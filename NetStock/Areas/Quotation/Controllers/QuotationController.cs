using NetStock.Contract;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NetStock.ActionFilters;

namespace NetStock.Areas.Quotation.Controllers
{
    [Authorize]
    [RouteArea("Quotation")]
    [SessionFilter]
    public class QuotationController : Controller
    {
        // GET: Quotation/Quotation
        public ActionResult Index()
        {
            return View();
        }


        #region Standard Quotation



        [Route("StandardRateProfile")]
        [HttpGet]
        public ActionResult StandardRateProfile(string quotationNo)
        {

            var quotation = new NetStock.Contract.Quotation();
            quotation.QuotationNo = string.Format("STANDARD_{0}", Utility.SsnBranch.ToString()); ;
            quotation.CustomerCode = "NONE";
            quotation.EffectiveDate = DateTime.Today.Date;
            quotation.ExpiryDate = DateTime.Today.Date;
            quotation.QuotationDate = DateTime.Today.Date;


            quotation = new NetStock.BusinessFactory.QuotationBO().GetQuotation(new Contract.Quotation { QuotationNo = string.Format("STANDARD_{0}", Utility.SsnBranch.ToString()) });

            if (quotation == null)
            {
                quotation = new NetStock.Contract.Quotation();
                quotation.QuotationNo = quotationNo;
                quotation.CustomerCode = "NONE";
                quotation.EffectiveDate = DateTime.Today.Date;
                quotation.ExpiryDate = DateTime.Today.Date;
                quotation.QuotationDate = DateTime.Today.Date;
                quotation.QuotationItems = new List<Contract.QuotationItem>();
            }

            quotation.ProductsList = Utility.GetProductList();

            quotation.CurrencyCodeList = Utility.GetCurrencyItemList();
            

            return View("StandardQuotation", quotation);
        }



        [Route("AddQuotationProduct")]
        [HttpPost]
        public ActionResult AddQuotationProduct(string barCode, decimal sellRate)
        {
            NetStock.Contract.QuotationItem qitem = new Contract.QuotationItem();

            string Message = string.Empty;
            var searchStatus = false;

            //var product = new NetStock.BusinessFactory.ProductBO().GetProductByBarCodeOrDescription(new Contract.Product { BarCode = barCode, Description = barCode });
            var product = new NetStock.BusinessFactory.ProductBO().GetProduct(new Contract.Product { ProductCode = barCode, Description = barCode });
            if (product != null)
            {
                qitem.ProductCode = product.ProductCode;
                qitem.ProductDescription = product.Description;
                qitem.BarCode = product.BarCode;
                qitem.SellRate = sellRate;
                qitem.ItemID = 0;
                qitem.RecordStatus = 1;
                qitem.Status = true;
                qitem.CreatedBy = Utility.DEFAULTUSER;
                qitem.ModifiedBy = Utility.DEFAULTUSER;

                Message = "Success";
            }
            else
            {
                Message = "Invalid Product Code";
            }

            


            //return Json(new { Message = Message, OrderDetail = orderDetail }, JsonRequestBehavior.AllowGet);

            return this.Json(new { Message = Message, QuotationItem = qitem }, JsonRequestBehavior.AllowGet);
        }

        


