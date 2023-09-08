go
Use master;
go
create database db06;
go
use db06;
go
CREATE TABLE users (
    users_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(90),
    [address] NVARCHAR(250),
    phone INT,
    birthday DATE,
    [role] NVARCHAR(50),
    created_date DATE,
    [status] BIT,
    email NVARCHAR(50),
    [password] NVARCHAR(250),
    [image] NVARCHAR(250),
    deleted BIT,
    activaties BIT
);
go
-- Tạo bảng Brand
CREATE TABLE brand (
  brand_id BIGINT PRIMARY KEY IDENTITY(1,1),
  brand_name NVARCHAR(50) NOT NULL,
  brand_image NVARCHAR(MAX) NOT NULL,
  activities BIT NOT NULL DEFAULT 0,
  deleted BIT NOT NULL DEFAULT 0
);
go
-- Tạo bảng Category
CREATE TABLE category (
  category_id BIGINT PRIMARY KEY IDENTITY(1,1),
  category_name NVARCHAR(50) NOT NULL,
  category_image NVARCHAR(MAX) NOT NULL,
  activities BIT NOT NULL DEFAULT 0,
  deleted BIT NOT NULL DEFAULT 0
);
go

-- Tạo bảng Size
CREATE TABLE size (
  size_id BIGINT PRIMARY KEY IDENTITY(1,1),
  size_number FLOAT NOT NULL,
  activities BIT NOT NULL DEFAULT 0,
  deleted BIT NOT NULL DEFAULT 0
);
go
-- Tạo bảng Product
CREATE TABLE product (
  product_id BIGINT PRIMARY KEY IDENTITY(1,1),
  product_name NVARCHAR(100) NOT NULL,
  category_id BIGINT NOT NULL,
  brand_id BIGINT NOT NULL,
  users_id BIGINT NOT NULL,
  price FLOAT NOT NULL,
  product_description NVARCHAR(MAX),
  activities BIT NOT NULL DEFAULT 0,
  featured BIT NOT NULL DEFAULT 0,
  created_date datetime,
  deleted BIT NOT NULL DEFAULT 0,
  CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category(category_id),
  CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
  CONSTRAINT fk_userr FOREIGN KEY (users_id) REFERENCES users(users_id)
);
go
-- Tạo bảng Color
CREATE TABLE color (
  color_id BIGINT PRIMARY KEY IDENTITY(1,1),
  product_id BIGINT NOT NULL,
  color_name NVARCHAR(50) NOT NULL,
  color_image NVARCHAR(MAX) NOT NULL,
  activities BIT NOT NULL DEFAULT 0,
  deleted BIT NOT NULL DEFAULT 0,
  CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES product(product_id),
);

go
-- Tạo bảng Product_Detail
CREATE TABLE product_detail (
  product_detail_id BIGINT PRIMARY KEY IDENTITY(1,1),
  product_id BIGINT NOT NULL,
  size_id BIGINT NOT NULL,
  color_id BIGINT NOT NULL,
  quantity BIGINT NOT NULL,
  deleted BIT NOT NULL DEFAULT 0,
  CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES product(product_id),
  CONSTRAINT fk_size FOREIGN KEY (size_id) REFERENCES size(size_id),
  CONSTRAINT fk_color FOREIGN KEY (color_id) REFERENCES color(color_id)
);
go
-- Tạo bảng favorite
CREATE TABLE favorite (
    favorite_id BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    product_id BIGINT NULL,
    users_id BIGINT NULL,
    date_like datetime NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (users_id) REFERENCES users(users_id)
);
go
-- Tạo bảng review
CREATE TABLE review (
    review_id BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    product_id BIGINT NULL,
    title nvarchar(200) NULL,
    users_id BIGINT NULL,
    review_date datetime NULL,
    display bit NULL,
    rating int NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (users_id) REFERENCES users(users_id)
);
go
CREATE TABLE cart(
	cart_id bigint IDENTITY(1,1) NOT NULL primary key,
	users_id bigint null,
	FOREIGN KEY (users_id) REFERENCES users(users_id)
)
go
CREATE TABLE cart_detail(
	cart_detail_id bigint IDENTITY(1,1) NOT NULL primary key,
	cart_id bigint ,
	product_detail_id bigint ,
	product_id bigint ,
	quantity int ,

	FOREIGN KEY (cart_id) REFERENCES cart(cart_id),

	FOREIGN KEY (product_detail_id) REFERENCES product_detail(product_detail_id),

	FOREIGN KEY (product_id) REFERENCES product(product_id)

)
go
CREATE TABLE payment_menthod(
	payment_method_id bigint IDENTITY(1,1) NOT NULL primary key,
	payment_menthod_name nvarchar(50) ,
	[description] nvarchar(max) ,
	display bit
)
go
CREATE TABLE shipping_address (
    shipping_address_id bigint IDENTITY(1,1) NOT NULL primary key,
    province NVARCHAR(255),
    district NVARCHAR(255),
    ward NVARCHAR(255),
    address_details VARCHAR(10),
	default_address bit ,
	users_id bigint
	FOREIGN KEY (users_id) REFERENCES users(users_id),
);


