
/* 
=======================================================================
START		[Master].[usp_AddressSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Address] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_AddressSelect]') IS NOT NULL
BEGIN 
DROP PROC [Master].[usp_AddressSelect] 
END 
GO
CREATE PROC [Master].[usp_AddressSelect] 
@AddressId bigint
AS 
BEGIN 
SELECT	[AddressId], [AddressLinkID], [SeqNo], [AddressType], [Address1], [Address2], [Address3], [Address4], [CityName], 
	[StateName], [CountryCode], [ZipCode], [TelNo], [FaxNo], [MobileNo], [Contact], [Email], [WebSite], [IsBilling], [IsActive], 
	[CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] , [Master].[udf_FullAddress]([AddressLinkID]) As FullAddress
FROM	[Master].[Address] 
WHERE	[AddressId] = @AddressId  
END
GO

/* 
=======================================================================
END		[Master].[usp_AddressSelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_AddressList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[Address] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_AddressList]') IS NOT NULL
BEGIN 
DROP PROC [Master].[usp_AddressList] 
END 
GO
CREATE PROC [Master].[usp_AddressList] 
    
AS 
BEGIN 
SELECT	[AddressId], [AddressLinkID], [SeqNo], [AddressType], [Address1], [Address2], [Address3], [Address4], [CityName], 
	[StateName], [CountryCode], [ZipCode], [TelNo], [FaxNo], [MobileNo], [Contact], [Email], [WebSite], [IsBilling], [IsActive], 
	[CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] , [Master].[udf_FullAddress]([AddressLinkID]) As FullAddress
FROM	[Master].[Address] 
	 
END
GO
/* 
=======================================================================
END		[Master].[usp_AddressSelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_AddressInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[Address] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_AddressInsert]') IS NOT NULL
BEGIN 
DROP PROC [Master].[usp_AddressInsert] 
END 
GO
CREATE PROC [Master].[usp_AddressInsert] 
@AddressLinkID nvarchar(50),
@SeqNo smallint,
@AddressType varchar(50),
@Address1 nvarchar(100),
@Address2 nvarchar(100),
@Address3 varchar(50),
@Address4 varchar(50),
@CityName nvarchar(40),
@StateName nvarchar(40),
@CountryCode varchar(2),
@ZipCode varchar(6),
@TelNo varchar(20),
@FaxNo varchar(20),
@MobileNo varchar(20),
@Contact nvarchar(20),
@Email varchar(50),
@WebSite varchar(50),
@IsBilling bit,
@IsActive bit,
@CreatedBy varchar(25),
@ModifiedBy varchar(25)

AS 
BEGIN 
INSERT INTO [Master].[Address] (
	[AddressLinkID], [SeqNo], [AddressType], [Address1], [Address2], [Address3], [Address4], [CityName], [StateName], [CountryCode], [ZipCode], [TelNo], [FaxNo], [MobileNo], [Contact], [Email], [WebSite], [IsBilling], [IsActive], [CreatedBy], [CreatedOn] )
SELECT	@AddressLinkID, @SeqNo, @AddressType, @Address1, @Address2, @Address3, @Address4, @CityName, @StateName, @CountryCode, @ZipCode, @TelNo, @FaxNo, @MobileNo, @Contact, @Email, @WebSite, @IsBilling, @IsActive, @CreatedBy, Getdate()
END	
GO
/* 
=======================================================================
END		[Master].[usp_AddressInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_AddressUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[Address] 
Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_AddressUpdate]') IS NOT NULL
BEGIN 
DROP PROC [Master].[usp_AddressUpdate] 
END 
GO
CREATE PROC [Master].[usp_AddressUpdate] 
@AddressId int,
@AddressLinkID nvarchar(50),
@SeqNo smallint,
@AddressType varchar(50),
@Address1 nvarchar(100),
@Address2 nvarchar(100),
@Address3 varchar(50),
@Address4 varchar(50),
@CityName nvarchar(40),
@StateName nvarchar(40),
@CountryCode varchar(2),
@ZipCode varchar(6),
@TelNo varchar(20),
@FaxNo varchar(20),
@MobileNo varchar(20),
@Contact nvarchar(20),
@Email varchar(50),
@WebSite varchar(50),
@IsBilling bit,
@IsActive bit,
@CreatedBy varchar(25),
@ModifiedBy varchar(25)
AS 
BEGIN 

UPDATE [Master].[Address]
SET    --[SeqNo] = @SeqNo, 
[AddressType] = @AddressType, [Address1] = @Address1, [Address2] = @Address2, [Address3] = @Address3, [Address4] = @Address4, [CityName] = @CityName, [StateName] = @StateName, [CountryCode] = @CountryCode, [ZipCode] = @ZipCode, [TelNo] = @TelNo, [FaxNo] = @FaxNo, [MobileNo] = @MobileNo, [Contact] = @Contact, [Email] = @Email, [WebSite] = @WebSite, [IsBilling] = @IsBilling, [IsActive] = @IsActive,  [ModifiedBy] = @ModifiedBy, [ModifiedOn] = Getdate()

WHERE  AddressLinkId = @AddressLinkID
END	
GO
/* 
=======================================================================
END		[Master].[usp_AddressUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_AddressSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
	Into [Master].[Address] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_AddressSave]') IS NOT NULL
BEGIN 
DROP PROC [Master].[usp_AddressSave] 
END 
GO
CREATE PROC [Master].[usp_AddressSave] 
@AddressId int,
@AddressLinkID nvarchar(50),
@SeqNo smallint,
@AddressType varchar(50),
@Address1 nvarchar(100),
@Address2 nvarchar(100),
@Address3 varchar(50),
@Address4 varchar(50),
@CityName nvarchar(40),
@StateName nvarchar(40),
@CountryCode varchar(2),
@ZipCode varchar(6),
@TelNo varchar(20),
@FaxNo varchar(20),
@MobileNo varchar(20),
@Contact nvarchar(20),
@Email varchar(50),
@WebSite varchar(50),
@IsBilling bit,
@IsActive bit,
@CreatedBy varchar(25),
@ModifiedBy varchar(25)
AS 
BEGIN 

IF (SELECT COUNT(0) FROM [Master].[Address]
WHERE 	AddressLinkId = @AddressLinkID)>0
BEGIN	
print 'update'
EXEC [Master].[usp_AddressUpdate] @AddressId,@AddressLinkID, @SeqNo, @AddressType, @Address1, @Address2, @Address3, @Address4, @CityName, @StateName, @CountryCode, @ZipCode, @TelNo, @FaxNo, @MobileNo, @Contact, @Email, @WebSite, @IsBilling, @IsActive, @CreatedBy,  @ModifiedBy 
END
Else
BEGIN
print 'insert'
EXEC [Master].[usp_AddressInsert] @AddressLinkID, @SeqNo, @AddressType, @Address1, @Address2, @Address3, @Address4, @CityName, @StateName, @CountryCode, @ZipCode, @TelNo, @FaxNo, @MobileNo, @Contact, @Email, @WebSite, @IsBilling, @IsActive, @CreatedBy, @ModifiedBy 
END
	

END	
GO
/* 
=======================================================================
END		[Master].[usp_AddressUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_AddressDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[Address] 
	Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_AddressDelete]') IS NOT NULL
BEGIN 
DROP PROC [Master].[usp_AddressDelete] 
END 
GO
CREATE PROC [Master].[usp_AddressDelete] 
@AddressId bigint
AS 
BEGIN 

DELETE
FROM   [Master].[Address]
WHERE  [AddressId] = @AddressId
END
GO
/* 
=======================================================================
END		[Master].[usp_AddressDelete]
=======================================================================
*/




