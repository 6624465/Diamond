using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class GoodsReceivePODetailBO
    {
        private GoodsReceivePODetailDAL   goodsreceivepodetailDAL;
        public GoodsReceivePODetailBO() {

            goodsreceivepodetailDAL = new GoodsReceivePODetailDAL();
        }

        public List<GoodsReceivePODetail> GetList(string documentNo)
        {
            return goodsreceivepodetailDAL.GetList(documentNo);
        }


        public bool SaveGoodsReceivePODetail(GoodsReceivePODetail newItem)
        {

            return goodsreceivepodetailDAL.Save(newItem);

        }

        public bool DeleteGoodsReceivePODetail(GoodsReceivePODetail item)
        {
            return goodsreceivepodetailDAL.Delete(item);
        }

        public GoodsReceivePODetail GetGoodsReceivePODetail(GoodsReceivePODetail item)
        {
            return (GoodsReceivePODetail)goodsreceivepodetailDAL.GetItem<GoodsReceivePODetail>(item);
        }

        public List<GoodsReceivePODetail> GetPurchaseOrderDetailPendingList(string PONo)
        {
            return  goodsreceivepodetailDAL.GetPurchaseOrderDetailPendingList(PONo);
        }
        

    }
}
