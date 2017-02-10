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
	public class StockAdjustmentHeader: IContract
	{
		// Constructor 
		public StockAdjustmentHeader() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

		[DisplayName("DocumentDate")] 
		public DateTime  DocumentDate { get; set; }

        [DisplayName("BranchID")]
        public Int16 BranchID { get; set; }


		[DisplayName("CustomerCode")] 
		public string  CustomerCode { get; set; }

        [DisplayName("CustomerName")]
        public string CustomerName { get; set; }

        

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



        public List<StockAdjustmentDetail> StockAdjustmentDetails { get; set; }

        public IEnumerable<SelectListItem> CustomersList { get; set; }
         


        public IEnumerable<SelectListItem> ProductList { get; set; }

        [DisplayName("ProductCode")]
        public string ProductCode { get; set; }
	}
}



