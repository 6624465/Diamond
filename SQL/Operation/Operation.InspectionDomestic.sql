

-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionDomesticSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [InspectionDomestic] Record based on [InspectionDomestic] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_InspectionDomesticSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionDomesticSelect] 
END 
GO
CREATE PROC [Operation].[usp_InspectionDomesticSelect] 
    @DocumentNo VARCHAR(50),
	@PONo varchar(50),
    @ProductCode VARCHAR(50)
AS 
 

BEGIN

	SELECT	Dt.[DocumentNo],Dt.PONo, Dt.[ProductCode],Dt.ItemNo, Dt.[InspectionDate], Dt.[InspectedBy], Dt.[BatchNo], Dt.[Qty], Dt.[UOM], Dt.[BagNo], Dt.[BagWeight], Dt.[Color], Dt.[MeltingMinute], 
			Dt.[IsMeltAll], Dt.[IsClean], Dt.[PHLevel], Dt.[Remarks], Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn], ISNULL(Prd.Description,'') As ProductDescription,1 As Status 
	FROM	[Operation].[InspectionDomestic]  Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	WHERE	Dt.[DocumentNo] = @DocumentNo  
			And Dt.PONo = @PONo
			AND Dt.[ProductCode] = @ProductCode  

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionDomesticSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionDomesticList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [InspectionDomestic] Records from [InspectionDomestic] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_InspectionDomesticList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionDomesticList] 
END 
GO
CREATE PROC [Operation].[usp_InspectionDomesticList] 
	@DocumentNo VARCHAR(50),
	@PONo varchar(50),
    @ProductCode VARCHAR(50)
AS 
 
BEGIN
	SELECT	Dt.[DocumentNo],Dt.PONo, Dt.[ProductCode],Dt.ItemNo, Dt.[InspectionDate], Dt.[InspectedBy], Dt.[BatchNo], Dt.[Qty], Dt.[UOM], Dt.[BagNo], Dt.[BagWeight], Dt.[Color], Dt.[MeltingMinute], 
			Dt.[IsMeltAll], Dt.[IsClean], Dt.[PHLevel], Dt.[Remarks], Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn], ISNULL(Prd.Description,'') As ProductDescription,1 As Status 
	FROM	[Operation].[InspectionDomestic]  Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	WHERE	Dt.[DocumentNo] = @DocumentNo  
			And Dt.PONo = @PONo
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionDomesticList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionDomesticInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [InspectionDomestic] Record Into [InspectionDomestic] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InspectionDomesticInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionDomesticInsert] 
END 
GO
CREATE PROC [Operation].[usp_InspectionDomesticInsert] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50),
	@ItemNo smallint,
    @InspectionDate datetime,
    @InspectedBy varchar(50),
    @BatchNo varchar(50),
    @Qty float,
    @UOM nvarchar(50),
    @BagNo varchar(50),
    @BagWeight varchar(50),
    @Color nvarchar(50),
    @MeltingMinute varchar(10),
    @IsMeltAll bit,
    @IsClean bit,
    @PHLevel varchar(10),
    @Remarks nvarchar(MAX),
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50)
AS 
  

BEGIN
	
	INSERT INTO [Operation].[InspectionDomestic] (
			[DocumentNo],PONo, [ProductCode],ItemNo, [InspectionDate], [InspectedBy], [BatchNo], [Qty], [UOM], [BagNo], [BagWeight], [Color], [MeltingMinute], [IsMeltAll], 
			[IsClean], [PHLevel], [Remarks], [CreatedBy], [CreatedOn])
	SELECT	@DocumentNo,@PONo, @ProductCode,@ItemNo, @InspectionDate, @InspectedBy, @BatchNo, @Qty, @UOM, @BagNo, @BagWeight, @Color, @MeltingMinute, @IsMeltAll, 
			@IsClean, @PHLevel, @Remarks, @CreatedBy, GetDate()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionDomesticInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionDomesticUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [InspectionDomestic] Record Into [InspectionDomestic] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InspectionDomesticUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionDomesticUpdate] 
