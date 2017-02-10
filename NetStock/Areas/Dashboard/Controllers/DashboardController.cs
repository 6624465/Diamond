using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NetStock.ActionFilters;

namespace NetStock.Areas.Dashboard.Controllers
{
    [RouteArea("Dashboard")]
    [SessionFilter]
    public class DashboardController : Controller
    {

        [HttpGet]
        [Route("Index")]
        public ActionResult Index()
        {
            var graphdatagoodsIssue = new NetStock.Contract.DashboardReportData();

            List<Int32> lstDataIssue = new NetStock.BusinessFactory.GoodsIssueBO().GetDashboardData();

            graphdatagoodsIssue.ItemName = "Goods Issue";
            graphdatagoodsIssue.ItemData = lstDataIssue;


            var graphdatagoodsReceive = new NetStock.Contract.DashboardReportData();

            List<Int32> lstDataReceive = new NetStock.BusinessFactory.GoodsReceiveHeaderBO().GetDashboardData();

            graphdatagoodsReceive.ItemName = "Goods Receive";
            graphdatagoodsReceive.ItemData = lstDataReceive;


            var dashboarddata = new NetStock.Contract.DashboardReport();

            dashboarddata.lstDashboardData.Add(graphdatagoodsIssue);
            dashboarddata.lstDashboardData.Add(graphdatagoodsReceive);

            dashboarddata.Months = MonthNames(-5);

            var monthlyFiguresDashboard = new NetStock.Contract.MonthlyFiguresDashboard();
            monthlyFiguresDashboard = new NetStock.BusinessFactory.DashBoardBO().GetMonthlyFigures();
            dashboarddata.monthlyFiguresDashboard = monthlyFiguresDashboard;

            return View(dashboarddata);
        }

        public List<string> MonthNames(int a)
        {
            DateTime date1;
            DateTime date2;

            date1 = DateTime.Now.AddMonths(a);
            date2 = DateTime.Now;

            var monthList = new List<string>();

            while (date1 <= date2)
            {
                monthList.Add(date1.ToString("MMM"));
                date1 = date1.AddMonths(1);
            }

            return monthList;
        }


    }
}