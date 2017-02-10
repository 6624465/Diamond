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
	public class ProductCategory: IContract
	{
		// Constructor 
		public ProductCategory() { }

		// Public Members 

		[DisplayName("Category Code")] 
		public string CategoryCode { get; set; }

		[DisplayName("Description")] 
		public string Description { get; set; }

		[DisplayName("Internal Stock")] 
		public bool  IsInternalStock { get; set; }

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



