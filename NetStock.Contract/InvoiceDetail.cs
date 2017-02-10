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
	public class InvoiceDetail: IContract
	{
		// Constructor 
		public InvoiceDetail() { }

		// Public Members 

		[DisplayName("InvoiceNo")] 
		public string  InvoiceNo { get; set; }

        
        [DisplayName("OrderNo")]
        public string OrderNo { get; set; }


		[DisplayName("ItemNo")] 
		public Int16  ItemNo { get; set; }

        [DisplayName("ProductCode")]
        public string ProductCode { get; set; }

        [DisplayName("Product Description")]
        public string ProductDescription { get; set; }



        [DisplayName("BarCode")]
        public string BarCode { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###}")]
        [DisplayName("Quantity")]
        public float Quantity { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("Price")] 
		public decimal Price { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }


	}
}



