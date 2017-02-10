using System;
using System.Globalization;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using NetStock.Models;
using System.Web.Security;

namespace NetStock.Controllers
{
    [Authorize]
    public class AccountController : Controller
    {
        public AccountController()
        {
        }


        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;

            LoginViewModel model = new LoginViewModel();

            var compist = new NetStock.BusinessFactory.CompanyBO().GetList();
            model.CompaniesList = new SelectList(compist, "CompanyCode", "CompanyName");
            return View(model);
        }       

        
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public  ActionResult Login(LoginViewModel model, string returnUrl)
        {
            if (!string.IsNullOrEmpty(Request.QueryString["companyCode"]))
            {
                var companyCode = Request.QueryString["companyCode"];
                var branchList = new NetStock.BusinessFactory.BranchBO().GetList().Where(x => x.CompanyCode == companyCode).ToList();
                model.BranchList = new SelectList(branchList, "BranchID", "BranchName");

                var compist = new NetStock.BusinessFactory.CompanyBO().GetList();
                model.CompaniesList = new SelectList(compist, "CompanyCode", "CompanyName");

                return View("Login", model);
            }

            if (!ModelState.IsValid)
            {
                return RedirectToAction("Login");
            }            

            var lstUsers = new NetStock.BusinessFactory.UsersBO().GetList();

            var result = true;

            var currentUser = lstUsers.Where(ur => ur.UserID.ToLower() == model.Email.ToLower() && ur.Password.ToLower() == model.Password.ToLower()).FirstOrDefault();

            if (currentUser == null)
            {
                result = false;
            }


            if (currentUser != null)
            {
                FormsAuthentication.SetAuthCookie(currentUser.UserID, false);

                Utility.DEFAULTUSER = currentUser.UserID;
                Utility.DEFAULTUSERNAME = currentUser.UserName;
                Utility.SsnBranch = model.BranchID;
                Session["BranchId"] = model.BranchID;
                Utility.SsnBranchText = Request.Form["hdnBranchSelected"];

                if (Url.IsLocalUrl(returnUrl) && returnUrl.Length > 1 && returnUrl.StartsWith("/")
                    && !returnUrl.StartsWith("//") && !returnUrl.StartsWith("/\\"))
                {
                    return Redirect(returnUrl);
                }
                else
                {
                    return RedirectToAction("Index", "Home");
                }
            }
            else
            {
                ModelState.AddModelError("", "The user name or password provided is incorrect.");
                return View(model);
            }
            
        }

        [HttpGet]
        [AllowAnonymous]
        public JsonResult GetBranchList(string companyCode)
        {
            var brancList = new NetStock.BusinessFactory.BranchBO().GetList().Where(x => x.CompanyCode == companyCode).ToList();
            return Json(brancList, JsonRequestBehavior.AllowGet);
        }
                
        
        [AllowAnonymous]        
        public ActionResult LogOff()
        {
            
            FormsAuthentication.SignOut();
            Session.Abandon();
            Session.Clear();
            return RedirectToAction("Login", "Account");
        }    

        
    }
}