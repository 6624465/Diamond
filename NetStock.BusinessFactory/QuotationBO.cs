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
    public class QuotationBO
    {
        private QuotationDAL quotationDAL;
        public QuotationBO()
        {

            quotationDAL = new QuotationDAL();
        }

        public List<Quotation> GetList()
        {
            return quotationDAL.GetList();
        }


        public bool SaveQuotation(Quotation newItem)
        {

            return quotationDAL.Save(newItem);

        }

        public bool DeleteQuotation(Quotation item)
        {
            return quotationDAL.Delete(item);
        }

        public Quotation GetQuotation(Quotation item)
        {
            return (Quotation)quotationDAL.GetItem<Quotation>(item);
        }


        
    }
}
