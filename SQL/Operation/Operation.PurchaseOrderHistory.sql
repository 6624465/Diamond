USE [NetStockDiamond];
GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_PurchaseOrderHistorySelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [PurchaseOrderHistory] Record based on [PurchaseOrderHistory] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_PurchaseOrderHistorySelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHistorySelect] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHistorySelect] 
    @PONo VARCHAR(50),
    @BranchID SMALLINT
AS 
 

BEGIN

	SELECT	[TransactionID], [PONo], [BranchID], [TransactionDate], [TransactionType], [PODate], [SupplierCode], [ShipmentDate], 
			[ReceiveDate], [EstimateDate], [ReferenceNo], [Buyer], [PRNo], [IncoTerms],PaymentTerm, [POStatus], [TotalAmount],OtherCharges, [IsVAT], [VATAmount], [NetAmount], 
			[IsCancel], [Remarks], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM	[Operation].[PurchaseOrderHistory] WITH (NOLOCK)
	WHERE  [PONo] = @PONo 
	       AND  [BranchID] = @BranchID 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_PurchaseOrderHistorySelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_PurchaseOrderHistoryList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [PurchaseOrderHistory] Records from [PurchaseOrderHistory] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_PurchaseOrderHistoryList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHistoryList] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHistoryList] 
    @PONo VARCHAR(50),
    @BranchID SMALLINT

AS 
 
BEGIN

	SELECT	[TransactionID], [PONo], [BranchID], [TransactionDate], [TransactionType], [PODate], [SupplierCode], [ShipmentDate], 
			[ReceiveDate], [EstimateDate], [ReferenceNo], [Buyer], [PRNo], [IncoTerms],PaymentTerm, [POStatus], [TotalAmount],OtherCharges, [IsVAT], [VATAmount], [NetAmount], 
			[IsCancel], [Remarks], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM	[Operation].[PurchaseOrderHistory] WITH (NOLOCK)
	WHERE  [PONo] = @PONo 
	       AND  [BranchID] = @BranchID 

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_PurchaseOrderHistoryList] 
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_PurchaseOrderHistoryInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [PurchaseOrderHistory] Record Into [PurchaseOrderHistory] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_PurchaseOrderHistoryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHistoryInsert] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHistoryInsert] 
    @TransactionID uniqueidentifier,
    @PONo varchar(50),
    @BranchID smallint,
    @TransactionDate datetime,
    @TransactionType varchar(50),
    @PODate datetime,
    @SupplierCode nvarchar(50),
    @ShipmentDate datetime,
    @ReceiveDate datetime,
    @EstimateDate datetime,
    @ReferenceNo nvarchar(50),
    @Buyer nvarchar(50),
    @PRNo nvarchar(50),
    @IncoTerms nvarchar(MAX),
	@PaymentTerm nvarchar(50),
    @POStatus bit,
    @TotalAmount decimal(18, 2),
	@OtherCharges decimal(18,2),
    @IsVAT bit,
    @VATAmount decimal(18, 2),
    @NetAmount decimal(18, 2),
    @IsCancel bit,
    @Remarks nvarchar(MAX),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
  

BEGIN
	
	INSERT INTO [Operation].[PurchaseOrderHistory] (
			[TransactionID], [PONo], [BranchID], [TransactionDate], [TransactionType], [PODate], [SupplierCode], [ShipmentDate], [ReceiveDate], 
			[EstimateDate], [ReferenceNo], [Buyer], [PRNo], [IncoTerms],PaymentTerm, [POStatus], [TotalAmount], [IsVAT], [VATAmount], [NetAmount], [IsCancel], [Remarks], 
			[CreatedBy], [CreatedOn])
	SELECT	@TransactionID, @PONo, @BranchID, @TransactionDate, @TransactionType, @PODate, @SupplierCode, @ShipmentDate, @ReceiveDate, 
			@EstimateDate, @ReferenceNo, @Buyer, @PRNo, @IncoTerms,@PaymentTerm, @POStatus, @TotalAmount, @IsVAT, @VATAmount, @NetAmount, @IsCancel, @Remarks, 
			@CreatedBy, GetDate()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_PurchaseOrderHistoryInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_PurchaseOrderHistoryUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [PurchaseOrderHistory] Record Into [PurchaseOrderHistory] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_PurchaseOrderHistoryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHistoryUpdate] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHistoryUpdate] 
    @TransactionID uniqueidentifier,
    @PONo varchar(50),
    @BranchID smallint,
    @TransactionDate datetime,
    @TransactionType varchar(50),
    @PODate datetime,
    @SupplierCode nvarchar(50),
    @ShipmentDate datetime,
    @ReceiveDate datetime,
    @EstimateDate datetime,
    @ReferenceNo nvarchar(50),
    @Buyer nvarchar(50),
    @PRNo nvarchar(50),
    @IncoTerms nvarchar(MAX),
	@PaymentTerm nvarchar(50),
    @POStatus bit,
    @TotalAmount decimal(18, 2),
	@OtherCharges decimal(18,2),
    @IsVAT bit,
    @VATAmount decimal(18, 2),
    @NetAmount decimal(18, 2),
    @IsCancel bit,
    @Remarks nvarchar(MAX),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
