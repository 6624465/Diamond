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
	public class GoodsIssue: IContract
	{
		// Constructor 
		public GoodsIssue()
        {
            //this.SupplierList = new List<SelectListItem>();
            //this.CustomerList = new List<SelectListItem>();
        }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

		[DisplayName("DocumentDate")] 
		public DateTime  DocumentDate { get; set; }

		[DisplayName("BranchID")] 
		public Int16  BranchID { get; set; }

		[DisplayName("CustomerCode")] 
		public string CustomerCode { get; set; }

		[DisplayName("CustomerName")]
        public string CustomerName { get; set; }



        [DisplayName("SupplierCode")]
        public string SupplierCode { get; set; }


        [DisplayName("SupplierName")]
        public string SupplierName { get; set; }


		[DisplayName("Remarks")] 
		public string Remarks { get; set; }

		[DisplayName("ReferenceNo")] 
		public string ReferenceNo { get; set; }

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


        public List<GoodsIssueDetail> GoodsIssueDetails { get; set; }

        public IEnumerable<SelectListItem> SupplierList { get; set; }
        public IEnumerable<SelectListItem> CustomerList { get; set; }
    }
}



