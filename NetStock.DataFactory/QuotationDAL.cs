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
    public class QuotationDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public QuotationDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<Quotation> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTQUOTATION, MapBuilder<Quotation>
                                                                    .MapAllProperties()
                                                                    .DoNotMap(dt => dt.QuotationItems)
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

            var quotation = (Quotation)(object)item;

            if (quotation.QuotationNo == "NEW")
            {
                if (CheckDuplicate(quotation) > 0)
                {
                    throw new Exception(string.Format("There are Some Active Quotations found for the Customer : {0}", quotation.CustomerCode));
                    return false;
                }
            }

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEQUOTATION);

                db.AddInParameter(savecommand, "QuotationNo", System.Data.DbType.String, quotation.QuotationNo);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, quotation.BranchID);
                db.AddInParameter(savecommand, "QuotationDate", System.Data.DbType.DateTime, quotation.QuotationDate);
                db.AddInParameter(savecommand, "EffectiveDate", System.Data.DbType.DateTime, quotation.EffectiveDate);
                db.AddInParameter(savecommand, "ExpiryDate", System.Data.DbType.DateTime, quotation.ExpiryDate);
                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, quotation.CustomerCode);
                db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, quotation.Status);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, quotation.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, quotation.ModifiedBy);
                db.AddInParameter(savecommand, "QuotationType", System.Data.DbType.String, quotation.QuotationType);
                db.AddOutParameter(savecommand, "NewQuotationNo", System.Data.DbType.String, 25);




                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    var quotationItemDAL = new QuotationItemDAL();

                    // Get the New Quotation No.
                    quotation.QuotationNo = savecommand.Parameters["@NewQuotationNo"].Value.ToString();
                    var iResult = quotationItemDAL.DeleteAll(quotation.QuotationNo);
                    var lstSaveItems = quotation.QuotationItems.Where(dt => dt.RecordStatus < 3).ToList();

                    Int16 itr = 1;

                   

                    if (lstSaveItems != null)
                    {


                        if (lstSaveItems.Count() > 0)
                        {
                            lstSaveItems.ForEach(dt =>
                            {
                                dt.QuotationNo = quotation.QuotationNo;
                                dt.ItemID = itr++;
                                dt.Status = true;
                                dt.BarCode = "";
                                dt.CreatedBy = quotation.CreatedBy;
                                dt.ModifiedBy = quotation.ModifiedBy;
                                dt.Status = true;

                            });


                            result = quotationItemDAL.SaveList(lstSaveItems, transaction) == true ? 1 : 0;
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


        public int CheckDuplicate<T>(T item) where T : IContract
        {
            var quotationItem = (Quotation)(object)item;

            var result = Convert.ToInt32(db.ExecuteScalar(DBRoutine.CHECKDUPLICATE,
                                                quotationItem.CustomerCode,
                                                quotationItem.EffectiveDate));

            return result;



        }


        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var quotation = (Quotation)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEQUOTATION);

                db.AddInParameter(deleteCommand, "QuotationNo", System.Data.DbType.String, quotation.QuotationNo);
                db.AddInParameter(deleteCommand, "ModifiedBy", System.Data.DbType.String, quotation.ModifiedBy);


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
            var item = ((Quotation)lookupItem);

            var quotationItem = db.ExecuteSprocAccessor(DBRoutine.SELECTQUOTATION,
                                                    MapBuilder<Quotation>
                                                    .MapAllProperties()
                                                    .DoNotMap(dt => dt.QuotationItems)
                                                    .Build(),
                                                    item.QuotationNo).FirstOrDefault();

            if (quotationItem != null)
            {

                quotationItem.QuotationItems = new NetStock.DataFactory.QuotationItemDAL().GetListByQuotationNo(quotationItem.QuotationNo);

            }


            return quotationItem;
        }

        #endregion






    }
}

