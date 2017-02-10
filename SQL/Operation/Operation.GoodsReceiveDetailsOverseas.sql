
-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailsOverseasSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceiveDetailsOverseas] Record based on [GoodsReceiveDetailsOverseas] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailsOverseasSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailsOverseasSelect] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailsOverseasSelect] 
    @DocumentNo VARCHAR(50),
	@PONo varchar(50),
    @ProductCode VARCHAR(50)
AS 
 

BEGIN

	SELECT	Dt.[DocumentNo],Dt.PONo, Dt.[ProductCode], Dt.[Quantity], Dt.[UOM], Dt.[ContainerNo], Dt.[ContainerCondition], Dt.[DamageDetails], Dt.[SealCondition], Dt.[SealNo], 
			Dt.[IsSort], Dt.[SortRemarks], Dt.[IsFCL], Dt.[IsHumidity], Dt.[IsProperPackage], Dt.[IsClean], Dt.[IsCompressed], Dt.[IsCorrectWeight], Dt.[QtyPerUOM], Dt.[IsProductLabel], 
			Dt.[IsInspectContainer], Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn] , ISNULL(Prd.Description,'') As ProductDescription 
	FROM	[Operation].[GoodsReceiveDetailsOverseas]   Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	WHERE  Dt.[DocumentNo] = @DocumentNo 
			And Dt.PONo = @PONo
	       AND Dt.[ProductCode] = @ProductCode 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailsOverseasSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailsOverseasList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [GoodsReceiveDetailsOverseas] Records from [GoodsReceiveDetailsOverseas] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailsOverseasList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailsOverseasList] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailsOverseasList] 
	@DocumentNo VARCHAR(50),
	@PONo varchar(50)
AS 
 
BEGIN
	SELECT	Dt.[DocumentNo],Dt.PONo, Dt.[ProductCode], Dt.[Quantity], Dt.[UOM], Dt.[ContainerNo], Dt.[ContainerCondition], Dt.[DamageDetails], Dt.[SealCondition], Dt.[SealNo], 
			Dt.[IsSort], Dt.[SortRemarks], Dt.[IsFCL], Dt.[IsHumidity], Dt.[IsProperPackage], Dt.[IsClean], Dt.[IsCompressed], Dt.[IsCorrectWeight], Dt.[QtyPerUOM], Dt.[IsProductLabel], 
			Dt.[IsInspectContainer], Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn] , ISNULL(Prd.Description,'') As ProductDescription 
	FROM	[Operation].[GoodsReceiveDetailsOverseas]   Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	WHERE  Dt.[DocumentNo] = @DocumentNo 
			And Dt.PONo = @PONo

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailsOverseasList] 
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailsOverseasInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [GoodsReceiveDetailsOverseas] Record Into [GoodsReceiveDetailsOverseas] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailsOverseasInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailsOverseasInsert] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailsOverseasInsert] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50),
    @Quantity float,
    @UOM nvarchar(50),
    @ContainerNo varchar(20),
    @ContainerCondition bit,
    @DamageDetails nvarchar(200),
    @SealCondition bit,
    @SealNo varchar(10),
    @IsSort bit,
    @SortRemarks nvarchar(200),
    @IsFCL bit,
    @IsHumidity bit,
    @IsProperPackage bit,
    @IsClean bit,
    @IsCompressed bit,
    @IsCorrectWeight bit,
    @QtyPerUOM int,
    @IsProductLabel bit,
    @IsInspectContainer bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)

AS 
  

BEGIN
	
	INSERT INTO [Operation].[GoodsReceiveDetailsOverseas] (
			[DocumentNo],[PONo], [ProductCode], [Quantity], [UOM], [ContainerNo], [ContainerCondition], [DamageDetails], [SealCondition], [SealNo], [IsSort], 
			[SortRemarks], [IsFCL], [IsHumidity], [IsProperPackage], [IsClean], [IsCompressed], [IsCorrectWeight], [QtyPerUOM], [IsProductLabel], 
			[IsInspectContainer], [CreatedBy], [CreatedOn])
	SELECT	@DocumentNo,@PONo, @ProductCode, @Quantity, @UOM, @ContainerNo, @ContainerCondition, @DamageDetails, @SealCondition, @SealNo, @IsSort, 
			@SortRemarks, @IsFCL, @IsHumidity, @IsProperPackage, @IsClean, @IsCompressed, @IsCorrectWeight, @QtyPerUOM, @IsProductLabel, 
			@IsInspectContainer, @CreatedBy, GetDate()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailsOverseasInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailsOverseasUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [GoodsReceiveDetailsOverseas] Record Into [GoodsReceiveDetailsOverseas] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailsOverseasUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailsOverseasUpdate] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailsOverseasUpdate] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50),
    @Quantity float,
    @UOM nvarchar(50),
    @ContainerNo varchar(20),
    @ContainerCondition bit,
    @DamageDetails nvarchar(200),
    @SealCondition bit,
    @SealNo varchar(10),
    @IsSort bit,
    @SortRemarks nvarchar(200),
    @IsFCL bit,
    @IsHumidity bit,
    @IsProperPackage bit,
    @IsClean bit,
    @IsCompressed bit,
    @IsCorrectWeight bit,
    @QtyPerUOM int,
    @IsProductLabel bit,
    @IsInspectContainer bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)

