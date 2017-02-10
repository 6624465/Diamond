
/* 
=======================================================================
 START		[Master].[usp_QuotationItemSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[QuotationItem] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationItemSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationItemSelect] 
END 
GO
CREATE PROC [Master].[usp_QuotationItemSelect] 
    @QuotationNo varchar(50),
    @ItemID smallint
AS 
BEGIN 
	SELECT TOP (1000)	Q.[QuotationNo], Q.[ItemID], Q.[ProductCode], Q.[BarCode], Q.[SellRate],Q.CurrencyCode, Q.[Status], Q.[CreatedBy], Q.[CreatedOn], 
			Q.[ModifiedBy], Q.[ModifiedOn] ,ISNULL(P.Description,'') As ProductDescription,0 As RecordStatus
	FROM   [Master].[QuotationItem] Q
	Left Outer Join [Master].[Product] P ON 
		Q.ProductCode = P.ProductCode
	WHERE  [QuotationNo] = @QuotationNo 
	       AND [ItemID] = @ItemID 
END
GO

/* 
=======================================================================
 END		[Master].[usp_QuotationItemSelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_QuotationItemList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[QuotationItem] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationItemList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationItemList] 
END 
GO
CREATE PROC [Master].[usp_QuotationItemList] 
    @QuotationNo varchar(50) 
AS 
BEGIN 
	SELECT	 TOP (1000) Q.[QuotationNo], Q.[ItemID], Q.[ProductCode], Q.[BarCode], Q.[SellRate],Q.CurrencyCode, Q.[Status], Q.[CreatedBy], Q.[CreatedOn], 
			Q.[ModifiedBy], Q.[ModifiedOn] ,ISNULL(P.Description,'') As ProductDescription,0 As RecordStatus
	FROM   [Master].[QuotationItem] Q
	Left Outer Join [Master].[Product] P ON 
		Q.ProductCode = P.ProductCode
	WHERE  [QuotationNo] = @QuotationNo  
	       
END
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationItemSelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_QuotationItemInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[QuotationItem] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationItemInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationItemInsert] 
END 
GO
CREATE PROC [Master].[usp_QuotationItemInsert] 
    @QuotationNo varchar(50),
    @ItemID smallint,
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50),
    @SellRate decimal(18, 2),
	@CurrencyCode varchar(3),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 
	INSERT INTO [Master].[QuotationItem] (
			[QuotationNo], [ItemID], [ProductCode], [BarCode], [SellRate],CurrencyCode, [Status], [CreatedBy], [CreatedOn] )
	SELECT	@QuotationNo, @ItemID, @ProductCode, @BarCode, @SellRate,@CurrencyCode, @Status, @CreatedBy, GETDATE()
END	
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationItemInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_QuotationItemUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[QuotationItem] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationItemUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationItemUpdate] 
END 
GO
CREATE PROC [Master].[usp_QuotationItemUpdate] 
    @QuotationNo varchar(50),
    @ItemID smallint,
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50),
    @SellRate decimal(18, 2),
	@CurrencyCode varchar(3),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 

	UPDATE [Master].[QuotationItem]
	SET    [ProductCode] = @ProductCode, [BarCode] = @BarCode, [SellRate] = @SellRate,CurrencyCode=@CurrencyCode, [Status] = @Status, 
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE  [QuotationNo] = @QuotationNo
	       AND [ItemID] = @ItemID
END	
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationItemUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_QuotationItemSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[QuotationItem] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationItemSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationItemSave] 
END 
GO
CREATE PROC [Master].[usp_QuotationItemSave] 
    @QuotationNo varchar(50),
    @ItemID smallint,
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50),
    @SellRate decimal(18, 2),
	@CurrencyCode varchar(3),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 
Declare @dt DateTime,
	 @DocID varchar(50)
/*
Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @OrderNo OUTPUT
*/


	IF (SELECT COUNT(0) FROM [Master].[QuotationItem]
		WHERE 	[QuotationNo] = @QuotationNo
	       AND [ItemID] = @ItemID)>0
	BEGIN	
		EXEC [Master].[usp_QuotationItemUpdate] @QuotationNo, @ItemID, @ProductCode, @BarCode, @SellRate,@CurrencyCode, @Status, @CreatedBy,  @ModifiedBy 
	END
	Else
	BEGIN
	    EXEC [Master].[usp_QuotationItemInsert] @QuotationNo, @ItemID, @ProductCode, @BarCode, @SellRate,@CurrencyCode, @Status, @CreatedBy,  @ModifiedBy 
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationItemUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_QuotationItemDeleteAll]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[QuotationItem] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_QuotationItemDeleteAll]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationItemDeleteAll] 
END 
GO
CREATE PROC [Master].[usp_QuotationItemDeleteAll] 
    @QuotationNo varchar(50)
     
AS 
BEGIN 

	DELETE
	FROM   [Master].[QuotationItem]
	WHERE  [QuotationNo] = @QuotationNo

	return 1;
	       
END
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationItemDeleteAll]
=======================================================================
*/
 

/*
=======================================================================
START		[Master].[usp_QuotationItemDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record From [Master].[QuotationItem] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_QuotationItemDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationItemDelete] 
END 
GO
CREATE PROC [Master].[usp_QuotationItemDelete] 
    @QuotationNo varchar(50),
	@ItemID smallint
     
AS 
BEGIN 

	DELETE
	FROM   [Master].[QuotationItem]
	WHERE  [QuotationNo] = @QuotationNo
	And ItemID = @ItemID

	return 1;
	       
END
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationItemDeleteAll]
=======================================================================
*/
 



/* 
=======================================================================
 START		[Master].[usp_QuotationGetProductPrice]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[QuotationItem] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationGetProductPrice]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationGetProductPrice] 
END 
GO
CREATE PROC [Master].[usp_QuotationGetProductPrice] 
	@ProductCode varchar(50)
AS 
BEGIN 
	SELECT	Q.[QuotationNo], Q.[ItemID], Q.[ProductCode], Q.[BarCode], Q.[SellRate],Q.CurrencyCode, Q.[Status], Q.[CreatedBy], Q.[CreatedOn], 
			Q.[ModifiedBy], Q.[ModifiedOn] ,ISNULL(P.Description,'') As ProductDescription,0 As RecordStatus
	FROM   [Master].[QuotationItem] Q
	Left Outer Join [Master].[Product] P ON 
		Q.ProductCode = P.ProductCode
	WHERE  Q.ProductCode = @ProductCode 

END
GO

/* 
=======================================================================
 END		[Master].[usp_QuotationGetProductPrice]
=======================================================================
*/
