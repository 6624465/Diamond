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
    public class CurrencyDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public CurrencyDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<Currency> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTCURRENCY, MapBuilder<Currency>.BuildAllProperties()).ToList();
        }

        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var currency = (Currency)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVECURRENCY);

                db.AddInParameter(savecommand, "CurrencyCode", System.Data.DbType.String, currency.CurrencyCode);
                db.AddInParameter(savecommand, "Description", System.Data.DbType.String, currency.Description);
                db.AddInParameter(savecommand, "Description1", System.Data.DbType.String, currency.Description1??"");





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
            var currency = (Currency)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETECURRENCY);

                db.AddInParameter(deleteCommand, "CurrencyCode", System.Data.DbType.String, currency.CurrencyCode);

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
            var item = ((Currency)lookupItem);

            var currencyItem = db.ExecuteSprocAccessor(DBRoutine.SELECTCURRENCY,
                                                    MapBuilder<Currency>.BuildAllProperties(),
                                                    item.CurrencyCode).FirstOrDefault();
            return currencyItem;
        }

        #endregion






    }
}

