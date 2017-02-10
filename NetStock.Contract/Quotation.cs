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
	public class Quotation: IContract
	{
		// Constructor 
		public Quotation() { }

		// Public Members 
        
		[DisplayName("QuotationNo")] 
		public string  QuotationNo { get; set; }

		[DisplayName("BranchID")] 
		public Int16  BranchID { get; set; }

		[DisplayName("QuotationDate")] 
		public DateTime  QuotationDate { get; set; }

		[DisplayName("EffectiveDate")] 
        public DateTime  EffectiveDate { get; set; }

		[DisplayName("ExpiryDate")] 
		public DateTime  ExpiryDate { get; set; }

        [Required(ErrorMessage = "Customer Code is required")]
		[DisplayName("CustomerCode")] 
		public string  CustomerCode { get; set; }

        [DisplayName("CustomerName")]
        public string CustomerName { get; set; }


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


        public string QuotationType { get; set; }

        public List<QuotationItem> QuotationItems { get; set; }

        public IEnumerable<SelectListItem> CustomersList { get; set; }

        public IEnumerable<SelectListItem> ProductsList { get; set; }

        public IEnumerable<SelectListItem> CurrencyCodeList { get; set; }



	}
}



