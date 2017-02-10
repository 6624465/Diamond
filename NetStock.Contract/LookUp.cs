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
	public class Lookup: IContract
	{
		// Constructor 
		public Lookup() { }

		// Public Members 

		[DisplayName("LookupCode")] 
		public string  LookupCode { get; set; }

		[DisplayName("Description")] 
		public string Description { get; set; }

		[DisplayName("Description2")] 
		public string Description2 { get; set; }

		[DisplayName("Category")] 
		public string  Category { get; set; }

		[DisplayName("Status")] 
		public bool  Status { get; set; }


	}
}



