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
	public class StockInHeader: IContract
	{
		// Constructor 
		public StockInHeader() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:dd.MM.yyyy}", ApplyFormatInEditMode = true)]
		[DisplayName("DocumentDate")] 
		public DateTime  DocumentDate { get; set; }

        [DisplayName("BranchID")]
        public Int16 BranchID { get; set; }


		[DisplayName("CustomerCode")] 
		public string  CustomerCode { get; set; }

        [DisplayName("CustomerName")]
        public string CustomerName { get; set; }

		[DisplayName("PONo")] 
		public string  PONo { get; set; }

		[DisplayName("Status")] 
		public bool  Status { get; set; }

		[DisplayName("IsApproved")] 
		public bool  IsApproved { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }

        [DisplayName("TotalAmount")]
        public decimal TotalAmount { get; set; }


        public bool IsVAT { get; set; }

        public decimal VATAmount { get; set; }

        public decimal NetAmount { get; set; }


        public List<StockInDetail> StockInDetails { get; set; }

        public IEnumerable<SelectListItem> CustomersList { get; set; }

        public IEnumerable<SelectListItem> POList { get; set; }


	}
}



