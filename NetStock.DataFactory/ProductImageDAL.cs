using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetStock.DataFactory
{
    public class ProductImageDAL
    {

        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public ProductImageDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members


        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }


        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var productImage = (ProductImage)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEPRODUCTIMAGE);

                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, productImage.Code);
                db.AddInParameter(savecommand, "ProductImage", System.Data.DbType.Binary, productImage.ProductImg);
                db.AddInParameter(savecommand, "FileName", System.Data.DbType.String, productImage.FileName);


                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    if (currentTransaction == null)
                        transaction.Commit();
                }


            }
            catch (Exception ex)
            {
                if (currentTransaction == null)
                    transaction.Rollback();

                throw;
            }

            return (result > 0 ? true : false);

        }


        public IContract GetItem<T>(IContract lookupItem) where T : IContract
        {
            var item = ((ProductImage)lookupItem);

            var companyItem = db.ExecuteSprocAccessor(DBRoutine.SELECTPRODUCTIMAGE,
                                                    MapBuilder<ProductImage>
                                                    .MapAllProperties()
                                                    .Build(),
                                                    ((ProductImage)lookupItem).Code).FirstOrDefault();


            if (companyItem == null)
            {
                return null;
            }

            return companyItem;
        }

        #endregion


        public ProductImage GetProductImage(string productCode)
        {
            var productimage = db.ExecuteSprocAccessor(DBRoutine.SELECTPRODUCTIMAGE,
                                                    MapBuilder<ProductImage>
                                                    .BuildAllProperties(),
                                                    productCode).FirstOrDefault();

            byte[] photo;


            if (productimage != null)
            {



                var searchcommand = db.GetStoredProcCommand(DBRoutine.SELECTPRODUCTIMAGE);
                db.AddInParameter(searchcommand, "ProductCode", System.Data.DbType.String, productCode);

                var reader = (System.Data.IDataReader)db.ExecuteReader(searchcommand);

                System.Data.DataTable dt = new System.Data.DataTable();

                dt.Load(reader);

                photo = (byte[])dt.Rows[0]["ProductImg"];

                productimage.ProductImg = photo;
            }
            return productimage;

        }

    }
}
