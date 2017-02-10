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
    public class OrderIssueDetailBO
    {
        private OrderIssueDetailDAL orderissuedetailDAL;
        public OrderIssueDetailBO()
        {

            orderissuedetailDAL = new OrderIssueDetailDAL();
        }

        public List<OrderIssueDetail> GetList()
        {
            return orderissuedetailDAL.GetList();
        }


        public bool SaveOrderDetail(OrderIssueDetail newItem)
        {

            return orderissuedetailDAL.Save(newItem);

        }

        public bool DeleteOrderDetail(OrderIssueDetail item)
        {
            return orderissuedetailDAL.Delete(item);
        }

        public OrderIssueDetail GetOrderIssueDetail(OrderIssueDetail item)
        {
            return (OrderIssueDetail)orderissuedetailDAL.GetItem<OrderIssueDetail>(item);
        }


        public OrderIssueDetail GetProductPrice(string customerCode, string barCode, short branchID)
        {
            return orderissuedetailDAL.GetProductPrice(customerCode, barCode, branchID);
        }

        public List<OrderIssueDetail> GetOrderIssueDetailPendingList(string referenceNo)
        {
            return orderissuedetailDAL.GetOrderIssueDetailPendingList(referenceNo);

        }
    }
}
