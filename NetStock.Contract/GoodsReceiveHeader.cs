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
	public class GoodsReceiveHeader: IContract
	{
		// Constructor 
		public GoodsReceiveHeader() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

		[DisplayName("DocumentDate")] 
		public DateTime  DocumentDate { get; set; }

		[DisplayName("BranchID")] 
		public Int16  BranchID { get; set; }

		[DisplayName("DocumentType")] 
		public string  DocumentType { get; set; }

		[DisplayName("Supplier Code")] 
		public string SupplierCode { get; set; }

        [DisplayName("Supplier Name")]
        public string SupplierName { get; set; }


        

		[DisplayName("PONo")] 
		public string PONo { get; set; }

		[DisplayName("Status")] 
		public bool  Status { get; set; }

		[DisplayName("IsApproved")] 
		public bool  IsApproved { get; set; }

		[DisplayName("ApprovedBy")] 
		public string  ApprovedBy { get; set; }

		[DisplayName("ApprovedOn")] 
		public DateTime  ApprovedOn { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }




        public List<GoodsReceivePODetail> GoodsReceivePODetailList { get; set; }
        public List<GoodsReceiveDetail> GoodsReceiveDetails { get; set; }
        public List<InspectionDomestic> InspectionDomesticList { get; set; }

        public List<GoodsReceiveDetailsOverseas> GoodsReceiveDetailsOverseasList { get; set; }
        public List<InspectionOverseas> InspectionOverSeasList { get; set; }



        

        public IEnumerable<SelectListItem> BranchList { get; set; }

        public IEnumerable<SelectListItem> SuppliersList { get; set; }

        public IEnumerable<SelectListItem> ProductsList { get; set; }

	}
}



