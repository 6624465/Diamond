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
    public class OrderIssueHeaderBO
    {
        private OrderIssueHeaderDAL orderissueheaderDAL;
        public OrderIssueHeaderBO()
        {

            orderissueheaderDAL = new OrderIssueHeaderDAL();
        }

        public List<OrderIssueHeader> GetList()
        {
            return orderissueheaderDAL.GetList();
        }


        public bool SaveOrderHeader(OrderIssueHeader newItem)
        {

            return orderissueheaderDAL.Save(newItem);

        }

        public bool DeleteOrderHeader(OrderIssueHeader item)
        {
            return orderissueheaderDAL.Delete(item);
        }

        public OrderIssueHeader GetOrderIssueHeader(OrderIssueHeader item)
        {
            return (OrderIssueHeader)orderissueheaderDAL.GetItem<OrderIssueHeader>(item);
        }

        public OrderIssueHeader SearchOrderIssueByRefNo(string referenceNo)
        {
            return (OrderIssueHeader)orderissueheaderDAL.SearchOrderIssueByRefNo(referenceNo);
        }


    }
}
