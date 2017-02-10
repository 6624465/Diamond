
/* 
=======================================================================
 START		[Master].[usp_CurrencySelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Currency] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CurrencySelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CurrencySelect] 
END 
GO
CREATE PROC [Master].[usp_CurrencySelect] 
    @CurrencyCode varchar(3)
AS 
BEGIN 
	SELECT [CurrencyCode], [Description], [Description1] 
	FROM   [Master].[Currency] 
	WHERE  [CurrencyCode] = @CurrencyCode  
END
GO

/* 
=======================================================================
 END		[Master].[usp_CurrencySelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CurrencyList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[Currency] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CurrencyList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CurrencyList] 
END 
GO
CREATE PROC [Master].[usp_CurrencyList] 
    
AS 
BEGIN 
	SELECT [CurrencyCode], [Description], [Description1] 
	FROM   [Master].[Currency] 
	 
END
GO
/* 
=======================================================================
 END		[Master].[usp_CurrencySelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_CurrencyInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[Currency] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CurrencyInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CurrencyInsert] 
END 
GO
CREATE PROC [Master].[usp_CurrencyInsert] 
    @CurrencyCode varchar(3),
    @Description nvarchar(255),
    @Description1 nvarchar(255)
AS 
BEGIN 
	INSERT INTO [Master].[Currency] ([CurrencyCode], [Description], [Description1])
	SELECT @CurrencyCode, @Description, @Description1
END	
GO
/* 
=======================================================================
 END		[Master].[usp_CurrencyInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_CurrencyUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[Currency] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CurrencyUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CurrencyUpdate] 
END 
GO
CREATE PROC [Master].[usp_CurrencyUpdate] 
    @CurrencyCode varchar(3),
    @Description nvarchar(255),
    @Description1 nvarchar(255)
AS 
BEGIN 

	UPDATE [Master].[Currency]
	SET    [CurrencyCode] = @CurrencyCode, [Description] = @Description, [Description1] = @Description1
	WHERE  [CurrencyCode] = @CurrencyCode
END	
GO
/* 
=======================================================================
 END		[Master].[usp_CurrencyUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CurrencySave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[Currency] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CurrencySave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CurrencySave] 
END 
GO
CREATE PROC [Master].[usp_CurrencySave] 
    @CurrencyCode varchar(3),
    @Description nvarchar(255),
    @Description1 nvarchar(255)
AS 
BEGIN 
 
	IF (SELECT COUNT(0) FROM [Master].[Currency]
		WHERE 	[CurrencyCode] = @CurrencyCode)>0
	BEGIN	
		EXEC [Master].[usp_CurrencyUpdate] @CurrencyCode, @Description, @Description1
	END
	Else
	BEGIN
	    EXEC [Master].[usp_CurrencyInsert] @CurrencyCode, @Description, @Description1
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_CurrencyUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_CurrencyDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[Currency] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_CurrencyDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CurrencyDelete] 
END 
GO
CREATE PROC [Master].[usp_CurrencyDelete] 
    @CurrencyCode varchar(3)
AS 
BEGIN 

	DELETE
	FROM   [Master].[Currency]
	WHERE  [CurrencyCode] = @CurrencyCode
END
GO
/* 
=======================================================================
 END		[Master].[usp_CurrencyDelete]
=======================================================================
*/
 