-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentHeaderSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Select the [StockAdjustmentHeader] Record based on [StockAdjustmentHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_StockAdjustmentHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentHeaderSelect] 
    @DocumentNo VARCHAR(50)
AS 
 

BEGIN

	SELECT	Hd.[DocumentNo], Hd.[DocumentDate],Hd.BranchID, Hd.[CustomerCode], Hd.[Status], 
			Hd.[IsApproved], Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn] ,ISNULL(S.CustomerName,'') As CustomerName
	FROM	[Operation].[StockAdjustmentHeader] Hd WITH (NOLOCK)
	Left Outer Join [Master].[Customer] S ON 
		Hd.CustomerCode = S.CustomerCode
	WHERE	[DocumentNo] = @DocumentNo 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentHeaderSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentHeaderList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Select all the [StockAdjustmentHeader] Records from [StockAdjustmentHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_StockAdjustmentHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentHeaderList] 

AS 
 
BEGIN
	SELECT	Hd.[DocumentNo], Hd.[DocumentDate],Hd.BranchID, Hd.[CustomerCode], Hd.[Status], 
			Hd.[IsApproved], Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn] ,ISNULL(S.CustomerName,'') As CustomerName
	FROM	[Operation].[StockAdjustmentHeader] Hd WITH (NOLOCK)
	Left Outer Join [Master].[Customer] S ON 
		Hd.CustomerCode = S.CustomerCode

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentHeaderList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentHeaderInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Inserts the [StockAdjustmentHeader] Record Into [StockAdjustmentHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_StockAdjustmentHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentHeaderInsert] 
    @DocumentNo varchar(50),
    @DocumentDate datetime,
    @BranchID smallint,
    @CustomerCode nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
  

BEGIN
	
	INSERT INTO [Operation].[StockAdjustmentHeader] (
			[DocumentNo], [DocumentDate],BranchID, [CustomerCode], [CreatedBy],[CreatedOn])
	SELECT	@DocumentNo, @DocumentDate,@BranchID, @CustomerCode, @CreatedBy, GetDate()


	Select @NewDocumentNo = @DocumentNo
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentHeaderInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentHeaderUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	updates the [StockAdjustmentHeader] Record Into [StockAdjustmentHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_StockAdjustmentHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentHeaderUpdate] 
    @DocumentNo varchar(50),
    @DocumentDate datetime,
    @BranchID smallint,
    @CustomerCode nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
 
	
BEGIN

	UPDATE [Operation].[StockAdjustmentHeader]
	SET    [DocumentDate] = @DocumentDate, [CustomerCode] = @CustomerCode, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDAte()
	WHERE  [DocumentNo] = @DocumentNo
	
	Select @NewDocumentNo = @DocumentNo
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentHeaderUpdate]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentHeaderSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Either INSERT or UPDATE the [StockAdjustmentHeader] Record Into [StockAdjustmentHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_StockAdjustmentHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentHeaderSave] 
    @DocumentNo varchar(50),
    @DocumentDate datetime,
    @BranchID smallint,
    @CustomerCode nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
 

BEGIN
Declare @dt DateTime,
	 @DocID varchar(50)


	IF (SELECT COUNT(0) FROM [Operation].[StockAdjustmentHeader] 
		WHERE 	[DocumentNo] = @DocumentNo)>0
	BEGIN
	    Exec [Operation].[usp_StockAdjustmentHeaderUpdate] 
		@DocumentNo, @DocumentDate,@BranchID, @CustomerCode, @CreatedBy, @ModifiedBy,@NewDocumentNo OUTPUT


	END
	ELSE
	BEGIN

		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 'SA', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()

		set @DocumentNo='';

		IF LEN(@DocumentNo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] @BranchID,'SA', @Dt ,@CreatedBy, @DocumentNo OUTPUT

	    Exec [Operation].[usp_StockAdjustmentHeaderInsert] 
		@DocumentNo, @DocumentDate,@BranchID, @CustomerCode, @CreatedBy, @ModifiedBy,@NewDocumentNo OUTPUT


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[StockAdjustmentHeaderSave]
-- ========================================================================================================================================

GO




----------------- Start of Delete-----------------------------------


-- ========================================================================================================================================
-- START											 [Operation].[usp_StockAdjustmentHeaderDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Deletes the [StockAdjustmentHeader] Record  based on [StockAdjustmentHeader]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_StockAdjustmentHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockAdjustmentHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_StockAdjustmentHeaderDelete] 
    @DocumentNo varchar(50)
AS 

	
BEGIN

	UPDATE	[Operation].[StockAdjustmentHeader]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[DocumentNo] = @DocumentNo


	Return 1;

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_StockAdjustmentHeaderDelete]
-- ========================================================================================================================================

GO
