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
    public class OrderDetailBO
    {
        private OrderDetailDAL orderdetailDAL;
        public OrderDetailBO()
        {

            orderdetailDAL = new OrderDetailDAL();
        }

        public List<OrderDetail> GetList()
        {
            return orderdetailDAL.GetList();
        }


        public bool SaveOrderDetail(OrderDetail newItem)
        {

            return orderdetailDAL.Save(newItem);

        }

        public bool DeleteOrderDetail(OrderDetail item)
        {
            return orderdetailDAL.Delete(item);
        }

        public OrderDetail GetOrderDetail(OrderDetail item)
        {
            return (OrderDetail)orderdetailDAL.GetItem<OrderDetail>(item);
        }


        public OrderDetail GetProductPrice(string customerCode, string barCode,short branchID)
        {
            return orderdetailDAL.GetProductPrice(customerCode, barCode, branchID);
        }

    }
}
