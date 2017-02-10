using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetStock.Contract
{
    public class DashboardReport
    {

        public List<string> Months { get; set; }

        public List<DashboardReportData> lstDashboardData { get; set; }

        public MonthlyFiguresDashboard monthlyFiguresDashboard { get; set; }

        public DashboardReport()
        {
            lstDashboardData = new List<DashboardReportData>();
            Months = new List<string>();
        }
    }

    public class DashboardReportData
    {
        public string ItemName { get; set; }

        public List<Int32> ItemData { get; set; }

    }

    public class MonthlyFiguresDashboard
    {
        public int TotalPO { get; set; }

        public int TotalSales { get; set; }

        public int TotalGoodsIssue { get; set; }

        public int TotalGoodsReceive { get; set; }

    
    }
}
