
-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderHistorySelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [SIHeaderHistory] Record based on [SIHeaderHistory] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_SIHeaderHistorySelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderHistorySelect] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderHistorySelect] 
    @DocumentNo VARCHAR(50),
    @BranchID SMALLINT
AS 
 

BEGIN

	SELECT [TransactionID], [DocumentNo], [BranchID], [TransactionDate], [TransactionType], [DocumentDate], [SupplierCode], [SupplierPI], [CustomerCode], [CustomerPO], [PaymentTerm], [TTDate], [IsOriginalDoc], [ETA], [ConfirmETA], [ETD], [ConfirmETD], [Remark], [POL], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[SIHeaderHistory] WITH (NOLOCK)
	WHERE  [DocumentNo] = @DocumentNo  
	       And [BranchID] = @BranchID  

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderHistorySelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderHistoryList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [SIHeaderHistory] Records from [SIHeaderHistory] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_SIHeaderHistoryList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderHistoryList] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderHistoryList] 
    @DocumentNo VARCHAR(50),
    @BranchID SMALLINT

AS 
 
BEGIN
	SELECT [TransactionID], [DocumentNo], [BranchID], [TransactionDate], [TransactionType], [DocumentDate], [SupplierCode], [SupplierPI], [CustomerCode], [CustomerPO], [PaymentTerm], [TTDate], [IsOriginalDoc], [ETA], [ConfirmETA], [ETD], [ConfirmETD], [Remark], [POL], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[SIHeaderHistory] WITH (NOLOCK)
	WHERE  [DocumentNo] = @DocumentNo  
	       And [BranchID] = @BranchID  

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderHistoryList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderHistoryInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [SIHeaderHistory] Record Into [SIHeaderHistory] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIHeaderHistoryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderHistoryInsert] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderHistoryInsert] 
    @TransactionID uniqueidentifier,
    @DocumentNo varchar(50),
    @BranchID smallint,
    @TransactionDate datetime,
    @TransactionType varchar(50),
    @DocumentDate datetime,
    @SupplierCode nvarchar(50),
    @SupplierPI nvarchar(50),
    @CustomerCode nvarchar(50),
    @CustomerPO nvarchar(50),
    @PaymentTerm nvarchar(50),
    @TTDate datetime,
    @IsOriginalDoc bit,
    @ETA datetime,
    @ConfirmETA datetime,
    @ETD datetime,
    @ConfirmETD datetime,
    @Remark nvarchar(MAX),
    @POL nvarchar(50),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
    
AS 
  

BEGIN
	
	INSERT INTO [Operation].[SIHeaderHistory] (
			[TransactionID], [DocumentNo], [BranchID], [TransactionDate], [TransactionType], [DocumentDate], [SupplierCode], [SupplierPI], [CustomerCode], 
			[CustomerPO], [PaymentTerm], [TTDate], [IsOriginalDoc], [ETA], [ConfirmETA], [ETD], [ConfirmETD], [Remark], [POL], [Status], 
			[CreatedBy], [CreatedOn])
	SELECT	@TransactionID, @DocumentNo, @BranchID, @TransactionDate, @TransactionType, @DocumentDate, @SupplierCode, @SupplierPI, @CustomerCode, 
			@CustomerPO, @PaymentTerm, @TTDate, @IsOriginalDoc, @ETA, @ConfirmETA, @ETD, @ConfirmETD, @Remark, @POL, @Status, 
			@CreatedBy, GetDate()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderHistoryInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderHistoryUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [SIHeaderHistory] Record Into [SIHeaderHistory] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIHeaderHistoryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderHistoryUpdate] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderHistoryUpdate] 
    @TransactionID uniqueidentifier,
    @DocumentNo varchar(50),
    @BranchID smallint,
    @TransactionDate datetime,
    @TransactionType varchar(50),
    @DocumentDate datetime,
    @SupplierCode nvarchar(50),
    @SupplierPI nvarchar(50),
    @CustomerCode nvarchar(50),
    @CustomerPO nvarchar(50),
    @PaymentTerm nvarchar(50),
    @TTDate datetime,
    @IsOriginalDoc bit,
    @ETA datetime,
    @ConfirmETA datetime,
    @ETD datetime,
    @ConfirmETD datetime,
    @Remark nvarchar(MAX),
    @POL nvarchar(50),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
 
	
