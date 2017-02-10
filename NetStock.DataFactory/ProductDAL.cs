using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using NetStock.Contract;
using System.Data.Common;



namespace NetStock.DataFactory
{
    public class ProductDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public ProductDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<Product> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTPRODUCT, MapBuilder<Product>
                                                    .MapAllProperties()
                                                    .DoNotMap(p => p.Photo)
                                                    .Build()).ToList();
        }

        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var product = (Product)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEPRODUCT);

                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, product.ProductCode);
                db.AddInParameter(savecommand, "Description", System.Data.DbType.String, product.Description);
                db.AddInParameter(savecommand, "ProductCategory", System.Data.DbType.String, product.ProductCategory == null ? "" : product.ProductCategory);
                db.AddInParameter(savecommand, "BarCode", System.Data.DbType.String, product.BarCode == null ? "" : product.BarCode);
                db.AddInParameter(savecommand, "UOM", System.Data.DbType.String, product.UOM == null ? "" : product.UOM);
                db.AddInParameter(savecommand, "Size", System.Data.DbType.String, product.Size == null ? "" : product.Size);
                db.AddInParameter(savecommand, "Color", System.Data.DbType.String, product.Color == null ? "" : product.Color);
                db.AddInParameter(savecommand, "BuyingPrice", System.Data.DbType.Decimal, product.BuyingPrice == null ? 0 : product.BuyingPrice);
                db.AddInParameter(savecommand, "SellingPrice", System.Data.DbType.Decimal, product.SellingPrice == null ? 0 : product.SellingPrice);
                db.AddInParameter(savecommand, "ReOrderQty", System.Data.DbType.Double, product.ReOrderQty == null ? 0 : product.ReOrderQty);
                db.AddInParameter(savecommand, "Location", System.Data.DbType.String, product.Location == null ? "" : product.Location);
                db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, product.Status);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, product.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, product.ModifiedBy);
                db.AddOutParameter(savecommand, "NewProductCode", System.Data.DbType.String, 50);



                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {

                    // Get the New Product Code.
                    product.ProductCode = savecommand.Parameters["@NewProductCode"].Value.ToString();

                    product.Photo.Code = product.ProductCode;

                    if (product.Photo.ProductImg != null)
                    {
                        if (product.Photo.ProductImg.Length > 0)
                        {
                            result = Convert.ToInt32(new ProductImageDAL().Save(product.Photo, currentTransaction));
                        }
                    }


                }


                if (currentTransaction == null)
                    transaction.Commit();

            }
            catch (Exception)
            {
                if (currentTransaction == null)
                    transaction.Rollback();

                throw;
            }

            return (result > 0 ? true : false);

        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var product = (Product)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEPRODUCT);

                db.AddInParameter(deleteCommand, "ProductCode", System.Data.DbType.String, product.ProductCode);


                result = Convert.ToBoolean(db.ExecuteNonQuery(deleteCommand, transaction));

                transaction.Commit();

            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }

            return result;
        }

        public IContract GetItem<T>(IContract lookupItem) where T : IContract
        {
            var item = ((Product)lookupItem);

            var productItem = db.ExecuteSprocAccessor(DBRoutine.SELECTPRODUCT,
                                                    MapBuilder<Product>
                                                    .MapAllProperties()
                                                    .DoNotMap(p => p.Photo)
                                                    .Build(),
                                                    item.ProductCode).FirstOrDefault();


            //if (productItem!=null)
            //{
            //    productItem.Photo = new ProductImageDAL().GetItem(new ProductImage {Code = productItem.ProductCode });
            //}
            return productItem;
        }

        public IContract GetProductByBarCodeOrDescription<T>(IContract lookupItem) where T : IContract
        {
            var item = ((Product)lookupItem);

            var productItem = db.ExecuteSprocAccessor(DBRoutine.SELECTPRODUCTBYBARCODEORDESCRIPTION,
                                                    MapBuilder<Product>
                                                    .MapAllProperties()
                                                    .DoNotMap(p => p.Photo)
                                                    .Build(),
                                                    item.BarCode, item.Description).FirstOrDefault();


            return productItem;
        }

        public IContract CheckDuplicateProduct(string productDescription, string barCode)
        {


            var productItem = db.ExecuteSprocAccessor(DBRoutine.PRODUCTCHECKDUPLICATE,
                                                    MapBuilder<Product>
                                                    .MapAllProperties()
                                                    .DoNotMap(p => p.Photo)
                                                    .Build(),
                                                    productDescription, barCode).FirstOrDefault();


            return productItem;
        }

        public IContract GetSupplierProductByBarCodeOrDescription(string supplierCode, string barcode, string description)
        {


            var productItem = db.ExecuteSprocAccessor(DBRoutine.SELECTSUPPLIERPRODUCTBYBARCODEORDESCRIPTION,
                                                    MapBuilder<Product>
                                                    .MapAllProperties()
                                                    .DoNotMap(p => p.Photo)
                                                    .Build(),
                                                    supplierCode, barcode, description).FirstOrDefault();


            return productItem;
        }



        #endregion






    }
}

