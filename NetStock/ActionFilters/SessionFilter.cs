using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NetStock.ActionFilters
{
    public class SessionFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Session["BranchId"] == null && filterContext.HttpContext.Session["BranchId"] == null)
            {
                try
                {
                    if (!filterContext.HttpContext.Request.IsAjaxRequest())
                    {
                        filterContext.Result = new RedirectResult("~/Account/Login");
                    }
                    else
                    {
                        /*
                        filterContext.Result = new JsonResult
                        {
                            Data = new
                            {
                                // put whatever data you want which will be sent
                                // to the client
                                message = "sorry, but you were logged out"
                            },
                            JsonRequestBehavior = JsonRequestBehavior.AllowGet
                        };
                        */
                        
                        filterContext.HttpContext.Response.StatusCode = 401;
                        filterContext.HttpContext.Response.End();
                        
                    }
                }
                catch(Exception ex)
                {
                    throw ex;
                }
            }
        }
    }
}