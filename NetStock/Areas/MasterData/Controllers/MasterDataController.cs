using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NetStock.ActionFilters;


namespace NetStock.Areas.MasterData.Controllers
{
    [Authorize]
    [SessionFilter]
    [RouteArea("MasterData")]
    public class MasterDataController : Controller
    {
        // GET: MasterData/MasterData
        public ActionResult Index()
        {
            return View();
        }


        #region Company

        


        [Route("Company")]
        [AcceptVerbs(HttpVerbs.Get | HttpVerbs.Post)]
        public ActionResult CompanyProfile(string companyCode)
        {
            Company company;
            if (companyCode != null)
                company = new NetStock.BusinessFactory.CompanyBO().GetCompany(new Company { CompanyCode = companyCode });
            else
                company = new Company();

            company.CountryList = Utility.GetCountryList();
            //return View("CompanyProfile");
            return View(company);
        }

        [ChildActionOnly]
        [Route("GetCompanies")]
        public PartialViewResult GetCompanies()
        {
            var companyList = new NetStock.BusinessFactory.CompanyBO().GetList();
            return PartialView(companyList);
        }


        

        [HttpPost]
        [Route("SaveCompanyProfile")]
        public ActionResult SaveCompanyProfile(NetStock.Contract.Company company)
        {

            company.CreatedBy = Utility.DEFAULTUSER;
            company.ModifiedBy = Utility.DEFAULTUSER;
            company.IsActive = Utility.DEFAULTSTATUS;


            if (company.CompanyAddress.AddressId == 0 || company.CompanyAddress.AddressId == null)
            {
                company.CompanyAddress.AddressType = "Company";
                company.CompanyAddress.SeqNo = 1;
                company.CompanyAddress.AddressLinkID = company.CompanyCode;

            }

            var result = new NetStock.BusinessFactory.CompanyBO().SaveCompany(company);

            return RedirectToAction("CompanyProfile", "MasterData", new { companyCode = company.CompanyCode });
             
        }

        #endregion

        #region Branch

        


        [Route("Branch")]
        [HttpGet]
        public ActionResult BranchProfile(string companyCode, string branchCode)
        {
            var branchprofile = new NetStock.Contract.Branch();
            branchprofile.CompanyCode = companyCode;

            if(branchCode!="NEW")
            { 
                branchprofile = new NetStock.BusinessFactory.BranchBO().GetBranch(new NetStock.Contract.Branch { BranchCode = branchCode });
            }

            if (branchprofile==null)
            {
                branchprofile = new NetStock.Contract.Branch();
            }

            branchprofile.CountryList = Utility.GetCountryList();

            return View(branchprofile);
        }

        [HttpPost]
        [Route("SaveBranchProfile")]
        public ActionResult SaveBranchProfile(NetStock.Contract.Branch branch)
        {

            branch.CreatedBy = Utility.DEFAULTUSER;
            branch.ModifiedBy = Utility.DEFAULTUSER;
            branch.IsActive = Utility.DEFAULTSTATUS;

            if (branch.BranchAddress.AddressId == 0 || branch.BranchAddress.AddressId == null)
            {
                branch.BranchAddress.AddressType = "Branch";
                branch.BranchAddress.SeqNo = 1;
                branch.BranchAddress.IsActive = true;
                branch.BranchAddress.AddressLinkID = branch.BranchCode;

            }
            var result = new NetStock.BusinessFactory.BranchBO().SaveBranch(branch);            

            return RedirectToAction("BranchProfile", "MasterData", new { companyCode = branch.CompanyCode, branchCode = branch.BranchCode });
        }


        #endregion


        #region Product Master



        [Route("Products")]
        public ActionResult Products()
        {

            var products = new NetStock.BusinessFactory.ProductBO().GetList().Where(pr => pr.Status == true).ToList();

            return View("Products", products);
        }

        [Route("EditProduct")]
        [HttpGet]
        public ActionResult EditProduct(string productCode, string barcode, string uom, string size, string color)
        {
            var product = new NetStock.Contract.Product();

            if (productCode != null && productCode.Length > 0)
            {
                if (productCode == "NEW")
                {
                    product = new NetStock.Contract.Product();
                }
                else
                {
                    product = new NetStock.BusinessFactory.ProductBO().GetProduct(new Contract.Product { ProductCode = productCode, BarCode = barcode, UOM = uom, Size = size, Color = color });

                    product.Photo = new NetStock.BusinessFactory.ProductImageBO().GetProductImage(product.ProductCode);
                }
            }
            product.UOMList = Utility.GetLookupItemList("UOM");
            product.ProductCategoryList = Utility.GetProductCategory();
            product.LocationList = Utility.GetLocationList();


            //return PartialView("AddProduct", product);
            return PartialView("NewProduct", product);
        }