-- ========================================================================================================================================
-- START											 [Master].[usp_ContactListByCustomer]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 01-Dec-2011
-- Description:	Selects all the Contact Records from Contact table.

-- Example:		Exec [Master].[usp_ContactListByCustomer] 'VL','Company'
-- ========================================================================================================================================

IF OBJECT_ID('[Master].[usp_ContactListByCustomer]') IS NOT NULL
BEGIN 
DROP PROC [Master].[usp_ContactListByCustomer] 
END 
GO



CREATE PROCEDURE [Master].[usp_ContactListByCustomer] 
@AddressLinkID nvarchar(50),
@AddressType varchar(50)
 
AS
BEGIN

SELECT	[AddressId], [AddressLinkID], [SeqNo], [AddressType], [Address1], [Address2], [Address3], [Address4], [CityName], 
	[StateName], [CountryCode], [ZipCode], [TelNo], [FaxNo], [MobileNo], [Contact], [Email], [WebSite], [IsBilling], [IsActive], 
	[CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] , [Master].[udf_FullAddress]([AddressLinkID]) As FullAddress
FROM	[Master].[Address] 
WHERE [AddressLinkID] = @AddressLinkID AND [AddressType]=@AddressType

END

GO

-- ========================================================================================================================================
-- END  											 [Master].[usp_ContactListByCustomer]
-- ========================================================================================================================================

