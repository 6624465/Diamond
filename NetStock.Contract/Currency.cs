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
	public class Currency: IContract
	{
		// Constructor 
		public Currency() { }

		// Public Members 

		[DisplayName("CurrencyCode")] 
		public string  CurrencyCode { get; set; }

		[DisplayName("Description")] 
		public string Description { get; set; }

		[DisplayName("Description1")] 
		public string Description1 { get; set; }


	}
}



