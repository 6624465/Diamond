using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetStock.Contract
{
    public class StockInquiryDetail
    {
        public StockInquiryDetail() { }

        public string ProductCode { get; set; }

        public string ProductDescription { get; set; }

        public string BarCode { get; set; }

        public string ProductCategory { get; set; }

        public decimal SellRate { get; set; }

        public string Color { get; set; }

        public string Size { get; set; }

        public string UOM { get; set; }

        public string Location { get; set; }

        public decimal StockInHand { get; set; }

        public float ReOrderQty { get; set; }

        public string Suppliers { get; set; }

        public decimal BuyingPrice { get; set; }
    }
}