CREATE TABLE [order](
	order_id bigint IDENTITY(1,1) NOT NULL primary key,
	users_id bigint ,
	shipping_address_id bigint,
	payment_method_id bigint ,
	shiping_address nvarchar(255) ,
	delivery_date date , 
	payment_status bit ,
	delivery_status bit,
	order_date datetime,
	initial_price float,
	shipping_fee float,
	total_amount float,
	order_status nvarchar(50)

	FOREIGN KEY (shipping_address_id) REFERENCES shipping_address(shipping_address_id),
	FOREIGN KEY (users_id) REFERENCES [user](users_id),
	FOREIGN KEY (payment_method_id) REFERENCES payment_menthod(payment_method_id),

)
go
CREATE TABLE order_detail(
	order_detail_id bigint IDENTITY(1,1) NOT NULL primary key,
	order_id bigint ,
	product_detail_id bigint ,
	quantity int,
	price float,
	FOREIGN KEY (order_id) REFERENCES [order](order_id),
	FOREIGN KEY (product_detail_id) REFERENCES product_detail(product_detail_id),
)
go
CREATE TABLE supplier(
	supplier_id BIGINT PRIMARY KEY IDENTITY(1,1),
	supplier_name NVARCHAR(100),
	addresss NVARCHAR(100),
	phone VARCHAR(20),
	email VARCHAR(100),
	display BIT,
	deleted BIT NOT NULL DEFAULT 0
)
go
CREATE TABLE import_receipt(
	import_receipt_id BIGINT PRIMARY KEY IDENTITY(1,1),
	supplier_id BIGINT,
	users_id BIGINT,
	total_amount FLOAT,
	import_date DATETIME,
	deleted BIT NOT NULL DEFAULT 0,
	CONSTRAINT fk_import_receipt_supplier FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
	CONSTRAINT fk_import_receipt_user FOREIGN KEY (users_id) REFERENCES users(users_id)
)
go
CREATE TABLE import_receipt_detail(
	import_receipt_detail_id BIGINT PRIMARY KEY IDENTITY(1,1),
	product_id BIGINT,
	import_receipt_id BIGINT,
	quantity INT,
	price FLOAT,
	deleted BIT NOT NULL DEFAULT 0,
	CONSTRAINT fk_import_receipt_detail_import FOREIGN KEY (import_receipt_id) REFERENCES import_receipt(import_receipt_id),
	CONSTRAINT fk_import_receipt_detale_product FOREIGN KEY (product_id) REFERENCES product(product_id)
)
go
CREATE TABLE discount(
	discount_id BIGINT PRIMARY KEY IDENTITY(1,1),
	discount_name NVARCHAR(100),
	[description] NVARCHAR(250),
	[start_date] DATETIME,
	end_date DATETIME,
	discount_rate DECIMAL(5,2),
	display BIT,
	[status] NVARCHAR(100)
)
go
CREATE TABLE product_discount(
	product_discount_id BIGINT PRIMARY KEY IDENTITY(1,1),
	discount_id BIGINT,
	product_id BIGINT,
	CONSTRAINT fk_product_discount_discount FOREIGN KEY (discount_id) REFERENCES discount(discount_id),
	CONSTRAINT fk_product_discount_product FOREIGN KEY (product_id) REFERENCES product(product_id)
)
go
CREATE TABLE direct_discount(
	direct_discount_id BIGINT PRIMARY KEY IDENTITY(1,1),
	product_id BIGINT,
	direct_discount DECIMAL(5,2),
	[start_date] DATETIME,
	end_date DATETIME,
	CONSTRAINT fk_direct_discount FOREIGN KEY (product_id) REFERENCES product(product_id)
)
go