        [Route("EditProduct1")]
        [HttpPost]
        public ActionResult EditProduct1(Product product)
        {

            if (!ModelState.IsValid)
            {
                return View("EditProduct", product);
            }

            try
            {
                foreach (string file in Request.Files)
                {
                    string fileName = file;
                }

                product.CreatedBy = Utility.DEFAULTUSER;
                product.ModifiedBy = Utility.DEFAULTUSER;
                product.Status = true;


                var result = new NetStock.BusinessFactory.ProductBO().SaveProduct(product);


                return Json(new { success = true });
            }
            catch (Exception ex)
            {

                throw ex;
            }



        }


        [Route("CheckDuplicateProduct")]
        [HttpPost]
        public JsonResult CheckDuplicateProduct(string productDescription, string barCode)
        {

            try
            {

                var product = new NetStock.BusinessFactory.ProductBO().CheckDuplicateProduct(productDescription, barCode);

                if (product != null)
                {
                    //return Json(new { success = true });
                    //return Json(new { result = true, Message = "Product Already exists", productCode = product });
                    return this.Json(new { Message = "Product Already Exists!", productCode = product }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    //return Json(new { result = false,productCode = "" });
                    return this.Json(new { Message = "", productCode = "" }, JsonRequestBehavior.AllowGet);
                }

            }
            catch (Exception ex)
            {

                throw ex;
            }



        }


        [Route("AddProduct")]
        [HttpGet]
        public ActionResult AddProduct(string productCode, string uom = "")
        {

            var product = new NetStock.Contract.Product();
             
               

                if (productCode != null && productCode.Length > 0)
                {
                    if (productCode == "NEW")
                    {
                        product = new NetStock.Contract.Product();
                        product.Status = true;
                    }
                    else
                    {
                        product = new NetStock.BusinessFactory.ProductBO().GetProduct(new Contract.Product { ProductCode = productCode, UOM = uom });
                        product.Photo = new NetStock.BusinessFactory.ProductImageBO().GetProductImage(product.ProductCode);
                    }
                }
                product.UOMList = Utility.GetLookupItemList("UOM");
                product.ProductCategoryList = Utility.GetProductCategory();
                product.LocationList = Utility.GetLookupItemList("LOCATION");             
            
            return View("AddProduct", product);
        }

        /*
        [Route("AddProduct")]
        [HttpGet]
        public ActionResult AddProduct(string productCode, string barcode = "", string uom = "", string size = "", string color = "")
        {

            var product = new NetStock.Contract.Product();



            if (productCode != null && productCode.Length > 0)
            {
                if (productCode == "NEW")
                {
                    product = new NetStock.Contract.Product();
                    product.Status = true;
                }
                else
                {
                    product = new NetStock.BusinessFactory.ProductBO().GetProduct(new Contract.Product { ProductCode = productCode, BarCode = barcode, UOM = uom, Size = size, Color = color });

                    product.Photo = new NetStock.BusinessFactory.ProductImageBO().GetProductImage(product.ProductCode);

                    //string imageBase64Data = Convert.ToBase64String(product.Photo.ProductImg);
                    //string imageDataURL = string.Format("data:image/png;base64,{0}", imageBase64Data);
                    //ViewBag.ImageData = imageDataURL;

                }
            }
            product.UOMList = Utility.GetLookupItemList("UOM");
            product.ProductCategoryList = Utility.GetProductCategory();
            //product.LocationList = Utility.GetLocationList();
            product.LocationList = Utility.GetLookupItemList("LOCATION");

            //var t = new FileContentResult(product.Photo.ProductImg, "image/jpeg");
            //ViewBag.Test = t;
            //return PartialView("AddProduct", product);
            return View("AddProduct", product);
        }
        */





        public FileContentResult GetImage(string productCode)
        {
            NetStock.Contract.Product product = new NetStock.Contract.Product();

            product.Photo = new NetStock.BusinessFactory.ProductImageBO().GetProductImage(productCode);

            byte[] byteArray = product.Photo.ProductImg;
            return byteArray != null
                           ? new FileContentResult(byteArray, "image/jpeg")
                           : null;


            //return File(product.Photo.ProductImg, "image/jpg");
        }


        [Route("AddProduct")]
        [HttpPost]
        public ActionResult AddProduct(Product product)
        {

            try
            {

                if (product.ProductCode == "NEW" || product.ProductCode == "")
                {

                    var objduplicate = new NetStock.BusinessFactory.ProductBO().CheckDuplicateProduct(product.Description, product.BarCode);
                    if (objduplicate != null)
                    {
                        return Json(new { success = false, Message = "Either Product Description or Barcode is duplicate", productCode = product.ProductCode });
                    }
                }

                byte[] fileData = null;
                var fileName = string.Empty;
                foreach (string file in Request.Files)
                {

                    HttpPostedFileBase currentfile = Request.Files[file];
                    fileName = currentfile.FileName;
                    using (var binaryReader = new BinaryReader(currentfile.InputStream))
                    {
                        fileData = binaryReader.ReadBytes(currentfile.ContentLength);
                    }
                    
                }
                ProductImage pImage = new ProductImage();

                pImage.ProductImg = fileData;
                pImage.Code = product.ProductCode;
                pImage.FileName = fileName;

                product.CreatedBy = Utility.DEFAULTUSER;
                product.ModifiedBy = Utility.DEFAULTUSER;
                product.Status = true;
                product.Photo = pImage;


                var result = new NetStock.BusinessFactory.ProductBO().SaveProduct(product);

                @TempData["isSaved"] = result;
                

                if (result)
                {
                    @TempData["resultMessage"] = string.Format("Product [{0}] Saved Successfully", product.ProductCode);
                }
                else {
                    @TempData["resultMessage"] = "Unable to Save the Record!";
                }
                
                
                //return Json(new { success = true, Message = "Product Saved successfully.", productCode = product.ProductCode });

                //return Json(new { success = true });
            }
            catch (Exception ex)
            {
                @TempData["isSaved"] = false;
                @TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("Products", "MasterData");

        }


        [Route("DeleteProduct")]
        [HttpPost]
        public JsonResult DeleteProduct(string productCode)
        {

            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.ProductBO().DeleteProduct(new NetStock.Contract.Product { ProductCode = productCode, ModifiedBy = Utility.DEFAULTUSER });

            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }

            return Json(new { result = result, Message = "Product deleted successfully.", productCode = productCode });


        }

        #endregion


        #region Test Upload PHOTO

        [Route("TestUpload")]
        public ActionResult TestUpload()
        {
            return View();
        }

        [Route("TestPhotoUpload")]
        [HttpPost]
        public ActionResult TestPhotoUpload()
        {
            foreach (string item in Request.Files)
            {

            }
            return Json(new { Message = "" });
        }


        #endregion

        #region Supplier



        [Route("Suppliers")]
        public ActionResult Suppliers()
        {

            var suppliers = new NetStock.BusinessFactory.CustomerBO().GetList().Where(cs => cs.CustomerType == "SUPPLIER").ToList();

            return View("Suppliers", suppliers);
            //return View(Suppliers);
        }

        [Route("EditSupplier")]
        [HttpGet]
        public ActionResult EditSupplier(string customerCode)
        {


            NetStock.Contract.Customer supplier = new Contract.Customer();

            if (customerCode == "NEW")
            {
                supplier.CustomerCode = customerCode;
                customerCode = "";
                supplier.Status = true;
            }
            if (customerCode != null && customerCode.Length > 0)
            {
                supplier = new NetStock.BusinessFactory.CustomerBO().GetCustomer(new Contract.Customer { CustomerCode = customerCode });
            }

            supplier.CountryList = NetStock.Utility.GetCountryList();
            supplier.CustomerModeList = NetStock.Utility.GetLookupItemList("SUPPLIERTYPE");
            return View("AddSupplier", supplier);
            //return View(Suppliers);
        }

        [Route("EditSupplier")]
        [HttpPost]
        public ActionResult EditSupplier(NetStock.Contract.Customer supplier)
        {


            try
            {


                supplier.CreatedBy = Utility.DEFAULTUSER;
                supplier.ModifiedBy = Utility.DEFAULTUSER;
                supplier.CustomerType = "SUPPLIER";
                supplier.Status = true;

                if (supplier.CustomerAddress.AddressId == 0 || supplier.CustomerAddress.AddressId == null)
                {
                    supplier.CustomerAddress.AddressType = "SUPPLIER";// "Customer";
                    supplier.CustomerAddress.SeqNo = 1;
                    supplier.CustomerAddress.AddressLinkID = supplier.CustomerCode;

                }
                var result = new NetStock.BusinessFactory.CustomerBO().SaveCustomer(supplier);



            }
            catch (Exception ex)
            {

                throw ex;
            }



            return RedirectToAction("Suppliers");
            //return View(Suppliers);
        }


        [Route("DeleteSupplier")]
        [HttpGet]
        public ActionResult DeleteSupplier(string supplierCode)
        {

            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.CustomerBO().DeleteCustomer(new NetStock.Contract.Customer { CustomerCode = supplierCode, ModifiedBy = Utility.DEFAULTUSER });

                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = string.Format("Customer [{0}] Deleted Successfully", supplierCode);
                else
                    TempData["resultMessage"] = "Unable to DELETE the Record!";
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            //return Json(new { result = result, Message = "Supplier deleted successfully.", supplierCode = supplierCode });
            return RedirectToAction("Suppliers");


        }


        /*
        [Route("SaveProd")]
        [HttpPost]
        public JsonResult SaveProd(string data)
        {
            JsonResult jr=new JsonResult();

            var lstResult = data.Split('$').ToList();

            NetStock.Contract.CustomerProduct cp = new Contract.CustomerProduct();
            cp.ProductCode = lstResult[1];
            cp.MatchProductCode = lstResult[0];
            cp.BarCode = lstResult[2];
            cp.CostPrice = Convert.ToDecimal(lstResult[3].ToString());

            // now do we need to split the string and put into the CustomerProduct object ? 
            // 

            var supplier = new NetStock.Contract.Customer();

            //return jr;

            var lstproducts = new List<NetStock.Contract.CustomerProduct>();

            lstproducts.Add(cp);

            supplier.CustomerProducts = lstproducts;

            

            //return View("SupplierProduct", supplier);

            return Json(supplier, JsonRequestBehavior.AllowGet);
        }
        */

        #endregion

        #region Customer



        [Route("Customers")]
        public ActionResult Customers()
        {
            var customers = new NetStock.BusinessFactory.CustomerBO().GetList().Where(cs => cs.CustomerType == "CUSTOMER").ToList();

            return View("Customers", customers);

        }

        [Route("EditCustomer")]
        [HttpGet]
        public ActionResult EditCustomer(string customerCode)
        {

            NetStock.Contract.Customer customer = new Contract.Customer();

            if (customerCode == "NEW" || customerCode == "")
            {
                customer.CustomerCode = customerCode;
                customer.CustomerCode = "";
                customer.Status = true;
            }

            if (customerCode != null && customerCode.Length > 0)
            {
                if (customerCode != "NEW")
                {
                    customer = new NetStock.BusinessFactory.CustomerBO().GetCustomer(new Contract.Customer { CustomerCode = customerCode });
                }

            }

            customer.CountryList = NetStock.Utility.GetCountryList();
            return View("AddCustomer", customer);
            //return View(Suppliers);
        }

        [Route("GetCustomer")]
        [HttpGet]
        public JsonResult GetCustomer(string customerCode)
        {

            NetStock.Contract.Customer customer = new Contract.Customer();
            customer = new NetStock.BusinessFactory.CustomerBO().GetCustomer(new Contract.Customer { CustomerCode = customerCode });
            customer.CountryList = NetStock.Utility.GetCountryList();

            return Json(customer);

        }


        [Route("EditCustomer")]
        [HttpPost]
        public ActionResult EditCustomer(NetStock.Contract.Customer customer)
        {


            try
            {


                customer.CreatedBy = Utility.DEFAULTUSER;
                customer.ModifiedBy = Utility.DEFAULTUSER;
                customer.CustomerMode = Utility.DEFAULTCUSTOMERMODE;
                customer.CustomerType = "CUSTOMER";
                customer.Status = true;

                if (customer.CustomerAddress.AddressId == 0 || customer.CustomerAddress.AddressId == null)
                {
                    customer.CustomerAddress.AddressType = "Customer";
                    customer.CustomerAddress.SeqNo = 1;
                    customer.CustomerAddress.AddressLinkID = customer.CustomerCode;

                }
                var result = new NetStock.BusinessFactory.CustomerBO().SaveCustomer(customer);



            }
            catch (Exception ex)
            {

                throw ex;
            }



            return RedirectToAction("Customers");
            //return View(Suppliers);
        }



        [Route("DeleteCustomer")]
        [HttpGet]
        public ActionResult DeleteCustomer(string customerCode)
        {

            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.CustomerBO().DeleteCustomer(new NetStock.Contract.Customer { CustomerCode = customerCode, ModifiedBy = Utility.DEFAULTUSER });
                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = string.Format("Customer [{0}] Deleted Successfully", customerCode);
                else
                    TempData["resultMessage"] = "Unable to DELETE the Record!";
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("Customers");


        }

        #endregion

        #region Supplier Product



        [Route("SupplierProducts")]
        [HttpGet]
        public ActionResult SupplierProducts(string supplierCode)
        {
            NetStock.Contract.Customer supplier = new Contract.Customer();




            supplier = new NetStock.BusinessFactory.CustomerBO().GetCustomer(new Contract.Customer { CustomerCode = supplierCode });

            if (supplier.CustomerType == "SUPPLIER")
            {
                supplier.CustomerProducts = new NetStock.BusinessFactory.CustomerProductBO().GetCustomerProductsList(supplier.CustomerCode);
            }

            if (supplier.CustomerProducts == null || supplier.CustomerProducts.Count == 0)
                supplier.CustomerProducts = new List<Contract.CustomerProduct>();

            return View("SupplierProduct", supplier);
        }

        [Route("SupplierProducts")]
        [HttpPost]
        public ActionResult SupplierProducts(NetStock.Contract.Customer supplier)
        {

            var items = ((NetStock.Contract.Customer)HttpContext.Session["SupplierProducts"]).CustomerProducts;



            foreach (var item in items)
            {
                item.CustomerCode = supplier.CustomerCode;
                item.CustomerName = supplier.CustomerName;

                var result = new NetStock.BusinessFactory.CustomerProductBO().SaveCustomerProduct(item);

            }

            return RedirectToAction("Suppliers");
        }




        [Route("SupplierProductList")]
        public ActionResult SupplierProductList(string supplierCode)
        {
            var productlist = new NetStock.BusinessFactory.CustomerProductBO().GetList();

            return PartialView("SupplierProductList", productlist);

        }

        [Route("EditSupplierProduct")]
        [HttpGet]
        public ActionResult EditSupplierProduct(string supplierCode, string productCode)
        {
            NetStock.Contract.CustomerProduct customerproduct = new Contract.CustomerProduct();

            customerproduct.MatchProductList = NetStock.Utility.GetProductList();

            return PartialView("AddSupplierProduct", customerproduct);

        }




        [Route("SaveSupplierProduct")]
        [HttpPost]
        public JsonResult SaveSupplierProduct(NetStock.Contract.Customer supplier)
        {
            try
            {
                supplier.Status = true;
                supplier.CreatedBy = Utility.DEFAULTUSER;
                supplier.ModifiedBy = Utility.DEFAULTUSER;

                var lstCustomerProducts = supplier.CustomerProducts;

                if (lstCustomerProducts != null || lstCustomerProducts.Count > 0)
                {
                    lstCustomerProducts.Update(p => { p.CustomerCode = supplier.CustomerCode; p.CostPrice = 0; });
                }


                var result = new NetStock.BusinessFactory.CustomerProductBO().SaveList(lstCustomerProducts);
            }
            catch (Exception ex)
            {

                ModelState.AddModelError("Error", ex.Message);
            }



            return Json(new { success = true, Message = "Products saved successfully.", supplierData = supplier });

        }


        [Route("DeleteSupplierProducts")]
        [HttpPost]
        public JsonResult DeleteSupplierProducts(string supplierCode)
        {
            try
            {

                var result = new NetStock.BusinessFactory.CustomerProductBO().DeleteAllCustomerProducts(supplierCode);
            }
            catch (Exception ex)
            {

                ModelState.AddModelError("Error", ex.Message);
            }



            return Json(new { success = true, Message = "Products Deleted successfully.", SupplierCode = supplierCode });

        }


        #endregion


        #region UOM
        [Route("UOMList")]
        [HttpGet]
        public ActionResult UOMList()
        {
            var lstUOM = new NetStock.BusinessFactory.LookupBO().GetList().Where(dt => dt.Category == "UOM" && dt.Status == true).ToList();
            return View("UOMList", lstUOM);
        }


 

        [Route("EditUOM")]
        [HttpGet]
        public ActionResult EditUOM(string lookupCode)
        {
            var uom = new NetStock.Contract.Lookup();

            if (lookupCode != null && lookupCode.Length > 0)
                uom = new NetStock.BusinessFactory.LookupBO().GetList().Where(dt => dt.Category == "UOM" && dt.LookupCode == lookupCode).FirstOrDefault();

            return PartialView("UOM", uom);
        }


        [Route("EditUOM")]
        [HttpPost]
        public ActionResult SaveUOM(NetStock.Contract.Lookup uomItem)
        {
            try
            {
                if (uomItem == null)
                    return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);


                uomItem.Status = true;
                uomItem.Category = "UOM";
                uomItem.Description2 = "";
                var result = new NetStock.BusinessFactory.LookupBO().SaveLookup(uomItem);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }
            return RedirectToAction("UOMList");
        }


