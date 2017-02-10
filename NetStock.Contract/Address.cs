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
	public class Address: IContract
	{
		// Constructor 
		public Address() { }

		// Public Members 

		[DisplayName("AddressId")] 
		public int  AddressId { get; set; }

		[DisplayName("AddressLinkID")] 
		public string  AddressLinkID { get; set; }

		[DisplayName("SeqNo")] 
		public Int16  SeqNo { get; set; }

		[DisplayName("AddressType")] 
		public string  AddressType { get; set; }

		[DisplayName("Address1")] 
		public string Address1 { get; set; }

		[DisplayName("Address2")] 
		public string Address2 { get; set; }

		[DisplayName("Address3")] 
		public string  Address3 { get; set; }

		[DisplayName("Address4")] 
		public string  Address4 { get; set; }

		[DisplayName("CityName")] 
		public string CityName { get; set; }

		[DisplayName("StateName")] 
		public string StateName { get; set; }

		[DisplayName("CountryCode")] 
		public string  CountryCode { get; set; }

		[DisplayName("ZipCode")] 
		public string  ZipCode { get; set; }

		[DisplayName("TelNo")] 
		public string  TelNo { get; set; }

		[DisplayName("FaxNo")] 
		public string  FaxNo { get; set; }

		[DisplayName("MobileNo")] 
		public string  MobileNo { get; set; }

		[DisplayName("Contact")] 
		public string Contact { get; set; }

		[DisplayName("Email")] 
		public string  Email { get; set; }

		[DisplayName("WebSite")] 
		public string  WebSite { get; set; }

		[DisplayName("IsBilling")] 
		public bool  IsBilling { get; set; }

		[DisplayName("IsActive")] 
		public bool  IsActive { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }

        [DisplayName("FullAddress")]
        public string FullAddress { get; set; }

	}
}



