using System.Web.Mvc;

namespace NetStock.Areas.Quotation
{
    public class QuotationAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "Quotation";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            //context.MapRoute(
            //    "Quotation_default",
            //    "Quotation/{controller}/{action}/{id}",
            //    new { action = "Index", id = UrlParameter.Optional }
            //);

            context.Routes.MapMvcAttributeRoutes();
        }
    }
}