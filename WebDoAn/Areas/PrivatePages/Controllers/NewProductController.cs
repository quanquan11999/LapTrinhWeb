using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebDoAn.Areas.PrivatePages.Controllers
{
    public class NewProductController : Controller
    {
        // GET: PrivatePages/NewProduct
        public ActionResult Index()
        {
            return View();
        }
    }
}