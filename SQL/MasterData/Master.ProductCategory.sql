-- ========================================================================================================================================
-- START											 [Master].[usp_ProductCategorySelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [ProductCategory] Record based on [ProductCategory] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_ProductCategorySelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductCategorySelect] 
END 
GO
CREATE PROC [Master].[usp_ProductCategorySelect] 
    @CategoryCode NVARCHAR(50)
AS 
 

BEGIN

	SELECT [CategoryCode], [Description], [IsInternalStock], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[ProductCategory]
	WHERE  [CategoryCode] = @CategoryCode 

END
-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductCategorySelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Master].[usp_ProductCategoryList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [ProductCategory] Records from [ProductCategory] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_ProductCategoryList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductCategoryList] 
END 
GO
CREATE PROC [Master].[usp_ProductCategoryList] 

AS 
 
BEGIN
	SELECT [CategoryCode], [Description], [IsInternalStock], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[ProductCategory] 

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductCategoryList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_ProductCategoryInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [ProductCategory] Record Into [ProductCategory] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductCategoryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductCategoryInsert] 
END 
GO
CREATE PROC [Master].[usp_ProductCategoryInsert] 
    @CategoryCode nvarchar(50),
    @Description nvarchar(MAX),
    @IsInternalStock bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
  

BEGIN
	
	INSERT INTO [Master].[ProductCategory] ([CategoryCode], [Description], [IsInternalStock], [CreatedBy], [CreatedOn])
	SELECT @CategoryCode, @Description, @IsInternalStock, @CreatedBy, GETDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductCategoryInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_ProductCategoryUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [ProductCategory] Record Into [ProductCategory] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductCategoryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductCategoryUpdate] 
END 
GO
CREATE PROC [Master].[usp_ProductCategoryUpdate] 
    @CategoryCode nvarchar(50),
    @Description nvarchar(MAX),
    @IsInternalStock bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
BEGIN

	UPDATE [Master].[ProductCategory]
	SET    [Description] = @Description, [IsInternalStock] = @IsInternalStock, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE  [CategoryCode] = @CategoryCode
	

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductCategoryUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_ProductCategorySave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [ProductCategory] Record Into [ProductCategory] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductCategorySave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductCategorySave] 
END 
GO
CREATE PROC [Master].[usp_ProductCategorySave] 
    @CategoryCode nvarchar(50),
    @Description nvarchar(MAX),
    @IsInternalStock bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
    
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Master].[ProductCategory] 
		WHERE 	[CategoryCode] = @CategoryCode)>0
	BEGIN
	    Exec [Master].[usp_ProductCategoryUpdate] 
		@CategoryCode, @Description, @IsInternalStock, @CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Master].[usp_ProductCategoryInsert] 
		@CategoryCode, @Description, @IsInternalStock, @CreatedBy, @ModifiedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Master].usp_[ProductCategorySave]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_ProductCategoryDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [ProductCategory] Record  based on [ProductCategory]

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductCategoryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductCategoryDelete] 
END 
GO
CREATE PROC [Master].[usp_ProductCategoryDelete] 
    @CategoryCode nvarchar(50)
AS 

	
BEGIN

	 
	DELETE
	FROM   [Master].[ProductCategory]
	WHERE  [CategoryCode] = @CategoryCode
	 
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductCategoryDelete]
-- ========================================================================================================================================

GO

 