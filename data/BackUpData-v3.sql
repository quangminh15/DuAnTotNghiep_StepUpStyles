USE [master]
GO
/****** Object:  Database [stepupstyles]    Script Date: 11/9/2023 7:23:57 PM ******/
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
/****** Object:  Table [dbo].[brand]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[cart]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[cart_detail]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[category]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[color]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[direct_discount]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[favorite]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[import_receipt]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[import_receipt_detail]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[order]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[order_detail]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[payment_menthod]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[product]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[product_detail]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[product_image]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[review]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[shipping_address]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[size]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[supplier]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[voucher]    Script Date: 11/9/2023 7:23:58 PM ******/
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
/****** Object:  Table [dbo].[voucher_use]    Script Date: 11/9/2023 7:23:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[voucher_use](
	[use_date] [datetime] NULL,
	[voucher_id] [bigint] NULL,
	[users_id] [bigint] NULL,
	[voucher_use_id] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[voucher_use_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[brand] ON 

INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (1, N'Converse', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F1.png?alt=media&token=397af877-91dd-4850-84ca-f61b6317df6c', 1, 0, CAST(N'2023-10-19T00:00:00.000' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (2, N'Nike', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F2.jpg?alt=media&token=cd62e855-c786-44e8-8076-b2c410314d9b', 1, 0, CAST(N'2023-10-22T20:31:40.927' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (3, N'Puma', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F3.jpg?alt=media&token=93f717a3-d9bf-4288-a554-3e58a305c4c5', 0, 0, CAST(N'2023-11-01T09:56:48.697' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (4, N'Reebok', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F4.png?alt=media&token=cd62b1f3-38eb-4c8d-a3fa-54fbe9d33fce', 0, 0, CAST(N'2023-11-01T09:56:38.803' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (5, N'New Balance', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F5.png?alt=media&token=7e7ac7e0-b26a-498b-a1da-63ed6738e3e5', 0, 0, CAST(N'2023-11-01T09:56:53.383' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (12, N'nhutin', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F12.jpg?alt=media&token=f723c765-ae3e-41a0-9a93-79b4b743a648', 1, 1, CAST(N'2023-10-31T09:23:41.593' AS DateTime))
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_image], [activities], [deleted], [modify_date]) VALUES (13, N'123', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/brands%2F13.png?alt=media&token=b5356f91-3cfc-4e60-9908-2248bdb2aad6', 1, 1, CAST(N'2023-10-31T09:23:36.837' AS DateTime))
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

INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (1, 1, 1, 1, 1)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (2, 2, 1, 2, 2)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (3, 3, 1, 3, 2)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (4, 4, 2, 3, 1)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (5, 5, 1, 2, 4)
SET IDENTITY_INSERT [dbo].[cart_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (1, N'Giày nam', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid2.jpg?alt=media&token=c1c66f85-eff7-44c6-a393-00a5199bd31e', 1, 0, CAST(N'2021-01-12T00:00:00.000' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (2, N'Giày nữ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid3.jpg?alt=media&token=3301b61a-fbc3-461a-8146-e393e3088f8a', 0, 0, CAST(N'2020-08-12T00:00:00.000' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (3, N'Giày thể thao', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Category%2Fgrid4.jpg?alt=media&token=127d7bd7-808d-407a-8fbc-11a1f697f21c', 1, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[category] ([category_id], [category_name], [category_image], [activities], [deleted], [modify_date]) VALUES (4, N'Giày chạy bộ', N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/Brand%2Fbanner3.jpg?alt=media&token=eb3b3207-0694-4331-8b28-49cc1f5d7a48', 1, 0, CAST(N'2023-10-13T00:00:00.000' AS DateTime))
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
SET IDENTITY_INSERT [dbo].[color] OFF
GO
SET IDENTITY_INSERT [dbo].[direct_discount] ON 

INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (5, 1, CAST(10.00 AS Decimal(5, 2)), CAST(N'2023-10-23T14:53:00.000' AS DateTime), CAST(N'2023-11-11T14:52:00.000' AS DateTime), 0, N'Đang diễn ra', 4500000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (6, 2, CAST(12.00 AS Decimal(5, 2)), CAST(N'2023-10-23T14:57:00.000' AS DateTime), CAST(N'2023-10-26T14:52:00.000' AS DateTime), 1, N'Đã kết thúc', 1320000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (7, 3, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-10-23T14:55:00.000' AS DateTime), CAST(N'2023-11-10T14:53:00.000' AS DateTime), 0, N'Đang diễn ra', 1900000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (8, 6, CAST(7.00 AS Decimal(5, 2)), CAST(N'2023-10-23T14:56:00.000' AS DateTime), CAST(N'2023-11-11T14:53:00.000' AS DateTime), 0, N'Đang diễn ra', 3394500)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (9, 10, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-10-23T20:29:00.000' AS DateTime), CAST(N'2023-11-03T14:53:00.000' AS DateTime), 0, N'Đã kết thúc', 474050)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (11, 4, CAST(4.00 AS Decimal(5, 2)), CAST(N'2023-11-10T14:57:00.000' AS DateTime), CAST(N'2023-11-18T14:57:00.000' AS DateTime), 0, N'Chưa diễn ra', 1296000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (12, 2, CAST(3.00 AS Decimal(5, 2)), CAST(N'2023-11-02T16:30:00.000' AS DateTime), CAST(N'2023-11-11T16:30:00.000' AS DateTime), 0, N'Đang diễn ra', 1455000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (13, 5, CAST(2.00 AS Decimal(5, 2)), CAST(N'2023-11-04T16:31:00.000' AS DateTime), CAST(N'2023-11-18T16:31:00.000' AS DateTime), 1, N'Đang diễn ra', 2401000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (14, 7, CAST(10.00 AS Decimal(5, 2)), CAST(N'2023-10-30T21:50:00.000' AS DateTime), CAST(N'2023-11-03T21:47:00.000' AS DateTime), 0, N'Đã kết thúc', 5931000)
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (16, 8, CAST(10.00 AS Decimal(5, 2)), CAST(N'2023-10-31T22:01:00.000' AS DateTime), CAST(N'2023-11-11T22:02:00.000' AS DateTime), 0, N'Đang diễn ra', 719100)
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

INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (1, 1, 1, 1, CAST(N'2023-09-10' AS Date), 1, 0, CAST(N'2023-09-07T08:00:00.000' AS DateTime), 100, 10, 110, N'Processing', NULL, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (2, 2, 2, 2, CAST(N'2023-09-10' AS Date), 1, 0, CAST(N'2023-09-07T09:30:00.000' AS DateTime), 150, 12.5, 162.5, N'Shipped', NULL, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (3, 3, 3, 3, CAST(N'2023-09-12' AS Date), 1, 0, CAST(N'2023-09-07T10:45:00.000' AS DateTime), 75, 7.5, 82.5, N'Delivered', NULL, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (4, 4, 4, 1, CAST(N'2023-09-13' AS Date), 1, 0, CAST(N'2023-09-07T12:15:00.000' AS DateTime), 200, 15, 215, N'Processing', NULL, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (5, 5, 5, 1, CAST(N'2023-09-14' AS Date), 1, 0, CAST(N'2023-09-07T13:45:00.000' AS DateTime), 90, 8, 98, N'Pending', NULL, NULL)
SET IDENTITY_INSERT [dbo].[order] OFF
GO
SET IDENTITY_INSERT [dbo].[order_detail] ON 

INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (1, 1, 2, 3, 25)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (2, 1, 3, 2, 15)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (3, 2, 1, 4, 30)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (4, 3, 2, 1, 10)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (5, 4, 3, 5, 50)
SET IDENTITY_INSERT [dbo].[order_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[payment_menthod] ON 

INSERT [dbo].[payment_menthod] ([payment_method_id], [payment_menthod_name], [description], [display]) VALUES (1, N'Thanh toán khi nhân hàng', N'Thanh toán tiền mặt', 1)
INSERT [dbo].[payment_menthod] ([payment_method_id], [payment_menthod_name], [description], [display]) VALUES (2, N'VNPAY', N'Thanh toán online', 1)
INSERT [dbo].[payment_menthod] ([payment_method_id], [payment_menthod_name], [description], [display]) VALUES (3, N'PayPal', N'Thanh toán online', 1)
SET IDENTITY_INSERT [dbo].[payment_menthod] OFF
GO
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (1, N'Converse 01', 1, 1, 1, 5000000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (2, N'Converse 02', 2, 1, 2, 1500000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 1, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (3, N'Converse 03', 3, 1, 3, 2000000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 1, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (4, N'Converse 04', 4, 1, 4, 1350000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 1, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (5, N'Converse 05', 5, 1, 5, 2450000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (6, N'Converse 06', 1, 1, 1, 3650000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 1, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (7, N'Converse 07', 2, 1, 2, 6590000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (8, N'Converse 08', 3, 1, 3, 799000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (9, N'Converse 09', 4, 1, 4, 500000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 1, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (10, N'Converse 10', 5, 1, 5, 499000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 1, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (11, N'Nike 01', 2, 2, 9, 7200000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 1, 1, CAST(N'2023-10-22T20:32:06.010' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (12, N'Nike 02', 1, 2, 1, 4000000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (13, N'Nike 03', 2, 2, 1, 6000000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (14, N'Nike 04', 1, 2, 1, 1500000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 0, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (15, N'Nike 05', 2, 2, 1, 2000000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 0, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (16, N'Nike 06', 4, 2, 1, 7680000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (17, N'Nike 07', 2, 2, 1, 567000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (18, N'Nike 08', 5, 2, 1, 876000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (19, N'Nike 09', 2, 2, 1, 567000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (20, N'Nike 10', 2, 2, 1, 987000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (21, N'Puma 01', 4, 3, 1, 867000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 0, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (22, N'Puma 02', 3, 3, 1, 967000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 0, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (23, N'Puma 03', 3, 3, 1, 934000, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 0, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (24, N'Puma 04', 5, 3, 1, 912000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ .', 0, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (25, N'Puma 05', 3, 3, 1, 856000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (26, N'Puma 06', 2, 3, 1, 712000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (27, N'Puma 07', 3, 3, 1, 536000, N'Sunflower là một trong những phối màu hot nhất của dòng Converse 1970s, rất đẹp và dễ phối đồ, đồng thời có 2 bản là cao cổ và thấp cổ,', 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (28, N'Puma 08', 1, 3, 1, 933000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (29, N'Puma 09', 3, 3, 1, 655000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (30, N'Puma 10', 3, 3, 1, 966000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (31, N'Reebok 01', 4, 4, 2, 908000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (32, N'Reebok 02', 2, 4, 2, 987000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (33, N'Reebok 03', 4, 4, 2, 6785430, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (34, N'Reebok 04', 4, 4, 2, 789500, N'Được gọi vui một cách thân thuộc là “giày Vans “, thực chất đây là một trong những phiên bản đầu tiên và cổ điển nhất của VANS trong bộ sưu tập VANS OLD SKOOL ra đời năm 1977.', 0, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (35, N'Reebok 05', 1, 4, 2, 876000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (36, N'Reebok 06', 4, 4, 2, 654000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (37, N'Reebok 07', 3, 4, 2, 567000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2023-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (38, N'Reebok 08', 4, 4, 2, 678900, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (39, N'Reebok 09', 4, 4, 2, 666000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (40, N'Reebok 10', 3, 4, 2, 999000, N'đều nên có một đôi trong tủ giày. Được mệnh danh là phiên bản mang “càng cũ càng đẹp” và nhiều phiên bản custom  bậc nhất của nhà VANS.', 0, 1, CAST(N'2020-07-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (41, N'New Balance 01', 5, 5, 3, 222000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (42, N'New Balance 02', 5, 5, 3, 666000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 1, CAST(N'2021-08-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (43, N'New Balance 03', 2, 5, 3, 999000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 0, CAST(N'2020-05-24T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (44, N'New Balance 04', 5, 5, 3, 777000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2012-07-26T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (45, N'New Balance 05', 3, 5, 3, 879000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2015-03-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (46, N'New Balance 06', 1, 5, 3, 567000, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2023-07-03T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (47, N'New Balance 07', 5, 5, 3, 8979000, N'Converse Renew Canvas, phiên bản giới hạn mang mục đích bảo vệ môi trường sẽ được chính thức mở bán tại hệ thống Converse VN từ ngày 5/7 với số lượng giới hạn.', 0, 1, CAST(N'2023-10-13T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (48, N'New Balance 08', 5, 5, 3, 8789000, N'huyền thoại hợp thời trang khiến đôi VANS này thật sự trở thành mẫu giày classic bất bại, là fan hâm mộ của VANS nói chung và những skaters nói riêng', 0, 1, CAST(N'2015-01-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (49, N'New Balance 09', 1, 5, 3, 6543000, N'Tới nay đôi giày chỉ với phối màu đen trắng này vẫn nằm trong top “Best Seller” của VANS trên toàn thế giới, với kiểu dáng cổ điển cùng “sọc Jazz”', 0, 0, CAST(N'2023-07-21T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[product] ([product_id], [product_name], [category_id], [brand_id], [users_id], [price], [product_description], [activities], [featured], [modify_date], [deleted]) VALUES (50, N'New Balance 10', 5, 5, 3, 2098908, N'Converse 1970s là 1 trong những dòng sản phẩm bán chạy nhất của Converse.Phần đế màu trắng ngà vintage được phủ 1 lớp bóng bên ngoài là điểm nhấn riêng cho dòng 1970s, dễ vệ sinh hơn.', 0, 1, CAST(N'2023-10-13T00:00:00.000' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[product] OFF
GO
SET IDENTITY_INSERT [dbo].[product_detail] ON 

INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (1, 1, 3, 1, 55, 0, CAST(N'2021-01-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (2, 2, 1, 2, 24, 0, CAST(N'2022-02-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (3, 3, 1, 3, 50, 0, CAST(N'2023-06-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (4, 4, 1, 4, 50, 0, CAST(N'2020-08-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (5, 5, 1, 5, 50, 0, CAST(N'2019-09-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (6, 6, 2, 1, 47, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (7, 7, 2, 2, 50, 0, CAST(N'2020-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (8, 8, 2, 3, 8, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (9, 9, 2, 4, 50, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (10, 10, 2, 5, 50, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (12, 1, 2, 2, 50, 0, CAST(N'2023-10-25T19:26:08.207' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (13, 1, 2, 5, 51, 0, CAST(N'2023-10-28T20:41:13.377' AS DateTime))
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
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (13, 1, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fanh1-2.jpg?alt=media&token=63b84d10-03cc-476d-97d3-f56abb015ef0', CAST(N'2023-10-16T00:00:00.000' AS DateTime))
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
INSERT [dbo].[product_image] ([product_image_id], [product_id], [image_path], [modify_date]) VALUES (25, 11, N'https://firebasestorage.googleapis.com/v0/b/stepupstyles-97319.appspot.com/o/productImage%2Fhinh10-1.jpg?alt=media&token=a2ddce2f-173d-4b35-b1e2-5603ab431b66', CAST(N'2023-10-22T20:31:31.357' AS DateTime))
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

INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (1, N'Hà Nội', N'Cầu Giấy', N'Dịch Vọng Hậu', N'123 Đường ABC', N'Nguyễn Văn Mười', N'0919919919', 1, 1)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (2, N'TPHCM', N'Quận 1', N'Bến Nghé', N'456 Đường XYZ', N'Nguyễn Văn A', N'0456456456', 0, 2)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (3, N'Hải Phòng', N'Hồng Bàng', N'Ngô Quyền', N'789 Đường DEF', N'Nguyễn Văn Mơi', N'0986543166', 0, 3)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (4, N'Đà Nẵng', N'Hải Châu', N'Hòa Cường Nam', N'101 Đường GHI', N'Nguyễn Văn Tèo', N'0987987989', 0, 4)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (5, N'Cần Thơ', N'Ninh Kiều', N'Tân An', N'202 Đường JKL', N'Nguyễn Văn Người Nhận', N'0456456456', 0, 5)
SET IDENTITY_INSERT [dbo].[shipping_address] OFF
GO
SET IDENTITY_INSERT [dbo].[size] ON 

INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (1, 38.5, 1, 0, CAST(N'2020-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (2, 39.5, 1, 0, CAST(N'2022-07-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (3, 40, 0, 0, CAST(N'2023-03-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (4, 41, 1, 0, CAST(N'2022-04-12T00:00:00.000' AS DateTime))
INSERT [dbo].[size] ([size_id], [size_number], [activities], [deleted], [modify_date]) VALUES (5, 42, 0, 1, CAST(N'2020-05-12T00:00:00.000' AS DateTime))
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
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[voucher] ON 

INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(15.00 AS Decimal(5, 2)), CAST(N'2023-11-10T00:00:00.000' AS DateTime), CAST(N'2023-11-20T00:00:00.000' AS DateTime), N'Giảm giá cho khách hàng 500000', 500000, 0, 1)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(15.00 AS Decimal(5, 2)), CAST(N'2023-11-04T17:00:00.000' AS DateTime), CAST(N'2023-11-20T17:00:00.000' AS DateTime), N'Giảm giá cho khách hàng 300000', 300000, 0, 2)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(10.00 AS Decimal(5, 2)), CAST(N'2023-11-06T00:00:00.000' AS DateTime), CAST(N'2023-11-20T00:00:00.000' AS DateTime), N'Giảm giá cho khách hàng 500000', 500000, 1, 3)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(13.00 AS Decimal(5, 2)), CAST(N'2023-11-10T11:11:00.000' AS DateTime), CAST(N'2023-11-10T11:11:00.000' AS DateTime), N'Giảm giá cho đơn hàng 500 k', 500000, 0, 5)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(13.00 AS Decimal(5, 2)), CAST(N'2023-11-10T11:11:00.000' AS DateTime), CAST(N'2023-11-10T11:11:00.000' AS DateTime), N'Giảm giá cho đơn hàng 500 k', 500000, 0, 6)
INSERT [dbo].[voucher] ([discount_amount], [date_start], [date_end], [description], [total], [deleted], [voucher_id]) VALUES (CAST(13.00 AS Decimal(5, 2)), CAST(N'2023-11-10T11:11:00.000' AS DateTime), CAST(N'2023-11-11T11:11:00.000' AS DateTime), N'Giảm giá cho đơn hàng 600 k', 600000, 0, 7)
SET IDENTITY_INSERT [dbo].[voucher] OFF
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
USE [master]
GO
ALTER DATABASE [stepupstyles] SET  READ_WRITE 
GO
