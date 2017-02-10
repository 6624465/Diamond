
/* 
=======================================================================
 START		[Operation].[usp_OrderDetailSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[OrderDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_OrderDetailSelect] 
    @OrderNo varchar(50),
    @ItemNo smallint 
AS 
BEGIN 
	
	
	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	[OrderNo], [ItemNo], Dt.[ProductCode], Dt.[BarCode], [Quantity],Cost, [SellRate], 
			[SellPrice], [MatchQuotation], DiscountType,DiscountAmount, AdjustAmount,PartialPayment, 
			Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],
			ISNULL(Pr.Description,'') As ProductDescription,ISNULL(Dt.Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription,
			0 As RecordStatus
	FROM   [Operation].[OrderDetail] Dt
	Left Outer Join [Master].[Product] Pr ON 
		Dt.ProductCode = Pr.ProductCode
	Left Outer Join WHLocation Lc ON 
		Pr.Location = Lc.LookupCode
	WHERE	[OrderNo] = @OrderNo  
			AND [ItemNo] = @ItemNo 
	        
END
GO

/* 
=======================================================================
 END		[Operation].[usp_OrderDetailSelect]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_OrderDetailList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Operation].[OrderDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderDetailList] 
END 
GO
CREATE PROC [Operation].[usp_OrderDetailList] 
    @OrderNo varchar(50)
     
AS 
BEGIN 
	
	
	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	[OrderNo], [ItemNo], Dt.[ProductCode], Dt.[BarCode], [Quantity],Cost, [SellRate], 
			[SellPrice], [MatchQuotation], DiscountType,DiscountAmount, AdjustAmount,PartialPayment, 
			Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],
			ISNULL(Pr.Description,'') As ProductDescription,ISNULL(Dt.Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription,
			0 As RecordStatus
	FROM   [Operation].[OrderDetail] Dt
	Left Outer Join [Master].[Product] Pr ON 
		Dt.ProductCode = Pr.ProductCode
	Left Outer Join WHLocation Lc ON 
		Pr.Location = Lc.LookupCode
	WHERE  [OrderNo] = @OrderNo  
	       
END
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderDetailSelect]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_OrderDetailInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Operation].[OrderDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_OrderDetailInsert] 
    @OrderNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50),
    @Quantity float,
	@Cost decimal(18,2),
    @SellRate decimal(18, 4),
    @SellPrice decimal(18, 4),
    @MatchQuotation varchar(50),
	@DiscountType varchar(50),
	@DiscountAmount decimal(18,4),
	@AdjustAmount decimal(18,4),
	@PartialPayment decimal(18,4),
	@Location nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 
	INSERT INTO [Operation].[OrderDetail] (
			[OrderNo], [ItemNo], [ProductCode], [BarCode], [Quantity],Cost, [SellRate], [SellPrice], [MatchQuotation],
			DiscountType,DiscountAmount,AdjustAmount,PartialPayment,Location, [CreatedBy], [CreatedOn])
	SELECT	@OrderNo, @ItemNo, @ProductCode, @BarCode, @Quantity,@Cost, @SellRate, @SellPrice, @MatchQuotation,@DiscountType,@DiscountAmount,
			@AdjustAmount,@PartialPayment,@Location, @CreatedBy, getdate()
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderDetailInsert]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_OrderDetailUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Operation].[OrderDetail] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_OrderDetailUpdate] 
    @OrderNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50),
    @Quantity float,
	@Cost decimal(18,2),
    @SellRate decimal(18, 4),
    @SellPrice decimal(18, 4),
    @MatchQuotation varchar(50),
	@DiscountType varchar(50),
	@DiscountAmount decimal(18,4),
	@AdjustAmount decimal(18,4),
	@PartialPayment decimal(18,2),
	@Location nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 

	UPDATE	[Operation].[OrderDetail]
	SET		[Quantity] = @Quantity,Cost = @Cost, [SellRate] = @SellRate, [SellPrice] = @SellPrice, [MatchQuotation] = @MatchQuotation, 
			[DiscountType]=@DiscountType,[DiscountAmount] = @DiscountAmount, [AdjustAmount] = @AdjustAmount, PartialPayment = @PartialPayment,
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE(),Location=@Location
	WHERE	[OrderNo] = @OrderNo
			AND [ItemNo] = @ItemNo
			AND [ProductCode] = @ProductCode
			AND [BarCode] = @BarCode
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderDetailUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_OrderDetailSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Operation].[OrderDetail] Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_OrderDetailSave] 
    @OrderNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50),
    @Quantity float,
	@Cost decimal(18,2),
    @SellRate decimal(18, 4),
    @SellPrice decimal(18, 4),
    @MatchQuotation varchar(50),
	@DiscountType varchar(50),
	@DiscountAmount decimal(18,4),
	@AdjustAmount decimal(18,4),
	@PartialPayment decimal(18,2),
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


	IF (SELECT COUNT(0) FROM [Operation].[OrderDetail]
		WHERE 	[OrderNo] = @OrderNo
	       AND [ItemNo] = @ItemNo
	       AND [ProductCode] = @ProductCode
	       AND [BarCode] = @BarCode)>0
	BEGIN	
		EXEC [Operation].[usp_OrderDetailUpdate] 
				@OrderNo, @ItemNo, @ProductCode, @BarCode,@Quantity,@Cost, @SellRate, 
				@SellPrice, @MatchQuotation,@DiscountType,@DiscountAmount,@AdjustAmount,@PartialPayment ,@Location, @CreatedBy, @ModifiedBy
	END
	Else
	BEGIN
	    EXEC [Operation].[usp_OrderDetailInsert] 
				@OrderNo, @ItemNo, @ProductCode, @BarCode, @Quantity,@Cost, @SellRate, 
				@SellPrice, @MatchQuotation,@DiscountType,@DiscountAmount,@AdjustAmount,@PartialPayment ,@Location, @CreatedBy, @ModifiedBy

	END
	

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderDetailUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_OrderDetailDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Operation].[OrderDetail] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Operation].[usp_OrderDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_OrderDetailDelete] 
    @OrderNo varchar(50) 
AS 
BEGIN 

	DELETE
	FROM   [Operation].[OrderDetail]
	WHERE  [OrderNo] = @OrderNo
	       
END
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderDetailDelete]
=======================================================================
*/

 