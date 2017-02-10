using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace NetStock.DataFactory
{
    public class SIHeaderDAL 
    {
        private Database db;

        /// <summary>
        /// Constructor
        /// </summary>
        public SIHeaderDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<SIHeader> GetList(short branchID)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTSIHEADER, MapBuilder<SIHeader>.MapAllProperties().DoNotMap(hd=> hd.SIDetails).Build(),branchID).ToList();
        }

        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var siheader = (SIHeader)(object)item;

            var connection = db.CreateConnection();
            connection.Open();

            var transaction = connection.BeginTransaction();

            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVESIHEADER);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, siheader.DocumentNo);
                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, siheader.BranchID);
                db.AddInParameter(savecommand, "DocumentDate", System.Data.DbType.DateTime, siheader.DocumentDate);
                db.AddInParameter(savecommand, "SupplierCode", System.Data.DbType.String, siheader.SupplierCode);
                db.AddInParameter(savecommand, "SupplierPI", System.Data.DbType.String, siheader.SupplierPI??"");
                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, siheader.CustomerCode??"");
                db.AddInParameter(savecommand, "CustomerPO", System.Data.DbType.String, siheader.CustomerPO??"");
                db.AddInParameter(savecommand, "PaymentTerm", System.Data.DbType.String, siheader.PaymentTerm??"");
                db.AddInParameter(savecommand, "TTDate", System.Data.DbType.DateTime, siheader.TTDate == null ? (object)DBNull.Value : siheader.TTDate);
                db.AddInParameter(savecommand, "IsOriginalDoc", System.Data.DbType.Boolean, siheader.IsOriginalDoc);
                db.AddInParameter(savecommand, "ETA", System.Data.DbType.DateTime, siheader.ETA == null ? (object)DBNull.Value :siheader.ETA );
                db.AddInParameter(savecommand, "ConfirmETA", System.Data.DbType.DateTime, siheader.ConfirmETA == null ? (object)DBNull.Value :siheader.ConfirmETA );
                db.AddInParameter(savecommand, "ETD", System.Data.DbType.DateTime, siheader.ETD == null ? (object)DBNull.Value : siheader.ETD);
                db.AddInParameter(savecommand, "ConfirmETD", System.Data.DbType.DateTime, siheader.ConfirmETD == null ? (object)DBNull.Value : siheader.ConfirmETD);
                db.AddInParameter(savecommand, "Remark", System.Data.DbType.String, siheader.Remark??"");
                db.AddInParameter(savecommand, "POL", System.Data.DbType.String, siheader.POL??"");
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, siheader.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, siheader.ModifiedBy);
                db.AddOutParameter(savecommand, "NewDocumentNo", System.Data.DbType.String, 25);


                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    var sidetailDAL = new SIDetailDAL();

                    // Get the New Quotation No.
                    siheader.DocumentNo = savecommand.Parameters["@NewDocumentNo"].Value.ToString();




                    Int16 itr = 1;

                    siheader.SIDetails.ForEach(dt =>
                    {
                        dt.DocumentNo = siheader.DocumentNo;
                        dt.CreatedBy = siheader.CreatedBy;
                        dt.ModifiedBy = siheader.ModifiedBy;

                    });


                    result = sidetailDAL.SaveList(siheader.SIDetails, transaction) == true ? 1 : 0;
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
            var siheader = (SIHeader)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETESIHEADER);

                db.AddInParameter(deleteCommand, "BranchID", System.Data.DbType.Int16, siheader.BranchID);
                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, siheader.DocumentNo);

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
            var item = ((SIHeader)lookupItem);

            var siheaderItem = db.ExecuteSprocAccessor(DBRoutine.SELECTSIHEADER,
                                                    MapBuilder<SIHeader>.MapAllProperties().DoNotMap(hd=> hd.SIDetails).Build(),
                                                    item.DocumentNo, item.BranchID).FirstOrDefault();

            if (siheaderItem != null)
            {
                siheaderItem.SIDetails = new SIDetailDAL().GetList(siheaderItem.DocumentNo);
            }
            
            
            return siheaderItem;
        }

        #endregion

    }
}

