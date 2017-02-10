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
    public class OrderIssueDetail : IContract
    {// Constructor 
        public OrderIssueDetail() { }

		// Public Members 

		[DisplayName("OrderNo")] 
		public string  OrderNo { get; set; }

		[DisplayName("ItemNo")] 
		public Int16  ItemNo { get; set; }

        [DisplayName("ProductCode")]
        public string ProductCode { get; set; }

        [DisplayName("Product Description")]
        public string ProductDescription { get; set; }



		[DisplayName("BarCode")] 
		public string  BarCode { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###}")]
		[DisplayName("Quantity")]
        public float Quantity { get; set; }


        [DisplayFormat(DataFormatString = "{0:#,###,###}")]
        [DisplayName("IssueQuantity")]
        public float? IssueQuantity { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("Cost")]
        public decimal Cost { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
		[DisplayName("SellRate")] 
		public decimal SellRate { get; set; }

        [DisplayFormat(DataFormatString = "{0:##,###.00}")]
		[DisplayName("SellPrice")] 
		public decimal SellPrice { get; set; }

		[DisplayName("MatchQuotation")] 
		public string  MatchQuotation { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }


        [DisplayName("Discount Type")]
        public string DiscountType { get; set; }

        [DisplayName("Discount Amount")]
        public decimal DiscountAmount { get; set; }

        [DisplayName("Adjust Amount")]
        public decimal AdjustAmount { get; set; }

        [DisplayName("PartialPayment")]
        public decimal PartialPayment { get; set; }


        [DisplayName("Product Photo")]
        public ProductImage Photo { get; set; }

        [DisplayName("Location")]
        public string Location { get; set; }

        [DisplayName("LocationDescription")]
        public string LocationDescription { get; set; }



        [DisplayName("RecordStatus")]
        public short RecordStatus { get; set; }

        public string ProductImageString { get; set; }

        public string ReferenceNo { get; set; }

        public IEnumerable<SelectListItem> ProductsList { get; set; }
        public IEnumerable<SelectListItem> DiscountTypeList { get; set; }
    }
}
