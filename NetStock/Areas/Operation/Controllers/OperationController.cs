using NetStock.BusinessFactory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NetStock.Contract;
using NetStock.ActionFilters;
using System.ComponentModel;

namespace NetStock.Areas.Operation.Controllers
{
    [Authorize]
    [SessionFilter]
    [RouteArea("Operation")]
    public class OperationController : Controller
    {
        // GET: Operation/Operation
        public ActionResult Index()
        {
            return View();
        }



        #region Stock Adjustments


        [Route("StockAdjustments")]
        [HttpGet]
        public ActionResult StockAdjustments()
        {
            var lstStockAdjustments = new NetStock.BusinessFactory.StockAdjustmentHeaderBO().GetList();
            return View("StockAdjustmentList", lstStockAdjustments);

        }

        [Route("StockAdjustment")]
        [HttpGet]
        public ActionResult StockAdjustment(string documentNo)
        {

            NetStock.Contract.StockAdjustmentHeader stockadjustment = null;

            if (documentNo == "NEW")
            {
                stockadjustment = new NetStock.Contract.StockAdjustmentHeader();
                stockadjustment.StockAdjustmentDetails = new List<Contract.StockAdjustmentDetail>();
                stockadjustment.DocumentDate = DateTime.Today.Date;
                stockadjustment.CreatedBy = Utility.DEFAULTUSER;
                stockadjustment.ModifiedBy = Utility.DEFAULTUSER;
                stockadjustment.Status = Utility.DEFAULTSTATUS;

                //stockledger.StockInDetails = SampleDataForStockInLedgerDetails();
            }
            else
            {
                stockadjustment = new NetStock.BusinessFactory.StockAdjustmentHeaderBO().GetStockInHeader(new Contract.StockAdjustmentHeader { DocumentNo = documentNo });
                stockadjustment.DocumentNo = documentNo;

                if (stockadjustment.StockAdjustmentDetails == null)
                {
                    stockadjustment.StockAdjustmentDetails = new List<Contract.StockAdjustmentDetail>();
                }

            }

            stockadjustment.CustomersList = NetStock.Utility.GetCustomerList(true);
            stockadjustment.ProductList = NetStock.Utility.GetProductList();

            return View("StockAdjustment", stockadjustment);

        }


        [Route("SaveStockAdjustment")]
        [HttpPost]
        public JsonResult SaveStockAdjustment(NetStock.Contract.StockAdjustmentHeader stockheader)
        {
            var message = string.Empty;
            var result = false;
            try
            {
                stockheader.CreatedBy = Utility.DEFAULTUSER;
                stockheader.ModifiedBy = Utility.DEFAULTUSER;
                stockheader.CustomerCode = "";
                stockheader.CustomerName = "";

                var lstProducts = stockheader.StockAdjustmentDetails;
                result = new NetStock.BusinessFactory.StockAdjustmentHeaderBO().SaveStockInHeader(stockheader);
                if (result)
                {
                    message = string.Format("Stock-IN saved successfully. Transaction Reference No. {0}  ", stockheader.DocumentNo);
                }
                else
                {
                    message = "Unable to Save STOCK-IN. Please try again!";
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }

            return Json(new { success = result, Message = message, POData = stockheader });
        }


        [Route("AddStockAdjustmentProduct")]
        [HttpPost]
        public ActionResult AddStockAdjustmentProduct(string barCode, Int16 quantity = 1, string stockType = "ADD")
        {

            NetStock.Contract.StockAdjustmentDetail stockDetail = new Contract.StockAdjustmentDetail();


            //var productData = new NetStock.BusinessFactory.ProductBO().GetSupplierProductByBarCodeOrDescription(supplierCode,barCode,barCode);
            var productData = new NetStock.BusinessFactory.ProductBO().GetProductByBarCodeOrDescription(new NetStock.Contract.Product { ProductCode = barCode, Description = barCode, BarCode = barCode });



            if (productData != null)
            {
                stockDetail.BarCode = productData.BarCode;
                stockDetail.ProductCode = productData.ProductCode;
                stockDetail.ProductDescription = productData.Description;
                stockDetail.BarCode = productData.BarCode;
                stockDetail.Quantity = quantity;
                stockDetail.DocumentNo = "";
                stockDetail.StockType = stockType;

            }


            return Json(new { Message = "Data", StockAdjustmentDetail = stockDetail }, JsonRequestBehavior.AllowGet);
        }

        [Route("AddPurchaseOrderDetails")]
        [HttpPost]
        public ActionResult AddPurchaseOrderDetails(string productCode, string quantity, string pono, string itemCode, string uniPrice, string totalAmt, string productDescription)
        {
            var _quantity = Convert.ToInt32(quantity);
            var itemNo = Convert.ToInt16(itemCode);
            var _unitPrice = Convert.ToDecimal(uniPrice);
            var _totalAmouunt = Convert.ToDecimal(totalAmt);

            PurchaseOrderDetail PurchaseOrderDetail = new PurchaseOrderDetail();
            PurchaseOrderDetail.ProductCode = productCode;
            PurchaseOrderDetail.Quantity = _quantity;
            PurchaseOrderDetail.PONo = pono;
            //PurchaseOrderDetail.ItemNo = itemNo;
            PurchaseOrderDetail.UnitPrice = _unitPrice;
            //PurchaseOrderDetail.TotalAmount = _totalAmouunt;
            PurchaseOrderDetail.ProductDescription = productDescription;


            return Json(new { Message = "Success", PurchaseOrderDetail = PurchaseOrderDetail }, JsonRequestBehavior.AllowGet);
        }


        [Route("DeleteStockAdjustment")]
        [HttpPost]
        public JsonResult DeleteStockAdjustment(string documentNo)
        {
            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.StockAdjustmentHeaderBO().DeleteStockInHeader(new NetStock.Contract.StockAdjustmentHeader { DocumentNo = documentNo, ModifiedBy = Utility.DEFAULTUSER });

            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }

            return Json(new { result = result, Message = "Stock Entry deleted successfully.", documentNo = documentNo });



        }



        #endregion


        #region StockInquiry



        [Route("StockInquiry")]
        [HttpGet]
        public ActionResult StockInquiry()
        {
            var stockinquiryHd = new NetStock.Contract.StockInquiryHeader();
            stockinquiryHd.ProductList = Utility.GetProductList();
            stockinquiryHd.ProductLocationList = Utility.GetLookupItemList("LOCATION").ToList();
            //stockinquiryHd.ProductCategoryList = Utility.GetLookupItemList("PRODUCTCATEGORY").ToList();
            stockinquiryHd.ProductCategoryList = new NetStock.BusinessFactory.ProductCategoryBO()
                                                    .GetList()
                                                    .Select(x => new SelectListItem {
                                                        Value = x.CategoryCode,
                                                        Text = x.Description
                                                    }).ToList();
            stockinquiryHd.SupplierList = Utility.GetCustomerList(true);
            stockinquiryHd.StockInquiryDetails = new List<NetStock.Contract.StockInquiryDetail>();

            return View("StockInquiry", stockinquiryHd);
        }

        [Route("StockInquiryResult")]
        [HttpPost]
        public ActionResult StockInquiryResult(NetStock.Contract.StockInquiryHeader stockinquiryHeader)
        {
            var stockinquiryHd = new NetStock.Contract.StockInquiryHeader();

            stockinquiryHd.ProductCode = stockinquiryHeader.ProductCode;
            stockinquiryHd.ProductCategory = stockinquiryHeader.ProductCategory;
            stockinquiryHd.ProductLocation = stockinquiryHeader.ProductLocation;

            stockinquiryHd.ProductList = Utility.GetProductList();
            stockinquiryHd.ProductLocationList = Utility.GetLookupItemList("LOCATION");
            stockinquiryHd.ProductCategoryList = Utility.GetLookupItemList("PRODUCTCATEGORY");
            stockinquiryHd.SupplierList = Utility.GetCustomerList(true);
            stockinquiryHd.StockInquiryDetails = new NetStock.BusinessFactory.StockLedgerBO().StockInquiry(stockinquiryHeader.ProductCode, stockinquiryHeader.ProductCategory, stockinquiryHeader.ProductLocation, stockinquiryHeader.SupplierCode);                        

            return View("StockInquiry", stockinquiryHd);
        }

        [Route("StockInquiryProductResult")]
        [HttpPost]
        public JsonResult StockInquiryProductResult(string productCode)
        {
            var stockinquiryHd = new NetStock.Contract.StockInquiryHeader();
            var Message = "Success";

            stockinquiryHd.ProductCode = productCode;

            stockinquiryHd.StockInquiryDetails = new NetStock.BusinessFactory.StockLedgerBO().StockInquiry(productCode, null, null, null);

            if (stockinquiryHd.StockInquiryDetails.Count == 0)
            {
                Message = "Invalid Bar-Code!";
            }


            return Json(new { Message = Message, stockDt = stockinquiryHd.StockInquiryDetails }, JsonRequestBehavior.AllowGet);


        }



        [Route("StockInLedgerList")]
        [HttpGet]
        public ActionResult StockInLedgerList()
        {
            var lstStock = new NetStock.BusinessFactory.StockInHeaderBO().GetList().Where(sk => sk.Status == true).ToList();
            return View("StockInList", lstStock);

        }



