use master
go

drop database ShopOnline
go
-- Tạo database ShopOnline
create database ShopOnline
go
use ShopOnline
go
-- 1: Tạo Table [Accounts] chứa tài khoản thành viên được phép sử dụng các trang quản trị ----
create table TaiKhoan
(
	taiKhoan varchar(20) primary key not null,
	matKhau varchar(20) not null,
	hoDem nvarchar(50) null,
	tenTV nvarchar(30) not null,
	ngaysinh datetime ,
	gioiTinh bit default 1,
	soDT nvarchar(20),
	email nvarchar(50),
	diaChi nvarchar(250),
	trangThai bit default 0,
	ghiChu ntext
)
go
-- 2: Tạo Table [Customers] chứa Thông tin khách hàng  ---------------------------------------
create table KhachHang
(
	maKH varchar(10) primary key not null,
	tenKH nvarchar(50) not null,
	soDT varchar(20) ,
	email varchar(50),
	diaChi nvarchar(250),
	ngaySinh datetime ,
	gioiTinh bit default 1,
	ghiChu ntext
)
go
-- 3: Tạo Table [Articles] chứa thông tin về các bài viết phục vụ cho quảng bá sản phẩm, ------
--    xu hướng mua sắm hiện nay của người tiêu dùng , ...             ------------------------- 
create table BaiViet
(
	maBV varchar(10) primary key not null,
	tenBV nvarchar(250) not null,
	hinhDD varchar(max),
	ndTomTat nvarchar(2000),
	ngayDang datetime ,
	loaiTin nvarchar(30),
	noiDung nvarchar(4000),
	taiKhoan varchar(20) not null ,
	daDuyet bit default 0,
	foreign key (taiKhoan) references taiKhoan(taiKhoan) on update cascade 
)
go
 --4: Tạo Table [LoaiSP] chứa thông tin loại sản phẩm, ngành hàng -----------------------------
create table LoaiSP
(
	maLoai int primary key not null identity,
	tenLoai nvarchar(88) not null,
	ghiChu ntext default ''
)
go
-- 4: Tạo Table [Products] chứa thông tin của sản phẩm mà shop kinh doanh online --------------
create table SanPham
(
	maSP varchar(10) primary key not null,
	tenSP nvarchar(500) not NULL,
	hinhDD varchar(max) DEFAULT '',
	ndTomTat nvarchar(2000) DEFAULT '',
	ngayDang DATETIME DEFAULT CURRENT_TIMESTAMP,
	maLoai int not null references LoaiSP(maLoai),
	noiDung nvarchar(4000) DEFAULT '',
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade,
	dvt nvarchar(32) default N'kg',
	daDuyet bit default 0,
	giaBan INTEGER DEFAULT 0,
	giamGia INTEGER DEFAULT 0 CHECK (giamGia>=0 AND giamGia<=100),
	nhaSanXuat nvarchar(168) default ''
)
go
-- 5: Tạo Table [Orders] chứa danh sách đơn hàng mà khách đã đặt mua thông qua web ------------
create table DonHang
(
	soDH varchar(10) primary key not null ,
	maKH varchar(10) not null foreign key references khachHang(maKH),
	taiKhoan varchar(20) not null foreign key references taiKhoan(taiKhoan) on update cascade ,
	ngayDat datetime,
	daKichHoat bit default 1,
	ngayGH datetime,
	diaChiGH nvarchar(250),
	ghiChu ntext
)
go	
-- 6: Tạo Table [OrderDetails] chứa thông tin chi tiết của các đơn hàng ---
--    mà khách đã đặt mua với các mặt hàng cùng số lượng đã chọn ---------- 
create table CtDonHang	
(
	soDH varchar(10) not null foreign key references donHang(soDH),
	maSP varchar(10) not null foreign key references sanPham(maSP),
	soLuong int,
	giaBan bigint,
	giamGia BIGINT,
	PRIMARY KEY (soDH, maSP)
)
go
-- YC 1: Nhập thông tin tài khoản, tối thiểu 5 thành viên sẽ dùng để làm việc với các trang: Administrative pages
insert into taiKhoan
values('Quân','123',N'Nguyễn Minh','Quân',19/09/2003,1,0337019125,'minhquan@gmail.com','472 CMT8, P.11,Q3, TP.HCM',1,'')
insert into taiKhoan
values('admin','abc',N'Ngô Ngọc',N'Tuyền',06/12/2003,1,0948337762,'nntuyen@gmail.com','419 LTR, P.Thới An,Q12, TP.HCM',1,'')
GO

insert into LoaiSP(tenLoai) values(N'Rau củ quả')
insert into LoaiSP(tenLoai) values(N'Thịt tươi & Trứng gia cầm')
insert into LoaiSP(tenLoai) values(N'Thủy hải sản')
insert into LoaiSP(tenLoai) values(N'Trái cây')
insert into LoaiSP(tenLoai) values(N' Thực phẩm khác')

go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rad', N'Cà chua', '/Materials/Images/cachua_1.png',
			          N'Cà chua là một loại rau ăn trái có giá trị dinh dưỡng cao, được trồng phổ biến trên thế giới cũng như ở Việt Nam.',
					  'admin',12000,10,1,N'Đà lạt','kg');
go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rab2', N'Bông cải xanh', '/Materials/Images/Bongcaixanh.png',
			          N'Bông cải xanh là nguồn thực phẩm rất giàu sắt, protein, canxi, crom, carbohydrate, vitamin A và vitamin C.
					  Với thực đơn kiêng khem trong 10 ngày bằng bông cải xanh.','admin',24000,10,1,N'Đà lạt','kg');
go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('RCC2', N'Cà chua cherry', '/Materials/Images/ca-chua-cherry.jpg',
			          N'Cà chua cherry là loại cà chua tròn nhỏ, có hình dáng giống quả cherry màu đỏ chót, thịt ngọt dày.',
					  'admin',20000,10,1,N'Khác','kg');
