
/* 
=======================================================================
 START		[Operation].[usp_InvoiceDetailSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[InvoiceDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailSelect] 
    @InvoiceNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50)
AS 
BEGIN 
	SELECT	Dt.[InvoiceNo], Dt.[ItemNo], Dt.[ProductCode], Dt.[BarCode], Dt.[Quantity], Dt.[Price], 
			Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],Dt.OrderNo,
			ISNULL(Pr.Description,'') As ProductDescription 
	FROM	[Operation].[InvoiceDetail]  Dt
	Left Outer Join [Master].[Product] Pr ON 
		Dt.ProductCode = Pr.ProductCode
	WHERE  Dt.[InvoiceNo] = @InvoiceNo 
	       AND Dt.[ItemNo] = @ItemNo 
	       AND Dt.[ProductCode] = @ProductCode 
	       AND Dt.[BarCode] = @BarCode 
END
GO

/* 
=======================================================================
 END		[Operation].[usp_InvoiceDetailSelect]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_InvoiceDetailList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Operation].[InvoiceDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailList] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailList] 
    @InvoiceNo varchar(50) 
AS 
BEGIN 
	SELECT	Dt.[InvoiceNo], Dt.[ItemNo], Dt.[ProductCode], Dt.[BarCode], Dt.[Quantity], Dt.[Price], 
			Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],Dt.OrderNo,
			ISNULL(Pr.Description,'') As ProductDescription 
	FROM	[Operation].[InvoiceDetail]  Dt
	Left Outer Join [Master].[Product] Pr ON 
		Dt.ProductCode = Pr.ProductCode
	WHERE  [InvoiceNo] = @InvoiceNo   
	        
END
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceDetailSelect]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_InvoiceDetailInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Operation].[InvoiceDetail] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailInsert] 
    @InvoiceNo varchar(50),
	@OrderNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50),
    @Quantity int,
    @Price decimal(18, 4),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 
	INSERT INTO [Operation].[InvoiceDetail] (
			[InvoiceNo],OrderNo, [ItemNo], [ProductCode], [BarCode], [Quantity], [Price], [CreatedBy], [CreatedOn] )
	SELECT	@InvoiceNo,@OrderNo, @ItemNo, @ProductCode, @BarCode, @Quantity, @Price, @CreatedBy, getdate()
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceDetailInsert]
=======================================================================
*/

/*
=======================================================================
START		[Operation].[usp_InvoiceDetailUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Operation].[InvoiceDetail] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailUpdate] 
    @InvoiceNo varchar(50),
	@OrderNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50),
    @Quantity int,
    @Price decimal(18, 4),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 

	UPDATE [Operation].[InvoiceDetail]
	SET    [Quantity] = @Quantity, [Price] = @Price,  [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE  [InvoiceNo] = @InvoiceNo
	       AND [ItemNo] = @ItemNo
	        
END	
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceDetailUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Operation].[usp_InvoiceDetailSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Operation].[InvoiceDetail] Table.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailSave] 
    @InvoiceNo varchar(50),
	@OrderNo varchar(50),
    @ItemNo smallint,
    @ProductCode nvarchar(50),
    @BarCode varchar(50),
    @Quantity int,
    @Price decimal(18, 4),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 





	IF (SELECT COUNT(0) FROM [Operation].[InvoiceDetail]
		WHERE 	[InvoiceNo] = @InvoiceNo
	       AND [ItemNo] = @ItemNo
	       )>0
	BEGIN	
		EXEC [Operation].[usp_InvoiceDetailUpdate] @InvoiceNo, @OrderNo,@ItemNo, @ProductCode, @BarCode, @Quantity, @Price, @CreatedBy,  @ModifiedBy 
	END
	Else
	BEGIN
	    EXEC [Operation].[usp_InvoiceDetailInsert] @InvoiceNo, @OrderNo,@ItemNo, @ProductCode, @BarCode, @Quantity, @Price, @CreatedBy,  @ModifiedBy 
	END
	

END	
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceDetailUpdate]
=======================================================================
*/
/*
=======================================================================
START		[Operation].[usp_InvoiceDetailDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Operation].[InvoiceDetail] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Operation].[usp_InvoiceDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceDetailDelete] 
    @InvoiceNo varchar(50)
    
AS 
BEGIN 

	DELETE
	FROM   [Operation].[InvoiceDetail]
	WHERE  [InvoiceNo] = @InvoiceNo
	       
END
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceDetailDelete]
=======================================================================
*/

