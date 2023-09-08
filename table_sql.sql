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
	CONSTRAINT fk_direct_discount FOREIGN KEY (product_id) REFERENCES product(product_id)
)
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

go
INSERT INTO import_receipt (supplier_id, users_id, total_amount, import_date)
VALUES
    (1, 1, 100.50, '2023-09-08 10:00:00'),
    (2, 2, 150.25, '2023-09-08 11:15:00'),
    (3, 3, 200.75, '2023-09-08 12:30:00'),
    (4, 4, 75.20, '2023-09-08 14:00:00'),
    (5, 5, 300.00, '2023-09-08 15:45:00'),
    (6, 6, 50.75, '2023-09-08 16:30:00'),
    (7, 7, 180.90, '2023-09-08 17:20:00'),
    (8, 8, 90.60, '2023-09-08 18:10:00'),
    (9, 9, 250.30, '2023-09-08 19:00:00'),
    (10, 10, 120.15, '2023-09-08 20:00:00');

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

go
INSERT INTO direct_discount (product_id, direct_discount, [start_date], end_date)
VALUES
    (1, 10.50, '2023-09-08 10:00:00', '2023-09-08 12:00:00'),
    (2, 5.25, '2023-09-08 11:00:00', '2023-09-08 13:00:00'),
    (3, 8.75, '2023-09-08 12:00:00', '2023-09-08 14:00:00'),
    (4, 3.20, '2023-09-08 13:00:00', '2023-09-08 15:00:00'),
    (5, 15.00, '2023-09-08 14:00:00', '2023-09-08 16:00:00'),
    (6, 2.75, '2023-09-08 15:00:00', '2023-09-08 17:00:00'),
    (7, 9.90, '2023-09-08 16:00:00', '2023-09-08 18:00:00'),
    (8, 4.60, '2023-09-08 17:00:00', '2023-09-08 19:00:00'),
    (9, 12.30, '2023-09-08 18:00:00', '2023-09-08 20:00:00'),
    (10, 6.15, '2023-09-08 19:00:00', '2023-09-08 21:00:00');