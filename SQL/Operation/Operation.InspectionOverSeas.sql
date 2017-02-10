

-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionOverSeasSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-Jun-2016
-- Description:	Select the [InspectionOverSeas] Record based on [InspectionOverSeas] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_InspectionOverSeasSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionOverSeasSelect] 
END 
GO
CREATE PROC [Operation].[usp_InspectionOverSeasSelect] 
    @DocumentNo VARCHAR(50),
    @PONo VARCHAR(50),
    @ProductCode VARCHAR(50)
AS 
 

BEGIN

	SELECT	Dt.[DocumentNo], Dt.[PONo], Dt.[ProductCode], Dt.[ChemicalName], Dt.[ReceivedDate], Dt.[ReceivedQty],  Dt.[InspectionDate], Dt.[InspectionTime], Dt.[InspectionQty], 
			Dt.[SupplierType], Dt.[IsRequireLabour], Dt.[InvoiceNo], Dt.[PINumber],Dt.PurchaseReceivedQty,dt.PurchaseQtyUOM, Dt.[COASupplier], Dt.[IsGetCOA], Dt.[IsGetAllItem], Dt.[MissingItem], 
			Dt.[IsGetCOABatchNo], Dt.[COABatchNo], Dt.[IsCOAManufactureDate],Dt.[ManufacturerDate], Dt.[IsCOAExpiryDate],Dt.[ExpiryDate], Dt.[TestResult], Dt.[FailedItem], Dt.[InspectionResult], 
			Dt.[Manufacturer], Dt.[ContainerNo], Dt.[SizeType], Dt.[ChemicalReceiveBatchNo], Dt.[BatchNo], Dt.[Homogenious], Dt.[IsLabelOK], Dt.[IsColorOK], Dt.[IsWet], 
			Dt.[ChemicalCondition], Dt.[ContaminationRemarks], Dt.[AcceptStatus], Dt.[AcceptRemarks], Dt.[BagWeight], Dt.[BagCondition], Dt.[PreparedBy], 
			Dt.[PreparedOn], Dt.[CheckedBy], Dt.[CheckedOn], Dt.[ApprovedBy], Dt.[ApprovedOn] , ISNULL(Prd.Description,'') As ProductDescription
	FROM   [Operation].[InspectionOverSeas] Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	WHERE  Dt.[DocumentNo] = @DocumentNo  
			And Dt.PONo = @PONo
			AND Dt.[ProductCode] = @ProductCode 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionOverSeasSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionOverSeasList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-Jun-2016
-- Description:	Select all the [InspectionOverSeas] Records from [InspectionOverSeas] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_InspectionOverSeasList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionOverSeasList] 
END 
GO
CREATE PROC [Operation].[usp_InspectionOverSeasList] 
@DocumentNo VARCHAR(50),
	@PONo varchar(50)
AS 
 
BEGIN
	SELECT	Dt.[DocumentNo], Dt.[PONo], Dt.[ProductCode], Dt.[ChemicalName], Dt.[ReceivedDate], Dt.[ReceivedQty],  Dt.[InspectionDate], Dt.[InspectionTime], Dt.[InspectionQty], 
			Dt.[SupplierType], Dt.[IsRequireLabour], Dt.[InvoiceNo], Dt.[PINumber],Dt.PurchaseReceivedQty,dt.PurchaseQtyUOM, Dt.[COASupplier], Dt.[IsGetCOA], Dt.[IsGetAllItem], Dt.[MissingItem], 
			Dt.[IsGetCOABatchNo], Dt.[COABatchNo], Dt.[IsCOAManufactureDate],Dt.[ManufacturerDate], Dt.[IsCOAExpiryDate],Dt.[ExpiryDate], Dt.[TestResult], Dt.[FailedItem], Dt.[InspectionResult], 
			Dt.[Manufacturer], Dt.[ContainerNo], Dt.[SizeType], Dt.[ChemicalReceiveBatchNo], Dt.[BatchNo], Dt.[Homogenious], Dt.[IsLabelOK], Dt.[IsColorOK], Dt.[IsWet], 
			Dt.[ChemicalCondition], Dt.[ContaminationRemarks], Dt.[AcceptStatus], Dt.[AcceptRemarks], Dt.[BagWeight], Dt.[BagCondition], Dt.[PreparedBy], 
			Dt.[PreparedOn], Dt.[CheckedBy], Dt.[CheckedOn], Dt.[ApprovedBy], Dt.[ApprovedOn] , ISNULL(Prd.Description,'') As ProductDescription
	FROM   [Operation].[InspectionOverSeas] Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	WHERE  Dt.[DocumentNo] = @DocumentNo  
			And Dt.PONo = @PONo		

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionOverSeasList] 
-- ========================================================================================================================================

