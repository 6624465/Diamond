
/* 
=======================================================================
 START		[Master].[usp_CountrySelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Country] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CountrySelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CountrySelect] 
END 
GO
CREATE PROC [Master].[usp_CountrySelect] 
    @CountryCode varchar(2)
AS 
BEGIN 
	SELECT [CountryCode], [CountryName], [Description] 
	FROM   [Master].[Country] 
	WHERE  [CountryCode] = @CountryCode  
END
GO

/* 
=======================================================================
 END		[Master].[usp_CountrySelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CountryList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[Country] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CountryList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CountryList] 
END 
GO
CREATE PROC [Master].[usp_CountryList] 
    
AS 
BEGIN 
	SELECT [CountryCode], [CountryName], [Description] 
	FROM   [Master].[Country] 
	 
END
GO
/* 
=======================================================================
 END		[Master].[usp_CountrySelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_CountryInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[Country] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CountryInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CountryInsert] 
END 
GO
CREATE PROC [Master].[usp_CountryInsert] 
    @CountryCode varchar(2),
    @CountryName nvarchar(255),
    @Description nvarchar(255)
AS 
BEGIN 
	INSERT INTO [Master].[Country] ([CountryCode], [CountryName], [Description])
	SELECT @CountryCode, @CountryName, @Description
END	
GO
/* 
=======================================================================
 END		[Master].[usp_CountryInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_CountryUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[Country] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CountryUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CountryUpdate] 
END 
GO
CREATE PROC [Master].[usp_CountryUpdate] 
    @CountryCode varchar(2),
    @CountryName nvarchar(255),
    @Description nvarchar(255)
AS 
BEGIN 

	UPDATE [Master].[Country]
	SET    [CountryCode] = @CountryCode, [CountryName] = @CountryName, [Description] = @Description
	WHERE  [CountryCode] = @CountryCode
END	
GO
/* 
=======================================================================
 END		[Master].[usp_CountryUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CountrySave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[Country] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CountrySave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CountrySave] 
END 
GO
CREATE PROC [Master].[usp_CountrySave] 
    @CountryCode varchar(2),
    @CountryName nvarchar(255),
    @Description nvarchar(255)
AS 
BEGIN 



	IF (SELECT COUNT(0) FROM [Master].[Country]
		WHERE 	[CountryCode] = @CountryCode)>0
	BEGIN	
		EXEC [Master].[usp_CountryUpdate] @CountryCode, @CountryName, @Description
	END
	Else
	BEGIN
	    EXEC [Master].[usp_CountryInsert] @CountryCode, @CountryName, @Description
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_CountryUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_CountryDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[Country] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_CountryDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CountryDelete] 
END 
GO
CREATE PROC [Master].[usp_CountryDelete] 
    @CountryCode varchar(2)
AS 
BEGIN 

	DELETE
	FROM   [Master].[Country]
	WHERE  [CountryCode] = @CountryCode
END
GO
/* 
=======================================================================
 END		[Master].[usp_CountryDelete]
=======================================================================
*/

