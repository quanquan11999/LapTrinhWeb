using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using WebDoAn.Models;

namespace WebDoAn.Controllers
{
    public class LoginController : Controller
    {
        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index( string Acc,string Pass)
        {
            string mk = MaHoa.encryptSHA256(Pass);
            // đọc tt tài khoản
            TaiKhoan ttdn = new ShopOnlineEntities4().TaiKhoans.Where(x => x.taiKhoan1.Equals(Acc.ToLower().Trim()) && x.matKhau.Equals(mk)).First<TaiKhoan>();
            bool isAuthentic = ttdn != null && ttdn.taiKhoan1.Equals(Acc.ToLower()) && ttdn.matKhau.Equals(mk);

            if (isAuthentic)
            {
                Session[" TtDangNhap"] = ttdn;

            }
            return View();

        }


    }
}