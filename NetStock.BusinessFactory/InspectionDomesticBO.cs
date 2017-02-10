using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class InspectionDomesticBO
    {
        private InspectionDomesticDAL   inspectiondomesticDAL;
        public InspectionDomesticBO() {

            inspectiondomesticDAL = new InspectionDomesticDAL();
        }

        public List<InspectionDomestic> GetList(string documentNo, string poNo,string productCode)
        {
            return inspectiondomesticDAL.GetList(documentNo, poNo, productCode);
        }




        public bool SaveInspectionDomesticList(List<InspectionDomestic> inspectionDomesticItems)
        {
            return inspectiondomesticDAL.SaveList(inspectionDomesticItems, null);


        }

        public bool SaveInspectionDomestic(InspectionDomestic newItem)
        {

            return inspectiondomesticDAL.Save(newItem);

        }

        public bool DeleteInspectionDomestic(InspectionDomestic item)
        {
            return inspectiondomesticDAL.Delete(item);
        }

       


        public InspectionDomestic GetInspectionDomestic(InspectionDomestic item)
        {
            return (InspectionDomestic)inspectiondomesticDAL.GetItem<InspectionDomestic>(item);
        }

    }
}
