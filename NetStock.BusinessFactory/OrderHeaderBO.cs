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
    public class OrderHeaderBO
    {
        private OrderHeaderDAL orderheaderDAL;
        public OrderHeaderBO()
        {

            orderheaderDAL = new OrderHeaderDAL();
        }

        public List<OrderHeader> GetList()
        {
            return orderheaderDAL.GetList();
        }


        public bool SaveOrderHeader(OrderHeader newItem)
        {

            return orderheaderDAL.Save(newItem);

        }

        public bool DeleteOrderHeader(OrderHeader item)
        {
            return orderheaderDAL.Delete(item);
        }

        public OrderHeader GetOrderHeader(OrderHeader item)
        {
            return (OrderHeader)orderheaderDAL.GetItem<OrderHeader>(item);
        }

    }
}