AS 
 
	
BEGIN

	UPDATE	[Operation].[GoodsReceiveDetailsOverseas]
	SET		[Quantity] = @Quantity, [UOM] = @UOM, [ContainerNo] = @ContainerNo, [ContainerCondition] = @ContainerCondition, [DamageDetails] = @DamageDetails, 
			[SealCondition] = @SealCondition, [SealNo] = @SealNo, [IsSort] = @IsSort, [SortRemarks] = @SortRemarks, [IsFCL] = @IsFCL, [IsHumidity] = @IsHumidity, 
			[IsProperPackage] = @IsProperPackage, [IsClean] = @IsClean, [IsCompressed] = @IsCompressed, [IsCorrectWeight] = @IsCorrectWeight, [QtyPerUOM] = @QtyPerUOM, 
			[IsProductLabel] = @IsProductLabel, [IsInspectContainer] = @IsInspectContainer, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE	[DocumentNo] = @DocumentNo
			And PONo = @PONo
			AND [ProductCode] = @ProductCode
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailsOverseasUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailsOverseasSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [GoodsReceiveDetailsOverseas] Record Into [GoodsReceiveDetailsOverseas] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailsOverseasSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailsOverseasSave] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailsOverseasSave] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50),
    @Quantity float,
    @UOM nvarchar(50),
    @ContainerNo varchar(20),
    @ContainerCondition bit,
    @DamageDetails nvarchar(200),
    @SealCondition bit,
    @SealNo varchar(10),
    @IsSort bit,
    @SortRemarks nvarchar(200),
    @IsFCL bit,
    @IsHumidity bit,
    @IsProperPackage bit,
    @IsClean bit,
    @IsCompressed bit,
    @IsCorrectWeight bit,
    @QtyPerUOM int,
    @IsProductLabel bit,
    @IsInspectContainer bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)

AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[GoodsReceiveDetailsOverseas] 
		WHERE 	[DocumentNo] = @DocumentNo
			And PONo = @PONo
	       AND [ProductCode] = @ProductCode)>0
	BEGIN
	    Exec [Operation].[usp_GoodsReceiveDetailsOverseasUpdate] 
				@DocumentNo,@PONo, @ProductCode, @Quantity, @UOM, @ContainerNo, @ContainerCondition, @DamageDetails, @SealCondition, @SealNo, @IsSort, 
				@SortRemarks, @IsFCL, @IsHumidity, @IsProperPackage, @IsClean, @IsCompressed, @IsCorrectWeight, @QtyPerUOM, @IsProductLabel, @IsInspectContainer, 
				@CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_GoodsReceiveDetailsOverseasInsert] 
				@DocumentNo,@PONo, @ProductCode, @Quantity, @UOM, @ContainerNo, @ContainerCondition, @DamageDetails, @SealCondition, @SealNo, @IsSort, 
				@SortRemarks, @IsFCL, @IsHumidity, @IsProperPackage, @IsClean, @IsCompressed, @IsCorrectWeight, @QtyPerUOM, @IsProductLabel, @IsInspectContainer, 
				@CreatedBy, @ModifiedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[GoodsReceiveDetailsOverseasSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveDetailsOverseasDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [GoodsReceiveDetailsOverseas] Record  based on [GoodsReceiveDetailsOverseas]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveDetailsOverseasDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveDetailsOverseasDelete] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveDetailsOverseasDelete] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50)
AS 

	
BEGIN
 
	DELETE
	FROM    [Operation].[GoodsReceiveDetailsOverseas]
	WHERE   [DocumentNo] = @DocumentNo
			And PONo = @PONo
	        AND [ProductCode] = @ProductCode
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveDetailsOverseasDelete]
-- ========================================================================================================================================

GO

 