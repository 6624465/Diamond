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
    public class PurchaseOrderHeaderDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public PurchaseOrderHeaderDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<PurchaseOrderHeader> GetList(short branchID)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTPURCHASEORDERHEADER,
                                            MapBuilder<PurchaseOrderHeader>
                                            .MapAllProperties()
                                            .DoNotMap(dt => dt.PurchaseOrderDetails)
                                            .Build(),branchID
                                            ).ToList();
        }

        public List<PurchaseOrderHeader> GetPurchaseOrderBySupplier(string supplierCode)
        {
            return db.ExecuteSprocAccessor(DBRoutine.PURCHASEORDERBYSUPPLIER,
                                            MapBuilder<PurchaseOrderHeader>
                                            .MapAllProperties()
                                            .DoNotMap(dt => dt.PurchaseOrderDetails)
                                            .Build(),supplierCode
                                            ).ToList();
        }


        


        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var purchaseorderheader = (PurchaseOrderHeader)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {



                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEPURCHASEORDERHEADER);

                db.AddInParameter(savecommand, "PONo", System.Data.DbType.String, purchaseorderheader.PONo);
                db.AddInParameter(savecommand, "PODate", System.Data.DbType.DateTime, purchaseorderheader.PODate);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, purchaseorderheader.BranchID);
                db.AddInParameter(savecommand, "SupplierCode", System.Data.DbType.String, purchaseorderheader.SupplierCode??"");
                db.AddInParameter(savecommand, "ShipmentDate", System.Data.DbType.DateTime, purchaseorderheader.ShipmentDate);
                db.AddInParameter(savecommand, "ReceiveDate", System.Data.DbType.DateTime, purchaseorderheader.ReceiveDate);
                db.AddInParameter(savecommand, "EstimateDate", System.Data.DbType.DateTime, purchaseorderheader.EstimateDate);
                db.AddInParameter(savecommand, "ReferenceNo", System.Data.DbType.String, purchaseorderheader.ReferenceNo??"");
                db.AddInParameter(savecommand, "Buyer", System.Data.DbType.String, purchaseorderheader.Buyer??"");
                db.AddInParameter(savecommand, "PRNo", System.Data.DbType.String, purchaseorderheader.PRNo??"");
                db.AddInParameter(savecommand, "IncoTerms", System.Data.DbType.String, purchaseorderheader.IncoTerms??"");
                db.AddInParameter(savecommand, "PaymentTerm", System.Data.DbType.String, purchaseorderheader.PaymentTerm ?? "");
                
                db.AddInParameter(savecommand, "TotalAmount", System.Data.DbType.Decimal, purchaseorderheader.TotalAmount);
                db.AddInParameter(savecommand, "OtherCharges", System.Data.DbType.Decimal, purchaseorderheader.OtherCharges);
                db.AddInParameter(savecommand, "IsVAT", System.Data.DbType.Boolean, purchaseorderheader.IsVAT);
                db.AddInParameter(savecommand, "VATAmount", System.Data.DbType.Decimal, purchaseorderheader.VATAmount);
                db.AddInParameter(savecommand, "NetAmount", System.Data.DbType.Decimal, purchaseorderheader.NetAmount);
                
                db.AddInParameter(savecommand, "Remarks", System.Data.DbType.String, purchaseorderheader.Remarks??"");
                db.AddInParameter(savecommand, "ContactPerson", System.Data.DbType.String, purchaseorderheader.ContactPerson ?? "");
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, purchaseorderheader.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, purchaseorderheader.ModifiedBy);
                db.AddOutParameter(savecommand, "NewPONo", System.Data.DbType.String, 25);


                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    var podetailDAL = new PurchaseOrderDetailDAL();

                    // Get the New Quotation No.
                    purchaseorderheader.PONo = savecommand.Parameters["@NewPONo"].Value.ToString();

                    Int16 itr = 1;

                    purchaseorderheader.PurchaseOrderDetails.ForEach(dt =>
                    {
                        dt.PONo = purchaseorderheader.PONo;
                        dt.CreatedBy = purchaseorderheader.CreatedBy;
                        dt.ModifiedBy = purchaseorderheader.ModifiedBy;
                         
                    }

                        );

                    //result = Convert.ToInt16(podetailDAL.Delete(purchaseorderheader.PONo, transaction));
                    result = podetailDAL.SaveList(purchaseorderheader.PurchaseOrderDetails, transaction) == true ? 1 : 0;
                }

                transaction.Commit();

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
            var purchaseorderheader = (PurchaseOrderHeader)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEPURCHASEORDERHEADER);

                db.AddInParameter(deleteCommand, "PONo", System.Data.DbType.String, purchaseorderheader.PONo);
                db.AddInParameter(deleteCommand, "BranchID", System.Data.DbType.Int16, purchaseorderheader.BranchID);
                db.AddInParameter(deleteCommand, "ModifiedBy", System.Data.DbType.String, purchaseorderheader.ModifiedBy);


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
            var item = ((PurchaseOrderHeader)lookupItem);

            var purchaseorderheaderItem = db.ExecuteSprocAccessor(DBRoutine.SELECTPURCHASEORDERHEADER,
                                                    MapBuilder<PurchaseOrderHeader>
                                                    .MapAllProperties()
                                                    .DoNotMap(dt => dt.PurchaseOrderDetails)
                                                    .Build(),
                                                    item.PONo,item.BranchID).FirstOrDefault();

            if (purchaseorderheaderItem !=null)
            {
                purchaseorderheaderItem.PurchaseOrderDetails = new PurchaseOrderDetailDAL().GetList(purchaseorderheaderItem.PONo);
            }
            
            return purchaseorderheaderItem;
        }

        #endregion






    }
}

