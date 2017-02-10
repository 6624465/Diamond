using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NetStock.Areas.User.Controllers
{

    [Authorize]
    [RouteArea("User")]
    [ActionFilters.SessionFilter]
    public class UserController : Controller
    {

        public ActionResult Index()
        {
            return View();
        }

        #region Users
        [Route("UserList")]
        [HttpGet]
        public ActionResult UserList()
        {
            var lstUsers = new NetStock.BusinessFactory.UsersBO().GetList();
            return View("UserList", lstUsers);
        }

        [Route("EditUser")]
        [HttpGet]
        public ActionResult EditUser(string userID)
        {
            var user = new NetStock.Contract.Users();

            if (userID == "NEW")
            {
                userID = "";
                user = new Contract.Users();
            }


            if (userID != null && userID.Length > 0)
                user = new NetStock.BusinessFactory.UsersBO().GetUsers(new Contract.Users { UserID = userID });


            user.RoleCodeList = Utility.GetRoleList();

            return View("UserProfile", user);
        }


        [Route("SaveUser")]
        [HttpPost]
        public JsonResult SaveUser(NetStock.Contract.Users user)
        {
            try
            {

                user.LogInStatus = true;
                user.CreatedBy = Utility.DEFAULTUSER;
                user.ModifiedBy = Utility.DEFAULTUSER;
                var result = new NetStock.BusinessFactory.UsersBO().SaveUsers(user);
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("Error", ex.Message);
            }
            return Json(new { success = true, Message = "USER PROFILE saved successfully.", userData = user });
        }

        #endregion

    }
}