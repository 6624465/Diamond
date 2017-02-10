
/* 
=======================================================================
 START		[Master].[usp_ProductSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Product] Table

Exec [Master].[usp_ProductSelect] 'UST-001'

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_ProductSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductSelect] 
END 
GO
CREATE PROC [Master].[usp_ProductSelect] 
    @ProductCode nvarchar(50)
AS 
BEGIN 

	;With ProductCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='PRODUCTCATEGORY'),
	UOMCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='UOM'),
	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	[ProductCode], [BarCode], [UOM], [Size], [Color],Prd.BuyingPrice, Prd.SellingPrice, Prd.[Description], [ProductCategory], [CurrentQty],[ReorderQty],[Location], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn],
			ISNULL(pct.Description,'') As ProductCategoryDescription ,ISNULL(uom.Description,'') As UOMDescription, 
			ISNULL(Lc.Description,'') As LocationDescription
	FROM	[Master].[Product] Prd
	Left Outer Join ProductCategory Pct ON
		Prd.ProductCategory = pct.LookupCode
	Left Outer Join UOMCategory uom ON
		Prd.UOM = uom.LookupCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	WHERE	[ProductCode] = @ProductCode  
END
GO

/* 
=======================================================================
 END		[Master].[usp_ProductSelect]
=======================================================================
*/

/* 
=======================================================================
 START		[Master].[usp_ProductSelectByBarCodeOrDescription]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Product] Table

Exec [Master].[usp_ProductSelectByBarCodeOrDescription] N'?????? ????? 30 ml',N'?????? ????? 30 ml'

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_ProductSelectByBarCodeOrDescription]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductSelectByBarCodeOrDescription] 
END 
GO
CREATE PROC [Master].[usp_ProductSelectByBarCodeOrDescription] 
	@BarCode nvarchar(255) = NULL,
    @ProductDescription nvarchar(255) = NULL
AS 
BEGIN 

declare @SQL nvarchar(max);

Set @SQL= ';With ProductCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category=''PRODUCTCATEGORY''),
	UOMCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category=''UOM''),
	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category=''LOCATION'')
	SELECT	[ProductCode], [BarCode], [UOM], [Size], [Color],Prd.BuyingPrice, Prd.SellingPrice, Prd.[Description], [ProductCategory], [CurrentQty],[ReorderQty],[Location], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn],
			ISNULL(pct.Description,'''') As ProductCategoryDescription ,ISNULL(uom.Description,'''') As UOMDescription, ISNULL(Lc.Description,'''') As LocationDescription
	FROM	[Master].[Product] Prd
	Left Outer Join ProductCategory Pct ON
		Prd.ProductCategory = pct.LookupCode
	Left Outer Join UOMCategory uom ON
		Prd.UOM = uom.LookupCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	WHERE Prd.Status=CAST(1 as bit) And	Prd.[BarCode] = N''' + @BarCode + '''' + 
	+ ' UNION ' + 
	' SELECT	[ProductCode], [BarCode], [UOM], [Size], [Color],Prd.BuyingPrice, Prd.SellingPrice, Prd.[Description], [ProductCategory], [CurrentQty],[ReorderQty],[Location], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn],
			ISNULL(pct.Description,'''') As ProductCategoryDescription ,ISNULL(uom.Description,'''') As UOMDescription, ISNULL(Lc.Description,'''') As LocationDescription
	FROM	[Master].[Product] Prd
	Left Outer Join ProductCategory Pct ON
		Prd.ProductCategory = pct.LookupCode
	Left Outer Join UOMCategory uom ON
		Prd.UOM = uom.LookupCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	WHERE Prd.Status=CAST(1 as bit) And	Prd.[Description] = N''' + @ProductDescription  + '''';

	print @SQL

	exec sp_executesql @SQL 

END
GO

/* 
=======================================================================
 END		[Master].[usp_ProductSelectByBarCodeOrDescription]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_ProductList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[Product] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_ProductList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductList] 
END 
GO
CREATE PROC [Master].[usp_ProductList] 
AS 
BEGIN 
		
	;With ProductCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='PRODUCTCATEGORY'),
	UOMCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='UOM'),
	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	Top (1000) [ProductCode], [BarCode], [UOM], [Size], [Color],Prd.BuyingPrice, Prd.SellingPrice, Prd.[Description], [ProductCategory], [CurrentQty],[ReorderQty],[Location], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn],
			ISNULL(pct.Description,'') As ProductCategoryDescription ,ISNULL(uom.Description,'') As UOMDescription, ISNULL(Lc.Description,'') As LocationDescription
	FROM	[Master].[Product] Prd
	Left Outer Join ProductCategory Pct ON
		Prd.ProductCategory = pct.LookupCode
	Left Outer Join UOMCategory uom ON
		Prd.UOM = uom.LookupCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	Order by Prd.CreatedOn Desc
	
 

END
GO
/* 
=======================================================================
 END		[Master].[usp_ProductSelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_ProductInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[Product] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_ProductInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductInsert] 
END 
GO
CREATE PROC [Master].[usp_ProductInsert] 
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50),
    @UOM nvarchar(50),
    @Size nvarchar(50),
    @Color nvarchar(50),
	@BuyingPrice decimal(18,2),
	@SellingPrice decimal(18,2),
    @Description nvarchar(250),
    @ProductCategory nvarchar(50),
	@ReorderQty int,
	@Location nvarchar(50),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@NewProductCode nvarchar(50) OUTPUT
AS 
BEGIN 
	INSERT INTO [Master].[Product] (
			[ProductCode], [BarCode], [UOM], [Size], [Color],[BuyingPrice],[SellingPrice], [Description], [ProductCategory],ReOrderQty,Location, [Status], [CreatedBy], [CreatedOn])
	SELECT	@ProductCode, @BarCode, @UOM, @Size, @Color,@BuyingPrice,@SellingPrice, @Description, @ProductCategory,@ReorderQty,@Location, @Status, @CreatedBy, Getdate()

	SELECT @NewProductCode = @ProductCode

END	
GO
/* 
=======================================================================
 END		[Master].[usp_ProductInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_ProductUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[Product] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_ProductUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductUpdate] 
END 
GO
CREATE PROC [Master].[usp_ProductUpdate] 
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50),
    @UOM nvarchar(50),
    @Size nvarchar(50),
    @Color nvarchar(50),
	@BuyingPrice decimal(18,2),
	@SellingPrice decimal(18,2),
    @Description nvarchar(250),
    @ProductCategory nvarchar(50),
	@ReorderQty int,
	@Location nvarchar(50),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@NewProductCode varchar(50) OUTPUT
AS 
BEGIN 

	UPDATE	[Master].[Product]
	SET		[BarCode] = @BarCode,[Description] = @Description, [ProductCategory] = @ProductCategory, [Size]=@Size,[Color]=@Color,
			Buyingprice = @BuyingPrice, SellingPrice = @SellingPrice,UOM=@UOM,
			[Status] = @Status, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE(),ReorderQty=@ReorderQty,Location=@Location
	WHERE	[ProductCode] = @ProductCode


	SELECT @NewProductCode = @ProductCode
			 
END	
GO
/* 
=======================================================================
 END		[Master].[usp_ProductUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_ProductSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[Product] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_ProductSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductSave] 
END 
GO
CREATE PROC [Master].[usp_ProductSave] 
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50),
    @UOM nvarchar(50),
    @Size nvarchar(50),
    @Color nvarchar(50),
	@BuyingPrice decimal(18,2),
	@SellingPrice decimal(18,2),
    @Description nvarchar(250),
    @ProductCategory nvarchar(50),
	@ReorderQty int,
	@Location nvarchar(50),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@NewProductCode varchar(50) OUTPUT
AS 
BEGIN 

Declare @dt DateTime,
	 @DocID varchar(50),
	 @BranchID smallint =0


	IF (SELECT COUNT(0) FROM [Master].[Product]
		WHERE 	[ProductCode] = @ProductCode)>0
	BEGIN	
		EXEC [Master].[usp_ProductUpdate] @ProductCode, @BarCode, @UOM, @Size, @Color,@BuyingPrice,@SellingPrice, @Description, 
		@ProductCategory,@ReorderQty,@Location, @Status, @CreatedBy,  @ModifiedBy  ,@NewProductCode  = @NewProductCode OUTPUT  
	END
	Else
	BEGIN

		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 10,'Product', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()
		Select Top (1) @BranchID= ISNULL(BranchID,0)
		From master.Branch
		Order By BranchID 

		--Set @ProductCode=''
		--IF LEN(@ProductCode)=0
		--	Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, 'Product', @Dt ,@CreatedBy, @ProductCode OUTPUT
	
		 



	    EXEC [Master].[usp_ProductInsert] @ProductCode, @BarCode, @UOM, @Size, @Color,@BuyingPrice,@SellingPrice, @Description, @ProductCategory,
			@ReorderQty,@Location, @Status, @CreatedBy,  @ModifiedBy  ,@NewProductCode  = @NewProductCode OUTPUT 
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_ProductUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_ProductDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[Product] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_ProductDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductDelete] 
END 
GO
CREATE PROC [Master].[usp_ProductDelete] 
    @ProductCode nvarchar(50)
AS 
BEGIN 

/*
	DELETE
	FROM   [Master].[Product]
	WHERE  [ProductCode] = @ProductCode
*/

	Update Master.Product
	Set Status=Cast(0 as bit)
	WHERE  [ProductCode] = @ProductCode


	       
