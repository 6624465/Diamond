using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace NetStock.Contract
{
    public class ReportParam
    {
        public ReportParam() { }

        public string CustomerCode { get; set; }

        public DateTime DateFrom { get; set; }

        public DateTime DateTo { get; set; }

        public string ProductCategory { get; set; }

        public string InvoiceType { get; set; }

        public string ProductCode { get; set; }

        public string DocumentNo { get; set; }


        public IEnumerable<SelectListItem> ProductList { get; set; }
        public IEnumerable<SelectListItem> ProductCategoryList { get; set; }
        

        public IEnumerable<SelectListItem> InvoiceTypeList { get; set; }

        public IEnumerable<SelectListItem> CustomersList { get; set; }
    }
}
