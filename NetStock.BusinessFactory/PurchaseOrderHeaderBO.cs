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
    public class PurchaseOrderHeaderBO
    {
        private PurchaseOrderHeaderDAL purchaseorderHeaderDAL;
        public PurchaseOrderHeaderBO()
        {

            purchaseorderHeaderDAL = new PurchaseOrderHeaderDAL();
        }

        public List<PurchaseOrderHeader> GetList(short branchID)
        {
            return purchaseorderHeaderDAL.GetList(branchID);
        }

        public List<PurchaseOrderHeader> GetPurchaseOrderBySupplier(string supplierCode)
        {
            return purchaseorderHeaderDAL.GetPurchaseOrderBySupplier(supplierCode);
        }


        public bool SavePurchaseOrderHeader(PurchaseOrderHeader newItem)
        {

            return purchaseorderHeaderDAL.Save(newItem);

        }

        public bool DeletePurchaseOrderHeader(PurchaseOrderHeader item)
        {
            return purchaseorderHeaderDAL.Delete(item);
        }

        public PurchaseOrderHeader GetPurchaseOrderHeader(PurchaseOrderHeader item)
        {
            return (PurchaseOrderHeader)purchaseorderHeaderDAL.GetItem<PurchaseOrderHeader>(item);
        }

    }
}
