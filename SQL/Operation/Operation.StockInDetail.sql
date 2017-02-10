

/* 
=======================================================================
 START		[Operation].[usp_StockInDetailSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[StockInDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_StockInDetailSelect] 
    @DocumentNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50)
AS 
BEGIN 


	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	Dt.[DocumentNo], Dt.[ItemNo], Dt.[ProductCode], Dt.[BarCode], Dt.[Quantity], Dt.[CreatedBy], Dt.[CreatedOn], 
			Dt.[ModifiedBy], Dt.[ModifiedOn] ,dt.Quantity As POQty,0 As PendingQty ,
			ISNULL(Prd.Description,'') As ProductDescription,Dt.BuyingPrice,(Dt.Quantity * Dt.BuyingPrice) As BuyingAmount,
			Dt.OutQuantity,ISNULL(Dt.Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription
	FROM   [Operation].[StockInDetail] Dt
	Left Outer Join [Master].[Product] Prd ON 
		Dt.ProductCode = Prd.ProductCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	WHERE  Dt.[DocumentNo] = @DocumentNo 
	       AND Dt.[ItemNo] = @ItemNo 
	       AND Dt.[ProductCode] = @ProductCode 
	       AND Dt.[BarCode] = @BarCode 
END
GO

/* 
=======================================================================
 END		[Operation].[usp_StockInDetailSelect]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_StockInDetailList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Operation].[StockInDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInDetailList] 
END 
GO
CREATE PROC [Operation].[usp_StockInDetailList] 
    @DocumentNo varchar(50)
     
AS 
BEGIN 

	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	Dt.[DocumentNo], Dt.[ItemNo], Dt.[ProductCode], Dt.[BarCode], Dt.[Quantity], Dt.[CreatedBy], Dt.[CreatedOn], 
			Dt.[ModifiedBy], Dt.[ModifiedOn] ,dt.Quantity As POQty,0 As PendingQty ,
			ISNULL(Prd.Description,'') As ProductDescription,Dt.BuyingPrice,(Dt.Quantity * Dt.BuyingPrice) As BuyingAmount,
			Dt.OutQuantity,ISNULL(Dt.Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription
	FROM	[Operation].[StockInDetail] Dt
	Left Outer Join [Master].[Product] Prd ON 
			Dt.ProductCode = Prd.ProductCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	WHERE  Dt.[DocumentNo] = @DocumentNo 
	        
END
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInDetailSelect]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_StockInDetailInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Operation].[StockInDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_StockInDetailInsert] 
    @DocumentNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50),
    @Quantity float,
	@BuyingPrice decimal(18,2),
	@Location nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 
	INSERT INTO [Operation].[StockInDetail] (
			[DocumentNo], [ItemNo], [ProductCode], [BarCode], [Quantity],BuyingPrice, [CreatedBy], [CreatedOn],OutQuantity,Location )
	SELECT	@DocumentNo, @ItemNo, @ProductCode, @BarCode, @Quantity,@BuyingPrice, @CreatedBy, GETDATE(),0,@Location
END	

GO
/* 
=======================================================================
 END		[Operation].[usp_StockInDetailInsert]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_StockInDetailUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Operation].[StockInDetail] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_StockInDetailUpdate] 
     @DocumentNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50),
    @Quantity float,
	@BuyingPrice decimal(18,2),
	@Location nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 

	UPDATE [Operation].[StockInDetail]
	SET    [Quantity] = @Quantity, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE(),
		   BuyingPrice=	@BuyingPrice,	Location =@Location


	WHERE  [DocumentNo] = @DocumentNo
	       AND [ItemNo] = @ItemNo
	       AND [ProductCode] = @ProductCode
	       AND [BarCode] = @BarCode
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInDetailUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_StockInDetailSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Operation].[StockInDetail] Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_StockInDetailSave] 
     @DocumentNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50),
    @Quantity float,
	@BuyingPrice decimal(18,2),
	@Location nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 
Declare @dt DateTime,
	 @DocID varchar(50)
/*
Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @OrderNo OUTPUT
*/


	IF (SELECT COUNT(0) FROM [Operation].[StockInDetail]
		WHERE 	[DocumentNo] = @DocumentNo
	       AND [ItemNo] = @ItemNo
	       AND [ProductCode] = @ProductCode
	       AND [BarCode] = @BarCode)>0
	BEGIN	
		EXEC [Operation].[usp_StockInDetailUpdate] @DocumentNo, @ItemNo, @ProductCode, @BarCode, @Quantity,@BuyingPrice,	@Location, @CreatedBy, @ModifiedBy 
	END
	Else
	BEGIN
	    EXEC [Operation].[usp_StockInDetailInsert] @DocumentNo, @ItemNo, @ProductCode, @BarCode, @Quantity,@BuyingPrice, @Location, @CreatedBy, @ModifiedBy 
	END
	

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInDetailUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_StockInDetailDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Operation].[StockInDetail] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Operation].[usp_StockInDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_StockInDetailDelete] 
    @DocumentNo varchar(50)
     
AS 
BEGIN 

	DELETE
	FROM   [Operation].[StockInDetail]
	WHERE  [DocumentNo] = @DocumentNo
	       
END
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInDetailDelete]
=======================================================================
*/



