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
    public class InvoiceDetailBO
    {
        private InvoiceDetailDAL invoicedetailDAL;
        public InvoiceDetailBO()
        {

            invoicedetailDAL = new InvoiceDetailDAL();
        }

        public List<InvoiceDetail> GetList()
        {
            return invoicedetailDAL.GetList();
        }


        public bool SaveInvoiceDetail(InvoiceDetail newItem)
        {

            return invoicedetailDAL.Save(newItem);

        }

        public bool DeleteInvoiceDetail(InvoiceDetail item)
        {
            return invoicedetailDAL.Delete(item);
        }

        public InvoiceDetail GetInvoiceDetail(InvoiceDetail item)
        {
            return (InvoiceDetail)invoicedetailDAL.GetItem<InvoiceDetail>(item);
        }

    }
}
