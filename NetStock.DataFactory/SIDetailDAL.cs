using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace NetStock.DataFactory
{
    public class SIDetailDAL  
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public SIDetailDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<SIDetail> GetList(string documentNo)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSIDETAIL, MapBuilder<SIDetail>.BuildAllProperties(),documentNo).ToList();
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

            var sidetail = (SIDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVESIDETAIL);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, sidetail.DocumentNo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, sidetail.ProductCode);
                db.AddInParameter(savecommand, "Quantity", System.Data.DbType.Double, sidetail.Quantity);
                db.AddInParameter(savecommand, "UOM", System.Data.DbType.String, sidetail.UOM);
                db.AddInParameter(savecommand, "UnitPrice", System.Data.DbType.Decimal, sidetail.UnitPrice);
                db.AddInParameter(savecommand, "CurrencyCode", System.Data.DbType.String, sidetail.CurrencyCode??"");
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, sidetail.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, sidetail.ModifiedBy);

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



        public bool Delete(string documentNo, string productCode, DbTransaction parentTransaction)
        {
            var SIDetailItem = new SIDetail { DocumentNo = documentNo, ProductCode = productCode };

            return Delete(SIDetailItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }


        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var sidetail = (SIDetail)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETESIDETAIL);




                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, sidetail.DocumentNo);
                db.AddInParameter(deleteCommand, "ProductCode", System.Data.DbType.String, sidetail.ProductCode);
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
            var item = ((SIDetail)lookupItem);

            var sidetailItem = db.ExecuteSprocAccessor(DBRoutine.SELECTSIDETAIL,
                                                    MapBuilder<SIDetail>.BuildAllProperties(),
                                                    item.DocumentNo).FirstOrDefault();
            return sidetailItem;
        }

        #endregion

    }
}