END
GO
/* 
=======================================================================
 END		[Master].[usp_ProductDelete]
=======================================================================
*/

 

 
/* 
=======================================================================
 START		[Master].[usp_ProductCheckDuplicate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Product] Table

Exec [Master].[usp_ProductCheckDuplicate] 'ruler'

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_ProductCheckDuplicate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductCheckDuplicate] 
END 
GO
CREATE PROC [Master].[usp_ProductCheckDuplicate] 
    @ProductDescription nvarchar(50),
	@BarCode nvarchar(50)
AS 
BEGIN 

	;With ProductCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='PRODUCTCATEGORY'),
	UOMCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='UOM'),
	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	[ProductCode], [BarCode], [UOM], [Size], [Color],Prd.BuyingPrice, Prd.SellingPrice, Prd.[Description], [ProductCategory], [CurrentQty],[ReorderQty],[Location], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn],
			ISNULL(pct.Description,'') As ProductCategoryDescription ,ISNULL(uom.Description,'') As UOMDescription, 
			ISNULL(Lc.Description,'') As LocationDescription
	FROM	[Master].[Product] Prd
	Left Outer Join ProductCategory Pct ON
		Prd.ProductCategory = pct.LookupCode
	Left Outer Join UOMCategory uom ON
		Prd.UOM = uom.LookupCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	WHERE	(Prd.[Description] = ISNULL(@ProductDescription,Prd.[Description])
	Or Prd.BarCode = ISNULL(@BarCode,Prd.BarCode))

END
GO

/* 
=======================================================================
 END		[Master].[usp_ProductCheckDuplicate]
=======================================================================
*/