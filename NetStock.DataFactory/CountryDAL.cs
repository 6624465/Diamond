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
    public class CountryDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public CountryDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<Country> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTCOUNTRY, MapBuilder<Country>.BuildAllProperties()).ToList();
        }

        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var country = (Country)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVECOUNTRY);

                db.AddInParameter(savecommand, "CountryCode", System.Data.DbType.String, country.CountryCode);
                db.AddInParameter(savecommand, "CountryName", System.Data.DbType.String, country.CountryName);
                db.AddInParameter(savecommand, "Description", System.Data.DbType.String, country.Description);





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
            var country = (Country)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETECOUNTRY);

                db.AddInParameter(deleteCommand, "CountryCode", System.Data.DbType.String, country.CountryCode);

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
            var item = ((Country)lookupItem);

            var countryItem = db.ExecuteSprocAccessor(DBRoutine.SELECTCOUNTRY,
                                                    MapBuilder<Country>.BuildAllProperties(),
                                                    item.CountryCode).FirstOrDefault();
            return countryItem;
        }

        #endregion






    }
}

