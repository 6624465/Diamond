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
	public class GoodsReceiveDetail: IContract
	{
		// Constructor 
		public GoodsReceiveDetail() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

        [DisplayName("PONo")]
        public string PONo { get; set; }

		[DisplayName("ProductCode")] 
		public string  ProductCode { get; set; }


        [DisplayName("ProductDescription")]
        public string ProductDescription { get; set; }
        

		[DisplayName("UOM")] 
		public string  UOM { get; set; }

		[DisplayName("IsCovered")] 
		public bool  IsCovered { get; set; }

		[DisplayName("CoverRemarks")] 
		public string CoverRemarks { get; set; }

		[DisplayName("IsSorted")] 
		public bool  IsSorted { get; set; }

		[DisplayName("SortedRemarks")] 
		public string SortedRemarks { get; set; }

		[DisplayName("IsHumidity")] 
		public bool  IsHumidity { get; set; }

		[DisplayName("IsSameAsPhoto")] 
		public bool  IsSameAsPhoto { get; set; }

		[DisplayName("IsClean")] 
		public bool  IsClean { get; set; }

		[DisplayName("IsCompressed")] 
		public bool  IsCompressed { get; set; }

		[DisplayName("IsCorrectWeight")] 
		public bool  IsCorrectWeight { get; set; }

        [DisplayName("Qty")]
        public float Qty { get; set; }

        [DisplayName("PalletQty")]
        public float PalletQty { get; set; }

        [DisplayName("PalletUOM")]
        public string PalletUOM { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }

		[DisplayName("Status")] 
		public bool  Status { get; set; }

        public IEnumerable<SelectListItem> ProductsList { get; set; }

	}
}



