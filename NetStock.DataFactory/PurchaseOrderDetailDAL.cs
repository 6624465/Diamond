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
    public class PurchaseOrderDetailDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public PurchaseOrderDetailDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<PurchaseOrderDetail> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTPURCHASEORDERDETAIL, MapBuilder<PurchaseOrderDetail>.BuildAllProperties()).ToList();
        }


        public List<PurchaseOrderDetail> GetList(string poNO)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTPURCHASEORDERDETAIL, MapBuilder<PurchaseOrderDetail>.BuildAllProperties(),poNO).ToList();
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

            var purchaseorderdetail = (PurchaseOrderDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEPURCHASEORDERDETAIL);

                db.AddInParameter(savecommand, "PONo", System.Data.DbType.String, purchaseorderdetail.PONo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, purchaseorderdetail.ProductCode);
                db.AddInParameter(savecommand, "Quantity", System.Data.DbType.Decimal, purchaseorderdetail.Quantity);
                db.AddInParameter(savecommand, "UOM", System.Data.DbType.String, purchaseorderdetail.UOM??"");
                db.AddInParameter(savecommand, "UnitPrice", System.Data.DbType.Decimal, purchaseorderdetail.UnitPrice);
                db.AddInParameter(savecommand, "CurrencyCode", System.Data.DbType.String, purchaseorderdetail.CurrencyCode??"");
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, purchaseorderdetail.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, purchaseorderdetail.ModifiedBy);


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


        public bool Delete(string poNo, DbTransaction parentTransaction)
        {
            var purchaseorderdetailItem = new PurchaseOrderDetail { PONo= poNo };

            return Delete(purchaseorderdetailItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }


        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var purchaseorderdetail = (PurchaseOrderDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEPURCHASEORDERDETAIL);
                db.AddInParameter(deleteCommand, "PONo", System.Data.DbType.String, purchaseorderdetail.PONo);
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
            var item = ((PurchaseOrderDetail)lookupItem);

            var purchaseorderdetailItem = db.ExecuteSprocAccessor(DBRoutine.SELECTPURCHASEORDERDETAIL,
                                                    MapBuilder<PurchaseOrderDetail>.BuildAllProperties(),
                                                    item.PONo).FirstOrDefault();
            return purchaseorderdetailItem;
        }

       
        #endregion






    }
}

