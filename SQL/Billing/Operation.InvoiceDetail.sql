
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
    @InvoiceNo varchar(50)
AS 
BEGIN 
	SELECT [InvoiceNo], OrderNo, [ItemNo], [Quantity], [Price], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[InvoiceDetail] 
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
	SELECT [InvoiceNo], OrderNo, [ItemNo], [Quantity], [Price], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn] 
	FROM   [Operation].[InvoiceDetail] 
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
    @Quantity float,
    @Price decimal(18, 4),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 
	INSERT INTO [Operation].[InvoiceDetail] (
			[InvoiceNo], OrderNo, [ItemNo],  [Quantity], [Price], [CreatedBy], [CreatedOn] )
	SELECT	@InvoiceNo, @OrderNo, @ItemNo,  @Quantity, @Price, @CreatedBy, getdate()
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
    @Quantity float,
    @Price decimal(18, 4),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 

	UPDATE [Operation].[InvoiceDetail]
	SET    [Quantity] = @Quantity, [Price] = @Price,  [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE  [InvoiceNo] = @InvoiceNo
		   AND OrderNo = @OrderNo
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
    @Quantity float,
    @Price decimal(18, 4),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
BEGIN 





	IF (SELECT COUNT(0) FROM [Operation].[InvoiceDetail]
		WHERE 	[InvoiceNo] = @InvoiceNo
	       AND [ItemNo] = @ItemNo
	       AND [OrderNo] = @OrderNo 
	       )>0
	BEGIN	
		EXEC [Operation].[usp_InvoiceDetailUpdate] @InvoiceNo,@OrderNo, @ItemNo,  @Quantity, @Price, @CreatedBy,  @ModifiedBy 
	END
	Else
	BEGIN
	    EXEC [Operation].[usp_InvoiceDetailInsert] @InvoiceNo,@OrderNo, @ItemNo,  @Quantity, @Price, @CreatedBy,  @ModifiedBy 
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

	return 1;
END
GO
/* 
=======================================================================
 END		[Operation].[usp_InvoiceDetailDelete]
=======================================================================
*/

