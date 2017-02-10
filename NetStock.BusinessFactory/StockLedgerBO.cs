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
    public class StockLedgerBO
    {
        private StockLedgerDAL stockledgerDAL;
        public StockLedgerBO()
        {

            stockledgerDAL = new StockLedgerDAL();
        }

        public List<StockLedger> GetList(string productCode)
        {
            return stockledgerDAL.GetList(productCode);
        }


        public bool SaveStockLedger(StockLedger newItem)
        {

            return stockledgerDAL.Save(newItem);

        }

        public bool DeleteStockLedger(StockLedger item)
        {
            return stockledgerDAL.Delete(item);
        }

        public StockLedger GetStockLedger(StockLedger item)
        {
            return (StockLedger)stockledgerDAL.GetItem<StockLedger>(item);
        }

        public List<StockInquiryDetail> StockInquiry(string productCode, string productCategory, string productLocation,string supplierCode)
        {
            return  stockledgerDAL.StockInquiry( productCode,  productCategory,  productLocation, supplierCode);
        }

        public Int32 GetProductCurrentStock(string productCode)
        {
            return stockledgerDAL.GetProductCurrentStock(productCode );
        }

    }
}
