using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebDoAn.Models;

namespace WebDoAn.Controllers
{
    public class BogSighleController : Controller
    {
        // GET: BogSighle
        public ActionResult Index(string maBV)
        {
            ShopOnlineEntities4 db = new ShopOnlineEntities4();
            BaiViet x = db.BaiViets.Where(z => z.maBV == maBV).First<BaiViet>();
            ViewData["BaiCanXem"] = x;
           
            return View();
        }
    }
}