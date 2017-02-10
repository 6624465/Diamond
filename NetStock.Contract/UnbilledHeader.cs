using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace NetStock.Contract
{
    public class UnbilledHeader:IContract
    {
        public UnbilledHeader() { }


        public string CustomerCode { get; set; }

        public DateTime DateFrom { get; set; }

        public DateTime DateTo { get; set; }

        public bool OverDue { get; set; }

        public int PaymentDays { get; set; }

        public string InvoiceType { get; set; }

        public List<UnbilledDetail> lstDetails { get; set; }

        public IEnumerable<SelectListItem> CustomersList { get; set; }

        public IEnumerable<SelectListItem> InvoiceTypeList { get; set; }


    }
}
