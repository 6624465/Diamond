 



/* 
=======================================================================
 START		[Operation].[usp_PurchaseOrderHeaderSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Select All Columns From [Operation].[PurchaseOrderHeader] Table

Exec [Operation].[usp_PurchaseOrderHeaderSelect] '1609001',70

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHeaderSelect] 
    @PONo varchar(50),
	@BranchID smallint
AS 
BEGIN 
	SELECT	Hd.[PONo], Hd.[PODate],Hd.BranchId, Hd.[SupplierCode],Hd.ShipmentDate,Hd.ReceiveDate,Hd.EstimateDate,hd.ReferenceNo,
			hd.Buyer,hd.PRNo, Hd.[POStatus], Hd.[IsCancel],Hd.IncoTerms,Hd.PaymentTerm,ISNULL(Pt.Description,'') As PaymentTermDescription ,Hd.Remarks, 
			Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn],
			ISNULL(S.CustomerName,'') As SupplierName,Hd.TotalAmount,Hd.OtherCharges,
			Case 
			When Hd.VATAmount>0 Then Cast(1 as bit) 
			Else Cast(0 as bit) END As IsVAT,
			Hd.VATAmount,Hd.NetAmount
	FROM	[Operation].[PurchaseOrderHeader] Hd
	Left Outer Join [Master].[Customer] S ON 
		Hd.SupplierCode = S.CustomerCode
	Left Outer Join Config.Lookup Pt On 
		Hd.PaymentTerm = Pt.LookupCode
	WHERE	[PONo] = @PONo 
			And BranchID = @BranchID
END
GO

/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderHeaderSelect]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_PurchaseOrderHeaderList]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	List All Data From [Operation].[PurchaseOrderHeader] Table

-- Exec [Operation].[usp_PurchaseOrderHeaderList] 10

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHeaderList] 
	@BranchID smallint
AS 
BEGIN 

	SELECT	Hd.[PONo], Hd.[PODate],Hd.BranchId, Hd.[SupplierCode],Hd.ShipmentDate,Hd.ReceiveDate,Hd.EstimateDate,hd.ReferenceNo,hd.Buyer,hd.PRNo, Hd.[POStatus], 
			Hd.[IsCancel],Hd.IncoTerms,Hd.PaymentTerm,ISNULL(Pt.Description,'') As PaymentTermDescription,Hd.Remarks, 
			Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn],
			ISNULL(S.CustomerName,'') As SupplierName,Hd.TotalAmount,Hd.OtherCharges,Hd.IsVAT,Hd.VATAmount,Hd.NetAmount
	FROM	[Operation].[PurchaseOrderHeader] Hd
	Left Outer Join [Master].[Customer] S ON 
		Hd.SupplierCode = S.CustomerCode
	Left Outer Join Config.Lookup Pt On 
		Hd.PaymentTerm = Pt.LookupCode
	--WHERE	BranchID = @BranchID

 
END
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderHeaderSelect]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_PurchaseOrderHeaderInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Inserts New Record Into [Operation].[PurchaseOrderHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHeaderInsert] 
    @PONo varchar(50),
    @PODate datetime,
    @BranchID smallint,
    @SupplierCode nvarchar(50),
	@ShipmentDate datetime=null,
	@ReceiveDate datetime=null,
	@EstimateDate datetime=null,
	@ReferenceNo nvarchar(50),
	@Buyer nvarchar(50),
	@PRNo nvarchar(50),
	@IncoTerms nvarchar(max),
	@PaymentTerm nvarchar(50),
	@TotalAmount decimal(18,2),
	@OtherCharges decimal(18,2),
	@IsVAT bit,
	@VATAmount decimal(18,2),
	@NetAmount decimal(18,2),
	@Remarks nvarchar(max),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewPONo varchar(25) OUTPUT 
    
AS 
BEGIN 
	INSERT INTO [Operation].[PurchaseOrderHeader] (
			[PONo], [PODate],BranchID, [SupplierCode],ShipmentDate,ReceiveDate,EstimateDate,ReferenceNo,Buyer,PRNo,IncoTerms,PaymentTerm,[POStatus],TotalAmount,OtherCharges,IsVAT,VATAmount,NetAmount,[IsCancel],Remarks, [CreatedBy], [CreatedOn] )
	SELECT	@PONo, @PODate,@BranchID, @SupplierCode,@ShipmentDate,@ReceiveDate,@EstimateDate,@ReferenceNo,@Buyer,@PRNo,@IncoTerms,@PaymentTerm,1,@TotalAmount,@OtherCharges,@IsVAT,@VATAmount,@NetAmount,Cast(0 as bit),@Remarks, @CreatedBy, getutcdate()

	SELECT @NewPONo = @PONo

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderHeaderInsert]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_PurchaseOrderHeaderUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Updates Existing Record Into [Operation].[PurchaseOrderHeader] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHeaderUpdate] 
    @PONo varchar(50),
    @PODate datetime,
    @BranchID smallint,
    @SupplierCode nvarchar(50),
	@ShipmentDate datetime=null,
	@ReceiveDate datetime=null,
	@EstimateDate datetime=null,
	@ReferenceNo nvarchar(50),
	@Buyer nvarchar(50),
	@PRNo nvarchar(50),
	@IncoTerms nvarchar(max),
	@PaymentTerm nvarchar(50),
	@TotalAmount decimal(18,2),
	@OtherCharges decimal(18,2),
	@IsVAT bit,
	@VATAmount decimal(18,2),
	@NetAmount decimal(18,2),
	@Remarks nvarchar(max),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewPONo varchar(25) OUTPUT 
AS 
BEGIN 

	UPDATE	[Operation].[PurchaseOrderHeader]
	SET		[SupplierCode] = @SupplierCode,ShipmentDate=@ShipmentDate,ReceiveDate=@ReceiveDate,
			EstimateDate = @EstimateDate,ReferenceNo = @ReferenceNo,Buyer = @Buyer,PRNo = @PRNo,
			IncoTerms= @IncoTerms,PaymentTerm=@PaymentTerm, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = getutcdate(),POStatus=1,IsCancel=0
			,TotalAmount = @TotalAmount,OtherCharges = @OtherCharges,IsVAT=@IsVAT,VATAmount=@VATAmount,NetAmount=@NetAmount,
			Remarks= @Remarks
	WHERE  [PONo] = @PONo

	SELECT @NewPONo = @PONo

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderHeaderUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_PurchaseOrderHeaderSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Operation].[PurchaseOrderHeader] Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHeaderSave] 
    @PONo varchar(50),
    @PODate datetime,
    @BranchID smallint,
    @SupplierCode nvarchar(50),
	@ShipmentDate datetime=null,
	@ReceiveDate datetime=null,
	@EstimateDate datetime=null,
	@ReferenceNo nvarchar(50),
	@Buyer nvarchar(50),
	@PRNo nvarchar(50),
	@IncoTerms nvarchar(max),
	@PaymentTerm nvarchar(50),
	@TotalAmount decimal(18,2),
	@OtherCharges decimal(18,2),
	@IsVAT bit,
	@VATAmount decimal(18,2),
	@NetAmount decimal(18,2),
	@Remarks nvarchar(max),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25),
    @NewPONo varchar(25) OUTPUT 
AS 
BEGIN 
Declare @dt DateTime,
		@DocID varchar(50),
		@vTransID UNIQUEIDENTIFIER ,
		@vTransactionType Varchar(10),
		@vHistoryCount int=1
 
		Select @vTransID = NEWID(), @vTransactionType = ''

	IF (SELECT COUNT(0) FROM [Operation].[PurchaseOrderHeader]
		WHERE 	[PONo] = @PONo )>0
	BEGIN	
		EXEC [Operation].[usp_PurchaseOrderHeaderUpdate] 
				@PONo, @PODate,@BranchID, @SupplierCode,@ShipmentDate,@ReceiveDate,@EstimateDate,@ReferenceNo,@Buyer,@PRNo,
				@IncoTerms,@PaymentTerm,@TotalAmount,@OtherCharges,@IsVAT,@VATAmount,@NetAmount,@Remarks, @CreatedBy, @ModifiedBy ,@NewPONo=@NewPONo OUTPUT

		Select @vHistoryCount = COUNT(0) 
		From [Operation].[PurchaseOrderHeader]
		Where PONo = @PONo And BranchID = @BranchID

		Select @vTransactionType = 'Revised #' + Convert(varchar(3),@vHistoryCount)

		Exec [Operation].[usp_PurchaseOrderHistoryInsert] 
				@vTransID, @PONo, @BranchID, @PODate, @vTransactionType, @PODate, @SupplierCode, @ShipmentDate, @ReceiveDate, 
				@EstimateDate, @ReferenceNo, @Buyer, @PRNo, @IncoTerms,@PaymentTerm, 1, @TotalAmount,@OtherCharges, @IsVAT, @VATAmount, @NetAmount, 0, 
				@Remarks, @CreatedBy, @ModifiedBy

	END
	Else
	BEGIN


	/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 10,'PO', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()

		Set @PONo =''

		IF LEN(@PONo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] @BranchID ,'PO', @Dt ,@CreatedBy, @PONo OUTPUT



	    EXEC [Operation].[usp_PurchaseOrderHeaderInsert] 
				@PONo, @PODate,@BranchID, @SupplierCode,@ShipmentDate,@ReceiveDate,@EstimateDate,@ReferenceNo,@Buyer,@PRNo,
				@IncoTerms,@PaymentTerm,	@TotalAmount,@OtherCharges,@IsVAT,@VATAmount,@NetAmount,@Remarks, @CreatedBy, @ModifiedBy ,@NewPONo=@NewPONo OUTPUT

		Select @vTransactionType = '1'

		Exec [Operation].[usp_PurchaseOrderHistoryInsert] 
				@vTransID, @PONo, @BranchID, @PODate, @vTransactionType, @PODate, @SupplierCode, @ShipmentDate, @ReceiveDate, 
				@EstimateDate, @ReferenceNo, @Buyer, @PRNo, @IncoTerms,@PaymentTerm, 1, @TotalAmount,@OtherCharges, @IsVAT, @VATAmount, @NetAmount, 0, 
				@Remarks, @CreatedBy, @ModifiedBy

	END
	

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderHeaderUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_PurchaseOrderHeaderDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Deletes Existing Record Into [Operation].[PurchaseOrderHeader] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Operation].[usp_PurchaseOrderHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderHeaderDelete] 
    @PONo varchar(50),
	@BranchID smallint,
	@ModifiedBy varchar(25)
AS 
BEGIN 

	If(Select COUNT(0) From Operation.GoodsReceiveHeader 
		Where PONo = @PONo
		And Status = CAST(1 as bit))>0
	Begin
		RAISERROR('Cannot Delete PO as its already updated in Goods Receive',16,1);
		return 1;
	End
	Else
	Begin

	Update [Operation].[PurchaseOrderHeader]
	Set IsCancel=CAST(1 As bit),ModifiedBy = @ModifiedBy, ModifiedOn = getDate()
	WHERE  [PONo] = @PONo
		--And BranchID = @BranchID
	End

END
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderHeaderDelete]
=======================================================================
*/


 