GO

 
-- START											 [Operation].[usp_InspectionOverSeasInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-Jun-2016
-- Description:	Inserts the [InspectionOverSeas] Record Into [InspectionOverSeas] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InspectionOverSeasInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionOverSeasInsert] 
END 
GO
CREATE PROC [Operation].[usp_InspectionOverSeasInsert] 
    @DocumentNo varchar(50),
    @PONo varchar(50),
    @ProductCode varchar(50),
    @ChemicalName nvarchar(200),
    @ReceivedDate datetime,
	@ReceivedQty float,
    @InspectionDate datetime,
    @InspectionTime datetime,
    @InspectionQty float,
    @SupplierType nvarchar(50),
    @IsRequireLabour bit,
    @InvoiceNo nvarchar(50),
    @PINumber nvarchar(50),
	@PurchaseReceivedQty float,
	@PurchaseQtyUOM nvarchar(50),
    @COASupplier nvarchar(200),
    @IsGetCOA bit,
    @IsGetAllItem bit,
    @MissingItem nvarchar(200),
    @IsGetCOABatchNo bit,
    @COABatchNo nvarchar(50),
    @IsCOAManufactureDate bit,
	@ManufacturerDate datetime,
    @IsCOAExpiryDate bit,
	@ExpiryDate datetime,
    @TestResult bit,
    @FailedItem nvarchar(200),
    @InspectionResult bit,
    @Manufacturer nvarchar(200),
    @ContainerNo varchar(50),
    @SizeType nvarchar(10),
    @ChemicalReceiveBatchNo nvarchar(50),
    @BatchNo nvarchar(50),
    @Homogenious smallint,
    @IsLabelOK bit,
    @IsColorOK bit,
    @IsWet bit,
    @ChemicalCondition smallint,
    @ContaminationRemarks nvarchar(MAX),
    @AcceptStatus smallint,
    @AcceptRemarks nvarchar(MAX),
    @BagWeight varchar(50),
    @BagCondition smallint,
    @PreparedBy varchar(50),
    @CheckedBy varchar(50),
    @ApprovedBy varchar(50)
AS 
  

BEGIN
	
	INSERT INTO [Operation].[InspectionOverSeas] (
			[DocumentNo], [PONo], [ProductCode], [ChemicalName], [ReceivedDate],ReceivedQty, [InspectionDate], [InspectionTime], [InspectionQty], [SupplierType], 
			[IsRequireLabour], [InvoiceNo], [PINumber],PurchaseReceivedQty,PurchaseQtyUOM, [COASupplier], [IsGetCOA], [IsGetAllItem], [MissingItem], [IsGetCOABatchNo], [COABatchNo], 
			[IsCOAManufactureDate],ManufacturerDate, [IsCOAExpiryDate],ExpiryDate, [TestResult], [FailedItem], [InspectionResult], [Manufacturer], [ContainerNo], 
			[SizeType], [ChemicalReceiveBatchNo], [BatchNo], [Homogenious], [IsLabelOK], [IsColorOK], [IsWet], [ChemicalCondition], [ContaminationRemarks], 
			[AcceptStatus], [AcceptRemarks], [BagWeight], [BagCondition], [PreparedBy], [PreparedOn], [CheckedBy], [CheckedOn], [ApprovedBy], [ApprovedOn])
	SELECT	@DocumentNo, @PONo, @ProductCode, @ChemicalName, @ReceivedDate,@ReceivedQty, @InspectionDate, @InspectionTime, @InspectionQty, @SupplierType, 
			@IsRequireLabour, @InvoiceNo, @PINumber,@PurchaseReceivedQty,@PurchaseQtyUOM, @COASupplier, @IsGetCOA, @IsGetAllItem, @MissingItem, @IsGetCOABatchNo, @COABatchNo, 
			@IsCOAManufactureDate,@ManufacturerDate, @IsCOAExpiryDate,@ExpiryDate, @TestResult, @FailedItem, @InspectionResult, @Manufacturer, @ContainerNo, 
			@SizeType, @ChemicalReceiveBatchNo, @BatchNo, @Homogenious, @IsLabelOK, @IsColorOK, @IsWet, @ChemicalCondition, @ContaminationRemarks, 
			@AcceptStatus, @AcceptRemarks, @BagWeight, @BagCondition, @PreparedBy, GETUTCDATE(), @CheckedBy, GETUTCDATE(), @ApprovedBy, GETUTCDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionOverSeasInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionOverSeasUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-Jun-2016
