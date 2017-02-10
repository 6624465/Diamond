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
    public class InvoiceHeaderDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public InvoiceHeaderDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<InvoiceHeader> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTINVOICEHEADER,
                                                MapBuilder<InvoiceHeader>
                                                .MapAllProperties()
                                                .DoNotMap(dt => dt.InvoiceDetails)
                                                .Build()).ToList();
        }


        //public List<UnbilledDetail> GetUnbilledOrders(UnbilledHeader item)
        //{
        //    return db.ExecuteSprocAccessor(DBRoutine.LISTUNBILLEDORDERS,
        //                                        MapBuilder<UnbilledDetail>
        //                                        .MapAllProperties()
        //                                        .Build(),
        //                                        item.CustomerCode,
        //                                        item.DateFrom,
        //                                        item.DateTo,
        //                                        item.OverDue,
        //                                        item.PaymentDays
        //                                        ).ToList();


        //}

        public List<UnbilledDetail> GetUnbilledOrders(UnbilledHeader item)
        {
            return db.ExecuteSprocAccessor(DBRoutine.UNBILLEDORDERS,
                                                MapBuilder<UnbilledDetail>
                                                .MapAllProperties()
                                                .Build(),
                                                item.CustomerCode,
                                                item.DateFrom.ToString("yyyy-MM-dd"),
                                                item.DateTo.ToString("yyyy-MM-dd"),
                                                item.InvoiceType,
                                                item.OverDue 
                                                ).ToList();


        }


        public List<UnbilledDetail> GetUnApprovedInvoices(UnbilledHeader item)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTUNAPPROVEDINVOICES,
                                                MapBuilder<UnbilledDetail>
                                                .MapAllProperties()
                                                .Build(),
                                                item.CustomerCode,
                                                item.DateFrom.ToString("yyyy-MM-dd"),
                                                item.DateTo.ToString("yyyy-MM-dd")
                                                ).ToList();


        }

        public List<UnbilledDetail> InvoiceInquiry(UnbilledHeader item)
        {
            return db.ExecuteSprocAccessor(DBRoutine.INVOICEINQUIRY,
                                                MapBuilder<UnbilledDetail>
                                                .MapAllProperties()
                                                .Build(),
                                                item.CustomerCode,
                                                item.DateFrom,
                                                item.DateTo,
                                                item.InvoiceType
                                                ).ToList();


        }

        public bool ApproveInvoice(List<UnbilledDetail> lstInvoice, string userID)
        {
            var result = 0;
           
            foreach (var dt in lstInvoice)
            {
                if (currentTransaction == null)
                {
                    connection = db.CreateConnection();
                    connection.Open();
                }

                var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);

                try
                {
                    var savecommand = db.GetStoredProcCommand(DBRoutine.APPROVEINVOICE);

                    db.AddInParameter(savecommand, "InvoiceNo", System.Data.DbType.String, dt.InvoiceNo);
                    db.AddInParameter(savecommand, "ApprovedBy", System.Data.DbType.String, userID);


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
            }
            return (result > 0 ? true : false);



        }



        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var invoiceheader = (InvoiceHeader)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEINVOICEHEADER);

                db.AddInParameter(savecommand, "InvoiceNo", System.Data.DbType.String, invoiceheader.InvoiceNo);
                db.AddInParameter(savecommand, "InvoiceDate", System.Data.DbType.DateTime, invoiceheader.InvoiceDate);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, invoiceheader.BranchID);
                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, invoiceheader.CustomerCode);
                db.AddInParameter(savecommand, "InvoiceType", System.Data.DbType.String, invoiceheader.InvoiceType);
                db.AddInParameter(savecommand, "InvoiceAmount", System.Data.DbType.Decimal, invoiceheader.InvoiceAmount);
                db.AddInParameter(savecommand, "TaxAmount", System.Data.DbType.Decimal, invoiceheader.TaxAmount);
                db.AddInParameter(savecommand, "TotalAmount", System.Data.DbType.Decimal, invoiceheader.TotalAmount);
                db.AddInParameter(savecommand, "PendingPayment", System.Data.DbType.Boolean, invoiceheader.PendingPayment);
                db.AddInParameter(savecommand, "PaymentDate", System.Data.DbType.DateTime, invoiceheader.PaymentDate);
                db.AddInParameter(savecommand, "DueDate", System.Data.DbType.DateTime, invoiceheader.DueDate);
                db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, invoiceheader.Status);
                db.AddInParameter(savecommand, "IsApproved", System.Data.DbType.Boolean, invoiceheader.IsApproved);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, invoiceheader.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, invoiceheader.ModifiedBy);
                db.AddOutParameter(savecommand, "NewInvoiceNo", System.Data.DbType.String, 25);

                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    var invoicedetailDAL = new InvoiceDetailDAL();

                    // Get the New Quotation No.
                    invoiceheader.InvoiceNo = savecommand.Parameters["@NewInvoiceNo"].Value.ToString();
                    invoiceheader.InvoiceDetails.ForEach(dt => dt.InvoiceNo = invoiceheader.InvoiceNo);
                    result = Convert.ToInt16(invoicedetailDAL.Delete(invoiceheader.InvoiceNo, transaction));
                    result = invoicedetailDAL.SaveList(invoiceheader.InvoiceDetails, transaction) == true ? 1 : 0;
                }



                if (result > 0)
                    if (currentTransaction == null)
                        transaction.Commit();
                    else
                        if (currentTransaction == null)
                            transaction.Rollback();

            }
            catch (Exception)
            {
                if (currentTransaction == null)
                    transaction.Rollback();

                throw;
            }

            return (result > 0 ? true : false);

        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var invoiceheader = (InvoiceHeader)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEINVOICEHEADER);

                db.AddInParameter(deleteCommand, "InvoiceNo", System.Data.DbType.String, invoiceheader.InvoiceNo);

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
            var item = ((InvoiceHeader)lookupItem);

            var invoiceheaderItem = db.ExecuteSprocAccessor(DBRoutine.SELECTINVOICEHEADER,
                                                    MapBuilder<InvoiceHeader>
                                                    .MapAllProperties()
                                                    .DoNotMap(dt => dt.InvoiceDetails)
                                                    .Build(), item.InvoiceNo).FirstOrDefault();

            if (invoiceheaderItem != null)
            {

                invoiceheaderItem.InvoiceDetails = new NetStock.DataFactory.InvoiceDetailDAL().GetListByOrderNo(invoiceheaderItem.InvoiceNo);

            }


            return invoiceheaderItem;
        }

        #endregion


        public string GetInvoiceNoByOrderNo(string OrderNo) 
        {

            var invoiceNo = "";

            var searchcommand = db.GetStoredProcCommand(DBRoutine.GETINVOICENOBYORDERNO);
            db.AddInParameter(searchcommand, "OrderNo", System.Data.DbType.String, OrderNo);
            var reader= db.ExecuteReader(searchcommand);

            while (reader.Read())
            {
                invoiceNo = reader[0].ToString();
            }

            return invoiceNo;
        }



    }
}

