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
    public class PurchaseOrderDetailBO
    {
        private PurchaseOrderDetailDAL purchaseorderDetailDAL;
        public PurchaseOrderDetailBO()
        {

            purchaseorderDetailDAL = new PurchaseOrderDetailDAL();
        }

        public List<PurchaseOrderDetail> GetList()
        {
            return purchaseorderDetailDAL.GetList();
        }

        public List<PurchaseOrderDetail> GetList(string poNO)
        {
            return purchaseorderDetailDAL.GetList(poNO);
        }


        public bool SavePurchaseOrderDetail(PurchaseOrderDetail newItem)
        {

            return purchaseorderDetailDAL.Save(newItem);

        }

        public bool DeletePurchaseOrderDetail(PurchaseOrderDetail item)
        {
            return purchaseorderDetailDAL.Delete(item);
        }

        public PurchaseOrderDetail GetPurchaseOrderDetail(PurchaseOrderDetail item)
        {
            return (PurchaseOrderDetail)purchaseorderDetailDAL.GetItem<PurchaseOrderDetail>(item);
        }

        

    }
}
