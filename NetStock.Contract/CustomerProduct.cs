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
	public class CustomerProduct: IContract
	{
		// Constructor 
		public CustomerProduct() { }

		// Public Members 

		[DisplayName("CustomerCode")] 
		public string  CustomerCode { get; set; }

		[DisplayName("Supplier's Code")] 
		public string  ProductCode { get; set; }

		[DisplayName("Match-Product Code")] 
		public string  MatchProductCode { get; set; }
         

		[DisplayName("Bar Code")] 
		public string  BarCode { get; set; }

		[DisplayName("Cost Price")] 
		public decimal CostPrice { get; set; }

        public IEnumerable<SelectListItem> MatchProductList { get; set; }

        public string CustomerName { get; set; }

        public string MatchProductName { get; set; }

	}
}



