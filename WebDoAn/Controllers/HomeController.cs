using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebDoAn.Models;

namespace WebDoAn.Controllers
{
    public class HomeController : Controller
    {
        [HttpGet]

        public ActionResult Index()
        {
            string tesMK = MaHoa.encryptSHA256("123");
            List<SanPham> a = Common.getProductByLoaiSP(2);
            return View();
        }
        public ActionResult AddToCart()
        {
            //--- Lấy giỏ hang từ Session ra
            CartShop gh = Session["GioHang"] as CartShop;
            //--- Thêm sản phẩm vừa chọn mua vào giỏ hàng

            //--- Cập nhật giỏ  hàng
            Session["GioHang"] = gh;
            return View("Index");
        }
    }
}