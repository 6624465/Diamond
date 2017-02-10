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
	public class StockAdjustmentDetail: IContract
	{
		// Constructor 
		public StockAdjustmentDetail() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

		[DisplayName("ItemNo")] 
		public Int16  ItemNo { get; set; }

		[DisplayName("ProductCode")] 
		public string ProductCode { get; set; }

        [DisplayName("ProductDescription")]
        public string ProductDescription { get; set; }

		[DisplayName("BarCode")] 
		public string BarCode { get; set; }

		[DisplayName("Quantity")]
        public float Quantity { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }



        [DisplayName("StockType")]
        public string StockType { get; set; }

        public IEnumerable<SelectListItem> ProductsList { get; set; }

        public IEnumerable<SelectListItem> StockTypeList { get; set; }
	}
}



