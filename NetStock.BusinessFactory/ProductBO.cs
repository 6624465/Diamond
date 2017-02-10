using System;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NetStock.Contract;
using NetStock.DataFactory;

namespace NetStock.BusinessFactory
{
    public class ProductBO
    {
        private ProductDAL productDAL;
        public ProductBO()
        {

            productDAL = new ProductDAL();
        }

        public List<Product> GetList()
        {
            return productDAL.GetList();
        }


        public bool SaveProduct(Product newItem)
        {

            return productDAL.Save(newItem);

        }

        public bool DeleteProduct(Product item)
        {
            return productDAL.Delete(item);
        }

        public Product GetProduct(Product item)
        {
            return (Product)productDAL.GetItem<Product>(item);
        }


        public Product GetProductByBarCodeOrDescription(Product item)
        {
            return (Product)productDAL.GetProductByBarCodeOrDescription<Product>(item);
        }

        public Product GetSupplierProductByBarCodeOrDescription(string supplierCode, string barCode, string description)
        {
            return (Product)productDAL.GetSupplierProductByBarCodeOrDescription(supplierCode,barCode,description);
        }

        public Product CheckDuplicateProduct(string productDescription, string barCode)
        {
            return (Product)productDAL.CheckDuplicateProduct(productDescription, barCode );
        }

    }
}
