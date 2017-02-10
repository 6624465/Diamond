

-- ========================================================================================================================================
-- START											 [Config].[usp_SystemWideConfigurationSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [SystemWideConfiguration] Record based on [SystemWideConfiguration] table
-- ========================================================================================================================================


IF OBJECT_ID('[Config].[usp_SystemWideConfigurationSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_SystemWideConfigurationSelect] 
END 
GO
CREATE PROC [Config].[usp_SystemWideConfigurationSelect] 
    @DisplayName VARCHAR(100)
AS 
 

BEGIN

	SELECT [DisplayName], [ConfigurationValue], [ModifiedBy], [ModifiedOn] 
	FROM   [Config].[SystemWideConfiguration] WITH (NOLOCK)
	WHERE  [DisplayName] = @DisplayName 

END
-- ========================================================================================================================================
-- END  											 [Config].[usp_SystemWideConfigurationSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Config].[usp_SystemWideConfigurationList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [SystemWideConfiguration] Records from [SystemWideConfiguration] table
-- ========================================================================================================================================


IF OBJECT_ID('[Config].[usp_SystemWideConfigurationList]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_SystemWideConfigurationList] 
END 
GO
CREATE PROC [Config].[usp_SystemWideConfigurationList] 

AS 
 
BEGIN
	SELECT [DisplayName], [ConfigurationValue], [ModifiedBy], [ModifiedOn] 
	FROM   [Config].[SystemWideConfiguration] WITH (NOLOCK)

END

-- ========================================================================================================================================
-- END  											 [Config].[usp_SystemWideConfigurationList] 
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Config].[usp_SystemWideConfigurationInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [SystemWideConfiguration] Record Into [SystemWideConfiguration] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Config].[usp_SystemWideConfigurationInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_SystemWideConfigurationInsert] 
END 
GO
CREATE PROC [Config].[usp_SystemWideConfigurationInsert] 
    @DisplayName varchar(100),
    @ConfigurationValue nvarchar(100),
    @ModifiedBy varchar(25) 
AS 
  

BEGIN
	
	INSERT INTO [Config].[SystemWideConfiguration] ([DisplayName], [ConfigurationValue], [ModifiedBy], [ModifiedOn])
	SELECT @DisplayName, @ConfigurationValue, @ModifiedBy,GETDATE() 
	
               
END

-- ========================================================================================================================================
-- END  											 [Config].[usp_SystemWideConfigurationInsert]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Config].[usp_SystemWideConfigurationUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [SystemWideConfiguration] Record Into [SystemWideConfiguration] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Config].[usp_SystemWideConfigurationUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_SystemWideConfigurationUpdate] 
END 
GO
CREATE PROC [Config].[usp_SystemWideConfigurationUpdate] 
    @DisplayName varchar(100),
    @ConfigurationValue nvarchar(100),
    @ModifiedBy varchar(25) 
AS 
 
	
BEGIN

	UPDATE [Config].[SystemWideConfiguration]
	SET    [DisplayName] = @DisplayName, [ConfigurationValue] = @ConfigurationValue, [ModifiedBy] = @ModifiedBy ,[ModifiedOn]=GETDATE()
	WHERE  [DisplayName] = @DisplayName
	

END

-- ========================================================================================================================================
-- END  											 [Config].[usp_SystemWideConfigurationUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Config].[usp_SystemWideConfigurationDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [SystemWideConfiguration] Record  based on [SystemWideConfiguration]

-- ========================================================================================================================================

IF OBJECT_ID('[Config].[usp_SystemWideConfigurationDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_SystemWideConfigurationDelete] 
END 
GO
CREATE PROC [Config].[usp_SystemWideConfigurationDelete] 
    @DisplayName varchar(100)
AS 

	
BEGIN


	DELETE
	FROM   [Config].[SystemWideConfiguration]
	WHERE  [DisplayName] = @DisplayName
END

-- ========================================================================================================================================
-- END  											 [Config].[usp_SystemWideConfigurationDelete]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Config].[usp_SystemWideConfigurationSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [SystemWideConfiguration] Record Into [SystemWideConfiguration] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Config].[usp_SystemWideConfigurationSave]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_SystemWideConfigurationSave] 
END 
GO
CREATE PROC [Config].[usp_SystemWideConfigurationSave] 
    @DisplayName varchar(100),
    @ConfigurationValue nvarchar(100),
    @ModifiedBy varchar(25) 
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Config].[SystemWideConfiguration] 
		WHERE 	[DisplayName] = @DisplayName)>0
	BEGIN
	    Exec [Config].[usp_SystemWideConfigurationUpdate] 
		@DisplayName, @ConfigurationValue, @ModifiedBy


	END
	ELSE
	BEGIN
	    Exec [Config].[usp_SystemWideConfigurationInsert] 
		@DisplayName, @ConfigurationValue, @ModifiedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Config].usp_[SystemWideConfigurationSave]
-- ========================================================================================================================================

GO



 

-- ========================================================================================================================================
-- START											 [Config].[usp_GetApplicationVersion]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [SystemWideConfiguration] Record based on [SystemWideConfiguration] table
-- ========================================================================================================================================


IF OBJECT_ID('[Config].[usp_GetApplicationVersion]') IS NOT NULL
BEGIN 
    DROP PROC [Config].[usp_GetApplicationVersion] 
END 
GO
CREATE PROC [Config].[usp_GetApplicationVersion] 
    @DisplayName VARCHAR(100)
AS 
 

BEGIN

	SELECT [ConfigurationValue]
	FROM   [Config].[SystemWideConfiguration] WITH (NOLOCK)
	WHERE  [DisplayName] = @DisplayName 

END
-- ========================================================================================================================================
-- END  											 [Config].[usp_GetApplicationVersion]
-- ========================================================================================================================================

GO