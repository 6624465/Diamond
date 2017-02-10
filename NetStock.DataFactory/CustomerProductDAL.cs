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
    public class CustomerProductDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public CustomerProductDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<CustomerProduct> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTCUSTOMERPRODUCT, MapBuilder<CustomerProduct>.BuildAllProperties()).ToList();
        }

        public List<CustomerProduct> GetCustomerProductsList(string customerCode)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTCUSTOMERPRODUCT, MapBuilder<CustomerProduct>.BuildAllProperties(),customerCode).ToList();
        }


        public bool SaveList<T>(List<T> items) where T : IContract
        {
            var result = true;

            if (items.Count == 0)
                result = true;

            foreach (var item in items)
            {
                result = Save(item, currentTransaction);
                if (result == false) break;
            }


            return result;

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

            var customerproduct = (CustomerProduct)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVECUSTOMERPRODUCT);

                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, customerproduct.CustomerCode);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, customerproduct.ProductCode);
                db.AddInParameter(savecommand, "MatchProductCode", System.Data.DbType.String, customerproduct.MatchProductCode);
                db.AddInParameter(savecommand, "BarCode", System.Data.DbType.String, customerproduct.BarCode);
                db.AddInParameter(savecommand, "CostPrice", System.Data.DbType.Decimal, customerproduct.CostPrice);


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
            var customerproduct = (CustomerProduct)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETECUSTOMERPRODUCT);

                db.AddInParameter(deleteCommand, "BarCode", System.Data.DbType.String, customerproduct.BarCode);
                db.AddInParameter(deleteCommand, "CustomerCode", System.Data.DbType.String, customerproduct.CustomerCode);
                db.AddInParameter(deleteCommand, "MatchProductCode", System.Data.DbType.String, customerproduct.MatchProductCode);
                db.AddInParameter(deleteCommand, "ProductCode", System.Data.DbType.String, customerproduct.ProductCode);




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

        public bool DeleteAllCustomerProducts(string customerCode)
        {
            var result = false;
            
            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEALLCUSTOMERPRODUCT);

                db.AddInParameter(deleteCommand, "CustomerCode", System.Data.DbType.String, customerCode);




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
            var item = ((CustomerProduct)lookupItem);

            var customerproductItem = db.ExecuteSprocAccessor(DBRoutine.SELECTCUSTOMERPRODUCT,
                                                    MapBuilder<CustomerProduct>.BuildAllProperties(),
                                                    item.CustomerCode,
                                                    item.ProductCode).FirstOrDefault();
            return customerproductItem;
        }

        #endregion






    }
}

