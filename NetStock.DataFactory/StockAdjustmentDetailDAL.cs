
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
    public class StockAdjustmentDetailDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public StockAdjustmentDetailDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<StockAdjustmentDetail> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSTOCKADJUSTMENTDETAIL, MapBuilder<StockAdjustmentDetail>.BuildAllProperties()).ToList();
        }

        public List<StockAdjustmentDetail> GetListByDocumentNo(string documentNo)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSTOCKADJUSTMENTDETAIL, MapBuilder<StockAdjustmentDetail>.BuildAllProperties(), documentNo).ToList();
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

            var stockadjustmentdetail = (StockAdjustmentDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVESTOCKADJUSTMENTDETAIL);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, stockadjustmentdetail.DocumentNo);
                db.AddInParameter(savecommand, "ItemNo", System.Data.DbType.Int16, stockadjustmentdetail.ItemNo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, stockadjustmentdetail.ProductCode);
                db.AddInParameter(savecommand, "BarCode", System.Data.DbType.String, stockadjustmentdetail.BarCode);
                db.AddInParameter(savecommand, "Quantity", System.Data.DbType.Double, stockadjustmentdetail.Quantity);
                db.AddInParameter(savecommand, "StockType", System.Data.DbType.String, stockadjustmentdetail.StockType);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, stockadjustmentdetail.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, stockadjustmentdetail.ModifiedBy);


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
            var StockadjustmentDetailItem = new StockAdjustmentDetail { DocumentNo = documentNo };

            return Delete(StockadjustmentDetailItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }





        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var StockadjustmentDetailItem = (StockAdjustmentDetail)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETESTOCKADJUSTMENTDETAIL);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, StockadjustmentDetailItem.DocumentNo);

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
            var item = ((StockAdjustmentDetail)lookupItem);

            var StockadjustmentDetailItem = db.ExecuteSprocAccessor(DBRoutine.SELECTSTOCKADJUSTMENTDETAIL,
                                                    MapBuilder<StockAdjustmentDetail>.BuildAllProperties(),
                                                    item.DocumentNo).FirstOrDefault();
            return StockadjustmentDetailItem;
        }

        #endregion


       
        

    }
}

