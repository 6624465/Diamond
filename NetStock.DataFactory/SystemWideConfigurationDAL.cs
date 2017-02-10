using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace NetStock.DataFactory
{
    public class SystemWideConfigurationDAL  
    {
        private Database db;

        /// <summary>
        /// Constructor
        /// </summary>
        public SystemWideConfigurationDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<SystemWideConfiguration> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSYSTEMWIDECONFIGURATION, MapBuilder<SystemWideConfiguration>.BuildAllProperties()).ToList();
        }

        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var systemwideconfiguration = (SystemWideConfiguration)(object)item;

            var connection = db.CreateConnection();
            connection.Open();

            var transaction = connection.BeginTransaction();

            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVESYSTEMWIDECONFIGURATION);

                db.AddInParameter(savecommand, "DisplayName", System.Data.DbType.String, systemwideconfiguration.DisplayName);
                db.AddInParameter(savecommand, "ConfigurationValue", System.Data.DbType.String, systemwideconfiguration.ConfigurationValue);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, systemwideconfiguration.ModifiedBy);



                result = db.ExecuteNonQuery(savecommand, transaction);

                transaction.Commit();

            }
            catch (Exception)
            {
                transaction.Rollback();
                throw;
            }

            return (result > 0 ? true : false);

        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var systemwideconfiguration = (SystemWideConfiguration)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETESYSTEMWIDECONFIGURATION);


                db.AddInParameter(deleteCommand, "DisplayName", System.Data.DbType.String, systemwideconfiguration.DisplayName);



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
            var obj = ((SystemWideConfiguration)lookupItem);

            var Item = db.ExecuteSprocAccessor(DBRoutine.SELECTSYSTEMWIDECONFIGURATION,
                                                    MapBuilder<SystemWideConfiguration>.BuildAllProperties(),
                                                    obj.DisplayName).FirstOrDefault();
            return Item;
        }

        #endregion

    }
}

