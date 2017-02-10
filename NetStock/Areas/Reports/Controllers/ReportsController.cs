using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NetStock.Areas.Reports.Controllers
{
    [Authorize]
    [RouteArea("Reports")]
    [ActionFilters.SessionFilter]
    public class ReportsController : Controller
    {
        // GET: Reports/Report
        public ActionResult Index()
        {
            return View("~/Views/Shared/Index.cshtml");
        }



        [Route("ViewReport")]
        public ActionResult ViewReport(string DocumentId, string Url)
        {
            ViewBag.DocumentId = DocumentId;
            ViewBag.Url = Url;
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }

        [Route("OrderInvoiceReport")]
        public ActionResult OrderInvoiceReport(string orderNo, string Url)
        {
            var invoiceNo = new NetStock.BusinessFactory.InvoiceHeaderBO().GetInvoiceNoByOrderNo(orderNo);
            ViewBag.BranchID = "";
            ViewBag.CustomerCode = "";
            ViewBag.DateFrom = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.DateTo = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.ReportSource = "InvoiceReport";
            ViewBag.InvoiceNo = invoiceNo;
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }


        [Route("PurchaseOrderReport")]
        public ActionResult PurchaseOrderReport(string branchID, string poNo, string Url)
        {

            ViewBag.BranchID = branchID;
            ViewBag.CustomerCode = "";
            ViewBag.DateFrom = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.DateTo = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.ReportSource = "PurchaseOrderReport";
            ViewBag.InvoiceNo = "";
            ViewBag.DocumentNo = poNo;
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }

        [Route("QuotationReport")]
        public ActionResult QuotationReport(string quotationNo, string Url)
        {

            ViewBag.BranchID = "";
            ViewBag.CustomerCode = "";
            ViewBag.DateFrom = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.DateTo = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.ReportSource = "QuotationReport";
            ViewBag.InvoiceNo = "";
            ViewBag.DocumentNo = quotationNo;
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }



        [Route("InvoiceReport")]
        public ActionResult InvoiceReport(string invoiceNo, string Url)
        {
            ViewBag.BranchID = "";
            ViewBag.CustomerCode = "";
            //ViewBag.DateFrom = dateFrom.ToString("yyyy-MM-dd");
            //ViewBag.DateTo = dateTo.ToString("yyyy-MM-dd");
            ViewBag.DateFrom = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.DateTo = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.ReportSource = "InvoiceReport";
            ViewBag.InvoiceNo = invoiceNo;
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);

            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }

        [Route("ProductStockHistory")]
        public ActionResult ProductStockHistory(string productCode, string Url)
        {
            ViewBag.BranchID = "";
            ViewBag.CustomerCode = "";
            ViewBag.DateFrom = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.DateTo = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.ReportSource = "ProductStockHistory";
            ViewBag.InvoiceNo = productCode;
            ViewBag.Url = string.Format("{0}{1}",Utility.REPORTSUBFOLDER, Url);

            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }

        [Route("ViewReportDailySales")]
        public ActionResult ViewReportDailySales( string customerCode, string dateFrom, string dateTo, string Url )
        {
            ViewBag.BranchID = "";
            ViewBag.CustomerCode = customerCode.Length==0?null:customerCode;
            //ViewBag.DateFrom = dateFrom.ToString("yyyy-MM-dd");
            //ViewBag.DateTo = dateTo.ToString("yyyy-MM-dd");
            ViewBag.DateFrom = dateFrom ;
            ViewBag.DateTo = dateTo ;
            ViewBag.ReportSource = "DailySalesReport";
            ViewBag.InvoiceNo = "";
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }


        [Route("ViewProfitAndLossReport")]
        public ActionResult ViewProfitAndLossReport(string dateFrom, string dateTo, string Url)
        {
            ViewBag.BranchID = "";
            ViewBag.DateFrom = dateFrom;
            ViewBag.DateTo = dateTo;
            ViewBag.ReportSource = "ProfitAndLossReport";
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }

        [Route("ViewStockPlan")]
        public ActionResult ViewStockPlan(string dateFrom, string dateTo, string Url)
        {
            ViewBag.BranchID = "";
            ViewBag.DateFrom = dateFrom.Replace("-", "/");  
            ViewBag.DateTo = dateTo.Replace("-", "/");  
            ViewBag.CustomerCode = "";
            ViewBag.DocumentNo = "";
            ViewBag.InvoiceNo = "";
            ViewBag.ReportSource = "StockPlan";
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }

        [Route("ViewShipmentSchedule")]
        public ActionResult ViewShipmentSchedule(string documentNo, string dateFrom, string dateTo, string Url)
        {
            ViewBag.BranchID = "";
            ViewBag.DateFrom = dateFrom.Replace("-", "/");
            ViewBag.DateTo = dateTo.Replace("-", "/");
            ViewBag.DocumentNo = documentNo;
            ViewBag.ReportSource = "ShipmentScheduleList";
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }

        [Route("ViewShipmentIndent")]
        public ActionResult ViewShipmentIndent(string documentNo, string dateFrom, string dateTo, string Url)
        {
            ViewBag.BranchID = "";
            ViewBag.DateFrom = dateFrom.Replace("-", "/");
            ViewBag.DateTo = dateTo.Replace("-", "/");
            ViewBag.DocumentNo = documentNo.Trim().Length == 0 ? "" : documentNo.Trim();
            ViewBag.ReportSource = "ShipmentIndentList";
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }



        [Route("ViewGF1")]
        public ActionResult ViewGF1(string documentNo, string dateFrom, string dateTo, string Url)
        {
            ViewBag.BranchID = "";
            ViewBag.DocumentNo = documentNo;
            ViewBag.DateFrom = dateFrom.Replace("-","/");
            ViewBag.DateTo = dateTo.Replace("-", "/");
            ViewBag.ReportSource = "GoodsReceiveDomesticDetails";
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }


        [Route("ViewGF2")]
        public ActionResult ViewGF2(string documentNo, string dateFrom, string dateTo, string Url)
        {
            ViewBag.BranchID = ""; 
            ViewBag.DocumentNo = documentNo;
            ViewBag.DateFrom = dateFrom.Replace("-","/");
            ViewBag.DateTo = dateTo.Replace("-", "/");
            ViewBag.ReportSource = "GoodsReceiveOverseasDetails";
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }

        [Route("ViewCheckSheet")]
        public ActionResult ViewCheckSheet(string documentNo, string dateFrom, string dateTo, string Url)
        {
            ViewBag.BranchID = ""; 
            ViewBag.DocumentNo = documentNo;
            ViewBag.DateFrom = dateFrom.Replace("-","/");
            ViewBag.DateTo = dateTo.Replace("-", "/");
            ViewBag.ReportSource = "InspectionDomestic";
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }

        [Route("ViewInspection")]
        public ActionResult ViewInspection(string documentNo, string dateFrom, string dateTo, string Url)
        {
            ViewBag.BranchID = ""; 
            ViewBag.DocumentNo = documentNo;
            ViewBag.DateFrom = dateFrom.Replace("-","/");
            ViewBag.DateTo = dateTo.Replace("-", "/");
            ViewBag.ReportSource = "InspectionOverseas";
            ViewBag.Url = string.Format("{0}{1}", Utility.REPORTSUBFOLDER, Url);
            var path = "~/Areas/Reports/Views/Shared/_ReportViewerPartial.cshtml";
            return PartialView(path);
        }


          


        [Route("DailySalesReport")]
        public ActionResult DailySalesReport()
        {
            var reportparam = new NetStock.Contract.ReportParam();
            reportparam.DateFrom = DateTime.Now.Date;
            reportparam.DateTo = DateTime.Now.Date;
            reportparam.CustomersList = Utility.GetCustomerList(false);


            //return View("~/Areas/Reports/Views/Report/DailySalesReport.cshtml", reportparam);
            return View("DailySalesReport", reportparam);
        }

        [Route("ProfitAndLossReport")]
        public ActionResult ProfitAndLossReport()
        {
            var reportparam = new NetStock.Contract.ReportParam();
            reportparam.CustomersList = Utility.GetCustomerList(false);
            reportparam.ProductList = Utility.GetProductList();
            reportparam.ProductCategoryList = Utility.GetLookupItemList("PRODUCTCATEGORY");
            reportparam.DateFrom = DateTime.Now.Date;
            reportparam.DateTo = DateTime.Now.Date;


            return View("ProfitAndLossReport", reportparam);
        }

        [Route("ShipmentIndent")]
        public ActionResult ShipmentIndent()
        {
            var reportparam = new NetStock.Contract.ReportParam();
             
            reportparam.DateFrom = DateTime.Now.Date;
            reportparam.DateTo = DateTime.Now.Date;


            return View("ShipmentIndentReport", reportparam);
        }

        [Route("ShipmentSchedule")]
        public ActionResult ShipmentSchedule()
        {
            var reportparam = new NetStock.Contract.ReportParam();
             
            reportparam.DateFrom = DateTime.Now.Date;
            reportparam.DateTo = DateTime.Now.Date;
            reportparam.CustomersList = Utility.GetCustomerList(false);


            return View("ShipmentScheduleReport", reportparam);
        }


        [Route("StockPlan")]
        public ActionResult StockPlan()
        {
            var reportparam = new NetStock.Contract.ReportParam();
             
            reportparam.DateFrom = DateTime.Now.Date;
            reportparam.DateTo = DateTime.Now.Date;


            return View("StockPlanReport", reportparam);
        }



    }
}