-- Description:	updates the [InspectionOverSeas] Record Into [InspectionOverSeas] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InspectionOverSeasUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionOverSeasUpdate] 
END 
GO
CREATE PROC [Operation].[usp_InspectionOverSeasUpdate] 
    @DocumentNo varchar(50),
    @PONo varchar(50),
    @ProductCode varchar(50),
    @ChemicalName nvarchar(200),
    @ReceivedDate datetime,
	@ReceivedQty float,
    @InspectionDate datetime,
    @InspectionTime datetime,
    @InspectionQty float,
    @SupplierType nvarchar(50),
    @IsRequireLabour bit,
    @InvoiceNo nvarchar(50),
    @PINumber nvarchar(50),
	@PurchaseReceivedQty float,
	@PurchaseQtyUOM nvarchar(50),
    @COASupplier nvarchar(200),
    @IsGetCOA bit,
    @IsGetAllItem bit,
    @MissingItem nvarchar(200),
    @IsGetCOABatchNo bit,
    @COABatchNo nvarchar(50),
    @IsCOAManufactureDate bit,
	@ManufacturerDate datetime,
    @IsCOAExpiryDate bit,
	@ExpiryDate datetime,
    @TestResult bit,
    @FailedItem nvarchar(200),
    @InspectionResult bit,
    @Manufacturer nvarchar(200),
    @ContainerNo varchar(50),
    @SizeType nvarchar(10),
    @ChemicalReceiveBatchNo nvarchar(50),
    @BatchNo nvarchar(50),
    @Homogenious smallint,
    @IsLabelOK bit,
    @IsColorOK bit,
    @IsWet bit,
    @ChemicalCondition smallint,
    @ContaminationRemarks nvarchar(MAX),
    @AcceptStatus smallint,
    @AcceptRemarks nvarchar(MAX),
    @BagWeight varchar(50),
    @BagCondition smallint,
    @PreparedBy varchar(50),
    @CheckedBy varchar(50),
    @ApprovedBy varchar(50)
