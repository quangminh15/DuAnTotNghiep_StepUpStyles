go
Use master;
go
create database stepupstyles;
go
use stepupstyles;
go
CREATE TABLE users (
    users_id BIGINT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(90),
    [address] NVARCHAR(250),
    phone NVARCHAR(11),
    birthday DATE,
    [role] NVARCHAR(50),
    created_date DATE,
    [status] BIT,
    email NVARCHAR(50),
    [password] NVARCHAR(250),
    [image] NVARCHAR(250),
    deleted BIT,
    activaties BIT,
	origin NVARCHAR(50)
);
go
-- Tạo bảng Brand
CREATE TABLE brand (
  brand_id BIGINT PRIMARY KEY IDENTITY(1,1),
  brand_name NVARCHAR(50) NOT NULL,
  brand_image NVARCHAR(MAX) NOT NULL,
  activities BIT NOT NULL DEFAULT 0,
  deleted BIT NOT NULL DEFAULT 0,
  modify_date datetime NULL,
);
go
-- Tạo bảng Category
CREATE TABLE category (
  category_id BIGINT PRIMARY KEY IDENTITY(1,1),
  category_name NVARCHAR(50) NOT NULL,
  category_image NVARCHAR(MAX) NOT NULL,
  activities BIT NOT NULL DEFAULT 0,
  deleted BIT NOT NULL DEFAULT 0,
  modify_date datetime NULL,
);
go

-- Tạo bảng Size
CREATE TABLE size (
  size_id BIGINT PRIMARY KEY IDENTITY(1,1),
  size_number FLOAT NOT NULL,
  activities BIT NOT NULL DEFAULT 0,
  deleted BIT NOT NULL DEFAULT 0,
  modify_date datetime NULL,
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
  modify_date datetime NULL,
  deleted BIT NOT NULL DEFAULT 0,
  CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES category(category_id),
  CONSTRAINT fk_brand FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
  CONSTRAINT fk_userr FOREIGN KEY (users_id) REFERENCES users(users_id)
);

--Tạo bảng image_path
go 
CREATE TABLE product_image (
  product_image_id BIGINT PRIMARY KEY IDENTITY(1,1),
  product_id BIGINT NOT NULL,
  image_path NVARCHAR(MAX) NOT NULL,
  modify_date datetime NULL,
  CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES product(product_id),
);
go
-- Tạo bảng Color
CREATE TABLE color (
  color_id BIGINT PRIMARY KEY IDENTITY(1,1),
  color_name NVARCHAR(50) NOT NULL,
  activities BIT NOT NULL DEFAULT 0,
  deleted BIT NOT NULL DEFAULT 0,
  modify_date datetime NULL,
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
  modify_date datetime NULL,
  CONSTRAINT fk_productqw FOREIGN KEY (product_id) REFERENCES product(product_id),
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
	check_buy bit

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
    address_details NVARCHAR(255),
	default_address bit ,
	users_id bigint
	FOREIGN KEY (users_id) REFERENCES users(users_id),
);
go

CREATE TABLE [order](
	order_id bigint IDENTITY(1,1) NOT NULL primary key,
	users_id bigint ,
	shipping_address_id bigint,
	payment_method_id bigint ,
	delivery_date date , 
	payment_status bit ,
	delivery_status bit,
	order_date datetime,
	initial_price float,
	shipping_fee float,
	total_amount float,
	order_status nvarchar(50),
	discount_price float

	FOREIGN KEY (shipping_address_id) REFERENCES shipping_address(shipping_address_id),
	FOREIGN KEY (users_id) REFERENCES users(users_id),
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
	product_detail_id BIGINT,
	import_receipt_id BIGINT,
	quantity INT,
	price FLOAT,
	deleted BIT NOT NULL DEFAULT 0,
	CONSTRAINT fk_import_receipt_detail_import FOREIGN KEY (import_receipt_id) REFERENCES import_receipt(import_receipt_id),
	CONSTRAINT fk_import_receipt_detale_product FOREIGN KEY (product_detail_id) REFERENCES product_detail(product_detail_id)
)
go
CREATE TABLE direct_discount(
	direct_discount_id BIGINT PRIMARY KEY IDENTITY(1,1),
	product_id BIGINT,
	direct_discount DECIMAL(5,2),
	[start_date] DATETIME,
	end_date DATETIME,
    [status] NVARCHAR(50),
    price_discount FLOAT,
	CONSTRAINT fk_direct_discount FOREIGN KEY (product_id) REFERENCES product(product_id)
)
go


