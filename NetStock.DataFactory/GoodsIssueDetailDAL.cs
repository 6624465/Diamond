using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace NetStock.DataFactory
{
    public class GoodsIssueDetailDAL  
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public GoodsIssueDetailDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<GoodsIssueDetail> GetList(string documentNo)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTGOODSISSUEDETAIL, MapBuilder<GoodsIssueDetail>.BuildAllProperties(),documentNo).ToList();
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

            var goodsissuedetail = (GoodsIssueDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);

            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEGOODSISSUEDETAIL);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, goodsissuedetail.DocumentNo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, goodsissuedetail.ProductCode);
                db.AddInParameter(savecommand, "Qty", System.Data.DbType.Double, goodsissuedetail.Qty);
                db.AddInParameter(savecommand, "LotNo", System.Data.DbType.String, goodsissuedetail.LotNo);
                db.AddInParameter(savecommand, "CurrentQty", System.Data.DbType.Double, goodsissuedetail.CurrentQty);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, goodsissuedetail.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, goodsissuedetail.ModifiedBy);



                result = db.ExecuteNonQuery(savecommand, transaction);

                if (currentTransaction == null)
                    transaction.Commit();

            }
            catch (Exception ex)
            {
                if (currentTransaction == null)
                    transaction.Rollback();
                throw;
            }

            return (result > 0 ? true : false);

        }

        public bool Delete(string documentNo, DbTransaction parentTransaction)
        {
            var goodsissuedetailItem = new GoodsIssueDetail { DocumentNo = documentNo};

            return Delete(goodsissuedetailItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }


        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var goodsissuedetail = (GoodsIssueDetail)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEGOODSISSUEDETAIL);


                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, goodsissuedetail.DocumentNo);

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

        public IContract GetItem(string documentNo )
        {


            var goodsissuedetailItem = db.ExecuteSprocAccessor(DBRoutine.SELECTGOODSISSUEDETAIL,
                                                    MapBuilder<GoodsIssueDetail>.BuildAllProperties(),
                                                    documentNo ).FirstOrDefault();
            return goodsissuedetailItem;
        }

        #endregion

    }
}

