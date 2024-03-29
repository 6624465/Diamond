﻿using System;
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
    public class OrderIssueDetailDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public OrderIssueDetailDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<OrderIssueDetail> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTORDERISSUEDETAIL, MapBuilder<OrderIssueDetail>
                                                                      .MapAllProperties()
                                                                      .DoNotMap(dt=> dt.Photo)
                                                                      .Build()).ToList();
        }

        public List<OrderIssueDetail> GetListByOrderNo(string orderNo)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTORDERISSUEDETAIL, MapBuilder<OrderIssueDetail>
                                                                        .MapAllProperties()
                                                                        .DoNotMap(dt => dt.Photo)
                                                                        .DoNotMap(dt => dt.ProductImageString)
                                                                        .Build(), orderNo).ToList();
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

            var orderissuedetail = (OrderIssueDetail)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEORDERISSUEDETAIL);

                db.AddInParameter(savecommand, "OrderNo", System.Data.DbType.String, orderissuedetail.OrderNo);
                db.AddInParameter(savecommand, "ItemNo", System.Data.DbType.Int16, orderissuedetail.ItemNo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, orderissuedetail.ProductCode);
                db.AddInParameter(savecommand, "BarCode", System.Data.DbType.String, orderissuedetail.BarCode == null ? "" : orderissuedetail.BarCode);
                db.AddInParameter(savecommand, "Quantity", System.Data.DbType.Double, orderissuedetail.Quantity);
                db.AddInParameter(savecommand, "IssueQuantity", System.Data.DbType.Double, orderissuedetail.IssueQuantity);
                db.AddInParameter(savecommand, "Cost", System.Data.DbType.Decimal, orderissuedetail.Cost);
                db.AddInParameter(savecommand, "SellRate", System.Data.DbType.Decimal, orderissuedetail.SellRate);
                db.AddInParameter(savecommand, "SellPrice", System.Data.DbType.Decimal, orderissuedetail.SellPrice);
                db.AddInParameter(savecommand, "MatchQuotation", System.Data.DbType.String, orderissuedetail.MatchQuotation == null ? "" : orderissuedetail.MatchQuotation);
                db.AddInParameter(savecommand, "DiscountType", System.Data.DbType.String, orderissuedetail.DiscountType == null ? "" : orderissuedetail.DiscountType);
                db.AddInParameter(savecommand, "DiscountAmount", System.Data.DbType.Decimal, orderissuedetail.DiscountAmount);
                db.AddInParameter(savecommand, "AdjustAmount", System.Data.DbType.Decimal, orderissuedetail.AdjustAmount);
                db.AddInParameter(savecommand, "PartialPayment", System.Data.DbType.Decimal, orderissuedetail.PartialPayment);
                db.AddInParameter(savecommand, "Location", System.Data.DbType.String, orderissuedetail.Location);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, orderissuedetail.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, orderissuedetail.ModifiedBy);

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








        public bool Delete(string orderNo, DbTransaction parentTransaction)
        {
            var orderdetailItem = new OrderDetail { OrderNo = orderNo };

            return Delete(orderdetailItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var orderdetail = (OrderIssueDetail)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEORDERISSUEDETAIL);

                db.AddInParameter(deleteCommand, "OrderNo", System.Data.DbType.String, orderdetail.OrderNo);


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
            var item = ((OrderIssueDetail)lookupItem);

            var orderdetailItem = db.ExecuteSprocAccessor(DBRoutine.SELECTORDERISSUEDETAIL,
                                                    MapBuilder<OrderIssueDetail>.MapAllProperties()
                                                                      .DoNotMap(dt => dt.Photo)
                                                                      .Build(),
                                                    item.OrderNo).FirstOrDefault();
            return orderdetailItem;
        }

        #endregion


        public OrderIssueDetail GetProductPrice(string customerCode, string barCode, short branchID)
        {
            var orderissuedetailItem = db.ExecuteSprocAccessor(DBRoutine.GETPRODUCTPRICE,
                                                    MapBuilder<OrderIssueDetail>.MapAllProperties()
                                                    .DoNotMap(dt => dt.Photo)
                                                    .DoNotMap(dt => dt.ProductImageString)
                                                    .DoNotMap(dt => dt.RecordStatus)
                                                    .Build(),
                                                    customerCode, barCode, branchID).FirstOrDefault();
            return orderissuedetailItem;
        
        
        }

        public List<OrderIssueDetail> GetOrderIssueDetailPendingList(string referenceNo)
        {


            var orderissudedetails = db.ExecuteSprocAccessor(DBRoutine.SELECTORDERISSUEDETAILPENDINGLIST,
                                                    MapBuilder<OrderIssueDetail>.MapAllProperties()
                                                    .DoNotMap(dt => dt.Photo)
                                                    .DoNotMap(dt => dt.ProductImageString)
                                                    .Build(),
                                                    referenceNo).ToList();
            return orderissudedetails;
        }
    }
}
