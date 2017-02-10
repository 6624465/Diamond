using NetStock.Contract;
using NetStock.DataFactory;
using System.Collections.Generic;


namespace NetStock.BusinessFactory
{
    public class DashBoardBO
    {
        private DashBoardDAL dashboardDAL;
        public DashBoardBO()
        {

            dashboardDAL = new DashBoardDAL();
        }

        public MonthlyFiguresDashboard GetMonthlyFigures()
        {
            return dashboardDAL.GetMonthlyFigures();
        }
    }
}
