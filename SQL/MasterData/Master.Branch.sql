/* 
=======================================================================
 START		[Master].[usp_BranchSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Branch] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_BranchSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_BranchSelect] 
END 
GO
CREATE PROC [Master].[usp_BranchSelect] 
    @BranchCode varchar(10)
AS 
BEGIN 
	SELECT [BranchID], [BranchCode], [BranchName], [RegNo], [IsActive], [CompanyCode], [AddressID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[Branch] 
	WHERE  [BranchCode] = @BranchCode  
END
GO

/* 
=======================================================================
 END		[Master].[usp_BranchSelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_BranchList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[Branch] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_BranchList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_BranchList] 
END 
GO
CREATE PROC [Master].[usp_BranchList] 

AS 
BEGIN 
	SELECT [BranchID], [BranchCode], [BranchName], [RegNo], [IsActive], [CompanyCode], [AddressID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[Branch] 
	Order By BranchID Desc
 
END
GO
/* 
=======================================================================
 END		[Master].[usp_BranchSelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_BranchInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[Branch] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_BranchInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_BranchInsert] 
END 
GO
CREATE PROC [Master].[usp_BranchInsert] 
    @BranchID smallint,
	@BranchCode varchar(10),
    @BranchName varchar(255),
    @RegNo varchar(20),
    @IsActive bit,
    @CompanyCode varchar(10),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
BEGIN 
	INSERT INTO [Master].[Branch] (
			[BranchCode], [BranchName], [RegNo], [IsActive], [CompanyCode],[CreatedBy], [CreatedOn] )
	SELECT	@BranchCode, @BranchName, @RegNo, @IsActive, @CompanyCode, @CreatedBy, Getdate()
END	
GO
/* 
=======================================================================
 END		[Master].[usp_BranchInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_BranchUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[Branch] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_BranchUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_BranchUpdate] 
END 
GO
CREATE PROC [Master].[usp_BranchUpdate] 
    @BranchID smallint,
    @BranchCode varchar(10),
    @BranchName varchar(255),
    @RegNo varchar(20),
    @IsActive bit,
    @CompanyCode varchar(10),
     
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
BEGIN 

	UPDATE [Master].[Branch]
	SET    [BranchCode] = @BranchCode, [BranchName] = @BranchName, [RegNo] = @RegNo, [IsActive] = @IsActive, [CompanyCode] = @CompanyCode, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = Getdate()
	WHERE  [BranchID] = @BranchID
END	
GO
/* 
=======================================================================
 END		[Master].[usp_BranchUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_BranchSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[Branch] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_BranchSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_BranchSave] 
END 
GO
CREATE PROC [Master].[usp_BranchSave] 
    @BranchID smallint,
    @BranchCode varchar(10),
    @BranchName varchar(255),
    @RegNo varchar(20),
    @IsActive bit,
    @CompanyCode varchar(10),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
BEGIN 


	IF (SELECT COUNT(0) FROM [Master].[Branch]
		WHERE 	[BranchID] = @BranchID)>0
	BEGIN	
		EXEC [Master].[usp_BranchUpdate] @BranchID,@BranchCode, @BranchName, @RegNo, @IsActive, @CompanyCode, @CreatedBy,  @ModifiedBy 
	END
	Else
	BEGIN
	    EXEC [Master].[usp_BranchInsert] @BranchID,@BranchCode, @BranchName, @RegNo, @IsActive, @CompanyCode, @CreatedBy,  @ModifiedBy 
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_BranchUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_BranchDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[Branch] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_BranchDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_BranchDelete] 
END 
GO
CREATE PROC [Master].[usp_BranchDelete] 
    @BranchID smallint
AS 
BEGIN 

	DELETE
	FROM   [Master].[Branch]
	WHERE  [BranchID] = @BranchID
END
GO
/* 
=======================================================================
 END		[Master].[usp_BranchDelete]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_BranchListByCompany]
=======================================================================
Author:		Sudarshan
Create date:	2015-04-05
Description:	List All Data From [Master].[Branch] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_BranchListByCompany]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_BranchListByCompany] 
END 
GO
CREATE PROC [Master].[usp_BranchListByCompany] 
    @CompanyCode varchar(10)
AS 
BEGIN 
	SELECT [BranchID], [BranchCode], [BranchName], [RegNo], [IsActive], [CompanyCode], [AddressID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[Branch] 
	WHERE  [CompanyCode] = @CompanyCode 
	Order By BranchID Desc
END
GO
/* 
=======================================================================
 END		[Master].[usp_BranchListByCompany]
=======================================================================
*/

