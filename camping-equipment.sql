USE [CAMPING_WEBSHOP]
GO
/****** Object:  Table [dbo].[CartItems]    Script Date: 5/19/2020 2:14:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartItems](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [float] NOT NULL,
	[ProId] [int] NOT NULL,
	[CartId] [int] NOT NULL,
 CONSTRAINT [PK__CartItem__3214EC0704141BF6] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Carts]    Script Date: 5/19/2020 2:14:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[BuyDate] [date] NULL,
	[Name] [nvarchar](50) NULL,
	[Phone] [nchar](10) NULL,
	[Email] [nvarchar](50) NULL,
	[Address] [nvarchar](150) NULL,
	[Note] [nvarchar](200) NULL,
	[Payment] [nvarchar](100) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK__Carts__3214EC0718967049] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 5/19/2020 2:14:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CateId] [int] IDENTITY(1,1) NOT NULL,
	[CateName] [nvarchar](255) NOT NULL,
	[CateImage] [nvarchar](500) NULL,
	[Display] [bit] NOT NULL,
 CONSTRAINT [PK__Categori__27638D142D0C84FA] PRIMARY KEY CLUSTERED 
(
	[CateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 5/19/2020 2:14:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Price] [float] NULL,
	[Discount] [float] NULL,
	[CateId] [int] NOT NULL,
	[Description] [nvarchar](2000) NULL,
	[Information] [nvarchar](2000) NULL,
	[Image] [nvarchar](500) NULL,
	[Display] [bit] NOT NULL,
 CONSTRAINT [PK__Products__3214EC078D14CE25] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 5/19/2020 2:14:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nchar](10) NOT NULL,
	[Address] [nvarchar](150) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](36) NOT NULL,
	[Avatar] [nvarchar](500) NULL,
	[RoleId] [int] NOT NULL,
	[Lock] [bit] NOT NULL,
 CONSTRAINT [PK__Users__3214EC072ADE063C] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[CartItems] ON 

INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (43, 1, 230000, 29, 3)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (45, 2, 230000, 29, 4)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (73, 1, 177000, 2, 2)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (74, 2, 325000, 1, 2)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (75, 10, 230000, 29, 2)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (76, 10, 950000, 22, 4)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (80, 1, 300000, 27, 9)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (96, 1, 1480000, 11, 13)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (100, 7, 300000, 27, 17)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (106, 1, 325000, 1, 13)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (130, 2, 2120000, 25, 1)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (131, 4, 325000, 1, 1)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (132, 1, 420000, 21, 1)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (138, 1, 1280000, 23, 24)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (142, 1, 202500, 9, 29)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (304, 10, 120000, 6, 33)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (307, 1, 1280000, 23, 39)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (308, 2, 177000, 2, 12)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (319, 1, 420000, 21, 38)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (320, 1, 455400, 28, 15)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (321, 100, 2120000, 25, 47)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (324, 1, 0, 28, 48)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (325, 1, 1870000, 26, 48)
INSERT [dbo].[CartItems] ([Id], [Quantity], [UnitPrice], [ProId], [CartId]) VALUES (328, 6, 300000, 27, 48)
SET IDENTITY_INSERT [dbo].[CartItems] OFF
SET IDENTITY_INSERT [dbo].[Carts] ON 

INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (1, 4, CAST(N'2019-09-21' AS Date), N'Trần Văn Dần', N'0326779770', N'hoale20061998@gmail.com', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'boom hàng', N'COD', 2)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (2, 5, CAST(N'2019-10-21' AS Date), N'Nude Tiger', N'0123456789', N'quanjoker25998@gmail.com', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'giao buổi sáng', N'COD', 3)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (3, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (4, 9, NULL, N'Lê Hồng Quân', N'0326779770', N'quanjoker25998@gmail.com', N'48, Man Thiện, P.Hiệp Phú, Quận 9', N'đừng giao', NULL, NULL)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (9, 5, CAST(N'2019-10-21' AS Date), N'Nude Tiger', N'0123456789', N'quanjoker25998@gmail.com', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'abc', N'VISA', 3)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (11, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (12, 5, CAST(N'2019-10-21' AS Date), N'Nude Tiger', N'0326779770', N'quanjoker25998@gmail.com', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'a', N'PAYPAL', 3)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (13, 5, CAST(N'2019-10-26' AS Date), N'Quân lê', N'0326779770', N'quanjoker25998@gmail.com', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'', N'COD', 2)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (14, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (15, 5, CAST(N'2019-11-22' AS Date), N'mess', N'0326779770', N'quanjoker25998@gmail.com', N'48, Man Thiện, P.Tăng Nhơn Phú A, Q.9', N'', N'COD', 0)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (17, 13, CAST(N'2019-10-29' AS Date), N'Lê Hồng Quân', N'0326779770', N'quanjoker25998@gmail.com', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'', N'COD', 3)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (18, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (24, 1, CAST(N'2019-11-09' AS Date), N'a', N'0326779770', N'giacsonklc@gmail.com', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'', N'VISA', 2)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (29, 1, CAST(N'2019-11-09' AS Date), N'a', N'0326779770', N'congtykimloan@yahoo.com.vn', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'', N'VISA', 3)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (33, 1, CAST(N'2019-11-15' AS Date), N'Lê Hồng Quân', N'0326779770', N'congtykimloan@yahoo.com.vn', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'ok', N'PAYPAL', 2)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (37, 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (38, 1, CAST(N'2019-11-15' AS Date), N'rô bớt chen', N'0326779770', N'robertchen@yahoo.com.vn', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'boom', N'IB', 0)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (39, 1, CAST(N'2019-11-15' AS Date), N'Lê Hồng Quân', N'0326779770', N'hoale20061998@gmail.com', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'test', N'VISA', 3)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (40, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (47, 5, CAST(N'2019-11-22' AS Date), N'messi', N'0326779770', N'quanjoker25998@gmail.com', N'48, Man Thiện, P.Tăng Nhơn Phú A, Q.9', N'boom hàng', N'COD', 0)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (48, 5, CAST(N'2019-11-26' AS Date), N'rô bớt chen', N'0326779770', N'quanjoker25998@gmail.com', N'48, Man Thiện, P.Tăng Nhơn Phú A, Quận 9', N'', N'COD', 1)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (49, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Carts] ([Id], [UserId], [BuyDate], [Name], [Phone], [Email], [Address], [Note], [Payment], [Status]) VALUES (50, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Carts] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CateId], [CateName], [CateImage], [Display]) VALUES (1, N'DAO ĐI RỪNG', N'images/category-image/knife.jpg', 0)
INSERT [dbo].[Categories] ([CateId], [CateName], [CateImage], [Display]) VALUES (2, N'NẤU ĂN', N'images/category-image/cook.png', 1)
INSERT [dbo].[Categories] ([CateId], [CateName], [CateImage], [Display]) VALUES (3, N'LỀU CẮM TRẠI', N'images/category-image/shelter.jpg', 1)
INSERT [dbo].[Categories] ([CateId], [CateName], [CateImage], [Display]) VALUES (4, N'BÀN GHẾ', N'images/category-image/chair.png', 1)
INSERT [dbo].[Categories] ([CateId], [CateName], [CateImage], [Display]) VALUES (5, N'ĐÈN PIN', N'images/category-image/flashlight.png', 1)
INSERT [dbo].[Categories] ([CateId], [CateName], [CateImage], [Display]) VALUES (6, N'PHỤ KIỆN DÃ NGOẠI', N'images/category-image/pkdn.png', 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (1, N'DAO TIGER', 650000, 0.5, 1, N'Tiger, là mẫu dao mạnh mẽ, ưu việt nhất mà chúng tôi muốn gửi đến Quý anh chị. Vừa là vật kỉ niệm, treo trang trí trong phòng. Vừa đủ để dùng khi đi cắm trại, đi rừng. Từ chặt, gọt, cho đến thái, chế biến các món ăn', N'Chiều dài lưỡi dao:	20cm
Chiều dài cán dao:	12cm
Chiều dài vỏ dao:	24cm
Chiều dài tổng khi cho dao vào bao:	34cm
Chất liệu thép:	Thép 60Si2 (Nhíp Oto)
Chất liệu gỗ:	Gỗ Cẩm Chỉ
Trọng lượng dao:	~ 290gram
Trọng lượng cả vỏ dao:	~ 480gram
Xuất xứ:	Rèn thủ công bởi anh em thợ rèn đồng bào Tày – Cao Bằng
Bộ sản phẩm bao gồm:	Dao và Vỏ Gỗ Cẩm Chỉ', N'https://hoabancamp.com/wp-content/uploads/2019/03/Dao-Di-Rung-Tiger-cover-1.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (2, N'DAO FIRE', 590000, 0.699999988079071, 1, N'', N'', N'https://hoabancamp.com/wp-content/uploads/2019/03/Dao-Di-Rung-Fire-1.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (3, N'Bình Nước Dã Ngoại NatureHike', 129000, 0, 2, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/03/Nuoc-NatureHike-NH14S002-T-cover-510x340.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (4, N'Đầu Chuyển Bếp Gas Dã Ngoại', 95000, 0, 2, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/08/%C4%90%E1%BA%A7u-N%E1%BB%91i-Chuy%E1%BB%83n-%C4%90%E1%BB%95i-B%E1%BA%BFp-Gas-D%C3%A3-Ngo%E1%BA%A1i_8-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (5, N'Bộ Lọ Đựng Gia Vị Dã Ngoại NatureHike', 120000, 0.4, 2, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/03/Gia-Vi-NatureHike-NH17T011-P-14-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (6, N'Tấm Chắn Gió NatureHike', 120000, 0, 2, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/05/Chan-gio-NatureHike-NH15F008-B-cover1-510x341.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (7, N'Thìa Dĩa Titanium Gấp Gọn NatureHike', 180000, 0, 2, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/07/B%E1%BB%99-Th%C3%ACa-D%C4%A9a-Titanium-G%E1%BA%A5p-G%E1%BB%8Dn-NatureHike-NH19C001-J_cover_dia-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (8, N'Bình Pha Trà, Hoa Quả NatureHike', 230000, 0, 2, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/08/B%C3%ACnh-Pha-Tr%C3%A0-Hoa-Qu%E1%BA%A3-NatureHike-NH19S003-B_13-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (9, N'Bếp Cồn Dã Ngoại NatureHike', 270000, 0.25, 2, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/03/Bep-NatureHike-NH18L001-T-08-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (10, N'Lều 2 Người NatureHike', 1380000, 0, 3, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/03/Leu-NatureHike-P-Series-NH18Z022-P-03-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (11, N'Lều 3 Người NatureHike', 1480000, 0, 3, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/03/Leu-NatureHike-P-Series-NH18Z022-P-cover-orange-510x340.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (12, N'Màn Võng NatureHike', 220000, 0, 3, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/08/M%C3%A0n-V%C3%B5ng-NatureHike-NH18D003-C_cover-510x340.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (13, N'Tăng Dã Ngoại Lục Giác NatureHike', 790000, 0.3, 3, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/05/T%C4%83ng-Che-N%E1%BA%AFng-NatureHike-NH16T012-S-Green-L-cover-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (14, N'Võng Đơn Siêu Nhẹ NatureHike', 300000, 0, 3, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/04/V%C3%B5ng-%C4%90%C6%A1n-NatureHike-NH17D012-C-orange-cover-510x341.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (15, N'Túi Ngủ Đôi Kèm Gối NatureHike', 700000, 0.2, 3, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/04/Tui-Ngu-Doi-NatureHike-SD15M030-J_01-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (16, N'Gối Hơi Lót Nhung NatureHike', 145000, 0, 3, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/07/G%E1%BB%91i-H%C6%A1i-L%C3%B3t-Nhung-NatureHike-NH15A001-L_cover_brown-510x288.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (17, N'Gối Hơi Bơm Tay NatureHike', 220000, 0, 3, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/07/G%E1%BB%91i-H%C6%A1i-B%C6%A1m-Tay-NatureHike-NH18B020-T-New-2019_cover_blue-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (18, N'Thảm Dã Ngoại Cách Nhiệt NatureHike', 280000, 0, 3, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/05/Tham-NatureHike-NH17Y020-M-cover_violet-1-510x341.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (19, N'Ghế Xếp Nhôm Dã Ngoại NatureHike', 270000, 0, 4, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/06/Ghe-Gap-NatureHike-NH15D012-B-02-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (20, N'Ghế Tựa Siêu Gọn NatureHike', 280000, 0, 4, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/07/Gh%E1%BA%BF-T%E1%BB%B1a-Si%C3%AAu-G%E1%BB%8Dn-NatureHike-NH18M001-Z_cover1_khaki-510x286.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (21, N'Bàn Dã Ngoại Siêu Nhẹ NatureHike', 420000, 0, 4, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/03/NH15Z012-L-cover-510x340.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (22, N'Ghế Dã Ngoại NatureHike', 950000, 0, 4, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/05/Ghe-NatureHike-Folding-Moon-NH18Y050-Z-gray-cover-510x340.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (23, N'Đèn pin Olight R18', 1280000, 0, 5, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/03/Olight-R18-2-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (24, N'Đèn pin Fenix UC30', 1490000, 0, 5, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/05/Den-Pin-Fenix-UC30-1-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (25, N'Đèn pin Fenix FD41', 2120000, 0, 5, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/03/Fenix-FD41-cover-2-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (26, N'Đèn pin Đeo Đầu Fenix HL60R', 1870000, 0, 5, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/03/Fenix-HL60R-1-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (27, N'Đèn Treo Lều Sạc USB NatureHike', 300000, 0, 5, NULL, NULL, N'https://hoabancamp.com/wp-content/uploads/2019/05/Den-Leu-NatureHike-NH16D300-C-blue-cover-510x340.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (28, N'Pin Olight 18650 ORB - 3600mAh', 460000, 1, 5, N'', N'', N'https://hoabancamp.com/wp-content/uploads/2019/08/Pin-Olight-18650-ORB-186C36-%E2%80%93-3600mAh-510x287.jpg', 1)
INSERT [dbo].[Products] ([Id], [Name], [Price], [Discount], [CateId], [Description], [Information], [Image], [Display]) VALUES (29, N'Đế Sạc Olight Micro-Dok III', 230000, 0.1, 5, N'Olight Micro-Dok III là phiên bản thứ ba của dock sạc từ tính được cấp nguồn Micro USB từ Olight. Đế sạc cung cấp dòng sạc 1A. Đây là một bộ sạc bổ sung tùy chọn cho các mẫu đèn Olight S-Series Olight S1R, S2R, S10R III, S30R II, S30R III, H1R Nova và H2R Nova.', N'Đế Sạc Olight Micro-Dok III Là Tùy Chọn Bổ Sung Cho Các Mẫu Đèn Olight S-Series, H1R, H2R
Đế sạc bao gồm đèn LED báo sạc, cổng USB để cấp nguồn cho bộ sạc, đáy đế sạc là các giác hút giúp giữ vững chân đế và cổng sạc nam châm để sạc đèn khi đặt lên.


Các Thành Phần Của Đế Sạc Olight Micro-Dok III
Đế Sạc Đã Bao Gồm 1 Dây Mciro USB


Đế Sạc Olight Micro-Dok III Bao Gồm 1 Dây Micro USB Đi Kèm', N'images/product-image/Fenix-CL26R-Red-Cover.jpg', 0)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [Name], [Email], [Phone], [Address], [Username], [Password], [Avatar], [RoleId], [Lock]) VALUES (1, N'admin', N'admin0908@gmail.com', N'0323456789', N'48, Man Thiện, Q9', N'admin', N'admin', N'images/avatar/tran_dan.jpg', 1, 0)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Phone], [Address], [Username], [Password], [Avatar], [RoleId], [Lock]) VALUES (4, N'Khach', N'guest1@gmail.com', N'0326779770', N'48, Man Thiện, P.Hiệp Phú, Quận 9', N'guest1', N'guest1', N'images/avatar/na`vi.png', 0, 1)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Phone], [Address], [Username], [Password], [Avatar], [RoleId], [Lock]) VALUES (5, N'rô bớt chen', N'quanjoker25998@gmail.com', N'0326779770', N'48, Man Thiện, P.Tăng Nhơn Phú A, Quận 9', N'quan', N'123', N'images/avatar/Ahihi.jpg', 0, 1)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Phone], [Address], [Username], [Password], [Avatar], [RoleId], [Lock]) VALUES (8, N'Lê Hồng Quân', N'test1@gmail.com', N'0326779770', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'quanjoker259', N'123', N'images/avatar/cover_1.jpg', 0, 1)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Phone], [Address], [Username], [Password], [Avatar], [RoleId], [Lock]) VALUES (9, N'test', N'hoale20061998@gmail.com', N'0326779770', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'test', N'123', N'images/avatar/face.jpg', 0, 1)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Phone], [Address], [Username], [Password], [Avatar], [RoleId], [Lock]) VALUES (11, N'abc', N'test2@gmail.com', N'0326779770', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'abc', N'a', N'images/avatar/Cover.jpg', 0, 1)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Phone], [Address], [Username], [Password], [Avatar], [RoleId], [Lock]) VALUES (13, N'Lê Hồng Quân', N'test3@gmail.com', N'0326779770', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'test123', N'123123', N'images/avatar/profile-pic.jpg', 0, 1)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Phone], [Address], [Username], [Password], [Avatar], [RoleId], [Lock]) VALUES (18, N'test004', N'test004@gmail.com', N'0326779770', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'testuser', N'123', N'images/avatar/valk 3 stickerless.png', 0, 1)
INSERT [dbo].[Users] ([Id], [Name], [Email], [Phone], [Address], [Username], [Password], [Avatar], [RoleId], [Lock]) VALUES (19, N'abc', N'test005@gmail.com', N'0326779770', N'48, Man Thiện, P.Hiệp Phú, Quận9', N'test005', N'123', N'images/avatar/ẩn sản phẩm.png', 0, 1)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Users__536C85E4A2F8190E]    Script Date: 5/19/2020 2:14:47 PM ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ__Users__536C85E4A2F8190E] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK__CartItems__CartI__1BFD2C07] FOREIGN KEY([CartId])
REFERENCES [dbo].[Carts] ([Id])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK__CartItems__CartI__1BFD2C07]
GO
ALTER TABLE [dbo].[CartItems]  WITH CHECK ADD  CONSTRAINT [FK__CartItems__ProId__1B0907CE] FOREIGN KEY([ProId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[CartItems] CHECK CONSTRAINT [FK__CartItems__ProId__1B0907CE]
GO
ALTER TABLE [dbo].[Carts]  WITH CHECK ADD  CONSTRAINT [FK__Carts__UserId__182C9B23] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Carts] CHECK CONSTRAINT [FK__Carts__UserId__182C9B23]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK__Products__CateId__15502E78] FOREIGN KEY([CateId])
REFERENCES [dbo].[Categories] ([CateId])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK__Products__CateId__15502E78]
GO