go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rbce', N'Bông cải tím', '/Materials/Images/bapcaitim.jpg',
			          N'Bắp cải tím có nguồn gốc từ vùng Địa Trung Hải, thích hợp với những vùng có khí hậu ôn đới, ở Việt Nam.',
					  'admin',10000,10,1,N'Khác','kg');
go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('bct', N'Bắp cải trắng', '/Materials/Images/Bapcaitrang.jpeg',
			          N'Trong bữa ăn gia đình, bắp cải được các bà nội trợ biến hóa thành nhiều món ăn ngon. Bắp cải luộc thơm ngọt vị gừng, bắp cải xào cà...',
					  'Quân',10000,10,1,N'Khác','kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rcaibx', N'Cải bó xôi', '/Materials/Images/boxoi.jpg',
			          N'Có khá nhiều tên gọi khác nhau của rau bina, chính vì thế mà nhiểu người vẫn không hay biết rau bina là rau gì.',
					  'Quân',15000,10,1,N'Khác','kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rcth', N'Cải thảo', '/Materials/Images/caithao.jpeg',
			          N'Cải thảo có vị ngọt, tính mát, có tác dụng hạ khí, thanh nhiệt nhuận thấp, tức là làm mềm cổ họng, bớt rát,
					  đỡ ho; lại bổ ích trường vị,...','Quân',10000,10,1,N'Khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rxal', N'Xà lách', '/Materials/Images/xalach.jpg',
			          N'Đà Lạt được ví như thiên đường của rau quả tươi ngon, bởi nhờ khí hậu 4 mùa.
					  Salad Đà Lạt có vị rất ngon, tất cả salads đều được sơ...','admin',10000,10,1,N'Khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rcat', N'Cà tím', '/Materials/Images/catim.jpg',
			          N'Cà tím còn tác dụng chống ứ đọng cholesterol và urê huyết nên rất có lợi trong điều trị các bệnh tim mạch,
					  chứng huyết áp cao, béo phì vì cho..','admin',25000,10,1,N'Khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('cud', N'Củ dền', '/Materials/Images/cuden.jpg',
			          N'Màu đỏ tươi của củ dền được cho là hỗn hợp tự nhiên của màu vàng thực vật (betacyanin) và màu tím (betaxanthin).'
					  ,'admin',25000,10,1,N'Khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('cnag', N'Củ năng', '/Materials/Images/cunang.jpg',
			          N'Củ năng là loại thực phẩm bổ dưỡng có khả năng hỗ trợ trị liệu đối với các bệnh tim mạch, đái tháo đường,
					  giảm nguy cơ sỏi thận, phục hồi...','admin',15000,10,1,N'Khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rcsen', N'Củ sen', '/Materials/Images/cusen.jpg',
			          N'Theo Đông y, Củ sen có vị ngọt nhẫn, tính mát, tác dụng cầm máu tiêu ứ huyết, lợi tiểu, an thần, bổ thận, sinh tinh.
					  Thường dùng trong các trường....','admin',30000,10,1,N'Khác',N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rcgun', N'Gừng', '/Materials/Images/gung.jpg',
			          N'Gừng có vị cay, tính ấm, vào 3 kinh phế, tỳ, vị, có tác dụng phát biểu, tán hàn ôn trung, tiêu đàm, hành thủy, giải độc.',
					  'admin',10000,10,1,N'Khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rcnghe', N'Củ nghệ', '/Materials/Images/nghecu.jpg',
			          N'Nghệ cung cấp rất nhiều chất dinh dưỡng có lợi cho sức khỏe như protein, chất xơ, niacin,
					  Vitamin C, Vitamin E, Vitamin K, natri, kali, canxi, đồng, sắt, magiê...','admin',10000,10,1,N'Khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rhatim', N'Hành tím', '/Materials/Images/hanhtim.jpg',
			          N'Đông và Tây y đều coi trọng công dụng của hành tím. Loài này còn có tên gọi khác là hành bóng,
					  hành Hà Lan, được mệnh danh là “vua của...','admin',35000,10,1,N'Khác',N'kg');

go
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rhatsen', N'Hạt sen', '/Materials/Images/hatsen.jpg',
			          N'Hạt sen giàu protein, chất xơ và các khoáng chất có lợi cho sức khỏe, nhưng lại ít chất béo và cholesterol,
					  vì vậy rất phù hợp để bổ sung...','admin',50000,10,1,N'Khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Rbongh', N'Bông hẹ', '/Materials/Images/bonghe.jpg',
			          N'Cây hẹ khi để già sẽ trổ bông, ta hay gọi là Bông hẹ.  Nó có chứa rất nhiều thành phần dinh dưỡng,
					  như chất xơ, chất đạm, chất đường,...','admin',15000,10,1,N'Khác',N'kg');

go

-- Thịt tươi& trứng-------------------------------------------------------------------------------------------------------

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) values
('&thdb', N'Bắp bò', '/Materials/Images/bapbo.jpeg',
  N'Cách làm thịt bắp bò luộc  đơn giản và dễ thực hiện nhất trong các món ăn từ thịt bò nên ai cũng có thể thực hiện được đấy.
  ','admin',300000,10,1,N'Vissan',N'kg'),
  ('&thdb', N'Thịt đùi bò', '/Materials/Images/thitduibo.jpg',
			          N'Thịt đùi có vị ngon tương tự phần mông bò và thường được cắt thành lát dày như bít-tết để nướng. 
					  Đùi bò không ngon bằng thăn ngoại nhưng cũng không...','admin',250000,10,1,N'Vissan','kg');

go



insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&tnb', N'Nạm bò', '/Materials/Images/nambo.jpg',
			          N'Nạm bò là phần cơ có hình bầu dục nằm gần đường rạch ở bụng của bò từ phần đốt sống thứ 3 đến thứ 6.
					  Phần thịt này thường...','Quân',200000,10,1,N'Vissan','kg');

go



insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&xsb', N'Sườn bò', '/Materials/Images/suonbo.jpg',
			          N'Sườn bò có xương là phần thịt có dính mỡ nên thịt rất mềm và thơm.
					  Sườn bò có xương thường được dùng để chế ra các món sườn nướng truyền...','Quân',230000,10,1,N'Vissan',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&cgh', N'giò heo', '/Materials/Images/gioheo.jpg',
			          N'Chân giò hay giò heo/giò lợn hay gọi đơn giản là giò hay giò hầm là một món ăn thông dụng
					  được chế biến từ nguyên liệu là giò của...','admin',180000,10,1,N'Vissan',N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&baroi', N'Thịt Ba rọi ', '/Materials/Images/baroi.jpg',
			          N'Thịt ba rọi là phần được xem là ngon nhất và cũng dễ chế biến nhất trong thịt lợn.
					  Thịt ba rọi mềm, béo lại thơm. ','admin',150000,10,1,N'Vissan',N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&clet', N'Thịt Ba rọi ', '/Materials/Images/cotlet.jpg',
			          N'Bạn có thể chế biến xong món sườn cốt lết nướng thơm ngon cho thực đơn bữa cơm gia đình.
					  Một món ăn dân dã khá nổi tiếng của người... ','admin',130000,10,1,N'Vissan',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&snon', N'Sườn non ', '/Materials/Images/suonnon.jpg',
			          N'Các món ngon được chế biến từ sườn non đặc biệt là món sườn non giả cầy thơm nức mũi,
					  ngon đậm đà luôn “được lòng” người thưởng thức không...','admin',120000,10,1,N'Vissan',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&nhx', N'Nạc heo xay ', '/Materials/Images/nacheoxay.jpg',
			          N'Bất kể bạn xay thịt để làm thức ăn cho trẻ nhỏ hay các loại thức ăn mềm để phù hợp với 
					  chế độ ăn uống thì mục tiêu là...','admin',10000,10,1,N'Vissan',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&cga', N'Cánh gà', '/Materials/Images/canhga.jpg',
			          N'Cánh gà chiên tỏi, cánh gà rim nấm hay cánh gà sốt chua ngọt...
					  mới nghe tên đã thấy vô cùng hấp dẫn mà cách làm lại chẳng hề khó.','admin',80000,10,1,N'Ba Huân',N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&dtoi', N'Đùi tỏi', '/Materials/Images/duitoi.jpg',
			          N'Tỏi gà là phần đùi gà được loại bỏ phần má đùi, thịt tuoi ngon, săn chắc.
					  Tỏi gà món ăn rất được ưa chuộng của người dân Việt Nam.','admin',80000,10,1,N'Ba Huân',N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&mad', N'Má Đùi ', '/Materials/Images/ma-dui.jpg',
			          N'Má đùi gà được lấy từ nguồn thịt sạch, tươi ngon, sản xuất theo công nghệ hiện đại,
					  mọi khâu từ tuyển chọn nguyên liệu tới chế biến đều diễn ra...','admin',70000,10,1,N'Ba Huân',N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&uga', N'Ức gà phi lê ', '/Materials/Images/ucga.jpg',
			          N'Ức gà có lẽ là một trong những phần ngon nhất của một chú gà. 
					  Nó chứa rất ít chất béo nên rất phù hợp cho người cần giảm cân...','Quân',70000,10,1,N'Ba Huân',N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&trga', N'Trứng gà ', '/Materials/Images/trungga.jpg',
			          N'Trứng gà rất giàu dinh dưỡng, tuy nhiên, không phải cứ ăn trứng gà là tốt cho cơ thể.
					  bạn cần lưu ý để biết nhằm vừa bổ sung chất...','Quân',35000,10,1,N'Ba Huân',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&trv', N'Trứng vịt ', '/Materials/Images/trungvit.jpg',
			          N'','Quân',35000,10,1,N'Ba Huân',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&trbt', N'Trứng bắc thảo ', '/Materials/Images/bachthao.jpg',
			          N'Nhiều nơi sản xuất trứng bắc thảo không theo phương pháp truyền thống mà bằng cách ngâm hóa chất để có
					  giá rẻ và rút ngắn thời gian nên rất...','Quân',50000,10,1,N'Ba Huân',N'chục');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&trc', N'Trứng cút ', '/Materials/Images/cut.jpg',
			          N'Trứng cút là một loại thực phẩm rất quen thuộc trong tủ lạnh nhiều gia đình vì nó có hàm lượng 
					  dinh dưỡng khá cao, giá thành khá rẻ và...','Quân',20000,10,1,N'Ba Huân',N'chục');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('&trm', N'Trứng vịt muối ', '/Materials/Images/trungmuoi.jpg',
			          N'Món trứng này đã có từ rất lâu có thể ăn kèm với cháo trắng là ngon nhất nhưng tùy khẩu vị 
					  một số người vẫn thích ăn trứng vịt...','Quân',20000,10,1,N'khác',N'chục');

go

--------thủy sản------------------------------------------------------------------------------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Scbasa', N'Cá basa ', '/Materials/Images/basa.jpg',
			          N'Cá basa là thực phẩm được rất nhiều người yêu thích bởi vị thơm ngon hấp dẫn và giá trị dinh dưỡng cao của nó.
					  Chính vì thế nhiều người lựa chọn thực phẩm này để chế biến các món ăn.','Quân',60000,10,1,N'khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Scdui', N'Cá Đuối ', '/Materials/Images/caduoi.jpg',
			          N'Cá đuối có thân hình dẹp.','admin',150000,10,1,N'khác',N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Schoi', N'Cá Hồi ', '/Materials/Images/cahoi.jpg',
			          N'Cá hồi không chỉ là một món ăn ngon mà còn là loại thực phẩm đặc biệt tốt cho sức khỏe. Ngăn ngừa bệnh tim,
					  duy trì sức khỏe của bộ não, giảm nguy cơ mắc bệnh ung thư da,…là một trong những lợi ích sức khỏe tuyệt vời của cá hồi.',
					  'Quân',180000,10,1,N'khác',N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Scah', N'Cá hường ', '/Materials/Images/cahuong.jpg',
			          N'Cá hường là loài cá không còn lạ với những người dân đồng bằng sông Cửu Long.
					  Loại cá này có thịt cá mềm, ngọt và có thể chế biến...','Quân',60000,10,1,N'khác',N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Scloc', N'Cá lóc', '/Materials/Images/calocc.jpg',
			          N'Cá lóc rất quen thuộc với người dân Việt Nam đặc biệt là vùng sông nước miền Tây. Thịt cá lóc lành tính, vị ngon ngọt,
					  ít xương và có thể dễ dàng chế biến thành nhiều món ngon bổ dưỡng, tốt cho sức khỏe như nấu canh chua, chiên giòn, nướng trui,
					  kho tộ','Quân',50000,10,1,N'khác',N'kg');

go



----- Trái cây-----------------------------------------------------
insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('Cbdx', N'BƯỞI DA XANH','/Materials/Images/buoidaxanh.jpg',
			        N'Bưởi da xanh là một trong những trái cây tươi chứa nhiều vitamin, nó không chỉ dễ ăn, 
                    vị ngọt mát mà còn chứa rất ít calorie, bưởi còn giúp bạn có được làn da đẹp và có tác dụng bổ dưỡng cơ thể,
                    phòng và chữa một số bệnh như cao huyết áp, đau dạ dày, tiểu đường…',
					    'Quân',25000, 0, 1, N'Khác', N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CONH', N'ỔI NỮ HOÀNG', '/Materials/Images/oi.jpg',
			        N'Ổi nữ hoàng quả to, xanh, giòn, ăn vào có vị chua ngọt, hạt rất ít.
                    Một đĩa Ổi Nữ Hoàng kèm chèn muối ớt cay nồng sẽ là sự kết hợp hoàn hảo cho bữa ăn vặt thơm ngon, tốt cho sức khỏe.',
					  'admin',17000, 0, 1, N'Khác', N'kg');

go

insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CMTL', N'ME THÁI LAN ', '/Materials/Images/methai.jpg',
			        N'Me Thái Lan là một mặt hàng có giá trị trên thế giới vì có nhiều giá trị dinh dưỡng và tính lành của nó. Trong trái me chứa hàm lượng cao vitamin C, 
                    cũng như vitamin E, vitamin nhóm B, canxi, sắt, phốt pho, kali, mangan và chất xơ. 
                    Đặc biệt nó còn chứa một số hợp chất hữu có có tác dụng chống oxy hóa và chống viêm. ',
					  'admin',130000, 0, 1, N'Khác', N'kg');
go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CDX', N'DỪA XIÊM','/Materials/Images/dua.jpg',
			        N'Dừa xiêm không chỉ là thức uống giải khát vào những ngày hè nóng nực 
                    mà đây còn là loại trái sở hữu nhiều công dụng tuyệt vời cho làn da và sức khỏe. ',
					  'admin',15000, 0, 1, N'Khác', N'quả');
go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CDD', N'ĐU ĐỦ', '/Materials/Images/dudu.jpg',
			    N'  - Đu đủ ruột vàng khi chọn những quả dài, cầm nặng tay, chín đều ngả màu vàng hơi ửng đỏ, 
                        trên mặt da có chấm đen tàn nhang, cuống còn dính nhựa là đu đủ chín cây, ăn ngọt thơm. Mua đu đủ ngày nắng ăn ngon hơn đu đủ ngày mưa.
                    - Nghiên cứu đã chỉ ra rằng, đu đủ có chứa một loại enzim tiêu hoá mang tên “papain”, rất tốt cho quá trình tiêu hoá. Chính bởi lý do này, 
                        nước ép của trái đu đủ xanh đã được sử dụng trong việc bào chế ra các loại thuốc với mục đích chữa trị và hỗ trợ hệ thống tiêu hoá.',
					  'Quân',20000, 0, 1, N'Khác', N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CNXT', N'NHẢN XUỒNG THÁI', '/Materials/Images/nhan.jpg',
			    N'  Cơm của trái nhãn xuồng có màu vàng ngà, giòn và rất ngọt. Khi chín vỏ nhãn có màu vàng da bò. 
                    Công dụng của quả nhãn xuồng đối với sức khỏe :
                    -Tăng cường vitamin C, giàu chất sắc
                    -Giúp tăng nồng độ chất khoáng để tránh loãng xương khi về già.
                    -Bảo vệ mắt trong vitamin nhóm B, riboflavin là thành phần quan trọng. 
                    -Giảm stress, nhãn có tác dụng kích thích tim mạch và lá lách hoạt động tốt. 
                    Từ đó, giúp cho quá trình lưu thông máu suôn sẻ, cung cấp hiệu ứng làm dịu hệ thần kinh, những mệt mỏi trong cuộc sống.',
					    'admin',60000, 0, 1, N'Khác', N'kg');

