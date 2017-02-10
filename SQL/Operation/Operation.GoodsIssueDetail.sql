

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueDetailSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsIssueDetail] Record based on [GoodsIssueDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsIssueDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueDetailSelect] 
    @DocumentNo VARCHAR(50),
    @ProductCode NVARCHAR(50)
AS 
 

BEGIN

	SELECT	Dt.[DocumentNo], Dt.[ProductCode], Dt.[Qty], Dt.[LotNo],Dt.CurrentQty, Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],
			Pr.Description As ProductName,1 As Status
	FROM	[Operation].[GoodsIssueDetail] Dt
	Left Outer Join Master.Product Pr ON
		Dt.ProductCode = Pr.ProductCode
	WHERE	Dt.[DocumentNo] = @DocumentNo 
			AND Dt.[ProductCode] = @ProductCode 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueDetailSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueDetailList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [GoodsIssueDetail] Records from [GoodsIssueDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsIssueDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueDetailList] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueDetailList] 
	@DocumentNo VARCHAR(50)
AS 
 
BEGIN
	SELECT	Dt.[DocumentNo], Dt.[ProductCode], Dt.[Qty], Dt.[LotNo],Dt.CurrentQty, Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],
			Pr.Description As ProductName,1 As Status
	FROM	[Operation].[GoodsIssueDetail] Dt
	Left Outer Join Master.Product Pr ON
		Dt.ProductCode = Pr.ProductCode
	WHERE	Dt.[DocumentNo] = @DocumentNo

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueDetailList] 
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueDetailInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [GoodsIssueDetail] Record Into [GoodsIssueDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsIssueDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueDetailInsert] 
    @DocumentNo varchar(50),
    @ProductCode nvarchar(50),
    @Qty float,
    @LotNo nvarchar(50),
	@CurrentQty float,
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50) 
AS 
  

BEGIN
	
	INSERT INTO [Operation].[GoodsIssueDetail] ([DocumentNo], [ProductCode], [Qty], [LotNo],CurrentQty, [CreatedBy], [CreatedOn] )
	SELECT @DocumentNo, @ProductCode, @Qty, @LotNo,@CurrentQty, @CreatedBy, GetDate()
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueDetailInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueDetailUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [GoodsIssueDetail] Record Into [GoodsIssueDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsIssueDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueDetailUpdate] 
    @DocumentNo varchar(50),
    @ProductCode nvarchar(50),
    @Qty float,
    @LotNo nvarchar(50),
	@CurrentQty float,
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50) 
AS 
 
	
BEGIN

	UPDATE [Operation].[GoodsIssueDetail]
	SET    [Qty] = @Qty, [LotNo] = @LotNo,CurrentQty=@CurrentQty, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE  [DocumentNo] = @DocumentNo
	       AND [ProductCode] = @ProductCode
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueDetailUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueDetailSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [GoodsIssueDetail] Record Into [GoodsIssueDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsIssueDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueDetailSave] 
    @DocumentNo varchar(50),
    @ProductCode nvarchar(50),
    @Qty float,
    @LotNo float(50),
	@CurrentQty int,
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50) 
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[GoodsIssueDetail] 
		WHERE 	[DocumentNo] = @DocumentNo
	       AND [ProductCode] = @ProductCode)>0
	BEGIN
	    Exec [Operation].[usp_GoodsIssueDetailUpdate] 
			@DocumentNo, @ProductCode, @Qty, @LotNo,@CurrentQty, @CreatedBy, @ModifiedBy

	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_GoodsIssueDetailInsert] 
			@DocumentNo, @ProductCode, @Qty, @LotNo,@CurrentQty, @CreatedBy, @ModifiedBy


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[GoodsIssueDetailSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsIssueDetailDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [GoodsIssueDetail] Record  based on [GoodsIssueDetail]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsIssueDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsIssueDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_GoodsIssueDetailDelete] 
    @DocumentNo varchar(50)
    
AS 

	
BEGIN

	DELETE
	FROM   [Operation].[GoodsIssueDetail]
	WHERE  [DocumentNo] = @DocumentNo
	        
 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsIssueDetailDelete]
-- ========================================================================================================================================

GO

