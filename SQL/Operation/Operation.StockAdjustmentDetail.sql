-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentDetailSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Select the [StockAdjustmentDetail] Record based on [StockAdjustmentDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_StockAdjustmentDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentDetailSelect] 
    @DocumentNo VARCHAR(50),
    @ItemNo SMALLINT,
    @ProductCode NVARCHAR(50),
    @BarCode NVARCHAR(50)
AS 
 

BEGIN

	SELECT Dt.[DocumentNo], Dt.[ItemNo], Dt.[ProductCode], Dt.[BarCode], Dt.[Quantity],Dt.StockType, Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],ISNULL(Prd.Description,'') As ProductDescription 
	FROM   [Operation].[StockAdjustmentDetail] Dt
	Left Outer Join [Master].[Product] Prd ON 
		Dt.ProductCode = Prd.ProductCode
	WHERE  Dt.[DocumentNo] = @DocumentNo 
	       AND Dt.[ItemNo] = @ItemNo 
	       AND Dt.[ProductCode] = @ProductCode 
	       AND Dt.[BarCode] = @BarCode 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentDetailSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentDetailList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Select all the [StockAdjustmentDetail] Records from [StockAdjustmentDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_StockAdjustmentDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentDetailList] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentDetailList] 
    @DocumentNo VARCHAR(50)

AS 
 
BEGIN
	SELECT Dt.[DocumentNo], Dt.[ItemNo], Dt.[ProductCode], Dt.[BarCode], Dt.[Quantity],Dt.StockType, Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],ISNULL(Prd.Description,'') As ProductDescription 
	FROM   [Operation].[StockAdjustmentDetail] Dt
	Left Outer Join [Master].[Product] Prd ON 
		Dt.ProductCode = Prd.ProductCode
	WHERE  Dt.[DocumentNo] = @DocumentNo 

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentDetailList] 
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentDetailInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Inserts the [StockAdjustmentDetail] Record Into [StockAdjustmentDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_StockAdjustmentDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentDetailInsert] 
    @DocumentNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50),
    @Quantity float,
	@StockType varchar(10),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)

AS 
  

BEGIN
	
	INSERT INTO [Operation].[StockAdjustmentDetail] ([DocumentNo], [ItemNo], [ProductCode], [BarCode], [Quantity],StockType, [CreatedBy], [CreatedOn])
	SELECT @DocumentNo, @ItemNo, @ProductCode, @BarCode, @Quantity,@StockType, @CreatedBy, GETDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentDetailInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentDetailUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	updates the [StockAdjustmentDetail] Record Into [StockAdjustmentDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_StockAdjustmentDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentDetailUpdate] 
    @DocumentNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50),
    @Quantity float,
	@StockType varchar(10),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
BEGIN

	UPDATE [Operation].[StockAdjustmentDetail]
	SET    [Quantity] = @Quantity, StockType = @StockType, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE  [DocumentNo] = @DocumentNo
	       AND [ItemNo] = @ItemNo
	       AND [ProductCode] = @ProductCode
	       AND [BarCode] = @BarCode
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentDetailUpdate]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentDetailSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Either INSERT or UPDATE the [StockAdjustmentDetail] Record Into [StockAdjustmentDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_StockAdjustmentDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentDetailSave] 
    @DocumentNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode nvarchar(50),
    @Quantity float,
	@StockType varchar(10),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[StockAdjustmentDetail] 
		WHERE 	[DocumentNo] = @DocumentNo
	       AND [ItemNo] = @ItemNo
	       AND [ProductCode] = @ProductCode
	       AND [BarCode] = @BarCode)>0
	BEGIN
	    Exec [Operation].[usp_StockAdjustmentDetailUpdate] 
		@DocumentNo, @ItemNo, @ProductCode, @BarCode, @Quantity,@StockType, @CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_StockAdjustmentDetailInsert] 
		@DocumentNo, @ItemNo, @ProductCode, @BarCode, @Quantity, @StockType,@CreatedBy, @ModifiedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[StockAdjustmentDetailSave]
-- ========================================================================================================================================

GO



----------------- Start of Delete-----------------------------------


-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentDetailDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Deletes the [StockAdjustmentDetail] Record  based on [StockAdjustmentDetail]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_StockAdjustmentDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentDetailDelete] 
    @DocumentNo varchar(50) 
AS 

	
BEGIN

	DELETE
	FROM   [Operation].[StockAdjustmentDetail]
	WHERE  [DocumentNo] = @DocumentNo
	        
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentDetailDelete]
-- ========================================================================================================================================

GO


