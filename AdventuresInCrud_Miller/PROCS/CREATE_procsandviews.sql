USE [AdventureWorksLT2019]
GO
/****** Object:  StoredProcedure [dbo].[GreenView]    Script Date: 2/17/2021 5:08:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GreenView]
as
BEGIN
select GreenView_View.[Name], GreenView_View.ProductNumber, GreenView_View.Color, GreenView_View.StandardCost, GreenView_View.ListPrice, GreenView_View.Size,
GreenView_View.[Weight], GreenView_View.SellStartDate, GreenView_View.SellEndDate, GreenView_View.DiscontinuedDate, GreenView_View.ModifiedDate, GreenView_View.[Description],
GreenView_View.[Category Name]
from [dbo].[GreenView_View]
where GreenView_View.Culture = 'en'
order by GreenView_View.[Name]
end
GO

USE [AdventureWorksLT2019]
GO
/****** Object:  StoredProcedure [dbo].[YellowView]    Script Date: 2/17/2021 5:08:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[YellowView]
as
BEGIN
SELECT YellowView_View.CustomerID, YellowView_View.Title, YellowView_View.FirstName, YellowView_View.MiddleName, YellowView_View.LastName, YellowView_View.Suffix, YellowView_View.CompanyName, YellowView_View.SalesPerson, 
                  YellowView_View.EmailAddress, YellowView_View.Phone, YellowView_View.AddressType, YellowView_View.AddressLine1, YellowView_View.AddressLine2, YellowView_View.City, YellowView_View.StateProvince, 
                  YellowView_View.CountryRegion, YellowView_View.PostalCode
FROM     YellowView_View
END
GO

USE [AdventureWorksLT2019]
GO
/****** Object:  StoredProcedure [dbo].[getinfo]    Script Date: 2/17/2021 5:09:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getinfo]
@ID int
as
begin
SELECT YellowView_View.Title, YellowView_View.FirstName, YellowView_View.MiddleName, YellowView_View.LastName, YellowView_View.Suffix, YellowView_View.CompanyName, YellowView_View.SalesPerson, 
                  YellowView_View.EmailAddress, YellowView_View.Phone, YellowView_View.AddressType, YellowView_View.AddressLine1, YellowView_View.AddressLine2, YellowView_View.City, YellowView_View.StateProvince, 
                  YellowView_View.CountryRegion, YellowView_View.PostalCode
				  from YellowView_View
				  where CustomerID = @ID
				  end
GO

USE [AdventureWorksLT2019]
GO
/****** Object:  StoredProcedure [dbo].[UpdateCustomerAddress]    Script Date: 2/17/2021 5:10:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateCustomerAddress]
@ID int,
@title nvarchar(8),
@firstname nvarchar(50),
@middlename nvarchar(50),
@lastname nvarchar(50),
@suffix nvarchar(10),
@companyname nvarchar(128),
@salesperson nvarchar(256),
@emailaddress nvarchar(50),
@phone nvarchar(25),
@addresstype nvarchar(50),
@addressline1 nvarchar(60),
@addressline2 nvarchar(60),
@city nvarchar(30),
@stateprovince nvarchar(50),
@countryregion nvarchar(50),
@postalcode nvarchar(15)
as
declare @addressID int
begin
update [SalesLT].[CustomerAddress] set [AddressType] = @addresstype
from SalesLT.CustomerAddress where [CustomerID] = @ID;
update [SalesLT].[Customer] set [Title] = @title,
								[FirstName] = @firstname,
								[MiddleName] = @middlename,
								[LastName] = @lastname,
								[Suffix] = @suffix,
								[CompanyName] = @companyname,
								[SalesPerson] = @salesperson,
								[EmailAddress] = @emailaddress,
								[Phone] = @phone
from SalesLT.Customer where [CustomerID] = @ID;
set @addressID = (select [AddressID] from [SalesLT].[CustomerAddress] where [CustomerID] = @ID)
update [SalesLT].[Address] set [AddressLine1] = @addressline1,
								[AddressLine2] = @addressline2,
								[City] = @city,
								[StateProvince] = @stateprovince,
								[CountryRegion] = @countryregion,
								[PostalCode] = @postalcode
from SalesLT.Customer where [AddressID] = @addressID;
end
GO

USE [AdventureWorksLT2019]
GO
/****** Object:  StoredProcedure [dbo].[DeleteCustomer]    Script Date: 2/17/2021 5:10:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[DeleteCustomer]
@ID int
as
begin
ALTER TABLE [SalesLT].[CustomerAddress]  WITH CHECK ADD  CONSTRAINT [DeleteConstraint] FOREIGN KEY([CustomerID])
REFERENCES [SalesLT].[Customer] ([CustomerID])
ON DELETE CASCADE
delete from SalesLT.Customer where CustomerID=@ID;
delete from SalesLT.CustomerAddress where CustomerID=@ID;
delete from SalesLT.SalesOrderHeader where CustomerID=@ID;
ALTER TABLE [SalesLT].[CustomerAddress] drop CONSTRAINT [DeleteConstraint]
end
GO

USE [AdventureWorksLT2019]
GO
/****** Object:  StoredProcedure [dbo].[addNewAddress]    Script Date: 2/17/2021 5:11:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[addNewAddress]
@addressline1 nvarchar(60),
@addressline2 nvarchar(60),
@city nvarchar(30),
@stateprovince nvarchar(50),
@countryregion nvarchar(50),
@postalcode nvarchar(15)
as
begin
insert into SalesLT.[Address] (AddressLine1, AddressLine2, City, StateProvince, CountryRegion, PostalCode,ModifiedDate)
values (@addressline1, @addressline2, @city, @stateprovince, @countryregion, @postalcode, GETDATE())
end
GO

USE [AdventureWorksLT2019]
GO
/****** Object:  StoredProcedure [dbo].[addNewCustomer]    Script Date: 2/17/2021 5:11:14 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[addNewCustomer]
@title nvarchar(8),
@firstname nvarchar(50),
@middlename nvarchar(50),
@lastname nvarchar(50),
@suffix nvarchar(10),
@companyname nvarchar(128),
@salesperson nvarchar(256),
@emailaddress nvarchar(50),
@phone nvarchar(25)
as
begin
insert into SalesLT.Customer (NameStyle, Title, FirstName, MiddleName, LastName, Suffix, CompanyName, SalesPerson, EmailAddress, Phone, PasswordHash, PasswordSalt)
values (0, @title, @firstname, @middlename, @lastname, @suffix, @companyname, @salesperson, @emailaddress, @phone, 'passhash', 'passsalt')
end
GO

USE [AdventureWorksLT2019]
GO
/****** Object:  StoredProcedure [dbo].[addNewCustomerAddress]    Script Date: 2/17/2021 5:11:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[addNewCustomerAddress]
@addresstype nvarchar(50)
as
begin
declare @customerID int,
@addressID int
set @customerID = (select top(1) [CustomerID] from SalesLT.Customer order by CustomerID desc)
set @addressID = (select top(1) [AddressID] from SalesLT.[Address] order by AddressID desc)
insert into SalesLT.CustomerAddress (CustomerID, AddressID, AddressType, ModifiedDate)
values (@customerID, @addressID, @addresstype, GETDATE())
end
GO

USE [AdventureWorksLT2019]
GO

/****** Object:  View [dbo].[GreenView_View]    Script Date: 2/17/2021 5:18:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GreenView_View]
AS
SELECT SalesLT.Product.Name, SalesLT.Product.ProductNumber, SalesLT.Product.Color, SalesLT.Product.StandardCost, SalesLT.Product.ListPrice, SalesLT.Product.Size, SalesLT.Product.Weight, SalesLT.Product.SellStartDate, 
                  SalesLT.Product.SellEndDate, SalesLT.Product.DiscontinuedDate, SalesLT.ProductCategory.Name AS [Category Name], SalesLT.ProductDescription.Description, SalesLT.ProductModel.Name AS [Model Name], 
                  SalesLT.ProductModelProductDescription.Culture, SalesLT.Product.ModifiedDate
FROM     SalesLT.Product INNER JOIN
                  SalesLT.ProductCategory ON SalesLT.Product.ProductCategoryID = SalesLT.ProductCategory.ProductCategoryID INNER JOIN
                  SalesLT.ProductModel ON SalesLT.Product.ProductModelID = SalesLT.ProductModel.ProductModelID INNER JOIN
                  SalesLT.ProductModelProductDescription ON SalesLT.ProductModel.ProductModelID = SalesLT.ProductModelProductDescription.ProductModelID INNER JOIN
                  SalesLT.ProductDescription ON SalesLT.ProductModelProductDescription.ProductDescriptionID = SalesLT.ProductDescription.ProductDescriptionID
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Product (SalesLT)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 315
            End
            DisplayFlags = 280
            TopColumn = 13
         End
         Begin Table = "ProductCategory (SalesLT)"
            Begin Extent = 
               Top = 7
               Left = 363
               Bottom = 170
               Right = 626
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductDescription (SalesLT)"
            Begin Extent = 
               Top = 7
               Left = 674
               Bottom = 170
               Right = 911
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductModel (SalesLT)"
            Begin Extent = 
               Top = 7
               Left = 959
               Bottom = 170
               Right = 1182
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductModelProductDescription (SalesLT)"
            Begin Extent = 
               Top = 7
               Left = 1230
               Bottom = 170
               Right = 1467
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         W' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GreenView_View'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'idth = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GreenView_View'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GreenView_View'
GO

USE [AdventureWorksLT2019]
GO

/****** Object:  View [dbo].[YellowView_View]    Script Date: 2/17/2021 5:20:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[YellowView_View]
AS
SELECT SalesLT.Customer.Title, SalesLT.Customer.FirstName, SalesLT.Customer.MiddleName, SalesLT.Customer.LastName, SalesLT.Customer.Suffix, SalesLT.Customer.CompanyName, SalesLT.Customer.SalesPerson, 
                  SalesLT.Customer.EmailAddress, SalesLT.Customer.Phone, SalesLT.CustomerAddress.AddressType, SalesLT.Address.AddressLine1, SalesLT.Address.AddressLine2, SalesLT.Address.City, SalesLT.Address.StateProvince, 
                  SalesLT.Address.CountryRegion, SalesLT.Address.PostalCode, SalesLT.Customer.CustomerID
FROM     SalesLT.Address FULL OUTER JOIN
                  SalesLT.CustomerAddress ON SalesLT.Address.AddressID = SalesLT.CustomerAddress.AddressID FULL OUTER JOIN
                  SalesLT.Customer ON SalesLT.CustomerAddress.CustomerID = SalesLT.Customer.CustomerID
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Address (SalesLT)"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CustomerAddress (SalesLT)"
            Begin Extent = 
               Top = 7
               Left = 536
               Bottom = 170
               Right = 730
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Customer (SalesLT)"
            Begin Extent = 
               Top = 7
               Left = 290
               Bottom = 170
               Right = 488
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'YellowView_View'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'YellowView_View'
GO