        [Route("StockInLedger")]
        [HttpGet]
        public ActionResult StockInLedger(string documentNo)
        {

            NetStock.Contract.StockInHeader stockledger = null;

            if (documentNo == "NEW")
            {
                stockledger = new NetStock.Contract.StockInHeader();
                stockledger.StockInDetails = new List<Contract.StockInDetail>();
                stockledger.DocumentDate = DateTime.Today.Date;
                stockledger.CreatedBy = Utility.DEFAULTUSER;
                stockledger.ModifiedBy = Utility.DEFAULTUSER;
                stockledger.Status = Utility.DEFAULTSTATUS;

                //stockledger.StockInDetails = SampleDataForStockInLedgerDetails();
            }
            else
            {
                stockledger = new NetStock.BusinessFactory.StockInHeaderBO().GetStockInHeader(new Contract.StockInHeader { DocumentNo = documentNo });
                stockledger.DocumentNo = documentNo;

                if (stockledger.StockInDetails == null)
                {
                    stockledger.StockInDetails = new List<Contract.StockInDetail>();

                }
                else
                {

                    stockledger.TotalAmount = stockledger.StockInDetails.Sum(dt => dt.BuyingAmount);

                }

            }

            stockledger.CustomersList = NetStock.Utility.GetCustomerList(true);

            stockledger.POList = NetStock.Utility.GetPOList();

            return View("StockInEntry", stockledger);

        }


        private List<Contract.StockInDetail> SampleDataForStockInLedgerDetails()
        {

            var lstStockDetail = new List<Contract.StockInDetail>();

            lstStockDetail.Add(new Contract.StockInDetail { ProductCode = "567", BarCode = "567", ItemNo = 1, POQty = 10 });
            lstStockDetail.Add(new Contract.StockInDetail { ProductCode = "9991", BarCode = "9999", ItemNo = 2, POQty = 10 });

            return lstStockDetail;

        }



        [Route("SaveStockInLedger")]
        [HttpPost]
        public JsonResult SaveStockInLedger(NetStock.Contract.StockInHeader stockheader)
        {
            var message = string.Empty;
            var result = false;
            try
            {
                stockheader.CreatedBy = Utility.DEFAULTUSER;
                stockheader.ModifiedBy = Utility.DEFAULTUSER;

                var lstProducts = stockheader.StockInDetails;
                result = new NetStock.BusinessFactory.StockInHeaderBO().SaveStockInHeader(stockheader);
                if (result)
                {
                    message = string.Format("Stock-IN saved successfully. Transaction Reference No. {0}  ", stockheader.DocumentNo);
                }
                else
                {
                    message = "Unable to Save STOCK-IN. Please try again!";
                }
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }

            return Json(new { success = result, Message = message, POData = stockheader });
        }


        [Route("EditStockItem")]
        [HttpGet]
        public ActionResult EditStockItem(string documentNo, int? itemID)
        {

            var stockItem = new NetStock.Contract.StockInDetail();

            if (itemID != null && itemID > 0)
            {
                if (HttpContext.Session["StockItems"] != null)
                {
                    stockItem = ((NetStock.Contract.StockInHeader)HttpContext.Session["StockItems"]).StockInDetails.Where(itm => itm.ItemNo == itemID).FirstOrDefault();
                }
            }
            stockItem.ProductsList = NetStock.Utility.GetProductList();



            return PartialView("AddStockItem", stockItem);

        }


        [Route("EditStockItem")]
        [HttpPost]
        public ActionResult EditStockItem(NetStock.Contract.StockInDetail item)
        {

            NetStock.Contract.StockInHeader stockheader;


            stockheader = (NetStock.Contract.StockInHeader)HttpContext.Session["StockItems"];

            if (stockheader == null)
            {
                stockheader = new Contract.StockInHeader();
                stockheader.StockInDetails = new List<Contract.StockInDetail>();

            }

            item.CreatedBy = Utility.DEFAULTUSER;
            item.ModifiedBy = Utility.DEFAULTUSER;




            if (stockheader.StockInDetails.Count == 0)
            {
                item.ItemNo = 1;
                stockheader.StockInDetails.Add(item);


            }
            else
            {

                var nextItem = stockheader.StockInDetails.Max(pr => pr.ItemNo);


                if (stockheader.StockInDetails.Where(pr => pr.ProductCode == item.ProductCode).Count() > 0)
                {

                    stockheader.StockInDetails.Where(pr => pr.ItemNo == item.ItemNo)
                                             .Update(pr =>
                                             {
                                                 pr.Quantity = item.Quantity;

                                             });
                }
                else
                {
                    item.ItemNo = (short)(nextItem + 1);
                    stockheader.StockInDetails.Add(item);
                }
            }



            return Json(new { success = true });



        }


        [Route("AddStockInProduct")]
        [HttpPost]
        public ActionResult AddStockInProduct(string supplierCode, string barCode, Int32 quantity = 1)
        {

            NetStock.Contract.StockInDetail stockDetail = new Contract.StockInDetail();


            //var productData = new NetStock.BusinessFactory.ProductBO().GetSupplierProductByBarCodeOrDescription(supplierCode,barCode,barCode);
            var productData = new NetStock.BusinessFactory.ProductBO().GetProductByBarCodeOrDescription(new NetStock.Contract.Product { ProductCode = barCode, Description = barCode, BarCode = barCode });



            if (productData != null)
            {
                stockDetail.BarCode = productData.BarCode;
                stockDetail.POQty = quantity;
                stockDetail.ProductCode = productData.ProductCode;
                stockDetail.ProductDescription = productData.Description;
                stockDetail.Quantity = quantity;
                stockDetail.PendingQty = (quantity - quantity);
                stockDetail.DocumentNo = "";
                stockDetail.Location = productData.Location;
                stockDetail.LocationDescription = productData.LocationDescription;


                var lstSupplierProduct = new NetStock.BusinessFactory.QuotationItemBO().GetSupplierQuotationProductPrice(supplierCode, stockDetail.ProductCode).FirstOrDefault();

                if (lstSupplierProduct != null)
                {
                    stockDetail.BuyingPrice = lstSupplierProduct.SellRate;
                }



            }



            return Json(new { Message = "Data", StockInDetail = stockDetail }, JsonRequestBehavior.AllowGet);
        }



        [Route("DeleteGoodsReceive")]
        [HttpGet]
        public ActionResult DeleteGoodsReceive(string documentNo)
        {
            var result = false;
            var message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.GoodsReceiveHeaderBO().DeleteGoodsReceiveHeader(new GoodsReceiveHeader { DocumentNo = documentNo, ModifiedBy = Utility.DEFAULTUSER, BranchID = Utility.SsnBranch });
                message = result ? "Goods receive deleted successfully." : "Can'nt able to delete.";

                TempData["isSaved"] = result;
                TempData["resultMessage"] = message;
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }
            return RedirectToAction("GoodsReceiveList");
        }

        [Route("DeleteStockEntry")]
        [HttpPost]
        public JsonResult DeleteStockEntry(string documentNo)
        {
            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.StockInHeaderBO().DeleteStockInHeader(new NetStock.Contract.StockInHeader { DocumentNo = documentNo, ModifiedBy = Utility.DEFAULTUSER });
                message = result ? "Stock Entry deleted successfully." : "Can'nt able to delete.";
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }

