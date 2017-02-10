using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;

namespace NetStock.DataFactory
{
    public class GoodsReceiveHeaderDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public GoodsReceiveHeaderDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<GoodsReceiveHeader> GetList(short branchID)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTGOODSRECEIVEHEADER, MapBuilder<GoodsReceiveHeader>.MapAllProperties()
                                                    .DoNotMap(h => h.GoodsReceiveDetails)
                                                    .Build(), branchID).ToList();
        }

        public List<Int32> GetDashboardData()
        {

            List<Int32> idata = new List<int>();

            var searchcommand = db.GetStoredProcCommand(DBRoutine.GOODSRECEIVEDASHBOARDATA);

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

            var goodsreceiveheader = (GoodsReceiveHeader)(object)item;

            var connection = db.CreateConnection();
            connection.Open();

            var transaction = connection.BeginTransaction();

            var isNewRecord = false;

            if (goodsreceiveheader.DocumentNo==null ||  goodsreceiveheader.DocumentNo == "" || goodsreceiveheader.DocumentNo == "NEW")
            {
                isNewRecord = true;
            }

            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEGOODSRECEIVEHEADER);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, goodsreceiveheader.DocumentNo);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, goodsreceiveheader.BranchID);
                db.AddInParameter(savecommand, "DocumentDate", System.Data.DbType.DateTime, goodsreceiveheader.DocumentDate);
                db.AddInParameter(savecommand, "DocumentType", System.Data.DbType.String, goodsreceiveheader.DocumentType);
                db.AddInParameter(savecommand, "SupplierCode", System.Data.DbType.String, goodsreceiveheader.SupplierCode);
                db.AddInParameter(savecommand, "PONo", System.Data.DbType.String, goodsreceiveheader.PONo ?? "");
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, goodsreceiveheader.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, goodsreceiveheader.ModifiedBy);
                db.AddOutParameter(savecommand, "NewDocumentNo", System.Data.DbType.String, 50);



                result = db.ExecuteNonQuery(savecommand, transaction);
                if (result > 0)
                { 
                    var goodsreceivepodetailDAL = new GoodsReceivePODetailDAL();


                    // Get the New Quotation No.
                    goodsreceiveheader.DocumentNo = savecommand.Parameters["@NewDocumentNo"].Value.ToString();

                    // Update the GoodsReceive PO Details

                    if (goodsreceiveheader.GoodsReceivePODetailList != null)
                    {
                        goodsreceiveheader.GoodsReceivePODetailList.ForEach(dt =>
                        {
                            dt.DocumentNo = goodsreceiveheader.DocumentNo;
                            dt.CreatedBy = goodsreceiveheader.CreatedBy;
                            dt.ModifiedBy = goodsreceiveheader.ModifiedBy;
                        });

                        result = goodsreceivepodetailDAL.SaveList(goodsreceiveheader.GoodsReceivePODetailList, transaction) == true ? 1 : 0;

                    }


                    if (isNewRecord)
                    {
                        if (result > 0)
                        {
                            var lstStockLedger = new List<StockLedger>();

                            foreach (var dt in goodsreceiveheader.GoodsReceivePODetailList)
                            {
                                lstStockLedger.Add(new StockLedger
                                {
                                    CustomerCode = goodsreceiveheader.SupplierCode,
                                    CreatedBy = goodsreceiveheader.CreatedBy,
                                    ModifiedBy = goodsreceiveheader.ModifiedBy,
                                    ProductCode = dt.ProductCode,
                                    Quantity = dt.ReceiveQuantity,
                                    StockFlag = 1,
                                    MatchDocumentNo = goodsreceiveheader.DocumentNo,
                                    TransactionNo = "",
                                    TransactionType = "IN",
                                    Location = "",
                                    BranchID = goodsreceiveheader.BranchID,
                                    StockDate = goodsreceiveheader.DocumentDate

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
                transaction.Rollback();
                throw;
            }

            return (result > 0 ? true : false);

        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var goodsreceiveheader = (GoodsReceiveHeader)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEGOODSRECEIVEHEADER);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, goodsreceiveheader.DocumentNo);
                db.AddInParameter(deleteCommand, "BranchID", System.Data.DbType.Int16, goodsreceiveheader.BranchID);

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
            var item = (GoodsReceiveHeader)lookupItem;

            var goodsreceiveheader = db.ExecuteSprocAccessor(DBRoutine.SELECTGOODSRECEIVEHEADER,
                                                    MapBuilder<GoodsReceiveHeader>
                                                    .MapAllProperties()
                                                    .DoNotMap(h => h.GoodsReceiveDetails)
                                                    .Build(),
                                                    item.DocumentNo, item.BranchID).FirstOrDefault();


            if (goodsreceiveheader != null)
            {

                goodsreceiveheader.GoodsReceivePODetailList = new NetStock.DataFactory.GoodsReceivePODetailDAL().GetList(item.DocumentNo);

            }
            return goodsreceiveheader;
        }
        
        public GoodsReceiveHeader SearchGoodsReceiveByPO(string poNo)
        {
            

            var goodsreceiveheader = db.ExecuteSprocAccessor(DBRoutine.SEARCHGOODSRECEIVEBYPO,
                                                    MapBuilder<GoodsReceiveHeader>
                                                    .MapAllProperties()
                                                    .DoNotMap(h => h.GoodsReceiveDetails)
                                                    .Build(),
                                                    poNo).FirstOrDefault();


             
            return goodsreceiveheader;
        }

        

        #endregion

    }
}

