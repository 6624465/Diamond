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
	public class InspectionDomestic: IContract
	{
		// Constructor 
		public InspectionDomestic() { }

		// Public Members 

		[DisplayName("DocumentNo")] 
		public string  DocumentNo { get; set; }

        [DisplayName("PONo")]
        public string PONo { get; set; }

		[DisplayName("ProductCode")] 
		public string  ProductCode { get; set; }

        [DisplayName("ItemNo")]
        public Int16 ItemNo { get; set; }
        

        [DisplayName("ProductDescription")]
        public string ProductDescription { get; set; }


		[DisplayName("InspectionDate")] 
		public DateTime  InspectionDate { get; set; }

		[DisplayName("InspectedBy")] 
		public string  InspectedBy { get; set; }

		[DisplayName("BatchNo")] 
		public string  BatchNo { get; set; }

		[DisplayName("Qty")]
        public float Qty { get; set; }

		[DisplayName("UOM")]
        public string UOM { get; set; }

		[DisplayName("BagNo")] 
		public string  BagNo { get; set; }

		[DisplayName("BagWeight")] 
		public string  BagWeight { get; set; }

		[DisplayName("Color")] 
		public string Color { get; set; }

		[DisplayName("MeltingMinute")] 
		public string  MeltingMinute { get; set; }

		[DisplayName("IsMeltAll")] 
		public bool  IsMeltAll { get; set; }

		[DisplayName("IsClean")] 
		public bool  IsClean { get; set; }

		[DisplayName("PHLevel")] 
		public string  PHLevel { get; set; }

		[DisplayName("Remarks")] 
		public string Remarks { get; set; }

		[DisplayName("CreatedBy")] 
		public string  CreatedBy { get; set; }

		[DisplayName("CreatedOn")] 
		public DateTime  CreatedOn { get; set; }

		[DisplayName("ModifiedBy")] 
		public string  ModifiedBy { get; set; }

		[DisplayName("ModifiedOn")] 
		public DateTime  ModifiedOn { get; set; }


        [DisplayName("Status")]
        public bool Status { get; set; }

    }
}



