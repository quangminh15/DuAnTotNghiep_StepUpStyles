USE [master]
GO
/****** Object:  Database [stepupstyles]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[brand]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[cart]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[cart_detail]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[category]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[color]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[direct_discount]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[favorite]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[import_receipt]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[import_receipt_detail]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[order]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[order_detail]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[payment_menthod]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[product]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[product_detail]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[product_image]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[review]    Script Date: 13/12/2023 4:46:38 CH ******/
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
	[order_detail_id] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shipping_address]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[size]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[supplier]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[voucher]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  Table [dbo].[voucher_use]    Script Date: 13/12/2023 4:46:38 CH ******/
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
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (3, N'Puma', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F3.jpg?alt=media&token=93f717a3-d9bf-4288-a554-3e58a305c4c5', 1, 0, CAST(N'2023-12-03T21:41:45.500' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (4, N'Reebok', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F4.png?alt=media&token=cd62b1f3-38eb-4c8d-a3fa-54fbe9d33fce', 1, 0, CAST(N'2023-11-22T14:08:54.067' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (5, N'New Balance', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F5.png?alt=media&token=7e7ac7e0-b26a-498b-a1da-63ed6738e3e5', 1, 0, CAST(N'2023-11-21T16:35:11.883' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (17, N'Vans', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2Fvans.png?alt=media&token=ad038354-71d9-4f18-bf11-5dd78cae6de6', 1, 0, CAST(N'2023-12-10T21:27:15.613' AS DateTime))
SET IDENTITY_INSERT [dbo].[brand] OFF
GO
SET IDENTITY_INSERT [dbo].[cart] ON 

INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (7, 1)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (8, 2)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (9, 3)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (10, 4)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (11, 5)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (12, 6)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (13, 7)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (14, 8)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (15, 9)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (16, 10)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (17, 11)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (18, 12)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (19, 13)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (20, 14)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (21, 15)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (22, 16)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (23, 17)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (24, 18)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (25, 19)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (26, 20)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (27, 21)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (28, 22)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (29, 23)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (30, 24)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (31, 25)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (32, 26)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (33, 27)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (34, 28)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (35, 29)
SET IDENTITY_INSERT [dbo].[cart] OFF
GO
SET IDENTITY_INSERT [dbo].[cart_detail] ON 

INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (7, 34, 54, 1, 4)
SET IDENTITY_INSERT [dbo].[cart_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (1, N'Giày nam', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2Fgiaynam.jpg?alt=media&token=b68d6705-c330-4982-b057-bb8996eba2ec', 1, 0, CAST(N'2023-12-03T21:57:39.807' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (2, N'Giày nữ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2Fgiaynu.jpg?alt=media&token=ac270809-4ce2-448c-9d45-1ad12f4d2749', 1, 0, CAST(N'2023-11-22T19:00:43.023' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (3, N'Giày thể thao', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2Fthethao.jpg?alt=media&token=12800c41-3734-4f76-8fac-b5f9ba1aa202', 1, 0, CAST(N'2023-11-22T19:00:17.170' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (4, N'Giày chạy bộ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2Fchayjbo.jpg?alt=media&token=4e395022-9dcd-49ef-936b-29786df352ae', 1, 0, CAST(N'2023-11-22T19:00:27.820' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (5, N'Giày đi bộ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid6.jpg?alt=media&token=ef1773b3-bf5f-4087-a8c6-45fddc0f85d4', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[color] ON 

INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (1, N'Ðen', 1, 0, CAST(N'2023-10-19T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (2, N'Xanh dương', 1, 0, CAST(N'2023-12-11T10:26:13.423' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (3, N'Xanh lam', 1, 0, CAST(N'2023-12-10T22:15:05.947' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (4, N'Vàng', 1, 0, CAST(N'2023-12-10T22:15:12.627' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (5, N'Đỏ', 1, 0, CAST(N'2023-10-13T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (6, N'Tím', 1, 0, CAST(N'2023-10-13T00:00:00.000' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (7, N'Hồng', 1, 0, CAST(N'2023-12-10T22:15:18.140' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (8, N'Trắng', 1, 0, CAST(N'2023-12-10T22:14:54.890' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (9, N'Nâu', 1, 0, CAST(N'2023-12-11T10:07:15.587' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (10, N'Xám', 1, 0, CAST(N'2023-12-11T10:26:21.750' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (11, N'Cam', 1, 0, CAST(N'2023-12-11T10:27:47.140' AS DateTime))
INSERT [dbo].[color] ([color_id], [color_name], [activities], [deleted], [modify_date]) VALUES (12, N'Xanh lá', 1, 0, CAST(N'2023-12-11T10:31:45.337' AS DateTime))
SET IDENTITY_INSERT [dbo].[color] OFF
GO
SET IDENTITY_INSERT [dbo].[direct_discount] ON 

INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (19, 1, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-15T23:59:00.000' AS DateTime), CAST(N'2023-12-22T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 4750000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (20, 2, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-15T23:59:00.000' AS DateTime), CAST(N'2023-12-22T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 1425000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (21, 3, CAST(6.00 AS Decimal(5, 2)), CAST(N'2023-12-15T23:59:00.000' AS DateTime), CAST(N'2023-12-22T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 1880000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (22, 4, CAST(7.00 AS Decimal(5, 2)), CAST(N'2023-12-15T23:59:00.000' AS DateTime), CAST(N'2023-12-22T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 1255500)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (23, 5, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-15T23:59:00.000' AS DateTime), CAST(N'2023-12-22T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 2327500)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (24, 6, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-15T23:59:00.000' AS DateTime), CAST(N'2023-12-22T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 3467500)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (25, 7, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-15T23:59:00.000' AS DateTime), CAST(N'2023-12-22T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 6260500)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (26, 8, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-22T23:59:00.000' AS DateTime), CAST(N'2023-12-29T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 759050)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (27, 9, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-22T23:59:00.000' AS DateTime), CAST(N'2023-12-29T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 475000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (28, 10, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-22T23:59:00.000' AS DateTime), CAST(N'2023-12-29T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 474050)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (29, 11, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-22T23:59:00.000' AS DateTime), CAST(N'2023-12-29T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 6840000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (30, 12, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-29T23:59:00.000' AS DateTime), CAST(N'2023-12-29T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 3800000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (31, 13, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-22T23:59:00.000' AS DateTime), CAST(N'2023-12-29T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 5700000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (32, 14, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-22T23:59:00.000' AS DateTime), CAST(N'2023-12-29T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 1425000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (33, 15, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-22T23:59:00.000' AS DateTime), CAST(N'2023-12-29T23:59:00.000' AS DateTime), 0, N'Chưa diễn ra', 1900000)
SET IDENTITY_INSERT [dbo].[direct_discount] OFF
GO
SET IDENTITY_INSERT [dbo].[favorite] ON 

INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (1, 2, 13, CAST(N'2023-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (2, 1, 13, CAST(N'2023-10-23T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (4, 2, 15, CAST(N'2023-09-20T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (5, 7, 16, CAST(N'2023-12-13T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (6, 3, 17, CAST(N'2023-06-10T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (7, 1, 19, CAST(N'2023-10-10T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (8, 5, 15, CAST(N'2023-05-02T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (9, 6, 14, CAST(N'2023-10-02T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (10, 1, 17, CAST(N'2023-12-04T00:00:00.000' AS DateTime))
INSERT [dbo].[favorite] ([favorite_id], [product_id], [users_id], [date_like]) VALUES (11, 3, 18, CAST(N'2023-12-13T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[favorite] OFF
GO
SET IDENTITY_INSERT [dbo].[import_receipt] ON 

INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (1, 1, 1, 533750000, CAST(N'2023-12-11T20:26:58.347' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (2, 2, 1, 518410000, CAST(N'2023-12-11T20:27:05.893' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (3, 3, 2, 152050000, CAST(N'2023-11-11T20:27:33.047' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (4, 4, 2, 734750000, CAST(N'2023-07-11T20:27:37.357' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (5, 5, 7, 660750000, CAST(N'2023-10-11T20:28:28.353' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (6, 7, 7, 487250000, CAST(N'2023-09-11T20:28:31.777' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (7, 11, 7, 177400000, CAST(N'2023-08-11T20:30:13.967' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (8, 15, 7, 599250000, CAST(N'2023-06-11T20:30:18.107' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (9, 13, 2, 402905000, CAST(N'2023-05-11T20:30:35.107' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (10, 17, 2, 400000000, CAST(N'2023-04-11T20:30:39.107' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (11, 13, 2, 437000000, CAST(N'2023-03-11T20:30:42.800' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (12, 11, 2, 177250000, CAST(N'2023-02-11T20:30:53.140' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (13, 15, 2, 360000000, CAST(N'2023-01-11T20:30:59.650' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[import_receipt] OFF
GO
SET IDENTITY_INSERT [dbo].[import_receipt_detail] ON 

INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (1, 1, 1, 50, 4700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (2, 64, 1, 40, 1300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (3, 3, 1, 60, 1800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (4, 89, 1, 30, 1250000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (5, 95, 1, 45, 2250000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (6, 99, 2, 40, 3500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (7, 7, 2, 50, 6400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (8, 122, 2, 30, 699000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (9, 128, 2, 45, 300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (10, 135, 2, 60, 399000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (11, 141, 3, 50, 150000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (12, 141, 3, 40, 170000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (13, 146, 3, 30, 800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (14, 150, 3, 60, 800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (15, 156, 3, 55, 650000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (16, 158, 3, 40, 750000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (17, 160, 4, 55, 450000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (18, 15, 4, 35, 7000000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (19, 16, 4, 40, 3800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (20, 19, 4, 45, 5800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (21, 20, 4, 40, 1300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (22, 23, 5, 50, 1800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (23, 162, 5, 55, 7400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (24, 25, 5, 70, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (25, 26, 5, 40, 850000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (26, 29, 5, 45, 850000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (27, 30, 5, 50, 850000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (28, 32, 6, 45, 750000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (29, 165, 6, 55, 650000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (30, 34, 6, 40, 800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (31, 36, 6, 60, 850000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (32, 38, 6, 45, 6500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (33, 39, 6, 65, 650000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (34, 41, 7, 50, 750000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (35, 169, 7, 40, 400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (36, 171, 7, 45, 350000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (37, 175, 7, 60, 650000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (38, 174, 7, 64, 350000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (39, 177, 7, 55, 850000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (40, 179, 8, 50, 1100000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (41, 49, 8, 40, 4700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (42, 67, 8, 45, 1300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (43, 78, 8, 55, 1800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (44, 90, 8, 60, 1250000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (45, 98, 8, 55, 2250000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (46, 106, 9, 40, 3350000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (47, 116, 9, 30, 6400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (48, 119, 9, 50, 699000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (49, 129, 9, 60, 300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (50, 137, 9, 45, 399000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (51, 138, 9, 40, 150000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (52, 146, 10, 40, 800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (53, 150, 10, 30, 800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (54, 154, 10, 45, 650000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (55, 157, 10, 60, 750000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (56, 160, 10, 55, 450000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (57, 15, 10, 35, 7000000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (58, 16, 10, 35, 7000000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (59, 19, 11, 30, 5800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (60, 21, 11, 35, 1300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (61, 23, 11, 20, 1800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (62, 161, 11, 15, 7400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (63, 24, 11, 40, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (64, 26, 11, 50, 850000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (65, 28, 12, 45, 850000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (66, 30, 12, 30, 850000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (67, 32, 12, 60, 750000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (68, 165, 12, 50, 650000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (69, 34, 12, 45, 800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (70, 36, 13, 30, 850000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (71, 37, 13, 40, 6500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (72, 39, 13, 20, 650000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (73, 41, 13, 50, 750000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (74, 167, 13, 60, 400000, 0)
SET IDENTITY_INSERT [dbo].[import_receipt_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[order] ON 

INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (7, 12, 11, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:24:13.000' AS DateTime), 30000000, 41501, 30041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (8, 12, 12, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:25:27.000' AS DateTime), 7849000, 41501, 7184091, N'Delivered', 706410, 3)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (9, 13, 13, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:26:04.000' AS DateTime), 10500000, 41501, 10541501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (10, 14, 14, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:26:58.000' AS DateTime), 16950000, 41501, 16991501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (11, 14, 15, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:27:04.000' AS DateTime), 7300000, 41501, 7341501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (12, 15, 16, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:27:43.000' AS DateTime), 3196000, 41501, 3237501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (13, 16, 17, 1, CAST(N'2023-12-20' AS Date), 0, 0, CAST(N'2023-12-13T10:28:09.000' AS DateTime), 2500000, 41501, 2541501, N'Pending', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (14, 16, 18, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:28:27.000' AS DateTime), 4000000, 41501, 4041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (15, 17, 19, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:28:46.000' AS DateTime), 4000000, 41501, 4041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (16, 17, 20, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:29:05.000' AS DateTime), 6000000, 41501, 6041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (17, 17, 20, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:29:25.000' AS DateTime), 2000000, 41501, 2041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (18, 18, 21, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:30:50.000' AS DateTime), 789500, 41501, 831001, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (19, 18, 22, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:31:20.000' AS DateTime), 6848000, 41501, 6889501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (20, 19, 23, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:31:58.000' AS DateTime), 2802000, 41501, 2843501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (21, 19, 23, 1, CAST(N'2023-12-20' AS Date), 0, 0, CAST(N'2023-12-13T10:32:30.000' AS DateTime), 500000, 41501, 541501, N'Pending', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (22, 20, 24, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:32:47.000' AS DateTime), 1350000, 41501, 1391501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (23, 20, 24, 1, CAST(N'2023-12-13' AS Date), 1, 0, CAST(N'2023-12-13T10:33:11.000' AS DateTime), 26360000, 41501, 26401501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (24, 21, 25, 1, CAST(N'2023-12-20' AS Date), 0, 0, CAST(N'2023-12-13T10:33:40.000' AS DateTime), 46130000, 41501, 46171501, N'Cancel', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (25, 21, 26, 1, CAST(N'2023-12-20' AS Date), 0, 0, CAST(N'2023-12-13T10:34:56.000' AS DateTime), 14400000, 41501, 14441501, N'Pending', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (26, 21, 27, 1, CAST(N'2023-12-20' AS Date), 0, 0, CAST(N'2023-12-13T10:35:12.000' AS DateTime), 500000, 41501, 541501, N'Confirmed', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (27, 22, 28, 1, CAST(N'2023-12-20' AS Date), 0, 0, CAST(N'2023-12-13T10:35:28.000' AS DateTime), 500000, 41501, 541501, N'Pending', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (28, 22, 29, 1, CAST(N'2023-12-20' AS Date), 0, 0, CAST(N'2023-12-13T10:36:22.000' AS DateTime), 42580580, 41501, 42622081, N'Confirmed', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (29, 22, 30, 1, CAST(N'2023-12-20' AS Date), 0, 0, CAST(N'2023-12-13T10:36:35.000' AS DateTime), 3101000, 41501, 3142501, N'Pending', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (30, 23, 31, 1, CAST(N'2023-12-20' AS Date), 0, 0, CAST(N'2023-12-13T10:37:08.000' AS DateTime), 40150000, 41501, 40191501, N'Pending', 0, NULL)
SET IDENTITY_INSERT [dbo].[order] OFF
GO
SET IDENTITY_INSERT [dbo].[order_detail] ON 

INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (7, 7, 54, 6, 5000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (8, 8, 98, 3, 2450000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (9, 8, 136, 1, 499000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (10, 9, 130, 1, 500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (11, 9, 77, 5, 2000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (12, 10, 82, 3, 2000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (13, 10, 104, 3, 3650000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (14, 11, 100, 2, 3650000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (15, 12, 118, 4, 799000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (16, 13, 129, 5, 500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (17, 14, 17, 1, 4000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (18, 15, 17, 1, 4000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (19, 16, 19, 1, 6000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (20, 17, 23, 1, 2000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (21, 18, 39, 1, 789500)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (22, 19, 32, 8, 856000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (23, 20, 28, 3, 934000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (24, 21, 167, 1, 500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (25, 22, 90, 1, 1350000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (26, 23, 109, 4, 6590000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (27, 24, 109, 7, 6590000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (28, 25, 15, 2, 7200000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (29, 26, 129, 1, 500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (30, 27, 129, 1, 500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (31, 28, 37, 6, 6785430)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (32, 28, 29, 2, 934000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (33, 29, 9, 1, 500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (34, 29, 25, 3, 867000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (35, 30, 107, 5, 3650000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (36, 30, 6, 6, 3650000)
SET IDENTITY_INSERT [dbo].[order_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[payment_menthod] ON 

INSERT [dbo].[payment_menthod] ([payment_method_id], [payment_menthod_name], [description], [display]) VALUES (1, N'Thanh toán khi nhân hàng', N'Thanh toán tiền mặt', 1)
INSERT [dbo].[payment_menthod] ([payment_method_id], [payment_menthod_name], [description], [display]) VALUES (2, N'VNPAY', N'Thanh toán online', 1)
INSERT [dbo].[payment_menthod] ([payment_method_id], [payment_menthod_name], [description], [display]) VALUES (3, N'PayPal', N'Thanh toán online', 1)
SET IDENTITY_INSERT [dbo].[payment_menthod] OFF
GO
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (1, N'Converse 01', 1, 1, 7, 5000000, N'<p>Converse l&agrave; biểu tượng của đường phố bụi bặm.</p>

<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong tr&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2023 nay, h&agrave;ng vải canvas, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ. Gồm Cnverse g&oacute;t đen trắng</p>

<p>- Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy converse bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao Converse nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-12-08T15:26:16.223' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (2, N'Converse 02', 2, 1, 7, 1500000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Mi Bantang, Quận Taijiang Địa chỉ: Mặt tiền cửa h&agrave;ng 17, Tầng 1, T&ograve;a nh&agrave; 1 #, T&ograve;a nh&agrave; Thương mại Liwei, Số 488, Đường Liuyi Middle, Phố Yingzhou, Quận Taijiang, Ph&uacute;c Ch&acirc;u, Ph&uacute;c Kiến, Trung Quốc</p>

<p>- Gi&agrave;y nam thời trang cao cổ Converse m&agrave;u c&aacute; t&iacute;nh hot trend 2023</p>

<p>- Với thiết kế phong c&aacute;ch đơn giản , đ&ocirc;i gi&agrave;y thể thao nam c&oacute; những điểm nhấn cực k&igrave; bắt mắt v&agrave; nổi bật khiến người đi nổi bật giữa đ&aacute;m đ&ocirc;ng .</p>

<p>- Chất liệu đế đ&ocirc;i gi&agrave;y nam được l&agrave;m từ vải canvas gi&uacute;p cho bạn đi cả ng&agrave;y m&agrave; vẫn cảm gi&aacute;c rất &ecirc;m &aacute;i .</p>

<p>- Với kiểu d&aacute;ng trẻ trung hiện đại , chủ nh&acirc;n của đ&ocirc;i gi&agrave;y nam c&oacute; thể phối với bất k&igrave; bộ đồ n&agrave;o trong tủ đồ , để đi chơi dạo phố , đi dự tiệc , đi du lịch picnic .</p>

<p>- Size gi&agrave;y đa dạng cho tất cả c&aacute;c anh em lựa chọn Tất cả c&aacute;c sản phẩm gi&agrave;y b&ecirc;n shop đều c&oacute; l&oacute;t gi&agrave;y tho&aacute;ng kh&iacute; chống h&ocirc;i ch&acirc;n Shop xin CAM KẾT 100% ảnh Gi&agrave;y do Shop tự chụp v&agrave; đ&iacute;nh Logo.</p>

<p>✔️ H&agrave;ng chuẩn 100% - Cam kết đổi trả nếu lỗi từ nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi trả size nếu kh&ocirc;ng vừa</p>

<p>✔️ Kiểu d&aacute;ng &ocirc;m ch&acirc;n, thon gọn, thoải m&aacute;i di chuyển m&agrave; kh&ocirc;ng lo đau ch&acirc;n</p>

<p>✔️ Giao h&agrave;ng tại nh&agrave;, Thanh to&aacute;n tại nh&agrave;, nhanh ch&oacute;ng, tiện dụng CHAT TRỰC TIẾP VỚI NH&Acirc;N VI&Ecirc;N</p>

<p>✔️ Gửi kh&aacute;ch xem mẫu gi&agrave;y hiện c&oacute;</p>

<p>✔️ Tư vấn c&aacute;c mẫu gi&agrave;y ph&ugrave; hợp với kh&aacute;ch h&agrave;ng Ch&uacute;ng t&ocirc;i mong muốn bạn hạnh ph&uacute;c khi mua h&agrave;ng!</p>

<p>-----------------------------------------------------</p>
', 1, 1, CAST(N'2023-12-08T15:23:33.463' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (3, N'Converse 03', 3, 1, 7, 2000000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Mi Bantang, Quận Taijiang Địa chỉ: Mặt tiền cửa h&agrave;ng 17, Tầng 1, T&ograve;a nh&agrave; 1 #, T&ograve;a nh&agrave; Thương mại Liwei, Số 488, Đường Liuyi Middle, Phố Yingzhou, Quận Taijiang, Ph&uacute;c Ch&acirc;u, Ph&uacute;c Kiến, Trung Quốc</p>

<p>- Gi&agrave;y nam thời trang cao cổ Converse m&agrave;u c&aacute; t&iacute;nh hot trend 2023</p>

<p>- Với thiết kế phong c&aacute;ch đơn giản , đ&ocirc;i gi&agrave;y thể thao nam c&oacute; những điểm nhấn cực k&igrave; bắt mắt v&agrave; nổi bật khiến người đi nổi bật giữa đ&aacute;m đ&ocirc;ng .</p>

<p>- Chất liệu đế đ&ocirc;i gi&agrave;y nam được l&agrave;m từ vải canvas gi&uacute;p cho bạn đi cả ng&agrave;y m&agrave; vẫn cảm gi&aacute;c rất &ecirc;m &aacute;i .</p>

<p>- Với kiểu d&aacute;ng trẻ trung hiện đại , chủ nh&acirc;n của đ&ocirc;i gi&agrave;y nam c&oacute; thể phối với bất k&igrave; bộ đồ n&agrave;o trong tủ đồ , để đi chơi dạo phố , đi dự tiệc , đi du lịch picnic .</p>

<p>- Size gi&agrave;y đa dạng cho tất cả c&aacute;c anh em lựa chọn Tất cả c&aacute;c sản phẩm gi&agrave;y b&ecirc;n shop đều c&oacute; l&oacute;t gi&agrave;y tho&aacute;ng kh&iacute; chống h&ocirc;i ch&acirc;n Shop xin CAM KẾT 100% ảnh Gi&agrave;y do Shop tự chụp v&agrave; đ&iacute;nh Logo.</p>

<p>✔️ H&agrave;ng chuẩn 100% - Cam kết đổi trả nếu lỗi từ nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi trả size nếu kh&ocirc;ng vừa</p>

<p>✔️ Kiểu d&aacute;ng &ocirc;m ch&acirc;n, thon gọn, thoải m&aacute;i di chuyển m&agrave; kh&ocirc;ng lo đau ch&acirc;n</p>

<p>✔️ Giao h&agrave;ng tại nh&agrave;, Thanh to&aacute;n tại nh&agrave;, nhanh ch&oacute;ng, tiện dụng CHAT TRỰC TIẾP VỚI NH&Acirc;N VI&Ecirc;N</p>

<p>✔️ Gửi kh&aacute;ch xem mẫu gi&agrave;y hiện c&oacute;</p>

<p>✔️ Tư vấn c&aacute;c mẫu gi&agrave;y ph&ugrave; hợp với kh&aacute;ch h&agrave;ng Ch&uacute;ng t&ocirc;i mong muốn bạn hạnh ph&uacute;c khi mua h&agrave;ng!</p>

<p>-----------------------------------------------------</p>
', 1, 0, CAST(N'2023-12-08T15:23:54.627' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (4, N'Converse 04', 4, 1, 7, 1350000, N'<p>Gi&agrave;y Converse Nam nữ Đen Size đa dạng ▪️Xuất xứ: Việt Nam</p>

<p>▪️Thương hiệu: Converse</p>

<p>▪️Chất liệu: Vải Canvas</p>

<p>▪️Đế: Cao su lưu h&oacute;a Dải</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM ✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc</p>

<p>🎁 G&Oacute;C MUA H&Agrave;NG</p>

<p>✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 1, 1, CAST(N'2023-12-08T15:25:18.103' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (5, N'Converse 05', 5, 1, 7, 2450000, N'<p>Converse l&agrave; biểu tượng của đường phố bụi bặm.</p>

<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong tr&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2023 nay, h&agrave;ng vải canvas, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ. Gồm Cnverse g&oacute;t đen trắng</p>

<p>- Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy converse bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao Converse nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-12-08T15:26:07.920' AS DateTime), 0)
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
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (8, N'Converse 08', 3, 1, 7, 799000, N'<p>Converse l&agrave; biểu tượng của đường phố bụi bặm.</p>

<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong tr&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2023 nay, h&agrave;ng vải canvas, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ. Gồm Cnverse g&oacute;t đen trắng</p>

<p>- Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy converse bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao Converse nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-12-08T15:28:53.023' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (9, N'Converse 09', 4, 1, 7, 500000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: vải canvas</p>

<p>+ M&agrave;u: đa dạng</p>

<p>+ Size: đa dạng (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

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
', 1, 0, CAST(N'2023-12-08T15:29:38.823' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (10, N'Converse 10', 5, 1, 7, 499000, N'<p>SHOP SUS LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; JD size 39-44</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM CỔ CAO JD</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp )</p>

<p>✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam Converse b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đa dạng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam Converse c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM</p>

<p>✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 1, 1, CAST(N'2023-12-08T15:30:41.897' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (11, N'Nike 01', 2, 2, 7, 7200000, N'<p>🐾 Size: đa dạng</p>

<p>⚡️ Tất cả sản phẩm của Shop đều cam kết Full Box, đ&oacute;ng g&oacute;i cẩn thận nhằm mang lại cho kh&aacute;ch h&agrave;ng trải nghiệm mua sắm online an t&acirc;m nhất! (Ngoại trừ c&aacute;c đợt sale gi&aacute; sỉ th&igrave; Shop kh&ocirc;ng thể hỗ trợ th&ecirc;m box đc)</p>

<p>👌 Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✨ Lưu &yacute; : H&agrave;ng xưởng về nhiều đợt do shop đặt số lượng lớn ,n&ecirc;n mỗi đợt lưới, logo v&agrave; đế c&oacute; kh&aacute;c nhau. C&aacute;c bạn nhớ xem b&agrave;i viết của shop v&agrave; c&acirc;n nhắc trước khi đặt nh&eacute;.</p>

<p>❗️❗️❗️ Ảnh Shop to&agrave;n bộ đều l&agrave; ảnh thật độc quyền tự chụp, c&aacute;c bạn k&eacute;o qua để xem video v&agrave; c&aacute;c g&oacute;c kh&aacute;c nh&eacute;</p>
', 1, 1, CAST(N'2023-12-08T16:05:36.510' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (12, N'Nike 02', 1, 2, 7, 4000000, N'<p>FSHOP LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; Nike&nbsp;size đa dạng</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM Nike&nbsp;</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp )</p>

<p>✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam Nike&nbsp;b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đen trắng v&agrave; x&aacute;m xanh trắng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam Nike&nbsp;c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM</p>

<p>✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 1, 1, CAST(N'2023-12-08T16:06:52.010' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (13, N'Nike 03', 2, 2, 7, 6000000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam</p>

<p>**Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa.&nbsp;</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 0, CAST(N'2023-12-08T16:07:44.043' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (14, N'Nike 04', 1, 2, 7, 1500000, N'<p>𝙏𝙝𝙤̂𝙣𝙜 𝙩𝙞𝙣 𝙨𝙖̉𝙣 𝙥𝙝𝙖̂̉𝙢:</p>

<p>- Chất lượng tốt nhất trong tầm gi&aacute;</p>

<p>- Form đẹp chuẩn : M&agrave;u sắc giống đến 98 &deg;/ₒ ;</p>

<p>- Chất liệu da + da lộn + vải mesh</p>

<p>- Logo in dập ch&igrave;m.</p>

<p>- Lưỡi g&agrave; cao d&agrave;y dặn; swoosh sắc n&eacute;t; M&ocirc;ng mũi l&agrave;m đẹp</p>

<p>- Đế 2 lớp kh&acirc;u chỉ đều</p>

<p>- Full box + accessories</p>

<p>&bull; Mẫu n&agrave;y bạn mang đ&uacute;ng hoặc up 1 size đối với ch&acirc;n b&egrave;</p>

<p>&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;&bull;</p>

<p>🔥shopgiaykiencuong🔥 k&iacute;nh ch&agrave;o qu&yacute; kh&aacute;ch</p>

<p>𝘾𝘼𝙈 𝙆𝙀̂́𝙏 𝙑𝙊̛́𝙄 𝙆𝙃𝘼́𝘾𝙃 𝙃𝘼̀𝙉𝙂 VỀ SẢN PHẨM</p>

<p>- Sản phẩm 100% giống với m&ocirc; tả.</p>

<p>- Giao h&agrave;ng đ&uacute;ng size, lỗi 1 đổi 1.</p>

<p>- Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc theo h&igrave;nh thức COD, v&iacute; Airpay, internet banking,...</p>

<p>❌𝙇𝙪̛𝙪 𝙮́ 𝙆𝙝𝙞 𝙠𝙝𝙖́𝙘𝙝 𝙣𝙝𝙖̣̂𝙣 𝙝𝙖̀𝙣𝙜:</p>

<p>✅Bao kiểm tra h&agrave;ng trước thanh to&aacute;n (Gọi cho shop theo hotline nếu bưu t&aacute; kh&ocirc;ng cho kiểm)</p>

<p>✅Hỗ trợ đổi size nếu kh&aacute;ch đặt nhầm size gi&agrave;y, lỗi nh&agrave; sản xuất</p>

<p>✅ Tất cả c&aacute;c sản phẩm đ&atilde; được chọn lựa kỹ trước khi cung cấp cho kh&aacute;ch h&agrave;ng</p>

<p>✅ Sản phẩm bao gồm đầy đủ : hộp, tag, giấy g&oacute;i v&agrave; phụ kiện.</p>
', 1, 1, CAST(N'2023-12-08T16:09:05.800' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (15, N'Nike 05', 2, 2, 7, 2000000, N'<p>Với 3 loại Nike&nbsp;: g&oacute;t đen trắng, phản quang v&agrave; g&oacute;t hoa c&uacute;c.</p>

<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong ch&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2023 nay, h&agrave;ng da, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ. Gồm Nike&nbsp;g&oacute;t đen trắng v&agrave; Nike&nbsp;hoa c&uacute;c</p>

<p>-Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy mc bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao Nike&nbsp;nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-12-08T16:10:07.037' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (16, N'Nike 06', 4, 2, 7, 7680000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : Nike&nbsp;</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>K&iacute;ch Thước : Size Nam v&agrave; Nữ đa dạng</p>

<p>M&agrave;u Sắc : đa dạng</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp</p>

<p>Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 1, 1, CAST(N'2023-12-11T10:43:05.857' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (17, N'Nike 07', 2, 2, 7, 567000, N'<p>🐾 Size: đa dạng</p>

<p>⚡️ Tất cả sản phẩm của Shop đều cam kết Full Box, đ&oacute;ng g&oacute;i cẩn thận nhằm mang lại cho kh&aacute;ch h&agrave;ng trải nghiệm mua sắm online an t&acirc;m nhất!</p>

<p>&nbsp; &nbsp; &nbsp; (Ngoại trừ c&aacute;c đợt sale gi&aacute; sỉ th&igrave; Shop kh&ocirc;ng thể hỗ trợ th&ecirc;m box đc)</p>

<p>👌 Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✨ Lưu &yacute; : H&agrave;ng xưởng về nhiều đợt do shop đặt số lượng lớn ,n&ecirc;n mỗi đợt lưới, logo v&agrave; đế c&oacute; kh&aacute;c nhau. C&aacute;c bạn nhớ xem b&agrave;i viết của shop v&agrave; c&acirc;n nhắc trước khi đặt nh&eacute;.</p>

<p>❗️❗️❗️ Ảnh Shop to&agrave;n bộ đều l&agrave; ảnh thật độc quyền tự chụp, c&aacute;c bạn k&eacute;o qua để xem video v&agrave; c&aacute;c g&oacute;c kh&aacute;c nh&eacute;</p>
', 0, 1, CAST(N'2023-12-08T16:11:28.787' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (18, N'Nike 08', 1, 2, 7, 876000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam</p>

<p>**Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 0, 1, CAST(N'2023-12-08T16:13:08.480' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (19, N'Nike 09', 2, 2, 7, 567000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: đa dạng</p>

<p>+ Size: đa dạng (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

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
', 0, 0, CAST(N'2023-12-08T16:14:13.717' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (20, N'Nike 10', 2, 2, 7, 987000, N'<p>F SHOP LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; Nike&nbsp;</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM Nike&nbsp;</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp )</p>

<p>✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam Nike&nbsp;b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đen trắng v&agrave; x&aacute;m xanh trắng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam Nike&nbsp;c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM</p>

<p>✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 0, 1, CAST(N'2023-12-08T16:15:36.077' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (21, N'Puma 01', 4, 3, 7, 867000, N'<p>SHOP SUS LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; Puma&nbsp;</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM Puma&nbsp;</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp )</p>

<p>✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam Puma&nbsp;b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đen trắng v&agrave; x&aacute;m xanh trắng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam Puma&nbsp;c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM</p>

<p>✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 1, 1, CAST(N'2023-12-08T16:16:48.747' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (22, N'Puma 02', 3, 3, 7, 967000, N'<p>SHOP SUS LU&Ocirc;N CHẮC CHẮN PHỤC VỤ C&Aacute;C BẠN BẰNG T&Acirc;T CẢ NHỮNG G&Igrave; M&Igrave;NH C&Oacute;</p>

<p>🍓 Về sản phẩm: Shop cam kết cả về chất lượng v&agrave; kiểu d&aacute;ng. Sản phẩm giống h&igrave;nh nha c&aacute;c bạn, kh&ocirc;ng phải h&agrave;ng gi&aacute; chợ 100K</p>

<p>🍓 Dịch vụ: Hỗ trợ đổi size nếu c&aacute;c bạn đi kh&ocirc;ng vừa trong v&ograve;ng 7 ng&agrave;y, nhớ giữ sạch sẽ nh&eacute;!</p>

<p>----------------------------------------------</p>

<p>Gi&agrave;y Nam ,Gi&agrave;y Thể Thao Nam đế bằng sneaker phong c&aacute;ch cổ cao si&ecirc;u đẹp m&atilde; Puma&nbsp;</p>

<p>-----------------------------------------------</p>

<p>✔️ C&aacute;c chương tr&igrave;nh khuyến mại bất ngờ cực kỳ hấp dẫn sẽ c&oacute; tại Shop mời bạn ấn theo d&otilde;i để biết th&ecirc;m chi tiết</p>

<p>✔️ FRRESHIP / HỖ TRỢ PH&Iacute; VẬN CHUYỂN ( KH&Aacute;CH KO BIẾT &Aacute;P M&Atilde; VẬN CHUYỂN CHAT / INBOX SHOP TRƯỚC KHI ĐẶT H&Agrave;NG ĐỂ ĐC HƯỚNG DẪN )</p>

<p>💥 TH&Ocirc;NG TIN SẢN PHẨM GI&Agrave;Y NAM Puma&nbsp;</p>

<p>✔️ Đến với Shop bạn ho&agrave;n to&agrave;n c&oacute; thể y&ecirc;n t&acirc;m h&agrave;ng đảm bảo chất lượng, tốt nhất trong tầm gi&aacute;.( kh&ocirc;ng c&oacute; h&agrave;ng lỗi, h&agrave;ng thứ cấp )</p>

<p>✔️ Đế gi&agrave;y được l&agrave;m bằng chất liệu cao su đ&uacute;c nguy&ecirc;n khối chắc chắn c&oacute; khắc họa tiết để tăng độ ma s&aacute;t, chống trơn trượt.</p>

<p>✔️M&agrave;u sắc: Gi&agrave;y nam Puma&nbsp;b&ecirc;n m&igrave;nh c&oacute; phối m&agrave;u đen trắng v&agrave; x&aacute;m xanh trắng</p>

<p>✔️Với phong c&aacute;ch trẻ trung năng động sản phẩm Gi&agrave;y nam JD c&aacute;c bạn c&oacute; thể phối với c&aacute;c loại quần: quần b&ograve;, quần lửng, quần kaki, quần jogger rất đẹp v&agrave; ngầu ạ</p>

<p>💥 HƯỚNG DẪN BẢO QUẢN GI&Agrave;Y THỂ THAO NAM</p>

<p>✔️ Để gi&agrave;y ở nơi kh&ocirc; r&aacute;o tho&aacute;ng m&aacute;t để giữ gi&agrave;y được bền đẹp hơn</p>

<p>✔️ Vệ sinh gi&agrave;y, d&ugrave;ng khăn hay b&agrave;n trải l&ocirc;ng mềm để chải sạch gi&agrave;y c&ugrave;ng với nước tẩy rửa gi&agrave;y chuy&ecirc;n dụng với da hay da Pu</p>

<p>✔️ C&oacute; thể giặt gi&agrave;y c&ugrave;ng với chất tẩy rửa nhẹ</p>

<p>❌ KHUYẾN C&Aacute;O</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng b&agrave;n chải cứng để vệ sinh gi&agrave;y sẽ l&agrave;m hư</p>

<p>⛔ Kh&ocirc;ng đi mưa ng&acirc;m nước l&acirc;u, kh&ocirc;ng phơi gi&agrave;y trực tiếp dưới ngo&agrave;i trời nắng gắt</p>

<p>-------------------------------------------------------------------------</p>
', 1, 1, CAST(N'2023-12-08T16:17:50.473' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (23, N'Puma 03', 3, 3, 7, 934000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6 th&aacute;ng Gi&agrave;y Thể Thao Nam</p>

<p>**Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa.&nbsp;</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 0, CAST(N'2023-12-08T16:18:29.507' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (24, N'Puma 04', 3, 3, 7, 912000, N'<p>▪️ Gi&agrave;y Puma&nbsp;Nam nữ</p>

<p>▪️ Xuất xứ: Việt Nam</p>

<p>▪️ Thương hiệu: Puma&nbsp;</p>

<p>▪️ Chất liệu: Vải Canvas</p>

<p>▪️ Đế: Cao su lưu h&oacute;a</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM</p>

<p>✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc</p>

<p>🎁 G&Oacute;C MUA H&Agrave;NG</p>

<p>✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 1, 1, CAST(N'2023-12-08T16:19:27.153' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (25, N'Puma 05', 3, 3, 7, 856000, N'<p>Chất da mềm &ecirc;m ch&acirc;n, thiết kế da chuẩn kh&ocirc;ng bong ch&oacute;c, đế được kh&acirc;u trong l&ecirc;n rất bền v&agrave; chống trơn trượt.</p>

<p>H&agrave;ng l&agrave; mẫu đang si&ecirc;u h&oacute;t năm 2023 nay, h&agrave;ng da, đế cao su kh&acirc;u chống trơn trượt cực bền.</p>

<p>G&oacute;t rất mượt v&agrave; kh&ocirc;ng bị s&ugrave; Ph&ugrave; hợp mọi lứa tuổi nam nữ</p>

<p>-Shop đảm bảo b&aacute;n h&agrave;ng rẻ nhất nhưng cũng khẳng định về chất lượng l&agrave; tốt nhất. C&aacute;c bạn l&ecirc;n xem qua đ&aacute;nh gi&aacute; về shop để tự tin l&agrave; m&igrave;nh mua h&agrave;ng kh&ocirc;ng bị lừa.(shop kh&ocirc;ng bao giờ b&aacute;n h&agrave;ng k&eacute;m chất lượng).</p>

<p>-Ở Đ&Acirc;U RẺ V&Agrave; ĐẸP HƠN SHOP XIN ĐỀN TIỀN.</p>

<p>-Tuyển CTV to&agrave;n quốc,chế độ v&agrave; cơ chế gi&aacute; hấp dẫn.</p>

<p>-Giầy Phom chuẩn,đi &ocirc;m ch&acirc;n,đế cao su chống trơn trượt.</p>

<p>-Ph&ugrave; hợp với c&aacute;c lứa tuổi nam nữ,dễ kết hợp quần &aacute;o.</p>

<p>-Shop đảm bảo ảnh v&agrave; video l&agrave; thật 100%.</p>

<p>-Hỗ trợ đổi trả h&agrave;ng do lỗi sản xuất,sai m&agrave;u sắc hoặc nhầm size cỡ.</p>

<p>-Tất cả sản phẩm đều được tặng k&egrave;m theo gồm hộp bill v&agrave; d&acirc;y giầy mc bản to.</p>

<p>-H&agrave;ng h&oacute;a 100% xuất sứ tại Việt Nam.</p>

<p>⚡️ Gi&agrave;y thể thao Puma&nbsp;nam nữ ⚡️</p>
', 1, 1, CAST(N'2023-12-08T16:20:37.223' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (26, N'Puma 06', 2, 3, 7, 712000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 1, 1, CAST(N'2023-12-11T10:43:16.653' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (27, N'Puma 07', 3, 3, 7, 536000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: đa dạng</p>

<p>+ Size:&nbsp; (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

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
', 0, 1, CAST(N'2023-12-08T16:21:36.187' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (28, N'Puma 08', 1, 3, 7, 933000, N'<p>▪️Xuất xứ: Việt Nam</p>

<p>▪️Thương hiệu: Puma&nbsp;</p>

<p>▪️Chất liệu: Vải Canvas</p>

<p>▪️Đế: Cao su lưu h&oacute;a&nbsp;</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM</p>

<p>✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc</p>

<p>🎁 G&Oacute;C MUA H&Agrave;NG</p>

<p>✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 0, 1, CAST(N'2023-12-08T16:22:14.763' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (29, N'Puma 09', 3, 3, 7, 655000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: đa dạng</p>

<p>+ Size: c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;</p>

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
', 0, 0, CAST(N'2023-12-08T16:22:38.590' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (30, N'Puma 10', 3, 3, 7, 966000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Mi Bantang, Quận Taijiang Địa chỉ: Mặt tiền cửa h&agrave;ng 17, Tầng 1, T&ograve;a nh&agrave; 1 #, T&ograve;a nh&agrave; Thương mại Liwei, Số 488, Đường Liuyi Middle, Phố Yingzhou, Quận Taijiang, Ph&uacute;c Ch&acirc;u, Ph&uacute;c Kiến, Trung Quốc</p>

<p>- Gi&agrave;y nam thời trang cao cổ g&oacute;t kẻ m&agrave;u c&aacute; t&iacute;nh hot trend 2023</p>

<p>- Với thiết kế phong c&aacute;ch đơn giản , đ&ocirc;i gi&agrave;y thể thao nam c&oacute; những điểm nhấn cực k&igrave; bắt mắt v&agrave; nổi bật khiến người đi nổi bật giữa đ&aacute;m đ&ocirc;ng .</p>

<p>- Chất liệu đế đ&ocirc;i gi&agrave;y nam được l&agrave;m từ cao su tổng hợp gi&uacute;p cho bạn đi cả ng&agrave;y m&agrave; vẫn cảm gi&aacute;c rất &ecirc;m &aacute;i .</p>

<p>- Với kiểu d&aacute;ng trẻ trung hiện đại , chủ nh&acirc;n của đ&ocirc;i gi&agrave;y nam c&oacute; thể phối với bất k&igrave; bộ đồ n&agrave;o trong tủ đồ , để đi chơi dạo phố , đi dự tiệc , đi du lịch picnic .</p>

<p>- Size gi&agrave;y cho tất cả c&aacute;c anh em lựa chọn</p>

<p>- Tất cả c&aacute;c sản phẩm gi&agrave;y b&ecirc;n shop đều c&oacute; l&oacute;t gi&agrave;y tho&aacute;ng kh&iacute; chống h&ocirc;i ch&acirc;n Shop xin CAM KẾT 100% ảnh Gi&agrave;y do Shop tự chụp v&agrave; đ&iacute;nh Logo.</p>

<p>✔️ H&agrave;ng chuẩn 100% - Cam kết đổi trả nếu lỗi từ nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi trả size nếu kh&ocirc;ng vừa</p>

<p>✔️ Kiểu d&aacute;ng &ocirc;m ch&acirc;n, thon gọn, thoải m&aacute;i di chuyển m&agrave; kh&ocirc;ng lo đau ch&acirc;n</p>

<p>✔️ Giao h&agrave;ng tại nh&agrave;, Thanh to&aacute;n tại nh&agrave;, nhanh ch&oacute;ng, tiện dụng&nbsp;</p>

<p>✔️ Gửi kh&aacute;ch xem mẫu gi&agrave;y hiện c&oacute;</p>

<p>✔️ Tư vấn c&aacute;c mẫu gi&agrave;y ph&ugrave; hợp với kh&aacute;ch h&agrave;ng Ch&uacute;ng t&ocirc;i mong muốn bạn hạnh ph&uacute;c khi mua h&agrave;ng!</p>

<p>-----------------------------------------------------</p>
', 0, 1, CAST(N'2023-12-08T16:23:39.827' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (31, N'Reebok 01', 4, 4, 7, 908000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Mi Bantang, Quận Taijiang Địa chỉ: Mặt tiền cửa h&agrave;ng 17, Tầng 1, T&ograve;a nh&agrave; 1 #, T&ograve;a nh&agrave; Thương mại Liwei, Số 488, Đường Liuyi Middle, Phố Yingzhou, Quận Taijiang, Ph&uacute;c Ch&acirc;u, Ph&uacute;c Kiến, Trung Quốc</p>

<p>- Gi&agrave;y nam thời trang cao cổ g&oacute;t kẻ m&agrave;u c&aacute; t&iacute;nh hot trend 2020</p>

<p>- Với thiết kế phong c&aacute;ch đơn giản , đ&ocirc;i gi&agrave;y thể thao nam c&oacute; những điểm nhấn cực k&igrave; bắt mắt v&agrave; nổi bật khiến người đi nổi bật giữa đ&aacute;m đ&ocirc;ng .</p>

<p>- Chất liệu đế đ&ocirc;i gi&agrave;y nam được l&agrave;m từ cao su tổng hợp gi&uacute;p cho bạn đi cả ng&agrave;y m&agrave; vẫn cảm gi&aacute;c rất &ecirc;m &aacute;i .</p>

<p>- Với kiểu d&aacute;ng trẻ trung hiện đại , chủ nh&acirc;n của đ&ocirc;i gi&agrave;y nam c&oacute; thể phối với bất k&igrave; bộ đồ n&agrave;o trong tủ đồ , để đi chơi dạo phố , đi dự tiệc , đi du lịch picnic .</p>

<p>- Size gi&agrave;y cho tất cả c&aacute;c anh em lựa chọn Tất cả c&aacute;c sản phẩm gi&agrave;y b&ecirc;n shop đều c&oacute; l&oacute;t gi&agrave;y tho&aacute;ng kh&iacute; chống h&ocirc;i ch&acirc;n Shop xin CAM KẾT 100% ảnh Gi&agrave;y do Shop tự chụp v&agrave; đ&iacute;nh Logo.</p>

<p>✔️ H&agrave;ng chuẩn 100%&nbsp; - Cam kết đổi trả nếu lỗi từ nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi trả size nếu kh&ocirc;ng vừa</p>

<p>✔️ Kiểu d&aacute;ng &ocirc;m ch&acirc;n, thon gọn, thoải m&aacute;i di chuyển m&agrave; kh&ocirc;ng lo đau ch&acirc;n</p>

<p>✔️ Giao h&agrave;ng tại nh&agrave;, Thanh to&aacute;n tại nh&agrave;, nhanh ch&oacute;ng, tiện dụng</p>

<p>✔️ Gửi kh&aacute;ch xem mẫu gi&agrave;y hiện c&oacute;</p>

<p>✔️ Tư vấn c&aacute;c mẫu gi&agrave;y ph&ugrave; hợp với kh&aacute;ch h&agrave;ng Ch&uacute;ng t&ocirc;i mong muốn bạn hạnh ph&uacute;c khi mua h&agrave;ng!</p>

<p>-----------------------------------------------------</p>
', 1, 1, CAST(N'2023-12-08T16:37:08.407' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (32, N'Reebok 02', 2, 4, 7, 987000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 1, 1, CAST(N'2023-12-08T16:37:42.497' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (33, N'Reebok 03', 4, 4, 7, 6785430, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6 th&aacute;ng Gi&agrave;y Thể Thao Nam</p>

<p>**Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 0, CAST(N'2023-12-08T16:38:49.907' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (34, N'Reebok 04', 4, 4, 7, 789500, N'<p>- Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>- Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam</p>

<p>- Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6 th&aacute;ng Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa.&nbsp;</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 1, CAST(N'2023-12-08T16:39:56.670' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (35, N'Reebok 05', 1, 4, 7, 876000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : Reebok&nbsp;</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>M&agrave;u Sắc : đa dạng</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 1, 1, CAST(N'2023-12-10T21:58:41.383' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (36, N'Reebok 06', 4, 4, 7, 654000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : No Brand</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>M&agrave;u Sắc v&agrave; K&iacute;ch Thước đa dạng</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 1, 1, CAST(N'2023-12-11T10:43:30.447' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (37, N'Reebok 07', 3, 4, 7, 567000, N'<p>🐾 Size v&agrave; m&agrave;u sắc đa dạng</p>

<p>⚡️ Tất cả sản phẩm của Shop đều cam kết Full Box, đ&oacute;ng g&oacute;i cẩn thận nhằm mang lại cho kh&aacute;ch h&agrave;ng trải nghiệm mua sắm online an t&acirc;m nhất! (Ngoại trừ c&aacute;c đợt sale gi&aacute; sỉ th&igrave; Shop kh&ocirc;ng thể hỗ trợ th&ecirc;m box đc)</p>

<p>👌 Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✨ Lưu &yacute; : H&agrave;ng xưởng về nhiều đợt do shop đặt số lượng lớn ,n&ecirc;n mỗi đợt lưới, logo v&agrave; đế c&oacute; kh&aacute;c nhau. C&aacute;c bạn nhớ xem b&agrave;i viết của shop v&agrave; c&acirc;n nhắc trước khi đặt nh&eacute;.</p>

<p>❗️❗️❗️ Ảnh Shop to&agrave;n bộ đều l&agrave; ảnh thật độc quyền tự chụp, c&aacute;c bạn k&eacute;o qua để xem video v&agrave; c&aacute;c g&oacute;c kh&aacute;c nh&eacute;</p>
', 0, 1, CAST(N'2023-12-08T16:41:27.110' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (38, N'Reebok 08', 4, 4, 7, 678900, N'<p>Gi&agrave;y Reebok&nbsp;Nam nữ&nbsp;</p>

<p>▪️Xuất xứ: Việt Nam</p>

<p>▪️Thương hiệu: Reebok&nbsp;</p>

<p>▪️Chất liệu: Vải Canvas</p>

<p>▪️Đế: Cao su lưu h&oacute;a&nbsp;</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM</p>

<p>✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc</p>

<p>🎁 G&Oacute;C MUA H&Agrave;NG</p>

<p>✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 0, 1, CAST(N'2023-12-08T16:42:13.583' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (39, N'Reebok 09', 4, 4, 7, 666000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: đa dạng</p>

<p>+ Size c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;</p>

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
', 0, 0, CAST(N'2023-12-08T16:42:52.750' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (40, N'Reebok 10', 3, 4, 7, 999000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 0, 1, CAST(N'2023-12-08T16:43:15.927' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (41, N'New Balance 01', 2, 5, 7, 222000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : New Balance</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>K&iacute;ch Thước : Size Nam: đa dạng</p>

<p>M&agrave;u Sắc : đa dạng</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp</p>

<p>Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 1, 1, CAST(N'2023-12-08T15:31:57.757' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (42, N'New Balance 02', 3, 5, 7, 666000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 1, 1, CAST(N'2023-12-08T15:32:51.537' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (43, N'New Balance 03', 2, 5, 7, 999000, N'<p>Sản xuất bởi Xưởng gi&agrave;y Wangdu Honglu Shoes Co., Ltd. Địa chỉ: Số 393, Hanzhuang Village, Wangdu Town, Quận Wangdu, Th&agrave;nh phố Bảo Định, H&agrave; Bắc, Trung Quốc.</p>

<p>Th&ocirc;ng Tin Sản Phẩm : Gi&agrave;y Thể Thao Nam - ABUUU ghi v&agrave; đen Xuất Xứ: Trung Quốc</p>

<p>✔️ Đế gi&agrave;y được thiết kế chịu ma s&aacute;t tốt, , nhẹ, &ecirc;m, c&acirc;n bằng v&agrave; tho&aacute;ng kh&iacute;</p>

<p>✔️ Kiểu d&aacute;ng hottrend của năm nay.</p>

<p>✔️ Gi&agrave;y đẹp, nhẹ, bền. C&oacute; thể l&agrave;m gi&agrave;y cặp, gi&agrave;y nh&oacute;m. Th&iacute;ch hợp đi chơi, chạy bộ, gym, đi học, đi l&agrave;m...</p>

<p>✔️ C&oacute; thể kết hợp Đồ, jeans, sooc, Ngố vv&hellip;. Đều ph&ugrave; hợp</p>

<p>🎁 CAM KẾT:</p>

<p>✔️Thanh to&aacute;n khi nhận h&agrave;ng</p>

<p>✔️Bảo H&agrave;nh: 6t Gi&agrave;y Thể Thao Nam</p>

<p>**Lưu &yacute; : Shop Chỉ Bảo H&agrave;nh Cho Những Sản Phẩm Lỗi Do Nh&agrave; Sản Xuất-</p>

<p>✔️ Ho&agrave;n tiền 100% nếu nhận sản phẩm kh&ocirc;ng giống h&igrave;nh</p>

<p>✔️ Đổi ngay h&agrave;ng mới nếu nhận h&agrave;ng bị lỗi, hỏng từ ph&iacute;a nh&agrave; sản xuất</p>

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 0, CAST(N'2023-12-08T15:34:06.310' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (44, N'New Balance 04', 3, 5, 7, 777000, N'<p>Lưu &yacute;: L&ocirc; sản xuất n&agrave;y size của nam form hơi nhỏ n&ecirc;n c&aacute;c bạn nh&iacute;ch một size l&ecirc;n hoặc inbox shop tư vấn ak. Xin cảm ơn Chi tiết sản phẩm</p>

<p>CAM KẾT: HÀNG CHUẨN 100%</p>

<p> HÀNG XƯỞNG TRỰC TIẾP SẢN XUẤT NÊN GIÁ SIÊU RẺ, XẢ LẺ SIZE NÊN GIÁ RẺ HƠN CẢ SỈ</p>

<p>HÌNH THẬT 100% SHOP TỰ CHỤP TỰ QUAY, hỗ trợ đổi trả khi có lỗi ❤️❤️❤️</p>

<p>Kiểu dáng ôm chân, thon gọn, thoải mái di chuyển không lo đau chân</p>

<p> Chất liệu vải mesh thấm mồ h&ocirc;i, vật liệu để tạo ra đế giữa l&agrave; EVA (ethylene vinyl acetate) v&agrave; PU (polyurethane)</p>

<p>Có hộp đựng ( Do trong quá trình vận chuyển không thể tránh khỏi hộp bị móp méo nhưng hộp không quan trọng, chủ yếu chất lượng sản phẩm khách nhé) do để tiếp kiệm chi ph&iacute; cho kh&aacute;ch n&ecirc;n shop đ&oacute;ng h&agrave;ng bằng hộp cartton th&ocirc;ng thường.</p>

<p> Hotline: Sỉ lẻ li&ecirc;n hệ 096184xxx5 để li&ecirc;n hệ chi tiết nh&eacute; kh&aacute;ch y&ecirc;u.</p>
', 1, 1, CAST(N'2023-12-08T15:34:34.620' AS DateTime), 0)
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

<p>✔️ Hỗ trợ đổi h&agrave;ng nếu c&aacute;c bạn đi kh&ocirc;ng vừa.</p>

<p>🎁 LỜI MUỐN N&Oacute;I! Nhận gi&agrave;y xong mong c&aacute;c bạn sẽ c&oacute; những phản hồi t&iacute;ch cực như Feedback h&igrave;nh ảnh hoặc đ&aacute;nh gi&aacute; 5 sao nếu cảm thấy OK. Mọi vấn đề bạn chưa vừa long xin h&atilde;y inbox để được hỗ trợ trước khi đ&aacute;nh gi&aacute; nh&eacute;. Cảm ơn bạn đ&atilde; đặt gi&agrave;y. Đừng qu&ecirc;n nhấn theo d&otilde;i nha! Gi&agrave;y Nhập Khẩu lu&ocirc;n dẫn đầu trong việc đ&aacute;p ứng nhanh ch&oacute;ng những tr&agrave;o lưu xu hướng thời trang mới nhất ch&acirc;u &Aacute;. mang đến l&agrave;n gi&oacute; mới với xu hướng thời trang năng động, hiện đại v&agrave; c&aacute; t&iacute;nh. Ch&uacute;ng t&ocirc;i li&ecirc;n tục đổi mới ch&iacute;nh m&igrave;nh v&agrave; cam kết lu&ocirc;n cập nhật những mẫu mới nhất để đ&aacute;p ứng nhu cầu v&agrave; l&agrave;m h&agrave;i l&ograve;ng tất cả kh&aacute;ch h&agrave;ng th&acirc;n thiết của Gi&agrave;y Nhập Khẩu</p>
', 1, 1, CAST(N'2023-12-08T16:01:54.173' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (46, N'New Balance 06', 1, 5, 7, 567000, N'<p>GIỚI THIỆU SẢN PHẨM Thương hiệu : No Brand</p>

<p>Xuất Xứ: Trung Quốc</p>

<p>K&iacute;ch Thước : Size Nam: 39 - 40 - 41 - 42 - 43</p>

<p>M&agrave;u Sắc : Đen trắng, Đen Full</p>

<p>Chất Liệu : vải sợi tho&aacute;ng kh&iacute; cao cấp bền đẹp Đế gi&agrave;y: Đế được l&agrave;m từ cao su gi&uacute;p gi&agrave;y th&ecirc;m bền đẹp hợp &ecirc;m ch&acirc;n, thoải m&aacute;i khi di chuyển Mix đồ cực k&igrave; chất Th&iacute;ch hợp đi chơi, dạo phố, đi dạo&hellip;..</p>

<p>Kiểu d&aacute;ng phong c&aacute;ch</p>

<p>&bull; Độ bền cao</p>

<p>&bull; Dễ phối đồ</p>

<p>Thanh to&aacute;n khi nhận h&agrave;ng Gi&aacute; si&ecirc;u rẻ khi mua tại shop nh&eacute; c&aacute;c bạn</p>
', 1, 1, CAST(N'2023-12-11T10:43:44.187' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (47, N'New Balance 07', 2, 5, 7, 8979000, N'<p>New Balance - Phi&ecirc;n bản giới hạn mang mục đ&iacute;ch bảo vệ m&ocirc;i trường sẽ được ch&iacute;nh thức mở b&aacute;n tại hệ thống New Balance VN từ ng&agrave;y 5/7 với số lượng giới hạn.</p>
', 1, 1, CAST(N'2023-12-08T16:00:55.107' AS DateTime), 1)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (48, N'New Balance 08', 1, 5, 7, 8789000, N'<p>Gi&agrave;y New Balance Nam nữ</p>

<p>▪️Xuất xứ: Việt Nam</p>

<p>▪️Thương hiệu: New Balance</p>

<p>▪️Chất liệu: Vải Canvas</p>

<p>▪️Đế: Cao su lưu h&oacute;a&nbsp;</p>

<p>⭐️ CAM KẾT V&Agrave; BẢO ĐẢM</p>

<p>✔CAM KẾT: H&Igrave;NH CHỤP THẬT 100% SẢN PHẨM</p>

<p>✔ CAM KẾT: Gi&agrave;y đ&uacute;ng như h&igrave;nh, kh&ocirc;ng đ&uacute;ng tặng miễn ph&iacute; lu&ocirc;n đ&ocirc;i gi&agrave;y.</p>

<p>✔Mang kh&ocirc;ng vừa đổi size trong v&ograve;ng 1 tuần 🚚 Thanh to&aacute;n khi nhận h&agrave;ng - Ship COD si&ecirc;u tốc to&agrave;n quốc</p>

<p>❌ KHUYẾN C&Aacute;O ❌</p>

<p>Với bất kỳ 1 đ&ocirc;i GI&Agrave;Y THỂ THAO NAM n&agrave;o bạn đều l&ecirc;n hạn chế để gi&agrave;y bị tiếp x&uacute;c trực tiếp với nhiệt độ n&oacute;ng v&agrave; ng&acirc;m nước mưa l&acirc;u khi phơi gi&agrave;y, bạn n&ecirc;n d&ugrave;ng giấy vệ sinh bao bọc bề mặt gi&agrave;y</p>

<p>⛔ Kh&ocirc;ng d&ugrave;ng h&oacute;a chất hay bột giặt c&oacute; hoạt t&iacute;nh tẩy rửa mạnh</p>

<p>💥 Shop cam kết:</p>

<p>✔ Sản phẩm chuẩn 100% như h&igrave;nh</p>

<p>✔ Giao h&agrave;ng tr&ecirc;n to&agrave;n quốc</p>

<p>🎁 G&Oacute;C MUA H&Agrave;NG</p>

<p>✔ Kh&aacute;ch chọn nhiều size v&agrave;o 1 đơn h&agrave;ng bằng c&aacute;ch chọn từng size v&agrave; bấm th&ecirc;m v&agrave;o giỏ h&agrave;ng, sau đ&oacute; l&agrave;m đầy đủ c&aacute;c bước tiếp theo, tới l&uacute;c thấy t&igrave;nh trạng đơn h&agrave;ng &quot;chờ x&aacute;c nhận&quot; l&agrave; kh&aacute;ch đ&atilde; đặt h&agrave;ng th&agrave;nh c&ocirc;ng.</p>

<p> Hotline: 09855xxx54</p>

<p>- - - - - - - - - - - - - - - -</p>
', 0, 0, CAST(N'2023-12-08T15:59:41.817' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (49, N'New Balance 09', 1, 5, 7, 6543000, N'<p>- TH&Ocirc;NG TIN SẢN PHẨM:</p>

<p>+ Chất liệu gi&agrave;y: da sần, da trơn nhẵn.</p>

<p>+ M&agrave;u: đa dạng</p>

<p>+ Size: tđa dạng (c&aacute;c bạn tham khảo th&ecirc;m bảng size để chọn được một đ&ocirc;i gi&agrave;y ưng &yacute; nhất nh&eacute;)</p>

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
', 0, 0, CAST(N'2023-12-08T16:04:20.720' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (50, N'New Balance 10', 5, 5, 7, 2098908, N'<p>New Balance 1970s l&agrave; 1 trong những d&ograve;ng sản phẩm b&aacute;n chạy nhất của New Balance.Phần đế m&agrave;u trắng ng&agrave; vintage được phủ 1 lớp b&oacute;ng b&ecirc;n ngoài là đi&ecirc;̉m nh&acirc;́n ri&ecirc;ng cho dòng 1970s, dễ vệ sinh hơn.</p>
', 0, 1, CAST(N'2023-12-08T16:03:36.977' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (53, N'Vans 01', 1, 17, 7, 500000, N'<p>Chiếc gi&agrave;y mang t&iacute;nh biểu tượng đ&atilde; mang lại sức sống cho sọc ngang của ch&uacute;ng t&ocirc;i: Đ&acirc;y l&agrave; Old Skool</p>

<p>Old Skool l&agrave; thiết kế gi&agrave;y d&eacute;p đầu ti&ecirc;n của ch&uacute;ng t&ocirc;i giới thiệu Vans Sidestripe nổi tiếng&mdash;mặc d&ugrave; hồi đ&oacute;, n&oacute; chỉ l&agrave; một bức vẽ nguệch ngoạc đơn giản được vẽ bởi người s&aacute;ng lập Paul Van Doren. Kể từ khi ra mắt lần đầu ti&ecirc;n v&agrave;o năm 1977, mẫu gi&agrave;y cổ thấp n&agrave;y đ&atilde; trở th&agrave;nh một biểu tượng trong giới trượt băng, &acirc;m nhạc v&agrave; thời trang. Từ những vận động vi&ecirc;n trượt v&aacute;n đường phố v&agrave; những người chơi nhạc punk đến những huyền thoại thời trang v&agrave; hip hop hiện tại, Old Skool lu&ocirc;n l&agrave; đ&ocirc;i gi&agrave;y ph&ugrave; hợp cho những nh&agrave; s&aacute;ng tạo l&agrave;m mọi việc theo c&aacute;ch ri&ecirc;ng của họ. Gi&agrave;y Old Skool Cosy Hug Sherpa khiến cuộc h&agrave;nh tr&igrave;nh trở n&ecirc;n thoải m&aacute;i hơn.</p>

<p>Gi&agrave;y cổ thấp mang t&iacute;nh biểu tượng, Sidestripe&trade;<br />
Mũ da lộn bền<br />
Lớp l&oacute;t ấm c&uacute;ng<br />
Đ&oacute;ng cửa bằng d&acirc;y buộc<br />
Mũ ng&oacute;n ch&acirc;n được gia cố<br />
V&ograve;ng cổ c&oacute; đệm hỗ trợ<br />
Đế ngo&agrave;i b&aacute;nh quế cao su đặc trưng<br />
Cổ điển Old Skool&trade;</p>
', 1, 0, CAST(N'2023-12-11T10:44:00.137' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (54, N'Vans 02', 3, 17, 7, 479999, N'<p>Logo &ldquo;Flying V&rdquo; nổi bật tạo n&ecirc;n thương hiệu cho đ&ocirc;i gi&agrave;y thoải m&aacute;i lấy cảm hứng từ thập ni&ecirc;n 80 n&agrave;y</p>

<p>Lowland ComfyCush l&agrave; h&igrave;nh b&oacute;ng Vans lưu trữ của thập ni&ecirc;n 80 với kiểu d&aacute;ng thanh mảnh v&agrave; đế ngo&agrave;i ComfyCush mang lại sự thoải m&aacute;i hiện đại. Được thiết kế ban đầu cho m&ocirc;n quần vợt v&agrave;o đầu những năm 80 khi Vans đang thử nghiệm những loại gi&agrave;y tập trung v&agrave;o thể thao, kiểu d&aacute;ng cổ thấp n&agrave;y vẫn duy tr&igrave; vẻ ngo&agrave;i quen thuộc đồng thời tăng th&ecirc;m sự phấn kh&iacute;ch cho logo Vans &ldquo;Flying V&rdquo; di sản của ch&uacute;ng t&ocirc;i.</p>

<p>H&igrave;nh b&oacute;ng lấy cảm hứng từ kho lưu trữ thập ni&ecirc;n 80<br />
Cấu h&igrave;nh mỏng, thấp<br />
Mũ gi&agrave;y bằng da, dệt v&agrave; tổng hợp<br />
Đ&oacute;ng cửa bằng d&acirc;y buộc<br />
Đế ngo&agrave;i ComfyCush&trade;<br />
Logo &ldquo;Flying V&rdquo; di sản<br />
Nh&atilde;n lưỡi b&oacute;ng bẩy<br />
V&ograve;ng cổ c&oacute; đệm hỗ trợ<br />
Ch&uacute;ng t&ocirc;i khuy&ecirc;n bạn n&ecirc;n tăng k&iacute;ch thước dựa tr&ecirc;n đ&aacute;nh gi&aacute; của kh&aacute;ch h&agrave;ng.</p>
', 1, 0, CAST(N'2023-12-11T10:44:19.417' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (55, N'Vans 03', 2, 17, 7, 799000, N'<p>Gi&agrave;y Slip-On đ&atilde; tạo n&ecirc;n xu hướng từ năm 1979</p>

<p>Bộ sưu tập L&yacute; thuyết M&agrave;u sắc cho ph&eacute;p bạn tạo ra một c&acirc;u chuyện m&agrave;u sắc độc đ&aacute;o bằng c&aacute;ch kết hợp c&aacute;c m&agrave;u sắc rực rỡ, bất ngờ với c&aacute;c kiểu gi&agrave;y mang t&iacute;nh biểu tượng của ch&uacute;ng t&ocirc;i. Được l&agrave;m bằng vải canvas cổ điển ph&iacute;a tr&ecirc;n, Color Theory Checkerboard Classic Slip-On t&ocirc;n vinh h&igrave;nh d&aacute;ng kh&ocirc;ng d&acirc;y huyền thoại của ch&uacute;ng t&ocirc;i đồng thời mang đến vẻ ngo&agrave;i mới mẻ gi&uacute;p tăng sức hấp dẫn của đ&ocirc;i gi&agrave;y dễ mang n&agrave;y.</p>

<p>Gi&agrave;y Slip-On mang t&iacute;nh biểu tượng<br />
Mũ vải c&oacute; cấu h&igrave;nh thấp<br />
In h&igrave;nh b&agrave;n cờ cổ điển<br />
L&yacute; thuyết m&agrave;u sắc Đường m&agrave;u theo m&ugrave;a<br />
V&ograve;ng cổ c&oacute; đệm hỗ trợ<br />
Điểm nhấn b&ecirc;n đ&agrave;n hồi<br />
Đế ngo&agrave;i b&aacute;nh quế cao su đặc trưng</p>
', 1, 0, CAST(N'2023-12-11T10:44:50.170' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (56, N'Vans 04', 1, 17, 7, 400000, N'<p>Gi&agrave;y Slip-On đ&atilde; tạo n&ecirc;n xu hướng từ năm 1979</p>

<p>Điều đầu ti&ecirc;n nổi bật l&agrave; m&agrave;u sắc. V&acirc;ng, ch&iacute;nh x&aacute;c l&agrave; thiếu m&agrave;u sắc. Ai biết được rằng m&agrave;u đen v&agrave; thiếc c&oacute; thể tạo n&ecirc;n sự kết hợp bắt mắt như vậy? Đ&ocirc;i gi&agrave;y Checkerboard Slip-On cổ điển n&agrave;y thực hiện c&aacute;c quy tắc phối hợp v&agrave; thận trọng trước gi&oacute;. Vans tập trung ho&agrave;n to&agrave;n v&agrave;o quan điểm &ldquo;Off The Wall&rdquo;, v&agrave; chiếc b&agrave;n cờ Slip-On n&agrave;y l&agrave; định nghĩa từ điển về c&aacute;ch tiếp cận đ&oacute;. Mũ gi&agrave;y bằng vải canvas c&oacute; cấu h&igrave;nh thấp, cổ gi&agrave;y c&oacute; đệm hỗ trợ v&agrave; c&aacute;c điểm nhấn b&ecirc;n h&ocirc;ng co gi&atilde;n đảm bảo độ vừa vặn thoải m&aacute;i, ph&ugrave; hợp với lớp ho&agrave;n thiện ca r&ocirc; m&agrave;u đen v&agrave; thiếc tinh xảo dễ d&agrave;ng thực hiện. C&oacute; rất nhiều loại gi&agrave;y Slip-On tr&ecirc;n thị trường, nhưng những đ&ocirc;i gi&agrave;y Slip-On Classic c4heckerboard n&agrave;y lại g&acirc;y ấn tượng kh&aacute;c biệt.</p>

<p>Gi&agrave;y Slip-On mang t&iacute;nh biểu tượng<br />
Mũ vải c&oacute; cấu h&igrave;nh thấp<br />
In h&igrave;nh b&agrave;n cờ cổ điển<br />
V&ograve;ng cổ c&oacute; đệm hỗ trợ<br />
Điểm nhấn b&ecirc;n đ&agrave;n hồi<br />
Đế ngo&agrave;i b&aacute;nh quế cao su đặc trưng</p>
', 1, 0, CAST(N'2023-12-11T10:44:26.693' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (57, N'Vans 05', 2, 17, 7, 900000, N'<p>Gi&agrave;y Slip-On đ&atilde; tạo n&ecirc;n xu hướng từ năm 1979</p>

<p>Bộ sưu tập L&yacute; thuyết M&agrave;u sắc cho ph&eacute;p bạn tạo ra một c&acirc;u chuyện m&agrave;u sắc độc đ&aacute;o bằng c&aacute;ch kết hợp c&aacute;c m&agrave;u sắc rực rỡ, bất ngờ với c&aacute;c kiểu gi&agrave;y mang t&iacute;nh biểu tượng của ch&uacute;ng t&ocirc;i. Được l&agrave;m bằng vải canvas cổ điển ph&iacute;a tr&ecirc;n, Color Theory Checkerboard Classic Slip-On t&ocirc;n vinh h&igrave;nh d&aacute;ng kh&ocirc;ng d&acirc;y huyền thoại của ch&uacute;ng t&ocirc;i đồng thời mang đến vẻ ngo&agrave;i mới mẻ gi&uacute;p tăng sức hấp dẫn của đ&ocirc;i gi&agrave;y dễ mang n&agrave;y.</p>

<p>Gi&agrave;y Slip-On mang t&iacute;nh biểu tượng<br />
Mũ vải c&oacute; cấu h&igrave;nh thấp<br />
In h&igrave;nh b&agrave;n cờ cổ điển<br />
L&yacute; thuyết m&agrave;u sắc Đường m&agrave;u theo m&ugrave;a<br />
V&ograve;ng cổ c&oacute; đệm hỗ trợ<br />
Điểm nhấn b&ecirc;n đ&agrave;n hồi<br />
Đế ngo&agrave;i b&aacute;nh quế cao su đặc trưng</p>
', 1, 0, CAST(N'2023-12-11T10:45:04.783' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (58, N'Vans 06', 3, 17, 7, 1200000, N'<p>Gi&agrave;y Slip-On đ&atilde; tạo n&ecirc;n xu hướng từ năm 1979</p>

<p>Bộ sưu tập L&yacute; thuyết M&agrave;u sắc cho ph&eacute;p bạn tạo ra một c&acirc;u chuyện m&agrave;u sắc độc đ&aacute;o bằng c&aacute;ch kết hợp c&aacute;c m&agrave;u sắc rực rỡ, bất ngờ với c&aacute;c kiểu gi&agrave;y mang t&iacute;nh biểu tượng của ch&uacute;ng t&ocirc;i. Được l&agrave;m bằng vải canvas cổ điển ph&iacute;a tr&ecirc;n, Color Theory Checkerboard Classic Slip-On t&ocirc;n vinh h&igrave;nh d&aacute;ng kh&ocirc;ng d&acirc;y huyền thoại của ch&uacute;ng t&ocirc;i đồng thời mang đến vẻ ngo&agrave;i mới mẻ gi&uacute;p tăng sức hấp dẫn của đ&ocirc;i gi&agrave;y dễ mang n&agrave;y.</p>

<p>Gi&agrave;y Slip-On mang t&iacute;nh biểu tượng<br />
Mũ vải c&oacute; cấu h&igrave;nh thấp<br />
In h&igrave;nh b&agrave;n cờ cổ điển<br />
L&yacute; thuyết m&agrave;u sắc Đường m&agrave;u theo m&ugrave;a<br />
V&ograve;ng cổ c&oacute; đệm hỗ trợ<br />
Điểm nhấn b&ecirc;n đ&agrave;n hồi<br />
Đế ngo&agrave;i b&aacute;nh quế cao su đặc trưng</p>
', 1, 0, CAST(N'2023-12-11T10:44:34.670' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[product] OFF
GO
SET IDENTITY_INSERT [dbo].[product_detail] ON 

INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (1, 1, 3, 1, 55, 0, CAST(N'2023-12-11T10:33:47.913' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (2, 2, 12, 3, 50, 0, CAST(N'2022-02-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (3, 3, 1, 5, 50, 0, CAST(N'2023-06-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (4, 4, 3, 1, 50, 0, CAST(N'2020-08-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (5, 5, 1, 4, 50, 0, CAST(N'2019-09-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (6, 6, 2, 1, 44, 0, CAST(N'2023-12-11T09:57:36.057' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (7, 7, 2, 5, 50, 0, CAST(N'2023-12-11T10:00:06.073' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (8, 8, 2, 8, 20, 0, CAST(N'2023-12-11T10:01:59.603' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (9, 9, 2, 1, 49, 0, CAST(N'2023-12-11T10:04:26.217' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (10, 10, 2, 4, 50, 0, CAST(N'2023-12-11T10:05:37.970' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (12, 1, 11, 8, 50, 0, CAST(N'2023-10-25T19:26:08.207' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (13, 1, 10, 8, 51, 0, CAST(N'2023-10-28T20:41:13.377' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (14, 11, 1, 10, 50, 0, CAST(N'2023-12-11T10:26:50.707' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (15, 11, 3, 5, 48, 0, CAST(N'2023-12-11T10:27:11.417' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (16, 12, 12, 1, 50, 0, CAST(N'2023-12-11T10:27:42.090' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (17, 12, 2, 11, 48, 0, CAST(N'2023-12-11T10:28:02.473' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (18, 13, 4, 8, 50, 0, CAST(N'2023-12-11T10:28:28.543' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (19, 13, 6, 1, 49, 0, CAST(N'2023-12-11T10:28:39.487' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (20, 14, 4, 3, 50, 0, CAST(N'2023-12-11T10:29:28.827' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (21, 14, 4, 8, 50, 0, CAST(N'2023-12-11T10:29:06.540' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (22, 15, 4, 1, 50, 0, CAST(N'2023-12-11T10:29:49.960' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (23, 15, 4, 8, 49, 0, CAST(N'2023-12-11T10:29:59.750' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (24, 21, 4, 3, 50, 0, CAST(N'2023-11-21T16:11:05.667' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (25, 21, 4, 8, 47, 0, CAST(N'2023-12-11T10:31:04.793' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (26, 22, 3, 1, 50, 0, CAST(N'2023-12-11T10:31:36.810' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (27, 22, 9, 12, 50, 0, CAST(N'2023-12-11T10:31:56.167' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (28, 23, 2, 7, 47, 0, CAST(N'2023-12-11T10:32:13.547' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (29, 23, 5, 1, 48, 0, CAST(N'2023-12-11T10:32:24.327' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (30, 24, 5, 1, 50, 0, CAST(N'2023-12-11T10:32:38.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (32, 25, 1, 2, 42, 0, CAST(N'2023-12-11T10:33:30.010' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (33, 31, 2, 8, 50, 0, CAST(N'2023-12-11T10:35:37.497' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (34, 31, 3, 1, 50, 0, CAST(N'2023-12-11T10:35:48.257' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (35, 32, 5, 2, 50, 0, CAST(N'2023-12-11T10:36:04.653' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (36, 32, 3, 8, 50, 0, CAST(N'2023-11-21T16:16:27.560' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (37, 33, 3, 5, 44, 0, CAST(N'2023-12-11T10:36:23.107' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (38, 33, 5, 11, 50, 0, CAST(N'2023-12-11T10:36:32.823' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (39, 34, 4, 1, 49, 0, CAST(N'2023-11-21T16:17:15.917' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (40, 34, 3, 8, 50, 0, CAST(N'2023-12-11T10:36:56.967' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (41, 35, 3, 12, 60, 0, CAST(N'2023-12-11T10:37:26.743' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (42, 41, 2, 9, 60, 0, CAST(N'2023-12-11T10:07:33.623' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (43, 42, 1, 1, 50, 0, CAST(N'2023-12-11T10:09:07.133' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (44, 43, 1, 7, 2, 0, CAST(N'2023-12-11T10:10:40.303' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (45, 44, 2, 2, 50, 0, CAST(N'2023-12-11T10:13:20.373' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (46, 45, 3, 8, 10, 0, CAST(N'2023-12-11T10:14:51.797' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (47, 1, 12, 8, 50, 0, CAST(N'2023-12-10T22:16:35.520' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (48, 1, 1, 8, 50, 0, CAST(N'2023-12-10T22:16:51.467' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (49, 1, 2, 8, 50, 0, CAST(N'2023-12-10T22:17:12.630' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (50, 1, 3, 8, 50, 0, CAST(N'2023-12-10T22:18:10.823' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (51, 1, 4, 8, 50, 0, CAST(N'2023-12-10T22:18:23.530' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (52, 1, 5, 8, 50, 0, CAST(N'2023-12-10T22:18:35.397' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (53, 1, 10, 1, 50, 0, CAST(N'2023-12-10T22:19:54.370' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (54, 1, 11, 1, 44, 0, CAST(N'2023-12-10T22:20:30.667' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (55, 1, 12, 1, 50, 0, CAST(N'2023-12-10T22:20:45.810' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (56, 1, 1, 1, 50, 0, CAST(N'2023-12-10T22:21:03.753' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (57, 1, 2, 1, 50, 0, CAST(N'2023-12-10T22:21:16.227' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (58, 1, 3, 1, 50, 0, CAST(N'2023-12-10T22:21:25.080' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (59, 1, 12, 3, 50, 0, CAST(N'2023-12-10T22:22:19.700' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (60, 1, 1, 3, 50, 0, CAST(N'2023-12-10T22:22:41.113' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (61, 1, 2, 3, 50, 0, CAST(N'2023-12-10T22:22:50.297' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (62, 1, 3, 3, 50, 0, CAST(N'2023-12-10T22:23:01.993' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (63, 2, 1, 3, 50, 0, CAST(N'2023-12-10T22:24:18.527' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (64, 2, 2, 3, 40, 0, CAST(N'2023-12-10T22:24:31.903' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (65, 2, 12, 4, 50, 0, CAST(N'2023-12-11T09:55:28.907' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (66, 2, 1, 4, 50, 0, CAST(N'2023-12-10T22:25:42.660' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (67, 2, 2, 4, 50, 0, CAST(N'2023-12-10T22:25:53.847' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (68, 2, 3, 4, 50, 0, CAST(N'2023-12-10T22:26:10.137' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (69, 2, 3, 1, 50, 0, CAST(N'2023-12-10T22:26:37.463' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (70, 2, 4, 1, 50, 0, CAST(N'2023-12-10T22:26:45.730' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (71, 2, 5, 1, 50, 0, CAST(N'2023-12-10T22:26:55.637' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (72, 2, 13, 1, 50, 0, CAST(N'2023-12-10T22:27:08.087' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (73, 3, 2, 5, 50, 0, CAST(N'2023-12-11T09:44:35.427' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (74, 3, 3, 5, 50, 0, CAST(N'2023-12-11T09:44:46.130' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (75, 3, 4, 5, 50, 0, CAST(N'2023-12-11T09:45:08.317' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (76, 3, 5, 5, 50, 0, CAST(N'2023-12-11T09:45:16.107' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (77, 3, 1, 4, 45, 0, CAST(N'2023-12-11T09:45:41.490' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (78, 3, 2, 4, 50, 0, CAST(N'2023-12-11T09:45:51.337' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (79, 3, 3, 4, 50, 0, CAST(N'2023-12-11T09:45:59.980' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (80, 3, 4, 4, 50, 0, CAST(N'2023-12-11T09:46:09.223' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (81, 3, 5, 4, 50, 0, CAST(N'2023-12-11T09:46:17.483' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (82, 3, 2, 1, 47, 0, CAST(N'2023-12-11T09:46:31.577' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (83, 3, 3, 1, 50, 0, CAST(N'2023-12-11T09:46:39.293' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (84, 3, 4, 1, 50, 0, CAST(N'2023-12-11T09:46:50.620' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (85, 3, 5, 1, 50, 0, CAST(N'2023-12-11T09:47:10.087' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (86, 4, 4, 1, 50, 0, CAST(N'2023-12-11T09:47:50.140' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (87, 4, 5, 1, 50, 0, CAST(N'2023-12-11T09:47:58.117' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (88, 4, 13, 1, 50, 0, CAST(N'2023-12-11T09:48:07.853' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (89, 4, 3, 8, 50, 0, CAST(N'2023-12-11T09:48:26.443' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (90, 4, 4, 8, 49, 0, CAST(N'2023-12-11T09:48:36.520' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (91, 4, 5, 8, 50, 0, CAST(N'2023-12-11T09:55:53.500' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (92, 4, 13, 8, 50, 0, CAST(N'2023-12-11T09:48:58.143' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (93, 5, 2, 4, 50, 0, CAST(N'2023-12-11T09:55:19.037' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (94, 5, 3, 4, 50, 0, CAST(N'2023-12-11T09:50:07.357' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (95, 5, 1, 5, 50, 0, CAST(N'2023-12-11T09:56:43.833' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (96, 5, 2, 5, 50, 0, CAST(N'2023-12-11T09:56:52.997' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (97, 5, 3, 5, 50, 0, CAST(N'2023-12-11T09:57:01.347' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (98, 5, 4, 5, 47, 0, CAST(N'2023-12-11T09:57:14.193' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (99, 6, 3, 1, 50, 0, CAST(N'2023-12-11T09:57:59.920' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (100, 6, 4, 1, 48, 0, CAST(N'2023-12-11T09:58:10.413' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (101, 6, 5, 1, 50, 0, CAST(N'2023-12-11T09:58:22.127' AS DateTime))
GO
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (102, 6, 13, 1, 50, 0, CAST(N'2023-12-11T09:58:30.477' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (103, 6, 2, 8, 50, 0, CAST(N'2023-12-11T09:58:51.680' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (104, 6, 3, 8, 47, 0, CAST(N'2023-12-11T09:59:06.447' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (105, 6, 4, 8, 50, 0, CAST(N'2023-12-11T09:59:17.917' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (106, 6, 5, 8, 50, 0, CAST(N'2023-12-11T09:59:27.360' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (107, 6, 13, 8, 45, 0, CAST(N'2023-12-11T09:59:35.573' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (108, 7, 3, 5, 50, 0, CAST(N'2023-12-11T10:00:15.380' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (109, 7, 4, 5, 39, 0, CAST(N'2023-12-11T10:00:23.937' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (110, 7, 5, 5, 50, 0, CAST(N'2023-12-11T10:00:31.050' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (111, 7, 13, 5, 50, 0, CAST(N'2023-12-11T10:00:39.523' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (112, 7, 2, 8, 50, 0, CAST(N'2023-12-11T10:00:50.747' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (113, 7, 3, 8, 50, 0, CAST(N'2023-12-11T10:00:58.467' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (114, 7, 4, 8, 50, 0, CAST(N'2023-12-11T10:01:08.097' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (115, 7, 5, 8, 50, 0, CAST(N'2023-12-11T10:01:22.277' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (116, 7, 13, 8, 50, 0, CAST(N'2023-12-11T10:01:31.023' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (117, 8, 12, 8, 50, 0, CAST(N'2023-12-11T10:02:11.253' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (118, 8, 1, 8, 46, 0, CAST(N'2023-12-11T10:02:18.847' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (119, 8, 3, 8, 50, 0, CAST(N'2023-12-11T10:02:41.483' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (120, 8, 4, 8, 50, 0, CAST(N'2023-12-11T10:02:49.410' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (121, 8, 2, 1, 50, 0, CAST(N'2023-12-11T10:03:20.090' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (122, 8, 3, 1, 50, 0, CAST(N'2023-12-11T10:03:27.687' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (123, 8, 4, 1, 50, 0, CAST(N'2023-12-11T10:03:36.247' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (124, 8, 5, 1, 50, 0, CAST(N'2023-12-11T10:03:52.347' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (125, 8, 13, 1, 50, 0, CAST(N'2023-12-11T10:04:01.520' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (126, 9, 3, 1, 50, 0, CAST(N'2023-12-11T10:04:35.590' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (127, 9, 4, 1, 50, 0, CAST(N'2023-12-11T10:04:44.423' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (128, 9, 2, 8, 50, 0, CAST(N'2023-12-11T10:04:56.360' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (129, 9, 3, 8, 43, 0, CAST(N'2023-12-11T10:05:04.313' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (130, 9, 4, 8, 49, 0, CAST(N'2023-12-11T10:05:10.290' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (131, 9, 5, 8, 50, 0, CAST(N'2023-12-11T10:05:19.453' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (132, 10, 3, 4, 50, 0, CAST(N'2023-12-11T10:05:46.940' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (133, 10, 4, 4, 50, 0, CAST(N'2023-12-11T10:05:53.603' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (134, 10, 5, 4, 50, 0, CAST(N'2023-12-11T10:06:00.237' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (135, 10, 1, 1, 50, 0, CAST(N'2023-12-11T10:06:16.040' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (136, 10, 2, 1, 49, 0, CAST(N'2023-12-11T10:06:24.483' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (137, 10, 3, 1, 50, 0, CAST(N'2023-12-11T10:06:37.040' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (138, 41, 3, 9, 50, 0, CAST(N'2023-12-11T10:07:45.043' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (139, 41, 4, 9, 50, 0, CAST(N'2023-12-11T10:07:52.967' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (140, 41, 2, 8, 50, 0, CAST(N'2023-12-11T10:08:25.180' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (141, 41, 3, 8, 50, 0, CAST(N'2023-12-11T10:08:32.240' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (142, 41, 4, 8, 50, 0, CAST(N'2023-12-11T10:08:40.890' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (143, 42, 2, 1, 50, 0, CAST(N'2023-12-11T10:09:18.640' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (144, 42, 3, 1, 50, 0, CAST(N'2023-12-11T10:09:30.277' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (145, 42, 4, 1, 50, 0, CAST(N'2023-12-11T10:09:39.043' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (146, 42, 2, 4, 50, 0, CAST(N'2023-12-11T10:09:49.387' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (147, 42, 3, 4, 50, 0, CAST(N'2023-12-11T10:09:57.397' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (148, 42, 4, 4, 50, 0, CAST(N'2023-12-11T10:10:05.777' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (149, 43, 2, 7, 50, 0, CAST(N'2023-12-11T10:11:00.063' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (150, 43, 3, 7, 50, 0, CAST(N'2023-12-11T10:11:07.910' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (151, 43, 4, 7, 50, 0, CAST(N'2023-12-11T10:11:25.343' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (152, 43, 3, 1, 50, 0, CAST(N'2023-12-11T10:11:41.890' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (153, 43, 4, 1, 50, 0, CAST(N'2023-12-11T10:11:50.050' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (154, 44, 3, 2, 50, 0, CAST(N'2023-12-11T10:13:39.283' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (155, 4, 2, 3, 50, 0, CAST(N'2023-12-11T10:14:05.140' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (156, 44, 4, 3, 50, 0, CAST(N'2023-12-11T10:14:13.397' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (157, 45, 3, 5, 50, 0, CAST(N'2023-12-11T10:15:13.403' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (158, 45, 4, 8, 50, 0, CAST(N'2023-12-11T10:15:31.517' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (159, 46, 3, 4, 50, 0, CAST(N'2023-12-11T10:25:08.643' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (160, 46, 4, 8, 50, 0, CAST(N'2023-12-11T10:25:23.770' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (161, 16, 3, 2, 50, 0, CAST(N'2023-12-11T10:30:22.923' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (162, 16, 3, 9, 50, 0, CAST(N'2023-12-11T10:30:42.793' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (163, 24, 3, 8, 50, 0, CAST(N'2023-12-11T10:32:53.417' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (164, 26, 3, 10, 50, 0, CAST(N'2023-12-11T10:34:12.530' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (165, 26, 5, 9, 50, 0, CAST(N'2023-12-11T10:37:43.970' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (166, 53, 2, 8, 50, 0, CAST(N'2023-12-11T10:38:19.920' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (167, 53, 3, 8, 49, 0, CAST(N'2023-12-11T10:38:33.060' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (168, 53, 3, 1, 50, 0, CAST(N'2023-12-11T10:38:43.130' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (169, 53, 4, 1, 50, 0, CAST(N'2023-12-11T10:38:52.020' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (170, 54, 4, 1, 50, 0, CAST(N'2023-12-11T10:39:08.080' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (171, 54, 5, 1, 50, 0, CAST(N'2023-12-11T10:39:18.247' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (172, 54, 3, 8, 50, 0, CAST(N'2023-12-11T10:39:27.310' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (173, 56, 5, 2, 50, 0, CAST(N'2023-12-11T10:39:45.957' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (174, 56, 4, 2, 50, 0, CAST(N'2023-12-11T10:39:55.170' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (175, 55, 4, 11, 50, 0, CAST(N'2023-12-11T10:40:08.667' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (176, 55, 2, 11, 50, 0, CAST(N'2023-12-11T10:40:20.727' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (177, 57, 4, 1, 50, 0, CAST(N'2023-12-11T10:40:35.823' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (178, 57, 5, 1, 50, 0, CAST(N'2023-12-11T10:40:45.973' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (179, 58, 3, 8, 50, 0, CAST(N'2023-12-11T10:40:55.797' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (180, 58, 5, 8, 50, 0, CAST(N'2023-12-11T10:41:09.060' AS DateTime))
SET IDENTITY_INSERT [dbo].[product_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[product_image] ON 

INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (1, 1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh1-2.jpg?alt=media&token=a78a88a0-14c2-4843-96f5-14c0a700eef7', CAST(N'2023-12-10T20:30:53.010' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (2, 3, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh4-1.jpg?alt=media&token=409246ca-0d84-4d42-820e-faaa1bb15f5c', CAST(N'2023-12-10T20:33:49.197' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (3, 2, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh6-2.jpg?alt=media&token=59ca4b49-5482-4c62-8aa3-0ac1369e4c1b', CAST(N'2023-12-10T20:32:14.717' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (4, 4, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh7-2.jpg?alt=media&token=2891b2e5-e540-47a2-b5e8-8a232ae75092', CAST(N'2023-12-10T20:35:12.670' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (5, 5, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh5-2.jpg?alt=media&token=016e81bc-fbbe-4691-9501-74c652d46776', CAST(N'2023-12-10T20:36:10.847' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (6, 6, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh12-1.jpg?alt=media&token=fe543f2b-fbbb-448d-ad30-952e7ff184bf', CAST(N'2023-12-10T20:37:52.253' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (7, 7, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh4-1.jpg?alt=media&token=585cb866-0055-4b3f-9ac6-1d0a4cea9b14', CAST(N'2023-12-10T20:39:55.497' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (8, 8, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh9-3.jpg?alt=media&token=a4b4283d-1d3b-46c0-821a-c568a2c854c0', CAST(N'2023-12-10T20:41:12.407' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (9, 9, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh2-3.jpg?alt=media&token=c67954b5-9655-4e56-b87b-ebe0c356305c', CAST(N'2023-12-10T20:42:56.223' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (10, 10, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh5-2.jpg?alt=media&token=05102d71-ba62-4c0c-a6a5-ddc89afdb448', CAST(N'2023-12-10T20:44:10.843' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (14, 2, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh6-3.jpg?alt=media&token=be75f0fe-1cc8-4e44-af88-08f1b75eeef7', CAST(N'2023-12-10T20:32:41.427' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (15, 3, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh4-3.jpg?alt=media&token=fa2163cc-20f0-4eb3-979f-07a57b288964', CAST(N'2023-12-10T20:34:08.763' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (16, 4, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh7-3.jpg?alt=media&token=66862fd7-ac96-48b6-ab83-2ecddc2db9cf', CAST(N'2023-12-10T20:35:30.707' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (17, 5, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh5-3.jpg?alt=media&token=22c8670c-1d3a-4fdb-a2e8-4e3beb6e1699', CAST(N'2023-12-10T20:36:24.390' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (18, 7, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh4-2.jpg?alt=media&token=04d608d1-3393-49f0-b388-3478889cc51b', CAST(N'2023-12-10T20:40:11.240' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (19, 8, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh8-3.jpg?alt=media&token=45f8e78b-0b30-43ac-8b34-53d2bb5eee0f', CAST(N'2023-12-10T20:41:27.233' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (20, 9, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh2-2.jpg?alt=media&token=047f5140-d036-4966-927f-0cc3f6189163', CAST(N'2023-12-10T20:43:07.837' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (21, 10, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh5-3.jpg?alt=media&token=9a2a79a5-bc57-4bbd-8113-3df439c04660', CAST(N'2023-12-10T20:44:25.973' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (22, 1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh1-3.jpg?alt=media&token=6b455e7b-4ca9-4d90-84a6-44ce02fa97a0', CAST(N'2023-10-19T15:55:13.237' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (23, 1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh2-2.jpg?alt=media&token=0b497231-50d9-4591-ac46-28a77c8d0c33', CAST(N'2023-12-10T20:31:13.697' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (24, 1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh3-3.jpg?alt=media&token=940ed65c-099f-4e02-88f8-eaa18f735e1e', CAST(N'2023-12-10T20:31:34.883' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (25, 11, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike01-1.jpg?alt=media&token=4d0f3c69-5dbc-4260-86d4-68ce36e579fe', CAST(N'2023-11-21T15:48:23.553' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (26, 11, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike01-2.jpg?alt=media&token=52a742cd-d34e-4bae-a5a5-be0f19790346', CAST(N'2023-11-21T15:48:41.550' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (27, 12, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike14-1.webp?alt=media&token=4868612a-0995-406d-bbfe-7519fd19185c', CAST(N'2023-12-10T21:16:07.357' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (28, 12, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike14-2.webp?alt=media&token=9c5de4e8-a61c-4b53-a972-736a0b45d4d9', CAST(N'2023-12-10T21:16:19.340' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (29, 13, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike03-1.jpg?alt=media&token=1a5e2e83-bbf1-47b5-9f27-7d7ecb7a3e66', CAST(N'2023-11-21T15:49:14.937' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (30, 13, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike03-2.jpg?alt=media&token=58c8a3a7-d99e-4f4a-b3c7-35b47788a046', CAST(N'2023-11-21T15:49:24.560' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (31, 14, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike13-1.webp?alt=media&token=1dc446dc-5342-4e56-a26b-030e805cec09', CAST(N'2023-12-10T21:18:16.787' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (32, 14, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike13-2.webp?alt=media&token=f9df6d6f-d36f-4333-b185-7af2693b076e', CAST(N'2023-12-10T21:18:27.403' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (33, 15, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike04-1.jpg?alt=media&token=b1f45599-5e32-4324-92d8-8397f804f7d3', CAST(N'2023-12-10T21:19:25.307' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (34, 15, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike04-2.jpg?alt=media&token=bf022111-5f48-4e5f-ac2a-4e82b37daf8b', CAST(N'2023-12-10T21:19:37.320' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (35, 21, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma08-1.webp?alt=media&token=daf3f7c1-b584-4036-a546-8fb19672d337', CAST(N'2023-12-10T21:35:29.390' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (36, 21, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma08-2.webp?alt=media&token=62c5507c-98fc-4a3f-9d7f-5c3412c6fd0c', CAST(N'2023-12-10T21:35:48.513' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (37, 22, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma03-1.webp?alt=media&token=77b93146-aa37-42f8-a67a-80446ccc4d3d', CAST(N'2023-12-10T21:36:42.077' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (38, 22, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma03-2.webp?alt=media&token=19d3714d-a1fc-4bce-b845-2985f7a5bda1', CAST(N'2023-12-10T21:36:55.410' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (39, 23, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma04-1.webp?alt=media&token=c00e13f2-92fc-47c9-8b7f-f1c814e64bf7', CAST(N'2023-12-10T21:41:17.970' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (40, 23, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma04-2.webp?alt=media&token=3a059352-5a6d-48cd-b44f-7a61c0e394b8', CAST(N'2023-12-10T21:41:30.247' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (41, 24, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma01-1.webp?alt=media&token=c58c339f-c5a2-4a49-a3c2-f5442d426f5a', CAST(N'2023-12-10T21:42:16.797' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (42, 24, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma01-2.webp?alt=media&token=28102169-b246-4a48-a958-2478b4a8954f', CAST(N'2023-12-10T21:42:33.263' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (43, 25, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma05-1.webp?alt=media&token=fd7665c2-47bb-4592-9551-0c11ea290c7c', CAST(N'2023-11-21T15:51:45.857' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (44, 25, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma05-2.webp?alt=media&token=474e25ec-90f6-4770-b657-ee203e78ea2f', CAST(N'2023-11-21T15:51:56.520' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (45, 31, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok01-1.webp?alt=media&token=53305cde-5fe4-4103-a805-ea16e9ad0505', CAST(N'2023-11-21T15:52:07.800' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (46, 31, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok01-2.webp?alt=media&token=1203d318-a630-4a3b-b3e8-dcf83854c41a', CAST(N'2023-11-21T15:52:16.593' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (47, 32, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok02-1.webp?alt=media&token=1fa29583-0a6e-4bbb-9e71-48073c3c139c', CAST(N'2023-11-21T15:52:27.163' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (48, 32, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok02-2.webp?alt=media&token=577959cd-f243-4afe-b1eb-f840ad6170c4', CAST(N'2023-11-21T15:52:38.213' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (49, 33, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok08-1.webp?alt=media&token=9a1321bd-8a42-4439-a6af-4fe0a3206959', CAST(N'2023-12-10T21:50:27.600' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (50, 33, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok08-2.webp?alt=media&token=5f99d4dc-79c3-48e6-bea8-0c45bddb2833', CAST(N'2023-12-10T21:50:39.260' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (51, 34, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok03-1.webp?alt=media&token=c10417aa-0b56-4d02-bbee-ac58cfe40eae', CAST(N'2023-12-10T21:51:08.853' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (52, 34, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok03-2.webp?alt=media&token=5d61e035-229a-4267-94b8-1017c3ca8b79', CAST(N'2023-12-10T21:51:20.913' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (53, 35, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok06-1.webp?alt=media&token=8c130717-aa61-4812-8a07-f762478c6f7b', CAST(N'2023-12-10T21:51:48.197' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (54, 35, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok06-2.webp?alt=media&token=da607cfb-61a7-4f1f-b6cf-c34df19e8985', CAST(N'2023-12-10T21:52:01.210' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (55, 41, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance01-1.webp?alt=media&token=5a8c73f4-4701-4c22-a04d-c0ba472a11aa', CAST(N'2023-11-21T15:53:50.500' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (56, 41, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance01-2.webp?alt=media&token=d9940e01-a9c0-434d-b4d3-4946d3b33632', CAST(N'2023-11-21T15:53:59.620' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (57, 42, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance03-1.webp?alt=media&token=a080234b-166e-48b6-9556-aaedceec2eca', CAST(N'2023-12-10T20:46:21.010' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (58, 42, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance03-2.webp?alt=media&token=e1e68791-6078-4cf5-ac09-e44785f23156', CAST(N'2023-12-10T20:46:38.797' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (59, 43, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance15-1.webp?alt=media&token=2b08a87e-89e2-4bb0-8e7a-42fd5832da95', CAST(N'2023-12-10T20:47:20.067' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (60, 43, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance15-2.webp?alt=media&token=c5475909-c09e-44c1-9cd3-5ec6d8e3e201', CAST(N'2023-12-10T20:47:34.143' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (61, 44, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance04-1.webp?alt=media&token=25017656-4867-4e57-9908-883cefa6c917', CAST(N'2023-11-21T15:55:02.810' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (62, 44, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance04-2.webp?alt=media&token=3a72ba5a-ed5d-48d3-9e14-d343e2c45b6b', CAST(N'2023-11-21T15:55:16.433' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (63, 45, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance02-1.webp?alt=media&token=d7fe07a4-fda5-4cac-934e-574d4f1093c6', CAST(N'2023-12-10T21:08:45.850' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (64, 45, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance02-2.webp?alt=media&token=ba8392c6-1dd7-42e6-b346-ec07369d8fb5', CAST(N'2023-12-10T21:09:06.587' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (65, 47, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh2-3.jpg?alt=media&token=84885104-7f9f-4fd7-ac84-d894454eb03d', CAST(N'2023-12-03T22:12:03.153' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (66, 2, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh5-3.jpg?alt=media&token=94ddc90e-9ba0-4f84-ac6e-c8529e6c8a9a', CAST(N'2023-12-10T20:33:04.290' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (67, 2, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh3-3.jpg?alt=media&token=8b246a87-da20-4dcf-8e26-d0b1943e868e', CAST(N'2023-12-10T20:33:19.230' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (68, 3, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh5-3.jpg?alt=media&token=89098eb2-ad94-487e-895b-18c229711fa1', CAST(N'2023-12-10T20:34:32.897' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (69, 3, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh2-2.jpg?alt=media&token=7bfd1d42-2dca-4882-b5be-6781a60b4117', CAST(N'2023-12-10T20:34:41.147' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (70, 4, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh11-1.jpg?alt=media&token=778c9fb5-d825-4c54-9fe1-a0df7e7991b9', CAST(N'2023-12-10T20:35:49.750' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (71, 4, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh11-2.jpg?alt=media&token=ddc2cafa-1bd1-4f6e-89d3-bb0595836f15', CAST(N'2023-12-10T20:35:57.583' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (72, 5, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh4-3.jpg?alt=media&token=20155083-fd4d-4e2b-8bd1-05ab260fb333', CAST(N'2023-12-10T20:36:52.410' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (73, 5, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh4-2.jpg?alt=media&token=946316b7-9f4b-413f-a428-22a3bfdd326a', CAST(N'2023-12-10T20:37:14.643' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (74, 6, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh12-2.jpg?alt=media&token=f4c49c40-665a-4a5c-9519-c2224f147d9c', CAST(N'2023-12-10T20:38:05.427' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (75, 6, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh13-1.jpg?alt=media&token=9060a390-db21-4c0a-8873-d0dd19e65e33', CAST(N'2023-12-10T20:38:58.137' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (76, 6, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh13-3.jpg?alt=media&token=282f02b5-9f52-4dbd-9ba9-82bf12553f37', CAST(N'2023-12-10T20:39:25.543' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (77, 7, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh3-2.jpg?alt=media&token=d842cfc1-9dd9-4bac-bdd1-1b899ab8e85a', CAST(N'2023-12-10T20:40:35.420' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (78, 7, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh3-3.jpg?alt=media&token=4881c404-58da-4b5c-89d5-c8efaff62330', CAST(N'2023-12-10T20:40:43.183' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (79, 8, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh10-3.jpg?alt=media&token=d0a95229-dced-46d3-a616-2ac1af8ef8e4', CAST(N'2023-12-10T20:41:52.640' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (80, 8, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh10-2.jpg?alt=media&token=6dab6973-aaf1-4164-8e88-a0a4ebf22cf1', CAST(N'2023-12-10T20:42:01.887' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (81, 9, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh1-2.jpg?alt=media&token=56503dad-2320-47bf-970f-6c66c1240b57', CAST(N'2023-12-10T20:43:22.550' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (82, 9, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh1-3.jpg?alt=media&token=5063d895-9700-4c4c-ae98-40ef7c45e004', CAST(N'2023-12-10T20:43:43.707' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (83, 10, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh2-2.jpg?alt=media&token=f1683c4f-ad5b-4e22-8cd7-321ed606e9ca', CAST(N'2023-12-10T20:44:46.673' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (84, 10, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh2-3.jpg?alt=media&token=7caa8968-6034-4844-af74-2d794aba476c', CAST(N'2023-12-10T20:44:54.087' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (85, 41, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance02-1.webp?alt=media&token=1435a3a5-bb8c-4848-b91a-66eea5558458', CAST(N'2023-12-10T20:45:56.860' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (87, 42, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance11-1.webp?alt=media&token=af4a581f-ebd8-4c6e-aa56-10549a2e5327', CAST(N'2023-12-10T20:46:55.017' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (89, 43, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance08-1.webp?alt=media&token=10ab5e86-3af3-4ae9-b7a9-3403602de0ea', CAST(N'2023-12-10T20:48:21.243' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (91, 44, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance14-1.webp?alt=media&token=3bc65de8-a44b-48c0-b8b6-cb8ecea7bc84', CAST(N'2023-12-10T21:05:57.677' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (94, 45, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance16-1.webp?alt=media&token=37975bee-ca94-40a0-b745-c51093c35a78', CAST(N'2023-12-10T21:12:14.547' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (96, 46, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance13-1.webp?alt=media&token=c2bcf590-6062-49a3-9e99-0b50eb89eff1', CAST(N'2023-12-10T21:12:43.727' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (97, 46, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance13-2.webp?alt=media&token=20aacbb0-f688-455b-aefc-3b80f1a61bf4', CAST(N'2023-12-10T21:12:52.297' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (98, 46, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnewbalance06-1.webp?alt=media&token=4a6a02ce-30e0-4720-bddd-f9fd632a6e97', CAST(N'2023-12-10T21:13:16.653' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (100, 11, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike12-1.webp?alt=media&token=37586ccf-f46d-4ef0-8170-397d9cf071fa', CAST(N'2023-12-10T21:13:59.983' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (101, 12, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike04-1.jpg?alt=media&token=8cb2c59c-bcda-4999-8d05-ab3ed443e9c1', CAST(N'2023-12-10T21:17:36.040' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (102, 13, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike04-2.jpg?alt=media&token=1db9f307-9c30-4990-8faf-682bb6cd8ba1', CAST(N'2023-12-10T21:17:54.677' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (103, 14, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike08-2.jpg?alt=media&token=0cb5d86b-3322-4159-bb7c-9392c0fc6b38', CAST(N'2023-12-10T21:19:05.170' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (104, 15, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike02-2.jpg?alt=media&token=cbbd8d48-e4b3-4012-b21a-03ab61f86243', CAST(N'2023-12-10T21:19:47.447' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (105, 16, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike09-1.jpg?alt=media&token=0a350218-e78b-4d3a-80c1-9fd867a280dd', CAST(N'2023-12-10T21:20:10.617' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (106, 16, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike09-2.jpg?alt=media&token=913ed7d4-b3f5-45c8-b4c6-e550a8a172be', CAST(N'2023-12-10T21:20:28.793' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (107, 16, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fnike17-1.webp?alt=media&token=628a42a9-caca-4121-b9ee-947b7086f386', CAST(N'2023-12-10T21:20:42.437' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (108, 21, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma09-1.webp?alt=media&token=ba98db93-f569-44d8-b520-993ee2ec71fd', CAST(N'2023-12-10T21:36:20.953' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (109, 22, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma01-2.webp?alt=media&token=bb387fe5-0975-41e0-b50a-c6f8cc8b0d03', CAST(N'2023-12-10T21:40:08.053' AS DateTime))
GO
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (110, 23, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma06-2.webp?alt=media&token=10cd0a45-dac9-4bf0-ad8f-30905ebf8c58', CAST(N'2023-12-10T21:41:49.310' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (111, 24, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma08-1.webp?alt=media&token=7a667d38-a756-4637-a56d-955c4ddb64f9', CAST(N'2023-12-10T21:42:53.140' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (112, 26, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma02-1.webp?alt=media&token=6a1c064e-47cd-47b8-9342-bb2e1426c095', CAST(N'2023-12-10T21:43:25.940' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (113, 26, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fpuma02-2.webp?alt=media&token=864afa3e-371a-4014-a019-686563edb1e5', CAST(N'2023-12-10T21:43:34.177' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (114, 31, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok03-2.webp?alt=media&token=27e344dd-78c0-44e5-8711-ecfbeed8afaa', CAST(N'2023-12-10T21:48:54.783' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (115, 32, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok04-1.webp?alt=media&token=9fa5af82-5bf6-434c-81ee-9f41d104af46', CAST(N'2023-12-10T21:49:47.217' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (116, 33, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok10-2.webp?alt=media&token=b732672e-56b2-478f-be0b-f6e8b534202b', CAST(N'2023-12-10T21:50:54.167' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (117, 34, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok04-2.webp?alt=media&token=d16deca0-a6fe-4947-926b-c3ce44780cb4', CAST(N'2023-12-10T21:51:36.277' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (118, 36, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok10-1.webp?alt=media&token=855bbc2a-9d4c-4eeb-922b-3d9cfb3de9fd', CAST(N'2023-12-10T21:52:27.117' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (119, 36, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Freebok10-2.webp?alt=media&token=a412d930-7300-4598-a64f-572502918a74', CAST(N'2023-12-10T21:52:40.687' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (120, 53, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh7-1.jpg?alt=media&token=053b9cd4-ca9d-4c40-8732-6157c2200097', CAST(N'2023-12-10T22:00:23.727' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (121, 53, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh7-3.jpg?alt=media&token=07c9acca-448e-412b-b45e-92fd9312fbac', CAST(N'2023-12-10T22:00:34.330' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (122, 53, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh6-3.jpg?alt=media&token=31c22c5c-0999-4b48-bd33-88d972e2760a', CAST(N'2023-12-10T22:00:45.010' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (123, 54, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh10-1.jpg?alt=media&token=8bdf75fe-9d96-4df4-8537-419092292bf3', CAST(N'2023-12-10T22:01:41.543' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (124, 54, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh10-3.jpg?alt=media&token=01b400e6-831b-4c5d-9002-b8804431c8cd', CAST(N'2023-12-10T22:01:49.497' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (125, 54, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fvans01-3.webp?alt=media&token=7b36a7ba-e66b-4d41-84e4-696509a46c08', CAST(N'2023-12-10T22:02:04.900' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (126, 55, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fvans03-1.webp?alt=media&token=4639f526-6ef8-4903-9c7e-415cbcb57e18', CAST(N'2023-12-10T22:02:16.820' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (127, 55, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fvans03-2.webp?alt=media&token=429c4d2e-d615-4573-9568-0804ca13366c', CAST(N'2023-12-10T22:02:28.060' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (128, 56, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh11-1.jpg?alt=media&token=1da25425-9951-4617-a863-02d2d34dab5c', CAST(N'2023-12-10T22:02:52.153' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (129, 56, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh11-2.jpg?alt=media&token=0c22012f-74b1-46d3-acde-6e3b65d2fc8d', CAST(N'2023-12-10T22:02:58.547' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (130, 57, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fvans04-1.webp?alt=media&token=dce50186-6450-47ca-bc74-cd08d9a9a8f0', CAST(N'2023-12-10T22:03:11.847' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (131, 57, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fvans04-3.webp?alt=media&token=aac57782-6436-44cf-8e04-a5c47d348fbe', CAST(N'2023-12-10T22:03:18.723' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (132, 58, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh12-1.jpg?alt=media&token=64f9e63f-0ca7-45b9-899a-ab2e485b95a7', CAST(N'2023-12-10T22:03:59.133' AS DateTime))
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (133, 58, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh12-2.jpg?alt=media&token=6071f6e6-7c32-4b31-97b8-6f0b639f3897', CAST(N'2023-12-10T22:04:06.107' AS DateTime))
SET IDENTITY_INSERT [dbo].[product_image] OFF
GO
SET IDENTITY_INSERT [dbo].[review] ON 

INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (1, 9, N'Sản phẩm đúng với mô tả, rất ưng ý luôn mang vừa vặn, đẹp, trẻ trung cho 5 sao sao luôn nha', 13, CAST(N'2023-12-13T00:00:00.000' AS DateTime), 5, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/reviews%2Fgiay.jpg?alt=media&token=56de7edf-5ab5-4e03-ae8b-a0ba75595dd3', NULL, NULL, 10)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (2, 3, N'vừa in luôn nhưng mình thấy dây giày hơi ngắn', 13, CAST(N'2023-11-20T00:00:00.000' AS DateTime), 4, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/reviews%2Fgiay.jpg?alt=media&token=56de7edf-5ab5-4e03-ae8b-a0ba75595dd3', NULL, NULL, 11)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (3, 6, NULL, 14, CAST(N'2023-10-17T00:00:00.000' AS DateTime), 4, NULL, NULL, NULL, 14)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (4, 3, N'Giày đẹp  vì shop có cho miếng nhựa để dữ phom giày đóng gói kĩ, 10đ ko cầm bàn cãi', 14, CAST(N'2023-11-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 12)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (5, 6, N'Shop gói hàng cẩn thận. Nhận về hộp còn nguyên vẹn. Form giày ok chi tiết ổn k có keo thừa. 10 điểm', 14, CAST(N'2023-09-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 13)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (6, 8, NULL, 15, CAST(N'2023-09-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 15)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (7, 12, N'Giày như kiểu bị lỗi ấy ạ. Mk đi bị đau chân bên phải chỗ gần mõm giày ấy ạ, đoạn đấy kiểu may lỗi nó bị chặt ạ', 16, CAST(N'2023-08-13T00:00:00.000' AS DateTime), 3, NULL, NULL, NULL, 17)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (8, 15, N'Sản phẩm giao hàng nhanh đóng gói cẩn thận hàng đúng với mô tả đi êm chân', 17, CAST(N'2023-08-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 20)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (9, 13, N'Shop giao hàng khá nhanh, có tặng thêm 1 dây giày trắng để thay đổi, trong giày shop có để cái giữ fom nha nên nhận hàng k bị móp méo tí nào', 17, CAST(N'2023-08-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 19)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (10, 12, N'Giày giao nhanh. Đúng size form đẹp hộp nguyên vẹn. Xinh lắm nhé', 17, CAST(N'2023-07-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 18)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (11, 25, N'Giày siêu đẹp chất lượng nha. Đóng gói chắc chắn giao hàng nhanh. Mở ra bao xịn luôn nên mua nha', 18, CAST(N'2023-07-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 22)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (12, 34, N'Giày mới, sạch, không lỗi ngoại trừ phần dưới đế chân trái bị lem chút màu đen. Đường chỉ may gọn, đẹp', 18, CAST(N'2023-06-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 21)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (13, 23, N'Với tầm giá này thì chất lượng giày ổn, shop có kèm thêm lót nhựa và 1 dây trắng nữa. Mn nên mua tăng lên 1 size so với bình thường cho thoải mái ạ.', 19, CAST(N'2023-06-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 23)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (14, 7, N'Giày đẹp ạ. Không có chỉ thừa luôn. Phân vân mãi mới mua tại k nghĩ rẻ mà lại hốt được đôi giày chất lượng thế này', 20, CAST(N'2023-08-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 26)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (15, 4, N'Giày đẹp lắm luôn ý . Với giá vậy thì k có gì để chê luôn đó shop ơi', 20, CAST(N'2023-08-13T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 25)
SET IDENTITY_INSERT [dbo].[review] OFF
GO
SET IDENTITY_INSERT [dbo].[shipping_address] ON 

INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (7, N'Bắc Giang', N'Huyện Lục Nam', N'Xã Chu Điện', N'Nguyễn Văn Mười', N'Nguyễn Văn Mười', N'0983647734', 1, 3)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (8, N'Bắc Giang', N'Huyện Lục Nam', N'Xã Đan Hội', N'Trần Văn Thanh', N'Trần Văn Thanh', N'0943774745', 1, 4)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (9, N'Bà Rịa - Vũng Tàu', N'Huyện Châu Đức', N'Xã Bình Ba', N'Huyền Trang', N'Huyền Trang', N'0943674775', 1, 5)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (10, N'Bạc Liêu', N'Thị Xã Giá Rai', N'Xã Tân Phong', N'Phương Mai', N'Phương Mai', N'0984764347', 1, 6)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (11, N'Bạc Liêu', N'Huyện Đông Hải', N'Xã Long Điền Đông A', N'Minh Xuân', N'Minh Xuân', N'0984364578', 1, 12)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (12, N'Bắc Kạn', N'Huyện Ngân Sơn', N'Xã Vân Tùng', N'Hùng Minh Sơn', N'Hùng Minh Sơn', N'0948743498', 0, 12)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (13, N'Quảng Ninh', N'Thành phố Uông Bí', N'Phường Quang Trung', N'Hà Vĩ Kiên ', N'Hà Vĩ Kiên ', N'0943877458', 1, 13)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (14, N'Vĩnh Phúc', N'Huyện Bình Xuyên', N'Xã Đạo Đức', N'Lê Văn Đỗ Kiên', N'Lê Văn Đỗ Kiên', N'0984766545', 1, 14)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (15, N'Bắc Kạn', N'Huyện Bạch Thông', N'Xã Cao Sơn', N'Nguyễn Tiến An', N'Nguyễn Tiến An', N'0957435543', 0, 14)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (16, N'Bắc Ninh', N'Huyện Gia Bình', N'Xã Đại Lai', N'An Tony', N'An Tony', N'0943434344', 1, 15)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (17, N'Bắc Ninh', N'Huyện Gia Bình', N'Xã Đại Lai', N'Hà Thanh Thanh', N'Hà Thanh Thanh', N'0943343444', 1, 16)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (18, N'Ninh Thuận', N'Huyện Ninh Hải', N'Xã Thanh Hải', N'Trần Văn Hà Đô', N'sadasd', N'0944347667', 0, 16)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (19, N'Bạc Liêu', N'Huyện Hồng Dân', N'Xã Vĩnh Lộc A', N'Bùi Thị Hạ', N'qweqe', N'0940988900', 1, 17)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (20, N'Bắc Giang', N'Huyện Việt Yên', N'Xã Bích Sơn', N'Trần Ánh Minh', N'wewrweer', N'0944007690', 0, 17)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (21, N'Bắc Kạn', N'Huyện Bạch Thông', N'Xã Cẩm Giàng', N'Nguyễn Trần Thanh ', N'jkhgkjdfg', N'0932343567', 1, 18)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (22, N'Bình Thuận', N'Thị xã La Gi', N'Xã Tân Bình', N'Võ Văn Hùng', N'asdjhfkh', N'0931232345', 0, 18)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (23, N'Hòa Bình', N'Huyện Kỳ Sơn', N'Xã Độc Lập', N'Nguyễn Thị Hoa', N'fsdfs', N'0932324566', 1, 19)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (24, N'Lai Châu', N'Huyện Nậm Nhùn', N'Xã Nậm Ban', N'Trần Ngọc Vi', N'sdfsd', N'0934532899', 1, 20)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (25, N'Hải Dương', N'Thị xã Kinh Môn', N'Xã Lạc Long', N'Adam Nguyễn', N'sdfsd', N'0912344657', 1, 21)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (26, N'Bình Dương', N'Thị xã Bến Cát', N'Phường Thới Hòa', N'Lê Văn Cốt', N'hhjsdhfsadf', N'0954354788', 0, 21)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (27, N'Cao Bằng', N'Huyện Hà Quảng', N'Xã Quý Quân', N'Lê Văn Liêm', N'ajdfjiowehrw', N'0954666568', 0, 21)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (28, N'Thanh Hóa', N'Huyện Thọ Xuân', N'Xã Xuân Lam', N'Tô Vũ Linh', N'sdjkdsjhfsd', N'0909767590', 0, 22)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (29, N'Cà Mau', N'Huyện Thới Bình', N'Xã Tân Lộc Đông', N'Trần Mạnh Cường', N'asdfhasdfasdf', N'0909655454', 1, 22)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (30, N'Bình Dương', N'Thành phố Dĩ An', N'Phường Bình Thắng', N'Trần Minh Hạnh', N'sadfjkladf', N'0909656565', 0, 22)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (31, N'Bạc Liêu', N'Thị Xã Giá Rai', N'Xã Phong Thạnh Tây', N'Thạc Jong Gol', N'jlkdfasdf', N'0909812234', 0, 23)
SET IDENTITY_INSERT [dbo].[shipping_address] OFF
GO
SET IDENTITY_INSERT [dbo].[size] ON 

INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (1, 38, 1, 0, CAST(N'2023-11-17T10:16:19.223' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (2, 39, 1, 0, CAST(N'2023-11-17T10:16:12.580' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (3, 40, 1, 0, CAST(N'2023-11-24T10:19:13.253' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (4, 41, 1, 0, CAST(N'2022-04-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (5, 42, 1, 0, CAST(N'2023-11-21T16:12:36.380' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (6, 31, 1, 0, CAST(N'2023-12-08T09:04:44.503' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (7, 32, 1, 0, CAST(N'2023-11-17T10:18:07.930' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (8, 33, 1, 0, CAST(N'2023-11-24T10:43:48.077' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (9, 34, 1, 0, CAST(N'2023-12-03T22:07:31.970' AS DateTime))
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

INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (1, N'Nike Vietnam', N'Tầng Trệt, TTTM Sense City. Số, 1 Đại lộ Hoà Bình, Tân An, Ninh Kiều, Cần Thơ', N'0292381969', N'nike123@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (2, N'Adidas Vietnam', N'Tầng 3, Tòa nhà 24T3 Thanh Xuân Complex, Số 6 Lê Văn Thiêm, Thanh Xuân Trung, Thanh Xuân, Hà Nội', N'0939348888', N'cskh@vuahanghieu.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (3, N'Biti''s', N'22 Lý Chiêu Hoàng, Phường 10, Quận 6, TP. Hồ Chí Minh', N'0387533443', N'bitts123@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (4, N'FILA Vietnam', N'25 Lý Chiêu Hoàng, Phường 10, Quận 6, TP. Hồ Chí Minh', N'0978646356', N'crv.fila@vn.centralretail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (5, N'Anta Vietnam', N'Số 5, ngõ 75, đường Hồng Hà, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0974945488', N'online@arr.com.vn', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (6, N'New Balance Vietnam', N'Số 163, Phan Đăng Lưu, Phường 01, Phú Nhuận, Hồ Chí Minh, Việt Nam', N'0314635071', N'newbalance@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (7, N'Puma Vietnam', N'Số 163, Phan Đăng Lưu, Phường 01, Phú Nhuận, Hồ Chí Minh, Việt Nam', N'0988758476', N'puma@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (8, N'Giày Hồng Thái', N'82 Lê Lợi, Phường 2, TP. Cao Lãnh, Đồng Tháp', N'0277385842', N'thaidui123@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (9, N'Converse', N'79 Nguyễn Trãi, P.An Hội, Q.Ninh Kiều, , Cần Thơ', N'0956476354', N'converse@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (10, N'Dr.choice Sneaker', N'69, Ngô Quyền, Tân An, Cần Thơ', N'0978746574', N'choicesneaker@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (11, N'K-converse', N'4/2/74 Đinh Tiên Hoàng, Ninh Kiều', N'0945678986', N'kconverse@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (12, N'Bali sneaker', N'18T, hẻm 51, đường 3/2, Ninh Kiều, Cần Thơ', N'0968735143', N'balisneaker@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (13, N'Vans Store Cần Thơ', N'48 Trần Hưng Đạo, P. An Nghiệp, Ninh Kiều, Cần Thơ', N'0389521879', N'vanstore@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (14, N'K- CONS', N'76A Đinh Tiên Hoàng, Quận Ninh Kiều, Tp Cần Thơ.', N'0964006257', N'kcons@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (15, N'DC Store', N'31 Huỳnh Cương, An Cư, Ninh Kiều, Cần Thơ', N'0582042490', N'dcstore@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (16, N'Giày Xám Store', N'95 Nguyễn Việt Hồng, phường An Phú, Ninh Kiều, TP Cần Thơ', N'0946422171', N'gxamstore@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (17, N'MWC', N'41G Mậu Thân, Q.Ninh Kiều', N'0957789376', N'mwc@gmail.com', 1, 0)
SET IDENTITY_INSERT [dbo].[supplier] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (1, N'Bùi Thanh Bùi', N'123 Main St', N'0847686870', CAST(N'2011-12-01' AS Date), N'ADMIN', CAST(N'2023-08-10' AS Date), 1, N'BTB@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://images.hdqwalls.com/download/katarina-lol-minimal-4k-pi-315x315.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (2, N'Trần Văn Năm', N'456 Elm St', N'9879879897', CAST(N'1985-03-20' AS Date), N'ADMIN', CAST(N'2023-08-11' AS Date), 1, N'DBVR@gnail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image2.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (3, N'Lê Thị Ri', N'789 Oak St', N'0456456456', CAST(N'1995-07-05' AS Date), N'EMPLOYEE', CAST(N'2023-08-12' AS Date), 1, N'RCRC@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image3.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (4, N'Trần Thanh Hải', N'101 Pine St', N'0977866511', CAST(N'1980-11-30' AS Date), N'EMPLOYEE', CAST(N'2023-08-13' AS Date), 1, N'bob@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image4.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (5, N'Nguyễn Lê Văn Thi', N'202 Cedar St', N'0986543166', CAST(N'1988-09-25' AS Date), N'CUSTOMER', CAST(N'2023-08-14' AS Date), 1, N'NLVT@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image5.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (6, N'Jack Ma', N'303 Spruce St', N'0919919918', CAST(N'1992-05-10' AS Date), N'EMPLOYEE', CAST(N'2023-08-15' AS Date), 1, N'jack5milion@example.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image6.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (7, N'Quang Minh', N'123', N'0876491749', CAST(N'2022-10-10' AS Date), N'ADMIN', CAST(N'2022-12-20' AS Date), 1, N'minh@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', NULL, 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (8, N'Xin chào', N'Vinh', N'0989098765', CAST(N'1999-04-10' AS Date), N'CUSTOMER', CAST(N'2023-11-25' AS Date), 1, N'phamm7696@gmail.com', N'$2a$10$BJ0MfiMWVc1HYgT2cs6Ca.mMlTcALXyB4GNogtm3XF0VoANEW6te.', N'https://images.hdqwalls.com/download/super-saiyan-rose-5a-315x315.jpg', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (9, N'Huynh Van Ni (FPL CT K17)', N'Cần Thơ', N'0948136411', CAST(N'1992-05-12' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'nihvpc04493@fpt.edu.vn', N'18c24ac7b8f', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (10, N'Nguyễn Đoàn Hải Anh', N'Khánh Hoà', N'0348163441', CAST(N'1992-05-13' AS Date), N'EMPLOYEE', CAST(N'2023-12-01' AS Date), 1, N'haianh@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (11, N'Diệp Anh Đào', N'Mỹ Tho', N'0124841286', CAST(N'1992-05-14' AS Date), N'EMPLOYEE', CAST(N'2023-12-01' AS Date), 1, N'SQLlv7@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (12, N'Bậc Thầy SQL', N'Đồng Nai', N'0764134767', CAST(N'1992-05-15' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'vusduy123@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (13, N'Thái Văn Vũ', N'Sydney', N'0512568518', CAST(N'1992-05-16' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'danhbeo0909@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (14, N'Danh Béo', N'Mỹ Tho', N'0145558356', CAST(N'1992-05-17' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'madxitrum222@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://images.hdqwalls.com/download/red-hood-evolution-5k-ne-315x315.jpg', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (15, N'Mai Anh Đào', NULL, N'0909712491', CAST(N'1992-05-18' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'tuannguyenjava@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (16, N'Nguyễn Đăng Khôi', NULL, N'0876541247', CAST(N'1992-05-19' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'dangkhoi999@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (17, N'Tuân Nguyễn', NULL, N'0796912411', CAST(N'1992-05-20' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'tuannguyen000@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (18, N'Khánh Chương', NULL, N'0512561235', CAST(N'1992-05-21' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'khanhchuong@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (19, N'DJ Thái Hoàng', NULL, N'0434141555', CAST(N'1992-05-21' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'thaihoangacademy@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (20, N'Ben 10', NULL, N'0271459581', CAST(N'1992-05-17' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'ben10101010@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (21, N'Hải Trần thanh', N'', N'', NULL, N'CUSTOMER', CAST(N'2023-12-11' AS Date), 1, N'wesd4444@gmail.com', N'18c584a7065', N'https://images.hdqwalls.com/download/punked-anime-girl-t3-315x315.jpg', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (22, N'DJ Phan Văn Thành', NULL, N'0434171655', CAST(N'1992-05-21' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'pvt123ad@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (23, N'Trần Nhứt Hàn', NULL, N'0999141555', CAST(N'1992-05-21' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'jqkklq1@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (24, N'Mitch Row', NULL, N'0401941555', CAST(N'1992-05-21' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'mstrow@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (25, N'Lê Quy Đệ', NULL, N'0434100055', CAST(N'1992-05-21' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'qldoppp@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (26, N'IRE Nguyễn', NULL, N'0164141555', CAST(N'1992-05-21' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'irn123@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (27, N'DJ Thái Hoàng', NULL, N'0430901555', CAST(N'1992-05-21' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'anonyuoio123@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (28, N'Hải', NULL, NULL, NULL, N'CUSTOMER', CAST(N'2023-12-13' AS Date), 1, N'volonghai1511@gmail.com', N'18c610e6565', N'https://lh3.googleusercontent.com/a/ACg8ocK8HRYnF0wg8DRGTrgT-4jnS5nQZMmqJU8WLtQF3h1m3_U=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (29, N'Vo Long Hai (FPL CT K17)', NULL, NULL, NULL, N'CUSTOMER', CAST(N'2023-12-13' AS Date), 1, N'haivlpc04485@fpt.edu.vn', N'18c61125b84', N'https://lh3.googleusercontent.com/a/ACg8ocLbS6YO9qgmxvxbVRLYw24ArskNGfzsoAFM4RooSnNU0VU=s96-c', 1, 1, N'GG')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[voucher] ON 

INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-13T23:59:00.000' AS DateTime), CAST(N'2023-12-23T23:59:00.000' AS DateTime), N'Voucher giảm 5% cho đơn hàng từ 2.500.000đ thỏa điều kiện của FourShoe. Áp dụng khi thanh toán đơn hàng website của FourShoe. HSD: 13/12/2023 23:59 - 23/12/2023 23:59. Mỗi khách hàng chỉ được dùng 1 lần. Mọi thắc mắc vui lòng liên hệ trong vòng 24H.', 2500000, 0, 1)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(6.00 AS Decimal(5, 2)), CAST(N'2023-12-13T23:59:00.000' AS DateTime), CAST(N'2023-12-23T23:59:00.000' AS DateTime), N'Voucher giảm 6% cho đơn hàng từ 3.000.000đ thỏa điều kiện của FourShoe. Áp dụng khi thanh toán đơn hàng website của FourShoe. HSD: 13/12/2023 23:59 - 23/12/2023 23:59. Mỗi khách hàng chỉ được dùng 1 lần. Mọi thắc mắc vui lòng liên hệ trong vòng 24H.', 3000000, 0, 2)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(7.00 AS Decimal(5, 2)), CAST(N'2023-12-13T23:59:00.000' AS DateTime), CAST(N'2023-12-23T23:59:00.000' AS DateTime), N'Voucher giảm 7% cho đơn hàng từ 3.500.000đ thỏa điều kiện của FourShoe. Áp dụng khi thanh toán đơn hàng website của FourShoe. HSD: 13/12/2023 23:59 - 23/12/2023 23:59. Mỗi khách hàng chỉ được dùng 1 lần. Mọi thắc mắc vui lòng liên hệ trong vòng 24H.', 3500000, 0, 3)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(8.00 AS Decimal(5, 2)), CAST(N'2023-12-13T23:59:00.000' AS DateTime), CAST(N'2023-12-23T23:59:00.000' AS DateTime), N'Voucher giảm 8% cho đơn hàng từ 4.000.000đ thỏa điều kiện của FourShoe. Áp dụng khi thanh toán đơn hàng website của FourShoe. HSD: 13/12/2023 23:59 - 23/12/2023 23:59. Mỗi khách hàng chỉ được dùng 1 lần. Mọi thắc mắc vui lòng liên hệ trong vòng 24H.', 4000000, 0, 4)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(9.00 AS Decimal(5, 2)), CAST(N'2023-12-13T23:59:00.000' AS DateTime), CAST(N'2023-12-23T23:59:00.000' AS DateTime), N'Voucher giảm 9% cho đơn hàng từ 4.500.000đ thỏa điều kiện của FourShoe. Áp dụng khi thanh toán đơn hàng website của FourShoe. HSD: 13/12/2023 23:59 - 23/12/2023 23:59. Mỗi khách hàng chỉ được dùng 1 lần. Mọi thắc mắc vui lòng liên hệ trong vòng 24H.', 4500000, 0, 5)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(10.00 AS Decimal(5, 2)), CAST(N'2023-12-13T23:59:00.000' AS DateTime), CAST(N'2023-12-23T23:59:00.000' AS DateTime), N'Voucher giảm 10% cho đơn hàng từ 5.000.000đ thỏa điều kiện của FourShoe. Áp dụng khi thanh toán đơn hàng website của FourShoe. HSD: 13/12/2023 23:59 - 23/12/2023 23:59. Mỗi khách hàng chỉ được dùng 1 lần. Mọi thắc mắc vui lòng liên hệ trong vòng 24H.', 5000000, 0, 6)
SET IDENTITY_INSERT [dbo].[voucher] OFF
GO
SET IDENTITY_INSERT [dbo].[voucher_use] ON 

INSERT [dbo].[voucher_use] ([use_date], [voucher_id], [users_id], [voucher_use_id], [saved]) VALUES (CAST(N'2023-12-13T10:25:10.000' AS DateTime), 1, 29, 1, 1)
INSERT [dbo].[voucher_use] ([use_date], [voucher_id], [users_id], [voucher_use_id], [saved]) VALUES (CAST(N'2023-12-13T10:25:11.000' AS DateTime), 2, 29, 2, 1)
INSERT [dbo].[voucher_use] ([use_date], [voucher_id], [users_id], [voucher_use_id], [saved]) VALUES (CAST(N'2023-12-13T10:25:13.000' AS DateTime), 5, 29, 3, 0)
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
/****** Object:  StoredProcedure [dbo].[GetProductQuantityByMonthAndYear]    Script Date: 13/12/2023 4:46:38 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductQuantityByMonthAndYear]
    @Month INT,
    @Year INT
AS
BEGIN
    SELECT
        p.product_name,
        SUM(ird.quantity) AS total_quantity
    FROM
        import_receipt ir
    INNER JOIN
        import_receipt_detail ird ON ir.import_receipt_id = ird.import_receipt_id
    INNER JOIN
        product_detail pd ON ird.product_detail_id = pd.product_detail_id
    INNER JOIN
        product p ON pd.product_id = p.product_id
    WHERE
        MONTH(CONVERT(DATE, ir.import_date)) = @Month
        AND YEAR(CONVERT(DATE, ir.import_date)) = @Year
        AND ir.deleted = 0
        AND ird.deleted = 0
    GROUP BY
        p.product_name
END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertCartItem]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  StoredProcedure [dbo].[SP_InsertShippingAddress]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  StoredProcedure [dbo].[SP_updateCartItem]    Script Date: 13/12/2023 4:46:38 CH ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateDefault]    Script Date: 13/12/2023 4:46:38 CH ******/
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
