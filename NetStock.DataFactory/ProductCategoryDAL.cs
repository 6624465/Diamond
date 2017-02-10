using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace NetStock.DataFactory
{
    public class ProductCategoryDAL  
    {
        private Database db;

        /// <summary>
        /// Constructor
        /// </summary>
        public ProductCategoryDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<ProductCategory> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTPRODUCTCATEGORY, MapBuilder<ProductCategory>.BuildAllProperties()).ToList();
        }

        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var productcategory = (ProductCategory)(object)item;

            var connection = db.CreateConnection();
            connection.Open();

            var transaction = connection.BeginTransaction();

            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEPRODUCTCATEGORY);

                db.AddInParameter(savecommand, "CategoryCode",System.Data.DbType.String,productcategory.CategoryCode);
                db.AddInParameter(savecommand, "Description",System.Data.DbType.String,productcategory.Description);
                db.AddInParameter(savecommand, "IsInternalStock",System.Data.DbType.Boolean,productcategory.IsInternalStock);
                db.AddInParameter(savecommand, "CreatedBy",System.Data.DbType.String,productcategory.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy",System.Data.DbType.String,productcategory.ModifiedBy);


                
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
            var productcategory = (ProductCategory)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEPRODUCTCATEGORY);

                db.AddInParameter(deleteCommand, "CategoryCode", System.Data.DbType.String, productcategory.CategoryCode);

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
            var item = (ProductCategory)lookupItem;

            var productcategory = db.ExecuteSprocAccessor(DBRoutine.SELECTPRODUCTCATEGORY,
                                                    MapBuilder<ProductCategory>.BuildAllProperties(),
                                                    item.CategoryCode).FirstOrDefault();
            return productcategory;
        }

        #endregion

    }
}

