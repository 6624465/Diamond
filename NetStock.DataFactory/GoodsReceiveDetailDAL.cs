using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace NetStock.DataFactory
{
    public class GoodsReceiveDetailDAL  
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public GoodsReceiveDetailDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<GoodsReceiveDetail> GetList(string documentNo,string poNo)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTGOODSRECEIVEDETAIL, MapBuilder<GoodsReceiveDetail>.BuildAllProperties(), documentNo,poNo).ToList();
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

            var goodsreceivedetail = (GoodsReceiveDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEGOODSRECEIVEDETAIL);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, goodsreceivedetail.DocumentNo);
                db.AddInParameter(savecommand, "PONo", System.Data.DbType.String, goodsreceivedetail.PONo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, goodsreceivedetail.ProductCode);
                db.AddInParameter(savecommand, "UOM", System.Data.DbType.String, goodsreceivedetail.UOM??"");
                db.AddInParameter(savecommand, "IsCovered", System.Data.DbType.Boolean, goodsreceivedetail.IsCovered);
                db.AddInParameter(savecommand, "CoverRemarks", System.Data.DbType.String, goodsreceivedetail.CoverRemarks??"");
                db.AddInParameter(savecommand, "IsSorted", System.Data.DbType.Boolean, goodsreceivedetail.IsSorted);
                db.AddInParameter(savecommand, "SortedRemarks", System.Data.DbType.String, goodsreceivedetail.SortedRemarks??"");
                db.AddInParameter(savecommand, "IsHumidity", System.Data.DbType.Boolean, goodsreceivedetail.IsHumidity);
                db.AddInParameter(savecommand, "IsSameAsPhoto", System.Data.DbType.Boolean, goodsreceivedetail.IsSameAsPhoto);
                db.AddInParameter(savecommand, "IsClean", System.Data.DbType.Boolean, goodsreceivedetail.IsClean);
                db.AddInParameter(savecommand, "IsCompressed", System.Data.DbType.Boolean, goodsreceivedetail.IsCompressed);
                db.AddInParameter(savecommand, "IsCorrectWeight", System.Data.DbType.Boolean, goodsreceivedetail.IsCorrectWeight);
                db.AddInParameter(savecommand, "Qty", System.Data.DbType.Decimal, goodsreceivedetail.Qty);
                db.AddInParameter(savecommand, "PalletQty", System.Data.DbType.Decimal, goodsreceivedetail.PalletQty);
                db.AddInParameter(savecommand, "PalletUOM", System.Data.DbType.String, goodsreceivedetail.PalletUOM??"");
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, goodsreceivedetail.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, goodsreceivedetail.ModifiedBy);
                


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


        public bool Delete(string documentNo, string poNo,string productCode, DbTransaction parentTransaction)
        {
            var GoodsReceiveDetailItem = new GoodsReceiveDetail { DocumentNo = documentNo, PONo = poNo,ProductCode = productCode };

            return Delete(GoodsReceiveDetailItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }


        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var goodsreceivedetail = (GoodsReceiveDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEGOODSRECEIVEDETAIL);

                db.AddInParameter(deleteCommand, "DocumentNo",System.Data.DbType.String,goodsreceivedetail.DocumentNo);
                db.AddInParameter(deleteCommand, "PONo", System.Data.DbType.String, goodsreceivedetail.PONo);
                db.AddInParameter(deleteCommand, "ProductCode", System.Data.DbType.String, goodsreceivedetail.ProductCode);
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
            var item = (GoodsReceiveDetail)lookupItem;

            var goodsreceivedetail = db.ExecuteSprocAccessor(DBRoutine.SELECTGOODSRECEIVEDETAIL,
                                                    MapBuilder<GoodsReceiveDetail>.BuildAllProperties(),
                                                    item.DocumentNo,item.PONo,item.ProductCode).FirstOrDefault();
            return goodsreceivedetail;
        }

        #endregion

    }
}