go





insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CDLRV', N'DƯA LƯỚI RUỘT VÀNG', '/Materials/Images/dualuoi.jpg',

			    N'  - Dưa lưới là một loại trái cây giàu dinh dưỡng, rất ngon và được mọi người ưa chuộng. 
                    - Dưa lưới ruột vàng: Dưa có phần vỏ ngoài màu xanh thẫm, trên vỏ đan xen những gân sáng trắng dày vào nhau giống như lưới.
                    - Dưa lưới ruột vàng đều có hương vị cực kỳ hấp dẫn. Khi ăn có vị ngọt và thanh mát, mọng nước, hương thơm dịu nhẹ.
                    - Trong trái dưa lưới có  vitamin C, A, B cùng nhiều dưỡng chất quan trọng khác 
                    có tác dụng hữu hiệu trong làm đẹp da, sáng mắt, ngăn ngừa ung thư, bảo vệ tim mạch, giảm căng thẳng, tốt cho thai nhi…',
					  'Quân',35000, 0, 1, N'Khác', N'kg');

go



insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CDH', N'DƯA HẤU', '/Materials/Images/duahau.jpg',

			    N'  Dưa hấu có tên khoa học là Citrullus lanatus, là một loại thực vật thuộc họ bầu bí, vỏ cứng, chứa nhiều nước, có nguồn gốc từ miền nam Châu Phi. 
                Dưa hấu được được nhiều người ưa chuộng bởi tính ngọt mát và nhiều nước, đồng thời còn giúp cung cấp nhiều vitamin và các nguyên tố vi lượng cho cơ thể.',
					  'admin',70000, 0, 1, N'Khác', N'kg');

