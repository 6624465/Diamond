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
	public class StockLedger: IContract
	{
		// Constructor 
		public StockLedger() { }

		// Public Members 

		[DisplayName("TransactionNo")] 
		public string  TransactionNo { get; set; }

		[DisplayName("TransactionType")] 
		public string  TransactionType { get; set; }

		[DisplayName("ProductCode")] 
		public string  ProductCode { get; set; }

        [DisplayName("BranchID")]
        public Int16 BranchID { get; set; }


		[DisplayName("CustomerCode")] 
		public string  CustomerCode { get; set; }

		[DisplayName("Quantity")]
        public float Quantity { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###}")]
        [DisplayName("StockFlag")] 
		public Int32  StockFlag { get; set; }


        [DisplayName("MatchDocumentNo")]
        public string MatchDocumentNo { get; set; }


        [DisplayName("Location")]
        public string Location { get; set; }

        [DisplayName("StockDate")]
        public DateTime StockDate { get; set; }
        

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


	}
}



