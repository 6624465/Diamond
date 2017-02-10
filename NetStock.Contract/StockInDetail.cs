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
	public class StockInDetail: IContract
	{
		// Constructor 
		public StockInDetail() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

		[DisplayName("ItemNo")] 
		public Int16  ItemNo { get; set; }

		[DisplayName("ProductCode")] 
		public string  ProductCode { get; set; }

        [DisplayName("ProductDescription")]
        public string ProductDescription { get; set; }


		[DisplayName("BarCode")] 
		public string  BarCode { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###}")]
        [DisplayName("Quantity")]
        public float Quantity { get; set; }


        [DisplayFormat(DataFormatString = "{0:#,###,###}")]
        [DisplayName("OutQuantity")]
        public float OutQuantity { get; set; }



        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("BuyingPrice")]
        public decimal BuyingPrice { get; set; }


        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("BuyingAmount")]
        public decimal BuyingAmount { get; set; }


        [DisplayName("Location")]
        public string Location { get; set; }

        [DisplayName("LocationDescription")]
        public string LocationDescription { get; set; }


		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }


        [DisplayName("P.O Qty")]
        public float POQty { get; set; }

        public float PendingQty { get; set; }

        public IEnumerable<SelectListItem> ProductsList { get; set; }



	}
}



