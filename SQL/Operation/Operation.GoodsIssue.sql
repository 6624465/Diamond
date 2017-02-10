

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsIssue] Record based on [GoodsIssue] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsIssueSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueSelect] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueSelect] 
    @DocumentNo VARCHAR(50)
AS 
 

BEGIN

	SELECT	Hd.[DocumentNo], Hd.[DocumentDate], Hd.[BranchID], Hd.[CustomerCode], Hd.[SupplierCode], Hd.[Remarks],
			Hd.[ReferenceNo], Hd.[Status], Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn],
			Sp.CustomerName As SupplierName,Cs.CustomerName As CustomerName
	FROM	[Operation].[GoodsIssue] Hd 
	Left Outer Join Master.Customer Sp On 
		Hd.SupplierCode = Sp.CustomerCode
	Left Outer Join Master.Customer Cs On 
		Hd.CustomerCode = Cs.CustomerCode
	WHERE  Hd.[DocumentNo] = @DocumentNo  

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [GoodsIssue] Records from [GoodsIssue] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsIssueList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueList] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueList] 

AS 
 
BEGIN
	
	SELECT	Hd.[DocumentNo], Hd.[DocumentDate], Hd.[BranchID], Hd.[CustomerCode], Hd.[SupplierCode], Hd.[Remarks],
			Hd.[ReferenceNo], Hd.[Status], Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn],
			Sp.CustomerName As SupplierName,Cs.CustomerName As CustomerName
	FROM	[Operation].[GoodsIssue] Hd 
	Left Outer Join Master.Customer Sp On 
		Hd.SupplierCode = Sp.CustomerCode
	Left Outer Join Master.Customer Cs On 
		Hd.CustomerCode = Cs.CustomerCode
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueList] 
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [GoodsIssue] Record Into [GoodsIssue] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsIssueInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueInsert] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueInsert] 
    @DocumentNo varchar(50),
    @DocumentDate datetime,
    @BranchID smallint,
    @CustomerCode nvarchar(50),
    @SupplierCode nvarchar(50),
    @Remarks nvarchar(MAX),
    @ReferenceNo nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
  

BEGIN
	
	INSERT INTO [Operation].[GoodsIssue] (
	
			[DocumentNo], [DocumentDate], [BranchID], [CustomerCode], [SupplierCode], [Remarks], [ReferenceNo], [CreatedBy], [CreatedOn])
	SELECT	@DocumentNo, @DocumentDate, @BranchID, @CustomerCode, @SupplierCode, @Remarks, @ReferenceNo, @CreatedBy, GetDate()


	Select @NewDocumentNo = @DocumentNo
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [GoodsIssue] Record Into [GoodsIssue] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsIssueUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueUpdate] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueUpdate] 
    @DocumentNo varchar(50),
    @DocumentDate datetime,
    @BranchID smallint,
    @CustomerCode nvarchar(50),
    @SupplierCode nvarchar(50),
    @Remarks nvarchar(MAX),
    @ReferenceNo nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
 
	
BEGIN

	UPDATE [Operation].[GoodsIssue]
	SET    [CustomerCode] = @CustomerCode, [SupplierCode] = @SupplierCode, [Remarks] = @Remarks, [ReferenceNo] = @ReferenceNo, 
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE  [DocumentNo] = @DocumentNo
	

	Select @NewDocumentNo = @DocumentNo

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueUpdate]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [GoodsIssue] Record Into [GoodsIssue] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsIssueSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueSave] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueSave] 
    @DocumentNo varchar(50),
    @DocumentDate datetime,
    @BranchID smallint,
    @CustomerCode nvarchar(50),
    @SupplierCode nvarchar(50),
    @Remarks nvarchar(MAX),
    @ReferenceNo nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
 

BEGIN
Declare @dt DateTime,
	 @DocID varchar(50)


	IF (SELECT COUNT(0) FROM [Operation].[GoodsIssue] 
		WHERE 	[DocumentNo] = @DocumentNo
				And BranchId = @BranchID)>0
	BEGIN
	    Exec [Operation].[usp_GoodsIssueUpdate] 
			@DocumentNo, @DocumentDate, @BranchID, @CustomerCode, @SupplierCode, @Remarks, @ReferenceNo, @CreatedBy, @ModifiedBy,@NewDocumentNo=@NewDocumentNo OUTPUT


	END
	ELSE
	BEGIN

		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber]10, 'GI', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()

		Set @DocumentNo =''

		IF LEN(@DocumentNo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] @BranchID,'GI', @Dt ,@CreatedBy, @DocumentNo OUTPUT


	    Exec [Operation].[usp_GoodsIssueInsert] 
			@DocumentNo, @DocumentDate, @BranchID, @CustomerCode, @SupplierCode, @Remarks, @ReferenceNo, @CreatedBy, @ModifiedBy,@NewDocumentNo=@NewDocumentNo OUTPUT


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[GoodsIssueSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [GoodsIssue] Record  based on [GoodsIssue]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsIssueDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueDelete] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueDelete] 
    @DocumentNo varchar(50),
	@ModifiedBy varchar(50)
AS 

	
BEGIN

	UPDATE	[Operation].[GoodsIssue]
	SET	[Status] = CAST(0 as bit),ModifiedBy=@ModifiedBy , ModifiedOn = GetDate()
	WHERE 	[DocumentNo] = @DocumentNo

	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueDelete]
-- ========================================================================================================================================

GO

 