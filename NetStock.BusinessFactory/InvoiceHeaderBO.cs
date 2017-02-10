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
    public class InvoiceHeaderBO
    {
        private InvoiceHeaderDAL invoiceheaderDAL;
        public InvoiceHeaderBO()
        {

            invoiceheaderDAL = new InvoiceHeaderDAL();
        }

        public List<InvoiceHeader> GetList()
        {
            return invoiceheaderDAL.GetList();
        }

        public List<UnbilledDetail> GetUnbilledOrders(UnbilledHeader item)
        {
            return invoiceheaderDAL.GetUnbilledOrders(item);
        }

        public List<UnbilledDetail> GetUnApprovedInvoices(UnbilledHeader item)
        {
            return invoiceheaderDAL.GetUnApprovedInvoices(item);
        }


        public bool ApproveInvoice(List<UnbilledDetail> items, string userID)
        {
            return invoiceheaderDAL.ApproveInvoice(items, userID);
        }


        public List<UnbilledDetail> InvoiceInquiry(UnbilledHeader item)
        {
            return invoiceheaderDAL.InvoiceInquiry(item);
        }


        

        public bool SaveInvoiceHeader(InvoiceHeader newItem)
        {

            return invoiceheaderDAL.Save(newItem);

        }

        public bool DeleteInvoiceHeader(InvoiceHeader item)
        {
            return invoiceheaderDAL.Delete(item);
        }

        public InvoiceHeader GetInvoiceHeader(InvoiceHeader item)
        {
            return (InvoiceHeader)invoiceheaderDAL.GetItem<InvoiceHeader>(item);
        }


        public string GetInvoiceNoByOrderNo(string OrderNo)
        {
            return invoiceheaderDAL.GetInvoiceNoByOrderNo(OrderNo);
        }

    }
}
