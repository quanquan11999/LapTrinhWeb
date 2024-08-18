using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebDoAn.Models;

namespace WebDoAn.Areas.PrivatePages.Controllers
{
    public class DSachBaivietController : Controller
    {
        // GET: PrivatePages/DSachBaiviet
        private static ShopOnlineEntities4 db = new ShopOnlineEntities4();
        private static bool DaDuyet;
        [HttpGet]
        public ActionResult Index(string IsActive)
        {
       
            capnhatdulieu(DaDuyet);

            return View();
        }
        public ActionResult Delete(string maBaiViet)
        {
            BaiViet x = db.BaiViets.Find(maBaiViet);
            db.BaiViets.Remove(x);
            db.SaveChanges();
            capnhatdulieu(DaDuyet);

            return View();

        }
        [HttpPost]
        public ActionResult Active(string maBaiViet)
        {
            BaiViet x = db.BaiViets.Find(maBaiViet);
            x.daDuyet = false;
            db.SaveChanges();

            capnhatdulieu(DaDuyet);
            return View();
        }/// <summary>
         /// Hàm phục vụ cho cập nhật dữ liệu cho view của control
         /// </summary>
        private void capnhatdulieu(bool daDuyet)
        {
            List<BaiViet> l = db.BaiViets.Where(x => x.daDuyet == daDuyet).ToList<BaiViet>();
            ViewData["DSBaiViet"] = l;

        }
    }
}