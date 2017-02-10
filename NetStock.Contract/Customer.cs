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
	public class Customer: IContract
	{
		// Constructor 
		public Customer() { }

		// Public Members 

        [Required(ErrorMessage="Customer Code is required")]
		[DisplayName("Customer Code")] 
		public string  CustomerCode { get; set; }

        [Required(ErrorMessage = "Customer Name is required")]
		[DisplayName("Customer Name")] 
		public string CustomerName { get; set; }

		[DisplayName("RegistrationNo")] 
		public string RegistrationNo { get; set; }

		[DisplayName("CustomerType")] 
		public string  CustomerType { get; set; }

		[DisplayName("Status")] 
		public bool  Status { get; set; }

		[DisplayName("Remark")] 
		public string Remark { get; set; }

		[DisplayName("CreditTerm")] 
		public Int16  CreditTerm { get; set; }

        [DisplayName("CustomerMode")]
        public string CustomerMode { get; set; }


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

        [DisplayName("Contact Person")]
        public string ContactPerson { get; set; }

        public List<CustomerProduct> CustomerProducts { get; set; }

        public Address CustomerAddress { get; set; }

        public IEnumerable<SelectListItem> CountryList { get; set; }

        public IEnumerable<SelectListItem> CustomerModeList { get; set; }



	}
}