go




insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CCD', N'CHANH DÂY','/Materials/Images/chanhday.jpg',
			    N'  Chanh dây chứa nhiều vitamin A, C, chất xơ, nước, axit giúp giảm cân hiệu quả. 
                Vitamin C giúp tăng cường sức khỏe, tăng sức đề kháng, giúp tiêu hao năng lượng, đốt cháy chất béo hiệu quả.',
					'Quân',18000, 0, 1, N'Khác', N'kg');

go





insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CTX', N'TÁO XANH', '/Materials/Images/tao.jpg',
			    N'  - Những dưỡng chất có trong táo ta xanh sạch sẽ khiến bạn không khỏi bất ngờ vì nó chứa nhiều tannin, axit maclic cùng nhiều khoáng chất khác.
                    + Bảo vệ lá phổi của bạn và cả nhà
                    + Làm giảm cholesterol trong máu
                    + Giảm cân hiệu quả
                    + Cải thiện tiêu hóa
                    +Tăng cường sức mạnh cho xương khớp',
					'admin',99000, 0, 1, N'Khác', N'kg');

go




insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CQD', N'QUÝT ĐƯỜNG','/Materials/Images/quyt.jpg',

			    N'  -  Quýt đường là loại quýt có kích thước trung bình từ 150 - 200g/1 trái, trái có dạng hình cầu, vỏ mỏng, màu xanh, khi chín hơi ngả vàng (vàng - xanh). 
                Múi quýt có màu cam và vị ngọt đậm nên nó có tên gọi là Quýt đường.
                - Quýt đường dễ trồng, dễ chăm sóc, thích nghi rộng với nhiều loại thổ nhưỡng và khí hậu khác nhau, 
                những năm gần đây giá thu mua cao và ổn định góp phần giúp cho nhiều bà con nông dân làm giàu, cải thiện kinh tế.
                - Quýt đường sở hữu hương vị ngọt lịm như chính tên gọi của nó là yếu tố khiến rất đông các quý cô nội trợ chọn loại trái cây này để làm món tráng miệng cho gia đình mình.
                - Không chỉ tốt cho sức khỏe, ngăn ngừa nhiều loại bệnh mà quả quýt còn tốt cho da và tóc nữa nhé.',
					'Quân',28000, 0, 1, N'Khác', N'kg');