BEGIN

	UPDATE	[Operation].[PurchaseOrderHistory]
	SET		[TransactionDate] = @TransactionDate, [TransactionType] = @TransactionType, [PODate] = @PODate, [SupplierCode] = @SupplierCode, [ShipmentDate] = @ShipmentDate, 
			[ReceiveDate] = @ReceiveDate, [EstimateDate] = @EstimateDate, [ReferenceNo] = @ReferenceNo, [Buyer] = @Buyer, [PRNo] = @PRNo, [IncoTerms] = @IncoTerms,PaymentTerm= @PaymentTerm, 
			[POStatus] = @POStatus, [TotalAmount] = @TotalAmount,OtherCharges= @OtherCharges, [IsVAT] = @IsVAT, [VATAmount] = @VATAmount, [NetAmount] = @NetAmount, [IsCancel] = @IsCancel, 
			[Remarks] = @Remarks, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE	[TransactionID] = @TransactionID
			AND [PONo] = @PONo
			AND [BranchID] = @BranchID
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_PurchaseOrderHistoryUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_PurchaseOrderHistorySave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [PurchaseOrderHistory] Record Into [PurchaseOrderHistory] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_PurchaseOrderHistorySave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHistorySave] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHistorySave] 
    @TransactionID uniqueidentifier,
    @PONo varchar(50),
    @BranchID smallint,
    @TransactionDate datetime,
    @TransactionType varchar(50),
    @PODate datetime,
    @SupplierCode nvarchar(50),
    @ShipmentDate datetime,
    @ReceiveDate datetime,
    @EstimateDate datetime,
    @ReferenceNo nvarchar(50),
    @Buyer nvarchar(50),
    @PRNo nvarchar(50),
    @IncoTerms nvarchar(MAX),
	@PaymentTerm nvarchar(50),
    @POStatus bit,
    @TotalAmount decimal(18, 2),
	@OtherCharges decimal(18,2),
    @IsVAT bit,
    @VATAmount decimal(18, 2),
    @NetAmount decimal(18, 2),
    @IsCancel bit,
    @Remarks nvarchar(MAX),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)

AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[PurchaseOrderHistory] 
		WHERE 	[TransactionID] = @TransactionID
	       AND [PONo] = @PONo
	       AND [BranchID] = @BranchID)>0
	BEGIN
	    Exec [Operation].[usp_PurchaseOrderHistoryUpdate] 
				@TransactionID, @PONo, @BranchID, @TransactionDate, @TransactionType, @PODate, @SupplierCode, @ShipmentDate, @ReceiveDate, 
				@EstimateDate, @ReferenceNo, @Buyer, @PRNo, @IncoTerms,@PaymentTerm, @POStatus, @TotalAmount,@OtherCharges, @IsVAT, @VATAmount, @NetAmount, @IsCancel, 
				@Remarks, @CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_PurchaseOrderHistoryInsert] 
				@TransactionID, @PONo, @BranchID, @TransactionDate, @TransactionType, @PODate, @SupplierCode, @ShipmentDate, @ReceiveDate, 
				@EstimateDate, @ReferenceNo, @Buyer, @PRNo, @IncoTerms,@PaymentTerm, @POStatus, @TotalAmount,@OtherCharges, @IsVAT, @VATAmount, @NetAmount, @IsCancel, 
				@Remarks, @CreatedBy, @ModifiedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[PurchaseOrderHistorySave]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_PurchaseOrderHistoryDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [PurchaseOrderHistory] Record  based on [PurchaseOrderHistory]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_PurchaseOrderHistoryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHistoryDelete] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHistoryDelete] 
     
    @PONo varchar(50),
    @BranchID smallint
AS 

	
BEGIN
 
	DELETE
	FROM   [Operation].[PurchaseOrderHistory]
	WHERE   [PONo] = @PONo
	       AND [BranchID] = @BranchID
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_PurchaseOrderHistoryDelete]
-- ========================================================================================================================================

GO
 

