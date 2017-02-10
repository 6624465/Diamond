
-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceivePODetailSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceivePODetail] Record based on [GoodsReceivePODetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsReceivePODetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceivePODetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceivePODetailSelect] 
    @DocumentNo VARCHAR(50),
    @PONo VARCHAR(50)
AS 
 

BEGIN

	SELECT Dt.[DocumentNo], Dt.[PONo], Dt.[ProductCode], Dt.[Quantity],Dt.ReceiveQuantity, (Dt.Quantity - Dt.ReceiveQuantity) As PendingQuantity,
	Dt.[UOM], Dt.[UnitPrice], Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn] ,
	ISNULL(prd.Description,'') As ProductDescription, 1 As Status,Dt.CurrencyCode,Cr.Description As CurrencyDescription
	FROM   [Operation].[GoodsReceivePODetail] Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	Left Outer Join Master.Currency Cr On 
		Dt.CurrencyCode = Cr.CurrencyCode

	WHERE  [DocumentNo] = @DocumentNo 
	       AND  [PONo] = @PONo 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceivePODetailSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceivePODetailList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [GoodsReceivePODetail] Records from [GoodsReceivePODetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsReceivePODetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceivePODetailList] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceivePODetailList] 
	@DocumentNo varchar(50)
AS 
 
BEGIN
	SELECT Dt.[DocumentNo], Dt.[PONo], Dt.[ProductCode], Dt.[Quantity],Dt.ReceiveQuantity,(Dt.Quantity - Dt.ReceiveQuantity) As PendingQuantity, Dt.[UOM], Dt.[UnitPrice], Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn] ,
	ISNULL(prd.Description,'') As ProductDescription, 1 As Status,Dt.CurrencyCode,Cr.Description As CurrencyDescription
	FROM   [Operation].[GoodsReceivePODetail] Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	Left Outer Join Master.Currency Cr On 
		Dt.CurrencyCode = Cr.CurrencyCode

	WHERE  [DocumentNo] = @DocumentNo

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceivePODetailList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceivePODetailInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [GoodsReceivePODetail] Record Into [GoodsReceivePODetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceivePODetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceivePODetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceivePODetailInsert] 
    @DocumentNo varchar(50),
    @PONo varchar(50),
    @ProductCode nvarchar(50),
    @Quantity float,
	@ReceiveQuantity float,
    @UOM nvarchar(50),
    @UnitPrice decimal(18, 2),
	@CurrencyCode varchar(3),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
  

BEGIN
	
	INSERT INTO [Operation].[GoodsReceivePODetail] (
			[DocumentNo], [PONo], [ProductCode], [Quantity],ReceiveQuantity, [UOM], [UnitPrice],CurrencyCode, [CreatedBy], [CreatedOn])
	SELECT	@DocumentNo, @PONo, @ProductCode, @Quantity,@ReceiveQuantity, @UOM, @UnitPrice,@CurrencyCode, @CreatedBy, GEtDate()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceivePODetailInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceivePODetailUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [GoodsReceivePODetail] Record Into [GoodsReceivePODetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceivePODetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceivePODetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceivePODetailUpdate] 
    @DocumentNo varchar(50),
    @PONo varchar(50),
    @ProductCode nvarchar(50),
    @Quantity float,
	@ReceiveQuantity float,
    @UOM nvarchar(50),
    @UnitPrice decimal(18, 2),
	@CurrencyCode varchar(3),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
 
	
BEGIN

	UPDATE [Operation].[GoodsReceivePODetail]
	SET   [ProductCode] = @ProductCode, [Quantity] = @Quantity, ReceiveQuantity = @ReceiveQuantity, [UOM] = @UOM, [UnitPrice] = @UnitPrice, CurrencyCode = @CurrencyCode, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GETDATE()
	WHERE  [DocumentNo] = @DocumentNo
	       AND [PONo] = @PONo
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceivePODetailUpdate]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceivePODetailSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [GoodsReceivePODetail] Record Into [GoodsReceivePODetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceivePODetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceivePODetailSave] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceivePODetailSave] 
    @DocumentNo varchar(50),
    @PONo varchar(50),
    @ProductCode nvarchar(50),
    @Quantity float,
	@ReceiveQuantity float,
    @UOM nvarchar(50),
    @UnitPrice decimal(18, 2),
	@CurrencyCode varchar(3),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) 
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[GoodsReceivePODetail] 
		WHERE 	[DocumentNo] = @DocumentNo
	       AND [PONo] = @PONo)>0
	BEGIN
	    Exec [Operation].[usp_GoodsReceivePODetailUpdate] 
				@DocumentNo, @PONo, @ProductCode, @Quantity,@ReceiveQuantity, @UOM, @UnitPrice,@CurrencyCode, @CreatedBy,  @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_GoodsReceivePODetailInsert] 
				@DocumentNo, @PONo, @ProductCode, @Quantity,@ReceiveQuantity, @UOM, @UnitPrice,@CurrencyCode, @CreatedBy,  @ModifiedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[GoodsReceivePODetailSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceivePODetailDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [GoodsReceivePODetail] Record  based on [GoodsReceivePODetail]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_GoodsReceivePODetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceivePODetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceivePODetailDelete] 
    @DocumentNo varchar(50),
    @PONo varchar(50)
AS 

	
BEGIN

	 
	DELETE
	FROM   [Operation].[GoodsReceivePODetail]
	WHERE  [DocumentNo] = @DocumentNo
	       AND [PONo] = @PONo
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceivePODetailDelete]
-- ========================================================================================================================================

GO
 


 
-- ========================================================================================================================================
-- START											 [Operation].[usp_GoodsReceivePODetailPendingList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceivePODetail] Record based on [GoodsReceivePODetail] table

-- EXEC [Operation].[usp_GoodsReceivePODetailPendingList] '1607009'
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_GoodsReceivePODetailPendingList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GoodsReceivePODetailPendingList] 
END 
GO
CREATE PROC [Operation].[usp_GoodsReceivePODetailPendingList] 
    @PONo VARCHAR(50)
AS 
 

BEGIN

	SELECT '' As [DocumentNo], Dt.[PONo], Dt.[ProductCode], Dt.[Quantity],0 As ReceiveQuantity,ISNULL((P.ReceiveQty -Dt.[Quantity])*-1,Dt.[Quantity]) As PendingQuantity, Dt.[UOM], Dt.[UnitPrice], 
			Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn] , ISNULL(Prd.Description,'') As ProductDescription ,1 As Status,
			Dt.CurrencyCode,Cr.Description As CurrencyDescription
	FROM   [Operation].[PurchaseOrderDetail]   Dt
	Left Outer Join Master.Product Prd On 
		Dt.ProductCode = Prd.ProductCode
	Left Outer Join Master.Currency Cr On 
		Dt.CurrencyCode = Cr.CurrencyCode
	Left Outer Join 
	(Select PoNo, Sum(ReceiveQuantity) As ReceiveQty From 
	Operation.GoodsReceivePODetail 
	Where PONo = @PONo
	Group By PONo ) P On 
		Dt.PONo = P.PONo
	WHERE Dt.[PONo] = @PONo 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_GoodsReceivePODetailPendingList]
-- ========================================================================================================================================

GO
