using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class GoodsIssueDetailBO
    {
        private GoodsIssueDetailDAL   goodsissusdetailDAL;
        public GoodsIssueDetailBO() {

            goodsissusdetailDAL = new GoodsIssueDetailDAL();
        }

        public List<GoodsIssueDetail> GetList(string documentNo)
        {
            return goodsissusdetailDAL.GetList(documentNo);
        }


        public bool SaveGoodsIssueDetail(GoodsIssueDetail newItem)
        {

            return goodsissusdetailDAL.Save(newItem);

        }

        public bool DeleteGoodsIssueDetail(GoodsIssueDetail item)
        {
            return goodsissusdetailDAL.Delete(item);
        }

        public GoodsIssueDetail GetGoodsIssueDetail(string documentNo)
        {
            return (GoodsIssueDetail)goodsissusdetailDAL.GetItem(documentNo);
        }

    }
}
