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
    public class InvoiceDetailDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public InvoiceDetailDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<InvoiceDetail> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTINVOICEDETAIL, MapBuilder<InvoiceDetail>.BuildAllProperties()).ToList();
        }

        public List<InvoiceDetail> GetListByOrderNo(string invoiceNo)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTINVOICEDETAIL, MapBuilder<InvoiceDetail>.BuildAllProperties(), invoiceNo).ToList();
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

            var invoicedetail = (InvoiceDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEINVOICEDETAIL);

                db.AddInParameter(savecommand, "InvoiceNo", System.Data.DbType.String, invoicedetail.InvoiceNo);
                db.AddInParameter(savecommand, "OrderNo", System.Data.DbType.String, invoicedetail.OrderNo);
                db.AddInParameter(savecommand, "ItemNo", System.Data.DbType.Int16, invoicedetail.ItemNo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, invoicedetail.ProductCode);
                db.AddInParameter(savecommand, "BarCode", System.Data.DbType.String, invoicedetail.BarCode);
                db.AddInParameter(savecommand, "Quantity", System.Data.DbType.Double, invoicedetail.Quantity);
                db.AddInParameter(savecommand, "Price", System.Data.DbType.Decimal, invoicedetail.Price);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, invoicedetail.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, invoicedetail.ModifiedBy);




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


        public bool Delete(string invoiceNo, DbTransaction parentTransaction)
        {
            var invoicedetailItem = new InvoiceDetail { InvoiceNo = invoiceNo};

            return Delete(invoicedetailItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }



        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var invoicedetail = (InvoiceDetail)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEINVOICEDETAIL);

                db.AddInParameter(deleteCommand, "InvoiceNo", System.Data.DbType.String, invoicedetail.InvoiceNo);


                result = Convert.ToBoolean(db.ExecuteNonQuery(deleteCommand, transaction));

                if(currentTransaction==null)
                    transaction.Commit();

            }
            catch (Exception ex)
            {
                if(currentTransaction==null)
                    transaction.Rollback();
                    
                throw ex;
            }

            return result;
        }

        public IContract GetItem<T>(IContract lookupItem) where T : IContract
        {
            var item = ((InvoiceDetail)lookupItem);

            var invoicedetailItem = db.ExecuteSprocAccessor(DBRoutine.SELECTINVOICEDETAIL,
                                                    MapBuilder<InvoiceDetail>.BuildAllProperties(),
                                                    item.InvoiceNo).FirstOrDefault();
            return invoicedetailItem;
        }

        #endregion






    }
}