go



insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CKLM', N'KHOAI LANG MẬT','/Materials/Images/lang.jpg',

			    N'  - Vitamin C là thành phần góp công chữa lành vết thương, ngăn ngừa lão hóa da, giảm stress và ngăn ngừa các tác nhân gây ung thư…
                    - Vitamin D tố cho xương và hệ thần kinh.
                    - Vitamin B6 giúp làm giảm homocysteine trong cơ thể mỗi người chúng ta, homocysteine chính là tác nhân chính gây ra các bệnh về tim mạch…
                    - Vi chất sắt có tác dụng thúc đẩy quá trình sản sinh bạch cầu, hồng cầu, giúp tăng cường hệ miễn dịch và chuyển hóa protein trong cơ thể.
                    - Magie có trong khoai lang mật cũng chính là những khoáng chất quan rất tốt cho cơ xương được phát triển, vững vàng về tim mạch.
                    - Khoai lang mật cũng có tác dụng giảm cân hữu hiệu.',
					'admin',50000, 0, 1, N'Khác', N'kg');

go




insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CMCN', N'MẴNG CẦU ', '/Materials/Images/cau.jpg',

			    N'   Mãng Cầu có mùi thơm của hoa hồng, vị ngọt lịm, dai dai và giàu dinh dưỡng nên được nhiều người ưa chuộng.
                - Với ưu điểm các múi dính chặt vào nhau cả khi chín.
                - Dễ vận chuyển vì dù có chạm mạnh trái không bị vỡ ra, vỏ mỏng, có thể bóc ra từng mảng như vỏ quít.
                - Với lớp vỏ mỏng, thịt trong màu trắng và rất chắc. Trái có mùi thơm đậm đà và đặc biệt ăn rất ngọt khi chín.
                + Nên để Mãng Cầu Ta ở nhiệt độ thường để trái có thể chín nhanh hơn.',
					'admin',65000, 0, 1, N'Khác', N'kg');

go





insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CSR', N'SẦU RIÊNG', '/Materials/Images/rieng.jpg',
			    N'  Sầu riêng là một loại trái cây lớn, có mùi khá nồng và nặng, nhưng cực kỳ giàu các chất dinh dưỡng, chẳng hạn như vitamin C, vitamin B, khoáng chất, chất béo lành mạnh, chất xơ và một số hợp chất thực vật có lợi khác. 
                Sầu riêng thường có mặt tại nhiều quốc gia trong khu vực Đông Nam Á, điển hình là Việt Nam. 
                Ăn sầu riêng có thể mang lại một số lợi ích nhất định cho sức khỏe.','admin',75000, 0, 1, N'Khác', N'kg');

go







insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CMCT', N'MĂNG CỤT', '/Materials/Images/cut.jpg',

			    N'  Trong thịt quả măng cụt chứa nhiều chất dinh dưỡng có lợi cho sức khỏe như:
                    - Cải thiện hệ miễn dịch
                    - Hỗ trợ giảm cân, giữ dáng
                    - Làm đẹp da
                    - Ổn định lượng đường trong máu
                    - Ngăn ngừa các bệnh lý về tim mạch
                    - Kích thích tiêu hóa, chống táo bón
                    - Giảm dị ứng',
					'Quân',255000, 0, 1, N'Khác', N'kg');

go



insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CSMN', N'CAM SÀNH', '/Materials/Images/cam.jpg',

			    N'  Cam sành có dạng trái hình cầu hơi dẹp, trọng lượng trung bình 235,9g , vỏ cam sành màu xanh đến xanh vàng khi chín, sần và dầy 3-5mm, tép màu vàng cam đậm, nhiều nước, vị ngọt chua , mùi rất thơm và khá nhiều hạt
                    Cam sành là loại trái cây tươi giàu vitamin C, vitamin A, canxi, chất xơ… rất bổ dưỡng cho cơ thể phụ nữ mang thai. Vitamin B9 (axit folic) có trong cam sành vô cùng quan trọng, 
                    đặc biệt đối với bà bầu hoặc những người đang cố gắng thụ thai. 
                    Cam sànhgiúp ngăn ngừa một số loại khuyết tật bẩm sinh, tăng sức đề kháng và giúp sản xuất các tế bào máu khỏe mạnh.
                     Ngoài ra chất limonoid trong nước cam giúp ngăn ngừa bệnh ung thư và có tác dụng giải độc, lợi tiểu. Phụ nữ mang thai thường ăn cam sành, hoặc các loại trái có họ hàng với cam như quýt, bưởi,…',
					'admin',23000, 0, 1, N'Khác', N'kg');

go


insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CTLRT', N'THANH LONG RUỘT TRẰNG', '/Materials/Images/thanhlong.jpg',

			    N'  - Thanh long ruột trắng có thành phần chất xơ rất cao, trung bình 100 gram chứa 0,7-0,9 gam chất xơ, rất tốt cho cơ thể, đặc biệt là cholesterol, tốt cho tiêu hóa, hạn chế táo bón giải độc cơ thể.
                    - Mỗi ngày một người nên ăn khoảng 20-30 gam chất xơ, đây là mức tối ưu có thể giúp ngăn ngừa nhiều loại bệnh nan y như ung thư, bệnh tim, tiểu đường ...
                    - Ngoài chất xơ, thanh long ruột trắng cũng giàu chất beta carotene, đây là một chất giúp cho cơ thể chuyển hóa thành vitamin provitamin, giúp loại bỏ các tế bào mà không dẫn đến nhiễm trùng',
					'Quân',55000, 0, 1, N'Khác', 'kg');

go



insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CMAP', N'MẬN AN PHƯỚC', '/Materials/Images/man.jpg',

			    N'  - Mận (roi) An Phước hình thuôn, màu đỏ sẫm, một số giống có màu trắng hay hồng. Thịt quả màu trắng bao quanh một hạt lớn.
                    - Sản phẩm tươi ngon, không chứa chất bảo quản đảm bảo an toàn sức khỏe cho người tiêu dùng.
                    - Đây là loại quả có năng lượng rất thấp, hàm lượng nước cao và đặc biệt, hàm lượng chất xơ trong roi rất cao. 
                    Vì vậy, quả roi được xếp vào nhóm có tác dụng giảm béo rất tốt.
                    - Hàm lượng chất xơ cao có tác dụng quét các chất béo và đường dư thừa ra khỏi đường tiêu hóa qua bài tiết.',
					'admin',35000, 0, 1, N'Khác', 'kg');

go




insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CĐH', N'Đào', '/Materials/Images/dao.jpg',

			    N'  Quả đào, miền Nam gọi là trái đào, cùng với quả của anh đào, mận, mơ là các loại quả hạch. Quả đào có một hạt giống to được bao bọc trong một lớp vỏ gỗ cứng, 
                cùi thịt màu vàng hay ánh trắng, có mùi vị thơm ngon và lớp vỏ có lông tơ mềm, khi non có màu xanh, khi chín chuyển sang màu hồng hoặc vàng.',
					'admin',50000, 0, 1, N'Khác', 'kg');

go



insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CDMTN', N'Dứa', '/Materials/Images/thom.jpg',

			    N'  Quả dứa có hàm lượng axit hữu cơ cao (axit malic và axit xitric).
                - Dứa là nguồn cung cấp mangan dồi dào cũng như có hàm lượng Vitamin C và Vitamin B1 khá cao.
                - Một tài liệu khác cho biết: Trong 100g phần ăn được cho 25 kcal, 0,03 mg caroten, 0,08 mg vitamin B1, 0,02 mg vitamin B2, 16 mg vitamin C (dứa tây). 
                Các chất khoáng: 16 mg ca, 11 mg phospho, 0,3 mg Fe, 0,07 mg Cu, 0,4g protein, 0,2g lipit, 13,7g hydrat cacbon, 85,3g nước, 0,4g xơ..
                - Trong quả dứa có chứa enzym bromelain, có thể phân huỷ protein. 
                Do vậy, quả dứa được sử dụng trong chế biến một số món ăn như thịt bò xào, thịt vịt xào để giúp thịt nhanh mềm và tạo hương vị đặc trưng.',
					'Quân',25.000, 0, 1, N'Khác', 'kg');

go



insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CLĐ', N'Lựu', '/Materials/Images/luu.jpg',

			    N'  Lựu không chỉ là một loại trái câу ngon, mát mà có nhiều lợi ích cho ѕức khỏe. 
                Trong quả lựu có chứa một lượng lớn các chất oху hóa, ᴠitamin C ᴠà nhiều loại ᴠitamin khác giúp tăng cường hệ miễn dịch, bảo ᴠệ ѕức khỏe ᴠà chống lại nhiều bệnh tật.',
					'Quân',65000, 0, 1, N'Khác', 'kg');

