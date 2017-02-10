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
	public class Location: IContract
	{
		// Constructor 
		public Location() { }

		// Public Members 

		[DisplayName("Location Code")] 
		public string  LocationCode { get; set; }

		[DisplayName("Location Description")] 
		public string LocationDescription { get; set; }


	}
}



