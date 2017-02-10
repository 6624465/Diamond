using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace NetStock.DataFactory
{
    public class GoodsReceiveDetailsOverseasDAL  
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public GoodsReceiveDetailsOverseasDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<GoodsReceiveDetailsOverseas> GetList(string documentNo, string poNo)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTGOODSRECEIVEDETAILSOVERSEAS, MapBuilder<GoodsReceiveDetailsOverseas>.BuildAllProperties(), documentNo, poNo).ToList();
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

            var goodsreceivedetailsoverseas = (GoodsReceiveDetailsOverseas)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEGOODSRECEIVEDETAILSOVERSEAS);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, goodsreceivedetailsoverseas.DocumentNo);
                db.AddInParameter(savecommand, "PONo", System.Data.DbType.String, goodsreceivedetailsoverseas.PONo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, goodsreceivedetailsoverseas.ProductCode);
                db.AddInParameter(savecommand, "Quantity", System.Data.DbType.Double, goodsreceivedetailsoverseas.Quantity);
                db.AddInParameter(savecommand, "UOM", System.Data.DbType.String, goodsreceivedetailsoverseas.UOM??"");
                db.AddInParameter(savecommand, "ContainerNo", System.Data.DbType.String, goodsreceivedetailsoverseas.ContainerNo??"");
                db.AddInParameter(savecommand, "ContainerCondition", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.ContainerCondition);
                db.AddInParameter(savecommand, "DamageDetails", System.Data.DbType.String, goodsreceivedetailsoverseas.DamageDetails??"");
                db.AddInParameter(savecommand, "SealCondition", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.SealCondition);
                db.AddInParameter(savecommand, "SealNo", System.Data.DbType.String, goodsreceivedetailsoverseas.SealNo??"");
                db.AddInParameter(savecommand, "IsSort", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.IsSort);
                db.AddInParameter(savecommand, "SortRemarks", System.Data.DbType.String, goodsreceivedetailsoverseas.SortRemarks??"");
                db.AddInParameter(savecommand, "IsFCL", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.IsFCL);
                db.AddInParameter(savecommand, "IsHumidity", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.IsHumidity);
                db.AddInParameter(savecommand, "IsProperPackage", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.IsProperPackage);
                db.AddInParameter(savecommand, "IsClean", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.IsClean);
                db.AddInParameter(savecommand, "IsCompressed", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.IsCompressed);
                db.AddInParameter(savecommand, "IsCorrectWeight", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.IsCorrectWeight);
                db.AddInParameter(savecommand, "QtyPerUOM", System.Data.DbType.Double, goodsreceivedetailsoverseas.QtyPerUOM);
                db.AddInParameter(savecommand, "IsProductLabel", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.IsProductLabel);
                db.AddInParameter(savecommand, "IsInspectContainer", System.Data.DbType.Boolean, goodsreceivedetailsoverseas.IsInspectContainer);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, goodsreceivedetailsoverseas.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, goodsreceivedetailsoverseas.ModifiedBy);


                
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


        public bool Delete(string documentNo, string poNo, string productCode, DbTransaction parentTransaction)
        {
            var goodsreceivedetailsoverseasItem = new GoodsReceiveDetailsOverseas { DocumentNo = documentNo, PONo = poNo, ProductCode = productCode };

            return Delete(goodsreceivedetailsoverseasItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var goodsreceivedetailsoverseas = (GoodsReceiveDetailsOverseas)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEGOODSRECEIVEDETAILSOVERSEAS);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, goodsreceivedetailsoverseas.DocumentNo);
                db.AddInParameter(deleteCommand, "PONo", System.Data.DbType.String, goodsreceivedetailsoverseas.PONo);
                db.AddInParameter(deleteCommand, "ProductCode", System.Data.DbType.String, goodsreceivedetailsoverseas.ProductCode);


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

            var item = (GoodsReceiveDetailsOverseas)lookupItem;

            var goodsreceivedetailsoverseas = db.ExecuteSprocAccessor(DBRoutine.SELECTGOODSRECEIVEDETAILSOVERSEAS,
                                                    MapBuilder<GoodsReceiveDetailsOverseas>.BuildAllProperties(),
                                                    item.DocumentNo, item.PONo, item.ProductCode).FirstOrDefault();
            return goodsreceivedetailsoverseas;
        }

        #endregion

    }
}

