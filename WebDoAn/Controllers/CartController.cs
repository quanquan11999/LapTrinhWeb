using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebDoAn.Models;

namespace WebDoAn.Controllers
{
    public class CartController : Controller
    {
        // GET: Cart
        public ActionResult Index()
        {
            CartShop gh = Session["GioHang"] as CartShop;
            //--- truyền ra ngoài
            ViewData["Cart"] = gh;
            return View();
        }
    }
}