-- Dữ liệu
--Users
go
INSERT INTO users (full_name, [address], phone, birthday, [role], created_date, [status], email, [password], [image], deleted, activaties)
VALUES 
    (N'Bùi Thanh Bùi', '123 Main St', 0123123123, '1990-01-15', 'User', '2023-08-10', 1, 'BTB@gmail.com', '202cb962ac59075b964b07152d234b70', 'image1.jpg', 0, 1),
    (N'Đi Bộ Vuốt Râu', '456 Elm St', 09879879897, '1985-03-20', 'Admin', '2023-08-11', 1, 'DBVR@gnail.com', '202cb962ac59075b964b07152d234b70', 'image2.jpg', 0, 1),
    (N'RiChaRiCon', '789 Oak St', 0456456456, '1995-07-05', 'User', '2023-08-12', 1, 'RCRC@gmail.com', '202cb962ac59075b964b07152d234b70', 'image3.jpg', 0, 1),
    (N'Trần Thanh Hải', '101 Pine St', 0977866511, '1980-11-30', 'User', '2023-08-13', 1, 'bob@gmail.com', '202cb962ac59075b964b07152d234b70', 'image4.jpg', 0, 1),
    (N'Nguyễn Lê Văn Thi', '202 Cedar St', 0986543166, '1988-09-25', 'Admin', '2023-08-14', 1, 'NLVT@gmail.com', '202cb962ac59075b964b07152d234b70', 'image5.jpg', 0, 1),
    ('Jack5M', '303 Spruce St', 0919919918, '1992-05-10', 'User', '2023-08-15', 1, 'jack5milion@example.com', '202cb962ac59075b964b07152d234b70', 'image6.jpg', 0, 1);
