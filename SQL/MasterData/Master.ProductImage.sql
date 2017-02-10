

-- ========================================================================================================================================
-- START											 [Master].[usp_ProductImageSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Select the [ProductImage] Record based on [ProductImage] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_ProductImageSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductImageSelect] 
END 
GO
CREATE PROC [Master].[usp_ProductImageSelect] 
    @ProductCode nVARCHAR(50)
AS 
 

BEGIN

	SELECT [ProductCode] As Code, [ProductImage] As ProductImg,[FileName] 
	FROM   [Master].[ProductImage] WITH (NOLOCK)
	WHERE  [ProductCode] = @ProductCode 

END
-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductImageSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Master].[usp_ProductImageList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Select all the [ProductImage] Records from [ProductImage] table
-- ========================================================================================================================================


IF OBJECT_ID('[Master].[usp_ProductImageList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductImageList] 
END 
GO
CREATE PROC [Master].[usp_ProductImageList] 

AS 
 
BEGIN
	SELECT [ProductCode] As Code, [ProductImage] As ProductImg ,[FileName]
	FROM   [Master].[ProductImage] WITH (NOLOCK)

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductImageList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Master].[usp_ProductImageInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Inserts the [ProductImage] Record Into [ProductImage] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductImageInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductImageInsert] 
END 
GO
CREATE PROC [Master].[usp_ProductImageInsert] 
    @ProductCode nvarchar(50),
    @ProductImage varbinary(MAX),
	@FileName nvarchar(max)
AS 
  

BEGIN
	
	INSERT INTO [Master].[ProductImage] ([ProductCode], [ProductImage],[FileName])
	SELECT @ProductCode, @ProductImage,@FileName  
	
               
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductImageInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Master].[usp_ProductImageUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	updates the [ProductImage] Record Into [ProductImage] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductImageUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductImageUpdate] 
END 
GO
CREATE PROC [Master].[usp_ProductImageUpdate] 
    @ProductCode nvarchar(50),
    @ProductImage varbinary(MAX),
	@FileName nvarchar(max)
AS 
 
	
BEGIN

	UPDATE [Master].[ProductImage]
	SET    [ProductCode] = @ProductCode, [ProductImage] = @ProductImage,[FileName]=@FileName  
	WHERE  [ProductCode] = @ProductCode
	

END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductImageUpdate]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Master].[usp_ProductImageSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Either INSERT or UPDATE the [ProductImage] Record Into [ProductImage] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductImageSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductImageSave] 
END 
GO
CREATE PROC [Master].[usp_ProductImageSave] 
    @ProductCode nvarchar(50),
    @ProductImage varbinary(MAX),
	@FileName nvarchar(max)
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Master].[ProductImage] 
		WHERE 	[ProductCode] = @ProductCode)>0
	BEGIN
	    Exec [Master].[usp_ProductImageUpdate] 
		@ProductCode, @ProductImage,@FileName  


	END
	ELSE
	BEGIN
	    Exec [Master].[usp_ProductImageInsert] 
		@ProductCode, @ProductImage,@FileName  


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Master].usp_[ProductImageSave]
-- ========================================================================================================================================

GO




----------------- Start of Delete-----------------------------------


-- ========================================================================================================================================
-- START											 [Master].[usp_ProductImageDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Deletes the [ProductImage] Record  based on [ProductImage]

-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ProductImageDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_ProductImageDelete] 
END 
GO
CREATE PROC [Master].[usp_ProductImageDelete] 
    @ProductCode nvarchar(50)
AS 

	
BEGIN

 
	DELETE
	FROM   [Master].[ProductImage]
	WHERE  [ProductCode] = @ProductCode
	 
END

-- ========================================================================================================================================
-- END  											 [Master].[usp_ProductImageDelete]
-- ========================================================================================================================================

GO
 