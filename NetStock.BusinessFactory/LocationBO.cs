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
    public class LocationBO
    {
        private LocationDAL LocationDAL;
        public LocationBO()
        {

            LocationDAL = new LocationDAL();
        }

        public List<Location> GetList()
        {
            return LocationDAL.GetList();
        }


        public bool SaveLocation(Location newItem)
        {

            return LocationDAL.Save(newItem);

        }

        public bool DeleteLocation(Location item)
        {
            return LocationDAL.Delete(item);
        }

        public Location GetLocation(Location item)
        {
            return (Location)LocationDAL.GetItem<Location>(item);
        }

    }
}
