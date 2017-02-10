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
    public class OrderHeaderDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public OrderHeaderDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<OrderHeader> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTORDERHEADER,
                                            MapBuilder<OrderHeader>
                                            .MapAllProperties()
                                            .DoNotMap(dt => dt.OrderDetails)
                                            .DoNotMap(dt=> dt.UOM)
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

            var orderheader = (OrderHeader)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            var isNewRecord = false;

            if (orderheader.OrderNo == "" || orderheader.OrderNo == "NEW")
            {
                isNewRecord = true;
            }


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEORDERHEADER);

                db.AddInParameter(savecommand, "OrderNo", System.Data.DbType.String, orderheader.OrderNo);
                db.AddInParameter(savecommand, "OrderDate", System.Data.DbType.DateTime, orderheader.OrderDate);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, orderheader.BranchID);
                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, orderheader.CustomerCode);
                db.AddInParameter(savecommand, "CustomerName", System.Data.DbType.String, orderheader.CustomerName == null ? "" : orderheader.CustomerName);
                db.AddInParameter(savecommand, "RegNo", System.Data.DbType.String, orderheader.RegNo == null ? "" : orderheader.RegNo);
                db.AddInParameter(savecommand, "CustomerAddress", System.Data.DbType.String, orderheader.CustomerAddress == null ? "" : orderheader.CustomerAddress);
                db.AddInParameter(savecommand, "SaleType", System.Data.DbType.String, orderheader.SaleType ?? "CASH");
                db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, orderheader.Status);
                db.AddInParameter(savecommand, "IsApproved", System.Data.DbType.Boolean, orderheader.IsApproved);
                db.AddInParameter(savecommand, "IsPayLater", System.Data.DbType.Boolean, orderheader.IsPayLater);
                db.AddInParameter(savecommand, "PaymentDays", System.Data.DbType.Int16, orderheader.PaymentDays == null ? 0 : orderheader.PaymentDays);
                db.AddInParameter(savecommand, "TotalAmount", System.Data.DbType.Decimal, orderheader.TotalAmount == null ? 0 : orderheader.TotalAmount);
                db.AddInParameter(savecommand, "IsVAT", System.Data.DbType.Boolean, orderheader.IsVAT);
                db.AddInParameter(savecommand, "VATAmount", System.Data.DbType.Decimal, orderheader.VATAmount);
                db.AddInParameter(savecommand, "ISWHTax", System.Data.DbType.Boolean, orderheader.IsWHTax);
                db.AddInParameter(savecommand, "WHTaxPercent", System.Data.DbType.Decimal, orderheader.WHTaxPercent);
                db.AddInParameter(savecommand, "WithHoldingAmount", System.Data.DbType.Decimal, orderheader.WithHoldingAmount);
                db.AddInParameter(savecommand, "NetAmount", System.Data.DbType.Decimal, orderheader.NetAmount);
                db.AddInParameter(savecommand, "PaidAmount", System.Data.DbType.Decimal, orderheader.PaidAmount == null ? 0 : orderheader.PaidAmount);
                db.AddInParameter(savecommand, "PaymentType", System.Data.DbType.String, orderheader.PaymentType);
                db.AddInParameter(savecommand, "IsRequiredDelivery", System.Data.DbType.Boolean, orderheader.IsRequireDelivery);
                db.AddInParameter(savecommand, "DeliveryDate", System.Data.DbType.DateTime, orderheader.DeliveryDate);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, orderheader.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, orderheader.ModifiedBy);
                db.AddInParameter(savecommand, "Remarks", System.Data.DbType.String, orderheader.Remarks == null ? "" : orderheader.Remarks);
                db.AddOutParameter(savecommand, "NewOrderNo", System.Data.DbType.String, 25);


                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    var orderdetailDAL = new OrderDetailDAL();

                    // Get the New Quotation No.
                    orderheader.OrderNo = savecommand.Parameters["@NewOrderNo"].Value.ToString();


                    Int16 itr = 1;
                    orderheader.OrderDetails.ForEach(dt =>
                    {
                        dt.OrderNo = orderheader.OrderNo;
                        dt.CreatedBy = orderheader.CreatedBy;
                        dt.ModifiedBy = orderheader.ModifiedBy;
                        dt.Location = dt.Location == null ? "NONE" : dt.Location;
                        dt.ItemNo = itr++;
                    });

                    result = Convert.ToInt16(orderdetailDAL.Delete(orderheader.OrderNo, transaction));
                    result = orderdetailDAL.SaveList(orderheader.OrderDetails, transaction) == true ? 1 : 0;

                    if (result > 0)
                    {
                        var invoiceHeader = new NetStock.Contract.InvoiceHeader();
                        List<NetStock.Contract.InvoiceDetail> lstInvoiceItems = new List<InvoiceDetail>();

                        foreach (var dt in orderheader.OrderDetails)
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

                        invoiceHeader.InvoiceNo = "";
                        invoiceHeader.BranchID = orderheader.BranchID;
                        invoiceHeader.InvoiceType = orderheader.SaleType ?? "CASH";
                        invoiceHeader.ApprovedBy = "";
                        invoiceHeader.CreatedBy = orderheader.CreatedBy;
                        invoiceHeader.ModifiedBy = orderheader.ModifiedBy;
                        invoiceHeader.CustomerCode = orderheader.CustomerCode;
                        invoiceHeader.InvoiceAmount = orderheader.TotalAmount;
                        invoiceHeader.InvoiceDate = orderheader.OrderDate;
                        invoiceHeader.PaymentDate = orderheader.OrderDate;
                        invoiceHeader.PendingPayment = orderheader.IsPayLater;
                        invoiceHeader.Status = true;
                        invoiceHeader.TaxAmount = 0;
                        invoiceHeader.TotalAmount = orderheader.PaidAmount;
                        invoiceHeader.DueDate = orderheader.OrderDate.AddDays(orderheader.PaymentDays);

                        invoiceHeader.InvoiceDetails = lstInvoiceItems;


                        result = new NetStock.DataFactory.InvoiceHeaderDAL().Save(invoiceHeader, transaction) == true ? 1 : 0;



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
            var orderheader = (OrderHeader)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEORDERHEADER);

                db.AddInParameter(deleteCommand, "OrderNo", System.Data.DbType.String, orderheader.OrderNo);
                db.AddInParameter(deleteCommand, "ModifiedBy", System.Data.DbType.String, orderheader.ModifiedBy);


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
            var item = ((OrderHeader)lookupItem);

            var orderheaderItem = db.ExecuteSprocAccessor(DBRoutine.SELECTORDERHEADER,
                                                    MapBuilder<OrderHeader>
                                                    .MapAllProperties()
                                                    .DoNotMap(dt => dt.OrderDetails)
                                                    .DoNotMap(dt => dt.UOM)
                                                    .Build(),
                                                    item.OrderNo).FirstOrDefault();

            if (orderheaderItem != null)
            {

                orderheaderItem.OrderDetails = new NetStock.DataFactory.OrderDetailDAL().GetListByOrderNo(orderheaderItem.OrderNo);

            }


            return orderheaderItem;
        }

        #endregion






    }
}

