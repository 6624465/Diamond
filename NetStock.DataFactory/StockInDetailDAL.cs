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
    public class StockInDetailDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public StockInDetailDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<StockInDetail> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSTOCKINDETAIL, MapBuilder<StockInDetail>.BuildAllProperties()).ToList();
        }

        public List<StockInDetail> GetListByDocumentNo(string documentNo)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSTOCKINDETAIL, MapBuilder<StockInDetail>.BuildAllProperties(), documentNo).ToList();
        }

        public bool SaveList<T>(List<T> items, DbTransaction parentTransaction) where T : IContract
        {
            var result = true;

            if (items.Count == 0)
                result = true;

            foreach (var item in items)
            {
                result = Save(item, parentTransaction);
                if (result == false) break;
            }


            return result;

        }


        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }


        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var stockindetail = (StockInDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVESTOCKINDETAIL);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, stockindetail.DocumentNo);
                db.AddInParameter(savecommand, "ItemNo", System.Data.DbType.Int16, stockindetail.ItemNo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, stockindetail.ProductCode);
                db.AddInParameter(savecommand, "BarCode", System.Data.DbType.String, stockindetail.BarCode==null? "":stockindetail.BarCode);
                db.AddInParameter(savecommand, "Quantity", System.Data.DbType.Double, stockindetail.Quantity);
                db.AddInParameter(savecommand, "BuyingPrice", System.Data.DbType.Decimal, stockindetail.BuyingPrice);
                db.AddInParameter(savecommand, "Location", System.Data.DbType.String, stockindetail.Location==null?"NONE":stockindetail.Location);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, stockindetail.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, stockindetail.ModifiedBy);


                result = db.ExecuteNonQuery(savecommand, transaction);

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

        public bool Delete(string documentNo, DbTransaction parentTransaction)
        {
            var stockdetailItem = new StockInDetail { DocumentNo = documentNo};

            return Delete(stockdetailItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }





        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var stockindetail = (StockInDetail)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETESTOCKINDETAIL);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, stockindetail.DocumentNo);

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
            var item = ((StockInDetail)lookupItem);

            var StockInDetailItem = db.ExecuteSprocAccessor(DBRoutine.SELECTSTOCKINDETAIL,
                                                    MapBuilder<StockInDetail>.BuildAllProperties(),
                                                    item.DocumentNo).FirstOrDefault();
            return StockInDetailItem;
        }

        #endregion


        public List<StockInDetail> GetPODetailsBySupplier( string PONo,string supplierCode)
        {


            var lstDetails = db.ExecuteSprocAccessor(DBRoutine.GETPOBYSUPPLIERCODE,
                                                    MapBuilder<StockInDetail>.BuildAllProperties(),
                                                    PONo, supplierCode).ToList();
            return lstDetails;
        }


        public List<StockInDetail> GetStockInByPendingQty(string productCode, double quantity)
        {
             

            var lstDetails = db.ExecuteSprocAccessor(DBRoutine.GETSTOCKINBYPENDINGQTY,
                                                    MapBuilder<StockInDetail>.BuildAllProperties(),
                                                    productCode, quantity).ToList();
            return lstDetails;
        }
        

    }
}

