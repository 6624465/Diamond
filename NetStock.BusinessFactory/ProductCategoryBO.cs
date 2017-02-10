using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class ProductCategoryBO
    {
        private ProductCategoryDAL   productcategoryDAL;
        public ProductCategoryBO() {

            productcategoryDAL = new ProductCategoryDAL();
        }

        public List<ProductCategory> GetList()
        {
            return productcategoryDAL.GetList();
        }


        public bool SaveProductCategory(ProductCategory newItem)
        {

            return productcategoryDAL.Save(newItem);

        }

        public bool DeleteProductCategory(ProductCategory item)
        {
            return productcategoryDAL.Delete(item);
        }

        public ProductCategory GetProductCategory(ProductCategory item)
        {
            return (ProductCategory)productcategoryDAL.GetItem<ProductCategory>(item);
        }

    }
}