-- Dữ liệu
--Users

--Brand
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted]) VALUES (N'Converse', N'3294d63f.png', 1, 0)
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted]) VALUES (N'Nike', N'b66762fa.png', 0, 0)
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted]) VALUES (N'Puma', N'7315656b.jpg', 1, 0)
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted]) VALUES (N'Reebok', N'd211e981.png', 0, 0)
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted]) VALUES (N'New Balance', N'f477e2d8.png', 1, 1)

--Category
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted]) VALUES (1, N'Giày nam', N'f62a6d0f.jpg', 1, 0)
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted]) VALUES (2, N'Giày nữ', N'337baa95.jpg', 0, 0)
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted]) VALUES (3, N'Giày thể thao', N'92e775d.jpg', 1, 0)
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted]) VALUES (4, N'Giày chạy bộ', N'47266f7.jpg', 0, 0)
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted]) VALUES (5, N'Giày đi bộ', N'26a75d10.jpg', 1, 1)
																					   
--Size
INSERT [dbo].[size] ([size_number], [activities], [deleted]) VALUES (1, 38.5, 1, 0)
INSERT [dbo].[size] ([size_number], [activities], [deleted]) VALUES (2, 39.5, 1, 0)
INSERT [dbo].[size] ([size_number], [activities], [deleted]) VALUES (3, 40, 0, 0)
INSERT [dbo].[size] ([size_number], [activities], [deleted]) VALUES (4, 41, 1, 0)
INSERT [dbo].[size] ([size_number], [activities], [deleted]) VALUES (5, 42, 0, 1)

