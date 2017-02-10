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
    public class StockInDetailBO
    {
        private StockInDetailDAL stockindetailDAL;
        public StockInDetailBO()
        {

            stockindetailDAL = new StockInDetailDAL();
        }

        public List<StockInDetail> GetList()
        {
            return stockindetailDAL.GetList();
        }


        public bool SaveStockInDetail(StockInDetail newItem)
        {

            return stockindetailDAL.Save(newItem);

        }

        public bool DeleteStockInDetail(StockInDetail item)
        {
            return stockindetailDAL.Delete(item);
        }

        public StockInDetail GetStockInDetail(StockInDetail item)
        {
            return (StockInDetail)stockindetailDAL.GetItem<StockInDetail>(item);
        }


        public List<StockInDetail> GetPODetailsBySupplier(string PONo, string supplierCode)
        {
            return stockindetailDAL.GetPODetailsBySupplier(PONo, supplierCode);
        }

        public List<StockInDetail> GetStockInByPendingQty(string productCode, float quantity)
        {
            return stockindetailDAL.GetStockInByPendingQty(productCode, quantity);
        }
    }
}
