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
	public class GoodsIssueDetail: IContract
	{
		// Constructor 
		public GoodsIssueDetail() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

        [DisplayName("ProductCode")]
        public string ProductCode { get; set; }

        [DisplayName("ProductName")]
        public string ProductName { get; set; }



		[DisplayName("Qty")] 
		public float  Qty { get; set; }

		[DisplayName("LotNo")] 
		public string LotNo { get; set; }

        [DisplayName("CurrentQty")]
        public float CurrentQty { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }

        [DisplayName("Status")]
        public bool Status { get; set; }


        public IEnumerable<SelectListItem> ProductsList { get; set; }

	}
}



