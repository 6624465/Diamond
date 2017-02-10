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
    public class StockInHeaderDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public StockInHeaderDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<StockInHeader> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSTOCKINHEADER, MapBuilder<StockInHeader>
                                                                         .MapAllProperties()
                                                                         .DoNotMap(dt => dt.StockInDetails)
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

            var stockinheader = (StockInHeader)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVESTOCKINHEADER);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, stockinheader.DocumentNo);
                db.AddInParameter(savecommand, "DocumentDate", System.Data.DbType.DateTime, stockinheader.DocumentDate);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, stockinheader.BranchID);
                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, stockinheader.CustomerCode);
                db.AddInParameter(savecommand, "PONo", System.Data.DbType.String, stockinheader.PONo==null?"":stockinheader.PONo);
                db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, stockinheader.Status);
                db.AddInParameter(savecommand, "TotalAmount", System.Data.DbType.Decimal, stockinheader.TotalAmount);
                db.AddInParameter(savecommand, "IsVAT", System.Data.DbType.Boolean, stockinheader.IsVAT);
                db.AddInParameter(savecommand, "VATAmount", System.Data.DbType.Decimal, stockinheader.VATAmount);
                db.AddInParameter(savecommand, "NetAmount", System.Data.DbType.Decimal, stockinheader.NetAmount);
                db.AddInParameter(savecommand, "IsApproved", System.Data.DbType.Boolean, stockinheader.IsApproved);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, stockinheader.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, stockinheader.ModifiedBy);
                db.AddOutParameter(savecommand, "NewDocumentNo", System.Data.DbType.String, 25);


                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    var stockindetailDAL = new StockInDetailDAL();

                    // Get the New Quotation No.
                    stockinheader.DocumentNo = savecommand.Parameters["@NewDocumentNo"].Value.ToString();


                    stockinheader.StockInDetails.ForEach(dt => dt.DocumentNo = stockinheader.DocumentNo);

                    Int16 itr = 1;

                    stockinheader.StockInDetails.ForEach(dt =>
                    {
                        dt.DocumentNo = stockinheader.DocumentNo;
                        dt.CreatedBy = stockinheader.CreatedBy;
                        dt.ModifiedBy = stockinheader.ModifiedBy;
                        dt.Location = (dt.Location==null? "NONE" : dt.Location);
                        dt.ItemNo= itr++;
                    });



                    result = Convert.ToInt16(stockindetailDAL.Delete(stockinheader.DocumentNo, transaction));


                    result = stockindetailDAL.SaveList(stockinheader.StockInDetails, transaction) == true ? 1 : 0;


                    if (result>0)
                    {
                        var lstStockLedger = new List<StockLedger>();

                        foreach (var dt in stockinheader.StockInDetails)
                        {
                            lstStockLedger.Add(new StockLedger
                            {
                                CustomerCode = stockinheader.CustomerCode,
                                CreatedBy = stockinheader.CreatedBy,
                                ModifiedBy = stockinheader.ModifiedBy,
                                ProductCode = dt.ProductCode,
                                Quantity = dt.Quantity,
                                StockFlag = 1,
                                MatchDocumentNo = stockinheader.DocumentNo,
                                TransactionNo = "",
                                TransactionType = "IN",
                                Location = dt.Location
                                


                            });



                        }

                        result = new StockLedgerDAL().SaveList(lstStockLedger, transaction) == true ? 1 : 0;


                        
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
            var stockinheader = (StockInHeader)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETESTOCKINHEADER);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, stockinheader.DocumentNo);
                db.AddInParameter(deleteCommand, "ModifiedBy", System.Data.DbType.String, stockinheader.ModifiedBy);

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
            var item = ((StockInHeader)lookupItem);

            var StockInHeaderItem = db.ExecuteSprocAccessor(DBRoutine.SELECTSTOCKINHEADER,
                                                    MapBuilder<StockInHeader>
                                                    .MapAllProperties()
                                                    .DoNotMap(dt => dt.StockInDetails)
                                                    .Build(),
                                                    item.DocumentNo).FirstOrDefault();
            if (StockInHeaderItem !=null)
            {
                StockInHeaderItem.StockInDetails = new StockInDetailDAL().GetListByDocumentNo(StockInHeaderItem.DocumentNo);

            }
            
            
            return StockInHeaderItem;
        }

        #endregion






    }
}

