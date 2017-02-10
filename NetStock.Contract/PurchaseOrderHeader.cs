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
	public class PurchaseOrderHeader: IContract
	{
		// Constructor 
		public PurchaseOrderHeader() { }

		// Public Members 

        [DisplayName("PONo")]
        public string PONo { get; set; }

        [DisplayName("PODate")]
        public DateTime PODate { get; set; }

        [DisplayName("BranchID")]
        public Int16 BranchID { get; set; }

        [DisplayName("SupplierCode")]
        public string SupplierCode { get; set; }

        [DisplayName("SupplierName")]
        public string SupplierName { get; set; }

        [DisplayName("ShipmentDate")]
        public DateTime? ShipmentDate { get; set; }

        [DisplayName("ReceiveDate")]
        public DateTime? ReceiveDate { get; set; }

        [DisplayName("EstimateDate")]
        public DateTime? EstimateDate { get; set; }

        [DisplayName("ReferenceNo")]
        public string ReferenceNo { get; set; }

        [DisplayName("Buyer")]
        public string Buyer { get; set; }

        [DisplayName("PRNo")]
        public string PRNo { get; set; }

        [DisplayName("IncoTerms")]
        public string IncoTerms { get; set; }

        [DisplayName("PaymentTerm")]
        public string PaymentTerm { get; set; }

        [DisplayName("PaymentTermDescription")]
        public string PaymentTermDescription { get; set; }
        

        [DisplayName("POStatus")]
        public bool POStatus { get; set; }

        [DisplayName("TotalAmount")]
        public decimal TotalAmount { get; set; }

        [DisplayName("OtherCharges")]
        public decimal OtherCharges { get; set; }
        

        [DisplayName("IsVAT")]
        public bool IsVAT { get; set; }

        [DisplayName("VATAmount")]
        public decimal VATAmount { get; set; }

        [DisplayName("NetAmount")]
        public decimal NetAmount { get; set; }

        [DisplayName("IsCancel")]
        public bool IsCancel { get; set; }

        [DisplayName("Remarks")]
        public string Remarks { get; set; }

        [DisplayName("Contact Person")]
        public string ContactPerson { get; set; }

        [DisplayName("CreatedBy")]
        public string CreatedBy { get; set; }

        [DisplayName("CreatedOn")]
        public DateTime CreatedOn { get; set; }

        [DisplayName("ModifiedBy")]
        public string ModifiedBy { get; set; }

        [DisplayName("ModifiedOn")]
        public DateTime ModifiedOn { get; set; }

         


        public List<PurchaseOrderDetail> PurchaseOrderDetails { get; set; }
        public IEnumerable<SelectListItem> SupplierList { get; set; }
        public IEnumerable<SelectListItem> BranchList { get; set; }
        public IEnumerable<SelectListItem> ProductsList { get; set; }
        public IEnumerable<SelectListItem> UOMList { get; set; }
        public IEnumerable<SelectListItem> IncoTermList { get; set; }
        public IEnumerable<SelectListItem> CurrencyCodeList { get; set; }
        public IEnumerable<SelectListItem> PaymentTypeList { get; set; }
	}
}



