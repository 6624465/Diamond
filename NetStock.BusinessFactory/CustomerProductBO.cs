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
    public class CustomerProductBO
    {
        private CustomerProductDAL customerproductDAL;
        public CustomerProductBO()
        {

            customerproductDAL = new CustomerProductDAL();
        }

        public List<CustomerProduct> GetList()
        {
            return customerproductDAL.GetList();
        }


        public List<CustomerProduct> GetCustomerProductsList(string customerCode)
        {
            return customerproductDAL.GetCustomerProductsList(customerCode);
        }


        public bool SaveList<T>(List<T> items) where T : IContract
        {
            return customerproductDAL.SaveList<T>(items);
        }


        public bool SaveCustomerProduct(CustomerProduct newItem)
        {

            return customerproductDAL.Save(newItem);

        }

        public bool DeleteCustomerProduct(CustomerProduct item)
        {
            return customerproductDAL.Delete(item);
        }

        public bool DeleteAllCustomerProducts(string customerCode)
        {
            return customerproductDAL.DeleteAllCustomerProducts(customerCode);
        }

        

        public CustomerProduct GetCustomerProduct(CustomerProduct item)
        {
            return (CustomerProduct)customerproductDAL.GetItem<CustomerProduct>(item);
        }

    }
}
