using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Configuration;


namespace NetStock.Controllers
{
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

    public class UploadController : Controller
    {
        // GET: Upload
        public ActionResult Index()
        {
            return View();
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
                    string documentsPath = ConfigurationManager.AppSettings["documentsPath"];
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


        [HttpGet]
        [Route("UploadFiles")]
        public JsonResult UploadFiles()
        {
            return Json("", JsonRequestBehavior.AllowGet);
        }
    }
}