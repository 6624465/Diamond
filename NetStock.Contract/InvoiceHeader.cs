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
	public class InvoiceHeader: IContract
	{
		// Constructor 
		public InvoiceHeader() { }

		// Public Members 

		[DisplayName("InvoiceNo")] 
		public string  InvoiceNo { get; set; }

		[DisplayName("InvoiceDate")] 
		public DateTime  InvoiceDate { get; set; }

        [DisplayName("CustomerCode")]
        public string CustomerCode { get; set; }

        [DisplayName("CustomerName")]
        public string CustomerName { get; set; }

		[DisplayName("InvoiceType")] 
		public string  InvoiceType { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("InvoiceAmount")] 
		public decimal InvoiceAmount { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("TaxAmount")] 
		public decimal TaxAmount { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("TotalAmount")] 
		public decimal TotalAmount { get; set; }

		[DisplayName("PendingPayment")] 
		public bool  PendingPayment { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        [DisplayName("PaymentDate")] 
		public DateTime  PaymentDate { get; set; }

        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        [DisplayName("DueDate")] 
		public DateTime  DueDate { get; set; }

		[DisplayName("Status")] 
		public bool  Status { get; set; }

		[DisplayName("IsApproved")] 
		public bool  IsApproved { get; set; }

		[DisplayName("ApprovedBy")] 
		public string  ApprovedBy { get; set; }

		[DisplayName("ApprovedOn")] 
		public DateTime  ApprovedOn { get; set; }

        [DisplayName("BranchID")]
        public Int16 BranchID { get; set; }


		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }


        [DisplayName("Required Delivery")]
        public bool IsRequireDelivery { get; set; }


        public List<InvoiceDetail> InvoiceDetails { get; set; }

        public IEnumerable<SelectListItem> InvoiceTypeList { get; set; }
        public IEnumerable<SelectListItem> CustomersList { get; set; }





	}
}



