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
    public class StockInHeaderBO
    {
        private StockInHeaderDAL stockinheaderDAL;
        public StockInHeaderBO()
        {

            stockinheaderDAL = new StockInHeaderDAL();
        }

        public List<StockInHeader> GetList()
        {
            return stockinheaderDAL.GetList();
        }


        public bool SaveStockInHeader(StockInHeader newItem)
        {

            return stockinheaderDAL.Save(newItem);

        }

        public bool DeleteStockInHeader(StockInHeader item)
        {
            return stockinheaderDAL.Delete(item);
        }

        public StockInHeader GetStockInHeader(StockInHeader item)
        {
            return (StockInHeader)stockinheaderDAL.GetItem<StockInHeader>(item);
        }

    }
}
