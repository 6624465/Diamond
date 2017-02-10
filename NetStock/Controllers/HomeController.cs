using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using NetStock.ActionFilters;

namespace NetStock.Controllers
{
    [Authorize]
    [SessionFilter]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult UserProfile()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult User()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        protected override void OnAuthorization(AuthorizationContext filterContext)
        {
            base.OnAuthorization(filterContext);

            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            FormsAuthenticationTicket ticket = null;
            if (authCookie != null)
            {
                ticket = FormsAuthentication.Decrypt(authCookie.Value);
            }
            var url = filterContext.HttpContext.Request.Url;
            if (ticket == null || ticket.Name == "")
            {

                filterContext.Result = new RedirectToRouteResult(
                    new System.Web.Routing.RouteValueDictionary { 
                { "Controller", "Account" }, 
                { "Action", "Login" }
                //{ "RedirectUrl", url } // how do I get this?
            }
                );
            }

        }
    }
}