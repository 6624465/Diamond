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
	public class SystemWideConfiguration: IContract
	{
		// Constructor 
		public SystemWideConfiguration() { }

		// Public Members 

		[DisplayName("DisplayName")] 
		public string  DisplayName { get; set; }

		[DisplayName("ConfigurationValue")] 
		public string  ConfigurationValue { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }


	}
}