        [Route("DeleteUOM")]
        [HttpGet]
        public ActionResult DeleteUOM(string lookupCode)
        {

            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.LookupBO().DeleteLookup(new NetStock.Contract.Lookup { LookupCode = lookupCode  });

                TempData["isSaved"] = result;

                if (result)
                    TempData["resultMessage"] = string.Format("UOM [{0}] Deleted Successfully", lookupCode);
                else
                    TempData["resultMessage"] = "Unable to DELETE the Record!";
                
            }
            catch (Exception ex)
            {
                TempData["isSaved"] = false;
                TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }
            return RedirectToAction("UOMList", "MasterData");
        }

        #endregion


        #region IncoTerms

        [Route("IncoTermList")]
        [HttpGet]
        public ActionResult IncoTermList()
        {
            var lstUOM = new NetStock.BusinessFactory.LookupBO().GetList().Where(dt => dt.Category == "INCOTERM" && dt.Status == true).ToList();
            return View("IncoTermList", lstUOM);
        }


        [Route("EditIncoTerm")]
        [HttpGet]
        public ActionResult EditIncoTerm(string lookupCode)
        {
            var uom = new NetStock.Contract.Lookup();

            if (lookupCode != null && lookupCode.Length > 0)
                uom = new NetStock.BusinessFactory.LookupBO().GetList().Where(dt => dt.Category == "INCOTERM" && dt.LookupCode == lookupCode).FirstOrDefault();

            return PartialView("IncoTerm", uom);
        }


