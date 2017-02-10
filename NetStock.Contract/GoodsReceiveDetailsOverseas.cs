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
	public class GoodsReceiveDetailsOverseas: IContract
	{
		// Constructor 
		public GoodsReceiveDetailsOverseas() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

        [DisplayName("PONo")]
        public string PONo { get; set; }

		[DisplayName("ProductCode")] 
		public string  ProductCode { get; set; }

        [DisplayName("ProductDescription")]
        public string ProductDescription { get; set; }


		[DisplayName("Quantity")]
        public float Quantity { get; set; }

		[DisplayName("UOM")]
        public string UOM { get; set; }

		[DisplayName("ContainerNo")] 
		public string  ContainerNo { get; set; }

		[DisplayName("ContainerCondition")] 
		public bool  ContainerCondition { get; set; }

		[DisplayName("DamageDetails")] 
		public string DamageDetails { get; set; }

		[DisplayName("SealCondition")] 
		public bool  SealCondition { get; set; }

		[DisplayName("SealNo")] 
		public string  SealNo { get; set; }

		[DisplayName("IsSort")] 
		public bool  IsSort { get; set; }

		[DisplayName("SortRemarks")] 
		public string SortRemarks { get; set; }

		[DisplayName("IsFCL")] 
		public bool  IsFCL { get; set; }

		[DisplayName("IsHumidity")] 
		public bool  IsHumidity { get; set; }

		[DisplayName("IsProperPackage")] 
		public bool  IsProperPackage { get; set; }

		[DisplayName("IsClean")] 
		public bool  IsClean { get; set; }

		[DisplayName("IsCompressed")] 
		public bool  IsCompressed { get; set; }

		[DisplayName("IsCorrectWeight")] 
		public bool  IsCorrectWeight { get; set; }

		[DisplayName("QtyPerUOM")]
        public float QtyPerUOM { get; set; }

		[DisplayName("IsProductLabel")] 
		public bool  IsProductLabel { get; set; }

		[DisplayName("IsInspectContainer")] 
		public bool  IsInspectContainer { get; set; }

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



