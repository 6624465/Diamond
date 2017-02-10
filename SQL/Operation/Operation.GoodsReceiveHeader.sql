USE [NetStockDiamond];
GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveHeaderSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceiveHeader] Record based on [GoodsReceiveHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsReceiveHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveHeaderSelect] 
    @DocumentNo VARCHAR(50),
    @BranchID SMALLINT
AS 
 

BEGIN

	SELECT	Hd.[DocumentNo], Hd.[BranchID], Hd.[DocumentDate], Hd.[DocumentType], Hd.[SupplierCode], 
			Hd.[PONo], Hd.[Status], Hd.[IsApproved], Hd.[ApprovedBy], Hd.[ApprovedOn], Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn],
			ISNULL(Cus.CustomerName,'') As SupplierName
	FROM	[Operation].[GoodsReceiveHeader] Hd  
	LEFT OUTER JOIN Master.Customer Cus ON 
		Hd.SupplierCode = Cus.CustomerCode 
	WHERE	[DocumentNo] = @DocumentNo 
			AND [BranchID] = @BranchID 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveHeaderSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveHeaderList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [GoodsReceiveHeader] Records from [GoodsReceiveHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsReceiveHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveHeaderList] 
    @BranchID SMALLINT
AS 
 
BEGIN
	SELECT	Hd.[DocumentNo], Hd.[BranchID], Hd.[DocumentDate], Hd.[DocumentType], Hd.[SupplierCode], 
			Hd.[PONo], Hd.[Status], Hd.[IsApproved], Hd.[ApprovedBy], Hd.[ApprovedOn], Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn],
			ISNULL(Cus.CustomerName,'') As SupplierName
	FROM	[Operation].[GoodsReceiveHeader] Hd  
	LEFT OUTER JOIN Master.Customer Cus ON 
		Hd.SupplierCode = Cus.CustomerCode 
	--WHERE  [BranchID] = @BranchID 

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveHeaderList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveHeaderInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [GoodsReceiveHeader] Record Into [GoodsReceiveHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveHeaderInsert] 
    @DocumentNo varchar(50),
    @BranchID smallint,
    @DocumentDate datetime,
    @DocumentType varchar(20),
    @SupplierCode nvarchar(50),
    @PONo nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
  

BEGIN
	
	INSERT INTO [Operation].[GoodsReceiveHeader] (
			[DocumentNo], [BranchID], [DocumentDate], [DocumentType], [SupplierCode], [PONo], [Status], [CreatedBy], [CreatedOn])
	SELECT	@DocumentNo, @BranchID, @DocumentDate, @DocumentType, @SupplierCode, @PONo, Cast(1 as bit), @CreatedBy, GetDate()
	
	
	Select @NewDocumentNo = @DocumentNo
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveHeaderInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveHeaderUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [GoodsReceiveHeader] Record Into [GoodsReceiveHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveHeaderUpdate] 
    @DocumentNo varchar(50),
    @BranchID smallint,
    @DocumentDate datetime,
    @DocumentType varchar(20),
    @SupplierCode nvarchar(50),
    @PONo nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
 
	
BEGIN

	UPDATE [Operation].[GoodsReceiveHeader]
	SET		[SupplierCode] = @SupplierCode, [PONo] = @PONo,  
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE  [DocumentNo] = @DocumentNo
	       AND [BranchID] = @BranchID
	       
	Select @NewDocumentNo = @DocumentNo
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveHeaderUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveHeaderSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [GoodsReceiveHeader] Record Into [GoodsReceiveHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveHeaderSave] 
    @DocumentNo varchar(50),
    @BranchID smallint,
    @DocumentDate datetime,
    @DocumentType varchar(20),
    @SupplierCode nvarchar(50),
    @PONo nvarchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewDocumentNo varchar(50) OUTPUT
AS 
 

BEGIN

Declare @dt DateTime,
	 @DocID varchar(50)

	IF (SELECT COUNT(0) FROM [Operation].[GoodsReceiveHeader] 
		WHERE 	[DocumentNo] = @DocumentNo
	       AND [BranchID] = @BranchID)>0
	BEGIN
	    Exec [Operation].[usp_GoodsReceiveHeaderUpdate] 
				@DocumentNo, @BranchID, @DocumentDate, @DocumentType, @SupplierCode, @PONo, @CreatedBy, @ModifiedBy ,@NewDocumentNo=@NewDocumentNo OUTPUT


	END
	ELSE
	BEGIN
	
		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber]10, 'GoodsReceive', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()

		set @DocumentNo =''
		IF LEN(@DocumentNo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] @BranchID,'GoodsReceive', @Dt ,@CreatedBy, @DocumentNo OUTPUT
	
	
	
	    Exec [Operation].[usp_GoodsReceiveHeaderInsert] 
				@DocumentNo, @BranchID, @DocumentDate, @DocumentType, @SupplierCode, @PONo, @CreatedBy, @ModifiedBy  ,@NewDocumentNo=@NewDocumentNo OUTPUT


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[GoodsReceiveHeaderSave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceiveHeaderDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [GoodsReceiveHeader] Record  based on [GoodsReceiveHeader]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceiveHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceiveHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceiveHeaderDelete] 
    @DocumentNo varchar(50),
    @BranchID smallint
AS 

	
BEGIN

	UPDATE	[Operation].[GoodsReceiveHeader]
	SET	[Status] = CAST(0 as bit)
	WHERE 	[DocumentNo] = @DocumentNo
	       AND [BranchID] = @BranchID

	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceiveHeaderDelete]
-- ========================================================================================================================================

GO

 