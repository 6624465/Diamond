using System.Web;
using System.Web.Optimization;

namespace NetStock
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            //bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
            //            "~/Scripts/jquery-{version}.js"));

            //bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
            //            "~/Scripts/jquery.validate*"));

            //// Use the development version of Modernizr to develop with and learn from. Then, when you're
            //// ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            //bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
            //            "~/Scripts/modernizr-*"));

            //bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
            //          "~/Scripts/bootstrap.js",
            //          "~/Scripts/respond.js"));

            //bundles.Add(new StyleBundle("~/Content/css").Include(
            //          "~/Content/bootstrap.css",
            //          "~/Content/site.css"));



            //bundles.Add(new StyleBundle("~/Content/AdminThemecss").Include(
            //         "~/ThemeAdminLTE-2.2.0/dist/css/AdminLTE.min.css",
            //         "~/ThemeAdminLTE-2.2.0/dist/css/skins/_all-skins.min.css",
            //         "~/ThemeAdminLTE-2.2.0/plugins/iCheck/flat/blue.css",
            //         "~/ThemeAdminLTE-2.2.0/plugins/morris/morris.css",
            //         "~/ThemeAdminLTE-2.2.0/plugins/jvectormap/jquery-jvectormap-1.2.2.css",
            //         "~/ThemeAdminLTE-2.2.0/plugins/datepicker/datepicker3.css",
            //         "~/ThemeAdminLTE-2.2.0/plugins/daterangepicker/daterangepicker-bs3.css",
            //         "~/ThemeAdminLTE-2.2.0/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css"
            //         ));


            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            //bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
            //     "~/Scripts/jquery.unobtrusive*",
            //            "~/Scripts/jquery.validate*"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                   "~/Scripts/jquery.unobtrusive*",
                   "~/Scripts/jquery.validate.js"));


            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css",
                      "~/Content/bootstrap-datetimepicker.css"));

            bundles.Add(new StyleBundle("~/Content/dataTablecss").Include(
                      "~/Scripts/bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.css",
                      "~/Scripts/bower_components/datatables-responsive/css/dataTables.responsive.css",
                      "~/Content/font-awesome.min.css"));

            bundles.Add(new StyleBundle("~/Content/AdminThemecss").Include(
                     "~/ThemeAdminLTE-2.2.0/dist/css/AdminLTE.min.css",
                     "~/ThemeAdminLTE-2.2.0/dist/css/skins/_all-skins.min.css",
                     "~/ThemeAdminLTE-2.2.0/plugins/iCheck/flat/blue.css",
                     "~/ThemeAdminLTE-2.2.0/plugins/morris/morris.css",
                     "~/ThemeAdminLTE-2.2.0/plugins/jvectormap/jquery-jvectormap-1.2.2.css",
                     "~/ThemeAdminLTE-2.2.0/plugins/datepicker/datepicker3.css",
                     "~/ThemeAdminLTE-2.2.0/plugins/daterangepicker/daterangepicker-bs3.css",
                     "~/ThemeAdminLTE-2.2.0/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css"
                     ));








            bundles.Add(new ScriptBundle("~/bundles/modalform").Include(
                    "~/Scripts/modalform.js"));



            bundles.Add(new ScriptBundle("~/bundles/pager").Include(
                    "~/Scripts/jquery.tablesorter.js",
                    "~/Scripts/jquery.tablesorter.pager.js"));

            bundles.Add(new ScriptBundle("~/bundles/dataTable").Include(
                "~/Scripts/bower_components/datatables/media/js/jquery.dataTables.min.js",
                "~/Scripts/bower_components/datatables-plugins/integration/bootstrap/3/dataTables.bootstrap.min.js"
                ));

            //bundles.Add(new ScriptBundle("~/bundles/datetime").Include(
            //        "~/Scripts/moment*",
            //        "~/Scripts/bootstrap-datetimepicker*"));
            bundles.Add(new ScriptBundle("~/bundles/jqueryUI").Include(
                  "~/Scripts/jquery-ui.js"
                   ));


            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                    "~/Content/AdminLTE/css/font-awesome.min.css",
                    "~/Content/AdminLTE/css/ionicons.min.css",
                    "~/Content/AdminLTE/css/morris/morris.css",
                    "~/Content/AdminLTE/css/jvectormap/jquery-jvectormap-1.2.2.css",
                    "~/Content/AdminLTE/css/fullcalendar/fullcalendar.css",
                    "~/Content/AdminLTE/css/daterangepicker/daterangepicker-bs3.css",
                    "~/Content/AdminLTE/css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css",
                    "~/Content/AdminLTE/css/AdminLTE.css"));


            bundles.IgnoreList.Ignore("*.unobtrusive-ajax.min.js", OptimizationMode.WhenDisabled);

        }
    }
}
