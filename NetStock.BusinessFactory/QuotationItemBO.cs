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
    public class QuotationItemBO
    {
        private QuotationItemDAL quotationitemDAL;
        public QuotationItemBO()
        {

            quotationitemDAL = new QuotationItemDAL();
        }

        public List<QuotationItem> GetList()
        {
            return quotationitemDAL.GetList();
        }

        public List<QuotationItem> GetQuotationProductPrice(string productCode)
        {
            return quotationitemDAL.GetQuotationProductPrice(productCode);
        }


        
        public List<QuotationItem> GetSupplierQuotationProductPrice(string supplierCode, string productCode )
        {
            return quotationitemDAL.GetSupplierQuotationProductPrice( supplierCode,  productCode );
        }


        public bool SaveQuotationItem(QuotationItem newItem)
        {

            return quotationitemDAL.Save(newItem);

        }

        public bool DeleteQuotationItem(QuotationItem item)
        {
            return quotationitemDAL.Delete(item);
        }

        public QuotationItem GetQuotationItem(QuotationItem item)
        {
            return (QuotationItem)quotationitemDAL.GetItem<QuotationItem>(item);
        }

    }
}
