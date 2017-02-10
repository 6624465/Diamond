using NetStock.Contract;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using NetStock.ActionFilters;

namespace NetStock.Areas.Billing.Controllers
{
    [Authorize]
    [RouteArea("Billing")]
    [SessionFilter]
    public class BillingController : Controller
    {
        // GET: Billing/Billing
        public ActionResult Index()
        {
            return View();
        }

        [Route("InvoiceEntry")]
        public ActionResult InvoiceEntry()
        {
            var invoice = new NetStock.Contract.InvoiceHeader();
            return View("InvoiceEntry", invoice);
            
        }

        [Route("InvoiceEntry")]
        [HttpGet]
        public ActionResult InvoiceEntry(string invoiceNo)
        {
            NetStock.Contract.InvoiceHeader invoiceheader = new Contract.InvoiceHeader();

            if (invoiceNo == "NEW")
                invoiceNo = "";

            if (invoiceNo != null && invoiceNo.Length > 0)
            {
                invoiceheader = new NetStock.BusinessFactory.InvoiceHeaderBO().GetInvoiceHeader(new Contract.InvoiceHeader { InvoiceNo= invoiceNo });


                if (invoiceheader.InvoiceDetails == null)
                {
                    invoiceheader.InvoiceDetails = new List<Contract.InvoiceDetail>();
                }

            }
            else
            {
                invoiceheader.InvoiceNo = invoiceNo;
                invoiceheader.InvoiceDate = DateTime.Today.Date;
                invoiceheader.InvoiceDetails = new List<Contract.InvoiceDetail>();

            }
            invoiceheader.CustomersList = Utility.GetCustomerList(false);

            return View("InvoiceEntry", invoiceheader);
            //return View(Products);
        }

        [Route("InvoiceApproval")]
        [HttpGet]
        public ActionResult InvoiceApproval()
        {
            var unbilledHeader = new NetStock.Contract.UnbilledHeader();
            unbilledHeader.CustomersList = Utility.GetCustomerList(false);
            unbilledHeader.InvoiceTypeList = Utility.GetLookupItemList("INVOICETYPE");
            unbilledHeader.DateFrom = DateTime.UtcNow.ThaiTime();
            unbilledHeader.DateTo = DateTime.UtcNow.ThaiTime();
            unbilledHeader.OverDue = false;
            unbilledHeader.PaymentDays = 0;
            unbilledHeader.lstDetails = new List<Contract.UnbilledDetail>();



            return View("InvoiceApproval", unbilledHeader);
            //return View(Products);
        }

        [Route("InvoiceApproval")]
        [HttpPost]
        public ActionResult InvoiceApproval(NetStock.Contract.UnbilledHeader item)
        {
            var unbilledHeader = new NetStock.Contract.UnbilledHeader();
            unbilledHeader.CustomersList = Utility.GetCustomerList(false);
            unbilledHeader.InvoiceTypeList = Utility.GetLookupItemList("INVOICETYPE");
            unbilledHeader.CustomerCode = item.CustomerCode == "ALL" ? null : item.CustomerCode;
            unbilledHeader.DateFrom = item.DateFrom;
            unbilledHeader.DateTo = item.DateTo;
            unbilledHeader.OverDue = true;
            unbilledHeader.PaymentDays = item.PaymentDays;

            item.OverDue = true;
            unbilledHeader.lstDetails = new NetStock.BusinessFactory.InvoiceHeaderBO().GetUnApprovedInvoices(item);


            return View("InvoiceApproval", unbilledHeader);
            //return View(Products);
        }

        [Route("ProcessApproval")]
        [HttpGet]
        public ActionResult ProcessApproval(string customerCode)
        {
            //var unbilledHeader = new NetStock.Contract.UnbilledHeader();
            //unbilledHeader.CustomersList = Utility.GetCustomerList(false);
            //unbilledHeader.InvoiceTypeList = Utility.GetLookupItemList("INVOICETYPE");
            //unbilledHeader.DateFrom = DateTime.Today.Date;
            //unbilledHeader.DateTo = DateTime.Today.Date;
            //unbilledHeader.OverDue = false;
            //unbilledHeader.PaymentDays = 0;





            return View("OverDueInvoices");
            //return View(Products);
        }

        [Route("SendInvoiceApproval")]
        public JsonResult SendInvoiceApproval(string htmlTableValue)
        {


            var message = string.Empty;
            var format = "dd-MM-yyyy"; // your datetime format
            var dateTimeConverter = new IsoDateTimeConverter { DateTimeFormat = format };
            List<UnbilledDetail> myDeserializedObjList = (List<UnbilledDetail>)JsonConvert.DeserializeObject(htmlTableValue, typeof(List<UnbilledDetail>), dateTimeConverter);

            var lstApprovedInvoices = myDeserializedObjList;

            lstApprovedInvoices.Where(dt=> dt.ApprovalStatus==null).Update(dt=> { dt.ApprovalStatus="" ;});

            //lstApprovedInvoices = myDeserializedObjList.Where(dt => dt.ApprovalStatus.Length > 0).ToList();

            if (lstApprovedInvoices==null || lstApprovedInvoices.Count==0)
            {
                message = "failure";
            }
            else { 

            var result = new NetStock.BusinessFactory.InvoiceHeaderBO().ApproveInvoice(lstApprovedInvoices, Utility.DEFAULTUSER);

            message = "Success";
            return Json(new { success = result, Message = message });
            
            }


            return Json(new { success = true, Message = message  }, JsonRequestBehavior.AllowGet);
            
        }

