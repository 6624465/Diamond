

-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [SIHeader] Record based on [SIHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_SIHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderSelect] 
    @DocumentNo VARCHAR(50),
    @BranchID SMALLINT
AS 
 

BEGIN

	SELECT [DocumentNo], [BranchID], [DocumentDate], [SupplierCode], [SupplierPI], [CustomerCode], [CustomerPO], [PaymentTerm], [TTDate], [IsOriginalDoc], [ETA], [ConfirmETA], [ETD], [ConfirmETD], [Remark], [POL], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[SIHeader] WITH (NOLOCK)
	WHERE  [DocumentNo] = @DocumentNo  
	       AND [BranchID] = @BranchID 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [SIHeader] Records from [SIHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_SIHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderList] 
	@BranchID SMALLINT
AS 
 
BEGIN
	SELECT [DocumentNo], [BranchID], [DocumentDate], [SupplierCode], [SupplierPI], [CustomerCode], [CustomerPO], [PaymentTerm], [TTDate], [IsOriginalDoc], [ETA], [ConfirmETA], [ETD], [ConfirmETD], [Remark], [POL], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[SIHeader] WITH (NOLOCK)
	WHERE  [BranchID] = @BranchID 

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [SIHeader] Record Into [SIHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderInsert] 
    @DocumentNo varchar(50),
    @BranchID smallint,
    @DocumentDate datetime,
    @SupplierCode nvarchar(50),
    @SupplierPI nvarchar(50),
    @CustomerCode nvarchar(50),
    @CustomerPO nvarchar(50),
    @PaymentTerm nvarchar(50),
    @TTDate datetime=null,
    @IsOriginalDoc bit,
    @ETA datetime=null,
    @ConfirmETA datetime=null,
    @ETD datetime=null,
    @ConfirmETD datetime=null,
    @Remark nvarchar(MAX),
    @POL nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@NewDocumentNo varchar(50) OUTPUT
AS 
  

BEGIN
	
	INSERT INTO [Operation].[SIHeader] (
			[DocumentNo], [BranchID], [DocumentDate], [SupplierCode], [SupplierPI], [CustomerCode], [CustomerPO], [PaymentTerm], [TTDate], 
			[IsOriginalDoc], [ETA], [ConfirmETA], [ETD], [ConfirmETD], [Remark], [POL], [CreatedBy], [CreatedOn])
	SELECT	@DocumentNo, @BranchID, @DocumentDate, @SupplierCode, @SupplierPI, @CustomerCode, @CustomerPO, @PaymentTerm, @TTDate, 
			@IsOriginalDoc, @ETA, @ConfirmETA, @ETD, @ConfirmETD, @Remark, @POL, @CreatedBy, GetDAte()
	
	Select @NewDocumentNo = @DocumentNo
               

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [SIHeader] Record Into [SIHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderUpdate] 
    @DocumentNo varchar(50),
    @BranchID smallint,
    @DocumentDate datetime,
    @SupplierCode nvarchar(50),
    @SupplierPI nvarchar(50),
    @CustomerCode nvarchar(50),
    @CustomerPO nvarchar(50),
    @PaymentTerm nvarchar(50),
    @TTDate datetime=null,
    @IsOriginalDoc bit,
    @ETA datetime=null,
    @ConfirmETA datetime=null,
    @ETD datetime=null,
    @ConfirmETD datetime=null,
    @Remark nvarchar(MAX),
    @POL nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@NewDocumentNo varchar(50) OUTPUT
