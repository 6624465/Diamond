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
    public class OrderIssueHeaderDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public OrderIssueHeaderDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<OrderIssueHeader> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTORDERISSUEHEADER,
                                            MapBuilder<OrderIssueHeader>
                                            .MapAllProperties()
                                            .DoNotMap(dt => dt.OrderIssueDetails)
                                            .Build()).ToList();
        }

        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var orderissueheader = (OrderIssueHeader)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            var isNewRecord = false;

            if (orderissueheader.OrderNo == "" || orderissueheader.OrderNo == "NEW")
            {
                isNewRecord = true;
            }


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEORDERISSUEHEADER);

                db.AddInParameter(savecommand, "OrderNo", System.Data.DbType.String, orderissueheader.OrderNo);
                db.AddInParameter(savecommand, "OrderDate", System.Data.DbType.DateTime, orderissueheader.OrderDate);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, orderissueheader.BranchID);
                db.AddInParameter(savecommand, "ReferenceNo", System.Data.DbType.String, orderissueheader.ReferenceNo);
                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, orderissueheader.CustomerCode);
                db.AddInParameter(savecommand, "CustomerName", System.Data.DbType.String, orderissueheader.CustomerName == null ? "" : orderissueheader.CustomerName);
                db.AddInParameter(savecommand, "RegNo", System.Data.DbType.String, orderissueheader.RegNo == null ? "" : orderissueheader.RegNo);
                db.AddInParameter(savecommand, "CustomerAddress", System.Data.DbType.String, orderissueheader.CustomerAddress == null ? "" : orderissueheader.CustomerAddress);
                db.AddInParameter(savecommand, "SaleType", System.Data.DbType.String, orderissueheader.SaleType ?? "CASH");
                db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, orderissueheader.Status);
                db.AddInParameter(savecommand, "IsApproved", System.Data.DbType.Boolean, orderissueheader.IsApproved);
                db.AddInParameter(savecommand, "IsPayLater", System.Data.DbType.Boolean, orderissueheader.IsPayLater);
                db.AddInParameter(savecommand, "PaymentDays", System.Data.DbType.Int16, orderissueheader.PaymentDays == null ? 0 : orderissueheader.PaymentDays);
                db.AddInParameter(savecommand, "TotalAmount", System.Data.DbType.Decimal, orderissueheader.TotalAmount == null ? 0 : orderissueheader.TotalAmount);
                db.AddInParameter(savecommand, "IsVAT", System.Data.DbType.Boolean, orderissueheader.IsVAT);
                db.AddInParameter(savecommand, "VATAmount", System.Data.DbType.Decimal, orderissueheader.VATAmount);
                db.AddInParameter(savecommand, "ISWHTax", System.Data.DbType.Boolean, orderissueheader.IsWHTax);
                db.AddInParameter(savecommand, "WHTaxPercent", System.Data.DbType.Decimal, orderissueheader.WHTaxPercent);
                db.AddInParameter(savecommand, "WithHoldingAmount", System.Data.DbType.Decimal, orderissueheader.WithHoldingAmount);
                db.AddInParameter(savecommand, "NetAmount", System.Data.DbType.Decimal, orderissueheader.NetAmount);
                db.AddInParameter(savecommand, "PaidAmount", System.Data.DbType.Decimal, orderissueheader.PaidAmount == null ? 0 : orderissueheader.PaidAmount);
                db.AddInParameter(savecommand, "PaymentType", System.Data.DbType.String, orderissueheader.PaymentType);
                db.AddInParameter(savecommand, "IsRequiredDelivery", System.Data.DbType.Boolean, orderissueheader.IsRequireDelivery);
                db.AddInParameter(savecommand, "DeliveryDate", System.Data.DbType.DateTime, orderissueheader.DeliveryDate);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, orderissueheader.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, orderissueheader.ModifiedBy);
                db.AddInParameter(savecommand, "Remarks", System.Data.DbType.String, orderissueheader.Remarks == null ? "" : orderissueheader.Remarks);
                db.AddOutParameter(savecommand, "NewOrderNo", System.Data.DbType.String, 25);


                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    var orderdetailDAL = new OrderDetailDAL();

                    // Get the New Quotation No.
                    orderissueheader.OrderNo = savecommand.Parameters["@NewOrderNo"].Value.ToString();


                    Int16 itr = 1;
                    orderissueheader.OrderIssueDetails.ForEach(dt =>
                    {
                        dt.OrderNo = orderissueheader.OrderNo;
                        dt.CreatedBy = orderissueheader.CreatedBy;
                        dt.ModifiedBy = orderissueheader.ModifiedBy;
                        dt.Location = dt.Location == null ? "NONE" : dt.Location;
                        dt.ItemNo = itr++;
                    });

                    result = Convert.ToInt16(orderdetailDAL.Delete(orderissueheader.OrderNo, transaction));
                    result = orderdetailDAL.SaveList(orderissueheader.OrderIssueDetails, transaction) == true ? 1 : 0;

                    if (result > 0)
                    {
                        var invoiceHeader = new NetStock.Contract.InvoiceHeader();
                        List<NetStock.Contract.InvoiceDetail> lstInvoiceItems = new List<InvoiceDetail>();

                        foreach (var dt in orderissueheader.OrderIssueDetails)
                        {
                            lstInvoiceItems.Add(new InvoiceDetail
                            {
                                InvoiceNo = "",
                                OrderNo = dt.OrderNo,
                                ItemNo = dt.ItemNo,
                                ProductCode = dt.ProductCode,
                                BarCode = dt.BarCode == null ? "" : dt.BarCode,
                                Quantity = dt.Quantity,
                                Price = dt.SellPrice,
                                CreatedBy = dt.CreatedBy,
                                ModifiedBy = dt.ModifiedBy

                            });
                        }

                        //invoiceHeader.InvoiceNo = "";
                        //invoiceHeader.BranchID = orderheader.BranchID;
                        //invoiceHeader.InvoiceType = orderheader.SaleType ?? "CASH";
                        //invoiceHeader.ApprovedBy = "";
                        //invoiceHeader.CreatedBy = orderheader.CreatedBy;
                        //invoiceHeader.ModifiedBy = orderheader.ModifiedBy;
                        //invoiceHeader.CustomerCode = orderheader.CustomerCode;
                        //invoiceHeader.InvoiceAmount = orderheader.TotalAmount;
                        //invoiceHeader.InvoiceDate = orderheader.OrderDate;
                        //invoiceHeader.PaymentDate = orderheader.OrderDate;
                        //invoiceHeader.PendingPayment = orderheader.IsPayLater;
                        //invoiceHeader.Status = true;
                        //invoiceHeader.TaxAmount = 0;
                        //invoiceHeader.TotalAmount = orderheader.PaidAmount;
                        //invoiceHeader.DueDate = orderheader.OrderDate.AddDays(orderheader.PaymentDays);

                        //invoiceHeader.InvoiceDetails = lstInvoiceItems;


                        //result = new NetStock.DataFactory.InvoiceHeaderDAL().Save(invoiceHeader, transaction) == true ? 1 : 0;



                    }

                    /*
                    if (isNewRecord)
                    {

                        if (result > 0)
                        {
                            var lstStockLedger = new List<StockLedger>();

                            foreach (var dt in orderheader.OrderDetails)
                            {
                                lstStockLedger.Add(new StockLedger
                                {
                                    CustomerCode = orderheader.CustomerCode,
                                    CreatedBy = orderheader.CreatedBy,
                                    ModifiedBy = orderheader.ModifiedBy,
                                    ProductCode = dt.ProductCode,
                                    BranchID = orderheader.BranchID,
                                    Quantity = dt.Quantity,
                                    StockFlag = -1,
                                    TransactionNo = "",
                                    MatchDocumentNo = orderheader.OrderNo,
                                    TransactionType = "OUT",
                                    Location = dt.Location,
                                    StockDate = orderheader.DeliveryDate,

                                });
                            }

                            result = new StockLedgerDAL().SaveList(lstStockLedger, transaction) == true ? 1 : 0;

                        }

                    }
                     * */


                }



                if (result > 0)
                    transaction.Commit();
                else
                    transaction.Rollback();

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
            var orderissueheader = (OrderIssueHeader)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEORDERISSUEHEADER);

                db.AddInParameter(deleteCommand, "OrderNo", System.Data.DbType.String, orderissueheader.OrderNo);
                db.AddInParameter(deleteCommand, "ModifiedBy", System.Data.DbType.String, orderissueheader.ModifiedBy);


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
            var item = ((OrderIssueHeader)lookupItem);

            var orderissueheaderItem = db.ExecuteSprocAccessor(DBRoutine.SELECTORDERISSUEHEADER,
                                                    MapBuilder<OrderIssueHeader>
                                                    .MapAllProperties()
                                                    .DoNotMap(dt => dt.OrderIssueDetails)
                                                    .Build(),
                                                    item.OrderNo).FirstOrDefault();

            if (orderissueheaderItem != null)
            {

                orderissueheaderItem.OrderIssueDetails = new NetStock.DataFactory.OrderIssueDetailDAL().GetListByOrderNo(orderissueheaderItem.OrderNo);

            }


            return orderissueheaderItem;
        }

        #endregion

        public OrderIssueHeader SearchOrderIssueByRefNo(string referenceNo)
        {


            var goodsreceiveheader = db.ExecuteSprocAccessor(DBRoutine.SEARCHORDERISSUEBYREFNO,
                                                    MapBuilder<OrderIssueHeader>
                                                    .MapAllProperties()
                                                    .DoNotMap(h => h.OrderIssueDetails)
                                                    .Build(),
                                                    referenceNo).FirstOrDefault();



            return goodsreceiveheader;
        }


    }
}
