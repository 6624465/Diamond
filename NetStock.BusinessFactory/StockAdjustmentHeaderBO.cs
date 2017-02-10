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
    public class StockAdjustmentHeaderBO
    {
        private StockAdjustmentHeaderDAL stockadjustmentheaderDAL;
        public StockAdjustmentHeaderBO()
        {

            stockadjustmentheaderDAL = new StockAdjustmentHeaderDAL();
        }

        public List<StockAdjustmentHeader> GetList()
        {
            return stockadjustmentheaderDAL.GetList();
        }


        public bool SaveStockInHeader(StockAdjustmentHeader newItem)
        {

            return stockadjustmentheaderDAL.Save(newItem);

        }

        public bool DeleteStockInHeader(StockAdjustmentHeader item)
        {
            return stockadjustmentheaderDAL.Delete(item);
        }

        public StockAdjustmentHeader GetStockInHeader(StockAdjustmentHeader item)
        {
            return (StockAdjustmentHeader)stockadjustmentheaderDAL.GetItem<StockAdjustmentHeader>(item);
        }


    }
}
