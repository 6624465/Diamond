using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetStock.Contract
{
    public class UnbilledDetail:IContract
    {

        public UnbilledDetail() { }


        public string InvoiceNo { get; set; }

        public DateTime InvoiceDate { get; set; }

        public string CustomerCode { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        public decimal InvoiceAmount { get; set; }

        [DisplayFormat(DataFormatString = "{0:#,###,###.00}")]
        public decimal PendingAmount { get; set; }

        public DateTime DueDate { get; set; }

        public string CustomerName { get; set; }

        public string InvoiceType { get; set; }

        public string ApprovalStatus { get; set; }


    }
}
