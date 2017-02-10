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
    public class LookUpDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public LookUpDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<Lookup> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTLOOKUP, MapBuilder<Lookup>.BuildAllProperties()).ToList();
        }

        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var lookup = (Lookup)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVELOOKUP);

                db.AddInParameter(savecommand, "LookupCode", System.Data.DbType.String, lookup.LookupCode);
                db.AddInParameter(savecommand, "Description", System.Data.DbType.String, lookup.Description);
                db.AddInParameter(savecommand, "Description2", System.Data.DbType.String, lookup.Description2);
                db.AddInParameter(savecommand, "Category", System.Data.DbType.String, lookup.Category);
                db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, lookup.Status);


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
            var lookup = (Lookup)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETELOOKUP);

                db.AddInParameter(deleteCommand, "LookupCode", System.Data.DbType.String, lookup.LookupCode);

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

        public IContract GetItem<T>(IContract lkItem) where T : IContract
        {
            var item = ((Lookup)lkItem);

            var lookupItem = db.ExecuteSprocAccessor(DBRoutine.SELECTLOOKUP,
                                                    MapBuilder<Lookup>.BuildAllProperties(),
                                                    item.LookupCode).FirstOrDefault();
            return lookupItem;
        }

        #endregion

         
    }
}

