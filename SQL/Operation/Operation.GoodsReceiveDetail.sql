
-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceiveDetail] Record based on [GoodsReceiveDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailSelect] 
    @DocumentNo VARCHAR(50),
	@PONo varchar(50),
	@ProductCode varchar(50)
	 
AS 
 

BEGIN

	SELECT	Dt.[DocumentNo],Dt.[PONo], Dt.[ProductCode], Dt.[UOM], Dt.[IsCovered], Dt.[CoverRemarks], Dt.[IsSorted], Dt.[SortedRemarks], Dt.[IsHumidity], Dt.[IsSameAsPhoto], 
			Dt.[IsClean], Dt.[IsCompressed], Dt.[IsCorrectWeight], Dt.[Qty],Dt.[PalletQty],Dt.PalletUOM, 
			Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn], Dt.[Status]  , ISNULL(Prd.Description,'') As ProductDescription
	FROM	[Operation].[GoodsReceiveDetail]    Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	WHERE	Dt.[DocumentNo] = @DocumentNo 
			And Dt.PONo = @PONo
			And Dt.ProductCode = @ProductCode  
			 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [GoodsReceiveDetail] Records from [GoodsReceiveDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailList] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailList] 
    @DocumentNo VARCHAR(50),
	@PONo varchar(50)

AS 
 
BEGIN
		SELECT	Dt.[DocumentNo],Dt.[PONo], Dt.[ProductCode], Dt.[UOM], Dt.[IsCovered], Dt.[CoverRemarks], Dt.[IsSorted], Dt.[SortedRemarks], Dt.[IsHumidity], Dt.[IsSameAsPhoto], 
			Dt.[IsClean], Dt.[IsCompressed], Dt.[IsCorrectWeight], Dt.[Qty],Dt.[PalletQty],Dt.PalletUOM, 
			Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn], Dt.[Status]  , ISNULL(Prd.Description,'') As ProductDescription
	FROM	[Operation].[GoodsReceiveDetail]    Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	WHERE	Dt.[DocumentNo] = @DocumentNo 
			And Dt.PONo = @PONo


END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [GoodsReceiveDetail] Record Into [GoodsReceiveDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailInsert] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50),
    @UOM varchar(10),
    @IsCovered bit,
    @CoverRemarks nvarchar(MAX),
    @IsSorted bit,
    @SortedRemarks nvarchar(MAX),
    @IsHumidity bit,
    @IsSameAsPhoto bit,
    @IsClean bit,
    @IsCompressed bit,
    @IsCorrectWeight bit,
    @Qty float,
	@PalletQty decimal(18, 0),
	@PalletUOM varchar(10),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
  

BEGIN
	
	INSERT INTO [Operation].[GoodsReceiveDetail] (
			[DocumentNo],PONo, [ProductCode], [UOM], [IsCovered], [CoverRemarks], [IsSorted], [SortedRemarks], [IsHumidity], [IsSameAsPhoto], 
			[IsClean], [IsCompressed], [IsCorrectWeight], [Qty],[PalletQty],[PalletUOM], [CreatedBy], [CreatedOn],[Status])
	SELECT	@DocumentNo,@PONo, @ProductCode, @UOM, @IsCovered, @CoverRemarks, @IsSorted, @SortedRemarks, @IsHumidity, @IsSameAsPhoto, 
			@IsClean, @IsCompressed, @IsCorrectWeight, @Qty,@PalletQty,@PalletUOM, @CreatedBy, GetDate() , Cast(1 as bit)
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [GoodsReceiveDetail] Record Into [GoodsReceiveDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailUpdate] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50),
    @UOM varchar(10),
    @IsCovered bit,
    @CoverRemarks nvarchar(MAX),
    @IsSorted bit,
    @SortedRemarks nvarchar(MAX),
    @IsHumidity bit,
    @IsSameAsPhoto bit,
    @IsClean bit,
    @IsCompressed bit,
    @IsCorrectWeight bit,
    @Qty float,
	@PalletQty decimal(18, 0),
	@PalletUOM varchar(10),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
BEGIN

	UPDATE	[Operation].[GoodsReceiveDetail]
	SET		[UOM] = @UOM, [IsCovered] = @IsCovered, [CoverRemarks] = @CoverRemarks, [IsSorted] = @IsSorted, 
			[SortedRemarks] = @SortedRemarks, [IsHumidity] = @IsHumidity, [IsSameAsPhoto] = @IsSameAsPhoto, [IsClean] = @IsClean, 
			[IsCompressed] = @IsCompressed, [IsCorrectWeight] = @IsCorrectWeight, [Qty] = @Qty, PalletQty=@PalletQty,PalletUOM=@PalletUOM,
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate() 
	WHERE	[DocumentNo] = @DocumentNo
			AND [ProductCode] = @ProductCode
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [GoodsReceiveDetail] Record Into [GoodsReceiveDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailSave] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50),
    @UOM varchar(10),
    @IsCovered bit,
    @CoverRemarks nvarchar(MAX),
    @IsSorted bit,
    @SortedRemarks nvarchar(MAX),
    @IsHumidity bit,
    @IsSameAsPhoto bit,
    @IsClean bit,
    @IsCompressed bit,
    @IsCorrectWeight bit,
    @Qty float,
	@PalletQty decimal(18, 0), 
	@PalletUOM varchar(10),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[GoodsReceiveDetail] 
		WHERE 	[DocumentNo] = @DocumentNo
	       AND  PONo = @PONo)>0
	BEGIN
	    Exec [Operation].[usp_GoodsReceiveDetailUpdate] 
			@DocumentNo,@PONo, @ProductCode, @UOM, @IsCovered, @CoverRemarks, @IsSorted, @SortedRemarks, @IsHumidity, @IsSameAsPhoto, @IsClean, @IsCompressed,
			@IsCorrectWeight, @Qty,@PalletQty,@PalletUOM, @CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_GoodsReceiveDetailInsert] 
			@DocumentNo,@PONo, @ProductCode, @UOM, @IsCovered, @CoverRemarks, @IsSorted, @SortedRemarks, @IsHumidity, @IsSameAsPhoto, @IsClean, @IsCompressed,
			@IsCorrectWeight, @Qty,@PalletQty,@PalletUOM, @CreatedBy, @ModifiedBy

	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[GoodsReceiveDetailSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [GoodsReceiveDetail] Record  based on [GoodsReceiveDetail]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailDelete] 
    @DocumentNo varchar(50) ,
	@PONo varchar(50),
	@ProductCode varchar(50)
AS 

	
BEGIN

	UPDATE	[Operation].[GoodsReceiveDetail]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[DocumentNo] = @DocumentNo
			And PONo = @PONo
			And ProductCode = @ProductCode
	        

 
 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailDelete]
-- ========================================================================================================================================

GO
 
