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
	public class OrderHeader: IContract
	{
		// Constructor 
		public OrderHeader() { }

		// Public Members 

		[DisplayName("Order No")] 
		public string  OrderNo { get; set; }

		[DisplayName("Order Date")] 
		public DateTime  OrderDate { get; set; }

        [DisplayName("BranchID")]
        public Int16 BranchID { get; set; }
        
        [DisplayName("Customer Code")]
        public string CustomerCode { get; set; }

        [DisplayName("Customer Name")]
        public string CustomerName { get; set; }

        [DisplayName("Reg No.")]
        public string RegNo{ get; set; }

        [DisplayName("Address")]
        public string CustomerAddress { get; set; }

		[DisplayName("Sale Type")] 
		public string  SaleType { get; set; }

		[DisplayName("Status")] 
		public bool  Status { get; set; }

		[DisplayName("Is Approved")] 
		public bool  IsApproved { get; set; }

		[DisplayName("Created By")] 
		public string  CreatedBy { get; set; }

		[DisplayName("Created On")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("Modified By")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("Modified On")] 
		public DateTime  ModifiedOn { get; set; }

        [DisplayName("Pay Later")] 
        public bool IsPayLater { get; set; }


        [DisplayFormat(DataFormatString = "{0:#,###,###}")]
        [DisplayName("Payment Days")]
        public int PaymentDays { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("Total Amount")]
        public decimal TotalAmount { get; set; }

        public bool IsVAT { get; set; }

        public bool IsWHTax { get; set; }

        public decimal VATAmount { get; set; }

        public decimal WHTaxPercent { get; set; }

        public decimal WithHoldingAmount { get; set; }

        public decimal NetAmount { get; set; }




        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("Paid Amount")]
        public decimal PaidAmount { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("Balance Amount")]
        public decimal BalanceAmount { get; set; }


        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        [DisplayName("Discount Amount")]
        public decimal DiscountAmount { get; set; }

        [DisplayName("Payment Type")]
        public string PaymentType { get; set; }

        [DisplayName("Required Delivery")]
        public bool IsRequireDelivery { get; set; }


        [DisplayName("Delivery Date")]
        public DateTime DeliveryDate { get; set; }

        [DisplayName("Remarks")]
        public string Remarks { get; set; }


        [DisplayName("UOM")]
        public string UOM { get; set; }

        public List<OrderDetail> OrderDetails { get; set; }

        public IEnumerable<SelectListItem> OrderTypeList { get; set; }
        public IEnumerable<SelectListItem> CustomersList { get; set; }
        public IEnumerable<SelectListItem> PaymentTypeList { get; set; }
        public IEnumerable<SelectListItem> DiscountTypeList { get; set; }

        public IEnumerable<SelectListItem> UOMList { get; set; }

        [DisplayName("PaymentTypeDescription")]
        public string PaymentTypeDescription { get; set; }


    }
}



