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
	public class PurchaseOrderDetail: IContract
	{
		// Constructor 
		public PurchaseOrderDetail() { }

		// Public Members 

		[DisplayName("PONo")] 
		public string  PONo { get; set; }

		 

        [DisplayName("ProductCode")]
        public string ProductCode { get; set; }

        [DisplayName("ProductDescription")]
        public string ProductDescription { get; set; }

         

        [DisplayFormat(DataFormatString = "{0:#,###,###}")]
        [DisplayName("Quantity")]
        public float Quantity { get; set; }

        [DisplayName("UOM")]
        public string UOM { get; set; }


        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("UnitPrice")]
        public decimal UnitPrice { get; set; }
 

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }


        [DisplayName("CurrencyCode")]
        public string CurrencyCode  { get; set; }

        [DisplayName("CurrencyDescription")]
        public string CurrencyDescription { get; set; }

        public IEnumerable<SelectListItem> CurrencyCodeList { get; set; }

        public IEnumerable<SelectListItem> ProductsList { get; set; }

        

        

	}
}



