
-- ========================================================================================================================================
-- START											 [Security].[usp_UsersSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Select the [Users] Record based on [Users] table
-- ========================================================================================================================================


IF OBJECT_ID('[Security].[usp_UsersSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UsersSelect] 
END 
GO
CREATE PROC [Security].[usp_UsersSelect] 
    @UserID VARCHAR(25)
AS 
 

BEGIN

	SELECT	[UserID], [UserName], [Password], [IsActive], [Email], [MobileNumber], [LogInStatus], [LastLogInOn], 
			[RoleCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM	[Security].[Users] WITH (NOLOCK)
	WHERE  [UserID] = @UserID  

END
-- ========================================================================================================================================
-- END  											 [Security].[usp_UsersSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Security].[usp_UsersList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Select all the [Users] Records from [Users] table
-- ========================================================================================================================================


IF OBJECT_ID('[Security].[usp_UsersList]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UsersList] 
END 
GO
CREATE PROC [Security].[usp_UsersList] 

AS 
 
BEGIN
	SELECT	[UserID], [UserName], [Password], [IsActive], [Email], [MobileNumber], [LogInStatus], [LastLogInOn], 
			[RoleCode], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM	[Security].[Users] WITH (NOLOCK)

END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UsersList] 
-- ========================================================================================================================================

GO





-- ========================================================================================================================================
-- START											 [Security].[usp_UsersInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Inserts the [Users] Record Into [Users] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UsersInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UsersInsert] 
END 
GO
CREATE PROC [Security].[usp_UsersInsert] 
    @UserID varchar(25),
    @UserName varchar(100),
    @Password varchar(15),
    @IsActive bit,
    @Email varchar(100),
    @MobileNumber varchar(10),
    @LogInStatus bit,
    @RoleCode varchar(20),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
  

BEGIN
	
	INSERT INTO [Security].[Users] (
			[UserID], [UserName], [Password], [IsActive], [Email], [MobileNumber], [LogInStatus], [RoleCode], [CreatedBy], [CreatedOn] )
	SELECT	@UserID, @UserName, @Password, @IsActive, @Email, @MobileNumber, @LogInStatus, @RoleCode, @CreatedBy, GETDATE()
	
               
END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UsersInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Security].[usp_UsersUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	updates the [Users] Record Into [Users] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UsersUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UsersUpdate] 
END 
GO
CREATE PROC [Security].[usp_UsersUpdate] 
    @UserID varchar(25),
    @UserName varchar(100),
    @Password varchar(15),
    @IsActive bit,
    @Email varchar(100),
    @MobileNumber varchar(10),
    @LogInStatus bit,
    @RoleCode varchar(20),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
BEGIN

	UPDATE	[Security].[Users]
	SET		[UserName] = @UserName, [Password] = @Password, [IsActive] = @IsActive, [Email] = @Email, 
			[MobileNumber] = @MobileNumber, [LogInStatus] = @LogInStatus, 
			[RoleCode] = @RoleCode, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE	[UserID] = @UserID
	

END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UsersUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Security].[usp_UsersSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Either INSERT or UPDATE the [Users] Record Into [Users] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UsersSave]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UsersSave] 
END 
GO
CREATE PROC [Security].[usp_UsersSave] 
    @UserID varchar(25),
    @UserName varchar(100),
    @Password varchar(15),
    @IsActive bit,
    @Email varchar(100),
    @MobileNumber varchar(10),
    @LogInStatus bit,
    @RoleCode varchar(20),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Security].[Users] 
		WHERE 	[UserID] = @UserID)>0
	BEGIN
	    Exec [Security].[usp_UsersUpdate] 
		@UserID, @UserName, @Password, @IsActive, @Email, @MobileNumber, @LogInStatus, @RoleCode, @CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Security].[usp_UsersInsert] 
		@UserID, @UserName, @Password, @IsActive, @Email, @MobileNumber, @LogInStatus, @RoleCode, @CreatedBy, @ModifiedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Security].usp_[UsersSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Security].[usp_UsersDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	10-AUG-2015
-- Description:	Deletes the [Users] Record  based on [Users]

-- ========================================================================================================================================

IF OBJECT_ID('[Security].[usp_UsersDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Security].[usp_UsersDelete] 
END 
GO
CREATE PROC [Security].[usp_UsersDelete] 
    @UserID varchar(25)
AS 

	
BEGIN

	UPDATE	[Security].[Users]
	SET	[IsActive] = CAST(0 as bit)
	WHERE 	[UserID] = @UserID


END

-- ========================================================================================================================================
-- END  											 [Security].[usp_UsersDelete]
-- ========================================================================================================================================

GO


