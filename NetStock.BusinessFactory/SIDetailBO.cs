using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class SIDetailBO
    {
        private SIDetailDAL   sidetailDAL;
        public SIDetailBO() {

            sidetailDAL = new SIDetailDAL();
        }

        public List<SIDetail> GetList(string documentNo)
        {
            return sidetailDAL.GetList(documentNo);
        }


        public bool SaveSIDetail(SIDetail newItem)
        {

            return sidetailDAL.Save(newItem);

        }

        public bool DeleteSIDetail(SIDetail item)
        {
            return sidetailDAL.Delete(item);
        }

        public SIDetail GetSIDetail(SIDetail item)
        {
            return (SIDetail)sidetailDAL.GetItem<SIDetail>(item);
        }

    }
}
