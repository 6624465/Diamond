using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class GoodsReceiveDetailBO
    {
        private GoodsReceiveDetailDAL   goodsreceivedetailDAL;
        public GoodsReceiveDetailBO() {

            goodsreceivedetailDAL = new GoodsReceiveDetailDAL();
        }

        public List<GoodsReceiveDetail> GetList(string documentNo,string poNo)
        {
            return goodsreceivedetailDAL.GetList(documentNo,poNo);
        }


        public bool SaveGoodsReceiveDetail(GoodsReceiveDetail newItem)
        {

            return goodsreceivedetailDAL.Save(newItem);

        }

        public bool DeleteGoodsReceiveDetail(GoodsReceiveDetail item)
        {
            return goodsreceivedetailDAL.Delete(item);
        }

        public GoodsReceiveDetail GetGoodsReceiveDetail(GoodsReceiveDetail item)
        {
            return (GoodsReceiveDetail)goodsreceivedetailDAL.GetItem<GoodsReceiveDetail>(item);
        }

    }
}
