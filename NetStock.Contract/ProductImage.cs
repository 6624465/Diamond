using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NetStock.Contract;

namespace NetStock.Contract
{
    public class ProductImage : IContract
    {
        public ProductImage() { }
        public string Code { get; set; }

        public byte[] ProductImg { get; set; }

        public string FileName { get; set; }
    }
}