AS 
 
	
BEGIN

	UPDATE	[Operation].[InspectionOverSeas]
	SET		[ChemicalName] = @ChemicalName, [ReceivedDate] = @ReceivedDate,ReceivedQty = @ReceivedQty, [InspectionDate] = @InspectionDate, [InspectionTime] = @InspectionTime, 
			[InspectionQty] = @InspectionQty, [SupplierType] = @SupplierType, [IsRequireLabour] = @IsRequireLabour, [InvoiceNo] = @InvoiceNo, [PINumber] = @PINumber,
			PurchaseReceivedQty=@PurchaseReceivedQty,PurchaseQtyUOM=@PurchaseQtyUOM, 
			[COASupplier] = @COASupplier, [IsGetCOA] = @IsGetCOA, [IsGetAllItem] = @IsGetAllItem, [MissingItem] = @MissingItem, [IsGetCOABatchNo] = @IsGetCOABatchNo, 
			[COABatchNo] = @COABatchNo, [IsCOAManufactureDate] = @IsCOAManufactureDate,ManufacturerDate=@ManufacturerDate, [IsCOAExpiryDate] = @IsCOAExpiryDate,ExpiryDate = @ExpiryDate,
			[TestResult] = @TestResult, [FailedItem] = @FailedItem, [InspectionResult] = @InspectionResult, [Manufacturer] = @Manufacturer, [ContainerNo] = @ContainerNo, 
			[SizeType] = @SizeType, [ChemicalReceiveBatchNo] = @ChemicalReceiveBatchNo, [BatchNo] = @BatchNo, [Homogenious] = @Homogenious, [IsLabelOK] = @IsLabelOK, 
			[IsColorOK] = @IsColorOK, [IsWet] = @IsWet, [ChemicalCondition] = @ChemicalCondition, [ContaminationRemarks] = @ContaminationRemarks, 
			[AcceptStatus] = @AcceptStatus, [AcceptRemarks] = @AcceptRemarks, [BagWeight] = @BagWeight, [BagCondition] = @BagCondition, 
			[PreparedBy] = @PreparedBy, [PreparedOn] = GETUTCDATE(), [CheckedBy] = @CheckedBy, [CheckedOn] = GETUTCDATE(), [ApprovedBy] = @ApprovedBy, [ApprovedOn] = GETUTCDATE()
	WHERE	[DocumentNo] = @DocumentNo
			AND [PONo] = @PONo
			AND [ProductCode] = @ProductCode
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionOverSeasUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionOverSeasSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-Jun-2016
-- Description:	Either INSERT or UPDATE the [InspectionOverSeas] Record Into [InspectionOverSeas] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InspectionOverSeasSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionOverSeasSave] 
END 
GO
CREATE PROC [Operation].[usp_InspectionOverSeasSave] 
    @DocumentNo varchar(50),
    @PONo varchar(50),
    @ProductCode varchar(50),
    @ChemicalName nvarchar(200),
    @ReceivedDate datetime,
	@ReceivedQty float,
    @InspectionDate datetime,
    @InspectionTime datetime,
    @InspectionQty float,
    @SupplierType nvarchar(50),
    @IsRequireLabour bit,
    @InvoiceNo nvarchar(50),
    @PINumber nvarchar(50),
	@PurchaseReceivedQty float,
	@PurchaseQtyUOM nvarchar(50),
    @COASupplier nvarchar(200),
    @IsGetCOA bit,
    @IsGetAllItem bit,
    @MissingItem nvarchar(200),
    @IsGetCOABatchNo bit,
    @COABatchNo nvarchar(50),
    @IsCOAManufactureDate bit,
	@ManufacturerDate datetime,
    @IsCOAExpiryDate bit,
	@ExpiryDate datetime,
    @TestResult bit,
    @FailedItem nvarchar(200),
    @InspectionResult bit,
    @Manufacturer nvarchar(200),
    @ContainerNo varchar(50),
    @SizeType nvarchar(10),
    @ChemicalReceiveBatchNo nvarchar(50),
    @BatchNo nvarchar(50),
    @Homogenious smallint,
    @IsLabelOK bit,
    @IsColorOK bit,
    @IsWet bit,
    @ChemicalCondition smallint,
    @ContaminationRemarks nvarchar(MAX),
    @AcceptStatus smallint,
    @AcceptRemarks nvarchar(MAX),
    @BagWeight varchar(50),
    @BagCondition smallint,
    @PreparedBy varchar(50),
    @CheckedBy varchar(50),
    @ApprovedBy varchar(50)
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[InspectionOverSeas] 
		WHERE 	[DocumentNo] = @DocumentNo
	       AND [PONo] = @PONo
	       AND [ProductCode] = @ProductCode)>0
	BEGIN
	    Exec [Operation].[usp_InspectionOverSeasUpdate] 
				@DocumentNo, @PONo, @ProductCode, @ChemicalName, @ReceivedDate,@ReceivedQty, @InspectionDate, @InspectionTime, @InspectionQty, @SupplierType, 
				@IsRequireLabour, @InvoiceNo, @PINumber,@PurchaseReceivedQty,@PurchaseQtyUOM, @COASupplier, @IsGetCOA, @IsGetAllItem, @MissingItem, @IsGetCOABatchNo, 
				@COABatchNo, @IsCOAManufactureDate,@ManufacturerDate, @IsCOAExpiryDate,@ExpiryDate, @TestResult, @FailedItem, @InspectionResult, @Manufacturer, 
				@ContainerNo, @SizeType, @ChemicalReceiveBatchNo, @BatchNo, @Homogenious, @IsLabelOK, @IsColorOK, @IsWet, 
				@ChemicalCondition, @ContaminationRemarks, @AcceptStatus, @AcceptRemarks, @BagWeight, @BagCondition, @PreparedBy, 
				@CheckedBy,  @ApprovedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_InspectionOverSeasInsert] 
				@DocumentNo, @PONo, @ProductCode, @ChemicalName, @ReceivedDate,@ReceivedQty, @InspectionDate, @InspectionTime, @InspectionQty, @SupplierType, 
				@IsRequireLabour, @InvoiceNo, @PINumber,@PurchaseReceivedQty,@PurchaseQtyUOM, @COASupplier, @IsGetCOA, @IsGetAllItem, @MissingItem, @IsGetCOABatchNo, 
				@COABatchNo, @IsCOAManufactureDate,@ManufacturerDate, @IsCOAExpiryDate,@ExpiryDate, @TestResult, @FailedItem, @InspectionResult, @Manufacturer, 
				@ContainerNo, @SizeType, @ChemicalReceiveBatchNo, @BatchNo, @Homogenious, @IsLabelOK, @IsColorOK, @IsWet, 
				@ChemicalCondition, @ContaminationRemarks, @AcceptStatus, @AcceptRemarks, @BagWeight, @BagCondition, @PreparedBy, 
				@CheckedBy,  @ApprovedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[InspectionOverSeasSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_InspectionOverSeasDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-Jun-2016
-- Description:	Deletes the [InspectionOverSeas] Record  based on [InspectionOverSeas]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_InspectionOverSeasDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InspectionOverSeasDelete] 
END 
GO
CREATE PROC [Operation].[usp_InspectionOverSeasDelete] 
    @DocumentNo varchar(50),
    @PONo varchar(50),
    @ProductCode varchar(50)
AS 

	
BEGIN

	 
	DELETE
	FROM   [Operation].[InspectionOverSeas]
	WHERE  [DocumentNo] = @DocumentNo
	       AND [PONo] = @PONo
	       AND [ProductCode] = @ProductCode
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_InspectionOverSeasDelete]
-- ========================================================================================================================================

GO
 