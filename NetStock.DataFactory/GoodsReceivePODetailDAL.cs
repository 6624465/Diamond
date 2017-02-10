using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace NetStock.DataFactory
{
    public class GoodsReceivePODetailDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public GoodsReceivePODetailDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<GoodsReceivePODetail> GetList(string documentNo)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTGOODSRECEIVEPODETAIL, MapBuilder<GoodsReceivePODetail>.BuildAllProperties(), documentNo).ToList();
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

            var goodsreceivepodetail = (GoodsReceivePODetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEGOODSRECEIVEPODETAIL);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, goodsreceivepodetail.DocumentNo);
                db.AddInParameter(savecommand, "PONo", System.Data.DbType.String, goodsreceivepodetail.PONo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, goodsreceivepodetail.ProductCode);
                db.AddInParameter(savecommand, "Quantity", System.Data.DbType.Double, goodsreceivepodetail.Quantity);
                db.AddInParameter(savecommand, "ReceiveQuantity", System.Data.DbType.Double, goodsreceivepodetail.ReceiveQuantity);
                db.AddInParameter(savecommand, "UOM", System.Data.DbType.String, goodsreceivepodetail.UOM);
                db.AddInParameter(savecommand, "UnitPrice", System.Data.DbType.Decimal, goodsreceivepodetail.UnitPrice);
                db.AddInParameter(savecommand, "CurrencyCode", System.Data.DbType.String, goodsreceivepodetail.CurrencyCode ?? "");
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, goodsreceivepodetail.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, goodsreceivepodetail.ModifiedBy);



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


        public bool Delete(string documentNo, string productCode, DbTransaction parentTransaction)
        {
            var goodsreceivepodetailItem = new GoodsReceiveDetail { DocumentNo = documentNo, ProductCode = productCode };

            return Delete(goodsreceivepodetailItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var goodsreceivepodetail = (GoodsReceivePODetail)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEGOODSRECEIVEPODETAIL);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, goodsreceivepodetail.DocumentNo);
                db.AddInParameter(deleteCommand, "PONo", System.Data.DbType.String, goodsreceivepodetail.PONo);


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
            var item = ((GoodsReceivePODetail)lookupItem);

            var poItem = db.ExecuteSprocAccessor(DBRoutine.SELECTGOODSRECEIVEPODETAIL,
                                                    MapBuilder<GoodsReceivePODetail>.BuildAllProperties(),
                                                    item.DocumentNo, item.PONo).FirstOrDefault();
            return poItem;
        }


        public List<GoodsReceivePODetail> GetPurchaseOrderDetailPendingList(string PONo)
        {


            var purchaseorderdetailItem = db.ExecuteSprocAccessor(DBRoutine.SELECTGOODSRECEIVEDETAILPENDINGLIST,
                                                    MapBuilder<GoodsReceivePODetail>.BuildAllProperties(),
                                                    PONo).ToList();
            return purchaseorderdetailItem;
        }

        


        #endregion

    }
}

