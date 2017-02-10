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
    public class StockLedgerDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public StockLedgerDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<StockLedger> GetList(string productCode)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSTOCKLEDGER, MapBuilder<StockLedger>.BuildAllProperties(),productCode).ToList();
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

            var stockledger = (StockLedger)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVESTOCKLEDGER);

                db.AddInParameter(savecommand, "TransactionNo", System.Data.DbType.String, stockledger.TransactionNo);
                db.AddInParameter(savecommand, "TransactionType", System.Data.DbType.String, stockledger.TransactionType);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, stockledger.ProductCode);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, stockledger.BranchID);
                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, stockledger.CustomerCode);
                db.AddInParameter(savecommand, "Quantity", System.Data.DbType.Double, stockledger.Quantity);
                db.AddInParameter(savecommand, "StockFlag", System.Data.DbType.Int32, stockledger.StockFlag);
                db.AddInParameter(savecommand, "MatchDocumentNo", System.Data.DbType.String, stockledger.MatchDocumentNo);
                db.AddInParameter(savecommand, "Location", System.Data.DbType.String, stockledger.Location);
                db.AddInParameter(savecommand, "StockDate", System.Data.DbType.DateTime, stockledger.StockDate);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, stockledger.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, stockledger.ModifiedBy);



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

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var stockledger = (StockLedger)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETESTOCKLEDGER);

                db.AddInParameter(deleteCommand, "TransactionNo", System.Data.DbType.String, stockledger.TransactionNo);
                db.AddInParameter(deleteCommand, "TransactionType", System.Data.DbType.String, stockledger.TransactionType);
                db.AddInParameter(deleteCommand, "ProductCode", System.Data.DbType.String, stockledger.ProductCode);
                db.AddInParameter(deleteCommand, "BranchID", System.Data.DbType.Int16, stockledger.BranchID);
 


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
            var item = ((StockLedger)lookupItem);

            var stockledgerItem = db.ExecuteSprocAccessor(DBRoutine.SELECTSTOCKLEDGER,
                                                    MapBuilder<StockLedger>.BuildAllProperties(),
                                                    item.TransactionNo,item.TransactionType,item.ProductCode,item.BranchID).FirstOrDefault();
            return stockledgerItem;
        }

        #endregion


        public List<StockInquiryDetail> StockInquiry(string productCode, string productCategory, string productLocation,string supplierCode)
        {
             

            var lstStockInquiry = db.ExecuteSprocAccessor(DBRoutine.STOCKINQUIRY,
                                                    MapBuilder<StockInquiryDetail>.BuildAllProperties(),
                                                    productCode, productCategory, productLocation,supplierCode).ToList();
            return lstStockInquiry;
        }

        public Int32 GetProductCurrentStock(string productCode)
        { 
            var currentStock  = ((Int32)(db.ExecuteScalar(DBRoutine.GETPRODUCTCURRENTSTOCK, productCode)));
            return currentStock;
        }
        


    }
}

