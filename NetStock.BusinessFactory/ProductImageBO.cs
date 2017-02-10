
using NetStock.Contract;
using NetStock.DataFactory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetStock.BusinessFactory
{
    public class ProductImageBO
    {
        private ProductImageDAL productImageDAL;
        public ProductImageBO()
        {

            productImageDAL = new ProductImageDAL();
        }
        public bool SaveProductImage(ProductImage newItem)
        {
            return productImageDAL.Save(newItem);
        }


        public ProductImage GetProductImage(string productCode)
        {
            return productImageDAL.GetProductImage(productCode);
        }


    }
}
