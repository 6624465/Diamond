/* 
=======================================================================
 START		[Master].[usp_CompanySelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Company] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CompanySelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CompanySelect] 
END 
GO
CREATE PROC [Master].[usp_CompanySelect] 
    @CompanyCode nvarchar(20)
AS 
BEGIN 
	SELECT [CompanyCode], [CompanyName], [RegNo], [IsActive], [AddressID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[Company] 
	WHERE  [CompanyCode] = @CompanyCode  
END
GO

/* 
=======================================================================
 END		[Master].[usp_CompanySelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CompanyList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[Company] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CompanyList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CompanyList] 
END 
GO
CREATE PROC [Master].[usp_CompanyList] 
    
AS 
BEGIN 
	SELECT [CompanyCode], [CompanyName], [RegNo], [IsActive], [AddressID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[Company] 
	 
END
GO
/* 
=======================================================================
 END		[Master].[usp_CompanySelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_CompanyInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[Company] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CompanyInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CompanyInsert] 
END 
GO
CREATE PROC [Master].[usp_CompanyInsert] 
    @CompanyCode nvarchar(20),
    @CompanyName nvarchar(250),
    @RegNo nvarchar(20),
    @IsActive bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
BEGIN 
	INSERT INTO [Master].[Company] (
			[CompanyCode], [CompanyName], [RegNo], [Logo], [IsActive], [CreatedBy], [CreatedOn] )
	SELECT	@CompanyCode, @CompanyName, @RegNo, NULL, @IsActive, @CreatedBy, getdate()
END	
GO
/* 
=======================================================================
 END		[Master].[usp_CompanyInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_CompanyUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[Company] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CompanyUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CompanyUpdate] 
END 
GO
CREATE PROC [Master].[usp_CompanyUpdate] 
    @CompanyCode nvarchar(20),
    @CompanyName nvarchar(250),
    @RegNo nvarchar(20),
    @IsActive bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
BEGIN 

	UPDATE	[Master].[Company]
	SET		[CompanyCode] = @CompanyCode, [CompanyName] = @CompanyName, [RegNo] = @RegNo, [Logo] = NULL, 
			[IsActive] = @IsActive,  [ModifiedBy] = @ModifiedBy, [ModifiedOn] = Getdate()
	WHERE	[CompanyCode] = @CompanyCode
END	
GO
/* 
=======================================================================
 END		[Master].[usp_CompanyUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CompanySave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[Company] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CompanySave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CompanySave] 
END 
GO
CREATE PROC [Master].[usp_CompanySave] 
    @CompanyCode nvarchar(20),
    @CompanyName nvarchar(250),
    @RegNo nvarchar(20),
    @IsActive bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
BEGIN 

	DELETE	FROM   [Master].[Company]

	IF (SELECT COUNT(0) FROM [Master].[Company]
		WHERE 	[CompanyCode] = @CompanyCode)>0
	BEGIN	
		EXEC [Master].[usp_CompanyUpdate] @CompanyCode, @CompanyName, @RegNo, @IsActive,   @CreatedBy,  @ModifiedBy 
	END
	Else
	BEGIN
	    EXEC [Master].[usp_CompanyInsert] @CompanyCode, @CompanyName, @RegNo, @IsActive, @CreatedBy,  @ModifiedBy 
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_CompanyUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_CompanyDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[Company] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_CompanyDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CompanyDelete] 
END 
GO
CREATE PROC [Master].[usp_CompanyDelete] 
    @CompanyCode Nvarchar(10)
AS 
BEGIN 

	DELETE
	FROM   [Master].[Company]
	WHERE  [CompanyCode] = @CompanyCode
END
GO
/* 
=======================================================================
 END		[Master].[usp_CompanyDelete]
=======================================================================
*/
 