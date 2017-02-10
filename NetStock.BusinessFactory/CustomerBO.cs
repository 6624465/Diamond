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
    public class CustomerBO
    {
        private CustomerDAL customerDAL;
        public CustomerBO()
        {

            customerDAL = new CustomerDAL();
        }

        public List<Customer> GetList()
        {
            return customerDAL.GetList();
        }


        public bool SaveCustomer(Customer newItem)
        {

            return customerDAL.Save(newItem);

        }

        public bool DeleteCustomer(Customer item)
        {
            return customerDAL.Delete(item);
        }

        public Customer GetCustomer(Customer item)
        {
            return (Customer)customerDAL.GetItem<Customer>(item);
        }

    }
}