go



insert into sanPham (maSP, tenSP, hinhDD, ndTomTat, taiKhoan, giaBan, giamGia, maLoai, nhaSanXuat, dvt) 
              values('CVS', N'Vú Sữa', '/Materials/Images/vusua.jpg',

			    N'  Quả vú sữa được các chuyên gia dinh dưỡng đánh giá là một loại thực phẩm rất tốt cho sức khỏe bởi nó là nguồn cung cấp vitamin và khoáng chất dồi dào.',
					'Quân',45000, 0, 1, N'Khác', 'kg');

go

-----------------BÀI VIẾT-----------------------------------------------------------------------
insert into BaiViet(maBV, tenBV, hinhDD, ndTomTat, ngayDang, loaiTin, noiDung,taiKhoan,daDuyet) 
              values('BS01',N'Các Cách Rửa Sạch Và Diệt Khuẩn Thực Phẩm Hiệu Quả','/Materials/Images/baiviet/traicay.jpg',
			  N' Hiện nay vấn đề “Thực phẩm bẩn” đang được mọi người quan tâm và là nỗi lo lắng của các hộ gia đình. Thịt lợn,
			  gà,bò, cá…và các loại rau củ quả nhiễm hóa chất, vi khuẩn độc hại đang...',21/11/2022,N'Báo ',
			  N' Hiện nay vấn đề “Thực phẩm bẩn” đang được mọi người quan tâm và là nỗi lo lắng của các hộ gia đình. Thịt lợn,
			  gà,bò, cá…và các loại rau củ quả nhiễm hóa chất, vi khuẩn độc hại đang được bày bán tràn lan trong thị trường. Để đảm bảo
			  các thành viên trong gia đình được ăn các thực phẩm tươi sạch thì các mẹ, bà nội trợ hãy tự trang bị cho mình một số cách rửa
			  sạch và diệt khuẩn thực phẩm an toàn hiệu quả tại nhà.

             1. Rửa bằng giấm
             Sử dụng giấm để rửa thực phẩm là một trongN những cách rất hiệu quả. Dung dịch giấm có nhiều thành phần có khả năng diệt vi khuẩn,
			 hóa chất cũng như vi khuẩn, ký sinh trùng trên thực phẩm, đặc biệt là trái cây và rau củ.
			 Pha hỗn hợp giấm và nước sạch theo tỷ lệ 1:3 và ngâm thực phẩm trong đó khoảng 20 phút trước khi nấu ăn. 
			 Lưu ý, sau khi ngâm bạn nhớ rửa lại thật sạch với nước vì giấm có vị chua, có thể ảnh hưởng đến mùi vị thực phẩm trong 
			 quá trình chế biến. Ngoài ra chúng ta có thể dùng giấm để diệt khuẩn quần áo cũng rất hiệu quả.
			 2. Sử dụng bột nghệ diệt khuẩn
			 Đối với những thực phẩm tươi sống như thịt, cá, thì bột nghệ chính là nguyên liệu diệt vi khuẩn cực kỳ hiệu quả. Chỉ cần dùng bột nghệ
			 rắc trực tiếp một lớp mỏng vào thịt, cá tươi sống để diệt trừ vi khuẩn. Cách diệt khuẩn này thường được các đầu bếp nhà hàng sử dụng vì
			 nó khử trùng diệt khuẩn nhanh chóng.
			 3. Rửa bằng hỗn hợp soda, chanh và giấm táo
			 Để có thể rửa sạch và diệt khuẩn các loại thực phẩm tươi sống, các bạn có thể tự pha chế nước dung dịch hỗn hợp để rửa sạch thực phẩm. 
			 Các bạn chuẩn bị 1 ít nước sạch, soda, chanh và giấm táo rồi trộn các nguyên liệu với nhau. Ngâm thực phẩm trong dung dịch hỗn hợp đó 
			 khoảng 5 – 7 phút để tiêu diệt vi khuẩn rồi rửa sạch thực phẩm dưới vòi nước chảy trực tiếp.
			 4. Rửa thực phẩm với nước chanh
			 Như các bạn đã biết quả chanh có thành phần axit sát khuẩn rất hiệu quả. Chúng ta chỉ cần dùng nửa quả chanh pha loãng với nước để ngâm
			 các rau củ quả trước khi chế biến. Lưu ý, không nên ngâm quá lâu sẽ ảnh hưởng đến chất lượng thực phẩm, chúng ta chỉ nên ngâm trong khoảng 5 – 7 phút
			 Chanh có đặc tính kháng khuẩn rất cao.
			 5. Rửa rau củ bằng nước muối
			 Dùng muối để ngâm rửa rau củ quả là cách diệt khuẩn đã quá quen thuộc với mọi gia đình. Nước muối là dung dịch tự nhiên, dễ dàng sử dụng
			 và là dung dịch diệt khuẩn tốt nhất. Chúng ta chỉ cần cho một ít muối vào chậu nước rồi ngâm rau củ quả. Nước muối có khả năng khử và loại 
			 bỏ vi khuẩn cũng như các hóa chất, thuốc trừ sâu, thuốc bảo vệ thực vật.
			 Lưu ý: Ngâm rau củ quả trong nước muối quá lâu sẽ bị mất vitamin. Vì thế chúng ta chỉ nên ngâm trong khoảng 10 phút thôi.
			 Nguồn: Internet' ,'admin',N' ');

go
insert into BaiViet(maBV, tenBV, hinhDD, ndTomTat, ngayDang, loaiTin, noiDung,taiKhoan,daDuyet) 
              values( ' BS02',N'5 tác dụng đáng kinh ngạc của việc ăn rau mỗi ngày','/Materials/Images/tacdung.jpg',
			           N'Các chuyên gia dinh dưỡng dường như luôn có sự khác biệt về quan điểm, nhưng có một lời khuyên
					   dinh dưỡng mà nhiều người đều đồng ý: Mọi người nên ăn nhiều rau hơn!',26/12/2022,N' bài viết',
					   N' 1. Giảm nguy cơ mắc bệnh tim Chế độ ăn nhiều rau có thể làm giảm huyết áp và giảm nguy cơ mắc bệnh tim và đột quỵ. Các kết quả nghiên cứu cho thấy chế độ ăn kiêng từ thực vật giúp cải thiện sức khỏe tim mạch tổng thể của bạn như thế nào.

Ví dụ, một trong những nghiên cứu dựa trên dân số lớn nhất đã báo cáo rằng những người ăn các loại rau ăn lá, chẳng hạn như rau diếp, rau bina, cải Thụy Sĩ và cải xanh, có nguy cơ mắc bệnh tim thấp hơn đáng kể.

Hơn nữa, nghiên cứu từ các phương pháp tiếp cận chế độ ăn uống để ngăn chặn tăng huyết áp (DASH) cho thấy các chất dinh dưỡng có trong rau, như kali và magiê giúp giảm huyết áp đáng kể, giảm nguy cơ đau tim và đột quỵ, theo Eat This, Not That!

Chế độ ăn kiêng DASH yêu cầu 4 đến 5 phần rau mỗi ngày. Một khẩu phần là 1 cốc rau sống hoặc 1/2 cốc nấu chín hoặc 100% nước trái cây.

2. Giúp duy trì làn da khỏe mạnh
Rau thực sự là thức ăn cho khuôn mặt của bạn. Rau chứa nhiều chất dinh dưỡng giúp duy trì làn da khỏe mạnh và giảm tổn thương da do tia UV gây ra.

Một số chất dinh dưỡng giúp bảo vệ da quan trọng trong rau bao gồm beta-carotene, vitamin C và các chất dinh dưỡng thực vật chống oxy hóa khác. Rau là một số nguồn tốt nhất của những chất dinh dưỡng có lợi này.

Một nghiên cứu quan sát lớn liên quan đến phụ nữ từ 40 đến 74 tuổi cho thấy rằng ăn thực phẩm giàu vitamin C và tiêu thụ ít chất béo và đường hơn có liên quan đến ít nếp nhăn hơn và trông trẻ hơn so với những người có lượng chất béo và carbohydrate hấp thụ cao hơn và thấp hơn lượng vitamin C.

Ăn nhiều rau mỗi ngày có thể giúp làm dịu chứng viêm mạn tính, giúp làm chậm quá trình lão hóa, làm tăng nhanh sự xuất hiện của các nếp nhăn và mất collagen.

3. Giúp duy trì sức khỏe đôi mắt
Duy trì thị lực khỏe mạnh cũng liên quan đến việc bảo vệ bạn khỏi tác hại của tia UV.

Các chất dinh dưỡng trong rau hỗ trợ sức khỏe của mắt bao gồm vitamin A, C, carotenoid và các chất dinh dưỡng thực vật khác giúp duy trì thị lực.

Nhiều nghiên cứu chỉ ra rằng lutein và zeaxanthin, các carotenoid có trong nhiều loại rau nhiều màu sắc và rau xanh, giúp giảm nguy cơ thoái hóa điểm vàng và đục thủy tinh thể do tuổi tác.

Những chất dinh dưỡng này lọc tia UV được cho là làm tăng nguy cơ mắc bệnh thoái hóa điểm vàng do tuổi tác (AMD) và đục thủy tinh thể.
Các nghiên cứu về bệnh mắt liên quan đến tuổi tác (AREDS) cho thấy kẽm, đồng, vitamin C, E và beta-carotene, lutein và zeaxanthin làm giảm 25% nguy cơ suy giảm sức khỏe mắt do tuổi tác.

Đục thủy tinh thể và AMD là những nguyên nhân hàng đầu gây suy giảm thị lực và mù lòa ở Mỹ. Nguy cơ gia tăng đáng kể sau 65 tuổi.

4. Cải thiện sức khỏe đường ruột
Rau là một trong những nhóm thực phẩm có nhiều chất xơ nhất và chất xơ trong rau giúp cải thiện hệ vi sinh vật đường ruột của bạn.

Hệ vi sinh vật - hoặc hàng nghìn tỉ vi khuẩn trong đường tiêu hóa - đóng một vai trò trong việc duy trì hệ thống miễn dịch của bạn.

Theo Trường Y tế Công cộng Harvard (Mỹ), một chế độ ăn giàu chất xơ với nhiều rau có thể hỗ trợ một hệ vi sinh vật khỏe mạnh. Chất xơ được phân hủy và lên men trong ruột kết. Quá trình lên men này tạo ra các axit béo chuỗi ngắn có lợi được sản xuất, theo Eat This, Not That!

Mặc dù tất cả các loại rau đều có lợi nhưng một số loại tốt nhất cho đường tiêu hóa bao gồm hành tây, tỏi tây, măng tây, atisô Jerusalem, rau bồ công anh và rong biển.

Những thực phẩm này đặc biệt giàu chất xơ prebiotic giúp cung cấp năng lượng cho các vi khuẩn lành mạnh trong đường ruột của bạn để giúp chúng sinh sôi và phát triển.

5. Tốt cho xương
Các loại rau xanh như cải xoăn, cải ngọt, cải thảo, rau cải thìa và củ cải xanh đều cung cấp canxi, nhưng chúng cũng cung cấp kali, axit folic, vitamin K và magiê giúp cơ thể đưa canxi vào xương của bạn.

Một số nghiên cứu đã báo cáo mối liên hệ nghịch giữa tiêu thụ rau và nguy cơ gãy xương.

Trong một tổng quan tài liệu về 5 nghiên cứu đã được công bố, các tác giả đã kết luận rằng ăn nhiều rau hơn có liên quan đến việc giảm nguy cơ gãy xương hông, theo Eat This, Not That!',N'Quân','');

go