        [Route("EditIncoTerm")]
        [HttpPost]
        public ActionResult SaveIncoTerm(NetStock.Contract.Lookup uomItem)
        {
            try
            {
                if (uomItem == null)
                    return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);


                uomItem.Status = true;
                uomItem.Category = "INCOTERM";
                uomItem.Description2 = "";
                var result = new NetStock.BusinessFactory.LookupBO().SaveLookup(uomItem);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }
            return RedirectToAction("IncoTermList");
        }


        [Route("DeleteIncoTerm")]
        [HttpGet]
        public ActionResult DeleteIncoTerm(string lookupCode)
        {

            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.LookupBO().DeleteLookup(new NetStock.Contract.Lookup { LookupCode = lookupCode });
                TempData["isSaved"] = result;

                if (result)
                    @TempData["resultMessage"] = string.Format("INCO-TERM [{0}] Deleted Successfully", lookupCode);
                else
                    @TempData["resultMessage"] = "Unable to DELETE the Record!";
            }
            catch (Exception ex)
            {
                @TempData["isSaved"] = false;
                @TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString()); 
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("IncoTermList", "MasterData");


        }



        #endregion


        #region Warehouse Location
        [Route("LocationList")]
        [HttpGet]
        public ActionResult LocationList()
        {
            var lstLookup = new NetStock.BusinessFactory.LookupBO().GetList().Where(dt => dt.Category == "LOCATION" && dt.Status == true).ToList();
            return View("LocationList", lstLookup);
        }


        [Route("EditLocation")]
        [HttpGet]
        public ActionResult EditLocation(string lookupCode)
        {
            var location = new NetStock.Contract.Lookup();

            if (lookupCode != null && lookupCode.Length > 0)
                location = new NetStock.BusinessFactory.LookupBO().GetList().Where(dt => dt.Category == "LOCATION" && dt.LookupCode == lookupCode).FirstOrDefault();

            return PartialView("WareHouseLocation", location);
        }


        [Route("EditLocation")]
        [HttpPost]
        public ActionResult SaveLocation(NetStock.Contract.Lookup locationItem)
        {
            try
            {
                if (locationItem == null)
                    return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);


                locationItem.Status = true;
                locationItem.Category = "LOCATION";
                locationItem.Description2 = "";
                var result = new NetStock.BusinessFactory.LookupBO().SaveLookup(locationItem);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }
            return RedirectToAction("LocationList");
        }

        [Route("DeleteLocationList")]
        [HttpGet]
        public ActionResult DeleteLocationList(string locationCode)
        {
            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.LookupBO().DeleteLookup(new NetStock.Contract.Lookup { LookupCode = locationCode });
                TempData["isSaved"] = result;

                if (result)
                    @TempData["resultMessage"] = string.Format("Product Category  [{0}] Deleted Successfully", locationCode);
                else
                    @TempData["resultMessage"] = "Unable to DELETE the Record!";
            }
            catch (Exception ex)
            {
                @TempData["isSaved"] = false;
                @TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("LocationList", "MasterData");
        }

        #endregion


        #region Payment Type

        [Route("PaymentTypeList")]
        [HttpGet]
        public ActionResult PaymentTypeList()
        {
            var lstLookup = new NetStock.BusinessFactory.LookupBO().GetList().Where(dt => dt.Category == "PAYMENTTYPE" && dt.Status == true).ToList();
            return View("PaymentTypeList", lstLookup);
        }


        [Route("EditPaymentType")]
        [HttpGet]
        public ActionResult EditPaymentType(string lookupCode)
        {
            var location = new NetStock.Contract.Lookup();

            if (lookupCode != null && lookupCode.Length > 0)
                location = new NetStock.BusinessFactory.LookupBO().GetList().Where(dt => dt.Category == "PAYMENTTYPE" && dt.LookupCode == lookupCode).FirstOrDefault();

            return PartialView("PaymentType", location);
        }


        [Route("EditPaymentType")]
        [HttpPost]
        public ActionResult SavePaymentType(NetStock.Contract.Lookup paymentTypeItem)
        {
            try
            {
                if (paymentTypeItem == null)
                    return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);


                paymentTypeItem.Status = true;
                paymentTypeItem.Category = "PAYMENTTYPE";
                paymentTypeItem.Description2 = "";
                var result = new NetStock.BusinessFactory.LookupBO().SaveLookup(paymentTypeItem);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }
            return RedirectToAction("PaymentTypeList");
        }

        [Route("DeletePaymentType")]
        [HttpGet]
        public ActionResult DeletePaymentType(string paymentTypeCode)
        {
            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.LookupBO().DeleteLookup(new NetStock.Contract.Lookup { LookupCode = paymentTypeCode });
                TempData["isSaved"] = result;

                if (result)
                    @TempData["resultMessage"] = string.Format("Payment Type  [{0}] Deleted Successfully", paymentTypeCode);
                else
                    @TempData["resultMessage"] = "Unable to DELETE the Record!";
            }
            catch (Exception ex)
            {
                @TempData["isSaved"] = false;
                @TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("PaymentTypeList", "MasterData");
        }



        #endregion


        #region Product Category
        [Route("ProductCategoryList")]
        [HttpGet]
        public ActionResult ProductCategoryList()
        {
            var lstLookup = new NetStock.BusinessFactory.ProductCategoryBO().GetList();
            return View("ProductCategoryList", lstLookup);
        }




        [Route("DeleteProductCategory")]
        [HttpGet]
        public ActionResult DeleteProductCategory(string categoryCode)
        {
            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.ProductCategoryBO().DeleteProductCategory(new NetStock.Contract.ProductCategory { CategoryCode = categoryCode });
                TempData["isSaved"] = result;

                if (result)
                    @TempData["resultMessage"] = string.Format("Product Category  [{0}] Deleted Successfully", categoryCode);
                else
                    @TempData["resultMessage"] = "Unable to DELETE the Record!";
            }
            catch (Exception ex)
            {
                @TempData["isSaved"] = false;
                @TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            return RedirectToAction("ProductCategoryList", "MasterData");
        }

        [Route("EditProductCategory")]
        [HttpGet]
        public ActionResult EditProductCategory(string categoryCode)
        {
            var productCategory = new NetStock.Contract.ProductCategory();

            if (categoryCode != null && categoryCode.Length > 0)
                productCategory = new NetStock.BusinessFactory.ProductCategoryBO().GetProductCategory(new ProductCategory { CategoryCode = categoryCode });

            return PartialView("ProductCategory", productCategory);
        }


        [Route("EditProductCategory")]
        [HttpPost]
        public ActionResult SaveProductCategory(NetStock.Contract.ProductCategory productCategory)
        {
            try
            {
                if (productCategory == null)
                    return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);


                productCategory.CreatedBy = Utility.DEFAULTUSER;
                productCategory.ModifiedBy = Utility.DEFAULTUSER;
                
                var result = new NetStock.BusinessFactory.ProductCategoryBO().SaveProductCategory(productCategory);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }
            return RedirectToAction("ProductCategoryList");
        }


        #endregion



        #region Currency

        [Route("CurrencyList")]
        [HttpGet]
        public ActionResult CurrencyList()
        {
            var lstCurrency = new NetStock.BusinessFactory.CurrencyBO().GetList().ToList();
            return View("CurrencyList", lstCurrency);
        }


        [Route("EditCurrency")]
        [HttpGet]
        public ActionResult EditCurrency(string CurrencyCode)
        {
            var currency = new NetStock.Contract.Currency();

            if (CurrencyCode != null && CurrencyCode.Length > 0)
                currency = new NetStock.BusinessFactory.CurrencyBO().GetList().Where(dt => dt.CurrencyCode == CurrencyCode).FirstOrDefault();

            return PartialView("Currency", currency);
        }


        [Route("EditCurrency")]
        [HttpPost]
        public ActionResult SaveCurrency(NetStock.Contract.Currency currencyItem)
        {
            try
            {
                if (currencyItem == null)
                    return new HttpStatusCodeResult(System.Net.HttpStatusCode.BadRequest);


                currencyItem.CurrencyCode = currencyItem.CurrencyCode;
                currencyItem.Description = currencyItem.Description;
                currencyItem.Description1 = currencyItem.Description1;
                var result = new NetStock.BusinessFactory.CurrencyBO().SaveCurrency(currencyItem);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }
            return RedirectToAction("CurrencyList");
        }


        [Route("DeleteCurrency")]
        [HttpGet]
        public ActionResult DeleteCurrency(string CurrencyCode)
        {

            var result = false;

            string message = string.Empty;
            try
            {
                result = new NetStock.BusinessFactory.CurrencyBO().DeleteCurrency(new NetStock.Contract.Currency { CurrencyCode = CurrencyCode });

                @TempData["isSaved"] = result;

                if (result)
                    @TempData["resultMessage"] = string.Format("Currency [{0}] Deleted Successfully", CurrencyCode);
                else
                    @TempData["resultMessage"] = "Unable to DELETE the Record!";

            }
            catch (Exception ex)
            {
                @TempData["isSaved"] = false;
                @TempData["resultMessage"] = string.Format("Error Occurred {0}", ex.Message.ToString());
                ModelState.AddModelError("Error", ex.Message);
            }

            //return Json(new { result = result, Message = lookupCode + " Deleted successfully.", UOMCode = lookupCode });

            return RedirectToAction("CurrencyList", "MasterData");

        }

        #endregion


        

        [Route("UpdateCustomerAddress")]
        [HttpPost]
        public JsonResult UpdateCustomerAddress(Customer customer)
        {

            var address = customer.CustomerAddress;
            address.AddressLinkID = customer.CustomerCode;
            address.AddressType = "Customer";
            address.ModifiedBy = Utility.DEFAULTUSER;
            address.CreatedBy = Utility.DEFAULTUSER;
            address.IsActive = true;
            address.IsBilling = true;


            var result = new NetStock.BusinessFactory.AddressBO().SaveAddress(address);

            customer = new NetStock.BusinessFactory.CustomerBO().GetCustomer(new NetStock.Contract.Customer { CustomerCode = customer.CustomerCode });

            return Json(GetFullAddress(customer.CustomerAddress.FullAddress), JsonRequestBehavior.AllowGet);
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



    }
}