BEGIN

	UPDATE	[Operation].[SIHeaderHistory]
	SET		[TransactionDate] = @TransactionDate, [TransactionType] = @TransactionType, [DocumentDate] = @DocumentDate, [SupplierCode] = @SupplierCode, 
			[SupplierPI] = @SupplierPI, [CustomerCode] = @CustomerCode, [CustomerPO] = @CustomerPO, [PaymentTerm] = @PaymentTerm, [TTDate] = @TTDate, 
			[IsOriginalDoc] = @IsOriginalDoc, [ETA] = @ETA, [ConfirmETA] = @ConfirmETA, [ETD] = @ETD, [ConfirmETD] = @ConfirmETD, [Remark] = @Remark, 
			[POL] = @POL, [Status] = @Status, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE	[TransactionID] = @TransactionID
			AND [DocumentNo] = @DocumentNo
			AND [BranchID] = @BranchID
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderHistoryUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderHistorySave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [SIHeaderHistory] Record Into [SIHeaderHistory] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIHeaderHistorySave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderHistorySave] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderHistorySave] 
    @TransactionID uniqueidentifier,
    @DocumentNo varchar(50),
    @BranchID smallint,
    @TransactionDate datetime,
    @TransactionType varchar(50),
    @DocumentDate datetime,
    @SupplierCode nvarchar(50),
    @SupplierPI nvarchar(50),
    @CustomerCode nvarchar(50),
    @CustomerPO nvarchar(50),
    @PaymentTerm nvarchar(50),
    @TTDate datetime,
    @IsOriginalDoc bit,
    @ETA datetime,
    @ConfirmETA datetime,
    @ETD datetime,
    @ConfirmETD datetime,
    @Remark nvarchar(MAX),
    @POL nvarchar(50),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[SIHeaderHistory] 
		WHERE 	[TransactionID] = @TransactionID
	       AND [DocumentNo] = @DocumentNo
	       AND [BranchID] = @BranchID)>0
	BEGIN
	    Exec [Operation].[usp_SIHeaderHistoryUpdate] 
				@TransactionID, @DocumentNo, @BranchID, @TransactionDate, @TransactionType, @DocumentDate, @SupplierCode, @SupplierPI, @CustomerCode, 
				@CustomerPO, @PaymentTerm, @TTDate, @IsOriginalDoc, @ETA, @ConfirmETA, @ETD, @ConfirmETD, @Remark, @POL, @Status, 
				@CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_SIHeaderHistoryInsert] 
				@TransactionID, @DocumentNo, @BranchID, @TransactionDate, @TransactionType, @DocumentDate, @SupplierCode, @SupplierPI, @CustomerCode, 
				@CustomerPO, @PaymentTerm, @TTDate, @IsOriginalDoc, @ETA, @ConfirmETA, @ETD, @ConfirmETD, @Remark, @POL, @Status, 
				@CreatedBy, @ModifiedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[SIHeaderHistorySave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderHistoryDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [SIHeaderHistory] Record  based on [SIHeaderHistory]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIHeaderHistoryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderHistoryDelete] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderHistoryDelete] 
    @DocumentNo varchar(50),
    @BranchID smallint
AS 

	
BEGIN

	 
	DELETE
	FROM   [Operation].[SIHeaderHistory]
	WHERE  [DocumentNo] = @DocumentNo
	       AND [BranchID] = @BranchID
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderHistoryDelete]
-- ========================================================================================================================================

GO
 