            return Json(new { result = result, Message = message, documentNo = documentNo });
        }

        #endregion

        #region Order Entry

        [Route("OrderEntry")]
        [HttpGet]
        public ActionResult OrderEntry(string orderNo)
        {

            NetStock.Contract.OrderHeader orderheader;

            orderheader = new NetStock.Contract.OrderHeader();

            if (orderNo == "NEW")
            {
                orderheader.OrderDetails = new List<NetStock.Contract.OrderDetail>();
                orderheader.OrderDate = DateTime.Now.Date;
                orderheader.DeliveryDate = DateTime.Now.Date;
                orderheader.OrderNo = "";
                orderheader.Status = true;
            }
            else
            {
                orderheader = new NetStock.BusinessFactory.OrderHeaderBO().GetOrderHeader(new Contract.OrderHeader { OrderNo = orderNo });
                if (orderheader != null)
                {


                    orderheader.OrderDetails.ForEach(dt =>

                    { dt.Photo = new NetStock.BusinessFactory.ProductImageBO().GetProductImage(dt.ProductCode); }

                        );

                    foreach (var item in orderheader.OrderDetails)
                    {
                        if (item.Photo != null)
                        {
                            item.ProductImageString = System.Convert.ToBase64String(item.Photo.ProductImg);
                        }
                    }
                }
                else
                {
                    orderheader = new Contract.OrderHeader();
                    orderheader.OrderDetails = new List<NetStock.Contract.OrderDetail>();
                    orderheader.OrderDate = DateTime.Now.Date;
                    orderheader.DeliveryDate = DateTime.Now.Date;
                    orderheader.OrderNo = "";
                    orderheader.Status = true;
                }

            }

            orderheader.DiscountTypeList = Utility.GetDiscountList();
            orderheader.CustomersList = NetStock.Utility.GetCustomerList(false);
            orderheader.OrderTypeList = Utility.GetLookupItemList("INVOICETYPE");
            orderheader.PaymentTypeList = Utility.GetLookupItemList("PAYMENTTYPE");
            orderheader.UOMList = NetStock.Utility.GetLookupItemList("UOM");


            var cashCustomer = new NetStock.BusinessFactory.CustomerBO().GetList().Where(cu => cu.Status == true && cu.CustomerType == "CUSTOMER" && cu.CustomerCode == "เงินสด").FirstOrDefault();
            if (cashCustomer != null)
            {
                orderheader.CustomerCode = cashCustomer.CustomerCode;
            }


            return View("OrderEntry", orderheader);
            //return View(Products);
        }

        [Route("SaveOrderEntry")]
        [HttpPost]
        public ActionResult SaveOrderEntry(NetStock.Contract.OrderHeader order)
        {

            var message = string.Empty;
            var result = false;
            try
            {


                order.Status = true;
                order.CreatedBy = Utility.DEFAULTUSER;
                order.ModifiedBy = Utility.DEFAULTUSER;
                order.BranchID = Utility.SsnBranch;
                //order.IsPayLater = (bool)(order.PaymentDays > 0);


                if (order.OrderNo == "NEW")
                {
                    order.OrderNo = "";
                }

                result = new NetStock.BusinessFactory.OrderHeaderBO().SaveOrderHeader(order);

                if (result)
                {
                    message = string.Format("Order saved successfully.Order No. {0}. Please Click PRINT button to print the Cash-bill.  ", order.OrderNo);
                }
                else
                {
                    message = "Unable to Save Current Order, Please try again.";
                }

            }
            catch (Exception ex)
            {

                ModelState.AddModelError("Error", ex.Message);
            }


            return RedirectToAction("Orders");
            //return Json(new { success = result, Message = message, POData = order });

        }

        [Route("DeleteOrder")]
        [HttpPost]
        public JsonResult DeleteOrder(string orderNo)
        {
            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.OrderHeaderBO().DeleteOrderHeader(new NetStock.Contract.OrderHeader { OrderNo = orderNo, ModifiedBy = Utility.DEFAULTUSER });

            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }

            return Json(new { result = result, Message = "Order deleted successfully.", orderNo = orderNo });



        }

        [Route("EditOrderItem")]
        [HttpGet]
        public ActionResult EditOrderItem(string orderNo, int? itemID)
        {
            var orderItem = new NetStock.Contract.OrderDetail();

            if (itemID != null && itemID > 0)
            {
                if (HttpContext.Session["OrderItems"] != null)
                {
                    orderItem = ((NetStock.Contract.OrderHeader)HttpContext.Session["OrderItems"]).OrderDetails.Where(itm => itm.ItemNo == itemID).FirstOrDefault();
                }
            }
            orderItem.ProductsList = NetStock.Utility.GetProductList();
            orderItem.DiscountTypeList = NetStock.Utility.GetLookupItemList("DISCOUNTTYPE");

            return PartialView("AddOrderItem", orderItem);

        }

        [Route("EditOrderDetail")]
        [HttpGet]
        public ActionResult EditOrderDetail(string orderNo, int? itemID)
        {
            var orderItem = new NetStock.Contract.OrderDetail();

            if (itemID != null && itemID > 0)
            {
                if (HttpContext.Session["OrderItems"] != null)
                {
                    orderItem = ((NetStock.Contract.OrderHeader)HttpContext.Session["OrderItems"]).OrderDetails.Where(itm => itm.ItemNo == itemID).FirstOrDefault();
                }
            }
            orderItem.ProductsList = NetStock.Utility.GetProductList();
            orderItem.DiscountTypeList = Utility.GetLookupItemList("DISCOUNTTYPE");

            return PartialView("OrderItem", orderItem);

        }

        [Route("EditOrderItem")]
        [HttpPost]
        public ActionResult EditOrderItem(NetStock.Contract.OrderDetail item)
        {

            NetStock.Contract.OrderHeader order;


            order = (NetStock.Contract.OrderHeader)HttpContext.Session["OrderItems"];

            item.CreatedBy = Utility.DEFAULTUSER;
            item.ModifiedBy = Utility.DEFAULTUSER;
            item.DiscountTypeList = Utility.GetLookupItemList("DISCOUNTTYPE");
            item.MatchQuotation = "STANDARD";

            var product = new NetStock.BusinessFactory.QuotationBO().GetQuotation(new Contract.Quotation { QuotationNo = "STANDARD" })
                                                                    .QuotationItems.Where(dt => dt.ProductCode == item.ProductCode).FirstOrDefault();

            if (product != null)
            {
                item.SellRate = product.SellRate;
                item.SellPrice = decimal.Multiply(item.SellRate,Convert.ToDecimal(item.Quantity));
            }


            if (order.OrderDetails.Count == 0)
            {
                item.ItemNo = 1;
                order.OrderDetails.Add(item);
                order.TotalAmount = order.OrderDetails.Sum(dt => dt.SellPrice);
            }
            else
            {

                var nextItem = order.OrderDetails.Max(pr => pr.ItemNo);


                if (order.OrderDetails.Where(pr => pr.ProductCode == item.ProductCode).Count() > 0)
                {

                    order.OrderDetails.Where(pr => pr.ItemNo == item.ItemNo)
                                             .Update(pr =>
                                             {
                                                 pr.Quantity = item.Quantity;

                                             });
                }
                else
                {
                    item.ItemNo = (short)(nextItem + 1);
                    order.OrderDetails.Add(item);
                    order.TotalAmount = order.OrderDetails.Sum(dt => dt.SellPrice);
                }
            }



            return Json(new { success = true });



        }

        [Route("Orders")]
        [HttpGet]
        public ActionResult Orders()
        {
            var lstOrders = new NetStock.BusinessFactory.OrderHeaderBO().GetList().Where(ord => ord.Status == true).ToList();
            //HttpContext.Session["OrderItems"] = null;
            return View("OrdersList", lstOrders);
        }
        #region
        [HttpGet]
        [Route("OrdersIssueList")]
        public ActionResult OrdersIssueList()
        {
            var lstOrdersIssue = new NetStock.BusinessFactory.OrderIssueHeaderBO().GetList().Where(x => x.Status == true).ToList();
            return View(lstOrdersIssue);
        }

        [Route("OrderIssueEntry")]
        [HttpGet]
        public ActionResult OrderIssueEntry(string orderNo)
        {

            NetStock.Contract.OrderIssueHeader orderIssueheader;

            orderIssueheader = new NetStock.Contract.OrderIssueHeader();

            if (orderNo == "NEW")
            {
                orderIssueheader.OrderIssueDetails = new List<NetStock.Contract.OrderIssueDetail>();
                orderIssueheader.OrderDate = DateTime.Now.Date;
                orderIssueheader.DeliveryDate = DateTime.Now.Date;
                orderIssueheader.OrderNo = "";
                orderIssueheader.Status = true;
            }
            else
            {
                orderIssueheader = new NetStock.BusinessFactory.OrderIssueHeaderBO().GetOrderIssueHeader(new Contract.OrderIssueHeader { OrderNo = orderNo });
                if (orderIssueheader != null)
                {


                    orderIssueheader.OrderIssueDetails.ForEach(dt => 
                    {
                        dt.Photo = new NetStock.BusinessFactory.ProductImageBO().GetProductImage(dt.ProductCode);
                    });

                    foreach (var item in orderIssueheader.OrderIssueDetails)
                    {
                        if (item.Photo != null)
                        {
                            item.ProductImageString = System.Convert.ToBase64String(item.Photo.ProductImg);
                        }
                    }
                }
                else
                {
                    orderIssueheader = new Contract.OrderIssueHeader();
                    orderIssueheader.OrderIssueDetails = new List<NetStock.Contract.OrderIssueDetail>();
                    orderIssueheader.OrderDate = DateTime.Now.Date;
                    orderIssueheader.DeliveryDate = DateTime.Now.Date;
                    orderIssueheader.OrderNo = "";
                    orderIssueheader.Status = true;
                }

            }

            orderIssueheader.DiscountTypeList = Utility.GetDiscountList();
            orderIssueheader.CustomersList = NetStock.Utility.GetCustomerList(false);
            orderIssueheader.OrderTypeList = Utility.GetLookupItemList("INVOICETYPE");
            orderIssueheader.PaymentTypeList = Utility.GetLookupItemList("PAYMENTTYPE");
            orderIssueheader.UOMList = NetStock.Utility.GetLookupItemList("UOM");


            var cashCustomer = new NetStock.BusinessFactory.CustomerBO().GetList().Where(cu => cu.Status == true && cu.CustomerType == "CUSTOMER" && cu.CustomerCode == "เงินสด").FirstOrDefault();
            if (cashCustomer != null)
            {
                orderIssueheader.CustomerCode = cashCustomer.CustomerCode;
            }


            return View("OrderIssueEntry", orderIssueheader);            
        }

        [Route("SearchOrderIssue")]
        public ActionResult SearchOrderIssue(string refOrderNo)
        {
            try
            {
                var orderIssueheader = new OrderIssueHeaderBO().SearchOrderIssueByRefNo(refOrderNo);
                if(orderIssueheader != null)
                {
                    orderIssueheader.OrderIssueDetails = new OrderIssueDetailBO().GetOrderIssueDetailPendingList(refOrderNo);
                }
                orderIssueheader.DiscountTypeList = Utility.GetDiscountList();
                orderIssueheader.CustomersList = NetStock.Utility.GetCustomerList(false);
                orderIssueheader.OrderTypeList = Utility.GetLookupItemList("INVOICETYPE");
                orderIssueheader.PaymentTypeList = Utility.GetLookupItemList("PAYMENTTYPE");
                orderIssueheader.UOMList = NetStock.Utility.GetLookupItemList("UOM");
                return View("OrderIssueEntry", orderIssueheader);
            }
            catch (Exception ex)
            {
                return RedirectToAction("Login", "Account");
            }
            
        }
        #endregion

        [Route("ProductPhoto")]
        public ActionResult ProductPhoto(string productCode)
        {
            var productImage = new NetStock.BusinessFactory.ProductImageBO().GetProductImage(productCode);

            return PartialView("ProductPhoto", productImage);
        }

        [Route("AddProductToGrid")]
        [HttpPost]
        public ActionResult AddProductToGrid(string customerCode, string barCode, float quantity = 1.0F, float TotalQty = 0)
        {
            NetStock.Contract.OrderDetail orderDetail = new Contract.OrderDetail();

            string Message = string.Empty;
            var searchStatus = false;
            //var orderproductData = new NetStock.BusinessFactory.OrderDetailBO().GetProductPrice(customerCode, barCode);

            //if (orderproductData == null)
            //{

            var product = new NetStock.BusinessFactory.ProductBO().GetProduct(new Contract.Product { ProductCode = barCode });
            if (product != null)
            {
                orderDetail.ProductCode = product.ProductCode;
                orderDetail.ProductDescription = product.Description;
                orderDetail.BarCode = product.BarCode;
                orderDetail.AdjustAmount = 0;
                orderDetail.CreatedBy = Utility.DEFAULTUSER;
                orderDetail.DiscountAmount = 0;
                orderDetail.DiscountType = "NONE";
                orderDetail.PartialPayment = 0;
                orderDetail.ItemNo = 0;
                orderDetail.MatchQuotation = "";
                orderDetail.ModifiedBy = Utility.DEFAULTUSER;
                orderDetail.OrderNo = "";
                orderDetail.Quantity = quantity;
                orderDetail.Location = product.Location;
                orderDetail.LocationDescription = product.LocationDescription;

                decimal stockCount = 0.0M;
                var item = new NetStock.BusinessFactory.StockLedgerBO().StockInquiry(product.ProductCode, product.ProductCategory, product.Location, null).FirstOrDefault();

                if (item != null)
                {
                    stockCount = item.StockInHand;
                }


                if (stockCount <= 0)
                {
                    Message = string.Format("Product : [{0}] , has NO STOCK", product.Description);
                }
                else if (stockCount < Convert.ToDecimal(quantity))
                {
                    Message = string.Format("Product : [{0}] CURRENT STOCK {1} , does not meet the Order Quantity!", product.Description, stockCount);
                }
                else
                {
                    Message = "Success";
                }


                orderDetail.Photo = new NetStock.BusinessFactory.ProductImageBO().GetProductImage(product.ProductCode);
                if (orderDetail.Photo != null)
                {
                    orderDetail.ProductImageString = System.Convert.ToBase64String(orderDetail.Photo.ProductImg);
                }

                orderDetail.Cost = GetProductCostPrice(orderDetail.ProductCode, TotalQty);
                decimal productSellRate = GetProductSellPrice(customerCode, orderDetail.ProductCode);
                orderDetail.SellRate = productSellRate;
                orderDetail.SellPrice = decimal.Multiply(productSellRate, Convert.ToDecimal(quantity));




            }
            else
            {
                Message = "Invalid Product Code";
            }



            return this.LargeJson(new { Message = Message, OrderDetail = orderDetail }, JsonRequestBehavior.AllowGet);
        }

        private decimal GetProductSellPrice(string customerCode, string productCode)
        {
            decimal sellRate = 0;

            var quotationProduct = new NetStock.BusinessFactory.OrderDetailBO().GetProductPrice(customerCode, productCode, Utility.SsnBranch);

            if (quotationProduct != null)
            {
                sellRate = quotationProduct.SellRate;
            }

            return sellRate;

        }

        private decimal GetProductCostPrice(string productCode, float quantity = 0)
        {
            decimal costPrice = 0;

            var PendingProducts = new NetStock.BusinessFactory.StockInDetailBO().GetStockInByPendingQty(productCode, quantity).FirstOrDefault();

            if (PendingProducts != null)
            {
                costPrice = PendingProducts.BuyingPrice;
            }

            return costPrice;

        }

        [HttpGet]
        [Route("GetProductCostPrice")]
        public JsonResult GetProductCostPrice(string productCode, string supplierCode)
        {
            decimal costPrice = 0;

            var PendingProducts = new NetStock.BusinessFactory.QuotationItemBO().GetSupplierQuotationProductPrice(supplierCode, productCode).FirstOrDefault();

            if (PendingProducts != null)
            {
                costPrice = PendingProducts.SellRate;
            }

            return Json(new { UnitPrice = costPrice }, JsonRequestBehavior.AllowGet);

        }

        [Route("GetCustomerDetails")]
        public JsonResult GetCustomerDetails(string customerCode)
        {
            var customer = new NetStock.BusinessFactory.CustomerBO().GetCustomer(new Contract.Customer { CustomerCode = customerCode });


            //customer.CustomerAddress.FullAddress= GetFullAddress(customer.CustomerAddress.FullAddress??"");
            return Json(new { CustomerData = customer }, JsonRequestBehavior.AllowGet);

        }

        protected string GetFullAddress(string address)
        {
            if (address.IndexOf(",") > 0)
            {
                var list = address.Split(',').ToList();

                var html = "";
                for (var i = 0; i < list.Count; i++)
                {
                    html += list[i] + "<br/>";
                }

                return html;
            }
            return address;
        }

        [Route("GetCustomerPOList")]
        public JsonResult GetCustomerPOList(string customerCode)
        {
            var lstSupplierPO = new NetStock.BusinessFactory.PurchaseOrderHeaderBO().GetPurchaseOrderBySupplier(customerCode);

            return Json(new { POList = lstSupplierPO }, JsonRequestBehavior.AllowGet);

        }

        [Route("GetPOListForStockIn")]
        public JsonResult GetPOListForStockIn(string poNo)
        {
            var lstSupplierPO = new NetStock.BusinessFactory.PurchaseOrderDetailBO().GetList(poNo);


            var lstStockDt = new List<NetStock.Contract.StockInDetail>();

            if (lstStockDt != null || lstStockDt.Count > 0)
            {



                lstSupplierPO.ForEach(po =>
                {
                    lstStockDt.Add(new Contract.StockInDetail
                    {
                        DocumentNo = "",
                        ItemNo = 0,
                        BarCode = "",
                        ProductCode = po.ProductCode,
                        ProductDescription = po.ProductDescription,
                        POQty = po.Quantity,
                        BuyingPrice = po.UnitPrice,
                        Quantity = 0,
                        PendingQty = po.Quantity,
                        BuyingAmount = (po.UnitPrice * 0),
                        CreatedBy = Utility.DEFAULTUSER,
                        ModifiedBy = Utility.DEFAULTUSER,
                        Location = "",
                        LocationDescription = ""
                    });

                }
                    );

            }
            return Json(new { stockDt = lstStockDt }, JsonRequestBehavior.AllowGet);

        }

        #endregion

        #region Delivery Order



        [Route("DeliveryOrders")]
        [HttpGet]
        public ActionResult DeliveryOrders()
        {
            var lstOrders = new NetStock.BusinessFactory.OrderHeaderBO().GetList();
            HttpContext.Session["OrderItems"] = null;
            return View("DeliveryOrderList", lstOrders);


        }

        [Route("DeliveryOrder")]
        [HttpGet]
        public ActionResult DeliveryOrder(string orderNo)
        {



            var isNew = false;
            NetStock.Contract.OrderHeader orderheader;

            if (HttpContext.Session["OrderItems"] != null)
            {
                orderheader = (NetStock.Contract.OrderHeader)HttpContext.Session["OrderItems"];
            }
            else
            {
                orderheader = new NetStock.Contract.OrderHeader();
                isNew = true;
            }

            if (orderNo == "NEW")
                orderNo = "";

            if (orderNo != null && orderNo.Length > 0)
            {
                if (isNew)
                {
                    orderheader = new NetStock.BusinessFactory.OrderHeaderBO().GetOrderHeader(new Contract.OrderHeader { OrderNo = orderNo });
                    orderheader.CustomersList = NetStock.Utility.GetCustomerList(false);
                    orderheader.OrderTypeList = Utility.GetLookupItemList("INVOICETYPE");
                    orderheader.PaymentTypeList = Utility.GetLookupItemList("PAYMENTTYPE");
                    HttpContext.Session["OrderItems"] = orderheader;
                }
            }
            else
            {
                orderheader.OrderNo = orderNo;
                orderheader.OrderDate = DateTime.Today.Date;
                orderheader.OrderTypeList = Utility.GetLookupItemList("INVOICETYPE");
                orderheader.PaymentTypeList = Utility.GetLookupItemList("PAYMENTTYPE");
                orderheader.CustomersList = Utility.GetCustomerList(false);

            }

            if (HttpContext.Session["OrderItems"] == null)
            {
                orderheader.OrderDetails = new List<Contract.OrderDetail>();

                HttpContext.Session["OrderItems"] = orderheader;
            }
            else
            {
                orderheader = (NetStock.Contract.OrderHeader)HttpContext.Session["OrderItems"];

                var currentDocumentNo = "";

                if (orderheader.OrderDetails != null && orderheader.OrderDetails.Count > 0)
                {
                    currentDocumentNo = orderheader.OrderDetails.FirstOrDefault().OrderNo;
                }

                if (currentDocumentNo == null)
                    currentDocumentNo = "";


                if (orderNo != currentDocumentNo)
                {
                    HttpContext.Session["OrderItems"] = null;
                    orderheader.OrderDetails = new List<Contract.OrderDetail>();
                    orderheader.OrderNo = "";
                    HttpContext.Session["OrderItems"] = orderheader;
                    orderheader.OrderDetails = new List<Contract.OrderDetail>();
                }

            }


            return View("DeliveryOrder", orderheader);
            //return View(Products);
        }

        #endregion

        #region Purchase Order



        [Route("PurchaseOrderList")]
        [HttpGet]
        public ActionResult PurchaseOrderList()
        {
            var lstPO = new NetStock.BusinessFactory.PurchaseOrderHeaderBO().GetList(Utility.SsnBranch);
            return View("PurchaseOrderList", lstPO);
        }

        [Route("PurchaseOrder")]
        [HttpGet]
        public ActionResult PurchaseOrder(string documentNo, short branchId)
        {
            NetStock.Contract.PurchaseOrderHeader poHeader = new Contract.PurchaseOrderHeader();

            if (documentNo == "NEW")
                documentNo = "";

            if (documentNo != null && documentNo.Length > 0)
            {
                poHeader = new NetStock.BusinessFactory.PurchaseOrderHeaderBO().GetPurchaseOrderHeader(new Contract.PurchaseOrderHeader { PONo = documentNo, BranchID = branchId });


                if (poHeader != null)
                {
                    if (poHeader.PurchaseOrderDetails == null)
                    {
                        poHeader.PurchaseOrderDetails = new List<Contract.PurchaseOrderDetail>();
                    }

                    if (!string.IsNullOrWhiteSpace(poHeader.SupplierCode))
                    {
                        var customerAddress = new Address();
                        var customerFullAddress = "";

                        var addressObj = new NetStock.BusinessFactory.CustomerBO()
                                                            .GetCustomer(new Contract.Customer
                                                            {
                                                                CustomerCode = poHeader.SupplierCode
                                                            });
                        if(addressObj != null && addressObj.CustomerAddress != null)
                            customerAddress = addressObj.CustomerAddress;

                        if (customerAddress != null)
	                    {
                            customerFullAddress=customerAddress.FullAddress;
	                    }

                        ViewData["ViewDataaddress"] = customerFullAddress;
                    }
                }
                else
                {
                    poHeader = new Contract.PurchaseOrderHeader();
                    poHeader.PurchaseOrderDetails = new List<PurchaseOrderDetail>();
                }
            }
            else
            {
                poHeader.PONo = documentNo;
                poHeader.PODate = DateTime.UtcNow.ThaiTime();
                //poHeader.ShipmentDate = DateTime.UtcNow.ThaiTime();
                //poHeader.EstimateDate = DateTime.UtcNow.ThaiTime();
                poHeader.PurchaseOrderDetails = new List<Contract.PurchaseOrderDetail>();
            }
            poHeader.SupplierList = Utility.GetCustomerList(true);
            poHeader.BranchList = NetStock.Utility.GetBranchList();
            poHeader.ProductsList = NetStock.Utility.GetProductList();
            poHeader.UOMList = NetStock.Utility.GetLookupItemList("UOM");
            poHeader.IncoTermList = NetStock.Utility.GetLookupItemList("INCOTERM");
            poHeader.CurrencyCodeList = NetStock.Utility.GetCurrencyItemList();
            poHeader.PaymentTypeList = Utility.GetLookupItemList("PAYMENTTYPE");


            return View("PurchaseOrder", poHeader);
        }

        [Route("EditPOItem")]
        [HttpGet]
        public ActionResult EditPOItem(string supplierCode)
        {
            var orderItem = new NetStock.Contract.PurchaseOrderDetail();
            var lstProducts = NetStock.Utility.GetProductList();

            if (lstProducts == null || lstProducts.Count() == 0)
            {
                lstProducts = NetStock.Utility.GetProductList();
            }

            orderItem.ProductsList = lstProducts;
            ViewBag.SupplierCode = supplierCode;

            return PartialView("AddPOItem", orderItem);

        }

        [Route("GetProductUnitPrice")]
        public JsonResult GetProductUnitPrice(string supplierCode, string productCode)
        {
            decimal unitPrice = 0;
            return Json(new { unitPrice = unitPrice }, JsonRequestBehavior.AllowGet);
        }

        [Route("EditPOItem")]
        [HttpPost]
        public ActionResult EditPOItem(NetStock.Contract.PurchaseOrderDetail item)
        {
            return Json(new { success = true });
        }

        [Route("SavePurchaseOrder")]
        [HttpPost]
        public ActionResult SavePurchaseOrder(NetStock.Contract.PurchaseOrderHeader purchaseOrder)
        {
            var message = string.Empty;
            var result = false;
            try
            {

                purchaseOrder.CreatedBy = Utility.DEFAULTUSER;
                purchaseOrder.ModifiedBy = Utility.DEFAULTUSER;
                var lstProducts = purchaseOrder.PurchaseOrderDetails;
                result = new NetStock.BusinessFactory.PurchaseOrderHeaderBO().SavePurchaseOrderHeader(purchaseOrder);

                if (result)
                {
                    message = string.Format("P.O {0} saved successfully  ", purchaseOrder.PONo);
                }
                else
                {
                    message = "Unable to Save Current P.O, Please try again.";
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
            return RedirectToAction("PurchaseOrderList");
        }

        [Route("DeletePO")]
        [HttpGet]
        public ActionResult DeletePO(string PONo)
        {
            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.PurchaseOrderHeaderBO().DeletePurchaseOrderHeader(new NetStock.Contract.PurchaseOrderHeader { PONo = PONo, ModifiedBy = Utility.DEFAULTUSER });

                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = string.Format("P.O [{0}] Deleted Successfully", PONo);
                else
                    TempData["resultMessage"] = "Unable to DELETE the Record!";

            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("PurchaseOrderList");
        }
        #endregion

        #region Goods Receive

        [HttpGet]
        [Route("GoodsReceiveList")]
        public ActionResult GoodsReceiveList()
        {


            var goodsReceiveHdrObj = new GoodsReceiveHeaderBO();
            var goodsList = goodsReceiveHdrObj.GetList(NetStock.Utility.DEFAULTBRANCH);

            return View("GoodsReceiveList", goodsList);
        }

        [HttpPost]
        [Route("SaveGoodsReceieveDomestic")]
        public ActionResult SaveGoodsReceieveDomestic(NetStock.Contract.GoodsReceiveHeader obj)
        {
            obj.CreatedBy = Utility.DEFAULTUSER;
            obj.ModifiedBy = Utility.DEFAULTUSER;
            obj.DocumentType = "DOMESTIC";
            var result = new NetStock.BusinessFactory.GoodsReceiveHeaderBO().SaveGoodsReceiveHeader(obj);

            TempData["isSaved"] = true;
            return RedirectToAction("GoodsReceiveDomestic", "Operation", new { documentNo = obj.DocumentNo, branchID = obj.BranchID });
        }

        [HttpGet]
        [Route("GoodsReceiveDomestic")]
        public ActionResult GoodsReceiveDomestic(string documentNo, short branchID = -1)
        {
            NetStock.Contract.GoodsReceiveHeader goodsreceiveheader = null;

            if (documentNo == "NEW")
            {
                goodsreceiveheader = new NetStock.Contract.GoodsReceiveHeader();
                goodsreceiveheader.GoodsReceiveDetails = new List<Contract.GoodsReceiveDetail>();
                goodsreceiveheader.DocumentDate = DateTime.Today.Date;
                goodsreceiveheader.BranchID = Utility.DEFAULTBRANCH;
                goodsreceiveheader.CreatedBy = Utility.DEFAULTUSER;
                goodsreceiveheader.ModifiedBy = Utility.DEFAULTUSER;
                goodsreceiveheader.Status = Utility.DEFAULTSTATUS;
                goodsreceiveheader.GoodsReceiveDetailsOverseasList = new List<Contract.GoodsReceiveDetailsOverseas>();
            }
            else
            {
                goodsreceiveheader = new NetStock.BusinessFactory.GoodsReceiveHeaderBO().GetGoodsReceiveHeader(new Contract.GoodsReceiveHeader { DocumentNo = documentNo, BranchID = branchID });
                goodsreceiveheader.DocumentNo = documentNo;

                if (goodsreceiveheader.GoodsReceiveDetails == null)
                {
                    goodsreceiveheader.GoodsReceiveDetails = new List<Contract.GoodsReceiveDetail>();
                }
            }
            goodsreceiveheader.SuppliersList = NetStock.Utility.GetCustomerList(true);
            goodsreceiveheader.BranchList = NetStock.Utility.GetBranchList();

            return View("GoodsReceiveDomestic", goodsreceiveheader);
        }

        [HttpPost]
        [Route("SaveGoodsReceieveOverSeas")]
        public ActionResult SaveGoodsReceieveOverSeas(NetStock.Contract.GoodsReceiveHeader obj)
        {
            obj.CreatedBy = Utility.DEFAULTUSER;
            obj.ModifiedBy = Utility.DEFAULTUSER;

            obj.DocumentType = "OVERSEAS";

            var result = new NetStock.BusinessFactory.GoodsReceiveHeaderBO().SaveGoodsReceiveHeader(obj);

            TempData["isSaved"] = true;
            return RedirectToAction("GoodsReceiveOverSeas", "Operation", new { documentNo = obj.DocumentNo, branchID = obj.BranchID });
        }

        [HttpGet]
        [Route("GoodsReceiveoverseas")]
        public ActionResult GoodsReceiveoverseas(string documentNo, short branchID = -1)
        {

            NetStock.Contract.GoodsReceiveHeader goodsreceiveheader = null;

            if (documentNo == "NEW")
            {
                goodsreceiveheader = new NetStock.Contract.GoodsReceiveHeader();
                goodsreceiveheader.GoodsReceiveDetails = new List<Contract.GoodsReceiveDetail>();
                goodsreceiveheader.DocumentDate = DateTime.Today.Date;
                goodsreceiveheader.BranchID = Utility.DEFAULTBRANCH;
                goodsreceiveheader.CreatedBy = Utility.DEFAULTUSER;
                goodsreceiveheader.ModifiedBy = Utility.DEFAULTUSER;
                goodsreceiveheader.Status = Utility.DEFAULTSTATUS;

                goodsreceiveheader.GoodsReceiveDetailsOverseasList = new List<Contract.GoodsReceiveDetailsOverseas>();

                //stockledger.StockInDetails = SampleDataForStockInLedgerDetails();
            }
            else
            {
                goodsreceiveheader = new NetStock.BusinessFactory.GoodsReceiveHeaderBO().GetGoodsReceiveHeader(new Contract.GoodsReceiveHeader { DocumentNo = documentNo, BranchID = branchID });
                goodsreceiveheader.DocumentNo = documentNo;

                if (goodsreceiveheader.GoodsReceiveDetails == null)
                {
                    goodsreceiveheader.GoodsReceiveDetails = new List<Contract.GoodsReceiveDetail>();

                }


            }

            goodsreceiveheader.SuppliersList = NetStock.Utility.GetCustomerList(true);
            goodsreceiveheader.BranchList = NetStock.Utility.GetBranchList();
            goodsreceiveheader.InspectionOverSeasList = new List<Contract.InspectionOverseas>();
            //goodsreceiveheader.suppliertypeli = NetStock.Utility.GetLookupItemList("SUPPLIERTYPE");
            //goodsreceiveheader.POList = NetStock.Utility.GetPOList();

            return View("GoodsReceiveoverseas", goodsreceiveheader);
        }

        #endregion


        #region Shipment Indent


        [Route("ShipmentIndentList")]
        public ActionResult ShipmentIndentList()
        {
            var lstSI = new NetStock.BusinessFactory.SIHeaderBO().GetList(Utility.SsnBranch);
            var supplierList = new NetStock.BusinessFactory.CustomerBO().GetList();

            var data = lstSI.Join(supplierList,
                            a => a.SupplierCode,
                            b => b.CustomerCode,
                            (a, b) => new { A = a, B = b })
                        .Where(x => x.A.Status == true)
                        .Select(x => new ShipmentIndentListVm
                        {
                            DocumentNo = x.A.DocumentNo,
                            DocumentDate = x.A.DocumentDate,
                            SupplierCode = x.A.SupplierCode,
                            SupplierName = x.B.CustomerName,
                            CustomerCode = x.A.CustomerCode,
                            CustomerName = supplierList.Where(y => y.CustomerCode == x.A.CustomerCode)
                                                .Select(y => y.CustomerName).FirstOrDefault<string>()
                        }).ToList<ShipmentIndentListVm>();            

            //return View("ShipmentIndentList", lstSI.Where(x => x.Status == true).ToList<SIHeader>());
            return View("ShipmentIndentList", data);


        }

        [HttpGet]
        [Route("ShipmentIndent")]
        public ActionResult ShipmentIndent(string documentNo)
        {
            var SIHeader = new NetStock.Contract.SIHeader();

            if (documentNo == "NEW")
                documentNo = "";

            if (documentNo != null && documentNo.Length > 0)
            {
                SIHeader = new NetStock.BusinessFactory.SIHeaderBO().GetSIHeader(new Contract.SIHeader { DocumentNo = documentNo, BranchID = Utility.SsnBranch });


                if (SIHeader.SIDetails == null)
                {
                    SIHeader.SIDetails = new List<Contract.SIDetail>();
                }

            }
            else
            {

                SIHeader.DocumentDate = DateTime.Today.Date;
                SIHeader.SIDetails = new List<Contract.SIDetail>();
            }

            SIHeader.SuppliersList = NetStock.Utility.GetCustomerList(true).ToList();
            SIHeader.CustomersList = NetStock.Utility.GetCustomerList(false).ToList();
            SIHeader.BranchList = NetStock.Utility.GetBranchList();
            SIHeader.ProductsList = NetStock.Utility.GetProductList();
            SIHeader.UOMList = NetStock.Utility.GetLookupItemList("UOM");
            SIHeader.CurrencyCodeList = NetStock.Utility.GetCurrencyItemList();
            SIHeader.PaymentTypeList = Utility.GetLookupItemList("PAYMENTTYPE");

            return View("ShipmentIndent", SIHeader);
        }

        [Route("GetPODetails")]
        public JsonResult GetPODetails(string documentNo)
        {
            try
            {
                var goodsreceivepodetail = new NetStock.BusinessFactory.GoodsReceivePODetailBO().GetPurchaseOrderDetailPendingList(documentNo);

                return Json(new { GoodsReceivePODetailData = goodsreceivepodetail }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { message = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [Route("SearchPO")]
        [HttpPost]
        public ActionResult SearchPO(string hdnPoNo, string hdnType)
        {
            var goodsreceiveheader = new NetStock.BusinessFactory.GoodsReceiveHeaderBO().SearchGoodsReceiveByPO(hdnPoNo);

            if (goodsreceiveheader != null)
            {
                var goodsreceivepodetail = new NetStock.BusinessFactory.GoodsReceivePODetailBO().GetPurchaseOrderDetailPendingList(hdnPoNo);

                goodsreceiveheader.GoodsReceivePODetailList = goodsreceivepodetail;

                goodsreceiveheader.SuppliersList = NetStock.Utility.GetCustomerList(true);
                goodsreceiveheader.BranchList = NetStock.Utility.GetBranchList();

                if (hdnType == DocumentType.DOMESTIC.ToString())
                    return View("GoodsReceiveDomestic", goodsreceiveheader);
                else if (hdnType == DocumentType.OVERSEAS.ToString())
                    return View("GoodsReceiveoverseas", goodsreceiveheader);
                else
                    return RedirectToAction("GoodsReceiveList");
            }

            return RedirectToAction("GoodsReceiveList");
        }

        [HttpPost]
        [Route("SaveSIDetails")]
        public ActionResult SaveSIDetails(NetStock.Contract.SIHeader SIHeader)
        {
            try
            {
                SIHeader.CreatedBy = Utility.DEFAULTUSER;
                SIHeader.ModifiedBy = Utility.DEFAULTUSER;

                var result = new NetStock.BusinessFactory.SIHeaderBO().SaveSIHeader(SIHeader);

                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = " Saved Successfully";
                else
                    TempData["resultMessage"] = "Unable to Save the Record!";
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("ShipmentIndentList");
        }

        [HttpGet]
        [Route("DeleteSI")]
        public ActionResult DeleteSI(string documentNo)
        {
            try
            {
                var result = new NetStock.BusinessFactory.SIHeaderBO().DeleteSIHeader(new SIHeader() { DocumentNo = documentNo, BranchID = Utility.SsnBranch });
                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = string.Format("Shipment Indent [{0}] Deleted Successfully", documentNo);
                else
                    TempData["resultMessage"] = "Unable to DELETE the Record!";
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("ShipmentIndentList");
        }

        [HttpGet]
        [Route("Goodsreceiveform1")]
        public ActionResult Goodsreceiveform1(string documentNo, string poNo, string productCode, string branchId)
        {
            //var goodsReceiveDetails = new GoodsReceiveDetail();
            //goodsReceiveDetails.ProductsList = NetStock.Utility.GetProductList();

            var goodsReceiveDetails = new GoodsReceiveDetailBO().GetGoodsReceiveDetail(new GoodsReceiveDetail { DocumentNo = documentNo, PONo = poNo, ProductCode = productCode });

            if (goodsReceiveDetails == null)
            {
                goodsReceiveDetails = new GoodsReceiveDetail();

                var goodsreceivepoDetails = new GoodsReceivePODetailBO().GetGoodsReceivePODetail(new GoodsReceivePODetail { DocumentNo = documentNo, PONo = poNo });


                goodsReceiveDetails.Qty = 0;
                goodsReceiveDetails.UOM = "";
                goodsReceiveDetails.ProductDescription = "";
                if (goodsreceivepoDetails != null)
                {
                    goodsReceiveDetails.Qty = goodsreceivepoDetails.Quantity;
                    goodsReceiveDetails.UOM = goodsreceivepoDetails.UOM;
                    goodsReceiveDetails.ProductDescription = goodsreceivepoDetails.ProductDescription;

                }

            }

            goodsReceiveDetails.DocumentNo = documentNo;
            goodsReceiveDetails.PONo = poNo;
            goodsReceiveDetails.ProductCode = productCode;



            TempData["branchId"] = branchId;

            return View("Goodsreceiveform1", goodsReceiveDetails);
        }

        [HttpPost]
        [Route("SaveGoodsreceiveform1")]
        public ActionResult SaveGoodsreceiveform1(GoodsReceiveDetail obj)
        {
            obj.CreatedBy = Utility.DEFAULTUSER;
            obj.ModifiedBy = Utility.DEFAULTUSER;

            var result = new NetStock.BusinessFactory.GoodsReceiveDetailBO().SaveGoodsReceiveDetail(obj);


            return RedirectToAction("GoodsReceiveDomestic", "Operation", new { documentNo = obj.DocumentNo, branchID = Convert.ToInt16(Request.Form["branchId"]) });
        }

        [HttpGet]
        [Route("Goodsreceiveform2")]
        public ActionResult Goodsreceiveform2(string documentNo, string poNo, string productCode, string branchId)
        {
            var goodsReceiveDetailsOverseas = new GoodsReceiveDetailsOverseasBO().GetGoodsReceiveDetailsOverseas(new GoodsReceiveDetailsOverseas { DocumentNo = documentNo, PONo = poNo, ProductCode = productCode });

            if (goodsReceiveDetailsOverseas == null)
            {
                goodsReceiveDetailsOverseas = new GoodsReceiveDetailsOverseas();

                var goodsreceivepoDetails = new GoodsReceivePODetailBO().GetGoodsReceivePODetail(new GoodsReceivePODetail { DocumentNo = documentNo, PONo = poNo });

                goodsReceiveDetailsOverseas.Quantity = 0;
                goodsReceiveDetailsOverseas.UOM = "";
                goodsReceiveDetailsOverseas.ProductDescription = "";
                if (goodsreceivepoDetails != null)
                {
                    goodsReceiveDetailsOverseas.Quantity = goodsreceivepoDetails.Quantity;
                    goodsReceiveDetailsOverseas.UOM = goodsreceivepoDetails.UOM;
                    goodsReceiveDetailsOverseas.ProductDescription = goodsreceivepoDetails.ProductDescription;

                }

            }

            goodsReceiveDetailsOverseas.DocumentNo = documentNo;
            goodsReceiveDetailsOverseas.PONo = poNo;
            goodsReceiveDetailsOverseas.ProductCode = productCode;



            TempData["branchId"] = branchId;



            return View("Goodsreceiveform2", goodsReceiveDetailsOverseas);
        }

        [HttpPost]
        [Route("SaveGoodsreceiveform2")]
        public ActionResult Goodsreceiveform2(GoodsReceiveDetailsOverseas obj)
        {
            obj.CreatedBy = Utility.DEFAULTUSER;
            obj.ModifiedBy = Utility.DEFAULTUSER;

            var result = new NetStock.BusinessFactory.GoodsReceiveDetailsOverseasBO().SaveGoodsReceiveDetailsOverseas(obj);


            return RedirectToAction("GoodsReceiveDomestic", "Operation", new { documentNo = obj.DocumentNo, branchID = Convert.ToInt16(Request.Form["branchId"]) });
        }

        [HttpGet]
        [Route("Goodsreceiveform3")]
        public ActionResult Goodsreceiveform3(string documentNo, string poNo, string productCode, string branchId)
        {

            var lstInspectionDomestic = new InspectionDomesticBO().GetList(documentNo, poNo, productCode);

            if (lstInspectionDomestic == null || lstInspectionDomestic.Count == 0)
            {
                lstInspectionDomestic = new List<InspectionDomestic>();

                lstInspectionDomestic.ForEach(dt =>
                {
                    dt.DocumentNo = documentNo;
                    dt.ProductCode = productCode;
                    dt.PONo = poNo;
                    dt.Qty = 0;
                    dt.UOM = "";
                });

                var goodsreceivepoDetails = new GoodsReceivePODetailBO().GetGoodsReceivePODetail(new GoodsReceivePODetail { DocumentNo = documentNo, PONo = poNo });
                if (goodsreceivepoDetails != null)
                {
                    lstInspectionDomestic.ForEach(dt =>
                    {
                        dt.ProductCode = goodsreceivepoDetails.ProductCode;
                        dt.ProductDescription = goodsreceivepoDetails.ProductDescription;
                        dt.Qty = goodsreceivepoDetails.Quantity;
                        dt.UOM = goodsreceivepoDetails.UOM;
                    });

                }

            }


            var idVm = new InspectionDomesticVm();
            idVm.inspectionDomesticList = lstInspectionDomestic;
            idVm.documentNo = documentNo;
            idVm.branchId = branchId;


            return View("Goodsreceiveform3", idVm);
        }

        [HttpPost]
        [Route("SaveGoodsreceiveform3")]
        public ActionResult Goodsreceiveform3(InspectionDomesticVm obj)
        {

            TempData["isSaved"] = false;

            if (obj.inspectionDomesticList.Count > 0)
            {
                obj.inspectionDomesticList.ForEach(dt =>
                {
                    dt.DocumentNo = obj.documentNo;
                    dt.PONo = obj.poNo;
                    dt.CreatedBy = Utility.DEFAULTUSER;
                    dt.ModifiedBy = Utility.DEFAULTUSER;
                });



                var result = new NetStock.BusinessFactory.InspectionDomesticBO().SaveInspectionDomesticList(obj.inspectionDomesticList);
                TempData["isSaved"] = result;

            }


            return RedirectToAction("GoodsReceiveDomestic", "Operation", new { documentNo = obj.documentNo, branchID = Convert.ToInt16(obj.branchId) });
        }

        [HttpGet]
        [Route("Inspection")]
        public ActionResult Inspection(string documentNo, string poNo, string productCode, string branchId)
        {
            var inspectionOverseas = new InspectionOverseasBO().GetInspectionOverseas(new InspectionOverseas { DocumentNo = documentNo, PONo = poNo, ProductCode = productCode });
            if (inspectionOverseas == null)
            {
                inspectionOverseas = new InspectionOverseas();

                inspectionOverseas.ReceivedQty = 0;

                var goodsreceivepoDetails = new GoodsReceivePODetailBO().GetGoodsReceivePODetail(new GoodsReceivePODetail { DocumentNo = documentNo, PONo = poNo });
                if (goodsreceivepoDetails != null)
                {
                    inspectionOverseas.ReceivedQty = Convert.ToInt16(goodsreceivepoDetails.Quantity);
                }
            }
            ViewBag.UOMList = new NetStock.BusinessFactory.LookupBO().GetList().Where(dt => dt.Category == "UOM" && dt.Status == true).Select(x => new {
                Value = x.LookupCode,
                Text = x.Description
            }).ToList();
            return View("Inspection", inspectionOverseas);
        }

        [HttpPost]
        [Route("SaveInspection")]
        public ActionResult SaveInspection(InspectionOverseas obj)
        {
            try
            {
                var result = new NetStock.BusinessFactory.InspectionOverseasBO().SaveInspectionOverseas(obj);

                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = string.Format("Inspection Chemical Saved Successfully", "");
                else
                    TempData["resultMessage"] = "Unable to SAVE the Record!";
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("GoodsReceiveDomestic", "Operation", new { documentNo = obj.DocumentNo, branchID = Convert.ToInt16(Request.Form["branchId"]) });
        }



        #endregion

        #region GoodsIssue



        [Route("GoodsIssueList")]
        [HttpGet]
        public ActionResult GoodsIssueList()
        {
            var lstgoodsissue = new NetStock.BusinessFactory.GoodsIssueBO().GetList();
            return View("GoodsIssueList", lstgoodsissue);
        }

        [Route("GoodsIssue")]
        public ActionResult GoodsIssue(string documentNo)
        {
            var goodsIssue = new GoodsIssue();
            goodsIssue.DocumentNo = documentNo;
            if (documentNo == "NEW")
            {

            }
            else
            {
                //goodsIssue = new NetStock.BusinessFactory.GoodsIssueBO().GetGoodsIssue(new Contract.GoodsIssue() { DocumentNo = documentNo });
                goodsIssue = new NetStock.BusinessFactory.GoodsIssueBO().GetGoodsIssue(goodsIssue);
            }

            var supplierList = new List<SelectListItem>();
            supplierList = Utility.GetCustomerList(true).ToList();

            var customerList = new List<SelectListItem>();
            customerList = Utility.GetCustomerList(false).ToList();

            goodsIssue.SupplierList = supplierList;
            goodsIssue.CustomerList = customerList;

            //goodsIssue.SupplierCode
            return View("GoodsIssue", goodsIssue);
        }

        [Route("SaveGoodsIssue")]
        public ActionResult SaveGoodsIssue(GoodsIssue obj)
        {
            try
            {
                obj.ModifiedBy = Utility.DEFAULTUSER;
                obj.CreatedBy = Utility.DEFAULTUSER;
                obj.ModifiedOn = DateTime.Now;
                obj.CreatedOn = DateTime.Now;
                obj.BranchID = Utility.DEFAULTBRANCH;
                obj.Status = true;

                var result = new GoodsIssueBO().SaveGoodsIssue(obj);

                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = string.Format("Goods Issue [{0}] Saved Successfully", obj.DocumentNo);
                else
                    TempData["resultMessage"] = "Unable to save the Record!";
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("GoodsIssueList");
        }

        [HttpGet]
        [Route("GetCurrentStock/{ProductCode}")]
        public JsonResult GetCurrentStock(string ProductCode)
        {
            var currentStock = new StockLedgerBO().GetProductCurrentStock(ProductCode);
            return Json(new { currentStock = currentStock }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [Route("DeleteFile")]
        public ActionResult DeleteFile(string hdnFileName, string hdnDocumentNo)
        {
            var documentFolder = Server.MapPath("~/UploadImages/") + hdnDocumentNo + "\\" + hdnFileName;

            var fileInfo = new System.IO.FileInfo(documentFolder);
            if (fileInfo.Exists)
                fileInfo.Delete();

            return RedirectToAction("ImageUploads", new { documentno = hdnDocumentNo });
        }
        #endregion

        [HttpGet]
        [Route("ImageUploads")]
        public ActionResult ImageUploads(string documentno)
        {
            List<file> fileList = new List<file>();
            // var documentNo = Request.Form["hdnDocumentNo"];
            var documentFolder = Server.MapPath("~/UploadImages/") + documentno;

            var dirInfo = new System.IO.DirectoryInfo(documentFolder);
            if (!dirInfo.Exists)
            {
                dirInfo.Create();
            }

            var filesLst = dirInfo.GetFiles();
            if (filesLst.Count() > 0)
            {
                foreach (var file in filesLst)
                {
                    /*
                    public string url { get; set; }
                    public string name { get; set; }
                    public string thumbnailUrl { get; set; }
                    public string error { get; set; }
                    public int size { get; set; }
                    public string deleteUrl { get; set; }
                    public string deleteType { get; set; } 
                    */
                    var item = new file();
                    item.name = file.Name;
                    item.size = Convert.ToInt32(file.Length);
                    item.url = "~/UploadImages/" + documentno + "//" + file.Name;
                    item.thumbnailUrl = "~/UploadImages/" + documentno + "//" + file.Name;
                    item.error = "";
                    item.deleteUrl = "";
                    item.deleteType = "";

                    fileList.Add(item);
                }
            }

            var documentType = Request.QueryString["documentType"] == DocumentType.DOMESTIC.ToString() ? "GoodsReceiveDomestic" : "GoodsReceiveOverseas";

            if (fileList.Count <= 10)
                return View("ImageUploads", fileList);
            else
                return RedirectToAction(documentType, new { documentNo = documentno, branchID = Utility.SsnBranch });
        }

        [HttpGet]
        [Route("UploadFiles")]
        public JsonResult UploadFiles(string documentNo)
        {
            //List<file> fileList = new List<file>();
            //// var documentNo = Request.Form["hdnDocumentNo"];
            //var documentFolder = Server.MapPath("~/UploadImages/") + documentNo;

            //var dirInfo = new System.IO.DirectoryInfo(documentFolder);
            //if (!dirInfo.Exists)
            //{
            //    dirInfo.Create();
            //}

            //var filesLst = dirInfo.GetFiles();
            //if (filesLst.Count() > 0)
            //{
            //    foreach (var file in filesLst)
            //    {
            //        /*
            //        public string url { get; set; }
            //        public string name { get; set; }
            //        public string thumbnailUrl { get; set; }
            //        public string error { get; set; }
            //        public int size { get; set; }
            //        public string deleteUrl { get; set; }
            //        public string deleteType { get; set; } 
            //        */
            //        var item = new file();
            //        item.name = file.Name;
            //        item.size = Convert.ToInt32(file.Length);
            //        item.url = "~/UploadImages/" + documentNo + "//" + file.Name;
            //        item.thumbnailUrl = "~/UploadImages/" + documentNo + "//" + file.Name;
            //        item.error = "";
            //        item.deleteUrl = "";
            //        item.deleteType = "";

            //        fileList.Add(item);
            //    }
            //}
            return Json("", JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [Route("UploadFiles")]
        public JsonResult UploadFiles(HttpPostedFileBase[] files)
        {
            var documentNo = Request.Form["hdnDocumentNo"];
            var myFiles = Request.Form["files"];
            try
            {
                var myfiles = new List<file>();
                /*Lopp for multiple files*/
                foreach (HttpPostedFileBase file in files)
                {
                    /*Geting the file name*/
                    string filename = System.IO.Path.GetFileName(file.FileName);
                    string documentsPath = Server.MapPath("~/UploadImages/"); //ConfigurationManager.AppSettings["documentsPath"];
                    string folderpath = documentsPath + "\\" + documentNo;

                    var dirInfo = new System.IO.DirectoryInfo(folderpath);
                    if (!dirInfo.Exists)
                    {
                        dirInfo.Create();
                    }

                    /*Saving the file in server folder*/
                    string filepathtosave = folderpath + "/" + filename;

                    var fileObj = new file();
                    fileObj.name = filename;
                    fileObj.url = "http://" + System.Web.HttpContext.Current.Request.Url.Host + ":" + System.Web.HttpContext.Current.Request.Url.Port + "/UploadImages/" + documentNo + "/" + filename;
                    fileObj.thumbnailUrl = "http://" + System.Web.HttpContext.Current.Request.Url.Host + ":" + System.Web.HttpContext.Current.Request.Url.Port + "/UploadImages/" + documentNo + "/" + filename;
                    fileObj.size = file.ContentLength;
                    fileObj.deleteUrl = "http://" + System.Web.HttpContext.Current.Request.Url.Host + ":" + System.Web.HttpContext.Current.Request.Url.Port + "/UploadImages/" + documentNo + "/" + filename;
                    fileObj.deleteType = "DELETE";
                    //public string deleteUrl { get; set; }
                    //public string deleteType { get; set; }
                    try
                    {
                        file.SaveAs(Server.MapPath("~/UploadImages/" + documentNo + "/" + filename));
                    }
                    catch (Exception ex)
                    {
                        fileObj.error = ex.Message;

                    }
                    myfiles.Add(fileObj);
                    /*HERE WILL BE YOUR CODE TO SAVE THE FILE DETAIL IN DATA BASE*/
                }

                return Json(new { files = myfiles });
            }
            catch
            {
                return Json(false);
            }

            // return Json("Success");
        }
    }

    public class file
    {
        public string url { get; set; }
        public string name { get; set; }
        public string thumbnailUrl { get; set; }
        public string error { get; set; }
        public int size { get; set; }
        public string deleteUrl { get; set; }
        public string deleteType { get; set; }
    }

    public class InspectionDomesticVm
    {
        public List<InspectionDomestic> inspectionDomesticList { get; set; }
        public string branchId { get; set; }
        public string documentNo { get; set; }
        public string poNo { get; set; }

        public InspectionDomesticVm()
        {
            this.inspectionDomesticList = new List<InspectionDomestic>();
        }
    }

    public class InspectionOverseas2
    {
        // Constructor 
        public InspectionOverseas2() { }

        [DisplayName("DocumentNo")]
        public string DocumentNo { get; set; }

        [DisplayName("ProductCode")]
        public string ProductCode { get; set; }

        [DisplayName("ReceivedDate")]
        public DateTime ReceivedDate { get; set; }

        [DisplayName("SupplierName")]
        public string SupplierName { get; set; }

        [DisplayName("ChemicalName")]
        public string ChemicalName { get; set; }

        [DisplayName("InspectionDate")]
        public DateTime InspectionDate { get; set; }

        [DisplayName("SupplierType")]
        public string SupplierType { get; set; }

        [DisplayName("PINumber")]
        public string PINumber { get; set; }

        [DisplayName("InspectionTime")]
        public DateTime InspectionTime { get; set; }

        [DisplayName("IsRequireLabour")]
        public bool IsRequireLabour { get; set; }

        [DisplayName("ReceivedQty")]
        public string ReceivedQty { get; set; }

        [DisplayName("InspectionQty")]
        public Int32 InspectionQty { get; set; }

        [DisplayName("InvoiceNo")]
        public string InvoiceNo { get; set; }

        [DisplayName("PONo")]
        public string PONo { get; set; }

        /* tab 1 */

        [DisplayName("IsGetCOA")]
        public bool IsGetCOA { get; set; }

        [DisplayName("COASupplier")]
        public string COASupplier { get; set; }

        [DisplayName("IsGetAllItem")]
        public bool IsGetAllItem { get; set; }

        [DisplayName("ChemicalReceiveBatchNo")]
        public string ChemicalReceiveBatchNo { get; set; }
        [DisplayName("MissingItem")]
        public string MissingItem { get; set; }

        [DisplayName("BatchNo")]
        public string BatchNo { get; set; }

        [DisplayName("IsCOAManufactureDate")]
        public bool IsCOAManufactureDate { get; set; }

        [DisplayName("ManufacturerDate")]
        public DateTime ManufacturerDate { get; set; }

        [DisplayName("IsCOAExpiryDate")]
        public bool IsCOAExpiryDate { get; set; }

        [DisplayName("ExpiryDate")]
        public DateTime ExpiryDate { get; set; }

        [DisplayName("TestResult")]
        public bool TestResult { get; set; }

        [DisplayName("InspectionResult")]
        public bool InspectionResult { get; set; }

        /* tab 2 */

        [DisplayName("Manufacturer")]
        public string Manufacturer { get; set; }

        [DisplayName("ContainerNo")]
        public string ContainerNo { get; set; }

        [DisplayName("ContainerType")]
        public string ContainerType { get; set; }

        /* tab 3 */
        [DisplayName("StoreQtyBatchNo")]
        public string StoreQtyBatchNo { get; set; }

        [DisplayName("Homogenious")]
        public Int16 Homogenious { get; set; }

        [DisplayName("IsSameAsSampleProduct")]
        public bool IsSameAsSampleProduct { get; set; }

        [DisplayName("IsWet")]
        public bool IsWet { get; set; }

        [DisplayName("ChemicalCondition")]
        public Int16 ChemicalCondition { get; set; }

        [DisplayName("AcceptStatus")]
        public Int16 AcceptStatus { get; set; }

        [DisplayName("AcceptRemarks")]
        public string AcceptRemarks { get; set; }

        [DisplayName("ContaminationRemarks")]
        public string ContaminationRemarks { get; set; }

        [DisplayName("BagCondition")]
        public Int16 BagCondition { get; set; }

        [DisplayName("BagWeight")]
        public string BagWeight { get; set; }

        [DisplayName("IsGoodCondition")]
        public bool IsGoodCondition { get; set; }
    }

    public class ShipmentIndentListVm
    {
        public string DocumentNo { get; set; }
        public DateTime? DocumentDate { get; set; }

        public string SupplierCode { get; set; }

        public string SupplierName { get; set; }

        public string CustomerCode { get; set; }

        public string CustomerName { get; set; }
    }

}
