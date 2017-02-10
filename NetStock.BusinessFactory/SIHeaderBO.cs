using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class SIHeaderBO
    {
        private SIHeaderDAL   siheaderDAL;
        public SIHeaderBO() {

            siheaderDAL = new SIHeaderDAL();
        }

        public List<SIHeader> GetList(short branchID)
        {
            return siheaderDAL.GetList(branchID);
        }


        public bool SaveSIHeader(SIHeader newItem)
        {

            return siheaderDAL.Save(newItem);

        }

        public bool DeleteSIHeader(SIHeader item)
        {
            return siheaderDAL.Delete(item);
        }

        public SIHeader GetSIHeader(SIHeader item)
        {
            return (SIHeader)siheaderDAL.GetItem<SIHeader>(item);
        }

    }
}
