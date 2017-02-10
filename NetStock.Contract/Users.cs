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
	public class Users: IContract
	{
		// Constructor 
		public Users() { }

		// Public Members 

		[DisplayName("UserID")] 
		public string  UserID { get; set; }

		[DisplayName("UserName")] 
		public string  UserName { get; set; }

		[DisplayName("Password")] 
		public string  Password { get; set; }

		[DisplayName("IsActive")] 
		public bool  IsActive { get; set; }

		[DisplayName("Email")] 
		public string  Email { get; set; }

		[DisplayName("MobileNumber")] 
		public string  MobileNumber { get; set; }

		[DisplayName("LogInStatus")] 
		public bool  LogInStatus { get; set; }

		[DisplayName("LastLogInOn")] 
		public DateTime  LastLogInOn { get; set; }

		

		[DisplayName("RoleCode")] 
		public string  RoleCode { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }


        public IEnumerable<SelectListItem> RoleCodeList { get; set; }


	}
}