        [Route("UnbilledInvoices")]
        [HttpGet]
        public ActionResult UnbilledInvoices()
        {


            var unbilledHeader = new NetStock.Contract.UnbilledHeader();
            unbilledHeader.CustomersList = Utility.GetCustomerList(false);
            unbilledHeader.InvoiceTypeList = Utility.GetLookupItemList("PAYMENTTYPE");
            unbilledHeader.DateFrom = DateTime.UtcNow.ThaiTime();
            unbilledHeader.DateTo = DateTime.UtcNow.ThaiTime();
            unbilledHeader.OverDue = false;
            unbilledHeader.PaymentDays = 0;
            unbilledHeader.lstDetails = new List<Contract.UnbilledDetail>();



            return View("UnbilledInvoices", unbilledHeader);
            //return View(Products);
        }


        [Route("UnBilledInvoiceInquiry")]
        [HttpPost]
        public ActionResult UnBilledInvoiceInquiry(NetStock.Contract.UnbilledHeader item)
        {


            var unbilledHeader = new NetStock.Contract.UnbilledHeader();
            unbilledHeader.CustomersList = Utility.GetCustomerList(false);
            unbilledHeader.InvoiceTypeList = Utility.GetLookupItemList("PAYMENTTYPE");
            unbilledHeader.CustomerCode = item.CustomerCode;
            unbilledHeader.DateFrom = item.DateFrom;
            unbilledHeader.DateTo = item.DateTo;
            unbilledHeader.OverDue = item.OverDue;
            unbilledHeader.PaymentDays = item.PaymentDays;
            unbilledHeader.lstDetails = new NetStock.BusinessFactory.InvoiceHeaderBO().GetUnbilledOrders(item);



            return View("UnbilledInvoices", unbilledHeader);
            //return View(Products);
        }

        



        [Route("UnbilledInvoices")]
        [HttpPost]
        public ActionResult UnbilledInvoices(NetStock.Contract.UnbilledHeader item)
        {



            var unbilledHeader = new NetStock.Contract.UnbilledHeader();
            unbilledHeader.CustomersList = Utility.GetCustomerList(false);
            unbilledHeader.InvoiceTypeList = Utility.GetLookupItemList("INVOICETYPE");
            unbilledHeader.CustomerCode = item.CustomerCode;
            unbilledHeader.DateFrom = item.DateFrom;
            unbilledHeader.DateTo = item.DateTo;
            unbilledHeader.OverDue = item.OverDue;
            unbilledHeader.PaymentDays = item.PaymentDays;
            unbilledHeader.lstDetails = new NetStock.BusinessFactory.InvoiceHeaderBO().GetUnbilledOrders(item);



            return View("UnbilledInvoices", unbilledHeader);

        }


        [Route("InvoiceInquiry")]
        [HttpGet]
        public ActionResult InvoiceInquiry()
        {


            var unbilledHeader = new NetStock.Contract.UnbilledHeader();
            unbilledHeader.CustomersList = Utility.GetCustomerList(false);
            unbilledHeader.InvoiceTypeList = Utility.GetLookupItemList("INVOICETYPE");
            unbilledHeader.DateFrom = DateTime.Today.Date;
            unbilledHeader.DateTo = DateTime.Today.Date;
            unbilledHeader.OverDue = false;
            unbilledHeader.PaymentDays = 0;
            unbilledHeader.lstDetails = new List<Contract.UnbilledDetail>();



            return View("InvoiceInquiry", unbilledHeader);
            //return View(Products);
        }


        [Route("InvoiceInquiryResult")]
        [HttpPost]
        public ActionResult InvoiceInquiryResult(NetStock.Contract.UnbilledHeader item)
        {



            var unbilledHeader = new NetStock.Contract.UnbilledHeader();
            unbilledHeader.CustomersList = Utility.GetCustomerList(false);
            unbilledHeader.InvoiceTypeList = Utility.GetLookupItemList("INVOICETYPE");
            unbilledHeader.CustomerCode = item.CustomerCode == "ALL" ? null : item.CustomerCode;
            unbilledHeader.InvoiceType = item.InvoiceType == "ALL" ? null : item.InvoiceType;
            unbilledHeader.DateFrom = item.DateFrom;
            unbilledHeader.DateTo = item.DateTo;
            unbilledHeader.OverDue = item.OverDue;
            unbilledHeader.PaymentDays = item.PaymentDays;
            unbilledHeader.lstDetails = new NetStock.BusinessFactory.InvoiceHeaderBO().InvoiceInquiry(item);



            return View("InvoiceInquiry", unbilledHeader);

        }

        [Route("OverDueInvoices")]
        [HttpGet]
        public ActionResult OverDueInvoices()
        {



            return View("OverDueInvoices");
            //return View(Products);
        }




        [Route("InvoiceList")]
        [HttpGet]
        public ActionResult InvoiceList()
        {
            var lstInvoice = new NetStock.BusinessFactory.InvoiceHeaderBO().GetList();

            return View("InvoiceList", lstInvoice);


        }
    }
}