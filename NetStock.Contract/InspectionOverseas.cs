using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Web;
using NetStock.Contract;

namespace NetStock.Contract
{
    public class InspectionOverseas : IContract
    {
        // Constructor 
        public InspectionOverseas() { }

        // Public Members 

        [DisplayName("DocumentNo")]
        public string DocumentNo { get; set; }

        [DisplayName("PONo")]
        public string PONo { get; set; }

        [DisplayName("ProductCode")]
        public string ProductCode { get; set; }

        [DisplayName("ChemicalName")]
        public string ChemicalName { get; set; }

        [DisplayName("ReceivedDate")]
        public DateTime ReceivedDate { get; set; }


        [DisplayName("ReceivedQty")]
        public float ReceivedQty { get; set; }

        [DisplayName("InspectionDate")]
        public DateTime InspectionDate { get; set; }

        [DisplayName("InspectionTime")]
        public DateTime InspectionTime { get; set; }

        [DisplayName("InspectionQty")]
        public float InspectionQty { get; set; }

        [DisplayName("SupplierType")]
        public string SupplierType { get; set; }

        [DisplayName("IsRequireLabour")]
        public bool IsRequireLabour { get; set; }

        [DisplayName("InvoiceNo")]
        public string InvoiceNo { get; set; }

        [DisplayName("PINumber")]
        public string PINumber { get; set; }

        [DisplayName("PurchaseReceivedQty")]
        public float PurchaseReceivedQty { get; set; }

        [DisplayName("PurchaseQtyUOM")]
        public string PurchaseQtyUOM { get; set; }



        [DisplayName("COASupplier")]
        public string COASupplier { get; set; }

        [DisplayName("IsGetCOA")]
        public bool IsGetCOA { get; set; }

        [DisplayName("IsGetAllItem")]
        public bool IsGetAllItem { get; set; }

        [DisplayName("MissingItem")]
        public string MissingItem { get; set; }

        [DisplayName("IsGetCOABatchNo")]
        public bool IsGetCOABatchNo { get; set; }

        [DisplayName("COABatchNo")]
        public string COABatchNo { get; set; }

        [DisplayName("IsCOAManufactureDate")]
        public bool IsCOAManufactureDate { get; set; }

        [DisplayName("ManufacturerDate")]
        public DateTime ManufacturerDate { get; set; }

        [DisplayName("IsCOAExpiryDate")]
        public bool IsCOAExpiryDate { get; set; }

        [DisplayName("ExpiryDate")]
        public DateTime ExpiryDate { get; set; }

        [DisplayName("TestResult")]
        public bool TestResult { get; set; }

        [DisplayName("FailedItem")]
        public string FailedItem { get; set; }

        [DisplayName("InspectionResult")]
        public bool InspectionResult { get; set; }

        [DisplayName("Manufacturer")]
        public string Manufacturer { get; set; }

        [DisplayName("ContainerNo")]
        public string ContainerNo { get; set; }

        [DisplayName("SizeType")]
        public string SizeType { get; set; }

        [DisplayName("ChemicalReceiveBatchNo")]
        public string ChemicalReceiveBatchNo { get; set; }

        [DisplayName("BatchNo")]
        public string BatchNo { get; set; }

        [DisplayName("Homogenious")]
        public Int16 Homogenious { get; set; }

        [DisplayName("IsLabelOK")]
        public bool IsLabelOK { get; set; }

        [DisplayName("IsColorOK")]
        public bool IsColorOK { get; set; }

        [DisplayName("IsWet")]
        public bool IsWet { get; set; }

        [DisplayName("ChemicalCondition")]
        public Int16 ChemicalCondition { get; set; }

        [DisplayName("ContaminationRemarks")]
        public string ContaminationRemarks { get; set; }

        [DisplayName("AcceptStatus")]
        public Int16 AcceptStatus { get; set; }

        [DisplayName("AcceptRemarks")]
        public string AcceptRemarks { get; set; }

        [DisplayName("BagWeight")]
        public string BagWeight { get; set; }

        [DisplayName("BagCondition")]
        public Int16 BagCondition { get; set; }

        [DisplayName("PreparedBy")]
        public string PreparedBy { get; set; }

        [DisplayName("PreparedOn")]
        public DateTime PreparedOn { get; set; }

        [DisplayName("CheckedBy")]
        public string CheckedBy { get; set; }

        [DisplayName("CheckedOn")]
        public DateTime CheckedOn { get; set; }

        [DisplayName("ApprovedBy")]
        public string ApprovedBy { get; set; }

        [DisplayName("ApprovedOn")]
        public DateTime ApprovedOn { get; set; }


    }
}



