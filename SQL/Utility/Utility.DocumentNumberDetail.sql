

-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberDetailSelect]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Select the [DocumentNumberDetail] Record based on [DocumentNumberDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Utility].[usp_DocumentNumberDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberDetailSelect] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberDetailSelect] 
    @BranchID SMALLINT,
    @DocumentKey VARCHAR(10),
    @YearNo SMALLINT
AS 
 

	
	SELECT [BranchID], [DocumentKey], [YearNo], [January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December] 
	FROM   [Utility].[DocumentNumberDetail] WITH (NOLOCK)
	WHERE  [BranchID] = @BranchID  
	       AND [DocumentKey] = @DocumentKey 
	       AND [YearNo] = @YearNo 


-- ========================================================================================================================================
-- END  											 [Utility].[usp_DocumentNumberDetailSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberDetailList]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Select all the [DocumentNumberDetail] Records from [DocumentNumberDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Utility].[usp_DocumentNumberDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberDetailList] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberDetailList] 

AS 
 
	SELECT [BranchID], [DocumentKey], [YearNo], [January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December] 
	FROM   [Utility].[DocumentNumberDetail]  WITH (NOLOCK)

-- ========================================================================================================================================
-- END  											 [Utility].[usp_DocumentNumberDetailList]
-- ========================================================================================================================================

GO








-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberDetailInsert]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Inserts the [DocumentNumberDetail] Record Into [DocumentNumberDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Utility].[usp_DocumentNumberDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberDetailInsert] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberDetailInsert] 
    @BranchID smallint,
    @DocumentKey varchar(10),
    @YearNo smallint,
    @January bigint,
    @February bigint,
    @March bigint,
    @April bigint,
    @May bigint,
    @June bigint,
    @July bigint,
    @August bigint,
    @September bigint,
    @October bigint,
    @November bigint,
    @December bigint
AS 
  
	
	--BEGIN TRAN
	
	INSERT INTO [Utility].[DocumentNumberDetail] ([BranchID], [DocumentKey], [YearNo], [January], [February], [March], [April], [May], [June], [July], [August], [September], [October], [November], [December])
	SELECT @BranchID, @DocumentKey, @YearNo, @January, @February, @March, @April, @May, @June, @July, @August, @September, @October, @November, @December
	
               
	--COMMIT

-- ========================================================================================================================================
-- END  											 [Utility].[usp_DocumentNumberDetailInsert]
-- ========================================================================================================================================

GO
-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberDetailUpdate]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	updates the [DocumentNumberDetail] Record Into [DocumentNumberDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Utility].[usp_DocumentNumberDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberDetailUpdate] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberDetailUpdate] 
    @BranchID smallint,
    @DocumentKey varchar(10),
    @YearNo smallint,
    @January bigint,
    @February bigint,
    @March bigint,
    @April bigint,
    @May bigint,
    @June bigint,
    @July bigint,
    @August bigint,
    @September bigint,
    @October bigint,
    @November bigint,
    @December bigint
AS 
 
	
	--BEGIN TRAN

	UPDATE [Utility].[DocumentNumberDetail]
	SET    [BranchID] = @BranchID, [DocumentKey] = @DocumentKey, [YearNo] = @YearNo, [January] = @January, [February] = @February, [March] = @March, [April] = @April, [May] = @May, [June] = @June, [July] = @July, [August] = @August, [September] = @September, [October] = @October, [November] = @November, [December] = @December
	WHERE  [BranchID] = @BranchID
	       AND [DocumentKey] = @DocumentKey
	       AND [YearNo] = @YearNo
	

	--COMMIT

-- ========================================================================================================================================
-- END  											 [Utility].[usp_DocumentNumberDetailUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberDetailDelete]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Deletes the [DocumentNumberDetail] Record  based on [DocumentNumberDetail]

-- ========================================================================================================================================

IF OBJECT_ID('[Utility].[usp_DocumentNumberDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberDetailDelete] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberDetailDelete] 
    @BranchID smallint,
    @DocumentKey varchar(10),
    @YearNo smallint,
	@ModifiedBy varchar(25)
AS 

	

	DELETE
	FROM   [Utility].[DocumentNumberDetail]
	WHERE  [BranchID] = @BranchID
	       AND [DocumentKey] = @DocumentKey
	       AND [YearNo] = @YearNo

-- ========================================================================================================================================
-- END  											 [Utility].[usp_DocumentNumberDetailDelete]
-- ========================================================================================================================================

GO
-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberDetailSave]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Either INSERT or UPDATE the [DocumentNumberDetail] Record Into [DocumentNumberDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Utility].[usp_DocumentNumberDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberDetailSave] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberDetailSave] 
    @BranchID smallint,
    @DocumentKey varchar(10),
    @YearNo smallint,
    @January bigint,
    @February bigint,
    @March bigint,
    @April bigint,
    @May bigint,
    @June bigint,
    @July bigint,
    @August bigint,
    @September bigint,
    @October bigint,
    @November bigint,
    @December bigint
AS 
 
	
	--BEGIN TRAN

	IF (SELECT COUNT(0) FROM [Utility].[DocumentNumberDetail] 
		WHERE 	[BranchID] = @BranchID
	       AND [DocumentKey] = @DocumentKey
	       AND [YearNo] = @YearNo)>0
	BEGIN
	    Exec [Utility].[usp_DocumentNumberDetailUpdate] 
		@BranchID, @DocumentKey, @YearNo, @January, @February, @March, @April, @May, @June, @July, @August, @September, @October, @November, @December


	END
	ELSE
	BEGIN
	    Exec [Utility].[usp_DocumentNumberDetailInsert] 
		@BranchID, @DocumentKey, @YearNo, @January, @February, @March, @April, @May, @June, @July, @August, @September, @October, @November, @December


	END
	

	--COMMIT

	

-- ========================================================================================================================================
-- END  											 [Utility].usp_[DocumentNumberDetailSave]
-- ========================================================================================================================================

GO



