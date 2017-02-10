using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class GoodsReceiveDetailsOverseasBO
    {
        private GoodsReceiveDetailsOverseasDAL   goodsreceivedetailsoverseasDAL;
        public GoodsReceiveDetailsOverseasBO()
        {

            goodsreceivedetailsoverseasDAL = new GoodsReceiveDetailsOverseasDAL();
        }

        public List<GoodsReceiveDetailsOverseas> GetList(string documentNo, string poNo)
        {
            return goodsreceivedetailsoverseasDAL.GetList(documentNo, poNo);
        }


        public bool SaveGoodsReceiveDetailsOverseas(GoodsReceiveDetailsOverseas newItem)
        {

            return goodsreceivedetailsoverseasDAL.Save(newItem);

        }

        public bool DeleteGoodsReceiveDetailsOverseas(GoodsReceiveDetailsOverseas item)
        {
            return goodsreceivedetailsoverseasDAL.Delete(item);
        }

        public GoodsReceiveDetailsOverseas GetGoodsReceiveDetailsOverseas(GoodsReceiveDetailsOverseas item)
        {
            return (GoodsReceiveDetailsOverseas)goodsreceivedetailsoverseasDAL.GetItem<GoodsReceiveDetailsOverseas>(item);
        }

    }
}
