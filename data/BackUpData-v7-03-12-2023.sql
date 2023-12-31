USE [master]
GO
/****** Object:  Database [stepupstyles]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[brand]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[cart]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[cart_detail]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[category]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[color]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[direct_discount]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[favorite]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[import_receipt]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[import_receipt_detail]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[order]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[order_detail]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[payment_menthod]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[product]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[product_detail]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[product_image]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[review]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[shipping_address]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[size]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[supplier]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[users]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[voucher]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  Table [dbo].[voucher_use]    Script Date: 03/12/2023 8:45:49 SA ******/
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
SET IDENTITY_INSERT [dbo].[brand] OFF
GO
SET IDENTITY_INSERT [dbo].[cart] ON 

INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (1, 1)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (2, 2)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (3, 3)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (4, 4)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (5, 5)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (6, 6)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (7, 7)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (8, 36)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (9, 37)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (10, 38)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (11, 39)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (12, 40)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (13, 41)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (14, 42)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (15, 43)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (16, 44)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (17, 45)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (18, 46)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (19, 47)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (20, 48)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (21, 49)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (22, 50)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (23, 51)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (24, 52)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (25, 53)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (26, 54)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (27, 55)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (28, 56)
INSERT [dbo].[cart] ([cart_id], [users_id]) VALUES (29, 57)
SET IDENTITY_INSERT [dbo].[cart] OFF
GO
SET IDENTITY_INSERT [dbo].[cart_detail] ON 

INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (2, 2, 1, 2, 2)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (3, 3, 1, 3, 2)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (4, 4, 2, 3, 1)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (5, 5, 1, 2, 4)
INSERT [dbo].[cart_detail] ([cart_detail_id], [cart_id], [product_detail_id], [product_id], [quantity]) VALUES (6, 1, 1, 1, 3)
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
INSERT [dbo].[direct_discount] ([direct_discount_id], [product_id], [direct_discount], [start_date], [end_date], [deleted], [status], [price_discount]) VALUES (18, 6, CAST(5.00 AS Decimal(5, 2)), CAST(N'2023-12-01T20:33:00.000' AS DateTime), CAST(N'2023-12-07T20:33:00.000' AS DateTime), 0, N'Đang diễn ra', 3467500)
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
SET IDENTITY_INSERT [dbo].[favorite] OFF
GO
SET IDENTITY_INSERT [dbo].[import_receipt] ON 

INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (11, 14, 1, 248000000, CAST(N'2023-12-02T20:52:49.490' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (12, 16, 1, 170000000, CAST(N'2023-11-02T20:52:58.200' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (13, 20, 1, 109000000, CAST(N'2023-11-02T20:53:01.337' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (14, 23, 1, 126000000, CAST(N'2023-10-02T20:53:04.333' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (15, 16, 1, 210000000, CAST(N'2023-10-02T20:53:07.563' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (16, 19, 2, 85000000, CAST(N'2023-09-02T20:55:34.973' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (17, 26, 2, 142500000, CAST(N'2023-08-02T20:55:38.710' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (18, 27, 2, 205500000, CAST(N'2023-07-02T20:55:42.473' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (19, 21, 2, 394000000, CAST(N'2023-06-02T20:55:46.120' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (20, 11, 2, 190500000, CAST(N'2023-05-02T20:55:55.717' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (21, 23, 5, 178500000, CAST(N'2023-04-02T20:59:38.367' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (22, 27, 5, 247500000, CAST(N'2023-03-02T20:59:42.253' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (23, 12, 5, 429000000, CAST(N'2023-02-02T20:59:47.103' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (24, 13, 5, 155500000, CAST(N'2023-01-02T20:59:49.907' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (25, 13, 5, 49000000, CAST(N'2023-12-02T20:59:58.657' AS DateTime), 0)
INSERT [dbo].[import_receipt] ([import_receipt_id], [supplier_id], [users_id], [total_amount], [import_date], [deleted]) VALUES (26, 13, 5, 41000000, CAST(N'2023-09-02T20:59:58.677' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[import_receipt] OFF
GO
SET IDENTITY_INSERT [dbo].[import_receipt_detail] ON 

INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (11, 1, 11, 40, 4800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (12, 48, 11, 40, 1400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (13, 2, 25, 35, 1400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (14, 47, 25, 30, 4700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (15, 9, 25, 35, 300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (16, 6, 25, 50, 3400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (17, 14, 11, 40, 7000000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (18, 50, 12, 30, 4600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (19, 36, 12, 40, 800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (20, 35, 12, 20, 800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (21, 29, 13, 50, 800000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (22, 49, 13, 50, 1100000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (23, 31, 13, 20, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (24, 38, 14, 20, 6300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (25, 53, 14, 30, 1200000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (26, 45, 14, 40, 500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (27, 5, 15, 35, 2000000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (28, 17, 15, 40, 3500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (29, 43, 16, 20, 400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (30, 45, 16, 40, 500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (31, 24, 16, 45, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (32, 41, 16, 50, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (33, 2, 17, 30, 1200000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (34, 54, 17, 40, 1600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (35, 26, 17, 25, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (36, 39, 17, 55, 500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (37, 31, 18, 30, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (38, 21, 18, 20, 1200000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (39, 43, 18, 60, 450000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (40, 5, 18, 45, 2100000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (41, 29, 18, 70, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (42, 44, 19, 50, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (43, 7, 19, 35, 6200000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (44, 52, 19, 20, 4700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (45, 40, 19, 40, 500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (46, 27, 19, 55, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (47, 3, 20, 30, 1700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (48, 5, 20, 20, 2100000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (49, 36, 20, 50, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (50, 43, 20, 60, 400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (51, 30, 20, 55, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (52, 31, 21, 30, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (53, 20, 21, 45, 1200000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (54, 8, 21, 20, 500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (55, 44, 21, 60, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (56, 49, 21, 55, 1100000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (57, 33, 26, 30, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (58, 24, 26, 20, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (59, 10, 26, 40, 200000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (60, 2, 22, 40, 1300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (61, 16, 22, 35, 3700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (62, 26, 22, 20, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (63, 36, 22, 35, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (64, 39, 22, 55, 500000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (65, 7, 23, 20, 6200000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (66, 43, 23, 25, 400000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (67, 29, 23, 10, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (68, 37, 23, 40, 6300000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (69, 25, 23, 60, 600000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (70, 39, 24, 40, 550000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (71, 29, 24, 35, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (72, 16, 24, 20, 3700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (73, 44, 24, 50, 700000, 0)
INSERT [dbo].[import_receipt_detail] ([import_receipt_detail_id], [product_detail_id], [import_receipt_id], [quantity], [price], [deleted]) VALUES (74, 30, 24, 40, 700000, 0)
SET IDENTITY_INSERT [dbo].[import_receipt_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[order] ON 

INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (1, 1, 1, 1, CAST(N'2023-12-02' AS Date), 1, 0, CAST(N'2023-09-07T08:00:00.000' AS DateTime), 100, 10, 110, N'Delivered', 123000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (2, 2, 2, 2, CAST(N'2023-12-02' AS Date), 1, 0, CAST(N'2023-09-07T09:30:00.000' AS DateTime), 150, 12.5, 162.5, N'Delivered', 100000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (3, 3, 3, 3, CAST(N'2023-09-12' AS Date), 1, 0, CAST(N'2023-09-07T10:45:00.000' AS DateTime), 75, 7.5, 82.5, N'Delivered', 400000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (4, 4, 4, 1, CAST(N'2023-12-02' AS Date), 1, 0, CAST(N'2023-09-07T12:15:00.000' AS DateTime), 200, 15, 215, N'Delivered', 500000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (5, 5, 5, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-09-07T13:45:00.000' AS DateTime), 90, 8, 98, N'Delivered', 700000, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (6, 1, 6, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-11-25T21:30:11.000' AS DateTime), 1320000, 41501, 1361501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (7, 1, 6, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-11-27T10:29:19.000' AS DateTime), 1320000, 41501, 1361501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (8, 40, 9, 1, CAST(N'2023-12-02' AS Date), 1, 0, CAST(N'2022-11-25T21:30:11.000' AS DateTime), 1320000, 41501, 1361501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (9, 4, 6, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-09-01T04:50:15.000' AS DateTime), 5000000, 43999, 5043999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (10, 1, 7, 1, CAST(N'2023-12-08' AS Date), 1, 0, CAST(N'2023-10-01T04:51:55.000' AS DateTime), 2000000, 43999, 2043999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (11, 3, 8, 1, CAST(N'2023-12-08' AS Date), 1, 0, CAST(N'2023-12-01T05:19:57.000' AS DateTime), 1500000, 43999, 1543999, N'Delivered', 225000, 1)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (12, 3, 8, 1, CAST(N'2023-12-08' AS Date), 1, 0, CAST(N'2023-12-01T15:36:08.000' AS DateTime), 1500000, 41501, 1541501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (13, 40, 9, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-01T15:44:54.000' AS DateTime), 1500000, 41501, 1541501, N'Delivered', 150000, 4)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (14, 6, 7, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-01T16:32:57.000' AS DateTime), 5000000, 41501, 5041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (15, 40, 9, 1, CAST(N'2022-12-02' AS Date), 1, 0, CAST(N'2022-12-01T17:22:37.000' AS DateTime), 5000000, 41501, 5041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (16, 40, 9, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-01T17:22:55.000' AS DateTime), 5000000, 41501, 5041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (17, 40, 13, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-01T17:22:57.000' AS DateTime), 5000000, 41501, 5041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (18, 40, 17, 1, CAST(N'2022-08-02' AS Date), 1, 0, CAST(N'2022-08-02T04:39:05.000' AS DateTime), 5000000, 41501, 4291501, N'Delivered', 750000, 1)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (19, 43, 11, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-02T21:39:46.000' AS DateTime), 12500000, 41501, 12541501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (20, 43, 18, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-02T21:42:57.000' AS DateTime), 2000000, 41501, 2041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (21, 43, 39, 1, CAST(N'2022-03-09' AS Date), 1, 0, CAST(N'2022-12-03T21:44:26.000' AS DateTime), 5000000, 41501, 5041501, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (22, 45, 10, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-02T21:47:16.000' AS DateTime), 1350000, 50999, 1400999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (23, 45, 24, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-02T21:55:12.000' AS DateTime), 3116000, 50999, 3166999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (24, 52, 20, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-02T21:55:44.000' AS DateTime), 3650000, 50999, 3700999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (25, 52, 27, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-02T21:57:29.000' AS DateTime), 500000, 50999, 475999, N'Delivered', 75000, 1)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (26, 52, 33, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-02T22:09:30.000' AS DateTime), 6590000, 50999, 6640999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (27, 54, 23, 1, CAST(N'2022-05-09' AS Date), 1, 0, CAST(N'2022-05-02T22:09:54.000' AS DateTime), 88000000, 50999, 88050999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (28, 54, 29, 1, CAST(N'2023-12-03' AS Date), 1, 0, CAST(N'2023-12-02T22:11:00.000' AS DateTime), 8590000, 50999, 8640999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (29, 54, 32, 1, CAST(N'2023-12-09' AS Date), 0, 0, CAST(N'2023-12-02T22:11:15.000' AS DateTime), 3800000, 50999, 3850999, N'Pending', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (30, 55, 16, 1, CAST(N'2023-12-09' AS Date), 1, 0, CAST(N'2023-12-02T22:11:27.000' AS DateTime), 500000, 50999, 550999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (31, 55, 30, 1, CAST(N'2023-12-09' AS Date), 0, 0, CAST(N'2023-12-02T22:12:38.000' AS DateTime), 1500000, 50999, 1550999, N'Pending', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (32, 55, 35, 1, CAST(N'2023-12-09' AS Date), 1, 0, CAST(N'2023-12-02T22:12:49.000' AS DateTime), 7300000, 50999, 7350999, N'Delivered', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (33, 55, 30, 1, CAST(N'2023-12-09' AS Date), 0, 0, CAST(N'2023-12-02T22:13:01.000' AS DateTime), 2397000, 50999, 2447999, N'Pending', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (34, 55, 35, 1, CAST(N'2023-12-09' AS Date), 0, 0, CAST(N'2023-12-02T22:13:11.000' AS DateTime), 4050000, 50999, 4100999, N'Pending', 0, NULL)
INSERT [dbo].[order] ([order_id], [users_id], [shipping_address_id], [payment_method_id], [delivery_date], [payment_status], [delivery_status], [order_date], [initial_price], [shipping_fee], [total_amount], [order_status], [discount_price], [voucher_use_id]) VALUES (35, 1, 13, 1, CAST(N'2023-12-09' AS Date), 0, 0, CAST(N'2023-12-02T22:52:47.000' AS DateTime), 799000, 41501, 840501, N'Pending', 0, NULL)
SET IDENTITY_INSERT [dbo].[order] OFF
GO
SET IDENTITY_INSERT [dbo].[order_detail] ON 

INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (1, 1, 2, 3, 25)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (2, 1, 3, 2, 15)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (3, 2, 1, 4, 30)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (4, 3, 2, 1, 10)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (5, 4, 3, 5, 50)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (6, 6, 2, 1, 1320000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (7, 7, 2, 1, 1320000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (8, 6, 2, 1, 1320000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (9, 7, 1, 1, 5000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (10, 8, 3, 1, 2000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (11, 9, 2, 1, 1500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (12, 10, 2, 1, 1500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (13, 11, 2, 1, 1500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (14, 12, 1, 1, 5000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (15, 13, 1, 1, 5000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (16, 14, 1, 1, 5000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (17, 15, 1, 1, 5000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (18, 16, 13, 1, 5000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (19, 17, 2, 5, 1500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (21, 18, 3, 1, 2000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (22, 19, 1, 1, 5000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (23, 20, 4, 1, 1350000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (24, 21, 5, 1, 2450000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (25, 21, 43, 1, 666000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (26, 22, 6, 1, 3650000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (27, 23, 9, 1, 500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (28, 24, 7, 1, 6590000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (29, 25, 3, 44, 2000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (30, 26, 7, 1, 6590000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (31, 26, 3, 1, 2000000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (32, 27, 4, 1, 1350000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (33, 27, 5, 1, 2450000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (34, 28, 9, 1, 500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (35, 29, 2, 1, 1500000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (36, 30, 6, 2, 3650000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (37, 31, 8, 3, 799000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (38, 32, 4, 3, 1350000)
INSERT [dbo].[order_detail] ([order_detail_id], [order_id], [product_detail_id], [quantity], [price]) VALUES (39, 33, 8, 1, 799000)
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
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (47, 1, 4, 1, 50, 0, CAST(N'2023-12-02T19:25:18.217' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (48, 2, 5, 5, 50, 0, CAST(N'2023-12-02T19:25:26.947' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (49, 4, 2, 3, 50, 0, CAST(N'2023-12-02T19:25:36.837' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (50, 1, 3, 7, 50, 0, CAST(N'2023-12-02T19:26:13.440' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (51, 1, 11, 5, 50, 0, CAST(N'2023-12-02T19:26:22.177' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (52, 1, 2, 3, 50, 0, CAST(N'2023-12-02T19:26:29.557' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (53, 2, 12, 3, 50, 0, CAST(N'2023-12-02T19:27:49.673' AS DateTime))
INSERT [dbo].[product_detail] ([product_detail_id], [product_id], [size_id], [color_id], [quantity], [deleted], [modify_date]) VALUES (54, 3, 7, 1, 50, 0, CAST(N'2023-12-02T19:27:59.050' AS DateTime))
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

INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (2, 3, NULL, 45, CAST(N'2023-11-03T00:00:00.000' AS DateTime), 4, NULL, NULL, NULL, 2)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (3, 2, N'Giày có hộp đựng chắc chắn, có miếnh giữ form nên kh bị móp méo. Giày ổn áp lắm lun, lên chân siu xinhhh', 50, CAST(N'2023-12-03T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 6)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (6, 1, N'lấy 2 đôi 36- và 38 thì đôi size 36 không khác gì 38', 45, CAST(N'2023-11-03T00:00:00.000' AS DateTime), 3, NULL, NULL, NULL, 9)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (7, 2, NULL, 50, CAST(N'2023-10-03T00:00:00.000' AS DateTime), 4, NULL, NULL, NULL, 8)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (10, 2, NULL, 45, CAST(N'2023-08-03T00:00:00.000' AS DateTime), 4, NULL, NULL, NULL, 11)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (11, 1, NULL, 50, CAST(N'2023-08-03T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 16)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (14, 2, NULL, 45, CAST(N'2023-06-03T00:00:00.000' AS DateTime), 3, NULL, NULL, NULL, 19)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (15, 1, N'Với giá này mình nghĩ giầy khá là hợp lý và dễ thương. Mang vừa chân màu đẹp kiểu dáng ổn . shop đóng gói cẩn thận giao hàng nhanh
', 50, CAST(N'2023-06-03T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 18)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (18, 3, N'k ngờ shop uy tín thực sự . giày đẹp mà giá rẻ hơn mấy trăm so với ngoài tiệm .chắc ngoài tiệm họ lấy thêm tiền mặt bằng nên đắt hơn', 45, CAST(N'2023-04-03T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 10)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (19, 3, N'Nhận được hàng rồi, giày vừa với giá tiền, nếu nói giá mắc hơn thì sẽ không mua
0:15
', 50, CAST(N'2023-01-03T00:00:00.000' AS DateTime), 4, NULL, NULL, NULL, 21)
INSERT [dbo].[review] ([review_id], [product_id], [title], [users_id], [review_date], [rating], [image1], [image2], [image3], [order_detail_id]) VALUES (22, 6, N'Giày đẹp, chất liệu tốt đúng như mô tả sản phẩm, rất hài lòng', 45, CAST(N'2023-10-26T00:00:00.000' AS DateTime), 5, NULL, NULL, NULL, 36)
SET IDENTITY_INSERT [dbo].[review] OFF
GO
SET IDENTITY_INSERT [dbo].[shipping_address] ON 

INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (1, N'Hà Nội', N'Cầu Giấy', N'Dịch Vọng Hậu', N'123 Đường ABC', N'Nguyễn Văn Mười', N'0919919919', 0, 1)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (2, N'TPHCM', N'Quận 1', N'Bến Nghé', N'456 Đường XYZ', N'Nguyễn Văn A', N'0456456456', 0, 2)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (3, N'Hải Phòng', N'Hồng Bàng', N'Ngô Quyền', N'789 Đường DEF', N'Nguyễn Văn Mơi', N'0986543166', 0, 3)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (4, N'Đà Nẵng', N'Hải Châu', N'Hòa Cường Nam', N'101 Đường GHI', N'Nguyễn Văn Tèo', N'0987987989', 0, 4)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (5, N'Cần Thơ', N'Ninh Kiều', N'Tân An', N'202 Đường JKL', N'Nguyễn Văn Người Nhận', N'0456456456', 0, 5)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (6, N'An Giang', N'Huyện Phú Tân', N'Xã Hiệp Xương', N'số 28', N'Minh', N'098       ', 1, 1)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (7, N'Hà Nội', N'Cầu Giấy', N'Dịch Vọng Hậu', N'123 Đường ABC', N'Nguyễn Văn Mười', N'0919919919', 0, 1)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (8, N'TPHCM', N'Quận 1', N'Bến Nghé', N'456 Đường XYZ', N'Nguyễn Văn A', N'0987765989', 0, 2)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (9, N'Hải Phòng', N'Hồng Bàng', N'Ngô Quyền', N'789 Đường DEF', N'Nguyễn Văn Mơi', N'0986543166', 0, 3)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (10, N'Đà Nẵng', N'Hải Châu', N'Hòa Cường Nam', N'101 Đường GHI', N'Nguyễn Văn Tèo', N'0985357989', 0, 4)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (11, N'Cần Thơ', N'Ninh Kiều', N'Tân An', N'202 Đường JKL', N'Trần A Tèo', N'0986675439', 0, 5)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (12, N'An Giang', N'Huyện Phú Tân', N'Xã Hiệp Xương', N'số 28', N'Võ Văn Vinh', N'0957854589', 1, 4)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (13, N'Bắc Giang', N'Huyện Yên Dũng', N'Xã Cảnh Thụy', N'số 2', N'Lê Minh Tân', N'0989685989', 1, 6)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (14, N'Bạc Liêu', N'Huyện Đông Hải', N'Xã Long Điền Đông', N'hẻm 34', N'Chung Minh Tấn', N'0154689653', 1, 3)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (15, N'Bắc Giang', N'Huyện Yên Thế', N'Xã Đồng Hưu', N'số 32', N'Lê Giong Gol', N'0968906765', 0, 40)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (16, N'Bắc Giang', N'Huyện Lục Ngạn', N'Xã Mỹ An', N'108 Đường a1', N'Nguyễn Văn Mười', N'0943654645', 0, 45)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (17, N'Bình Định', N'Huyện Tây Sơn', N'Xã Tây Phú', N'Số 12 hẻm 89', N'Trần Mạnh Dụng', N'0174543534', 0, 43)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (18, N'Bắc Giang', N'Huyện Lục Nam', N'Xã Đông Hưng', N'Số  43 hẻm 132', N'Trần Minh Minh', N'0973453455', 0, 42)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (19, N'Bạc Liêu', N'Huyện Hồng Dân', N'Xã Ninh Thạnh Lợi', N'Số 665 đường B2  ', N'Thạch Khương', N'0943534355', 1, 40)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (20, N'Bến Tre', N'Huyện Giồng Trôm', N'Xã Châu Bình', N'hẻm 12', N'Thạch Jong Gol', N'0153454533', 1, 41)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (21, N'Bạc Liêu', N'Thị Xã Giá Rai', N'Xã Phong Thạnh Tây', N'Số 134', N'Nguyễn Văn A', N'0456546456', 1, 42)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (22, N'Bắc Giang', N'Huyện Lục Nam', N'Xã Đông Phú', N'Đường 12', N'Trần Thị Lụa', N'0435345345', 0, 55)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (23, N'Bắc Kạn', N'Huyện Ngân Sơn', N'Xã Thượng Quan', N'Số 23', N'Trần Văn Tân', N'0964535435', 0, 40)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (24, N'Bắc Giang', N'Huyện Yên Thế', N'Xã Canh Nậu', N'hẻm 12', N'Trần  Minh Tâm', N'0934534554', 1, 43)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (25, N'Bắc Kạn', N'Huyện Na Rì', N'Xã Hữu Thác', N'Hẻm 3', N'Võ Thị Hiền', N'0964565466', 0, 53)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (26, N'Bắc Kạn', N'Huyện Chợ Mới', N'Thị trấn Chợ Mới', N'số 3 hẻm 32', N'Nguyễn Quăng Tiến', N'0945355345', 0, 52)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (27, N'Bắc Kạn', N'Huyện Na Rì', N'Xã Lam Sơn', N'số 12 hẻm 67', N'Trần Hạ Minh', N'0953453455', 1, 44)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (28, N'An Giang', N'Huyện Phú Tân', N'Xã Long Hoà', N'số 26 hẻm 123', N'Võ Minh Hạ', N'0945645666', 0, 51)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (29, N'Bắc Kạn', N'Huyện Na Rì', N'Xã Lam Sơn', N'Số 34 đường 3A', N'Kiên Văn  Toàn', N'0934353454', 0, 54)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (30, N'Bà Rịa - Vũng Tàu', N'Thị Xã Phú Mỹ', N'Xã Tân Hoà', N'số 56', N'Phùng Anh Minh', N'0914155555', 1, 45)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (31, N'Bắc Kạn', N'Huyện Ngân Sơn', N'Xã Thượng Ân', N'đường 233 ', N'Nguyễn Phụng', N'0144222222', 1, 50)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (32, N'Lai Châu', N'Huyện Tân Uyên', N'Xã Tà Mít', N'32/45 đường 5B', N'Nguyễn Văn Toàn', N'0154654564', 1, 51)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (33, N'Tây Ninh', N'Huyện Bến Cầu', N'Xã Long Chữ', N'hẻm 5P ', N'Lê Thị Lụa', N'0975546467', 1, 52)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (34, N'Sơn La', N'Huyện Bắc Yên', N'Xã Hang Chú', N'30/34 hẻm  P4', N'Văn Thành', N'0765645647', 1, 53)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (35, N'Thanh Hóa', N'Huyện Quan Sơn', N'Xã Sơn Hà', N'34/45 đường  3A', N'Lê Văn Bông', N'0786546452', 1, 54)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (36, N'Tiền Giang', N'Thị xã Gò Công', N'Xã Long Hòa', N'số 40 đường 3/2', N'Nguyễn A Mười', N'0754535467', 1, 55)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (37, N'Thái Nguyên', N'Huyện Đại Từ', N'Xã La Bằng', N'số 30 đường 3A', N'Văn Cường', N'0676756542', 0, 51)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (38, N'Bến Tre', N'Huyện Châu Thành', N'Xã Phước Thạnh', N'Số 45 đường 3A', N'Văn Minh', N'0934554355', 0, 54)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (39, N'Tiền Giang', N'Huyện Châu Thành', N'Xã Long Định', N'Số 45 hẻm 45', N'Lê Văn Đình Ki', N'0935434543', 0, 52)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (40, N'Bạc Liêu', N'Huyện Hòa Bình', N'Xã Vĩnh Hậu A', N'2/26 đường 3A', N'Hùng Minh Sơn', N'0954354355', 0, 53)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (41, N'Vĩnh Phúc', N'Huyện Vĩnh Tường', N'Xã Lý Nhân', N'123 đường mới', N'Hà Vĩ Kiên', N'0955554646', 0, 55)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (42, N'Hòa Bình', N'Huyện Lương Sơn', N'Xã Cư Yên', N'số 23 hẻm cũ', N'Mã TIến An', N'0946686995', 0, 44)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (43, N'Sơn La', N'Huyện Mai Sơn', N'Xã Chiềng Chăn', N'Số 34 ', N'An Nguyễn', N'0954354434', 0, 42)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (44, N'Hải Dương', N'Huyện Cẩm Giàng', N'Xã Cẩm Điền', N'Số 153 đường AA', N'Trần Văn Vui', N'0978656437', 0, 44)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (45, N'Tuyên Quang', N'Thành phố Tuyên Quang', N'Xã Đội Cấn', N'Số 34 ', N'Lê Thị Giàu', N'0945645666', 0, 43)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (46, N'Quảng Bình', N'Huyện Lệ Thủy', N'Xã Liên Thủy', N'4/34 hẻm 33', N'Lê Thị Ngọc Bích', N'0934575677', 0, 41)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (47, N'Bình Thuận', N'Huyện Hàm Thuận Bắc', N'Xã Đa Mi', N'Số 12', N'Nguyễn Sad Di', N'0956577565', 0, 40)
INSERT [dbo].[shipping_address] ([shipping_address_id], [province], [district], [ward], [address_details], [name_receiver], [phone_receiver], [default_address], [users_id]) VALUES (48, N'Lạng Sơn', N'Huyện Lộc Bình', N'Xã Như Khuê', N'Số 23', N'Trần Văn Toàn', N'0974564565', 1, 50)
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

INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (11, N'Nike Vietnam', N'Tầng Trệt, TTTM Sense City. Số, 1 Đại lộ Hoà Bình, Tân An, Ninh Kiều, Cần Thơ', N'0292381969', N'nike123@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (12, N'Adidas Vietnam', N'Tầng 3, Tòa nhà 24T3 Thanh Xuân Complex, Số 6 Lê Văn Thiêm, Thanh Xuân Trung, Thanh Xuân, Hà Nội', N'0939348888', N'cskh@vuahanghieu.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (13, N'Biti''s', N'22 Lý Chiêu Hoàng, Phường 10, Quận 6, TP. Hồ Chí Minh', N'0387533443', N'bitts123@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (14, N'FILA Vietnam', N'25 Lý Chiêu Hoàng, Phường 10, Quận 6, TP. Hồ Chí Minh', N'0978646356', N'crv.fila@vn.centralretail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (15, N'Anta Vietnam', N'Số 5, ngõ 75, đường Hồng Hà, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'0974945488', N'online@arr.com.vn', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (16, N'New Balance Vietnam', N'Số 163, Phan Đăng Lưu, Phường 01, Phú Nhuận, Hồ Chí Minh, Việt Nam', N'0314635071', N'newbalance@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (17, N'Puma Vietnam', N'Số 163, Phan Đăng Lưu, Phường 01, Phú Nhuận, Hồ Chí Minh, Việt Nam', N'0988758476', N'puma@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (18, N'Giày Hồng Thái', N'82 Lê Lợi, Phường 2, TP. Cao Lãnh, Đồng Tháp', N'0277385842', N'thaidui123@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (19, N'Converse', N'79 Nguyễn Trãi, P.An Hội, Q.Ninh Kiều, , Cần Thơ', N'0956476354', N'converse@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (20, N'Dr.choice Sneaker', N'69, Ngô Quyền, Tân An, Cần Thơ', N'0978746574', N'choicesneaker@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (21, N'K-converse', N'4/2/74 Đinh Tiên Hoàng, Ninh Kiều', N'0945678986', N'kconverse@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (22, N'Bali sneaker', N'18T, hẻm 51, đường 3/2, Ninh Kiều, Cần Thơ', N'0968735143', N'balisneaker@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (23, N'Vans Store Cần Thơ', N'48 Trần Hưng Đạo, P. An Nghiệp, Ninh Kiều, Cần Thơ', N'0389521879', N'vanstore@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (24, N'K- CONS', N'76A Đinh Tiên Hoàng, Quận Ninh Kiều, Tp Cần Thơ.', N'0964006257', N'kcons@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (25, N'DC Store', N'31 Huỳnh Cương, An Cư, Ninh Kiều, Cần Thơ', N'0582042490', N'dcstore@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (26, N'Giày Xám Store', N'95 Nguyễn Việt Hồng, phường An Phú, Ninh Kiều, TP Cần Thơ', N'0946422171', N'gxamstore@gmail.com', 1, 0)
INSERT [dbo].[supplier] ([supplier_id], [supplier_name], [addresss], [phone], [email], [display], [deleted]) VALUES (27, N'MWC', N'41G Mậu Thân, Q.Ninh Kiều', N'0957789376', N'mwc@gmail.com', 1, 0)
SET IDENTITY_INSERT [dbo].[supplier] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (1, N'Bùi Thanh Bùi', N'123 Main St', N'0847686870', CAST(N'2011-12-01' AS Date), N'ADMIN', CAST(N'2023-08-10' AS Date), 1, N'BTB@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://images.hdqwalls.com/download/katarina-lol-minimal-4k-pi-315x315.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (2, N'Trần Văn Năm', N'456 Elm St', N'9879879897', CAST(N'1985-03-20' AS Date), N'ADMIN', CAST(N'2023-08-11' AS Date), 1, N'DBVR@gnail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image2.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (3, N'Lê Thị Ri', N'789 Oak St', N'0456456456', CAST(N'1995-07-05' AS Date), N'EMPLOYEE', CAST(N'2023-08-12' AS Date), 1, N'RCRC@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image3.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (4, N'Trần Thanh Hải', N'101 Pine St', N'0977866511', CAST(N'1980-11-30' AS Date), N'EMPLOYEE', CAST(N'2023-08-13' AS Date), 1, N'bob@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image4.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (5, N'Nguyễn Lê Văn Thi', N'202 Cedar St', N'0986543166', CAST(N'1988-09-25' AS Date), N'ADMIN', CAST(N'2023-08-14' AS Date), 1, N'NLVT@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image5.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (6, N'Jack Ma', N'303 Spruce St', N'0919919918', CAST(N'1992-05-10' AS Date), N'EMPLOYEE', CAST(N'2023-08-15' AS Date), 1, N'jack5milion@example.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'image6.jpg', 1, 1, N'DF')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (7, N'Quang Minh', N'123', N'0876491749', CAST(N'2022-10-10' AS Date), N'ADMIN', CAST(N'2022-12-20' AS Date), 1, N'minh@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', NULL, 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (36, N'Xin chào', N'Vinh', N'0989098765', CAST(N'1999-04-10' AS Date), N'CUSTOMER', CAST(N'2023-11-25' AS Date), 1, N'phamm7696@gmail.com', N'$2a$10$BJ0MfiMWVc1HYgT2cs6Ca.mMlTcALXyB4GNogtm3XF0VoANEW6te.', N'https://images.hdqwalls.com/download/super-saiyan-rose-5a-315x315.jpg', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (41, N'Lê Trung Khánh', N'Hà Nội', N'0987681649', CAST(N'1992-05-11' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'wesd4444@gmail.com', N'18c2409a9fb', N'https://images.hdqwalls.com/download/super-saiyan-rose-5a-315x315.jpg', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (42, N'Huynh Van Ni (FPL CT K17)', N'Cần Thơ', N'0948136411', CAST(N'1992-05-12' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'nihvpc04493@fpt.edu.vn', N'18c24ac7b8f', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (43, N'Nguyễn Đoàn Hải Anh', N'Khánh Hoà', N'0348163441', CAST(N'1992-05-13' AS Date), N'EMPLOYEE', CAST(N'2023-12-01' AS Date), 1, N'haianh@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (44, N'Diệp Anh Đào', N'Mỹ Tho', N'0124841286', CAST(N'1992-05-14' AS Date), N'EMPLOYEE', CAST(N'2023-12-01' AS Date), 1, N'SQLlv7@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (45, N'Bậc Thầy SQL', N'Đồng Nai', N'0764134767', CAST(N'1992-05-15' AS Date), N'ADMIN', CAST(N'2023-12-01' AS Date), 1, N'vusduy123@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (46, N'Thái Văn Vũ', N'Sydney', N'0512568518', CAST(N'1992-05-16' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'danhbeo0909@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (47, N'Đinh Danh Béo', N'Tokyo', N'0145558356', CAST(N'1992-05-17' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'madxitrum222@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (48, N'Mai Anh Đào', NULL, N'0909712491', CAST(N'1992-05-18' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'tuannguyenjava@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (49, N'Nguyễn Đăng Khôi', NULL, N'0876541247', CAST(N'1992-05-19' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'dangkhoi999@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (50, N'Tuân Nguyễn', NULL, N'0796912411', CAST(N'1992-05-20' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'tuannguyen000@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (51, N'Khánh Chương', NULL, N'0512561235', CAST(N'1992-05-21' AS Date), N'CUSTOMER', CAST(N'2023-12-01' AS Date), 1, N'khanhchuong@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'FB')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (52, N'DJ Thái Hoàng', NULL, N'0434141555', CAST(N'1992-05-21' AS Date), N'ADMIN', CAST(N'2023-12-01' AS Date), 1, N'thaihoangacademy@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
INSERT [dbo].[users] ([users_id], [full_name], [address], [phone], [birthday], [role], [created_date], [status], [email], [password], [image], [deleted], [activaties], [origin]) VALUES (53, N'Ben 10', NULL, N'0271459581', CAST(N'1992-05-17' AS Date), N'ADMIN', CAST(N'2023-12-01' AS Date), 1, N'ben10101010@gmail.com', N'$2a$12$2F5WMktqXXBTLDbX6LoGRuk6e5q4bVHTcdSyNkvrqiFHxQHLc81Wa', N'https://lh3.googleusercontent.com/a/ACg8ocIUF6LNyVhNb6YY1PVhkQ2azts8IIQsY4buTZKUAD8a=s96-c', 1, 1, N'GG')
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
INSERT [dbo].[voucher_use] ([use_date], [voucher_id], [users_id], [voucher_use_id], [saved]) VALUES (CAST(N'2023-11-27T10:40:52.000' AS DateTime), 1, 1, 5, 1)
INSERT [dbo].[voucher_use] ([use_date], [voucher_id], [users_id], [voucher_use_id], [saved]) VALUES (CAST(N'2023-11-27T16:25:53.000' AS DateTime), 1, 1, 6, 1)
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
ALTER TABLE [dbo].[review]  WITH CHECK ADD  CONSTRAINT [FK_review_order_detail] FOREIGN KEY([order_detail_id])
REFERENCES [dbo].[order_detail] ([order_detail_id])
GO
ALTER TABLE [dbo].[review] CHECK CONSTRAINT [FK_review_order_detail]
GO
ALTER TABLE [dbo].[voucher_use]  WITH CHECK ADD FOREIGN KEY([users_id])
REFERENCES [dbo].[users] ([users_id])
GO
ALTER TABLE [dbo].[voucher_use]  WITH CHECK ADD  CONSTRAINT [FK_voucher] FOREIGN KEY([voucher_id])
REFERENCES [dbo].[voucher] ([voucher_id])
GO
ALTER TABLE [dbo].[voucher_use] CHECK CONSTRAINT [FK_voucher]
GO
/****** Object:  StoredProcedure [dbo].[GetProductQuantityByMonthAndYear]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_InsertCartItem]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_InsertShippingAddress]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_updateCartItem]    Script Date: 03/12/2023 8:45:49 SA ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateDefault]    Script Date: 03/12/2023 8:45:49 SA ******/
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
