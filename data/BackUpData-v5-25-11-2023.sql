USE [master]
GO
/****** Object:  Database [stepupstyles]    Script Date: 25/11/2023 9:36:40 CH ******/
CREATE DATABASE [stepupstyles]
GO
ALTER DATABASE [stepupstyles] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [stepupstyles] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [stepupstyles] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [stepupstyles] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [stepupstyles] SET ARITHABORT OFF 
GO
ALTER DATABASE [stepupstyles] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [stepupstyles] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [stepupstyles] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [stepupstyles] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [stepupstyles] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [stepupstyles] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [stepupstyles] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [stepupstyles] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [stepupstyles] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [stepupstyles] SET  ENABLE_BROKER 
GO
ALTER DATABASE [stepupstyles] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [stepupstyles] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [stepupstyles] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [stepupstyles] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [stepupstyles] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [stepupstyles] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [stepupstyles] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [stepupstyles] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [stepupstyles] SET  MULTI_USER 
GO
ALTER DATABASE [stepupstyles] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [stepupstyles] SET DB_CHAINING OFF 
GO
ALTER DATABASE [stepupstyles] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [stepupstyles] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [stepupstyles] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [stepupstyles] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'stepupstyles', N'ON'
GO
ALTER DATABASE [stepupstyles] SET QUERY_STORE = OFF
GO
USE [stepupstyles]
GO
/****** Object:  Table [dbo].[brand]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brand](
	[brand_id] [bigint] IDENTITY(1,1) NOT NULL,
	[brand_name] [nvarchar](50) NOT NULL,
	[brand_image] [nvarchar](max) NOT NULL,
	[activities] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[modify_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[cart_id] [bigint] IDENTITY(1,1) NOT NULL,
	[users_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart_detail]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart_detail](
	[cart_detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[cart_id] [bigint] NULL,
	[product_detail_id] [bigint] NULL,
	[product_id] [bigint] NULL,
	[quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[cart_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[category_id] [bigint] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](50) NOT NULL,
	[category_image] [nvarchar](max) NOT NULL,
	[activities] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[modify_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[color]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[color](
	[color_id] [bigint] IDENTITY(1,1) NOT NULL,
	[color_name] [nvarchar](50) NOT NULL,
	[activities] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[modify_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[color_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[direct_discount]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[direct_discount](
	[direct_discount_id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_id] [bigint] NULL,
	[direct_discount] [decimal](5, 2) NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
	[deleted] [bit] NOT NULL,
	[status] [nvarchar](50) NULL,
	[price_discount] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[direct_discount_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[favorite]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[favorite](
	[favorite_id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_id] [bigint] NULL,
	[users_id] [bigint] NULL,
	[date_like] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[favorite_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[import_receipt]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[import_receipt](
	[import_receipt_id] [bigint] IDENTITY(1,1) NOT NULL,
	[supplier_id] [bigint] NULL,
	[users_id] [bigint] NULL,
	[total_amount] [float] NULL,
	[import_date] [datetime] NULL,
	[deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[import_receipt_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[import_receipt_detail]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[import_receipt_detail](
	[import_receipt_detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_detail_id] [bigint] NULL,
	[import_receipt_id] [bigint] NULL,
	[quantity] [int] NULL,
	[price] [float] NULL,
	[deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[import_receipt_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[order_id] [bigint] IDENTITY(1,1) NOT NULL,
	[users_id] [bigint] NULL,
	[shipping_address_id] [bigint] NULL,
	[payment_method_id] [bigint] NULL,
	[delivery_date] [date] NULL,
	[payment_status] [bit] NULL,
	[delivery_status] [bit] NULL,
	[order_date] [datetime] NULL,
	[initial_price] [float] NULL,
	[shipping_fee] [float] NULL,
	[total_amount] [float] NULL,
	[order_status] [nvarchar](50) NULL,
	[discount_price] [float] NULL,
	[voucher_use_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order_detail]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_detail](
	[order_detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[order_id] [bigint] NULL,
	[product_detail_id] [bigint] NULL,
	[quantity] [int] NULL,
	[price] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment_menthod]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_menthod](
	[payment_method_id] [bigint] IDENTITY(1,1) NOT NULL,
	[payment_menthod_name] [nvarchar](50) NULL,
	[description] [nvarchar](max) NULL,
	[display] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[payment_method_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](100) NOT NULL,
	[category_id] [bigint] NOT NULL,
	[brand_id] [bigint] NOT NULL,
	[users_id] [bigint] NOT NULL,
	[price] [float] NOT NULL,
	[product_description] [nvarchar](max) NULL,
	[activities] [bit] NOT NULL,
	[featured] [bit] NOT NULL,
	[modify_date] [datetime] NULL,
	[deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_detail]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_detail](
	[product_detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_id] [bigint] NOT NULL,
	[size_id] [bigint] NOT NULL,
	[color_id] [bigint] NOT NULL,
	[quantity] [bigint] NOT NULL,
	[deleted] [bit] NOT NULL,
	[modify_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_image]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_image](
	[product_image_id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_id] [bigint] NOT NULL,
	[image_path] [nvarchar](max) NOT NULL,
	[modify_date] [datetime] NULL,
 CONSTRAINT [PK_product_image] PRIMARY KEY CLUSTERED 
(
	[product_image_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[review]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[review](
	[review_id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_id] [bigint] NULL,
	[title] [nvarchar](200) NULL,
	[users_id] [bigint] NULL,
	[review_date] [datetime] NULL,
	[rating] [int] NULL,
	[image1] [varchar](max) NULL,
	[image2] [varchar](max) NULL,
	[image3] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shipping_address]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shipping_address](
	[shipping_address_id] [bigint] IDENTITY(1,1) NOT NULL,
	[province] [nvarchar](255) NULL,
	[district] [nvarchar](255) NULL,
	[ward] [nvarchar](255) NULL,
	[address_details] [nvarchar](255) NULL,
	[name_receiver] [nvarchar](50) NULL,
	[phone_receiver] [char](10) NULL,
	[default_address] [bit] NULL,
	[users_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[shipping_address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[size]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[size](
	[size_id] [bigint] IDENTITY(1,1) NOT NULL,
	[size_number] [float] NOT NULL,
	[activities] [bit] NOT NULL,
	[deleted] [bit] NOT NULL,
	[modify_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[size_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[supplier]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[supplier](
	[supplier_id] [bigint] IDENTITY(1,1) NOT NULL,
	[supplier_name] [nvarchar](100) NULL,
	[addresss] [nvarchar](100) NULL,
	[phone] [varchar](20) NULL,
	[email] [varchar](100) NULL,
	[display] [bit] NULL,
	[deleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[supplier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[users_id] [bigint] IDENTITY(1,1) NOT NULL,
	[full_name] [nvarchar](90) NULL,
	[address] [nvarchar](250) NULL,
	[phone] [nvarchar](11) NULL,
	[birthday] [date] NULL,
	[role] [nvarchar](50) NULL,
	[created_date] [date] NULL,
	[status] [bit] NULL,
	[email] [nvarchar](50) NULL,
	[password] [nvarchar](250) NULL,
	[image] [nvarchar](250) NULL,
	[deleted] [bit] NULL,
	[activaties] [bit] NULL,
	[origin] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[users_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[voucher]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[voucher](
	[discount_amount] [decimal](5, 2) NULL,
	[date_start] [datetime] NULL,
	[date_end] [datetime] NULL,
	[description] [nvarchar](255) NULL,
	[total] [float] NULL,
	[deleted] [bit] NULL,
	[voucher_id] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[voucher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[voucher_use]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[voucher_use](
	[use_date] [datetime] NULL,
	[voucher_id] [bigint] NULL,
	[users_id] [bigint] NULL,
	[voucher_use_id] [bigint] IDENTITY(1,1) NOT NULL,
	[saved] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[voucher_use_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[brand] ON 

INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (1, N'Converse', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F1.png?alt=media&token=397af877-91dd-4850-84ca-f61b6317df6c', 1, 0, CAST(N'2023-11-22T14:08:49.613' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (2, N'Nike', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F2.jpg?alt=media&token=cd62e855-c786-44e8-8076-b2c410314d9b', 1, 0, CAST(N'2023-10-22T20:31:40.927' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (3, N'Puma', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F3.jpg?alt=media&token=93f717a3-d9bf-4288-a554-3e58a305c4c5', 1, 0, CAST(N'2023-11-24T09:18:26.453' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (4, N'Reebok', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F4.png?alt=media&token=cd62b1f3-38eb-4c8d-a3fa-54fbe9d33fce', 1, 0, CAST(N'2023-11-22T14:08:54.067' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (5, N'New Balance', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F5.png?alt=media&token=7e7ac7e0-b26a-498b-a1da-63ed6738e3e5', 1, 0, CAST(N'2023-11-21T16:35:11.883' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (12, N'nhutin7777', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F12.jpg?alt=media&token=f723c765-ae3e-41a0-9a93-79b4b743a648', 1, 1, CAST(N'2023-11-17T10:57:35.513' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (13, N'123', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F13.png?alt=media&token=b5356f91-3cfc-4e60-9908-2248bdb2aad6', 1, 1, CAST(N'2023-10-31T09:23:36.837' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (16, N'GIày bóng rổ\', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2FConverse.png?alt=media&token=d02bfe84-a2fe-44c0-9d13-51a6524f211f', 0, 1, CAST(N'2023-11-24T09:18:30.260' AS DateTime))
SET IDENTITY_INSERT [dbo].[brand] OFF
GO
SET IDENTITY_INSERT [dbo].[cart] ON 

INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (1, 1)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (2, 2)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (3, 3)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (4, 4)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (5, 5)
SET IDENTITY_INSERT [dbo].[cart] OFF
GO
SET IDENTITY_INSERT [dbo].[cart_detail] ON 

INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (2, 2, 1, 2, 2)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (3, 3, 1, 3, 2)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (4, 4, 2, 3, 1)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (5, 5, 1, 2, 4)
SET IDENTITY_INSERT [dbo].[cart_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (1, N'Giày nam', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2Fgiaynam.jpg?alt=media&token=b68d6705-c330-4982-b057-bb8996eba2ec', 1, 0, CAST(N'2023-11-22T19:01:08.017' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (2, N'Giày nữ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2Fgiaynu.jpg?alt=media&token=ac270809-4ce2-448c-9d45-1ad12f4d2749', 1, 0, CAST(N'2023-11-22T19:00:43.023' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (3, N'Giày thể thao', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2Fthethao.jpg?alt=media&token=12800c41-3734-4f76-8fac-b5f9ba1aa202', 1, 0, CAST(N'2023-11-22T19:00:17.170' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (4, N'Giày chạy bộ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2Fchayjbo.jpg?alt=media&token=4e395022-9dcd-49ef-936b-29786df352ae', 1, 0, CAST(N'2023-11-22T19:00:27.820' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (5, N'Giày đi bộ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid6.jpg?alt=media&token=ef1773b3-bf5f-4087-a8c6-45fddc0f85d4', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[color] ON 

INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (1, N'Ðen', 1, 0, CAST(N'2023-10-19T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (2, N'Xanh lá', 1, 0, CAST(N'2021-02-12T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (3, N'Xanh lam', 0, 0, CAST(N'2022-03-10T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (4, N'Vàng', 0, 1, CAST(N'2023-10-13T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (5, N'Đỏ', 1, 0, CAST(N'2023-10-13T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (6, N'Tím', 1, 0, CAST(N'2023-10-13T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (7, N'Hồng', 0, 0, CAST(N'2023-11-21T16:08:17.733' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (8, N'Trắng', 1, 1, CAST(N'2023-11-24T10:38:28.457' AS DateTime))
SET IDENTITY_INSERT [dbo].[color] OFF
GO
SET IDENTITY_INSERT [dbo].[direct_discount] ON 

INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (6, 2, CAST(12.00 AS Decimal(5, 2)), CAST(N'2023-10-23T14:57:00.000' AS DateTime), CAST(N'2023-10-26T14:52:00.000' AS DateTime), 1, N'Đã kết thúc', 1320000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (9, 10, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-10-23T20:29:00.000' AS DateTime), CAST(N'2023-11-03T14:53:00.000' AS DateTime), 1, N'Đã kết thúc', 474050)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (11, 4, CAST(4.00 AS Decimal(5, 2)), CAST(N'2023-11-10T14:57:00.000' AS DateTime), CAST(N'2023-11-18T14:57:00.000' AS DateTime), 0, N'Đã kết thúc', 1296000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (12, 2, CAST(3.00 AS Decimal(5, 2)), CAST(N'2023-11-02T16:30:00.000' AS DateTime), CAST(N'2023-11-11T16:30:00.000' AS DateTime), 0, N'Đã kết thúc', 1455000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (13, 5, CAST(2.00 AS Decimal(5, 2)), CAST(N'2023-11-04T16:31:00.000' AS DateTime), CAST(N'2023-11-18T16:31:00.000' AS DateTime), 0, N'Đã kết thúc', 2401000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (14, 7, CAST(10.00 AS Decimal(5, 2)), CAST(N'2023-10-30T21:50:00.000' AS DateTime), CAST(N'2023-11-03T21:47:00.000' AS DateTime), 0, N'Đã kết thúc', 5931000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (16, 8, CAST(10.00 AS Decimal(5, 2)), CAST(N'2023-10-31T22:01:00.000' AS DateTime), CAST(N'2023-11-11T22:02:00.000' AS DateTime), 0, N'Đã kết thúc', 719100)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (17, 10, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-11-21T09:25:00.000' AS DateTime), CAST(N'2023-12-09T09:25:00.000' AS DateTime), 0, N'Đang diễn ra', 474050)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (18, 6, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-01T20:33:00.000' AS DateTime), CAST(N'2023-12-07T20:33:00.000' AS DateTime), 0, N'Chưa diễn ra', 3467500)
SET IDENTITY_INSERT [dbo].[direct_discount] OFF
GO
SET IDENTITY_INSERT [dbo].[favorite] ON 

INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (1, 3, 4, CAST(N'2022-12-12T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (2, 2, 2, CAST(N'2023-08-05T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (3, 5, 2, CAST(N'2023-03-20T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (4, 2, 5, CAST(N'2023-07-20T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (6, 3, 2, CAST(N'2023-06-30T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (8, 2, 4, CAST(N'2023-09-03T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (9, 3, 2, CAST(N'2023-04-01T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (10, 4, 2, CAST(N'2023-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (56, 2, 3, CAST(N'2023-11-01T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (58, 3, 3, CAST(N'2023-11-01T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (59, 4, 3, CAST(N'2023-11-01T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (60, 5, 3, CAST(N'2023-11-01T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (64, 6, 3, CAST(N'2023-11-01T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (65, 1, 3, CAST(N'2023-11-22T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[favorite] OFF
GO
SET IDENTITY_INSERT [dbo].[import_receipt] ON 

INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (1, 1, 1, 155, CAST(N'2023-09-08T10:00:00.000' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (2, 2, 2, 162, CAST(N'2023-09-08T11:15:00.000' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (3, 3, 3, 369, CAST(N'2023-09-08T12:30:00.000' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (4, 4, 4, 51, CAST(N'2023-09-08T14:00:00.000' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (5, 5, 5, 675, CAST(N'2023-09-08T15:45:00.000' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (6, 6, 1, 17.25, CAST(N'2023-09-08T16:30:00.000' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (7, 7, 2, 170.1, CAST(N'2023-09-08T17:20:00.000' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (8, 8, 3, 57.599999999999994, CAST(N'2023-09-08T18:10:00.000' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (9, 9, 4, 354.2, CAST(N'2023-09-08T19:00:00.000' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (10, 10, 5, 85.05, CAST(N'2023-09-08T20:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[import_receipt] OFF
GO
SET IDENTITY_INSERT [dbo].[import_receipt_detail] ON 

INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (1, 1, 1, 10, 15.5, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (2, 2, 2, 8, 20.25, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (3, 3, 3, 12, 30.75, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (4, 4, 4, 5, 10.2, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (5, 5, 5, 15, 45, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (6, 6, 6, 3, 5.75, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (7, 7, 7, 9, 18.9, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (8, 8, 8, 6, 9.6, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (9, 9, 9, 14, 25.3, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (10, 10, 10, 7, 12.15, 0)
SET IDENTITY_INSERT [dbo].[import_receipt_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[order] ON 

INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (1, 1, 1, 1, CAST(N'2023-09-10' AS Date), 1, 0, CAST(N'2023-09-07T08:00:00.000' AS DateTime), 100, 10, 110, N'Confirmed', 123000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (2, 2, 2, 2, CAST(N'2023-09-10' AS Date), 1, 0, CAST(N'2023-09-07T09:30:00.000' AS DateTime), 150, 12.5, 162.5, N'Shipping', 100000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (3, 3, 3, 3, CAST(N'2023-09-12' AS Date), 1, 0, CAST(N'2023-09-07T10:45:00.000' AS DateTime), 75, 7.5, 82.5, N'Delivered', 400000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (4, 4, 4, 1, CAST(N'2023-09-13' AS Date), 1, 0, CAST(N'2023-09-07T12:15:00.000' AS DateTime), 200, 15, 215, N'Confirmed', 500000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (5, 5, 5, 1, CAST(N'2023-09-14' AS Date), 1, 0, CAST(N'2023-09-07T13:45:00.000' AS DateTime), 90, 8, 98, N'Pending', 700000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (6, 1, 6, 1, CAST(N'2023-12-02' AS Date), 0, 0, CAST(N'2023-11-25T21:30:11.000' AS DateTime), 1320000, 41501, 1361501, N'Pending', 0, NULL)
SET IDENTITY_INSERT [dbo].[order] OFF
GO
SET IDENTITY_INSERT [dbo].[order_detail] ON 

INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (1, 1, 2, 3, 25)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (2, 1, 3, 2, 15)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (3, 2, 1, 4, 30)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (4, 3, 2, 1, 10)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (5, 4, 3, 5, 50)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (6, 6, 2, 1, 1320000)
SET IDENTITY_INSERT [dbo].[order_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[payment_menthod] ON 

INSERT [dbo].[payment_menthod] ([payment_method_id], [payment_menthod_name], [description], [display]) VALUES (1, N'Thanh toán khi nhân hàng', N'Thanh toán tiền mặt', 1)
INSERT [dbo].[payment_menthod] ([payment_method_id], [payment_menthod_name], [description], [display]) VALUES (2, N'VNPAY', N'Thanh toán online', 1)
INSERT [dbo].[payment_menthod] ([payment_method_id], [payment_menthod_name], [description], [display]) VALUES (3, N'PayPal', N'Thanh toán online', 1)
SET IDENTITY_INSERT [dbo].[payment_menthod] OFF
GO
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (1, N'Converse 01', 1, 1, 7, 5000000, N'<p>Với 3 loại mcqueen: g&oacute;t đen trắng, phản quang v&agrave; g&oacute;t hoa c&uacute;c.</p>

<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong ch&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2020 nay, h&agrave;ng da, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ. Gồm MCqueen g&oacute;t đen trắng, phản quang v&agrave; mcq hoa c&uacute;c</p>

<p>-Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy mc bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao MCQueen nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-11-17T10:48:02.630' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (2, N'Converse 02', 2, 1, 7, 1500000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Mi Bantang, Quận Taijiang Địa chỉ: Mặt tiền cửa h&agrave;ng 17, Tầng 1, T&ograve;a nh&agrave; 1 #, T&ograve;a nh&agrave; Thương mại Liwei, Số 488, Đường Liuyi Middle, Phố Yingzhou, Quận Taijiang, Ph&uacute;c Ch&acirc;u, Ph&uacute;c Kiến, Trung Quốc</p>

<p>- Gi&agrave;y nam thời trang cao cổ g&oacute;t kẻ m&agrave;u c&aacute; t&iacute;nh hot trend 2020</p>

<p>- Với thiết kế phong c&aacute;ch đơn giản , đ&ocirc;i gi&agrave;y thể thao nam c&oacute; những điểm nhấn cực k&igrave; bắt mắt v&agrave; nổi bật khiến người đi nổi bật giữa đ&aacute;m đ&ocirc;ng .</p>

<p>- Chất liệu đế đ&ocirc;i gi&agrave;y nam được l&agrave;m từ cao su tổng hợp gi&uacute;p cho bạn đi cả ng&agrave;y m&agrave; vẫn cảm gi&aacute;c rất &ecirc;m &aacute;i .</p>

<p>- Với kiểu d&aacute;ng trẻ trung hiện đại , chủ nh&acirc;n của đ&ocirc;i gi&agrave;y nam c&oacute; thể phối với bất k&igrave; bộ đồ n&agrave;o trong tủ đồ , để đi chơi dạo phố , đi dự tiệc , đi du lịch picnic .</p>

<p>- Size gi&agrave;y từ 39 đến 43 cho tất cả c&aacute;c anh em lựa chọn Tất cả c&aacute;c sản phẩm gi&agrave;y b&ecirc;n shop đều c&oacute; l&oacute;t gi&agrave;y tho&aacute;ng kh&iacute; chống h&ocirc;i ch&acirc;n Shop xin CAM KẾT 100% ảnh Gi&agrave;y do Shop tự chụp v&agrave; đ&iacute;nh Logo.</p>

<p>✔️ H&agrave;ng chuẩn 100% VNXK v&agrave; QCCC - Cam kết đổi trả nếu lỗi từ nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi trả size nếu kh&ocirc;ng vừa</p>

<p>✔️ Kiểu d&aacute;ng &ocirc;m ch&acirc;n, thon gọn, thoải m&aacute;i di chuyển m&agrave; kh&ocirc;ng lo đau ch&acirc;n</p>

<p>✔️ Giao h&agrave;ng tại nh&agrave;, Thanh to&aacute;n tại nh&agrave;, nhanh ch&oacute;ng, tiện dụng CHAT TRỰC TIẾP VỚI NH&Acirc;N VI&Ecirc;N</p>

<p>✔️ Gửi kh&aacute;ch xem mẫu gi&agrave;y hiện c&oacute;</p>

<p>✔️ Tư vấn c&aacute;c mẫu gi&agrave;y ph&ugrave; hợp với kh&aacute;ch h&agrave;ng Ch&uacute;ng t&ocirc;i mong muốn bạn hạnh ph&uacute;c khi mua h&agrave;ng!</p>

<p>-----------------------------------------------------</p>
', 1, 1, CAST(N'2023-11-17T10:36:50.920' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (3, N'Converse 03', 3, 1, 7, 2000000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Mi Bantang, Quận Taijiang Địa chỉ: Mặt tiền cửa h&agrave;ng 17, Tầng 1, T&ograve;a nh&agrave; 1 #, T&ograve;a nh&agrave; Thương mại Liwei, Số 488, Đường Liuyi Middle, Phố Yingzhou, Quận Taijiang, Ph&uacute;c Ch&acirc;u, Ph&uacute;c Kiến, Trung Quốc</p>

<p>- Gi&agrave;y nam thời trang cao cổ g&oacute;t kẻ m&agrave;u c&aacute; t&iacute;nh hot trend 2020</p>

<p>- Với thiết kế phong c&aacute;ch đơn giản , đ&ocirc;i gi&agrave;y thể thao nam c&oacute; những điểm nhấn cực k&igrave; bắt mắt v&agrave; nổi bật khiến người đi nổi bật giữa đ&aacute;m đ&ocirc;ng .</p>

<p>- Chất liệu đế đ&ocirc;i gi&agrave;y nam được l&agrave;m từ cao su tổng hợp gi&uacute;p cho bạn đi cả ng&agrave;y m&agrave; vẫn cảm gi&aacute;c rất &ecirc;m &aacute;i .</p>

<p>- Với kiểu d&aacute;ng trẻ trung hiện đại , chủ nh&acirc;n của đ&ocirc;i gi&agrave;y nam c&oacute; thể phối với bất k&igrave; bộ đồ n&agrave;o trong tủ đồ , để đi chơi dạo phố , đi dự tiệc , đi du lịch picnic .</p>

<p>- Size gi&agrave;y từ 39 đến 43 cho tất cả c&aacute;c anh em lựa chọn Tất cả c&aacute;c sản phẩm gi&agrave;y b&ecirc;n shop đều c&oacute; l&oacute;t gi&agrave;y tho&aacute;ng kh&iacute; chống h&ocirc;i ch&acirc;n Shop xin CAM KẾT 100% ảnh Gi&agrave;y do Shop tự chụp v&agrave; đ&iacute;nh Logo.</p>

<p>✔️ H&agrave;ng chuẩn 100% VNXK v&agrave; QCCC - Cam kết đổi trả nếu lỗi từ nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi trả size nếu kh&ocirc;ng vừa</p>

<p>✔️ Kiểu d&aacute;ng &ocirc;m ch&acirc;n, thon gọn, thoải m&aacute;i di chuyển m&agrave; kh&ocirc;ng lo đau ch&acirc;n</p>

<p>✔️ Giao h&agrave;ng tại nh&agrave;, Thanh to&aacute;n tại nh&agrave;, nhanh ch&oacute;ng, tiện dụng CHAT TRỰC TIẾP VỚI NH&Acirc;N VI&Ecirc;N</p>

<p>✔️ Gửi kh&aacute;ch xem mẫu gi&agrave;y hiện c&oacute;</p>

<p>✔️ Tư vấn c&aacute;c mẫu gi&agrave;y ph&ugrave; hợp với kh&aacute;ch h&agrave;ng Ch&uacute;ng t&ocirc;i mong muốn bạn hạnh ph&uacute;c khi mua h&agrave;ng!</p>

<p>-----------------------------------------------------</p>
', 1, 0, CAST(N'2023-11-17T10:37:05.040' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (4, N'Converse 04', 4, 1, 7, 1350000, N'<p>Gi&agrave;y Van Nam nữ Đen Đủ Size Từ 35-43 ▪️Xuất xứ: Việt Nam</p>

<p>▪️Thương hiệu: Van ▪️Chất liệu: Vải Canvas</p>

<p>▪️Đế: Cao su lưu h&oacute;a Dải size : 35. 36. 37. 38. 39, 40, 41, 42, 43</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM ✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc 🎁 G&Oacute;C MUA H&Agrave;NG ✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 1, 1, CAST(N'2023-11-17T10:51:30.017' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (5, N'Converse 05', 5, 1, 7, 2450000, N'<p>Với 3 loại mcqueen: g&oacute;t đen trắng, phản quang v&agrave; g&oacute;t hoa c&uacute;c.</p>

<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong ch&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2020 nay, h&agrave;ng da, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ. Gồm MCqueen g&oacute;t đen trắng, phản quang v&agrave; mcq hoa c&uacute;c</p>

<p>-Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy mc bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao MCQueen nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-11-17T10:48:09.280' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (6, N'Converse 06', 1, 1, 7, 3650000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p> Size của nữ từ 36 ~39, size nam 39~43 (c&oacute; m&agrave;u ghi hồng kh&ocirc;ng c&oacute; size của nam c&ograve;n c&aacute;c m&agrave;u c&ograve;n lại đều c&oacute; đủ hai m&agrave;u nam, nữ)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 1, 1, CAST(N'2023-11-17T10:39:03.553' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (7, N'Converse 07', 2, 1, 7, 6590000, N'<p>🐾 Size: 36 - 44</p>

<p>⚡️ Tất cả sản phẩm của Shop đều cam kết Full Box, đ&oacute;ng g&oacute;i cẩn thận nhằm mang lại cho kh&aacute;ch h&agrave;ng trải nghiệm mua sắm online an t&acirc;m nhất! (Ngoại trừ c&aacute;c đợt sale gi&aacute; sỉ th&igrave; Shop kh&ocirc;ng thể hỗ trợ th&ecirc;m box đc) 👌 Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✨ Lưu &yacute; : H&agrave;ng xưởng về nhiều đợt do shop đặt số lượng lớn ,n&ecirc;n mỗi đợt lưới, logo v&agrave; đế c&oacute; kh&aacute;c nhau. C&aacute;c bạn nhớ xem b&agrave;i viết của shop v&agrave; c&acirc;n nhắc trước khi đặt nh&eacute;.</p>

<p>❗️❗️❗️ Ảnh Shop to&agrave;n bộ đều l&agrave; ảnh thật độc quyền tự chụp, c&aacute;c bạn k&eacute;o qua để xem video v&agrave; c&aacute;c g&oacute;c kh&aacute;c nh&eacute;</p>
', 1, 1, CAST(N'2023-11-17T10:35:01.683' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (8, N'Converse 08', 3, 1, 7, 799000, N'<p>Với 3 loại mcqueen: g&oacute;t đen trắng, phản quang v&agrave; g&oacute;t hoa c&uacute;c.</p>

<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong ch&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2020 nay, h&agrave;ng da, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ. Gồm MCqueen g&oacute;t đen trắng, phản quang v&agrave; mcq hoa c&uacute;c</p>

<p>-Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy mc bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao MCQueen nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-11-17T10:47:35.207' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (9, N'Converse 09', 4, 1, 7, 500000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: trắng</p>

<p>+ Size: từ 36 đến 43 (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

<p>+ Chiều cao: đế cao 2,5 cm</p>

<p>+ Trọng lượng Gi&agrave;y : 800g</p>

<p>&nbsp;</p>

<p>- Gợi &yacute; c&aacute;c dịp ph&ugrave; hợp để sử dụng:</p>

<p>+ Mọi hoạt động h&agrave;ng ng&agrave;y (đi chơi, đi học, thể dục thể thao,...)</p>

<p>+ Phối với c&aacute;c trang phục năng động hoặc đồ &acirc;u đều dễ d&agrave;ng v&agrave; t&ocirc;n d&aacute;ng</p>

<p>&nbsp;</p>

<p>- CHẾ ĐỘ BẢO H&Agrave;NH V&Agrave; ĐỔI TRẢ</p>

<p>Chế độ bảo h&agrave;nh: Gi&agrave;y b&ecirc;n shop được bảo h&agrave;nh 3 th&aacute;ng cho trường hợp bong da v&agrave; sứt chỉ.</p>

<p>Chế độ đổi trả:</p>

<p>+ Nếu gi&agrave;y lỗi b&ecirc;n shop sẽ hỗ trợ đổi, trả miễn ph&iacute; 100%</p>

<p>+ Trường hợp mua gi&agrave;y về m&agrave; size qu&aacute; rộng hoặc qu&aacute; chật, li&ecirc;n hệ lại shop trong v&ograve;ng 7 ng&agrave;y (kể từ ng&agrave;y nhận sản phẩm) để nhận đổi trả</p>

<p>&nbsp;</p>

<p>Cảm ơn c&aacute;c bạn đ&atilde; quan t&acirc;m đến sản phẩm của shop. Đừng qu&ecirc;n đ&aacute;nh gi&aacute; 5 sao khi nhận được h&agrave;ng nh&eacute;!!</p>

<p>* Mọi chi tiết v&agrave; thắc mắc xin li&ecirc;n hệ lại shop để được giải đ&aacute;p tận t&igrave;nh.</p>
', 1, 0, CAST(N'2023-11-17T10:33:29.477' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (10, N'Converse 10', 5, 1, 7, 499000, N'<p>SHOP SUS LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; JD size 39-44</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM CỔ CAO JD</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp ) ✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam JD b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đen trắng v&agrave; x&aacute;m xanh trắng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam JD c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM ✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 1, 1, CAST(N'2023-11-17T10:43:57.207' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (11, N'Nike 01', 2, 2, 7, 7200000, N'<p>🐾 Size: 36 - 44</p>

<p>⚡️ Tất cả sản phẩm của Shop đều cam kết Full Box, đ&oacute;ng g&oacute;i cẩn thận nhằm mang lại cho kh&aacute;ch h&agrave;ng trải nghiệm mua sắm online an t&acirc;m nhất! (Ngoại trừ c&aacute;c đợt sale gi&aacute; sỉ th&igrave; Shop kh&ocirc;ng thể hỗ trợ th&ecirc;m box đc) 👌 Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✨ Lưu &yacute; : H&agrave;ng xưởng về nhiều đợt do shop đặt số lượng lớn ,n&ecirc;n mỗi đợt lưới, logo v&agrave; đế c&oacute; kh&aacute;c nhau. C&aacute;c bạn nhớ xem b&agrave;i viết của shop v&agrave; c&acirc;n nhắc trước khi đặt nh&eacute;.</p>

<p>❗️❗️❗️ Ảnh Shop to&agrave;n bộ đều l&agrave; ảnh thật độc quyền tự chụp, c&aacute;c bạn k&eacute;o qua để xem video v&agrave; c&aacute;c g&oacute;c kh&aacute;c nh&eacute;</p>
', 1, 1, CAST(N'2023-11-17T10:35:16.940' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (12, N'Nike 02', 1, 2, 7, 4000000, N'<p>SHOP SUS LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; JD size 39-44</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM CỔ CAO JD</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp ) ✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam JD b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đen trắng v&agrave; x&aacute;m xanh trắng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam JD c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM ✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 1, 1, CAST(N'2023-11-21T16:04:15.813' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (13, N'Nike 03', 2, 2, 7, 6000000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa. ✔️ Chat với shop để được tư vấn nếu cần nh&eacute;.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 0, CAST(N'2023-11-21T16:04:23.137' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (14, N'Nike 04', 1, 2, 7, 1500000, N'<p>𝙏𝙝𝙤̂𝙣𝙜 𝙩𝙞𝙣 𝙨𝙖̉𝙣 𝙥𝙝𝙖̂̉𝙢:</p>

<p>- M&atilde; Sản Phẩm: MSN2871</p>

<p>- Chất lượng tốt nhất trong tầm gi&aacute;</p>

<p>- Form đẹp chuẩn : M&agrave;u sắc giống đến 98 &deg;/ₒ ;</p>

<p>- Chất liệu da + da lộn + vải mesh</p>

<p>- Logo M&ocirc;ng in dập ch&igrave;m.</p>

<p>- Lưỡi g&agrave; cao d&agrave;y dặn; swoosh sắc n&eacute;t; M&ocirc;ng mũi l&agrave;m đẹp</p>

<p>- Đế 2 lớp kh&acirc;u chỉ đều</p>

<p>- Full box + accessories</p>

<p>&nbsp;</p>

<p>&bull; Mẫu n&agrave;y bạn mang đ&uacute;ng hoặc up 1 size đối với ch&acirc;n b&egrave;</p>

<p>&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;</p>

<p>🔥shopgiaykiencuong🔥 k&iacute;nh ch&agrave;o qu&yacute; kh&aacute;ch</p>

<p>&nbsp;</p>

<p>𝘾𝘼𝙈 𝙆𝙀̂́𝙏 𝙑𝙊̛́𝙄 𝙆𝙃𝘼́𝘾𝙃 𝙃𝘼̀𝙉𝙂 VỀ SẢN PHẨM</p>

<p>- Sản phẩm 100% giống với m&ocirc; tả.</p>

<p>- Giao h&agrave;ng đ&uacute;ng size, lỗi 1 đổi 1.</p>

<p>- Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc theo h&igrave;nh thức COD, v&iacute; Airpay, internet banking,...</p>

<p>&nbsp;</p>

<p>❌𝙇𝙪̛𝙪 𝙮́ 𝙆𝙝𝙞 𝙠𝙝𝙖́𝙘𝙝 𝙣𝙝𝙖̣̂𝙣 𝙝𝙖̀𝙣𝙜:</p>

<p>✅Bao kiểm tra h&agrave;ng trước thanh to&aacute;n (Gọi cho shop theo hotline nếu bưu t&aacute; kh&ocirc;ng cho kiểm)</p>

<p>✅Hỗ trợ đổi size nếu kh&aacute;ch đặt nhầm size gi&agrave;y, lỗi nh&agrave; sản xuất</p>

<p>✅ Tất cả c&aacute;c sản phẩm đ&atilde; được chọn lựa kỹ trước khi cung cấp cho kh&aacute;ch h&agrave;ng</p>

<p>✅ Sản phẩm bao gồm đầy đủ : hộp, tag, giấy g&oacute;i v&agrave; phụ kiện.</p>
', 1, 1, CAST(N'2023-11-21T16:04:32.623' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (15, N'Nike 05', 2, 2, 7, 2000000, N'<p>Với 3 loại mcqueen: g&oacute;t đen trắng, phản quang v&agrave; g&oacute;t hoa c&uacute;c.</p>

<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong ch&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2020 nay, h&agrave;ng da, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ. Gồm MCqueen g&oacute;t đen trắng, phản quang v&agrave; mcq hoa c&uacute;c</p>

<p>-Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy mc bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao MCQueen nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-11-21T16:04:44.423' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (16, N'Nike 06', 4, 2, 7, 7680000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : No Brand</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>K&iacute;ch Thước : Size Nam: 39 - 40 - 41 - 42 - 43</p>

<p>M&agrave;u Sắc : Đen trắng, Đen Full</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 0, 1, CAST(N'2023-11-17T10:46:24.683' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (17, N'Nike 07', 2, 2, 7, 567000, N'<p>🐾 Size: 36 - 44</p>

<p>⚡️ Tất cả sản phẩm của Shop đều cam kết Full Box, đ&oacute;ng g&oacute;i cẩn thận nhằm mang lại cho kh&aacute;ch h&agrave;ng trải nghiệm mua sắm online an t&acirc;m nhất! (Ngoại trừ c&aacute;c đợt sale gi&aacute; sỉ th&igrave; Shop kh&ocirc;ng thể hỗ trợ th&ecirc;m box đc) 👌 Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✨ Lưu &yacute; : H&agrave;ng xưởng về nhiều đợt do shop đặt số lượng lớn ,n&ecirc;n mỗi đợt lưới, logo v&agrave; đế c&oacute; kh&aacute;c nhau. C&aacute;c bạn nhớ xem b&agrave;i viết của shop v&agrave; c&acirc;n nhắc trước khi đặt nh&eacute;.</p>

<p>❗️❗️❗️ Ảnh Shop to&agrave;n bộ đều l&agrave; ảnh thật độc quyền tự chụp, c&aacute;c bạn k&eacute;o qua để xem video v&agrave; c&aacute;c g&oacute;c kh&aacute;c nh&eacute;</p>
', 0, 1, CAST(N'2023-11-17T10:35:09.817' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (18, N'Nike 08', 5, 2, 7, 876000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa. ✔️ Chat với shop để được tư vấn nếu cần nh&eacute;.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 0, 1, CAST(N'2023-11-17T10:50:03.190' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (19, N'Nike 09', 2, 2, 7, 567000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: trắng</p>

<p>+ Size: từ 36 đến 43 (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

<p>+ Chiều cao: đế cao 2,5 cm</p>

<p>+ Trọng lượng Gi&agrave;y : 800g</p>

<p>&nbsp;</p>

<p>- Gợi &yacute; c&aacute;c dịp ph&ugrave; hợp để sử dụng:</p>

<p>+ Mọi hoạt động h&agrave;ng ng&agrave;y (đi chơi, đi học, thể dục thể thao,...)</p>

<p>+ Phối với c&aacute;c trang phục năng động hoặc đồ &acirc;u đều dễ d&agrave;ng v&agrave; t&ocirc;n d&aacute;ng</p>

<p>&nbsp;</p>

<p>- CHẾ ĐỘ BẢO H&Agrave;NH V&Agrave; ĐỔI TRẢ</p>

<p>Chế độ bảo h&agrave;nh: Gi&agrave;y b&ecirc;n shop được bảo h&agrave;nh 3 th&aacute;ng cho trường hợp bong da v&agrave; sứt chỉ.</p>

<p>Chế độ đổi trả:</p>

<p>+ Nếu gi&agrave;y lỗi b&ecirc;n shop sẽ hỗ trợ đổi, trả miễn ph&iacute; 100%</p>

<p>+ Trường hợp mua gi&agrave;y về m&agrave; size qu&aacute; rộng hoặc qu&aacute; chật, li&ecirc;n hệ lại shop trong v&ograve;ng 7 ng&agrave;y (kể từ ng&agrave;y nhận sản phẩm) để nhận đổi trả</p>

<p>&nbsp;</p>

<p>Cảm ơn c&aacute;c bạn đ&atilde; quan t&acirc;m đến sản phẩm của shop. Đừng qu&ecirc;n đ&aacute;nh gi&aacute; 5 sao khi nhận được h&agrave;ng nh&eacute;!!</p>

<p>* Mọi chi tiết v&agrave; thắc mắc xin li&ecirc;n hệ lại shop để được giải đ&aacute;p tận t&igrave;nh.</p>
', 0, 0, CAST(N'2023-11-17T10:33:44.147' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (20, N'Nike 10', 2, 2, 7, 987000, N'<p>SHOP SUS LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; JD size 39-44</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM CỔ CAO JD</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp ) ✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam JD b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đen trắng v&agrave; x&aacute;m xanh trắng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam JD c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM ✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 0, 1, CAST(N'2023-11-17T10:44:12.810' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (21, N'Puma 01', 4, 3, 7, 867000, N'<p>SHOP SUS LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; JD size 39-44</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM CỔ CAO JD</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp ) ✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam JD b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đen trắng v&agrave; x&aacute;m xanh trắng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam JD c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM ✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 1, 1, CAST(N'2023-11-21T16:04:57.337' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (22, N'Puma 02', 3, 3, 7, 967000, N'<p>SHOP SUS LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; JD size 39-44</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM CỔ CAO JD</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp ) ✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam JD b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đen trắng v&agrave; x&aacute;m xanh trắng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam JD c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM ✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 1, 1, CAST(N'2023-11-21T16:05:04.157' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (23, N'Puma 03', 3, 3, 7, 934000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa. ✔️ Chat với shop để được tư vấn nếu cần nh&eacute;.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 0, CAST(N'2023-11-21T16:05:13.233' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (24, N'Puma 04', 3, 3, 7, 912000, N'<p>Gi&agrave;y Van Nam nữ Đen Đủ Size Từ 35-43 ▪️Xuất xứ: Việt Nam</p>

<p>▪️Thương hiệu: Van ▪️Chất liệu: Vải Canvas</p>

<p>▪️Đế: Cao su lưu h&oacute;a Dải size : 35. 36. 37. 38. 39, 40, 41, 42, 43</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM ✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc 🎁 G&Oacute;C MUA H&Agrave;NG ✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 1, 1, CAST(N'2023-11-21T16:05:31.197' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (25, N'Puma 05', 3, 3, 7, 856000, N'<p>Với 3 loại mcqueen: g&oacute;t đen trắng, phản quang v&agrave; g&oacute;t hoa c&uacute;c.</p>

<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong ch&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2020 nay, h&agrave;ng da, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ. Gồm MCqueen g&oacute;t đen trắng, phản quang v&agrave; mcq hoa c&uacute;c</p>

<p>-Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy mc bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao MCQueen nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-11-21T16:05:42.233' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (26, N'Puma 06', 2, 3, 7, 712000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p> Size của nữ từ 36 ~39, size nam 39~43 (c&oacute; m&agrave;u ghi hồng kh&ocirc;ng c&oacute; size của nam c&ograve;n c&aacute;c m&agrave;u c&ograve;n lại đều c&oacute; đủ hai m&agrave;u nam, nữ)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 0, 1, CAST(N'2023-11-17T10:39:10.010' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (27, N'Puma 07', 3, 3, 7, 536000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: trắng</p>

<p>+ Size: từ 36 đến 43 (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

<p>+ Chiều cao: đế cao 2,5 cm</p>

<p>+ Trọng lượng Gi&agrave;y : 800g</p>

<p>&nbsp;</p>

<p>- Gợi &yacute; c&aacute;c dịp ph&ugrave; hợp để sử dụng:</p>

<p>+ Mọi hoạt động h&agrave;ng ng&agrave;y (đi chơi, đi học, thể dục thể thao,...)</p>

<p>+ Phối với c&aacute;c trang phục năng động hoặc đồ &acirc;u đều dễ d&agrave;ng v&agrave; t&ocirc;n d&aacute;ng</p>

<p>&nbsp;</p>

<p>- CHẾ ĐỘ BẢO H&Agrave;NH V&Agrave; ĐỔI TRẢ</p>

<p>Chế độ bảo h&agrave;nh: Gi&agrave;y b&ecirc;n shop được bảo h&agrave;nh 3 th&aacute;ng cho trường hợp bong da v&agrave; sứt chỉ.</p>

<p>Chế độ đổi trả:</p>

<p>+ Nếu gi&agrave;y lỗi b&ecirc;n shop sẽ hỗ trợ đổi, trả miễn ph&iacute; 100%</p>

<p>+ Trường hợp mua gi&agrave;y về m&agrave; size qu&aacute; rộng hoặc qu&aacute; chật, li&ecirc;n hệ lại shop trong v&ograve;ng 7 ng&agrave;y (kể từ ng&agrave;y nhận sản phẩm) để nhận đổi trả</p>

<p>&nbsp;</p>

<p>Cảm ơn c&aacute;c bạn đ&atilde; quan t&acirc;m đến sản phẩm của shop. Đừng qu&ecirc;n đ&aacute;nh gi&aacute; 5 sao khi nhận được h&agrave;ng nh&eacute;!!</p>

<p>* Mọi chi tiết v&agrave; thắc mắc xin li&ecirc;n hệ lại shop để được giải đ&aacute;p tận t&igrave;nh.</p>
', 0, 1, CAST(N'2023-11-17T10:34:17.397' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (28, N'Puma 08', 1, 3, 7, 933000, N'<p>Gi&agrave;y Van Nam nữ Đen Đủ Size Từ 35-43 ▪️Xuất xứ: Việt Nam</p>

<p>▪️Thương hiệu: Van ▪️Chất liệu: Vải Canvas</p>

<p>▪️Đế: Cao su lưu h&oacute;a Dải size : 35. 36. 37. 38. 39, 40, 41, 42, 43</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM ✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc 🎁 G&Oacute;C MUA H&Agrave;NG ✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 0, 1, CAST(N'2023-11-17T10:51:22.503' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (29, N'Puma 09', 3, 3, 7, 655000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: trắng</p>

<p>+ Size: từ 36 đến 43 (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

<p>+ Chiều cao: đế cao 2,5 cm</p>

<p>+ Trọng lượng Gi&agrave;y : 800g</p>

<p>&nbsp;</p>

<p>- Gợi &yacute; c&aacute;c dịp ph&ugrave; hợp để sử dụng:</p>

<p>+ Mọi hoạt động h&agrave;ng ng&agrave;y (đi chơi, đi học, thể dục thể thao,...)</p>

<p>+ Phối với c&aacute;c trang phục năng động hoặc đồ &acirc;u đều dễ d&agrave;ng v&agrave; t&ocirc;n d&aacute;ng</p>

<p>&nbsp;</p>

<p>- CHẾ ĐỘ BẢO H&Agrave;NH V&Agrave; ĐỔI TRẢ</p>

<p>Chế độ bảo h&agrave;nh: Gi&agrave;y b&ecirc;n shop được bảo h&agrave;nh 3 th&aacute;ng cho trường hợp bong da v&agrave; sứt chỉ.</p>

<p>Chế độ đổi trả:</p>

<p>+ Nếu gi&agrave;y lỗi b&ecirc;n shop sẽ hỗ trợ đổi, trả miễn ph&iacute; 100%</p>

<p>+ Trường hợp mua gi&agrave;y về m&agrave; size qu&aacute; rộng hoặc qu&aacute; chật, li&ecirc;n hệ lại shop trong v&ograve;ng 7 ng&agrave;y (kể từ ng&agrave;y nhận sản phẩm) để nhận đổi trả</p>

<p>&nbsp;</p>

<p>Cảm ơn c&aacute;c bạn đ&atilde; quan t&acirc;m đến sản phẩm của shop. Đừng qu&ecirc;n đ&aacute;nh gi&aacute; 5 sao khi nhận được h&agrave;ng nh&eacute;!!</p>

<p>* Mọi chi tiết v&agrave; thắc mắc xin li&ecirc;n hệ lại shop để được giải đ&aacute;p tận t&igrave;nh.</p>
', 0, 0, CAST(N'2023-11-17T10:33:51.577' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (30, N'Puma 10', 3, 3, 7, 966000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Mi Bantang, Quận Taijiang Địa chỉ: Mặt tiền cửa h&agrave;ng 17, Tầng 1, T&ograve;a nh&agrave; 1 #, T&ograve;a nh&agrave; Thương mại Liwei, Số 488, Đường Liuyi Middle, Phố Yingzhou, Quận Taijiang, Ph&uacute;c Ch&acirc;u, Ph&uacute;c Kiến, Trung Quốc</p>

<p>- Gi&agrave;y nam thời trang cao cổ g&oacute;t kẻ m&agrave;u c&aacute; t&iacute;nh hot trend 2020</p>

<p>- Với thiết kế phong c&aacute;ch đơn giản , đ&ocirc;i gi&agrave;y thể thao nam c&oacute; những điểm nhấn cực k&igrave; bắt mắt v&agrave; nổi bật khiến người đi nổi bật giữa đ&aacute;m đ&ocirc;ng .</p>

<p>- Chất liệu đế đ&ocirc;i gi&agrave;y nam được l&agrave;m từ cao su tổng hợp gi&uacute;p cho bạn đi cả ng&agrave;y m&agrave; vẫn cảm gi&aacute;c rất &ecirc;m &aacute;i .</p>

<p>- Với kiểu d&aacute;ng trẻ trung hiện đại , chủ nh&acirc;n của đ&ocirc;i gi&agrave;y nam c&oacute; thể phối với bất k&igrave; bộ đồ n&agrave;o trong tủ đồ , để đi chơi dạo phố , đi dự tiệc , đi du lịch picnic .</p>

<p>- Size gi&agrave;y từ 39 đến 43 cho tất cả c&aacute;c anh em lựa chọn Tất cả c&aacute;c sản phẩm gi&agrave;y b&ecirc;n shop đều c&oacute; l&oacute;t gi&agrave;y tho&aacute;ng kh&iacute; chống h&ocirc;i ch&acirc;n Shop xin CAM KẾT 100% ảnh Gi&agrave;y do Shop tự chụp v&agrave; đ&iacute;nh Logo.</p>

<p>✔️ H&agrave;ng chuẩn 100% VNXK v&agrave; QCCC - Cam kết đổi trả nếu lỗi từ nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi trả size nếu kh&ocirc;ng vừa</p>

<p>✔️ Kiểu d&aacute;ng &ocirc;m ch&acirc;n, thon gọn, thoải m&aacute;i di chuyển m&agrave; kh&ocirc;ng lo đau ch&acirc;n</p>

<p>✔️ Giao h&agrave;ng tại nh&agrave;, Thanh to&aacute;n tại nh&agrave;, nhanh ch&oacute;ng, tiện dụng CHAT TRỰC TIẾP VỚI NH&Acirc;N VI&Ecirc;N</p>

<p>✔️ Gửi kh&aacute;ch xem mẫu gi&agrave;y hiện c&oacute;</p>

<p>✔️ Tư vấn c&aacute;c mẫu gi&agrave;y ph&ugrave; hợp với kh&aacute;ch h&agrave;ng Ch&uacute;ng t&ocirc;i mong muốn bạn hạnh ph&uacute;c khi mua h&agrave;ng!</p>

<p>-----------------------------------------------------</p>
', 0, 1, CAST(N'2023-11-17T10:37:12.557' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (31, N'Reebok 01', 4, 4, 7, 908000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Mi Bantang, Quận Taijiang Địa chỉ: Mặt tiền cửa h&agrave;ng 17, Tầng 1, T&ograve;a nh&agrave; 1 #, T&ograve;a nh&agrave; Thương mại Liwei, Số 488, Đường Liuyi Middle, Phố Yingzhou, Quận Taijiang, Ph&uacute;c Ch&acirc;u, Ph&uacute;c Kiến, Trung Quốc</p>

<p>- Gi&agrave;y nam thời trang cao cổ g&oacute;t kẻ m&agrave;u c&aacute; t&iacute;nh hot trend 2020</p>

<p>- Với thiết kế phong c&aacute;ch đơn giản , đ&ocirc;i gi&agrave;y thể thao nam c&oacute; những điểm nhấn cực k&igrave; bắt mắt v&agrave; nổi bật khiến người đi nổi bật giữa đ&aacute;m đ&ocirc;ng .</p>

<p>- Chất liệu đế đ&ocirc;i gi&agrave;y nam được l&agrave;m từ cao su tổng hợp gi&uacute;p cho bạn đi cả ng&agrave;y m&agrave; vẫn cảm gi&aacute;c rất &ecirc;m &aacute;i .</p>

<p>- Với kiểu d&aacute;ng trẻ trung hiện đại , chủ nh&acirc;n của đ&ocirc;i gi&agrave;y nam c&oacute; thể phối với bất k&igrave; bộ đồ n&agrave;o trong tủ đồ , để đi chơi dạo phố , đi dự tiệc , đi du lịch picnic .</p>

<p>- Size gi&agrave;y từ 39 đến 43 cho tất cả c&aacute;c anh em lựa chọn Tất cả c&aacute;c sản phẩm gi&agrave;y b&ecirc;n shop đều c&oacute; l&oacute;t gi&agrave;y tho&aacute;ng kh&iacute; chống h&ocirc;i ch&acirc;n Shop xin CAM KẾT 100% ảnh Gi&agrave;y do Shop tự chụp v&agrave; đ&iacute;nh Logo.</p>

<p>✔️ H&agrave;ng chuẩn 100% VNXK v&agrave; QCCC - Cam kết đổi trả nếu lỗi từ nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi trả size nếu kh&ocirc;ng vừa</p>

<p>✔️ Kiểu d&aacute;ng &ocirc;m ch&acirc;n, thon gọn, thoải m&aacute;i di chuyển m&agrave; kh&ocirc;ng lo đau ch&acirc;n</p>

<p>✔️ Giao h&agrave;ng tại nh&agrave;, Thanh to&aacute;n tại nh&agrave;, nhanh ch&oacute;ng, tiện dụng CHAT TRỰC TIẾP VỚI NH&Acirc;N VI&Ecirc;N</p>

<p>✔️ Gửi kh&aacute;ch xem mẫu gi&agrave;y hiện c&oacute;</p>

<p>✔️ Tư vấn c&aacute;c mẫu gi&agrave;y ph&ugrave; hợp với kh&aacute;ch h&agrave;ng Ch&uacute;ng t&ocirc;i mong muốn bạn hạnh ph&uacute;c khi mua h&agrave;ng!</p>

<p>-----------------------------------------------------</p>
', 1, 1, CAST(N'2023-11-21T16:02:44.587' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (32, N'Reebok 02', 2, 4, 7, 987000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p> Size của nữ từ 36 ~39, size nam 39~43 (c&oacute; m&agrave;u ghi hồng kh&ocirc;ng c&oacute; size của nam c&ograve;n c&aacute;c m&agrave;u c&ograve;n lại đều c&oacute; đủ hai m&agrave;u nam, nữ)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 1, 1, CAST(N'2023-11-21T16:02:58.067' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (33, N'Reebok 03', 4, 4, 7, 6785430, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa. ✔️ Chat với shop để được tư vấn nếu cần nh&eacute;.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 0, CAST(N'2023-11-21T16:03:06.613' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (34, N'Reebok 04', 4, 4, 7, 789500, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa. ✔️ Chat với shop để được tư vấn nếu cần nh&eacute;.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 1, CAST(N'2023-11-21T16:03:36.227' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (35, N'Reebok 05', 1, 4, 7, 876000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : No Brand</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>K&iacute;ch Thước : Size Nam: 39 - 40 - 41 - 42 - 43</p>

<p>M&agrave;u Sắc : Đen trắng, Đen Full</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 1, 1, CAST(N'2023-11-21T16:03:45.923' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (36, N'Reebok 06', 4, 4, 7, 654000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : No Brand</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>K&iacute;ch Thước : Size Nam: 39 - 40 - 41 - 42 - 43</p>

<p>M&agrave;u Sắc : Đen trắng, Đen Full</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 0, 1, CAST(N'2023-11-17T10:46:09.470' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (37, N'Reebok 07', 3, 4, 7, 567000, N'<p>🐾 Size: 36 - 44</p>

<p>⚡️ Tất cả sản phẩm của Shop đều cam kết Full Box, đ&oacute;ng g&oacute;i cẩn thận nhằm mang lại cho kh&aacute;ch h&agrave;ng trải nghiệm mua sắm online an t&acirc;m nhất! (Ngoại trừ c&aacute;c đợt sale gi&aacute; sỉ th&igrave; Shop kh&ocirc;ng thể hỗ trợ th&ecirc;m box đc) 👌 Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✨ Lưu &yacute; : H&agrave;ng xưởng về nhiều đợt do shop đặt số lượng lớn ,n&ecirc;n mỗi đợt lưới, logo v&agrave; đế c&oacute; kh&aacute;c nhau. C&aacute;c bạn nhớ xem b&agrave;i viết của shop v&agrave; c&acirc;n nhắc trước khi đặt nh&eacute;.</p>

<p>❗️❗️❗️ Ảnh Shop to&agrave;n bộ đều l&agrave; ảnh thật độc quyền tự chụp, c&aacute;c bạn k&eacute;o qua để xem video v&agrave; c&aacute;c g&oacute;c kh&aacute;c nh&eacute;</p>
', 0, 1, CAST(N'2023-11-17T10:35:23.937' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (38, N'Reebok 08', 4, 4, 7, 678900, N'<p>Gi&agrave;y Van Nam nữ Đen Đủ Size Từ 35-43 ▪️Xuất xứ: Việt Nam</p>

<p>▪️Thương hiệu: Van ▪️Chất liệu: Vải Canvas</p>

<p>▪️Đế: Cao su lưu h&oacute;a Dải size : 35. 36. 37. 38. 39, 40, 41, 42, 43</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM ✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc 🎁 G&Oacute;C MUA H&Agrave;NG</p>

<p>✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 0, 1, CAST(N'2023-11-17T10:52:01.530' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (39, N'Reebok 09', 4, 4, 7, 666000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: trắng</p>

<p>+ Size: từ 36 đến 43 (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

<p>+ Chiều cao: đế cao 2,5 cm</p>

<p>+ Trọng lượng Gi&agrave;y : 800g</p>

<p>&nbsp;</p>

<p>- Gợi &yacute; c&aacute;c dịp ph&ugrave; hợp để sử dụng:</p>

<p>+ Mọi hoạt động h&agrave;ng ng&agrave;y (đi chơi, đi học, thể dục thể thao,...)</p>

<p>+ Phối với c&aacute;c trang phục năng động hoặc đồ &acirc;u đều dễ d&agrave;ng v&agrave; t&ocirc;n d&aacute;ng</p>

<p>&nbsp;</p>

<p>- CHẾ ĐỘ BẢO H&Agrave;NH V&Agrave; ĐỔI TRẢ</p>

<p>Chế độ bảo h&agrave;nh: Gi&agrave;y b&ecirc;n shop được bảo h&agrave;nh 3 th&aacute;ng cho trường hợp bong da v&agrave; sứt chỉ.</p>

<p>Chế độ đổi trả:</p>

<p>+ Nếu gi&agrave;y lỗi b&ecirc;n shop sẽ hỗ trợ đổi, trả miễn ph&iacute; 100%</p>

<p>+ Trường hợp mua gi&agrave;y về m&agrave; size qu&aacute; rộng hoặc qu&aacute; chật, li&ecirc;n hệ lại shop trong v&ograve;ng 7 ng&agrave;y (kể từ ng&agrave;y nhận sản phẩm) để nhận đổi trả</p>

<p>&nbsp;</p>

<p>Cảm ơn c&aacute;c bạn đ&atilde; quan t&acirc;m đến sản phẩm của shop. Đừng qu&ecirc;n đ&aacute;nh gi&aacute; 5 sao khi nhận được h&agrave;ng nh&eacute;!!</p>

<p>* Mọi chi tiết v&agrave; thắc mắc xin li&ecirc;n hệ lại shop để được giải đ&aacute;p tận t&igrave;nh.</p>
', 0, 0, CAST(N'2023-11-17T10:34:07.723' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (40, N'Reebok 10', 3, 4, 7, 999000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p> Size của nữ từ 36 ~39, size nam 39~43 (c&oacute; m&agrave;u ghi hồng kh&ocirc;ng c&oacute; size của nam c&ograve;n c&aacute;c m&agrave;u c&ograve;n lại đều c&oacute; đủ hai m&agrave;u nam, nữ)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 0, 1, CAST(N'2023-11-17T10:39:16.957' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (41, N'New Balance 01', 5, 5, 7, 222000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : No Brand</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>K&iacute;ch Thước : Size Nam: 39 - 40 - 41 - 42 - 43</p>

<p>M&agrave;u Sắc : Đen trắng, Đen Full</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 1, 1, CAST(N'2023-11-23T16:52:47.387' AS DateTime), 1)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (42, N'New Balance 02', 5, 5, 7, 666000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p> Size của nữ từ 36 ~39, size nam 39~43 (c&oacute; m&agrave;u ghi hồng kh&ocirc;ng c&oacute; size của nam c&ograve;n c&aacute;c m&agrave;u c&ograve;n lại đều c&oacute; đủ hai m&agrave;u nam, nữ)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 1, 1, CAST(N'2023-11-21T16:06:33.237' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (43, N'New Balance 03', 2, 5, 7, 999000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa. ✔️ Chat với shop để được tư vấn nếu cần nh&eacute;.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 0, CAST(N'2023-11-21T16:06:41.287' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (44, N'New Balance 04', 3, 5, 7, 777000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p> Size của nữ từ 36 ~39, size nam 39~43 (c&oacute; m&agrave;u ghi hồng kh&ocirc;ng c&oacute; size của nam c&ograve;n c&aacute;c m&agrave;u c&ograve;n lại đều c&oacute; đủ hai m&agrave;u nam, nữ)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 1, 1, CAST(N'2023-11-21T16:06:53.417' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (45, N'New Balance 05', 3, 5, 7, 879000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa. ✔️ Chat với shop để được tư vấn nếu cần nh&eacute;.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 1, CAST(N'2023-11-23T16:39:54.593' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (46, N'New Balance 06', 1, 5, 7, 567000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : No Brand</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>K&iacute;ch Thước : Size Nam: 39 - 40 - 41 - 42 - 43</p>

<p>M&agrave;u Sắc : Đen trắng, Đen Full</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 0, 1, CAST(N'2023-11-17T10:45:45.200' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (47, N'New Balance 07', 5, 5, 3, 8979000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 0, 1, CAST(N'2023-11-23T16:44:56.813' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (48, N'New Balance 08', 5, 5, 7, 8789000, N'<p>Gi&agrave;y Van Nam nữ Đen Đủ Size Từ 35-43 ▪️Xuất xứ: Việt Nam</p>

<p>▪️Thương hiệu: Van ▪️Chất liệu: Vải Canvas</p>

<p>▪️Đế: Cao su lưu h&oacute;a Dải size : 35. 36. 37. 38. 39, 40, 41, 42, 43</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM ✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc 🎁 G&Oacute;C MUA H&Agrave;NG ✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 0, 1, CAST(N'2023-11-17T10:51:36.047' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (49, N'New Balance 09', 1, 5, 7, 6543000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: trắng</p>

<p>+ Size: từ 36 đến 43 (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

<p>+ Chiều cao: đế cao 2,5 cm</p>

<p>+ Trọng lượng Gi&agrave;y : 800g</p>

<p>&nbsp;</p>

<p>- Gợi &yacute; c&aacute;c dịp ph&ugrave; hợp để sử dụng:</p>

<p>+ Mọi hoạt động h&agrave;ng ng&agrave;y (đi chơi, đi học, thể dục thể thao,...)</p>

<p>+ Phối với c&aacute;c trang phục năng động hoặc đồ &acirc;u đều dễ d&agrave;ng v&agrave; t&ocirc;n d&aacute;ng</p>

<p>&nbsp;</p>

<p>- CHẾ ĐỘ BẢO H&Agrave;NH V&Agrave; ĐỔI TRẢ</p>

<p>Chế độ bảo h&agrave;nh: Gi&agrave;y b&ecirc;n shop được bảo h&agrave;nh 3 th&aacute;ng cho trường hợp bong da v&agrave; sứt chỉ.</p>

<p>Chế độ đổi trả:</p>

<p>+ Nếu gi&agrave;y lỗi b&ecirc;n shop sẽ hỗ trợ đổi, trả miễn ph&iacute; 100%</p>

<p>+ Trường hợp mua gi&agrave;y về m&agrave; size qu&aacute; rộng hoặc qu&aacute; chật, li&ecirc;n hệ lại shop trong v&ograve;ng 7 ng&agrave;y (kể từ ng&agrave;y nhận sản phẩm) để nhận đổi trả</p>

<p>&nbsp;</p>

<p>Cảm ơn c&aacute;c bạn đ&atilde; quan t&acirc;m đến sản phẩm của shop. Đừng qu&ecirc;n đ&aacute;nh gi&aacute; 5 sao khi nhận được h&agrave;ng nh&eacute;!!</p>

<p>* Mọi chi tiết v&agrave; thắc mắc xin li&ecirc;n hệ lại shop để được giải đ&aacute;p tận t&igrave;nh.</p>
', 0, 0, CAST(N'2023-11-17T10:33:58.647' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (50, N'New Balance 10', 5, 5, 3, 2098908, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2023-10-13T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[product] OFF
GO
SET IDENTITY_INSERT [dbo].[product_detail] ON 

INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (1, 1, 3, 1, 55, 1, CAST(N'2023-11-24T11:26:35.470' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (2, 2, 1, 2, 23, 0, CAST(N'2022-02-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (3, 3, 1, 3, 50, 0, CAST(N'2023-06-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (4, 4, 1, 4, 50, 0, CAST(N'2020-08-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (5, 5, 1, 5, 50, 0, CAST(N'2019-09-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (6, 6, 2, 1, 47, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (7, 7, 2, 2, 50, 0, CAST(N'2020-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (8, 8, 2, 3, 20, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (9, 9, 2, 4, 50, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (10, 10, 2, 5, 50, 0, CAST(N'2023-11-24T11:25:25.537' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (12, 1, 2, 2, 50, 0, CAST(N'2023-10-25T19:26:08.207' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (13, 1, 2, 5, 51, 0, CAST(N'2023-10-28T20:41:13.377' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (14, 11, 1, 1, 50, 0, CAST(N'2023-11-21T16:09:06.893' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (15, 11, 2, 3, 50, 0, CAST(N'2023-11-21T16:09:16.377' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (16, 12, 12, 5, 50, 0, CAST(N'2023-11-21T16:09:32.187' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (17, 12, 2, 3, 50, 0, CAST(N'2023-11-21T16:09:44.743' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (18, 13, 4, 2, 50, 0, CAST(N'2023-11-21T16:09:53.243' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (19, 13, 6, 7, 50, 0, CAST(N'2023-11-21T16:10:03.560' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (20, 14, 6, 3, 50, 0, CAST(N'2023-11-21T16:10:14.520' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (21, 14, 4, 6, 50, 0, CAST(N'2023-11-21T16:10:26.037' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (22, 15, 4, 3, 50, 0, CAST(N'2023-11-21T16:10:43.710' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (23, 15, 4, 6, 50, 0, CAST(N'2023-11-21T16:10:55.577' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (24, 21, 4, 3, 50, 0, CAST(N'2023-11-21T16:11:05.667' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (25, 21, 4, 1, 50, 0, CAST(N'2023-11-21T16:11:16.533' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (26, 22, 3, 3, 50, 0, CAST(N'2023-11-21T16:11:38.500' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (27, 22, 9, 6, 50, 0, CAST(N'2023-11-21T16:11:51.333' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (28, 23, 2, 2, 50, 0, CAST(N'2023-11-21T16:12:10.410' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (29, 23, 5, 3, 50, 0, CAST(N'2023-11-21T16:13:06.857' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (30, 24, 5, 3, 50, 0, CAST(N'2023-11-21T16:14:53.847' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (31, 25, 3, 5, 50, 0, CAST(N'2023-11-21T16:15:04.787' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (32, 25, 1, 3, 50, 0, CAST(N'2023-11-21T16:15:15.157' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (33, 31, 2, 2, 50, 0, CAST(N'2023-11-21T16:15:31.160' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (34, 31, 3, 7, 50, 0, CAST(N'2023-11-21T16:15:40.967' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (35, 32, 5, 8, 50, 0, CAST(N'2023-11-21T16:16:16.050' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (36, 32, 3, 8, 50, 0, CAST(N'2023-11-21T16:16:27.560' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (37, 33, 3, 7, 50, 0, CAST(N'2023-11-21T16:16:43.187' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (38, 33, 5, 8, 50, 0, CAST(N'2023-11-21T16:16:58.700' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (39, 34, 4, 1, 50, 0, CAST(N'2023-11-21T16:17:15.917' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (40, 34, 3, 3, 50, 0, CAST(N'2023-11-21T16:17:28.477' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (41, 35, 3, 6, 60, 0, CAST(N'2023-11-21T16:17:40.760' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (42, 41, 2, 3, 60, 0, CAST(N'2023-11-21T16:17:50.927' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (43, 42, 4, 3, 50, 0, CAST(N'2023-11-21T16:18:00.620' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (44, 43, 6, 3, 2, 0, CAST(N'2023-11-21T16:18:10.980' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (45, 44, 2, 5, 0, 0, CAST(N'2023-11-21T16:18:20.697' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (46, 45, 6, 5, 1, 0, CAST(N'2023-11-21T16:18:31.767' AS DateTime))
SET IDENTITY_INSERT [dbo].[product_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[product_image] ON 

INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (1, 1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh1-1.png?alt=media&token=2c46603e-506b-478a-abd0-85679d41e2a2', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (2, 3, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh3-1.png?alt=media&token=c6e93e2d-30b7-407e-9a82-2e81d02da103', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (3, 2, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh2-1.png?alt=media&token=2a087997-2507-45a4-a0e1-73dca3116159', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (4, 4, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh4-1.jpg?alt=media&token=849fd34f-2c42-4b6d-ad24-8797fa8c5e39', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (5, 5, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh5-1.png?alt=media&token=041b16af-0abd-44f5-9df9-12fe851525f6', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (6, 6, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh6-1.png?alt=media&token=6cf47f9a-477f-45e2-a979-f2c623b55f0b', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (7, 7, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh6-2.jpg?alt=media&token=eb13975c-974e-476d-a613-d4fff494480f', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (8, 8, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh7-1.png?alt=media&token=0b96e873-f501-40c4-ba65-4d1c54c7ae9c', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (9, 9, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh8-1.png?alt=media&token=2dfa3dfa-7f9d-4ce1-8814-6ce94cee51ca', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (10, 10, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh10-1.png?alt=media&token=72d1eabc-dd33-474c-8226-4d6663029eae', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (14, 2, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh2-2.jpg?alt=media&token=9e7395a3-92f2-4670-96e5-3ee371535b52', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (15, 3, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh3-3.jpg?alt=media&token=1a121904-ee07-47d1-8df5-100afdccc0a9', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (16, 4, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh4-3.jpg?alt=media&token=508a9ec7-dd22-4360-baa1-9bf846da926b', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (17, 5, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh5-2.jpg?alt=media&token=72edb7bd-55a7-4748-96c9-0d0eec2708e1', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (18, 7, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh6-3.jpg?alt=media&token=39f974af-1bdb-4a0b-8c20-fed588efecd1', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (19, 8, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh7-2.jpg?alt=media&token=91a290d4-8bb6-4781-ab8c-b6a163f4afed', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (20, 9, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh8-2.jpg?alt=media&token=aa784230-2081-4a9d-9fab-02377a433e21', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (21, 10, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh10-3.jpg?alt=media&token=78d65153-4ac4-499e-8acd-fce19b2a6d4e', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (22, 1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh1-3.jpg?alt=media&token=6b455e7b-4ca9-4d90-84a6-44ce02fa97a0', CAST(N'2023-10-19T15:55:13.237' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (23, 1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh7-3.jpg?alt=media&token=6a91e021-3e84-4b8a-a6fd-72655f3b449e', CAST(N'2023-10-17T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (24, 1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh1-2.jpg?alt=media&token=fba21661-4b6b-4644-b6eb-ecbc9b2d28e6', CAST(N'2023-10-17T00:00:00.000' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (25, 11, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike01-1.jpg?alt=media&token=4d0f3c69-5dbc-4260-86d4-68ce36e579fe', CAST(N'2023-11-21T15:48:23.553' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (26, 11, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike01-2.jpg?alt=media&token=52a742cd-d34e-4bae-a5a5-be0f19790346', CAST(N'2023-11-21T15:48:41.550' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (27, 12, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike02-1.jpg?alt=media&token=41ff8d6f-1c15-4f8b-978f-5522852b0f87', CAST(N'2023-11-21T15:48:50.023' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (28, 12, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike02-2.jpg?alt=media&token=89fd6d99-9fd8-414b-a4b3-c0a72177807c', CAST(N'2023-11-21T15:48:57.393' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (29, 13, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike03-1.jpg?alt=media&token=1a5e2e83-bbf1-47b5-9f27-7d7ecb7a3e66', CAST(N'2023-11-21T15:49:14.937' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (30, 13, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike03-2.jpg?alt=media&token=58c8a3a7-d99e-4f4a-b3c7-35b47788a046', CAST(N'2023-11-21T15:49:24.560' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (31, 14, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike04-1.jpg?alt=media&token=2bee973f-43e2-49a1-a3dc-1fc5890a0575', CAST(N'2023-11-21T15:49:33.757' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (32, 14, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike04-2.jpg?alt=media&token=822d5d82-a8f3-4cae-9e94-b6a9bdfcecd1', CAST(N'2023-11-21T15:49:40.857' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (33, 15, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike05-1.jpg?alt=media&token=8f3f918d-36d2-444d-9971-75b0a5ea7b59', CAST(N'2023-11-21T15:50:01.037' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (34, 15, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike05-2.jpg?alt=media&token=fa085e0e-ea6a-4306-bac7-ce084ac9fed8', CAST(N'2023-11-21T15:50:09.093' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (35, 21, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma01-1.webp?alt=media&token=6809fa31-6597-4272-9c5c-08713e008fb3', CAST(N'2023-11-21T15:50:22.773' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (36, 21, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma01-2.webp?alt=media&token=6c82f56d-46ed-4f05-810b-44f9dfeeb3cd', CAST(N'2023-11-21T15:50:31.113' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (37, 22, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma02-1.webp?alt=media&token=8cb8d208-cc1d-4905-93eb-5f3a2a3ee0a4', CAST(N'2023-11-21T15:50:39.260' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (38, 22, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma02-2.webp?alt=media&token=450a1baf-9351-4d9f-979e-96fba41a0932', CAST(N'2023-11-21T15:50:46.913' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (39, 23, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma03-1.webp?alt=media&token=e7cc2d90-7d55-45d8-9013-3e5689d75236', CAST(N'2023-11-21T15:50:55.517' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (40, 23, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma03-2.webp?alt=media&token=5584e050-18f5-4c1e-bafd-fde34f42ec31', CAST(N'2023-11-21T15:51:04.500' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (41, 24, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma04-1.webp?alt=media&token=80aeb550-a6df-4813-8ea9-18428643bb3b', CAST(N'2023-11-21T15:51:17.103' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (42, 24, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma04-2.webp?alt=media&token=cac7dc4d-f2d4-4391-affe-d0245ce98615', CAST(N'2023-11-21T15:51:29.240' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (43, 25, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma05-1.webp?alt=media&token=fd7665c2-47bb-4592-9551-0c11ea290c7c', CAST(N'2023-11-21T15:51:45.857' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (44, 25, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma05-2.webp?alt=media&token=474e25ec-90f6-4770-b657-ee203e78ea2f', CAST(N'2023-11-21T15:51:56.520' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (45, 31, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok01-1.webp?alt=media&token=53305cde-5fe4-4103-a805-ea16e9ad0505', CAST(N'2023-11-21T15:52:07.800' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (46, 31, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok01-2.webp?alt=media&token=1203d318-a630-4a3b-b3e8-dcf83854c41a', CAST(N'2023-11-21T15:52:16.593' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (47, 32, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok02-1.webp?alt=media&token=1fa29583-0a6e-4bbb-9e71-48073c3c139c', CAST(N'2023-11-21T15:52:27.163' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (48, 32, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok02-2.webp?alt=media&token=577959cd-f243-4afe-b1eb-f840ad6170c4', CAST(N'2023-11-21T15:52:38.213' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (49, 33, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok03-1.webp?alt=media&token=9f46af5f-893f-4dd6-bee8-0b844caeb9dd', CAST(N'2023-11-21T15:52:46.910' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (50, 33, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok03-2.webp?alt=media&token=3ae68e6d-2a11-40fb-9bc4-27c1cbc22079', CAST(N'2023-11-21T15:52:54.203' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (51, 34, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok04-1.webp?alt=media&token=6db405d5-4181-4846-855d-b95c282fb284', CAST(N'2023-11-21T15:53:05.217' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (52, 34, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok04-2.webp?alt=media&token=c9aa9104-1789-47f3-a689-c5afcc188d04', CAST(N'2023-11-21T15:53:13.207' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (53, 35, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok05-1.webp?alt=media&token=47c92d70-f8fb-463d-9f4f-fc58588b3c4b', CAST(N'2023-11-21T15:53:23.810' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (54, 35, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok05-2.webp?alt=media&token=b8ec97ff-8cb7-4ac2-bb1f-b22bb85b8d1e', CAST(N'2023-11-21T15:53:38.223' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (55, 41, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance01-1.webp?alt=media&token=5a8c73f4-4701-4c22-a04d-c0ba472a11aa', CAST(N'2023-11-21T15:53:50.500' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (56, 41, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance01-2.webp?alt=media&token=d9940e01-a9c0-434d-b4d3-4946d3b33632', CAST(N'2023-11-21T15:53:59.620' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (57, 42, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance02-1.webp?alt=media&token=034bff8a-107d-44b5-80a0-3a7b39800fdf', CAST(N'2023-11-21T15:54:08.603' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (58, 42, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance02-2.webp?alt=media&token=92f9a657-fa1a-4261-a871-de58046dafc3', CAST(N'2023-11-21T15:54:31.497' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (59, 43, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance03-1.webp?alt=media&token=c1ec3768-fe67-4aba-9279-a48e9015119b', CAST(N'2023-11-21T15:54:46.757' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (60, 43, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance03-2.webp?alt=media&token=e4d80dd3-e74a-4380-aee7-9e412b81d8ec', CAST(N'2023-11-21T15:54:54.880' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (61, 44, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance04-1.webp?alt=media&token=25017656-4867-4e57-9908-883cefa6c917', CAST(N'2023-11-21T15:55:02.810' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (62, 44, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance04-2.webp?alt=media&token=3a72ba5a-ed5d-48d3-9e14-d343e2c45b6b', CAST(N'2023-11-21T15:55:16.433' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (63, 45, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance05-1.webp?alt=media&token=e5e4d4cc-45d1-4cd3-94e6-e4b0d11d82e0', CAST(N'2023-11-21T15:55:27.953' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (64, 45, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance05-2.webp?alt=media&token=0d124c22-1bb7-4505-9ee8-746874117460', CAST(N'2023-11-21T15:55:37.483' AS DateTime))
SET IDENTITY_INSERT [dbo].[product_image] OFF
GO
SET IDENTITY_INSERT [dbo].[review] ON 

INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (1, 1, N'Sản phẩm tuyệt vời!', 3, CAST(N'2023-08-15T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (2, 2, N'Chất lượng tốt', 2, CAST(N'2023-08-14T00:00:00.000' AS DateTime), 4, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (3, 1, N'Dịch vụ xuất sắc', 3, CAST(N'2023-08-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (4, 3, N'Không được khuyến nghị', 4, CAST(N'2023-08-12T00:00:00.000' AS DateTime), 2, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (5, 2, N'Trung bình', 5, CAST(N'2023-08-11T00:00:00.000' AS DateTime), 3, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (6, 4, N'Đề xuất cao', 2, CAST(N'2023-08-10T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (7, 3, N'Chất lượng kém', 2, CAST(N'2023-08-09T00:00:00.000' AS DateTime), 1, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (8, 4, N'Giao hàng nhanh', 4, CAST(N'2023-08-07T00:00:00.000' AS DateTime), 4, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (9, 6, N'Không đáng giá giá tiền', 5, CAST(N'2023-08-06T00:00:00.000' AS DateTime), 2, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (10, 5, N'Tuyệt vời', 5, CAST(N'2023-08-05T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (11, 7, N'Terrible', 2, CAST(N'2023-08-04T00:00:00.000' AS DateTime), 1, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (12, 6, N'Sản phẩm trung bình', 3, CAST(N'2023-08-03T00:00:00.000' AS DateTime), 3, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (13, 8, N'Giá trị tốt', 4, CAST(N'2023-08-02T00:00:00.000' AS DateTime), 4, NULL, NULL, NULL)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3]) VALUES (14, 7, N'Kinh khủng', 5, CAST(N'2023-08-01T00:00:00.000' AS DateTime), 1, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[review] OFF
GO
SET IDENTITY_INSERT [dbo].[shipping_address] ON 

INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (1, N'Hà Nội', N'Cầu Giấy', N'Dịch Vọng Hậu', N'123 Đường ABC', N'Nguyễn Văn Mười', N'0919919919', 0, 1)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (2, N'TPHCM', N'Quận 1', N'Bến Nghé', N'456 Đường XYZ', N'Nguyễn Văn A', N'0456456456', 0, 2)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (3, N'Hải Phòng', N'Hồng Bàng', N'Ngô Quyền', N'789 Đường DEF', N'Nguyễn Văn Mơi', N'0986543166', 0, 3)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (4, N'Đà Nẵng', N'Hải Châu', N'Hòa Cường Nam', N'101 Đường GHI', N'Nguyễn Văn Tèo', N'0987987989', 0, 4)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (5, N'Cần Thơ', N'Ninh Kiều', N'Tân An', N'202 Đường JKL', N'Nguyễn Văn Người Nhận', N'0456456456', 0, 5)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (6, N'An Giang', N'Huyện Phú Tân', N'Xã Hiệp Xương', N'số 28', N'Minh', N'098       ', 1, 1)
SET IDENTITY_INSERT [dbo].[shipping_address] OFF
GO
SET IDENTITY_INSERT [dbo].[size] ON 

INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (1, 38, 1, 0, CAST(N'2023-11-17T10:16:19.223' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (2, 39, 1, 0, CAST(N'2023-11-17T10:16:12.580' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (3, 40, 1, 0, CAST(N'2023-11-24T10:19:13.253' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (4, 41, 1, 0, CAST(N'2022-04-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (5, 42, 1, 0, CAST(N'2023-11-21T16:12:36.380' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (6, 31, 1, 0, CAST(N'2023-11-24T10:44:03.237' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (7, 32, 1, 0, CAST(N'2023-11-17T10:18:07.930' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (8, 33, 1, 0, CAST(N'2023-11-24T10:43:48.077' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (9, 34, 1, 0, CAST(N'2023-11-24T10:44:08.093' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (10, 35, 1, 0, CAST(N'2023-11-24T10:43:57.937' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (11, 36, 1, 0, CAST(N'2023-11-17T10:18:16.363' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (12, 37, 1, 0, CAST(N'2023-11-17T10:18:11.083' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (13, 43, 1, 0, CAST(N'2023-11-21T16:12:30.090' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (14, 44, 1, 0, CAST(N'2023-11-21T16:12:41.460' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (15, 30, 1, 0, CAST(N'2023-11-24T09:58:01.777' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (17, 1, 0, 1, CAST(N'2023-11-24T10:12:09.617' AS DateTime))
SET IDENTITY_INSERT [dbo].[size] OFF
GO
SET IDENTITY_INSERT [dbo].[supplier] ON 

INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (1, N'Nhà cung cấp 1', N'Địa chỉ 1', N'123456789', N'email1@example.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (2, N'Nhà cung cấp 2', N'Địa chỉ 2', N'987654321', N'email2@example.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (3, N'Nhà cung cấp 3', N'Địa chỉ 3', N'555555555', N'email3@example.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (4, N'Nhà cung cấp 4', N'Địa chỉ 4', N'111111111', N'email4@example.com', 0, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (5, N'Nhà cung cấp 5', N'Địa chỉ 5', N'222222222', N'email5@example.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (6, N'Nhà cung cấp 6', N'Địa chỉ 6', N'333333333', N'email6@example.com', 0, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (7, N'Nhà cung cấp 7', N'Địa chỉ 7', N'444444444', N'email7@example.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (8, N'Nhà cung cấp 8', N'Địa chỉ 8', N'666666666', N'email8@example.com', 0, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (9, N'Nhà cung cấp 9', N'Địa chỉ 9', N'777777777', N'email9@example.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (10, N'Nhà cung cấp 10', N'Địa chỉ 10', N'999999999', N'email10@example.com', 1, 0)
SET IDENTITY_INSERT [dbo].[supplier] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (1, N'Bùi Thanh Bùi', N'123 Main St', N'123123123', CAST(N'1990-01-15' AS Date), N'USER', CAST(N'2023-08-10' AS Date), 1, N'BTB@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image1.jpg', 0, 1, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (2, N'Đi Bộ Vuốt Râu', N'456 Elm St', N'9879879897', CAST(N'1985-03-20' AS Date), N'ADMIN', CAST(N'2023-08-11' AS Date), 1, N'DBVR@gnail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image2.jpg', 0, 1, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (3, N'RiChaRiCon', N'789 Oak St', N'456456456', CAST(N'1995-07-05' AS Date), N'USER', CAST(N'2023-08-12' AS Date), 1, N'RCRC@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image3.jpg', 0, 1, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (4, N'Trần Thanh Hải', N'101 Pine St', N'977866511', CAST(N'1980-11-30' AS Date), N'USER', CAST(N'2023-08-13' AS Date), 1, N'bob@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image4.jpg', 0, 1, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (5, N'Nguyễn Lê Văn Thi', N'202 Cedar St', N'986543166', CAST(N'1988-09-25' AS Date), N'ADMIN', CAST(N'2023-08-14' AS Date), 1, N'NLVT@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image5.jpg', 0, 1, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (6, N'Jack5M', N'303 Spruce St', N'919919918', CAST(N'1992-05-10' AS Date), N'USER', CAST(N'2023-08-15' AS Date), 1, N'jack5milion@example.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image6.jpg', 0, 1, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (7, N'minh', N'123', N'123', CAST(N'2022-10-10' AS Date), N'ADMIN', CAST(N'2022-12-20' AS Date), 1, N'minh@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', NULL, 0, 1, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (24, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (35, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (36, N'xinchaocacban2', NULL, N'0989098765', NULL, N'CUSTOMER', CAST(N'2023-11-25' AS Date), 1, N'phamm7696@gmail.com', N'$2a$10$BJ0MfiMWVc1HYgT2cs6Ca.mMlTcALXyB4GNogtm3XF0VoANEW6te.', N'https://images.hdqwalls.com/download/super-saiyan-rose-5a-315x315.jpg', 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[voucher] ON 

INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(15.00 AS Decimal(5, 2)), CAST(N'2023-11-24T00:00:00.000' AS DateTime), CAST(N'2023-11-29T00:00:00.000' AS DateTime), N'Giảm giá cho khách hàng 500.000vnđ', 500000, 0, 1)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(15.00 AS Decimal(5, 2)), CAST(N'2023-11-04T17:00:00.000' AS DateTime), CAST(N'2023-11-20T17:00:00.000' AS DateTime), N'Giảm giá cho khách hàng 300000', 300000, 0, 2)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(10.00 AS Decimal(5, 2)), CAST(N'2023-11-06T00:00:00.000' AS DateTime), CAST(N'2023-11-20T00:00:00.000' AS DateTime), N'Giảm giá cho khách hàng 500000', 500000, 1, 3)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(13.00 AS Decimal(5, 2)), CAST(N'2023-11-10T11:11:00.000' AS DateTime), CAST(N'2023-11-10T11:11:00.000' AS DateTime), N'Giảm giá cho đơn hàng 500 k', 500000, 0, 5)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(13.00 AS Decimal(5, 2)), CAST(N'2023-11-10T11:11:00.000' AS DateTime), CAST(N'2023-11-10T11:11:00.000' AS DateTime), N'Giảm giá cho đơn hàng 500 k', 500000, 0, 6)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(13.00 AS Decimal(5, 2)), CAST(N'2023-11-10T11:11:00.000' AS DateTime), CAST(N'2023-11-11T11:11:00.000' AS DateTime), N'Giảm giá cho đơn hàng 600 k', 600000, 0, 7)
SET IDENTITY_INSERT [dbo].[voucher] OFF
GO
SET IDENTITY_INSERT [dbo].[voucher_use] ON 

INSERT [dbo].[voucher_use] ([use_date], [voucher_id], [users_id], [voucher_use_id], [saved]) VALUES (CAST(N'2023-11-25T20:59:24.000' AS DateTime), 1, 1, 1, 1)
INSERT [dbo].[voucher_use] ([use_date], [voucher_id], [users_id], [voucher_use_id], [saved]) VALUES (CAST(N'2023-11-25T20:59:35.000' AS DateTime), 1, 1, 2, 1)
INSERT [dbo].[voucher_use] ([use_date], [voucher_id], [users_id], [voucher_use_id], [saved]) VALUES (CAST(N'2023-11-25T20:59:40.000' AS DateTime), 1, 1, 3, 1)
INSERT [dbo].[voucher_use] ([use_date], [voucher_id], [users_id], [voucher_use_id], [saved]) VALUES (CAST(N'2023-11-25T20:59:44.000' AS DateTime), 1, 1, 4, 1)
SET IDENTITY_INSERT [dbo].[voucher_use] OFF
GO
ALTER TABLE [dbo].[brand] ADD  DEFAULT ((0)) FOR [activities]
GO
ALTER TABLE [dbo].[brand] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[category] ADD  DEFAULT ((0)) FOR [activities]
GO
ALTER TABLE [dbo].[category] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[color] ADD  DEFAULT ((0)) FOR [activities]
GO
ALTER TABLE [dbo].[color] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[direct_discount] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[import_receipt] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[import_receipt_detail] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[product] ADD  DEFAULT ((0)) FOR [activities]
GO
ALTER TABLE [dbo].[product] ADD  DEFAULT ((0)) FOR [featured]
GO
ALTER TABLE [dbo].[product] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[product_detail] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[size] ADD  DEFAULT ((0)) FOR [activities]
GO
ALTER TABLE [dbo].[size] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[supplier] ADD  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([users_id])
GO
ALTER TABLE [dbo].[cart_detail]  WITH CHECK ADD FOREIGN KEY([cart_id])
REFERENCES [dbo].[cart] ([cart_id])
GO
ALTER TABLE [dbo].[cart_detail]  WITH CHECK ADD FOREIGN KEY([product_detail_id])
REFERENCES [dbo].[product_detail] ([product_detail_id])
GO
ALTER TABLE [dbo].[cart_detail]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[direct_discount]  WITH CHECK ADD  CONSTRAINT [fk_direct_discount] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[direct_discount] CHECK CONSTRAINT [fk_direct_discount]
GO
ALTER TABLE [dbo].[favorite]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[favorite]  WITH CHECK ADD FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([users_id])
GO
ALTER TABLE [dbo].[import_receipt]  WITH CHECK ADD  CONSTRAINT [fk_import_receipt_supplier] FOREIGN KEY([supplier_id])
REFERENCES [dbo].[supplier] ([supplier_id])
GO
ALTER TABLE [dbo].[import_receipt] CHECK CONSTRAINT [fk_import_receipt_supplier]
GO
ALTER TABLE [dbo].[import_receipt]  WITH CHECK ADD  CONSTRAINT [fk_import_receipt_user] FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([users_id])
GO
ALTER TABLE [dbo].[import_receipt] CHECK CONSTRAINT [fk_import_receipt_user]
GO
ALTER TABLE [dbo].[import_receipt_detail]  WITH CHECK ADD  CONSTRAINT [fk_import_receipt_detail_import] FOREIGN KEY([import_receipt_id])
REFERENCES [dbo].[import_receipt] ([import_receipt_id])
GO
ALTER TABLE [dbo].[import_receipt_detail] CHECK CONSTRAINT [fk_import_receipt_detail_import]
GO
ALTER TABLE [dbo].[import_receipt_detail]  WITH CHECK ADD  CONSTRAINT [fk_import_receipt_detale_product] FOREIGN KEY([product_detail_id])
REFERENCES [dbo].[product_detail] ([product_detail_id])
GO
ALTER TABLE [dbo].[import_receipt_detail] CHECK CONSTRAINT [fk_import_receipt_detale_product]
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD FOREIGN KEY([payment_method_id])
REFERENCES [dbo].[payment_menthod] ([payment_method_id])
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD FOREIGN KEY([shipping_address_id])
REFERENCES [dbo].[shipping_address] ([shipping_address_id])
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([users_id])
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_voucher_use] FOREIGN KEY([voucher_use_id])
REFERENCES [dbo].[voucher_use] ([voucher_use_id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_voucher_use]
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[order] ([order_id])
GO
ALTER TABLE [dbo].[order_detail]  WITH CHECK ADD FOREIGN KEY([product_detail_id])
REFERENCES [dbo].[product_detail] ([product_detail_id])
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [fk_brand] FOREIGN KEY([brand_id])
REFERENCES [dbo].[brand] ([brand_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [fk_brand]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [fk_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [fk_category]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [fk_userr] FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([users_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [fk_userr]
GO
ALTER TABLE [dbo].[product_detail]  WITH CHECK ADD  CONSTRAINT [fk_color] FOREIGN KEY([color_id])
REFERENCES [dbo].[color] ([color_id])
GO
ALTER TABLE [dbo].[product_detail] CHECK CONSTRAINT [fk_color]
GO
ALTER TABLE [dbo].[product_detail]  WITH CHECK ADD  CONSTRAINT [fk_productqw] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_detail] CHECK CONSTRAINT [fk_productqw]
GO
ALTER TABLE [dbo].[product_detail]  WITH CHECK ADD  CONSTRAINT [fk_size] FOREIGN KEY([size_id])
REFERENCES [dbo].[size] ([size_id])
GO
ALTER TABLE [dbo].[product_detail] CHECK CONSTRAINT [fk_size]
GO
ALTER TABLE [dbo].[product_image]  WITH CHECK ADD  CONSTRAINT [fk_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_image] CHECK CONSTRAINT [fk_product]
GO
ALTER TABLE [dbo].[review]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[review]  WITH CHECK ADD FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([users_id])
GO
ALTER TABLE [dbo].[shipping_address]  WITH CHECK ADD FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([users_id])
GO
ALTER TABLE [dbo].[voucher_use]  WITH CHECK ADD FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([users_id])
GO
ALTER TABLE [dbo].[voucher_use]  WITH CHECK ADD  CONSTRAINT [FK_voucher] FOREIGN KEY([voucher_id])
REFERENCES [dbo].[voucher] ([voucher_id])
GO
ALTER TABLE [dbo].[voucher_use] CHECK CONSTRAINT [FK_voucher]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertCartItem]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROCEDURE [dbo].[SP_InsertCartItem]
    @cart_id BIGINT,
    @product_id BIGINT,
    @size_id BIGINT,
    @color_id BIGINT,
    @quantity INT
AS
BEGIN
    DECLARE @product_detail_id BIGINT;

    -- Find the variant_id based on provided criteria
    SELECT @product_detail_id = product_detail_id
    FROM product_detail
    WHERE product_id = @product_id AND size_id = @size_id AND color_id = @color_id;

    -- Check if the cart item already exists
    DECLARE @existing_cart_item_id BIGINT;

    SELECT @existing_cart_item_id = cart_detail_id
    FROM cart_detail
    WHERE cart_id = @cart_id AND product_detail_id = @product_detail_id;

    -- If the cart item exists, update the quantity
    IF @existing_cart_item_id IS NOT NULL
    BEGIN
        UPDATE cart_detail
        SET quantity = quantity + @quantity
        WHERE cart_detail_id = @existing_cart_item_id;
    END
    ELSE
    BEGIN
        -- If the cart item does not exist, insert a new row
        INSERT INTO cart_detail(cart_id, product_detail_id, product_id, quantity)
        VALUES (@cart_id, @product_detail_id,@product_id, @quantity);
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertShippingAddress]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROCEDURE [dbo].[SP_InsertShippingAddress]
    @user_id BIGINT,
    @default bit,
    @province nvarchar(255),
	@district nvarchar(255),
	@ward nvarchar(255),
    @name_receiver nvarchar(50),
    @phone_receiver char(50),
	 @address_detail nvarchar(250)
AS
BEGIN
    DECLARE @shipping_id BIGINT;

    
    SELECT @shipping_id = shipping_address_id
    FROM shipping_address
    WHERE users_id = @user_id;
	
	IF @shipping_id is null
	 BEGIN
        insert into shipping_address(users_id,name_receiver,phone_receiver,province,district,ward,default_address,address_details)
        values (@user_id,@name_receiver,@phone_receiver,@province,@district,@ward,1,@address_detail)
    END
	ELSE
	Begin
		if @default = 1
		begin
			--finde the present default id 
			DECLARE @addressDefault_id BIGINT

			select @addressDefault_id = shipping_address_id
			from shipping_address 
			where users_id = @user_id and default_address =1
			
			 BEGIN
					UPDATE shipping_address
					SET default_address = 0
					WHERE shipping_address_id = @addressDefault_id;
			 END
				insert into shipping_address(users_id,name_receiver,phone_receiver,province,district,ward,default_address,address_details)
				values (@user_id,@name_receiver,@phone_receiver,@province,@district,@ward,@default,@address_detail)
		end
		else
		Begin 
			insert into shipping_address(users_id,name_receiver,phone_receiver,province,district,ward,default_address,address_details)
				values (@user_id,@name_receiver,@phone_receiver,@province,@district,@ward,@default,@address_detail)
		End
	End
END

GO
/****** Object:  StoredProcedure [dbo].[SP_updateCartItem]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   PROCEDURE [dbo].[SP_updateCartItem]
    @cart_detail_id BIGINT,
    @product_id BIGINT,
    @size_id BIGINT,
    @color_id BIGINT
AS
BEGIN
    DECLARE @product_detail_id BIGINT;

    -- Find the variant_id based on provided criteria
    SELECT @product_detail_id = product_detail_id
    FROM product_detail
    WHERE product_id = @product_id AND size_id = @size_id AND color_id = @color_id;

    -- Check if the cart item already exist
    IF @product_detail_id IS NOT NULL
    BEGIN
        UPDATE cart_detail
        SET product_detail_id = @product_detail_id
        WHERE cart_detail_id = @cart_detail_id
    
    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateDefault]    Script Date: 25/11/2023 9:36:40 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   PROCEDURE [dbo].[SP_UpdateDefault]
    @user_id BIGINT,
	@shipping_address_id BIGINT
    
AS
BEGIN
			DECLARE @addressDefault_id BIGINT

			select @addressDefault_id = shipping_address_id
			from shipping_address 
			where users_id = @user_id and default_address =1
			
			 BEGIN
					UPDATE shipping_address
					SET default_address = 0
					WHERE shipping_address_id = @addressDefault_id;
			 END

			 BEGIN
					UPDATE shipping_address
					SET default_address = 1
					WHERE shipping_address_id = @shipping_address_id;
			 END
	
END
GO
USE [master]
GO
ALTER DATABASE [stepupstyles] SET  READ_WRITE 
GO
