using NetStock.Contract;
using NetStock.DataFactory;
using System;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class GoodsReceiveHeaderBO
    {
        private GoodsReceiveHeaderDAL   goodsreceiveheaderDAL;
        public GoodsReceiveHeaderBO() {

            goodsreceiveheaderDAL = new GoodsReceiveHeaderDAL();
        }

        public List<GoodsReceiveHeader> GetList(short branchID)
        {
            return goodsreceiveheaderDAL.GetList(branchID);
        }


        public bool SaveGoodsReceiveHeader(GoodsReceiveHeader newItem)
        {

            return goodsreceiveheaderDAL.Save(newItem);

        }

        public bool DeleteGoodsReceiveHeader(GoodsReceiveHeader item)
        {
            return goodsreceiveheaderDAL.Delete(item);
        }

        public GoodsReceiveHeader GetGoodsReceiveHeader(GoodsReceiveHeader item)
        {
            return (GoodsReceiveHeader)goodsreceiveheaderDAL.GetItem<GoodsReceiveHeader>(item);
        }

        public GoodsReceiveHeader SearchGoodsReceiveByPO(string poNo)
        {
            return  goodsreceiveheaderDAL.SearchGoodsReceiveByPO(poNo);
        }

        

        public List<Int32> GetDashboardData()
        {
            return goodsreceiveheaderDAL.GetDashboardData();
        }

    }
}
