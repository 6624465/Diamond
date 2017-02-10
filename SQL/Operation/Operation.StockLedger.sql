
/* 
=======================================================================
 START		[Operation].[usp_StockLedgerSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[StockLedger] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockLedgerSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockLedgerSelect] 
END 
GO
CREATE PROC [Operation].[usp_StockLedgerSelect] 
    @TransactionNo varchar(50),
    @TransactionType varchar(50),
    @ProductCode nvarchar(50),
	@BranchID smallint
    
AS 
BEGIN 

	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	[TransactionNo], [TransactionType], [ProductCode],[BranchID], [CustomerCode], [Quantity], [StockFlag], 
			[CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] ,MatchDocumentNo,
			ISNULL(Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription,StockDate
	FROM	[Operation].[StockLedger] SK
	Left Outer Join WHLocation Lc ON 
		SK.Location = Lc.LookupCode
	WHERE	[TransactionNo] = @TransactionNo  
			AND [TransactionType] = @TransactionType  
			AND [ProductCode] = @ProductCode 
			And BranchID = @BranchID
	       
END
GO

/* 
=======================================================================
 END		[Operation].[usp_StockLedgerSelect]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_StockLedgerList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Operation].[StockLedger] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockLedgerList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockLedgerList] 
END 
GO
CREATE PROC [Operation].[usp_StockLedgerList] 
    @ProductCode nvarchar(50) 
     
AS 
BEGIN 

	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	[TransactionNo], [TransactionType], [ProductCode],[BranchID], [CustomerCode], [Quantity], [StockFlag], 
			[CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] ,MatchDocumentNo,
			ISNULL(Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription,StockDate
	FROM	[Operation].[StockLedger] SK
	Left Outer Join WHLocation Lc ON 
		SK.Location = Lc.LookupCode
	WHERE	[ProductCode] = @ProductCode  
	       
	        
END
GO
/* 
=======================================================================
 END		[Operation].[usp_StockLedgerSelect]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_StockLedgerInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Operation].[StockLedger] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockLedgerInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockLedgerInsert] 
END 
GO
CREATE PROC [Operation].[usp_StockLedgerInsert] 
    @TransactionNo varchar(50),
    @TransactionType varchar(50),
    @ProductCode nvarchar(50),
    @BranchID smallint,
    @CustomerCode nvarchar(50),
    @Quantity float,
    @StockFlag int,
	@MatchDocumentNo varchar(50),
	@Location nvarchar(50),
	@StockDate datetime,
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50) 
AS 
BEGIN 
	INSERT INTO [Operation].[StockLedger] (
			[TransactionNo], [TransactionType], [ProductCode],[BranchID], [CustomerCode], 
			[Quantity], [StockFlag],[MatchDocumentNo],Location,StockDate, [CreatedBy], [CreatedOn])
	SELECT	@TransactionNo, @TransactionType, @ProductCode,@BranchID, @CustomerCode, 
			@Quantity, @StockFlag,@MatchDocumentNo,@Location,@StockDate, @CreatedBy, GETDATE()
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_StockLedgerInsert]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_StockLedgerUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Operation].[StockLedger] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockLedgerUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockLedgerUpdate] 
END 
GO
CREATE PROC [Operation].[usp_StockLedgerUpdate] 
    @TransactionNo varchar(50),
    @TransactionType varchar(50),
    @ProductCode nvarchar(50),
    @BranchID smallint,
    @CustomerCode nvarchar(50),
    @Quantity float,
    @StockFlag int,
	@MatchDocumentNo varchar(50),
	@Location nvarchar(50),
	@StockDate datetime,
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50) 
AS 
BEGIN 

	UPDATE	[Operation].[StockLedger]
	SET		[CustomerCode] = @CustomerCode, [Quantity] = @Quantity, [StockFlag] = @StockFlag, 
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE(),Location = @Location,StockDate=@StockDate
	WHERE	[TransactionNo] = @TransactionNo
			AND [TransactionType] = @TransactionType
			AND [ProductCode] = @ProductCode
			And [BranchID] = @BranchID
	       
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_StockLedgerUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_StockLedgerSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Operation].[StockLedger] Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockLedgerSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockLedgerSave] 
END 
GO
CREATE PROC [Operation].[usp_StockLedgerSave] 
    @TransactionNo varchar(50),
    @TransactionType varchar(50),
    @ProductCode nvarchar(50),
    @BranchID smallint,
    @CustomerCode nvarchar(50),
    @Quantity float,
    @StockFlag int,
	@MatchDocumentNo varchar(50),
 	@Location nvarchar(50),
	@StockDate datetime,
    @CreatedBy varchar(50),
    @ModifiedBy varchar(50) 
AS 
BEGIN 
Declare @dt DateTime,
	 @DocID varchar(50)
/*
Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @OrderNo OUTPUT
*/


	IF (SELECT COUNT(0) FROM [Operation].[StockLedger]
		WHERE 	[TransactionNo] = @TransactionNo
	       AND [TransactionType] = @TransactionType
	       AND [ProductCode] = @ProductCode
	       And [BranchID] = @BranchID
	       )>0
	BEGIN	
		EXEC [Operation].[usp_StockLedgerUpdate] @TransactionNo, @TransactionType, @ProductCode,@BranchID, @CustomerCode, @Quantity, @StockFlag,@MatchDocumentNo,@Location,@StockDate, @CreatedBy,  @ModifiedBy 
	END
	Else
	BEGIN

		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 10,'Ledger', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		
		
		
		Set @Dt = GETDATE()

		Set @TransactionNo =''

		IF LEN(@TransactionNo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] @BranchID,'Ledger', @Dt ,@CreatedBy, @TransactionNo OUTPUT

	    EXEC [Operation].[usp_StockLedgerInsert] @TransactionNo, @TransactionType, @ProductCode,@BranchID, @CustomerCode, @Quantity, @StockFlag,@MatchDocumentNo,@Location,@StockDate, @CreatedBy,  @ModifiedBy 

		/* 
			Update the StockInDetail to update the OUTQUANTITY to cut out the stock in FIFO Manner. 
		*/

		If @TransactionType ='OUT'
		Begin
			Exec [Operation].[usp_UpdateOutStockInDetailProduct] @ProductCode, @Quantity

		End


	END
	

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_StockLedgerUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_StockLedgerDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Operation].[StockLedger] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Operation].[usp_StockLedgerDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockLedgerDelete] 
END 
GO
CREATE PROC [Operation].[usp_StockLedgerDelete] 
    @TransactionNo varchar(50),
    @TransactionType varchar(50),
    @ProductCode nvarchar(50),
    @BranchID smallint
    
