
/* 
=======================================================================
 START		[Operation].[usp_PurchaseOrderDetailSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Select All Columns From [Operation].[PurchaseOrderDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderDetailSelect] 
    @PONo varchar(50)
    
AS 
BEGIN 
	
	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	Dt.[PONo],   Dt.[ProductCode], Dt.[Quantity],Dt.UOM, Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn] ,
			ISNULL(P.Description,'') As ProductDescription,  Dt.UnitPrice ,Dt.CurrencyCode,Cr.Description As CurrencyDescription
	FROM	[Operation].[PurchaseOrderDetail] Dt
	Left Outer Join [Master].[Product] P ON 
		Dt.ProductCode = P.ProductCode
	Left Outer Join WHLocation Lc ON 
		P.Location = Lc.LookupCode
	Left Outer Join Master.Currency Cr ON 
		Dt.CurrencyCode = Cr.CurrencyCode
	WHERE  [PONo] = @PONo  
END
GO

/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderDetailSelect]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_PurchaseOrderDetailList]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	List All Data From [Operation].[PurchaseOrderDetail] Table


Exec [Operation].[usp_PurchaseOrderDetailList] 'PO151000003'
=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderDetailList] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderDetailList] 
    @PONo varchar(50) 
AS 
BEGIN 

	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	Dt.[PONo],   Dt.[ProductCode], Dt.[Quantity],Dt.UOM, Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn] ,
			ISNULL(P.Description,'') As ProductDescription,  Dt.UnitPrice ,Dt.CurrencyCode,Cr.Description As CurrencyDescription
	FROM	[Operation].[PurchaseOrderDetail] Dt
	Left Outer Join [Master].[Product] P ON 
		Dt.ProductCode = P.ProductCode
	Left Outer Join WHLocation Lc ON 
		P.Location = Lc.LookupCode
	Left Outer Join Master.Currency Cr ON 
		Dt.CurrencyCode = Cr.CurrencyCode

	WHERE   [PONo] = @PONo 
END
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderDetailSelect]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_PurchaseOrderDetailInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Inserts New Record Into [Operation].[PurchaseOrderDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderDetailInsert] 
    @PONo varchar(50),
    @ProductCode nvarchar(50),
    @Quantity float,
	@UOM nvarchar(50),
	@UnitPrice decimal(18,2),
	@CurrencyCode varchar(3),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 
	INSERT INTO [Operation].[PurchaseOrderDetail] (
			[PONo], [ProductCode], [Quantity],UOM,UnitPrice,CurrencyCode, [CreatedBy], [CreatedOn] )
	SELECT	@PONo, @ProductCode, @Quantity,@UOM,@UnitPrice,@CurrencyCode, @CreatedBy, GETDATE()
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderDetailInsert]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_PurchaseOrderDetailUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Updates Existing Record Into [Operation].[PurchaseOrderDetail] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderDetailUpdate] 
    @PONo varchar(50),
    @ProductCode nvarchar(50),
    @Quantity float,
	@UOM nvarchar(50),
 	@UnitPrice decimal(18,2),
	@CurrencyCode varchar(3),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 

	UPDATE [Operation].[PurchaseOrderDetail]
	SET    [Quantity] = @Quantity, UOM=@UOM, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE(),
		   UnitPrice = @UnitPrice,CurrencyCode = @CurrencyCode
	WHERE  [PONo] = @PONo
	       
	       AND [ProductCode] = @ProductCode
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderDetailUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_PurchaseOrderDetailSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Operation].[PurchaseOrderDetail] Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderDetailSave] 
    @PONo varchar(50),
    @ProductCode nvarchar(50),
    @Quantity float,
	@UOM nvarchar(50),
	@UnitPrice decimal(18,2),
	@CurrencyCode varchar(3),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 
Declare @dt DateTime,
	 @DocID varchar(50)
/*
Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @OrderNo OUTPUT
*/


	IF (SELECT COUNT(0) FROM [Operation].[PurchaseOrderDetail]
		WHERE 	[PONo] = @PONo
	       AND [ProductCode] = @ProductCode)>0
	BEGIN	
		EXEC [Operation].[usp_PurchaseOrderDetailUpdate] 
				@PONo,  @ProductCode, @Quantity, @UOM,@UnitPrice,@CurrencyCode,@CreatedBy,  @ModifiedBy 
	END
	Else
	BEGIN
	    EXEC [Operation].[usp_PurchaseOrderDetailInsert] 
				@PONo, @ProductCode, @Quantity,@UOM,	@UnitPrice,@CurrencyCode, @CreatedBy,  @ModifiedBy
	END
	

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderDetailUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_PurchaseOrderDetailDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	Deletes Existing Record Into [Operation].[PurchaseOrderDetail] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Operation].[usp_PurchaseOrderDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderDetailDelete] 
    @PONo varchar(50) 
AS 
BEGIN 

	DELETE
	FROM   [Operation].[PurchaseOrderDetail]
	WHERE  [PONo] = @PONo


END
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderDetailDelete]
=======================================================================
*/
 
