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
    public class StockAdjustmentHeaderDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public StockAdjustmentHeaderDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<StockAdjustmentHeader> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSTOCKADJUSTMENTHEADER, MapBuilder<StockAdjustmentHeader>
                                                                         .MapAllProperties()
                                                                         .DoNotMap(dt => dt.StockAdjustmentDetails)
                                                                         .DoNotMap(dt => dt.ProductCode)
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

            var stockadjustmentheader = (StockAdjustmentHeader)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVESTOCKADJUSTMENTHEADER);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, stockadjustmentheader.DocumentNo);
                db.AddInParameter(savecommand, "DocumentDate", System.Data.DbType.DateTime, stockadjustmentheader.DocumentDate);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, stockadjustmentheader.BranchID);
                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, stockadjustmentheader.CustomerCode);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, stockadjustmentheader.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, stockadjustmentheader.ModifiedBy);
                db.AddOutParameter(savecommand, "NewDocumentNo", System.Data.DbType.String, 25);


                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    var stockadjustmentdetailDAL = new StockAdjustmentDetailDAL();

                    // Get the New Quotation No.
                    stockadjustmentheader.DocumentNo = savecommand.Parameters["@NewDocumentNo"].Value.ToString();


                    stockadjustmentheader.StockAdjustmentDetails.ForEach(dt => dt.DocumentNo = stockadjustmentheader.DocumentNo);

                    Int16 itr = 1;

                    stockadjustmentheader.StockAdjustmentDetails.ForEach(dt =>
                    {
                        dt.DocumentNo = stockadjustmentheader.DocumentNo;
                        dt.CreatedBy = stockadjustmentheader.CreatedBy;
                        dt.ModifiedBy = stockadjustmentheader.ModifiedBy;
                        dt.ItemNo= itr++;
                    });



                    result = Convert.ToInt16(stockadjustmentdetailDAL.Delete(stockadjustmentheader.DocumentNo, transaction));


                    result = stockadjustmentdetailDAL.SaveList(stockadjustmentheader.StockAdjustmentDetails, transaction) == true ? 1 : 0;


                    

                    if (result>0)
                    {
                        var lstStockLedger = new List<StockLedger>();

                        foreach (var dt in stockadjustmentheader.StockAdjustmentDetails)
                        {
                            

                            lstStockLedger.Add(new StockLedger
                            {
                                CustomerCode = stockadjustmentheader.CustomerCode,
                                CreatedBy = stockadjustmentheader.CreatedBy,
                                ModifiedBy = stockadjustmentheader.ModifiedBy,
                                ProductCode = dt.ProductCode,
                                Quantity = dt.Quantity,
                                StockFlag = dt.StockType=="ADD"? 1:-1 ,
                                MatchDocumentNo = stockadjustmentheader.DocumentNo,
                                TransactionNo = "",
                                TransactionType = dt.StockType=="ADD"? "IN" : "OUT",
                                Location = ""


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
            var stockadjustmentheader  = (StockAdjustmentHeader)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETESTOCKADJUSTMENTHEADER);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, stockadjustmentheader.DocumentNo);
                

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
            var item = ((StockAdjustmentHeader)lookupItem);

            var StockAdjustmentHeaderItem = db.ExecuteSprocAccessor(DBRoutine.SELECTSTOCKADJUSTMENTHEADER,
                                                    MapBuilder<StockAdjustmentHeader>
                                                    .MapAllProperties()
                                                    .DoNotMap(dt => dt.StockAdjustmentDetails)
                                                    .DoNotMap(dt => dt.ProductCode)
                                                    .Build(),
                                                    item.DocumentNo).FirstOrDefault();
            if (StockAdjustmentHeaderItem !=null)
            {
                StockAdjustmentHeaderItem.StockAdjustmentDetails = new StockAdjustmentDetailDAL().GetListByDocumentNo(StockAdjustmentHeaderItem.DocumentNo);

            }
            
            
            return StockAdjustmentHeaderItem;
        }

        #endregion






    }
}