AS 
BEGIN 

	DELETE
	FROM   [Operation].[StockLedger]
	WHERE  [TransactionNo] = @TransactionNo
	       AND [TransactionType] = @TransactionType
	       AND [ProductCode] = @ProductCode
	       And [BranchID] = @BranchID
END
GO
/* 
=======================================================================
 END		[Operation].[usp_StockLedgerDelete]
=======================================================================
*/

 

/* 
=======================================================================
 START		[Operation].[usp_StockInquiry]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[StockLedger] Table


-- exec [Operation].[usp_StockInquiry] @ProductCode='Soda',@ProductCategory=NULL,@ProductLocation=NULL,@SupplierCode=NULL
=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInquiry]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInquiry] 
END 
GO
CREATE PROC [Operation].[usp_StockInquiry] 
    @ProductCode nvarchar(50),
    @ProductCategory nvarchar(50),
	@ProductLocation nvarchar(50),
    @SupplierCode nvarchar(50)
    
AS 
BEGIN 
	

	If @ProductCode IS NULL
		Set @ProductCode = ''

	If LEN(@ProductLocation)=''
		Set @ProductLocation=NULL

	If @SupplierCode IS NULL

	Begin
		Select Distinct Pr.ProductCode,ISNULL(Pr.Description,'') As ProductDescription,ISNULL(Pr.ProductCategory,'') ProductCategory,
		ISNULL(Pr.Color,'') As Color,ISNULL(Pr.UOM,'') As UOM ,ISNULL(Pr.Size,'') As Size, 
		SUM(ISNULL(Sk.Quantity*Sk.StockFlag,0)) As StockInHand, ''  AS Location,Pr.BarCode,
		Pr.ReOrderQty,[Operation].[udf_GetProductSuppliers](Pr.ProductCode) As Suppliers,Q.SellRate,[Operation].[udf_GetProductHighestCostPrice](Pr.ProductCode) As BuyingPrice
		From Master.Product Pr 
		Left Outer Join Operation.StockLedger Sk ON 
		Sk.ProductCode = Pr.ProductCode
		Left Outer Join Master.STANDARDQuotationView Q On
			Q.ProductCode = Pr.ProductCode
			 
		Where 
		((Pr.ProductCode = ISNULL(@ProductCode,Pr.BarCode)) OR (Pr.Description like '%'+ @ProductCode+'%'))
		And Pr.ProductCategory = ISNULL(@ProductCategory,Pr.ProductCategory)
		And Pr.Location = ISNULL(@ProductLocation,Pr.Location)
		--And Sk.CustomerCode = ISNULL(@SupplierCode,Sk.CustomerCode)
		Group By Pr.ProductCode,Pr.Description,Pr.Color,Pr.Size,Pr.UOM,Pr.ProductCategory,Pr.BarCode,Pr.ReOrderQty,Q.SellRate
	End
	Else
	Begin
		Select Distinct Pr.ProductCode,ISNULL(Pr.Description,'') As ProductDescription,ISNULL(Pr.ProductCategory,'') ProductCategory,
		ISNULL(Pr.Color,'') As Color,ISNULL(Pr.UOM,'') As UOM ,ISNULL(Pr.Size,'') As Size, 
		SUM(ISNULL(Sk.Quantity*Sk.StockFlag,0)) As StockInHand, ''  AS Location,Pr.BarCode,
		Pr.ReOrderQty,Cs.CustomerName as Suppliers,Q.SellRate,[Operation].[udf_GetProductHighestCostPrice](Pr.ProductCode) As BuyingPrice
		From Master.Product Pr 
		Left Outer Join Operation.StockLedger Sk ON 
		Sk.ProductCode = Pr.ProductCode
		Left Outer Join Master.Customer Cs ON
			Sk.CustomerCode = Cs.CustomerCode
		Left Outer Join Master.STANDARDQuotationView Q On
			Q.ProductCode = Pr.ProductCode
		Where 
		((Pr.ProductCode = ISNULL(@ProductCode,Pr.BarCode)) OR (Pr.Description like '%'+ @ProductCode+'%'))
		--(Pr.BarCode = ISNULL(@ProductCode,Pr.BarCode) Or Pr.ProductCode = ISNULL(@ProductCode,Pr.BarCode))
		--Pr.Description like '%'+ @ProductCode+'%'
		And Pr.ProductCategory = ISNULL(@ProductCategory,Pr.ProductCategory)
		And Pr.Location = ISNULL(@ProductLocation,Pr.Location)
		And Sk.CustomerCode = ISNULL(@SupplierCode,Sk.CustomerCode)
		Group By Pr.ProductCode,Pr.Description,Pr.Color,Pr.Size,Pr.UOM,Pr.ProductCategory,Pr.BarCode,Pr.ReOrderQty,Cs.CustomerName,Q.SellRate

	End
	       
END
GO
/* 
=======================================================================
 END		[Operation].[usp_StockInquiry]
=======================================================================
*/
 

  