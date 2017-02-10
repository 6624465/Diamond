using NetStock.Contract;
using NetStock.DataFactory;
using System;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class GoodsIssueBO
    {
        private GoodsIssueDAL   goodsissueDAL;
        public GoodsIssueBO() {

            goodsissueDAL = new GoodsIssueDAL();
        }

        public List<GoodsIssue> GetList()
        {
            return goodsissueDAL.GetList();
        }


        public bool SaveGoodsIssue(GoodsIssue newItem)
        {

            return goodsissueDAL.Save(newItem);

        }

        public bool DeleteGoodsIssue(GoodsIssue item)
        {
            return goodsissueDAL.Delete(item);
        }

        public GoodsIssue GetGoodsIssue(GoodsIssue item)
        {
            return (GoodsIssue)goodsissueDAL.GetItem<GoodsIssue>(item);
        }

        public List<Int32> GetDashboardData()
        {
            return goodsissueDAL.GetDashboardData();
        }

    }
}