        [Route("SaveStandardRateProfile")]
        [HttpPost]
        public ActionResult SaveStandardRateProfile(NetStock.Contract.Quotation quotation )
        {
            try
            {
                var format = "dd/MM/yyyy"; // your datetime format
                var dateTimeConverter = new IsoDateTimeConverter { DateTimeFormat = format };

                 

                quotation.Status = true;
                quotation.QuotationNo = string.Format("STANDARD_{0}", Utility.SsnBranch.ToString());
                quotation.CreatedBy = Utility.DEFAULTUSER;
                quotation.ModifiedBy = Utility.DEFAULTUSER;
                quotation.QuotationType = Utility.CUSTOMERQUOTATION;
                quotation.BranchID = Utility.SsnBranch;
                //quotation.QuotationItems = quotation.QuotationItems.Where(x => x.RecordStatus != 3).ToList();
                var result = new NetStock.BusinessFactory.QuotationBO().SaveQuotation(quotation);

                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = "Quotation saved successfully";
                else
                    TempData["resultMessage"] = "Unable to Save the Record!";
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("StandardRateProfile", new { quotationNo = quotation.QuotationNo });
        }



        [Route("EditQuotationItem")]
        [HttpGet]
        public ActionResult EditQuotationitem(string quotationNo, int? itemID)
        {
            NetStock.Contract.QuotationItem quotationItem = null;

            if (quotationNo == string.Empty || quotationNo == null)
            {
                quotationItem = new NetStock.Contract.QuotationItem();
            }



            quotationItem.ProductsList = NetStock.Utility.GetProductList();

            return PartialView("AddQuotationItem", quotationItem);

        }

        //[Route("EditQuotationItem")]
        //[HttpPost]
        //public ActionResult EditQuotationitem(NetStock.Contract.QuotationItem item)
        //{
        //    NetStock.Contract.Quotation quotation;

        //    if (item.QuotationNo == "STANDARD")
        //    {
        //        quotation = (NetStock.Contract.Quotation)HttpContext.Session["StdQuotationItems"];

        //    }
        //    else
        //    {
        //        quotation = (NetStock.Contract.Quotation)HttpContext.Session["QuotationItems"];
        //    }
        //    item.CreatedBy = Utility.DEFAULTUSER;
        //    item.ModifiedBy = Utility.DEFAULTUSER;
        //    item.Status = true;


        //    if (quotation.QuotationItems.Count == 0)
        //    {
        //        item.ItemID = 1;
        //        quotation.QuotationItems.Add(item);
        //    }
        //    else
        //    {

        //        var nextItem = quotation.QuotationItems.Max(pr => pr.ItemID);


        //        if (quotation.QuotationItems.Where(pr => pr.ProductCode == item.ProductCode).Count() > 0)
        //        {

        //            quotation.QuotationItems.Where(pr => pr.ItemID == item.ItemID)
        //                                     .Update(pr =>
        //                                     {
        //                                         pr.SellRate = item.SellRate;

        //                                     });
        //        }
        //        else
        //        {
        //            item.ItemID = (short)(nextItem + 1);
        //            quotation.QuotationItems.Add(item);
        //        }
        //    }



        //    return Json(new { success = true });

        //}


        #endregion

        #region Customer Quotation

        [Route("CustomerQuotationList")]
        public ActionResult CustomerQuotationList()
        {

            var lstQuotation = new NetStock.BusinessFactory.QuotationBO()
                                                           .GetList()
                                                           .Where(q => !q.QuotationNo.Contains("STANDARD") && 
                                                                       q.QuotationType == Utility.CUSTOMERQUOTATION && 
                                                                       q.Status==true).ToList();


            return View("CustomerQuotationList", lstQuotation);
            //return View(Customers);
        }

        [Route("EditCustomerQuotation")]
        [HttpGet]
        public ActionResult EditCustomerQuotation(string quotationNo)
        {

            NetStock.Contract.Quotation quotation = null;



            if (quotationNo == "NEW")
            {
                quotation = new Contract.Quotation();
                quotation.QuotationDate = quotation.EffectiveDate = quotation.ExpiryDate = DateTime.Now;
                quotation.QuotationItems = new List<Contract.QuotationItem>();
                quotation.Status = true;

            }
            else
            {
                var quotationBO = new NetStock.BusinessFactory.QuotationBO();

                quotation = quotationBO.GetQuotation(new Contract.Quotation { QuotationNo = quotationNo });

                if (quotation == null)
                {
                    quotation = new Contract.Quotation();
                    quotation.QuotationDate = quotation.EffectiveDate = quotation.ExpiryDate = DateTime.Now;
                    quotation.QuotationItems = new List<Contract.QuotationItem>();

                }

            }

            quotation.CustomersList = Utility.GetCustomerList(false);
            quotation.ProductsList = Utility.GetProductList();
            quotation.CurrencyCodeList = Utility.GetCurrencyItemList();

            return View("CustomerQuotation", quotation);
            //return View(Suppliers);
        }

        [Route("SaveCustomerQuotation")]
        [HttpPost]
        public ActionResult SaveCustomerQuotation(NetStock.Contract.Quotation quotation)
        {
            var message = string.Empty;
            var result = false;


            try
            {
                 
                quotation.Status = true;
                quotation.CreatedBy = Utility.DEFAULTUSER;
                quotation.ModifiedBy = Utility.DEFAULTUSER;
                quotation.QuotationType = Utility.CUSTOMERQUOTATION;
                quotation.BranchID = Utility.SsnBranch;

                result = new NetStock.BusinessFactory.QuotationBO().SaveQuotation(quotation);

                if (result)
                {
                    message = string.Format("Quotation {0} saved successfully  ", quotation.QuotationNo);
                }
                else
                {
                    message = "Unable to Save Quotation";
                }

                TempData["isSaved"] = true;
                TempData["resultMessage"] = message; 
            }
            catch (Exception ex)
            {
                message = string.Format("Unable to Save Quotation. Error Code : {0} ", ex.Message);
                TempData["isSaved"] = false;
                TempData["resultMessage"] = message;
            }

            return RedirectToAction("CustomerQuotationList");

        }



        [Route("DeleteCustomerQuotation")]
        [HttpGet]
        public ActionResult DeleteCustomerQuotation(string quotationNo)
        {
            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.QuotationBO().DeleteQuotation(new NetStock.Contract.Quotation { QuotationNo = quotationNo, ModifiedBy = Utility.DEFAULTUSER });

                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = string.Format("quotation No [{0}] Deleted Successfully", quotationNo);
                else
                    TempData["resultMessage"] = "Unable to DELETE the Record!";
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }           


            return RedirectToAction("CustomerQuotationList");
        }



