

/* 
=======================================================================
 START		[Operation].[usp_OrderHeaderSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[OrderHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_OrderHeaderSelect] 
    @OrderNo varchar(50)
AS 
BEGIN 
	SELECT [OrderNo], [OrderDate],BranchID, Hd.[CustomerCode], [SaleType], Hd.[Status], [IsApproved], IsPayLater,PaymentDays,
			TotalAmount,IsVAT,VATAmount,IsWHTax,WHTaxPercent,WithHoldingAmount,NetAmount,PaidAmount,IsRequireDelivery,DeliveryDate,
			Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn] ,COALESCE(Hd.CustomerName,Cus.CustomerName) As CustomerName,
			0 As BalanceAmount,0 As DiscountAmount,Hd.RegNo,Hd.CustomerAddress,Hd.PaymentType,Hd.IsRequireDelivery,Hd.Remarks
	FROM   [Operation].[OrderHeader] Hd
	Left Outer Join Master.Customer Cus ON
		Hd.CustomerCode = Cus.CustomerCode
	WHERE  [OrderNo] = @OrderNo  
END
GO

/* 
=======================================================================
 END		[Operation].[usp_OrderHeaderSelect]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_OrderHeaderList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Operation].[OrderHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_OrderHeaderList] 
    
AS 
BEGIN 
	SELECT [OrderNo], [OrderDate],BranchID, Hd.[CustomerCode], [SaleType], Hd.[Status], [IsApproved], IsPayLater,PaymentDays,
			TotalAmount,IsVAT,VATAmount,IsWHTax,WHTaxPercent,WithHoldingAmount,NetAmount,PaidAmount,IsRequireDelivery,DeliveryDate,
			Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn] ,COALESCE(Hd.CustomerName,Cus.CustomerName) As CustomerName,
			0 As BalanceAmount,0 As DiscountAmount,Hd.RegNo,Hd.CustomerAddress,Hd.PaymentType,Hd.IsRequireDelivery,Hd.Remarks
	FROM   [Operation].[OrderHeader] Hd
	Left Outer Join Master.Customer Cus ON
		Hd.CustomerCode = Cus.CustomerCode
	 
END
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderHeaderSelect]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_OrderHeaderInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Operation].[OrderHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_OrderHeaderInsert] 
    @OrderNo varchar(50),
    @OrderDate datetime,
    @BranchID smallint,
    @CustomerCode nvarchar(50),
	@CustomerName nvarchar(255),
	@RegNo varchar(50),
	@CustomerAddress nvarchar(2000),
    @SaleType varchar(50),
    @Status bit,
    @IsApproved bit,
	@IsPayLater bit,
	@PaymentDays int,
	@TotalAmount decimal(18,2),
	@IsVAT bit,
	@VATAmount decimal(18,2),
	@ISWHTax bit,
	@WHTaxPercent decimal(18,2),
	@WithHoldingAmount decimal(18,2),
	@NetAmount decimal(18,2),
	@PaidAmount decimal(18,2),
	@PaymentType varchar(50),
	@IsRequiredDelivery bit,
	@DeliveryDate datetime,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
	@Remarks nvarchar(255),
    @NewOrderNo varchar(25) OUTPUT 
AS 
BEGIN 
	INSERT INTO [Operation].[OrderHeader] (
			[OrderNo], [OrderDate],BranchID, [CustomerCode],CustomerName,RegNo,CustomerAddress, [SaleType], [Status], [IsApproved],IsPayLater, PaymentDays,
			TotalAmount,IsVAT,VATAmount,IsWHTax,WHTaxPercent,WithHoldingAmount,NetAmount,PaidAmount,
			PaymentType,IsRequireDelivery,DeliveryDate,[CreatedBy], [CreatedOn],Remarks )
	SELECT	@OrderNo, @OrderDate,@BranchID, @CustomerCode,@CustomerName,@RegNo,@CustomerAddress, @SaleType, @Status, @IsApproved,@IsPayLater, @PaymentDays,
			@TotalAmount,@IsVAT,@VATAmount,@IsWHTax,@WHTaxPercent,@WithHoldingAmount,@NetAmount,@PaidAmount,
			@PaymentType,@IsRequiredDelivery,@DeliveryDate,@CreatedBy, GETDATE(),@Remarks


	SELECT @NewOrderNo = @OrderNo

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderHeaderInsert]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_OrderHeaderUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Operation].[OrderHeader] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_OrderHeaderUpdate] 
    @OrderNo varchar(50),
    @OrderDate datetime,
    @BranchID smallint,
    @CustomerCode nvarchar(50),
	@CustomerName nvarchar(255),
	@RegNo varchar(50),
	@CustomerAddress nvarchar(2000),
    @SaleType varchar(50),
    @Status bit,
    @IsApproved bit,
	@IsPayLater bit,
	@PaymentDays int,
	@TotalAmount decimal(18,2),
	@IsVAT bit,
	@VATAmount decimal(18,2),
	@ISWHTax bit,
	@WHTaxPercent decimal(18,2),
	@WithHoldingAmount decimal(18,2),
	@NetAmount decimal(18,2),
	@PaidAmount decimal(18,2),
	@PaymentType varchar(50),
	@IsRequiredDelivery bit,
	@DeliveryDate datetime,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)   ,
	@Remarks nvarchar(255),
    @NewOrderNo varchar(25) OUTPUT
AS 
BEGIN 

	UPDATE  [Operation].[OrderHeader]
	SET     [OrderDate] = @OrderDate, [CustomerCode] = @CustomerCode,CustomerName=@CustomerName,RegNo=@RegNo,CustomerAddress=@CustomerAddress, 
			[SaleType] = @SaleType, [Status] = @Status, 
			[IsApproved] = @IsApproved, IsPayLater= @IsPayLater, PaymentDays =@PaymentDays, 	TotalAmount =@TotalAmount ,	PaidAmount =@PaidAmount ,
			PaymentType = @PaymentType,IsRequireDelivery = @IsRequiredDelivery,DeliveryDate = @DeliveryDate,
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = getdate()
	WHERE   [OrderNo] = @OrderNo

	SELECT @NewOrderNo = @OrderNo

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderHeaderUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_OrderHeaderSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Operation].[OrderHeader] Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_OrderHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_OrderHeaderSave] 
    @OrderNo varchar(50),
    @OrderDate datetime,
    @BranchID smallint,
    @CustomerCode nvarchar(50),
	@CustomerName nvarchar(255),
	@RegNo varchar(50),
	@CustomerAddress nvarchar(2000),
    @SaleType varchar(50),
    @Status bit,
    @IsApproved bit,
	@IsPayLater bit,
	@PaymentDays int,
	@TotalAmount decimal(18,2),
	@IsVAT bit,
	@VATAmount decimal(18,2),
	@ISWHTax bit,
	@WHTaxPercent decimal(18,2),
	@WithHoldingAmount decimal(18,2),
	@NetAmount decimal(18,2),
	@PaidAmount decimal(18,2),
	@PaymentType varchar(50),
	@IsRequiredDelivery bit,
	@DeliveryDate datetime,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)   ,
	@Remarks nvarchar(255),
    @NewOrderNo varchar(25) OUTPUT 
AS 
BEGIN 
Declare @dt DateTime,
	 @DocID varchar(50)
/*
Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @OrderNo OUTPUT
*/


	IF (SELECT COUNT(0) FROM [Operation].[OrderHeader]
		WHERE 	[OrderNo] = @OrderNo)>0
	BEGIN	
		EXEC [Operation].[usp_OrderHeaderUpdate] 
			@OrderNo, @OrderDate,@BranchID, @CustomerCode,@CustomerName,@RegNo,@CustomerAddress, @SaleType, @Status, @IsApproved,	@IsPayLater, @PaymentDays,
			@TotalAmount,@IsVAT,@VATAmount,@IsWHTax,@WHTaxPercent,@WithHoldingAmount,@NetAmount,@PaidAmount,
			@PaymentType,@IsRequiredDelivery,@DeliveryDate, @CreatedBy, @ModifiedBy,@Remarks,@NewOrderNo=@NewOrderNo OUTPUT
	END
	Else
	BEGIN

		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber]10, 'Order', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()

		IF LEN(@OrderNo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] @BranchID,'Order', @Dt ,@CreatedBy, @OrderNo OUTPUT
	


	    EXEC [Operation].[usp_OrderHeaderInsert] 			
			@OrderNo, @OrderDate,@BranchID, @CustomerCode,@CustomerName,@RegNo,@CustomerAddress, @SaleType, @Status, @IsApproved,	@IsPayLater, @PaymentDays,
			@TotalAmount,@IsVAT,@VATAmount,@IsWHTax,@WHTaxPercent,@WithHoldingAmount,@NetAmount,@PaidAmount,
			@PaymentType,@IsRequiredDelivery,@DeliveryDate, @CreatedBy, @ModifiedBy,@Remarks,@NewOrderNo=@NewOrderNo OUTPUT

	END
	

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderHeaderUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_OrderHeaderDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Operation].[OrderHeader] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Operation].[usp_OrderHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_OrderHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_OrderHeaderDelete] 
    @OrderNo varchar(50),
	@ModifiedBy varchar(25)
AS 
BEGIN 

	--DELETE
	--FROM   [Operation].[OrderHeader]
	--WHERE  [OrderNo] = @OrderNo

	Update Operation.OrderHeader
	Set Status=CAST(0 as bit) , ModifiedBy=@ModifiedBy, ModifiedOn = GETDATE()
	Where OrderNo = @OrderNo


	Delete stk
	From Operation.StockLedger stk
	Inner Join Operation.OrderDetail Dt On 
		stk.ProductCode = dt.ProductCode
		And stk.MatchDocumentNo = dt.OrderNo
	Where
		dt.OrderNo = @OrderNo

END
GO
/* 
=======================================================================
 END		[Operation].[usp_OrderHeaderDelete]
=======================================================================
*/
 
