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
    public class QuotationItemDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public QuotationItemDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<QuotationItem> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTQUOTATIONITEM, MapBuilder<QuotationItem>.BuildAllProperties()).ToList();
        }

        public List<QuotationItem> GetQuotationProductPrice(string productCode )
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTQUOTATIONPRODUCTPRICE, MapBuilder<QuotationItem>.BuildAllProperties(),productCode).ToList();
        }


        public List<QuotationItem> GetSupplierQuotationProductPrice(string supplierCode, string productCode )
        {
            return db.ExecuteSprocAccessor(DBRoutine.GETSUPPLIERPRODUCTPRICE, MapBuilder<QuotationItem>.BuildAllProperties(),supplierCode, productCode).ToList();
        }
        
        

        public List<QuotationItem> GetListByQuotationNo(string quotationNo )
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTQUOTATIONITEM, MapBuilder<QuotationItem>.BuildAllProperties(),quotationNo).ToList();
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

            var quotationitem = (QuotationItem)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEQUOTATIONITEM);

                db.AddInParameter(savecommand, "QuotationNo", System.Data.DbType.String, quotationitem.QuotationNo);
                db.AddInParameter(savecommand, "ItemID", System.Data.DbType.Int16, quotationitem.ItemID);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, quotationitem.ProductCode);
                db.AddInParameter(savecommand, "BarCode", System.Data.DbType.String, quotationitem.BarCode==null? "":quotationitem.BarCode);
                db.AddInParameter(savecommand, "SellRate", System.Data.DbType.Decimal, quotationitem.SellRate);
                db.AddInParameter(savecommand, "CurrencyCode", System.Data.DbType.String, quotationitem.CurrencyCode == null ? "" : quotationitem.CurrencyCode);
                
                db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, quotationitem.Status);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, quotationitem.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, quotationitem.ModifiedBy);




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


        public bool Delete(string quotationNo, DbTransaction parentTransaction)
        {
            var quotationdetailItem = new QuotationItem { QuotationNo = quotationNo };

            return Delete(quotationdetailItem, parentTransaction);
        }

        public bool DeleteItem(QuotationItem item, DbTransaction parentTransaction)
        {

            return Delete(item, parentTransaction);
        }


        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }



        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var quotationitem = (QuotationItem)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEQUOTATIONITEM);


                db.AddInParameter(deleteCommand, "QuotationNo", System.Data.DbType.String, quotationitem.QuotationNo);
                db.AddInParameter(deleteCommand, "ItemID", System.Data.DbType.Int16, quotationitem.ItemID);

                result = Convert.ToBoolean(db.ExecuteNonQuery(deleteCommand, transaction));

                if (currentTransaction == null)
                    transaction.Commit();

            }
            catch (Exception ex)
            {
                if (currentTransaction == null)
                    transaction.Rollback();
                
                throw ex;
            }

            return result;
        }

        public bool DeleteAll(string quotationNo)
        {
            var result = false;            

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEQUOTATIONITEMALL);


                db.AddInParameter(deleteCommand, "QuotationNo", System.Data.DbType.String, quotationNo);

                result = Convert.ToBoolean(db.ExecuteNonQuery(deleteCommand, transaction));

                if (currentTransaction == null)
                    transaction.Commit();

            }
            catch (Exception ex)
            {
                if (currentTransaction == null)
                    transaction.Rollback();

                throw ex;
            }

            return result;
        }

        public IContract GetItem<T>(IContract lookupItem) where T : IContract
        {
            var item = ((QuotationItem)lookupItem);

            var quotationitemItem = db.ExecuteSprocAccessor(DBRoutine.SELECTQUOTATIONITEM,
                                                    MapBuilder<QuotationItem>.BuildAllProperties(),
                                                    item.QuotationNo).FirstOrDefault();
            return quotationitemItem;
        }

        #endregion






    }
}

