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
	public class QuotationItem: IContract
	{
		// Constructor 
		public QuotationItem() { }

		// Public Members 

		[DisplayName("QuotationNo")] 
		public string  QuotationNo { get; set; }

		[DisplayName("ItemID")] 
		public Int16  ItemID { get; set; }

		[DisplayName("ProductCode")] 
		public string  ProductCode { get; set; }

        [DisplayName("ProductDescription")]
        public string ProductDescription { get; set; }


		[DisplayName("BarCode")] 
		public string  BarCode { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###.00}")]
        [DisplayName("SellRate")] 
		public decimal SellRate { get; set; }

        [DisplayName("CurrencyCode")]
        public string CurrencyCode { get; set; }
        

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

		[DisplayName("RecordStatus")]
        public short RecordStatus  { get; set; }

        

        public IEnumerable<SelectListItem> ProductsList { get; set; }
        public IEnumerable<SelectListItem> CurrencyCodeList { get; set; }

	}
}



