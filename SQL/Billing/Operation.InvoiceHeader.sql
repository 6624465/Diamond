

/* 
=======================================================================
 START		[Operation].[usp_InvoiceHeaderSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[InvoiceHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderSelect] 
    @InvoiceNo varchar(50)
AS 
BEGIN 
	SELECT [InvoiceNo], [InvoiceDate], [CustomerCode], [InvoiceType], [InvoiceAmount], [TaxAmount], [TotalAmount], [PendingPayment], [PaymentDate], [DueDate], [Status],[IsApproved], [ApprovedBy], [ApprovedOn], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[InvoiceHeader] 
	WHERE  [InvoiceNo] = @InvoiceNo 
END
GO

/* 
=======================================================================
 END		[Operation].[usp_InvoiceHeaderSelect]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_InvoiceHeaderList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Operation].[InvoiceHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderList] 
    
AS 
BEGIN 
	SELECT [InvoiceNo], [InvoiceDate], [CustomerCode], [InvoiceType], [InvoiceAmount], [TaxAmount], [TotalAmount], [PendingPayment], [PaymentDate], [DueDate], [Status],[IsApproved], [ApprovedBy], [ApprovedOn], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[InvoiceHeader] 
	 
END
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceHeaderSelect]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_InvoiceHeaderInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Operation].[InvoiceHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderInsert] 
    @InvoiceNo varchar(50),
    @InvoiceDate datetime,
    @CustomerCode varchar(50),
    @InvoiceType varchar(50),
    @InvoiceAmount decimal(18, 4),
    @TaxAmount decimal(18, 4),
    @TotalAmount decimal(18, 4),
    @PendingPayment bit,
    @PaymentDate datetime = NULL,
    @DueDate datetime = NULL,
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewInvoiceNo varchar(25) OUTPUT 
AS 
BEGIN 
	INSERT INTO [Operation].[InvoiceHeader] (
			[InvoiceNo], [InvoiceDate], [CustomerCode], [InvoiceType], [InvoiceAmount], [TaxAmount], [TotalAmount], [PendingPayment], [PaymentDate], 
			[DueDate], [Status], [CreatedBy], [CreatedOn] )
	SELECT	@InvoiceNo, @InvoiceDate, @CustomerCode, @InvoiceType, @InvoiceAmount, @TaxAmount, @TotalAmount, @PendingPayment, @PaymentDate, 
			@DueDate, @Status, @CreatedBy, GetDate()

	Select @NewInvoiceNo = @InvoiceNo

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceHeaderInsert]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_InvoiceHeaderUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Operation].[InvoiceHeader] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderUpdate] 
    @InvoiceNo varchar(50),
    @InvoiceDate datetime,
    @CustomerCode varchar(50),
    @InvoiceType varchar(50),
    @InvoiceAmount decimal(18, 4),
    @TaxAmount decimal(18, 4),
    @TotalAmount decimal(18, 4),
    @PendingPayment bit,
    @PaymentDate datetime = NULL,
    @DueDate datetime = NULL,
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewInvoiceNo varchar(25) OUTPUT
AS 
BEGIN 

	UPDATE	[Operation].[InvoiceHeader]
	SET		[InvoiceDate] = @InvoiceDate, [CustomerCode] = @CustomerCode, [InvoiceType] = @InvoiceType, [InvoiceAmount] = @InvoiceAmount, [TaxAmount] = @TaxAmount, 
			[TotalAmount] = @TotalAmount, [PendingPayment] = @PendingPayment, [PaymentDate] = @PaymentDate, [DueDate] = @DueDate, [Status] = @Status, 
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = getdate()
	WHERE	[InvoiceNo] = @InvoiceNo

	select @NewInvoiceNo= @InvoiceNo

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceHeaderUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_InvoiceHeaderSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Operation].[InvoiceHeader] Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderSave] 
    @InvoiceNo varchar(50),
    @InvoiceDate datetime,
    @CustomerCode varchar(50),
    @InvoiceType varchar(50),
    @InvoiceAmount decimal(18, 4),
    @TaxAmount decimal(18, 4),
    @TotalAmount decimal(18, 4),
    @PendingPayment bit,
    @PaymentDate datetime = NULL,
    @DueDate datetime = NULL,
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewInvoiceNo varchar(25) OUTPUT 
AS 
BEGIN 
Declare @dt DateTime,
	 @DocID varchar(50)
/*
Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @OrderNo OUTPUT
*/


	IF (SELECT COUNT(0) FROM [Operation].[InvoiceHeader]
		WHERE 	[InvoiceNo] = @InvoiceNo)>0
	BEGIN	
		EXEC [Operation].[usp_InvoiceHeaderUpdate] @InvoiceNo, @InvoiceDate, @CustomerCode, @InvoiceType, @InvoiceAmount, @TaxAmount, @TotalAmount, @PendingPayment, 
				@PaymentDate, @DueDate, @Status,@CreatedBy,  @ModifiedBy,@NewInvoiceNo= @NewInvoiceNo OUTPUT 
	END
	Else
	BEGIN

		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 'Invoice', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()

		IF LEN(@InvoiceNo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] 'Invoice', @Dt ,@CreatedBy, @InvoiceNo OUTPUT

	    EXEC [Operation].[usp_InvoiceHeaderInsert] @InvoiceNo, @InvoiceDate, @CustomerCode, @InvoiceType, @InvoiceAmount, @TaxAmount, @TotalAmount, @PendingPayment, 
				@PaymentDate, @DueDate, @Status,@CreatedBy,  @ModifiedBy,@NewInvoiceNo= @NewInvoiceNo OUTPUT
	END
	

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceHeaderUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_InvoiceHeaderDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Operation].[InvoiceHeader] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Operation].[usp_InvoiceHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceHeaderDelete] 
    @InvoiceNo varchar(50)
AS 
BEGIN 

	DELETE
	FROM   [Operation].[InvoiceHeader]
	WHERE  [InvoiceNo] = @InvoiceNo
END
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceHeaderDelete]
=======================================================================
*/
 