AS 
 
	
BEGIN

	UPDATE	[Operation].[SIHeader]
	SET		[SupplierCode] = @SupplierCode, [SupplierPI] = @SupplierPI, [CustomerCode] = @CustomerCode, [CustomerPO] = @CustomerPO, 
			[PaymentTerm] = @PaymentTerm, [TTDate] = @TTDate, [IsOriginalDoc] = @IsOriginalDoc, [ETA] = @ETA, [ConfirmETA] = @ConfirmETA, [ETD] = @ETD, 
			[ConfirmETD] = @ConfirmETD, [Remark] = @Remark, [POL] = @POL, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE	[DocumentNo] = @DocumentNo
			AND [BranchID] = @BranchID
	
		Select @NewDocumentNo = @DocumentNo

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [SIHeader] Record Into [SIHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderSave] 
    @DocumentNo varchar(50),
    @BranchID smallint,
    @DocumentDate datetime,
    @SupplierCode nvarchar(50),
    @SupplierPI nvarchar(50),
    @CustomerCode nvarchar(50),
    @CustomerPO nvarchar(50),
    @PaymentTerm nvarchar(50),
    @TTDate datetime=null,
    @IsOriginalDoc bit,
    @ETA datetime=null,
    @ConfirmETA datetime=null,
    @ETD datetime=null,
    @ConfirmETD datetime=null,
    @Remark nvarchar(MAX),
    @POL nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@NewDocumentNo varchar(50) OUTPUT
AS 
 

BEGIN

Declare @dt DateTime,
		@DocID varchar(50),
		@vTransID UNIQUEIDENTIFIER ,
		@vTransactionType Varchar(10),
		@vHistoryCount int=1
					
		Select @vTransID = NEWID(), @vTransactionType = ''

	IF (SELECT COUNT(0) FROM [Operation].[SIHeader] 
		WHERE 	[DocumentNo] = @DocumentNo
	       AND [BranchID] = @BranchID)>0
	BEGIN
	    Exec [Operation].[usp_SIHeaderUpdate] 
				@DocumentNo, @BranchID, @DocumentDate, @SupplierCode, @SupplierPI, @CustomerCode, @CustomerPO, @PaymentTerm, @TTDate, @IsOriginalDoc, @ETA, 
				@ConfirmETA, @ETD, @ConfirmETD, @Remark, @POL, @CreatedBy, @ModifiedBy ,@NewDocumentNo=@NewDocumentNo OUTPUT


		Select @vHistoryCount = COUNT(0) 
		From [Operation].[SIHeaderHistory]
		Where DocumentNo = @DocumentNo And BranchID = @BranchID

		Select @vTransactionType = 'Revised #' + Convert(varchar(3),@vHistoryCount)

		Exec [Operation].[usp_SIHeaderHistoryInsert] 
				@vTransID, @DocumentNo, @BranchID, @DocumentDate, @vTransactionType, @DocumentDate, @SupplierCode, @SupplierPI, @CustomerCode, 
				@CustomerPO, @PaymentTerm, @TTDate, @IsOriginalDoc, @ETA, @ConfirmETA, @ETD, @ConfirmETD, @Remark, @POL, 1, 
				@CreatedBy, @ModifiedBy



	END
	ELSE
	BEGIN

		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber]10, 'SI', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()

		set @DocumentNo =''
		IF LEN(@DocumentNo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] @BranchID,'SI', @Dt ,@CreatedBy, @DocumentNo OUTPUT
	

	    Exec [Operation].[usp_SIHeaderInsert] 
				@DocumentNo, @BranchID, @DocumentDate, @SupplierCode, @SupplierPI, @CustomerCode, @CustomerPO, @PaymentTerm, @TTDate, @IsOriginalDoc, @ETA, 
				@ConfirmETA, @ETD, @ConfirmETD, @Remark, @POL, @CreatedBy, @ModifiedBy ,@NewDocumentNo=@NewDocumentNo OUTPUT


		Select @vTransactionType = '1'

		Exec [Operation].[usp_SIHeaderHistoryInsert] 
				@vTransID, @DocumentNo, @BranchID, @DocumentDate, @vTransactionType, @DocumentDate, @SupplierCode, @SupplierPI, @CustomerCode, 
				@CustomerPO, @PaymentTerm, @TTDate, @IsOriginalDoc, @ETA, @ConfirmETA, @ETD, @ConfirmETD, @Remark, @POL, 1, 
				@CreatedBy, @ModifiedBy


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[SIHeaderSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_SIHeaderDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [SIHeader] Record  based on [SIHeader]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_SIHeaderDelete] 
    @DocumentNo varchar(50),
    @BranchID smallint
AS 

	
BEGIN

	UPDATE	[Operation].[SIHeader]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[DocumentNo] = @DocumentNo
	       AND [BranchID] = @BranchID

	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIHeaderDelete]
-- ========================================================================================================================================

GO


