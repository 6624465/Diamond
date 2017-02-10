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
    public class StockAdjustmentDetailBO
    {
        private StockAdjustmentDetailDAL stockadjustmentdetailDAL;
        public StockAdjustmentDetailBO()
        {

            stockadjustmentdetailDAL = new StockAdjustmentDetailDAL();
        }

        public List<StockAdjustmentDetail> GetList()
        {
            return stockadjustmentdetailDAL.GetList();
        }


        public bool SaveStockInDetail(StockAdjustmentDetail newItem)
        {

            return stockadjustmentdetailDAL.Save(newItem);

        }

        public bool DeleteStockInDetail(StockAdjustmentDetail item)
        {
            return stockadjustmentdetailDAL.Delete(item);
        }

        public StockAdjustmentDetail GetStockInDetail(StockAdjustmentDetail item)
        {
            return (StockAdjustmentDetail)stockadjustmentdetailDAL.GetItem<StockAdjustmentDetail>(item);
        }

 
    }
}
