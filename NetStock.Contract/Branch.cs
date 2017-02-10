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
	public class Branch: IContract
	{
		// Constructor 
		public Branch() { }

		// Public Members 

		[DisplayName("BranchID")] 
		public Int16  BranchID { get; set; }

		[DisplayName("BranchCode")] 
		public string  BranchCode { get; set; }

		[DisplayName("BranchName")] 
		public string  BranchName { get; set; }

		[DisplayName("RegNo")] 
		public string  RegNo { get; set; }

		[DisplayName("IsActive")] 
		public bool  IsActive { get; set; }

		[DisplayName("CompanyCode")] 
		public string  CompanyCode { get; set; }

		[DisplayName("AddressID")] 
		public string  AddressID { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }

        public Address BranchAddress { get; set; }

        public IEnumerable<SelectListItem> CountryList { get; set; }
	}
}



