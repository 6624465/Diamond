
/* 
=======================================================================
 START		[Master].[usp_CustomerSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Customer] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerSelect] 
END 
GO
CREATE PROC [Master].[usp_CustomerSelect] 
    @CustomerCode nvarchar(25)
AS 
BEGIN 
	SELECT [CustomerCode], [CustomerName], [RegistrationNo], [CustomerType], [Status], [Remark], [CreditTerm],[CustomerMode], [AddressID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[Customer] 
	WHERE  [CustomerCode] = @CustomerCode  
END
GO

/* 
=======================================================================
 END		[Master].[usp_CustomerSelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CustomerList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[Customer] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerList] 
END 
GO
CREATE PROC [Master].[usp_CustomerList] 
    
AS 
BEGIN 
	SELECT [CustomerCode], [CustomerName], [RegistrationNo], [CustomerType], [Status], [Remark], [CreditTerm],[CustomerMode], [AddressID], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Master].[Customer] 
	Order By CustomerName
	 
END
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerSelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_CustomerInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[Customer] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerInsert] 
END 
GO
CREATE PROC [Master].[usp_CustomerInsert] 
    @CustomerCode nvarchar(25),
    @CustomerName nvarchar(255),
    @RegistrationNo nvarchar(100),
    @CustomerType varchar(50),
    @Status bit,
    @Remark nvarchar(100),
    @CreditTerm smallint,
	@CustomerMode varchar(25),
    @AddressID varchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@NewCustomerCode nvarchar(25) OUTPUT
AS 
BEGIN 
	INSERT INTO [Master].[Customer] (
			[CustomerCode], [CustomerName], [RegistrationNo], [CustomerType], [Status], [Remark], [CreditTerm],CustomerMode, [AddressID], [CreatedBy], [CreatedOn] )
	SELECT	@CustomerCode, @CustomerName, @RegistrationNo, @CustomerType, @Status, @Remark, @CreditTerm,@CustomerMode, @AddressID, @CreatedBy, Getdate()

	Select @NewCustomerCode = @CustomerCode

END	
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_CustomerUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[Customer] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerUpdate] 
END 
GO
CREATE PROC [Master].[usp_CustomerUpdate] 
    @CustomerCode nvarchar(25),
    @CustomerName nvarchar(255),
    @RegistrationNo nvarchar(100),
    @CustomerType varchar(50),
    @Status bit,
    @Remark nvarchar(100),
    @CreditTerm smallint,
	@CustomerMode varchar(25),
    @AddressID varchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@NewCustomerCode nvarchar(25) OUTPUT
AS 
BEGIN 

	UPDATE [Master].[Customer]
	SET    [CustomerName] = @CustomerName, [RegistrationNo] = @RegistrationNo, [CustomerType] = @CustomerType, 
			[Status] = @Status, [Remark] = @Remark, [CreditTerm] = @CreditTerm, CustomerMode = @CustomerMode, [AddressID] = @AddressID, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETUTCDATE()
	WHERE  ([CustomerCode] = @CustomerCode OR [CustomerName]=@CustomerName)

	Select @NewCustomerCode = @CustomerCode

END	
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CustomerSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[Customer] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerSave] 
END 
GO
CREATE PROC [Master].[usp_CustomerSave] 
    @CustomerCode nvarchar(25),
    @CustomerName nvarchar(255),
    @RegistrationNo nvarchar(100),
    @CustomerType varchar(50),
    @Status bit,
    @Remark nvarchar(100),
    @CreditTerm smallint,
	@CustomerMode varchar(25),
    @AddressID varchar(50),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@NewCustomerCode nvarchar(25) OUTPUT
AS 
BEGIN 



	IF (SELECT COUNT(0) FROM [Master].[Customer]
		WHERE 	([CustomerCode] = @CustomerCode or [CustomerName] = @CustomerName))>0
	BEGIN	
		EXEC [Master].[usp_CustomerUpdate] 
				@CustomerCode, @CustomerName, @RegistrationNo, @CustomerType, @Status, @Remark, @CreditTerm,@CustomerMode, 
				@AddressID, @CreatedBy,  @ModifiedBy ,@NewCustomerCode = @NewCustomerCode OUTPUT
	END
	Else
	BEGIN

		--If @CustomerType = 'SUPPLIER'
		--Begin

			Declare @PrefixCount int =0

			Select @PrefixCount= COUNT(0) From Master.Customer
			Where LEFT(CustomerName,1) = LEFT(@CustomerName,1)
			
			Set @CustomerCode = LEFT(@CustomerName,1) + '-' + [Utility].[udf_PADL](Convert(char(3),@PrefixCount+1),3,'0')


		--End


	    EXEC [Master].[usp_CustomerInsert] 
			@CustomerCode, @CustomerName, @RegistrationNo, @CustomerType, @Status, @Remark, @CreditTerm,@CustomerMode, 
				@AddressID, @CreatedBy,  @ModifiedBy ,@NewCustomerCode = @NewCustomerCode OUTPUT
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CustomerDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[Customer] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_CustomerDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerDelete] 
END 
GO
CREATE PROC [Master].[usp_CustomerDelete] 
    @CustomerCode nvarchar(25),
	@ModifiedBy varchar(25)
AS 
BEGIN 

	--DELETE
	--FROM   [Master].[Customer]
	--WHERE  [CustomerCode] = @CustomerCode

	IF(Select Status From Master.Customer Where CustomerCode = @CustomerCode)=CAST(1 as bit)
	Begin

		If(Select COUNT(0) From Operation.stockinheader Where CustomerCode =@CustomerCode)>0

		Update Master.Customer
		Set Status=CAST(0 As bit),ModifiedBy = @ModifiedBy , ModifiedOn = GETDATE()
		where [CustomerCode] = @CustomerCode

		Else
			Delete From master.Customer
			Where CustomerCode = @CustomerCode

	End
	Else
		Return 1;

END
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerDelete]
=======================================================================
*/

 