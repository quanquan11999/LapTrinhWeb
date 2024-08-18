using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebDoAn.Models
{
    public class CartShop
    {
        public string MaKH { get; set; }
        public string TaiKhoan { get; set; }
        public DateTime NgayDat { get; set; }
        public DateTime NgayGiao { get; set; }
        public string Diachi { get; set; }
        ///---??
        ///---
        public SortedList<string, CtDonHang> SanPham { get; set; }
        /// <summary>
        /// Default constructor
        /// </summary>
        public CartShop()
        {
            this.MaKH = ""; this.TaiKhoan = ""; this.NgayDat = DateTime.Now; this.NgayGiao = DateTime.Now.AddDays(2);
            this.Diachi = "";
            this.SanPham = new SortedList<string, CtDonHang>();
        }
        /// <summary>
        /// Phương thức trả về true nếu không có sản phẩm nào đã chọn
        /// </summary>
        /// <returns></returns>
        public bool IsEmpty()
        {
            return SanPham.Keys.Count == 0;
        }
        public void addItem(string maSP)
        {
            if (SanPham.Keys.Contains(maSP))
            {
                CtDonHang x = SanPham.Values[SanPham.IndexOfKey(maSP)];
                x.soLuong++;
                SanPham.Values[SanPham.IndexOfKey(maSP)] = x;
            }
            else
            {
                CtDonHang i = new CtDonHang();
                i.maSP = maSP;
                i.soLuong = 1;
                SanPham z = Common.getProductById(maSP);
                i.giaBan = z.giaBan;
                i.giamGia = z.giamGia;
                ///// bỏ vào ds
                SanPham.Add(maSP, i);
            }
        }
        public void updateOneItem(CtDonHang x)
        {
            this.SanPham.Remove(x.maSP);
            this.SanPham.Add(x.maSP, x);
        }


        public void deleteItem(String maSP)
        {
            if (SanPham.Keys.Contains(maSP))

                SanPham.Remove(maSP);

        }
        /// <summary>
        /// giảm số lượng
        /// </summary>
        /// <param name="maSP"></param>
        public void decrease(string maSP)
        {
            if (SanPham.Keys.Contains(maSP))
            {
                CtDonHang x = SanPham.Values[SanPham.IndexOfKey(maSP)];
                if (x.soLuong > 1)
                {
                    x.soLuong--;
                    SanPham.Values[SanPham.IndexOfKey(maSP)] = x;

                }
                else
                    deleteItem(maSP);
            }
        }
        public long moneyOfOneProducr(CtDonHang x)
        {
            return (long)(x.giaBan * x.soLuong - (x.giaBan * x.soLuong * x.giamGia));
        }
        public long totalOfCartShop()
        {
            long kq = 0;
            foreach (CtDonHang i in SanPham.Values)
                kq += moneyOfOneProducr(i);
            return kq;
        }

        internal void addItem(object maSP)
        {
            throw new NotImplementedException();
        }
    }
}