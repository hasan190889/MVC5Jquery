using Demo.Models;
using System;
using System.Web.Mvc;

namespace Demo.Controllers
{
    public class HomeController : Controller
    {
        #region Declaration

        DatabaseHandler handler = new DatabaseHandler();

        #endregion

        #region Public Methods

        /// <summary>
        /// Calls Index view
        /// </summary>
        /// <returns>View</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Gets list of all users
        /// </summary>
        /// <returns>List in json format</returns>
        public JsonResult GetAllUsers()
        {
            return Json(handler.GetAllUser(), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Adds or updates a record in database
        /// </summary>
        /// <param name="user">User object</param>
        /// <returns>Users list</returns>
        public JsonResult AddUpdateUser(User user)
        {
            handler.AddUpdateUser(user);
            return GetAllUsers();
        }
                
        /// <summary>
        /// Deletes user's record from database
        /// </summary>
        /// <param name="ID">User Id</param>
        /// <returns>User list</returns>
        public JsonResult Delete(int userId)
        {
            handler.DeleteUser(userId);
            return GetAllUsers();
        }

        #endregion
    }
}