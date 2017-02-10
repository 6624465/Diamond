

-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberHeaderSelect]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Select the [DocumentNumberHeader] Record based on [DocumentNumberHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Utility].[usp_DocumentNumberHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberHeaderSelect] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberHeaderSelect] 
    @BranchID SMALLINT,
    @DocumentID VARCHAR(200),
    @DocumentKey VARCHAR(10)
AS 
 

	
	SELECT [BranchID], [DocumentID], [DocumentKey], [DocumentPrefix], [NumberLength], [LastNumber], [UseCompany], [UseBranch], [UseYear], [UseMonth], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Utility].[DocumentNumberHeader] WITH (NOLOCK)
	WHERE  [BranchID] = @BranchID 
	       AND [DocumentID] = @DocumentID  
	       AND [DocumentKey] = @DocumentKey 


-- ========================================================================================================================================
-- END  											 [Utility].[usp_DocumentNumberHeaderSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberHeaderList]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Select all the [DocumentNumberHeader] Records from [DocumentNumberHeader] table
-- ========================================================================================================================================


IF OBJECT_ID('[Utility].[usp_DocumentNumberHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberHeaderList] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberHeaderList] 

AS 
 
	SELECT [BranchID], [DocumentID], [DocumentKey], [DocumentPrefix], [NumberLength], [LastNumber], [UseCompany], [UseBranch], [UseYear], [UseMonth], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Utility].[DocumentNumberHeader]  WITH (NOLOCK)

-- ========================================================================================================================================
-- END  											 [Utility].[usp_DocumentNumberHeaderList]
-- ========================================================================================================================================

GO






-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberHeaderInsert]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Inserts the [DocumentNumberHeader] Record Into [DocumentNumberHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Utility].[usp_DocumentNumberHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberHeaderInsert] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberHeaderInsert] 
    @BranchID smallint,
    @DocumentID varchar(200),
    @DocumentKey varchar(10),
    @DocumentPrefix varchar(10),
    @NumberLength smallint,
    @LastNumber smallint,
    @UseCompany bit,
    @UseBranch bit,
    @UseYear bit,
    @UseMonth bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
  
	
	--BEGIN TRAN
	
	INSERT INTO [Utility].[DocumentNumberHeader] 
				([BranchID], [DocumentID], [DocumentKey], [DocumentPrefix], [NumberLength], [LastNumber], [UseCompany], [UseBranch], [UseYear], 
				[UseMonth], [CreatedBy], [CreatedOn])
	SELECT		@BranchID, @DocumentID, @DocumentKey, @DocumentPrefix, @NumberLength, @LastNumber, @UseCompany, @UseBranch, @UseYear, 
				@UseMonth, @CreatedBy, GETDATE()
	
               
	--COMMIT

-- ========================================================================================================================================
-- END  											 [Utility].[usp_DocumentNumberHeaderInsert]
-- ========================================================================================================================================

GO
-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberHeaderUpdate]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	updates the [DocumentNumberHeader] Record Into [DocumentNumberHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Utility].[usp_DocumentNumberHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberHeaderUpdate] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberHeaderUpdate] 
    @BranchID smallint,
    @DocumentID varchar(200),
    @DocumentKey varchar(10),
    @DocumentPrefix varchar(10),
    @NumberLength smallint,
    @LastNumber smallint,
    @UseCompany bit,
    @UseBranch bit,
    @UseYear bit,
    @UseMonth bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
	--BEGIN TRAN

	UPDATE	[Utility].[DocumentNumberHeader]
	SET		[BranchID] = @BranchID, [DocumentID] = @DocumentID, [DocumentKey] = @DocumentKey, [DocumentPrefix] = @DocumentPrefix, 
			[NumberLength] = @NumberLength, [LastNumber] = @LastNumber, [UseCompany] = @UseCompany, [UseBranch] = @UseBranch, [UseYear] = @UseYear, 
			[UseMonth] = @UseMonth, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE	[BranchID] = @BranchID
			AND [DocumentID] = @DocumentID
			AND [DocumentKey] = @DocumentKey
	

	--COMMIT

-- ========================================================================================================================================
-- END  											 [Utility].[usp_DocumentNumberHeaderUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Utility].[usp_DocumentNumberHeaderSave]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 	01-Dec-2011
-- Description:	Either INSERT or UPDATE the [DocumentNumberHeader] Record Into [DocumentNumberHeader] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Utility].[usp_DocumentNumberHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_DocumentNumberHeaderSave] 
END 
GO
CREATE PROC [Utility].[usp_DocumentNumberHeaderSave] 
    @BranchID smallint,
    @DocumentID varchar(200),
    @DocumentKey varchar(10),
    @DocumentPrefix varchar(10),
    @NumberLength smallint,
    @LastNumber smallint,
    @UseCompany bit,
    @UseBranch bit,
    @UseYear bit,
    @UseMonth bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
	--BEGIN TRAN

	IF (SELECT COUNT(0) FROM [Utility].[DocumentNumberHeader] 
		WHERE 	[BranchID] = @BranchID
	       AND [DocumentID] = @DocumentID
	       AND [DocumentKey] = @DocumentKey)>0
	BEGIN
	    Exec [Utility].[usp_DocumentNumberHeaderUpdate] 
						@BranchID, @DocumentID, @DocumentKey, @DocumentPrefix, @NumberLength, @LastNumber, @UseCompany, @UseBranch, @UseYear, @UseMonth, @CreatedBy, @ModifiedBy


	END
	ELSE
	BEGIN
	    Exec [Utility].[usp_DocumentNumberHeaderInsert] 
						@BranchID, @DocumentID, @DocumentKey, @DocumentPrefix, @NumberLength, @LastNumber, @UseCompany, @UseBranch, @UseYear, @UseMonth, @CreatedBy, @ModifiedBy


	END
	

	--COMMIT

	

-- ========================================================================================================================================
-- END  											 [Utility].usp_[DocumentNumberHeaderSave]
-- ========================================================================================================================================

GO


