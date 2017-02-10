using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;

namespace NetStock.DataFactory
{
    public class InspectionDomesticDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public InspectionDomesticDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<InspectionDomestic> GetList(string documentNo, string poNo, string productCode)
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTINSPECTIONDOMESTIC, MapBuilder<InspectionDomestic>.BuildAllProperties(), documentNo, poNo, productCode).ToList();
        }

        public bool SaveList<T>(List<T> items, DbTransaction parentTransaction) where T : IContract
        {
            var result = true;
            try
            {


                if (items.Count == 0)
                    result = true;


                if (parentTransaction == null)
                {
                    connection = db.CreateConnection();
                    connection.Open();
                    parentTransaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);
                    currentTransaction = parentTransaction;

                }



                result = DeleteAll(((InspectionDomestic)(object)items.FirstOrDefault()).DocumentNo);


                var inspectiondomestic = ((List<InspectionDomestic>)(object)items).Where(x => x.Status == true).ToList();
                foreach (var item in inspectiondomestic)
                {
                    result = Save(item, parentTransaction);
                    if (result == false) break;
                }

                if (currentTransaction!=null)
                {
                    currentTransaction.Commit();
                }

            }
            catch (Exception)
            {
                
                currentTransaction.Rollback();
                throw;
            }
            finally {
                parentTransaction = null;
                currentTransaction = null;
            }

            return result;

        }


        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }


        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;
            var inspectionoverseas = (InspectionOverseas)(object)item;
            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }
            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);
            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEINSPECTIONOVERSEAS);

                db.AddInParameter(savecommand, "DocumentNo", System.Data.DbType.String, inspectionoverseas.DocumentNo);
                db.AddInParameter(savecommand, "PONo", System.Data.DbType.String, inspectionoverseas.PONo);
                db.AddInParameter(savecommand, "ProductCode", System.Data.DbType.String, inspectionoverseas.ProductCode);
                db.AddInParameter(savecommand, "ChemicalName", System.Data.DbType.String, inspectionoverseas.ChemicalName);
                db.AddInParameter(savecommand, "ReceivedDate", System.Data.DbType.DateTime, inspectionoverseas.ReceivedDate.ToString("dd-MM-yyyy") == "01-01-0001" ? (object)DBNull.Value : inspectionoverseas.ReceivedDate);
                db.AddInParameter(savecommand, "ReceivedQty", System.Data.DbType.Double, inspectionoverseas.ReceivedQty);
                db.AddInParameter(savecommand, "InspectionDate", System.Data.DbType.DateTime, inspectionoverseas.InspectionDate.ToString("dd-MM-yyyy") == "01-01-0001" ? (object)DBNull.Value : inspectionoverseas.InspectionDate);
                db.AddInParameter(savecommand, "InspectionTime", System.Data.DbType.DateTime, inspectionoverseas.InspectionTime);
                db.AddInParameter(savecommand, "InspectionQty", System.Data.DbType.Double, inspectionoverseas.InspectionQty);
                db.AddInParameter(savecommand, "SupplierType", System.Data.DbType.String, inspectionoverseas.SupplierType);
                db.AddInParameter(savecommand, "IsRequireLabour", System.Data.DbType.Boolean, inspectionoverseas.IsRequireLabour);
                db.AddInParameter(savecommand, "InvoiceNo", System.Data.DbType.String, inspectionoverseas.InvoiceNo);
                db.AddInParameter(savecommand, "PINumber", System.Data.DbType.String, inspectionoverseas.PINumber);
                db.AddInParameter(savecommand, "PurchaseReceivedQty", System.Data.DbType.Double, inspectionoverseas.PurchaseReceivedQty);
                db.AddInParameter(savecommand, "PurchaseQtyUOM", System.Data.DbType.String, inspectionoverseas.PurchaseQtyUOM);
                db.AddInParameter(savecommand, "COASupplier", System.Data.DbType.String, inspectionoverseas.COASupplier);
                db.AddInParameter(savecommand, "IsGetCOA", System.Data.DbType.Boolean, inspectionoverseas.IsGetCOA);
                db.AddInParameter(savecommand, "IsGetAllItem", System.Data.DbType.Boolean, inspectionoverseas.IsGetAllItem);
                db.AddInParameter(savecommand, "MissingItem", System.Data.DbType.String, inspectionoverseas.MissingItem);
                db.AddInParameter(savecommand, "IsGetCOABatchNo", System.Data.DbType.Boolean, inspectionoverseas.IsGetCOABatchNo);
                db.AddInParameter(savecommand, "COABatchNo", System.Data.DbType.String, inspectionoverseas.COABatchNo);
                db.AddInParameter(savecommand, "IsCOAManufactureDate", System.Data.DbType.Boolean, inspectionoverseas.IsCOAManufactureDate);
                db.AddInParameter(savecommand, "ManufactureDate", System.Data.DbType.DateTime, inspectionoverseas.ManufacturerDate.ToString("dd-MM-yyyy") == "01-01-0001" ? (object)DBNull.Value : inspectionoverseas.ManufacturerDate);
                db.AddInParameter(savecommand, "IsCOAExpiryDate", System.Data.DbType.Boolean, inspectionoverseas.IsCOAExpiryDate);
                db.AddInParameter(savecommand, "ExpiryDate", System.Data.DbType.DateTime, inspectionoverseas.ExpiryDate.ToString("dd-MM-yyyy") == "01-01-0001" ? (object)DBNull.Value : inspectionoverseas.ExpiryDate);
                db.AddInParameter(savecommand, "TestResult", System.Data.DbType.Boolean, inspectionoverseas.TestResult);
                db.AddInParameter(savecommand, "FailedItem", System.Data.DbType.String, inspectionoverseas.FailedItem);
                db.AddInParameter(savecommand, "InspectionResult", System.Data.DbType.Boolean, inspectionoverseas.InspectionResult);
                db.AddInParameter(savecommand, "Manufacturer", System.Data.DbType.String, inspectionoverseas.Manufacturer);
                db.AddInParameter(savecommand, "ContainerNo", System.Data.DbType.String, inspectionoverseas.ContainerNo);
                db.AddInParameter(savecommand, "SizeType", System.Data.DbType.String, inspectionoverseas.SizeType);
                db.AddInParameter(savecommand, "ChemicalReceiveBatchNo", System.Data.DbType.String, inspectionoverseas.ChemicalReceiveBatchNo);
                db.AddInParameter(savecommand, "BatchNo", System.Data.DbType.String, inspectionoverseas.BatchNo);
                db.AddInParameter(savecommand, "Homogenious", System.Data.DbType.Int16, inspectionoverseas.Homogenious);
                db.AddInParameter(savecommand, "IsLabelOK", System.Data.DbType.Boolean, inspectionoverseas.IsLabelOK);
                db.AddInParameter(savecommand, "IsColorOK", System.Data.DbType.Boolean, inspectionoverseas.IsColorOK);
                db.AddInParameter(savecommand, "IsWet", System.Data.DbType.Boolean, inspectionoverseas.IsWet);
                db.AddInParameter(savecommand, "ChemicalCondition", System.Data.DbType.Int16, inspectionoverseas.ChemicalCondition);
                db.AddInParameter(savecommand, "ContaminationRemarks", System.Data.DbType.String, inspectionoverseas.ContaminationRemarks);
                db.AddInParameter(savecommand, "AcceptStatus", System.Data.DbType.Int16, inspectionoverseas.AcceptStatus);
                db.AddInParameter(savecommand, "AcceptRemarks", System.Data.DbType.String, inspectionoverseas.AcceptRemarks);
                db.AddInParameter(savecommand, "BagWeight", System.Data.DbType.String, inspectionoverseas.BagWeight);
                db.AddInParameter(savecommand, "BagCondition", System.Data.DbType.Int16, inspectionoverseas.BagCondition);
                db.AddInParameter(savecommand, "PreparedBy", System.Data.DbType.String, inspectionoverseas.PreparedBy);
                db.AddInParameter(savecommand, "CheckedBy", System.Data.DbType.String, inspectionoverseas.CheckedBy);
                db.AddInParameter(savecommand, "ApprovedBy", System.Data.DbType.String, inspectionoverseas.ApprovedBy);

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

            return (result > 0 ? true : false);
        }

        public bool Delete(string documentNo, string poNo, string productCode, DbTransaction parentTransaction)
        {
            var inspectiondomesticItem = new InspectionDomestic { DocumentNo = documentNo, PONo = poNo, ProductCode = productCode };

            return Delete(inspectiondomesticItem, parentTransaction);
        }

        public bool Delete<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Delete(item);
        }



        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var inspectiondomestic = (InspectionDomestic)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEINSPECTIONDOMESTIC);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, inspectiondomestic.DocumentNo);
                db.AddInParameter(deleteCommand, "PONo", System.Data.DbType.String, inspectiondomestic.PONo);
                db.AddInParameter(deleteCommand, "ProductCode", System.Data.DbType.String, inspectiondomestic.ProductCode);

                result = Convert.ToBoolean(db.ExecuteNonQuery(deleteCommand, transaction));

                if (currentTransaction == null)
                    transaction.Commit();

            }
            catch (Exception ex)
            {
                if (currentTransaction == null)
                    transaction.Rollback();
                throw ex;
            }

            return result;
        }


        public bool DeleteAll(string documentNo)
        {
            var result = false;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEINSPECTIONDOMESTICALL);

                db.AddInParameter(deleteCommand, "DocumentNo", System.Data.DbType.String, documentNo);


                result = Convert.ToBoolean(db.ExecuteNonQuery(deleteCommand, transaction));

                if (currentTransaction == null)
                    transaction.Commit();

            }
            catch (Exception ex)
            {
                if (currentTransaction == null)
                    transaction.Rollback();
                throw ex;
            }

            return result;
        }
        public IContract GetItem<T>(IContract lookupItem) where T : IContract
        {
            var item = (InspectionDomestic)lookupItem;

            var inspectiondomestic = db.ExecuteSprocAccessor(DBRoutine.SELECTINSPECTIONDOMESTIC,
                                                    MapBuilder<InspectionDomestic>.BuildAllProperties(),
                                                    item.DocumentNo, item.PONo, item.ProductCode).FirstOrDefault();
            return inspectiondomestic;
        }

        #endregion

    }
}

