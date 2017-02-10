using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class SystemWideConfigurationBO
    {
        private SystemWideConfigurationDAL   systemwideconfigurationDAL;
        public SystemWideConfigurationBO() {

            systemwideconfigurationDAL = new SystemWideConfigurationDAL();
        }

        public List<SystemWideConfiguration> GetList()
        {
            return systemwideconfigurationDAL.GetList();
        }


        public bool SaveSystemWideConfiguration(SystemWideConfiguration newItem)
        {

            return systemwideconfigurationDAL.Save(newItem);

        }

        public bool DeleteSystemWideConfiguration(SystemWideConfiguration item)
        {
            return systemwideconfigurationDAL.Delete(item);
        }

        public SystemWideConfiguration GetSystemWideConfiguration(SystemWideConfiguration item)
        {
            return (SystemWideConfiguration)systemwideconfigurationDAL.GetItem<SystemWideConfiguration>(item);
        }

    }
}
