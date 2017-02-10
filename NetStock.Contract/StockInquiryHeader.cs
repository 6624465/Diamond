using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace NetStock.Contract
{
    public class StockInquiryHeader
    {
        public StockInquiryHeader() { }


        public string ProductCode { get; set; }
        public string ProductCategory { get; set; }
        public string ProductLocation { get; set; }
        public string SupplierCode { get; set; }

        public List<StockInquiryDetail> StockInquiryDetails { get; set; }

        public IEnumerable<SelectListItem> ProductList { get; set; }
        public IEnumerable<SelectListItem> ProductCategoryList { get; set; }
        public IEnumerable<SelectListItem> ProductLocationList  { get; set; }
        public IEnumerable<SelectListItem> SupplierList { get; set; }


    }
}
