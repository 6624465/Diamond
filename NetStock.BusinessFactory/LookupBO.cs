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
    public class LookupBO
    {
        private LookUpDAL lookupDAL;
        public LookupBO()
        {

            lookupDAL = new LookUpDAL();
        }

        public List<Lookup> GetList()
        {
            return lookupDAL.GetList();
        }


        public bool SaveLookup(Lookup newItem)
        {

            return lookupDAL.Save(newItem);

        }

        public bool DeleteLookup(Lookup item)
        {
            return lookupDAL.Delete(item);
        }

        public Lookup GetLookup(Lookup item)
        {
            return (Lookup)lookupDAL.GetItem<Lookup>(item);
        }

    }
}