--Product
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (1, N'Converse 01', 1, 1,1, 5000000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (2, N'Converse 02', 2, 1,2, 1500000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 1, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (3, N'Converse 03', 3, 1,3, 2000000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 1, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (4, N'Converse 04', 4, 1,4, 1350000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (5, N'Converse 05', 5, 1,5, 2450000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (6, N'Converse 06', 1, 1,1, 3650000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (7, N'Converse 07', 2, 1,2, 6590000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.' , 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (8, N'Converse 08', 3, 1,3, 799000 , N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.' , 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (9, N'Converse 09', 4, 1,4, 500000 , N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.' , 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (10, N'Converse 10', 5, 1,5, 499000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (11, N'Nike 01', 2, 2,1, 7200000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (12, N'Nike 02', 1, 2,1, 4000000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 1, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (13, N'Nike 03', 2, 2,1, 6000000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (14, N'Nike 04', 1, 2,1, 1500000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (15, N'Nike 05', 2, 2,1, 2000000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.' ,1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (16, N'Nike 06', 4, 2,1, 7680000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (17, N'Nike 07', 2, 2,1, 567000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (18, N'Nike 08', 5, 2,1, 876000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (19, N'Nike 09', 2, 2,1, 567000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (20, N'Nike 10', 2, 2,1, 987000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (21, N'Puma 01', 4, 3,1, 867000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (22, N'Puma 02', 3, 3,1, 967000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.',1, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime)  ,0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (23, N'Puma 03', 3, 3,1, 934000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 1, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (24, N'Puma 04', 5, 3,1, 912000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ .', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (25, N'Puma 05', 3, 3,1, 856000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”'   , 1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (26, N'Puma 06', 2, 3,1, 712000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (27, N'Puma 07', 3, 3,1, 536000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,',  0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (28, N'Puma 08', 1, 3,1, 933000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.' ,  0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (29, N'Puma 09', 3, 3,1, 655000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.' , 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime) ,0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (30, N'Puma 10', 3, 3,1, 966000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.' , 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime) ,0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (31, N'Reebok 01', 4, 4,2, 908000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (32, N'Reebok 02', 2, 4,2, 987000,  N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.',1, 1,CAST(N'2021-08-21T00:00:00.000' AS DateTime) ,0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (33, N'Reebok 03', 4, 4,2, 6785430, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.',1, 0,CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (34, N'Reebok 04', 4, 4,2, 789500, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (35, N'Reebok 05', 1, 4,2, 876000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (36, N'Reebok 06', 4, 4,2, 654000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (37, N'Reebok 07', 3, 4,2, 567000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (38, N'Reebok 08', 4, 4,2, 678900, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (39, N'Reebok 09', 4, 4,2, 666000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (40, N'Reebok 10', 3, 4,2, 999000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (41, N'New Balance 01', 5, 5, 3, 222000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (42, N'New Balance 02', 5, 5, 3, 666000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 1, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (43, N'New Balance 03', 2, 5, 3, 999000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (44, N'New Balance 04', 5, 5, 3, 777000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (45, N'New Balance 05', 3, 5, 3, 879000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (46, N'New Balance 06', 1, 5, 3, 567000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (47, N'New Balance 07', 5, 5, 3, 8979000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (48, N'New Balance 08', 5, 5, 3, 8789000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (49, N'New Balance 09', 1, 5, 3, 6543000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [created_date], [deleted]) VALUES (50, N'New Balance 10', 5, 5, 3, 2098908, 0, 1, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', CAST(N'2020-07-05T00:00:00.000' AS DateTime),0)


--Color
INSERT [dbo].[color] ([product_id], [color_name], [color_image], [activities]) VALUES (1, 1, N'Ðen', N'img.png',1, 0)
INSERT [dbo].[color] ([produt_id], [color_name], [color_image], [activities]) VALUES (3, 3, N'Xanh lá',N'img.png' ,1, 0)
INSERT [dbo].[color] ([producct_id], [color_name], [color_image], [activities]) VALUES (2, 2, N'Xanh lam',N'img.png' ,0, 0)
INSERT [dbo].[color] ([product_id], [color_name], [color_image], [activities]) VALUES (4, 4, N'Vàng',N'img.png' ,0, 0)
INSERT [dbo].[color] ([product_id], [color_name], [color_image], [activities]) VALUES (5, 5, N'Đỏ',N'img.png' ,1, 0)
INSERT [dbo].[color] ([product_id], [color_name], [color_image], [activities]) VALUES (8, 6, N'Tím', N'img.png',1, 1)

--Product Detail
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (1, 1, 3, 1, 50, 0)
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (2, 1, 1, 2, 24, 0)
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (3, 1, 1, 3, 50, 0)
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (4, 1, 1, 4, 50, 0)
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (5, 1, 1, 5, 50, 0)
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (6, 1, 2, 1, 47, 0)
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (7, 1, 2, 2, 50, 0)
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (8, 1, 2, 3, 8, 0)
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (9, 1, 2, 4, 50, 0)
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted]) VALUES (10, 1, 2, 5, 50, 1)

--Favorite


--Review



--Cart


--Cart detail


--payment_menthod



--Order


--order_detail



--supplier


--import_receipt


--import_receipt_detail


--direct_discount


