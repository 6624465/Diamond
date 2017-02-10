using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;

namespace NetStock.BusinessFactory
{
    public class InspectionOverseasBO
    {
        private InspectionOverseasDAL   inspectionoverseasDAL;
        public InspectionOverseasBO() {

            inspectionoverseasDAL = new InspectionOverseasDAL();
        }

        public List<InspectionOverseas> GetList(string documentNo, string poNo)
        {
            return inspectionoverseasDAL.GetList(documentNo, poNo);
        }


        public bool SaveInspectionOverseas(InspectionOverseas newItem)
        {

            return inspectionoverseasDAL.Save(newItem);

        }

        public bool DeleteInspectionOverseas(InspectionOverseas item)
        {
            return inspectionoverseasDAL.Delete(item);
        }

        public InspectionOverseas GetInspectionOverseas(InspectionOverseas item)
        {
            return (InspectionOverseas)inspectionoverseasDAL.GetItem<InspectionOverseas>(item);
        }

    }
}