--Brand
go
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (N'Converse', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2FN.png?alt=media&token=ee468e27-b9cb-4d44-a7aa-d9ce44edc563', 1, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (N'Nike', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2FN2.jpg?alt=media&token=2fa25ee7-6298-40ee-a1af-298473e69ff3', 0, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (N'Puma', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2FN3.jpg?alt=media&token=0c3bd08a-bbd3-4a40-8b49-cf119db4d232', 1, 0, CAST(N'2009-09-12T00:00:00.000' AS DateTime))
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (N'Reebok', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2FN4.jpg?alt=media&token=1a5454e3-1eb9-43c1-aaee-93c652e4b523', 0, 0, CAST(N'2019-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[brand] ([brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (N'New Balance', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2FN5.jpg?alt=media&token=c7bb3a37-6673-4248-9cc8-412b8c6d6f96', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
--Category
go
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted], [modify_date]) VALUES ( N'Giày nam', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid2.jpg?alt=media&token=c1c66f85-eff7-44c6-a393-00a5199bd31e', 1, 0, CAST(N'2021-01-12T00:00:00.000' AS DateTime))
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted], [modify_date]) VALUES ( N'Giày nữ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid3.jpg?alt=media&token=3301b61a-fbc3-461a-8146-e393e3088f8a', 0, 0, CAST(N'2020-08-12T00:00:00.000' AS DateTime))
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted], [modify_date]) VALUES ( N'Giày thể thao', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid4.jpg?alt=media&token=127d7bd7-808d-407a-8fbc-11a1f697f21c', 1, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted], [modify_date]) VALUES ( N'Giày chạy bộ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid5.jpg?alt=media&token=b9b8ea55-468a-4af1-8ecc-55b4df6561a7', 0, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[category] ([category_name], [category_image], [activities], [deleted], [modify_date]) VALUES ( N'Giày đi bộ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid6.jpg?alt=media&token=ef1773b3-bf5f-4087-a8c6-45fddc0f85d4', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime))														   
--Size
go
INSERT [dbo].[size] ([size_number], [activities], [deleted], [modify_date]) VALUES (38.5, 1, 0, CAST(N'2020-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_number], [activities], [deleted], [modify_date]) VALUES (39.5, 1, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_number], [activities], [deleted], [modify_date]) VALUES (40, 0, 0, CAST(N'2023-03-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_number], [activities], [deleted], [modify_date]) VALUES (41, 1, 0, CAST(N'2022-04-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_number], [activities], [deleted], [modify_date]) VALUES (42, 0, 1, CAST(N'2020-05-12T00:00:00.000' AS DateTime))
--Product
go
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (N'Converse 01', 1, 1,1, 5000000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (N'Converse 02', 2, 1,2, 1500000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 1, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (N'Converse 03', 3, 1,3, 2000000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 1, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (N'Converse 04', 4, 1,4, 1350000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (N'Converse 05', 5, 1,5, 2450000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (N'Converse 06', 1, 1,1, 3650000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (N'Converse 07', 2, 1,2, 6590000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.' , 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (N'Converse 08', 3, 1,3, 799000 , N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.' , 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (N'Converse 09', 4, 1,4, 500000 , N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.' , 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Converse 10', 5, 1,5, 499000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 01', 2, 2,1, 7200000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 02', 1, 2,1, 4000000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 1, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 03', 2, 2,1, 6000000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 04', 1, 2,1, 1500000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 05', 2, 2,1, 2000000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.' ,1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 06', 4, 2,1, 7680000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 07', 2, 2,1, 567000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 08', 5, 2,1, 876000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 09', 2, 2,1, 567000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Nike 10', 2, 2,1, 987000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 01', 4, 3,1, 867000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 02', 3, 3,1, 967000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.',1, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime)  ,0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 03', 3, 3,1, 934000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 1, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 04', 5, 3,1, 912000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ .', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 05', 3, 3,1, 856000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”'   , 1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 06', 2, 3,1, 712000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 07', 3, 3,1, 536000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,',  0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 08', 1, 3,1, 933000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.' ,  0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 09', 3, 3,1, 655000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.' , 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime) ,0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Puma 10', 3, 3,1, 966000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.' , 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime) ,0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 01', 4, 4,2, 908000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 02', 2, 4,2, 987000,  N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.',1, 1,CAST(N'2021-08-21T00:00:00.000' AS DateTime) ,0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 03', 4, 4,2, 6785430, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.',1, 0,CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 04', 4, 4,2, 789500, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 05', 1, 4,2, 876000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 06', 4, 4,2, 654000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 07', 3, 4,2, 567000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 08', 4, 4,2, 678900, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 09', 4, 4,2, 666000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'Reebok 10', 3, 4,2, 999000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 01', 5, 5, 3, 222000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 02', 5, 5, 3, 666000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 1, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 03', 2, 5, 3, 999000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 04', 5, 5, 3, 777000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 05', 3, 5, 3, 879000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 06', 1, 5, 3, 567000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 07', 5, 5, 3, 8979000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 08', 5, 5, 3, 8789000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 09', 1, 5, 3, 6543000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime),0)
INSERT [dbo].[product] ([product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES ( N'New Balance 10', 5, 5, 3, 2098908, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime),0)
--[product_image]
go
INSERT [dbo].[product_image] ([product_id],[image_path], [modify_date]) VALUES (1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/images%2Fshop-11.jpg?alt=media&token=18d95f47-b2d6-4e81-95c6-8c510e8a6b93', CAST(N'2023-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_id],[image_path], [modify_date]) VALUES (3,N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/images%2Fshop-22.jpg?alt=media&token=94c0a4ed-69e6-4827-9163-fd8f4b1a427c', CAST(N'2023-07-05T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_id],[image_path], [modify_date]) VALUES (2,N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/images%2Fshop-4.jpg?alt=media&token=d30a1129-ad2b-4a27-a0c4-0a5ff61ed1cc', CAST(N'2022-07-02T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_id],[image_path], [modify_date]) VALUES (4,N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/images%2Fshop-66.jpg?alt=media&token=d5e75b21-cca8-4b5d-a9ab-6e5c69e964bb', CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_id],[image_path], [modify_date]) VALUES (5,N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/images%2Fshop-4.jpg?alt=media&token=d30a1129-ad2b-4a27-a0c4-0a5ff61ed1cc', CAST(N'2021-02-09T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_id],[image_path], [modify_date]) VALUES (6, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/images%2Fshop-22.jpg?alt=media&token=94c0a4ed-69e6-4827-9163-fd8f4b1a427c', CAST(N'2021-01-11T00:00:00.000' AS DateTime))

--Color
go
INSERT [dbo].[color] ([color_name],[activities], [deleted], [modify_date]) VALUES (N'Ðen',1, 0, CAST(N'2020-01-12T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_name],[activities], [deleted], [modify_date]) VALUES (N'Xanh lá' ,1, 0, CAST(N'2021-02-12T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_name],[activities], [deleted], [modify_date]) VALUES (N'Xanh lam' ,0, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_name],[activities], [deleted], [modify_date]) VALUES (N'Vàng' ,0, 0, CAST(N'2023-04-11T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_name],[activities], [deleted], [modify_date]) VALUES (N'Đỏ',1, 0, CAST(N'2022-07-06T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_name],[activities], [deleted], [modify_date]) VALUES (N'Tím',1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime))

--Product Detail
go
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (1, 3, 1, 50, 0, CAST(N'2021-01-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (2, 1, 2, 24, 0, CAST(N'2022-02-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (3, 1, 3, 50, 0, CAST(N'2023-06-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (4, 1, 4, 50, 0, CAST(N'2020-08-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (5, 1, 5, 50, 0, CAST(N'2019-09-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (6, 2, 1, 47, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (7, 2, 2, 50, 0, CAST(N'2020-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (8, 2, 3, 8, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (9, 2, 4, 50, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (10, 2, 5, 50, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime))

--Favorite
go
INSERT INTO favorite( product_id,[users_id],date_like)
VALUES (3,4,'2022-12-12'),
	   (2,2,'2023-08-05'),
	   (5,2,'2023-03-20'),
	   (2,5,'2023-07-20'),
	   (1,3,'2023-05-12'),
	   (3,2,'2023-06-30'),
	   (4,3,'2023-08-01'),
	   (2,4,'2023-09-03'),
	   (3,2,'2023-04-01'),
	   (4,2,'2023-01-01')
--Review
go
INSERT INTO review (product_id, title, [users_id], review_date, display, rating)
VALUES
    (1, N'Sản phẩm tuyệt vời!', 3, '2023-08-15', 1, 5),
    (2, N'Chất lượng tốt', 2, '2023-08-14', 1, 4),
    (1, N'Dịch vụ xuất sắc', 3, '2023-08-13', 1, 5),
    (3, N'Không được khuyến nghị', 4, '2023-08-12', 1, 2),
    (2, N'Trung bình', 5, '2023-08-11', 1, 3),
    (4, N'Đề xuất cao', 2, '2023-08-10', 1, 5),
    (3, N'Chất lượng kém', 2, '2023-08-09', 1, 1),
    (4, N'Giao hàng nhanh', 4, '2023-08-07', 1, 4),
    (6, N'Không đáng giá giá tiền', 5, '2023-08-06', 1, 2),
    (5, N'Tuyệt vời', 5, '2023-08-05', 1, 5),
    (7, N'Terrible', 2, '2023-08-04', 1, 1),
    (6, N'Sản phẩm trung bình', 3, '2023-08-03', 1, 3),
    (8, N'Giá trị tốt', 4, '2023-08-02', 1, 4),
    (7, N'Kinh khủng', 5, '2023-08-01', 1, 1);
--Cart
insert into cart(users_id)
values (1),
	   (2),
	   (3),
	   (4),
	   (5);

--Cart detail
insert into cart_detail(cart_id,product_detail_id,product_id,quantity)
values (1,1,1,1),
	   (2,1,2,2),
	   (3,1,3,2),
	   (4,2,3,1),
	   (5,1,2,4);

--payment_menthod
insert into payment_menthod(payment_menthod_name,[description],display)
values (N'Thanh toán khi nhân hàng',N'Thanh toán tiền mặt',1),
	   (N'VNPAY',N'Thanh toán online',1),
	   (N'PayPal',N'Thanh toán online',1);

--shipping_address
INSERT INTO shipping_address (province, district, ward, address_details, default_address, users_id)
VALUES
    (N'Hà Nội', N'Cầu Giấy', N'Dịch Vọng Hậu', N'123 Đường ABC', 1, 1),
    (N'TPHCM', N'Quận 1', N'Bến Nghé', N'456 Đường XYZ', 0, 2),
    (N'Hải Phòng', N'Hồng Bàng', N'Ngô Quyền', N'789 Đường DEF', 0, 3),
    (N'Đà Nẵng', N'Hải Châu', N'Hòa Cường Nam', N'101 Đường GHI', 0, 4),
    (N'Cần Thơ', N'Ninh Kiều', N'Tân An', N'202 Đường JKL', 0, 5);
--Order

INSERT INTO [order] (users_id, payment_method_id, shipping_address_id, delivery_date, payment_status, delivery_status, order_date, initial_price, shipping_fee, total_amount, order_status)
VALUES
    (1, 1, 1, '2023-09-10', 1, 0, '2023-09-07 08:00:00', 100.00, 10.00, 110.00, 'Processing'),
    (2, 2, 2, '2023-09-10',1, 0, '2023-09-07 09:30:00', 150.00, 12.50, 162.50, 'Shipped'),
	(3, 3, 3, '2023-09-12', 1, 0, '2023-09-07 10:45:00', 75.00, 7.50, 82.50, 'Delivered'),
    (4, 1, 4, '2023-09-13', 1, 0, '2023-09-07 12:15:00', 200.00, 15.00, 215.00, 'Processing'),
    (5, 1, 5, '2023-09-14', 1, 0, '2023-09-07 13:45:00', 90.00, 8.00, 98.00, 'Pending');
--order_detail
INSERT INTO order_detail (order_id, product_detail_id, quantity, price)
VALUES
    (1, 2, 3, 25.00),
    (1, 3, 2, 15.00),
    (2, 1, 4, 30.00),
    (3, 2, 1, 10.00),
    (4, 3, 5, 50.00);



--supplier
go
INSERT INTO supplier (supplier_name, addresss, phone, email, display)
VALUES
    (N'Nhà cung cấp 1', N'Địa chỉ 1', N'123456789', N'email1@example.com', 1),
    (N'Nhà cung cấp 2', N'Địa chỉ 2', N'987654321', N'email2@example.com', 1),
    (N'Nhà cung cấp 3', N'Địa chỉ 3', N'555555555', N'email3@example.com', 1),
    (N'Nhà cung cấp 4', N'Địa chỉ 4', N'111111111', N'email4@example.com', 0),
    (N'Nhà cung cấp 5', N'Địa chỉ 5', N'222222222', N'email5@example.com', 1),
    (N'Nhà cung cấp 6', N'Địa chỉ 6', N'333333333', N'email6@example.com', 0),
    (N'Nhà cung cấp 7', N'Địa chỉ 7', N'444444444', N'email7@example.com', 1),
    (N'Nhà cung cấp 8', N'Địa chỉ 8', N'666666666', N'email8@example.com', 0),
    (N'Nhà cung cấp 9', N'Địa chỉ 9', N'777777777', N'email9@example.com', 1),
    (N'Nhà cung cấp 10', N'Địa chỉ 10', N'999999999', N'email10@example.com', 1);
--import_receipt
go
INSERT INTO import_receipt (supplier_id, users_id, total_amount, import_date)
VALUES
    (1, 1, 100.50, '2023-09-08 10:00:00'),
    (2, 2, 150.25, '2023-09-08 11:15:00'),
    (3, 3, 200.75, '2023-09-08 12:30:00'),
    (4, 4, 75.20, '2023-09-08 14:00:00'),
    (5, 5, 300.00, '2023-09-08 15:45:00'),
    (6, 1, 50.75, '2023-09-08 16:30:00'),
    (7, 2, 180.90, '2023-09-08 17:20:00'),
    (8, 3, 90.60, '2023-09-08 18:10:00'),
    (9, 4, 250.30, '2023-09-08 19:00:00'),
    (10, 5, 120.15, '2023-09-08 20:00:00');
--import_receipt_detail
go
INSERT INTO import_receipt_detail (product_detail_id, import_receipt_id, quantity, price)
VALUES
    (1, 1, 10, 15.50),
    (2, 2, 8, 20.25),
    (3, 3, 12, 30.75),
    (4, 4, 5, 10.20),
    (5, 5, 15, 45.00),
    (6, 6, 3, 5.75),
    (7, 7, 9, 18.90),
    (8, 8, 6, 9.60),
    (9, 9, 14, 25.30),
    (10, 10, 7, 12.15);
--direct_discount
go
INSERT INTO direct_discount (product_id, direct_discount, [start_date], end_date, [status], price_discount)
VALUES
    (1, 10.50, '2023-09-08 10:00:00', '2023-09-08 10:00:00', 'Đã Kết Thúc', 10.5),
    (2, 5.25, '2023-09-08 10:00:00', '2023-09-08 10:00:00', 'Đã Kết Thúc', 10.5),
    (3, 8.75, '2023-09-08 10:00:00', '2023-09-08 10:00:00', 'Đã Kết Thúc', 10.5);