        #endregion


        #region Supplier Quotation

        [Route("SupplierQuotationList")]
        public ActionResult SupplierQuotationList()
        {

            var lstQuotation = new NetStock.BusinessFactory.QuotationBO()
                                                           .GetList()
                                                           .Where(q => !q.QuotationNo.Contains("STANDARD") && 
                                                                       q.QuotationType == Utility.SUPPLIERQUOTATION && 
                                                                       q.Status==true).ToList();


            return View("SupplierQuotationList", lstQuotation);
            //return View(Customers);
        }

        [Route("EditSupplierQuotation")]
        [HttpGet]
        public ActionResult EditSupplierQuotation(string quotationNo)
        {

            NetStock.Contract.Quotation quotation = null;



            if (quotationNo == "NEW")
            {
                quotation = new Contract.Quotation();
                quotation.QuotationDate = quotation.EffectiveDate = quotation.ExpiryDate = DateTime.Now;
                quotation.QuotationItems = new List<Contract.QuotationItem>();
                quotation.Status = true;

            }
            else
            {
                var quotationBO = new NetStock.BusinessFactory.QuotationBO();

                quotation = quotationBO.GetQuotation(new Contract.Quotation { QuotationNo = quotationNo });

                if (quotation == null)
                {
                    quotation = new Contract.Quotation();
                    quotation.QuotationDate = quotation.EffectiveDate = quotation.ExpiryDate = DateTime.Now;
                    quotation.QuotationItems = new List<Contract.QuotationItem>();

                }

            }

            quotation.CustomersList = Utility.GetCustomerList(true);
            quotation.ProductsList = Utility.GetProductList();
            quotation.CurrencyCodeList = Utility.GetCurrencyItemList();

            return View("SupplierQuotation", quotation);
            //return View(Suppliers);
        }

        [Route("SaveSupplierQuotation")]
        [HttpPost]
        public ActionResult SaveSupplierQuotation(NetStock.Contract.Quotation quotation)
        {

            var message = string.Empty;
            var result = false;

            try
            {
                
                quotation.Status = true;
                quotation.CreatedBy = Utility.DEFAULTUSER;
                quotation.ModifiedBy = Utility.DEFAULTUSER;
                quotation.QuotationType = Utility.SUPPLIERQUOTATION;
                quotation.BranchID = Utility.SsnBranch;

                result = new NetStock.BusinessFactory.QuotationBO().SaveQuotation(quotation);

                if (result)
                {
                    message = string.Format("Quotation {0} saved successfully  ", quotation.QuotationNo);
                }
                else
                {
                    message = "Unable to Save Quotation";
                }

                TempData["isSaved"] = result;
                TempData["resultMessage"] = message;
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("SupplierQuotationList");

        }

        #endregion


        [Route("DeleteSupplierQuotation")]
        [HttpGet]
        public ActionResult DeleteSupplierQuotation(string quotationNo)
        {
            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.QuotationBO().DeleteQuotation(new NetStock.Contract.Quotation { QuotationNo = quotationNo, ModifiedBy = Utility.DEFAULTUSER });
                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = string.Format("Supplier Quotation [{0}] Deleted Successfully", quotationNo);
                else
                    TempData["resultMessage"] = "Unable to DELETE the Record!";
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("SupplierQuotationList");

       }

    }
}