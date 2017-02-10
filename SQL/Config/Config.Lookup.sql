/* 
=======================================================================
 START		[Config].[usp_LookupSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Config].[Lookup] Table

=======================================================================
*/

IF OBJECT_ID('[Config].[usp_LookupSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupSelect] 
END 
GO
CREATE PROC [Config].[usp_LookupSelect] 
    @LookupCode nvarchar(25)
AS 
BEGIN 
	SELECT [LookupCode], [Description], [Description2], [Category], [Status] 
	FROM   [Config].[Lookup] 
	WHERE  [LookupCode] = @LookupCode  
END
GO

/* 
=======================================================================
 END		[Config].[usp_LookupSelect]
=======================================================================
*/


/*
=======================================================================
START		[Config].[usp_LookupList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Config].[Lookup] Table

=======================================================================
*/

IF OBJECT_ID('[Config].[usp_LookupList]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupList] 
END 
GO
CREATE PROC [Config].[usp_LookupList] 
    
AS 
BEGIN 
	SELECT [LookupCode], [Description], [Description2], [Category], [Status] 
	FROM   [Config].[Lookup] 
	
END
GO
/* 
=======================================================================
 END		[Config].[usp_LookupSelect]
=======================================================================
*/
/*
=======================================================================
START		[Config].[usp_LookupInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Config].[Lookup] Table

=======================================================================
*/

IF OBJECT_ID('[Config].[usp_LookupInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupInsert] 
END 
GO
CREATE PROC [Config].[usp_LookupInsert] 
    @LookupCode nvarchar(25),
    @Description nvarchar(255),
    @Description2 nvarchar(255),
    @Category varchar(50),
    @Status bit
AS 
BEGIN 
	INSERT INTO [Config].[Lookup] ([LookupCode], [Description], [Description2], [Category], [Status])
	SELECT @LookupCode, @Description, @Description2, @Category, @Status
END	
GO
/* 
=======================================================================
 END		[Config].[usp_LookupInsert]
=======================================================================
*/

/*
=======================================================================
START		[Config].[usp_LookupUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Config].[Lookup] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Config].[usp_LookupUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupUpdate] 
END 
GO
CREATE PROC [Config].[usp_LookupUpdate] 
    @LookupCode nvarchar(25),
    @Description nvarchar(255),
    @Description2 nvarchar(255),
    @Category varchar(50),
    @Status bit
AS 
BEGIN 

	UPDATE [Config].[Lookup]
	SET    [Description] = @Description, [Description2] = @Description2, [Category] = @Category, [Status] = CAST(1 as bit)
	WHERE  [LookupCode] = @LookupCode
END	
GO
/* 
=======================================================================
 END		[Config].[usp_LookupUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Config].[usp_LookupSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Config].[Lookup] Table.

=======================================================================
*/

IF OBJECT_ID('[Config].[usp_LookupSave]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupSave] 
END 
GO
CREATE PROC [Config].[usp_LookupSave] 
    @LookupCode nvarchar(25),
    @Description nvarchar(255),
    @Description2 nvarchar(255),
    @Category varchar(50),
    @Status bit
AS 
BEGIN 

	IF (SELECT COUNT(0) FROM [Config].[Lookup]
		WHERE 	[LookupCode] = @LookupCode)>0
	BEGIN	
		EXEC [Config].[usp_LookupUpdate] @LookupCode, @Description, @Description2, @Category, @Status
	END
	Else
	BEGIN
	    EXEC [Config].[usp_LookupInsert] @LookupCode, @Description, @Description2, @Category, @Status
	END
	

END	
GO
/* 
=======================================================================
 END		[Config].[usp_LookupUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Config].[usp_LookupDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Config].[Lookup] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Config].[usp_LookupDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_LookupDelete] 
END 
GO
CREATE PROC [Config].[usp_LookupDelete] 
    @LookupCode nvarchar(25)
AS 
BEGIN 

	Delete [Config].[Lookup]
	
	WHERE  [LookupCode] = @LookupCode
END
GO
/* 
=======================================================================
 END		[Config].[usp_LookupDelete]
=======================================================================
*/

 

  