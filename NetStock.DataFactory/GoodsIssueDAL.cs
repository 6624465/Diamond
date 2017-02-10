using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;

namespace NetStock.DataFactory
{
    public class GoodsIssueDAL  
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public GoodsIssueDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<GoodsIssue> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTGOODSISSUE, MapBuilder<GoodsIssue>.MapAllProperties().DoNotMap(x=> x.GoodsIssueDetails).Build()).ToList();
        }

        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }

        public List<Int32> GetDashboardData()
        {

            List<Int32> idata = new List<int>();

            var searchcommand = db.GetStoredProcCommand(DBRoutine.GOODSISSUEDASHBOARDATA);

            SqlDataReader reader = ((RefCountingDataReader)db.ExecuteReader(searchcommand)).InnerReader as SqlDataReader;

            while (reader.Read())
            {
                idata.Add(Convert.ToInt32(reader[0]));
            }


            return idata;
        }


        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var goodsissue = (GoodsIssue)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }
            var isNewRecord = false;

            if (goodsissue.DocumentNo == "" || goodsissue.DocumentNo == "NEW")
            {
                isNewRecord = true;
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);

             

            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEGOODSISSUE);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, goodsissue.DocumentNo);
                db.AddInParameter(savecommand, "DocumentDate", System.Data.DbType.DateTime, goodsissue.DocumentDate);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, goodsissue.BranchID);
                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, goodsissue.CustomerCode);
                db.AddInParameter(savecommand, "SupplierCode", System.Data.DbType.String, goodsissue.SupplierCode);
                db.AddInParameter(savecommand, "Remarks", System.Data.DbType.String, goodsissue.Remarks);
                db.AddInParameter(savecommand, "ReferenceNo", System.Data.DbType.String, goodsissue.ReferenceNo);
                //db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, goodsissue.Status);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, goodsissue.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, goodsissue.ModifiedBy);
                db.AddOutParameter(savecommand, "NewDocumentNo", System.Data.DbType.String, 50);


                 

                result = db.ExecuteNonQuery(savecommand, transaction);


                if (result > 0)
                {
                    var goodsissuedetailDAL = new GoodsIssueDetailDAL();

                    // Get the New Quotation No.
                    goodsissue.DocumentNo = savecommand.Parameters["@NewDocumentNo"].Value.ToString();


                    Int16 itr = 1;
                    goodsissue.GoodsIssueDetails.ForEach(dt =>
                    {
                        dt.DocumentNo = goodsissue.DocumentNo;
                        dt.CreatedBy = goodsissue.CreatedBy;
                        dt.ModifiedBy = goodsissue.ModifiedBy;
                         
                    });

                    result = Convert.ToInt16(goodsissuedetailDAL.Delete(goodsissue.DocumentNo, transaction));
                    result = goodsissuedetailDAL.SaveList(goodsissue.GoodsIssueDetails, transaction) == true ? 1 : 0;

                     


                    if (isNewRecord)
                    {

                        if (result > 0)
                        {
                            var lstStockLedger = new List<StockLedger>();

                            foreach (var dt in goodsissue.GoodsIssueDetails)
                            {
                                lstStockLedger.Add(new StockLedger
                                {
                                    CustomerCode = goodsissue.CustomerCode,
                                    CreatedBy = goodsissue.CreatedBy,
                                    ModifiedBy = goodsissue.ModifiedBy,
                                    ProductCode = dt.ProductCode,
                                    BranchID = goodsissue.BranchID,
                                    Quantity = dt.Qty,
                                    StockFlag = -1,
                                    TransactionNo = "",
                                    MatchDocumentNo = goodsissue.DocumentNo,
                                    TransactionType = "OUT",
                                    Location = "",
                                    StockDate = goodsissue.DocumentDate,

                                });
                            }

                            result = new StockLedgerDAL().SaveList(lstStockLedger, transaction) == true ? 1 : 0;

                        }

                    }


                }

                if (result > 0)
                    transaction.Commit();
                else
                    transaction.Rollback();


            }
            catch (Exception)
            {
                if (result > 0)
                    transaction.Rollback();
                throw;
            }

            return (result > 0 ? true : false);

        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var goodsissue = (GoodsIssue)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEGOODSISSUE);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, goodsissue.DocumentNo);

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
            var obj = ((GoodsIssue)lookupItem);

            var goodsissueItem = db.ExecuteSprocAccessor(DBRoutine.SELECTGOODSISSUE,
                                                    MapBuilder<GoodsIssue>.MapAllProperties().DoNotMap(x=> x.GoodsIssueDetails).Build(),
                                                    obj.DocumentNo).FirstOrDefault();

            if (goodsissueItem != null)
            {

                goodsissueItem.GoodsIssueDetails = new NetStock.DataFactory.GoodsIssueDetailDAL().GetList(goodsissueItem.DocumentNo);

            }
            return goodsissueItem;
        }

        #endregion

    }
}

