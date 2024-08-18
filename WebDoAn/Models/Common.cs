using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace WebDoAn.Models
{
    public class Common
    {
        public static List<SanPham> getProducts()
        {
            List<SanPham> a = new List<SanPham>();

            DbContext cn = new DbContext("name=ShopOnlineEntities4");
            a = cn.Set<SanPham>().ToList<SanPham>();
            return a;
        }
        public static List<SanPham> getProductByLoaiSP(int maLoai)
        {
            List<SanPham> a = new List<SanPham>();

            DbContext cn = new DbContext("name=ShopOnlineEntities4");
            a = cn.Set<SanPham>().Where(x=> x.maLoai==maLoai).OrderByDescending(z =>z.ngayDang).ToList<SanPham>();
            return a;
        }
        ///<summary>
        ///hàm lấy danh sách các loại hang
        ///</summary>
        public static List<LoaiSP> getCategories()
        {
            return new DbContext("name=ShopOnlineEntities4").Set<LoaiSP>().ToList<LoaiSP>();
        }
        /// <summary>
        /// láy ra bài viết mới nhát từ datbase
        /// </summary>
        /// <param name="n"></param>
        /// <returns></returns>
        public static List<BaiViet> getArticleContent(int n)
        {
            List<BaiViet> l = new List<BaiViet>();
            ShopOnlineEntities4 db = new ShopOnlineEntities4();
            l = db.BaiViets.OrderByDescending(bv => bv.ngayDang).Take(n).ToList<BaiViet>();
            return l;
        }
        public static SanPham getProductById(string maSP)
        {
            List<SanPham> a = new List<SanPham>();

            DbContext cn = new DbContext("name=ShopOnlineEntities3");

            return cn.Set<SanPham>().Find(maSP);
        }
        public static string getNameOfProductByID(string maSP)
        {
            List<SanPham> l = new List<SanPham>();

            DbContext cn = new DbContext("name=ShopOnlineEntities3");

            return cn.Set<SanPham>().Find(maSP).tenSP;
        }
        public static string getImageOfProductByID(string maSP)
        {
            List<SanPham> l = new List<SanPham>();

            DbContext cn = new DbContext("name=ShopOnlineEntities3");

            return cn.Set<SanPham>().Find(maSP).hinhDD;
        }
    }
}
    