END 
GO
CREATE PROC [Operation].[usp_InspectionDomesticUpdate] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50),
	@ItemNo smallint,
    @InspectionDate datetime,
    @InspectedBy varchar(50),
    @BatchNo varchar(50),
    @Qty float,
    @UOM nvarchar(50),
    @BagNo varchar(50),
    @BagWeight varchar(50),
    @Color nvarchar(50),
    @MeltingMinute varchar(10),
    @IsMeltAll bit,
    @IsClean bit,
    @PHLevel varchar(10),
    @Remarks nvarchar(MAX),
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50)
AS 
 
	
BEGIN

	UPDATE	[Operation].[InspectionDomestic]
	SET		[InspectionDate] = @InspectionDate, [InspectedBy] = @InspectedBy, [BatchNo] = @BatchNo, [Qty] = @Qty, [UOM] = @UOM, [BagNo] = @BagNo, 
			[BagWeight] = @BagWeight, [Color] = @Color, [MeltingMinute] = @MeltingMinute, [IsMeltAll] = @IsMeltAll, [IsClean] = @IsClean, [PHLevel] = @PHLevel, 
			[Remarks] = @Remarks, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE	[DocumentNo] = @DocumentNo
			And PONo = @PONo
			AND [ProductCode] = @ProductCode
			And ItemNo =@ItemNo
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionDomesticUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionDomesticSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [InspectionDomestic] Record Into [InspectionDomestic] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InspectionDomesticSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionDomesticSave] 
END 
GO
CREATE PROC [Operation].[usp_InspectionDomesticSave] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50),
	@ItemNo smallint,
    @InspectionDate datetime,
    @InspectedBy varchar(50),
    @BatchNo varchar(50),
    @Qty float,
    @UOM nvarchar(50),
    @BagNo varchar(50),
    @BagWeight varchar(50),
    @Color nvarchar(50),
    @MeltingMinute varchar(10),
    @IsMeltAll bit,
    @IsClean bit,
    @PHLevel varchar(10),
    @Remarks nvarchar(MAX),
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50)

AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[InspectionDomestic] 
		WHERE 	[DocumentNo] = @DocumentNo
		And PONo = @PONo
	       AND [ProductCode] = @ProductCode
		   And ItemNo = @ItemNo)>0
	BEGIN
	    Exec [Operation].[usp_InspectionDomesticUpdate] 
					@DocumentNo,@PONo, @ProductCode,@ItemNo, @InspectionDate, @InspectedBy, @BatchNo, @Qty, @UOM, @BagNo, @BagWeight, @Color, @MeltingMinute, @IsMeltAll, 
					@IsClean, @PHLevel, @Remarks, @CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_InspectionDomesticInsert] 
					@DocumentNo,@PONo, @ProductCode,@ItemNo, @InspectionDate, @InspectedBy, @BatchNo, @Qty, @UOM, @BagNo, @BagWeight, @Color, @MeltingMinute, @IsMeltAll, 
					@IsClean, @PHLevel, @Remarks, @CreatedBy, @ModifiedBy

	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[InspectionDomesticSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionDomesticDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [InspectionDomestic] Record  based on [InspectionDomestic]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InspectionDomesticDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionDomesticDelete] 
END 
GO
CREATE PROC [Operation].[usp_InspectionDomesticDelete] 
    @DocumentNo varchar(50),
	@PONo varchar(50),
    @ProductCode varchar(50)
AS 

	
BEGIN

	 
	-- Use the SOFT DELETE.
	DELETE
	FROM   [Operation].[InspectionDomestic]
	WHERE  [DocumentNo] = @DocumentNo
			And PONo = @PONo
	       AND [ProductCode] = @ProductCode
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionDomesticDelete]
-- ========================================================================================================================================

GO
 



-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionDomesticDeleteALL]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	24-Jun-2016
-- Description:	Deletes the [InspectionDomestic] Record  based on DocumentNo

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InspectionDomesticDeleteALL]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionDomesticDeleteALL] 
END 
GO
CREATE PROC [Operation].[usp_InspectionDomesticDeleteALL] 
    @DocumentNo varchar(50) 
AS 

	
BEGIN

	 
	-- Use the SOFT DELETE.
	DELETE
	FROM   [Operation].[InspectionDomestic]
	WHERE  [DocumentNo] = @DocumentNo
			 
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionDomesticDeleteALL]
-- ========================================================================================================================================

GO
 