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
    public class Product : IContract
    {
        // Constructor 
        public Product() { }

        // Public Members 
        //[Required(ErrorMessage = "Product Code is required")]
        [DisplayName("Product Code / รหัสสินค้า")]
        public string ProductCode { get; set; }

        //[Required(ErrorMessage = "Description is required")]
        [DisplayName("Description / ชื่อสินค้า")]
        public string Description { get; set; }

        //[DisplayName("Product Category / ประเภท")]
        public string ProductCategory { get; set; }

        //[Required(ErrorMessage = "BarCode is required")]
        [DisplayName("Bar Code / บาร์โค้ด")]
        public string BarCode { get; set; }

        [DisplayName("UOM / หน่วยนับ")]
        public string UOM { get; set; }

        [DisplayName("Size / ขนาด")]
        public string Size { get; set; }

        [DisplayName("Color / สี")]
        public string Color { get; set; }

        [DisplayName("Current Qty")]
        public float CurrentQty { get; set; }

        [DisplayName("Status")]
        public bool Status { get; set; }

        [DisplayName("Created By")]
        public string CreatedBy { get; set; }

        [DisplayName("Created On")]
        public DateTime CreatedOn { get; set; }

        [DisplayName("Modified By")]
        public string ModifiedBy { get; set; }

        [DisplayName("Modified On")]
        public DateTime ModifiedOn { get; set; }

        [DisplayName("Re-Order Qty")]
        public float ReOrderQty { get; set; }

        [DisplayName("W/H Location / ตำแหน่งการจัดวาง")]
        public string Location { get; set; }

        [DisplayName("W/H Location Description")]
        public string LocationDescription { get; set; }

        public string ProductCategoryDescription { get; set; }
        public string UOMDescription { get; set; }


        [DisplayName("Buying Price")]
        public decimal BuyingPrice { get; set; }


        [DisplayName("Selling Price")]
        public decimal SellingPrice { get; set; }


        public IEnumerable<SelectListItem> ProductCategoryList { get; set; }
        public IEnumerable<SelectListItem> UOMList { get; set; }
        public IEnumerable<SelectListItem> LocationList { get; set; }

        [DisplayName("Product Photo / รูป")]
        public ProductImage Photo { get; set; }

    }
}



