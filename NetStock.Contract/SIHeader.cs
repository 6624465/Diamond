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
	public class SIHeader: IContract
	{
		// Constructor 
		public SIHeader() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

		[DisplayName("DocumentDate")] 
		public DateTime  DocumentDate { get; set; }

		[DisplayName("BranchID")] 
		public Int16  BranchID { get; set; }

		[DisplayName("SupplierCode")] 
		public string SupplierCode { get; set; }

		[DisplayName("SupplierPI")] 
		public string SupplierPI { get; set; }

		[DisplayName("CustomerCode")] 
		public string CustomerCode { get; set; }

		[DisplayName("CustomerPO")] 
		public string CustomerPO { get; set; }

		[DisplayName("PaymentTerm")] 
		public string PaymentTerm { get; set; }

		[DisplayName("TTDate")] 
		public DateTime?  TTDate { get; set; }

		[DisplayName("IsOriginalDoc")] 
		public bool  IsOriginalDoc { get; set; }

		[DisplayName("ETA")] 
		public DateTime?  ETA { get; set; }

		[DisplayName("ConfirmETA")] 
		public DateTime?  ConfirmETA { get; set; }

		[DisplayName("ETD")] 
		public DateTime?  ETD { get; set; }

		[DisplayName("ConfirmETD")] 
		public DateTime?  ConfirmETD { get; set; }

		[DisplayName("Remark")] 
		public string Remark { get; set; }

		[DisplayName("POL")] 
		public string POL { get; set; }

		[DisplayName("Status")] 
		public bool  Status { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }


        public List<SIDetail> SIDetails { get; set; }
         

 

        public IEnumerable<SelectListItem> BranchList { get; set; }

        public IEnumerable<SelectListItem> SuppliersList { get; set; }

        public IEnumerable<SelectListItem> CustomersList { get; set; }

        public IEnumerable<SelectListItem> ProductsList { get; set; }

        public IEnumerable<SelectListItem> UOMList { get; set; }
        public IEnumerable<SelectListItem> CurrencyCodeList { get; set; }
        public IEnumerable<SelectListItem> PaymentTypeList { get; set; }


	}
}



