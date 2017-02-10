
/* 
=======================================================================
 START		[Master].[usp_LocationSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-05
Description:	Select All Columns From [Master].[Location] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_LocationSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_LocationSelect] 
END 
GO
CREATE PROC [Master].[usp_LocationSelect] 
    @LocationCode nvarchar(50)
AS 
BEGIN 
	SELECT [LocationCode], [LocationDescription] 
	FROM   [Master].[Location] 
	WHERE  [LocationCode] = @LocationCode 
END
GO

/* 
=======================================================================
 END		[Master].[usp_LocationSelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_LocationList]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-05
Description:	List All Data From [Master].[Location] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_LocationList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_LocationList] 
END 
GO
CREATE PROC [Master].[usp_LocationList] 
     
AS 
BEGIN 
	SELECT [LocationCode], [LocationDescription] 
	FROM   [Master].[Location] 
	
END
GO
/* 
=======================================================================
 END		[Master].[usp_LocationSelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_LocationInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-05
Description:	Inserts New Record Into [Master].[Location] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_LocationInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_LocationInsert] 
END 
GO
CREATE PROC [Master].[usp_LocationInsert] 
    @LocationCode nvarchar(50),
    @LocationDescription nvarchar(255)
AS 
BEGIN 
	INSERT INTO [Master].[Location] ([LocationCode], [LocationDescription])
	SELECT @LocationCode, @LocationDescription
END	
GO
/* 
=======================================================================
 END		[Master].[usp_LocationInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_LocationUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-05
Description:	Updates Existing Record Into [Master].[Location] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_LocationUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_LocationUpdate] 
END 
GO
CREATE PROC [Master].[usp_LocationUpdate] 
    @LocationCode nvarchar(50),
    @LocationDescription nvarchar(255)
AS 
BEGIN 

	UPDATE [Master].[Location]
	SET    [LocationCode] = @LocationCode, [LocationDescription] = @LocationDescription
	WHERE  [LocationCode] = @LocationCode
END	
GO
/* 
=======================================================================
 END		[Master].[usp_LocationUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_LocationSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-05
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[Location] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_LocationSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_LocationSave] 
END 
GO
CREATE PROC [Master].[usp_LocationSave] 
    @LocationCode nvarchar(50),
    @LocationDescription nvarchar(255)
AS 
BEGIN 
Declare @dt DateTime,
	 @DocID varchar(50)
/*
Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @OrderNo OUTPUT
*/


	IF (SELECT COUNT(0) FROM [Master].[Location]
		WHERE 	[LocationCode] = @LocationCode)>0
	BEGIN	
		EXEC [Master].[usp_LocationUpdate] @LocationCode, @LocationDescription
	END
	Else
	BEGIN
	    EXEC [Master].[usp_LocationInsert] @LocationCode, @LocationDescription
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_LocationUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_LocationDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-05
Description:	Deletes Existing Record Into [Master].[Location] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_LocationDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_LocationDelete] 
END 
GO
CREATE PROC [Master].[usp_LocationDelete] 
    @LocationCode nvarchar(50)
AS 
BEGIN 

	DELETE
	FROM   [Master].[Location]
	WHERE  [LocationCode] = @LocationCode
END
GO
/* 
=======================================================================
 END		[Master].[usp_LocationDelete]
=======================================================================
*/

