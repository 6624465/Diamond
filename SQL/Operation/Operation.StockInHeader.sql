
/* 
=======================================================================
 START		[Operation].[usp_StockInHeaderSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[StockInHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInHeaderSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInHeaderSelect] 
END 
GO
CREATE PROC [Operation].[usp_StockInHeaderSelect] 
    @DocumentNo varchar(50)
AS 
BEGIN 
	SELECT	Hd.[DocumentNo], Hd.[DocumentDate],Hd.[BranchID], Hd.[CustomerCode], Hd.[PONo], Hd.[Status], Hd.[IsApproved], 
			Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn] ,ISNULL(S.CustomerName,'') As CustomerName,
			Hd.TotalAmount,Hd.IsVAT,hd.VATAmount,Hd.NetAmount
	FROM	[Operation].[StockInHeader]  Hd
	Left Outer Join [Master].[Customer] S ON 
		Hd.CustomerCode = S.CustomerCode
	WHERE  [DocumentNo] = @DocumentNo 
END
GO

/* 
=======================================================================
 END		[Operation].[usp_StockInHeaderSelect]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_StockInHeaderList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Operation].[StockInHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInHeaderList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInHeaderList] 
END 
GO
CREATE PROC [Operation].[usp_StockInHeaderList] 
    
AS 
BEGIN 
	SELECT	Hd.[DocumentNo], Hd.[DocumentDate],Hd.[BranchID], Hd.[CustomerCode], Hd.[PONo], Hd.[Status], Hd.[IsApproved], 
			Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn] ,ISNULL(S.CustomerName,'') As CustomerName,
			Hd.TotalAmount,Hd.IsVAT,hd.VATAmount,Hd.NetAmount
	FROM	[Operation].[StockInHeader]  Hd
	Left Outer Join [Master].[Customer] S ON 
		Hd.CustomerCode = S.CustomerCode
	 
END
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInHeaderSelect]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_StockInHeaderInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Operation].[StockInHeader] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInHeaderInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInHeaderInsert] 
END 
GO
CREATE PROC [Operation].[usp_StockInHeaderInsert] 
    @DocumentNo varchar(50),
    @DocumentDate datetime,
    @BranchID smallint,
    @CustomerCode varchar(50),
    @PONo varchar(50),
    @Status bit,
	@TotalAmount decimal(18,2),
	@IsVAT bit,
	@VatAmount decimal(18,2),
	@NetAmount decimal(18,2),
    @IsApproved bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)  ,
    @NewDocumentNo varchar(25) OUTPUT
AS 
BEGIN 
	INSERT INTO [Operation].[StockInHeader] (
			[DocumentNo], [DocumentDate],BranchID, [CustomerCode], [PONo], [Status],TotalAmount,IsVAT,VATAmount,NetAmount, [IsApproved], [CreatedBy], [CreatedOn] )
	SELECT	@DocumentNo, @DocumentDate,@BranchID, @CustomerCode, @PONo, Cast(1 as bit),@TotalAmount,@IsVAT,@VatAmount,@NetAmount, @IsApproved, @CreatedBy, GETDATE()

		SELECT @NewDocumentNo = @DocumentNo
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInHeaderInsert]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_StockInHeaderUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Operation].[StockInHeader] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInHeaderUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInHeaderUpdate] 
END 
GO
CREATE PROC [Operation].[usp_StockInHeaderUpdate] 
    @DocumentNo varchar(50),
    @DocumentDate datetime,
    @BranchID smallint,
    @CustomerCode varchar(50),
    @PONo varchar(50),
    @Status bit,
	@TotalAmount decimal(18,2),
	@IsVAT bit,
	@VatAmount decimal(18,2),
	@NetAmount decimal(18,2),
    @IsApproved bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) ,
    @NewDocumentNo varchar(25) OUTPUT
AS 
BEGIN 

	UPDATE	[Operation].[StockInHeader]
	SET		[DocumentDate] = @DocumentDate, [CustomerCode] = @CustomerCode, [PONo] = @PONo, [Status] = Cast(1 as bit), 
			[IsApproved] = @IsApproved, 
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE	[DocumentNo] = @DocumentNo

		SELECT @NewDocumentNo = @DocumentNo
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInHeaderUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_StockInHeaderSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Operation].[StockInHeader] Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInHeaderSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInHeaderSave] 
END 
GO
CREATE PROC [Operation].[usp_StockInHeaderSave] 
    @DocumentNo varchar(50),
    @DocumentDate datetime,
    @BranchID smallint,
    @CustomerCode varchar(50),
    @PONo varchar(50),
    @Status bit,
	@TotalAmount decimal(18,2),
	@IsVAT bit,
	@VatAmount decimal(18,2),
	@NetAmount decimal(18,2),
    @IsApproved bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)  ,
    @NewDocumentNo varchar(25) OUTPUT
AS 
BEGIN 
Declare @dt DateTime,
	 @DocID varchar(50)
/*
Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @OrderNo OUTPUT
*/


	IF (SELECT COUNT(0) FROM [Operation].[StockInHeader]
		WHERE 	[DocumentNo] = @DocumentNo)>0
	BEGIN	
		EXEC [Operation].[usp_StockInHeaderUpdate] @DocumentNo, @DocumentDate,@BranchID, @CustomerCode, @PONo, @Status, @TotalAmount,@IsVAT,@VatAmount,@NetAmount, @IsApproved, @CreatedBy, @ModifiedBy , 
		@NewDocumentNo  = @NewDocumentNo OUTPUT
	END
	Else
	BEGIN

		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 10,'Stock', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()

		set @DocumentNo='';

		IF LEN(@DocumentNo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] @BranchID,'Stock', @Dt ,@CreatedBy, @DocumentNo OUTPUT
	

	    EXEC [Operation].[usp_StockInHeaderInsert] @DocumentNo, @DocumentDate,@BranchID, @CustomerCode, @PONo, @Status,@TotalAmount,@IsVAT,@VatAmount,@NetAmount, @IsApproved, @CreatedBy, @ModifiedBy , 
		@NewDocumentNo  = @NewDocumentNo OUTPUT
	
	END

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInHeaderUpdate]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_StockInHeaderDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Operation].[StockInHeader] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Operation].[usp_StockInHeaderDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInHeaderDelete] 
END 
GO
CREATE PROC [Operation].[usp_StockInHeaderDelete] 
    @DocumentNo varchar(50),
	@ModifiedBy varchar(25)
AS 
BEGIN 

	Update Operation.StockInHeader 
	Set Status = CAST(0 as bit),ModifiedBy = @ModifiedBy, ModifiedOn = GETDATE()
	Where DocumentNo = @DocumentNo 


	Delete stk
	From Operation.StockLedger stk
	Inner Join Operation.StockInDetail Dt On 
		stk.ProductCode = dt.ProductCode
		And stk.MatchDocumentNo = dt.DocumentNo
	Where
		dt.DocumentNo = @DocumentNo

 
END
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInHeaderDelete]
=======================================================================
*/


