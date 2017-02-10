


-- ========================================================================================================================================
-- START											 [Operation].[usp_SIDetailSelect]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [SIDetail] Record based on [SIDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_SIDetailSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIDetailSelect] 
END 
GO
CREATE PROC [Operation].[usp_SIDetailSelect] 
    @DocumentNo VARCHAR(50),
    @ProductCode NVARCHAR(50)
AS 
 

BEGIN

	SELECT	Dt.[DocumentNo], Dt.[ProductCode], Dt.[Quantity],Dt.UOM, Dt.[UnitPrice], Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],
			Dt.CurrencyCode,
			ISNULL(Cr.Description,'') As CurrencyDescription,
			ISNULL(P.Description,'') As ProductDescription 
	FROM	[Operation].[SIDetail] Dt
	Left Outer Join Master.Currency Cr ON 
			Dt.CurrencyCode = Cr.CurrencyCode
	Left Outer Join [Master].[Product] P ON 
		Dt.ProductCode = P.ProductCode
	WHERE  Dt.[DocumentNo] = @DocumentNo  
	       AND Dt.[ProductCode] = @ProductCode  

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIDetailSelect]
-- ========================================================================================================================================

GO

-- ========================================================================================================================================
-- START											 [Operation].[usp_SIDetailList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select all the [SIDetail] Records from [SIDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_SIDetailList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIDetailList] 
END 
GO
CREATE PROC [Operation].[usp_SIDetailList] 
	@DocumentNo VARCHAR(50)
AS 
 
BEGIN
		SELECT	Dt.[DocumentNo], Dt.[ProductCode], Dt.[Quantity],Dt.UOM, Dt.[UnitPrice], Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn],
			Dt.CurrencyCode,
			ISNULL(Cr.Description,'') As CurrencyDescription,
			ISNULL(P.Description,'') As ProductDescription 
	FROM	[Operation].[SIDetail] Dt
	Left Outer Join Master.Currency Cr ON 
			Dt.CurrencyCode = Cr.CurrencyCode
	Left Outer Join [Master].[Product] P ON 
		Dt.ProductCode = P.ProductCode
	WHERE  [DocumentNo] = @DocumentNo

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIDetailList] 
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_SIDetailInsert]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Inserts the [SIDetail] Record Into [SIDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIDetailInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIDetailInsert] 
END 
GO
CREATE PROC [Operation].[usp_SIDetailInsert] 
    @DocumentNo varchar(50),
    @ProductCode nvarchar(50),
    @Quantity float,
	@UOM nvarchar(50),
    @UnitPrice decimal(18, 2),
	@CurrencyCode varchar(3),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)

AS 
  

BEGIN
	
	INSERT INTO [Operation].[SIDetail] (
			[DocumentNo], [ProductCode], [Quantity],UOM, [UnitPrice],CurrencyCode, [ModifiedBy], [ModifiedOn])
	SELECT	@DocumentNo, @ProductCode, @Quantity,@UOM, @UnitPrice,@CurrencyCode, @ModifiedBy, GetDate()
	
               
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIDetailInsert]
-- ========================================================================================================================================

GO



-- ========================================================================================================================================
-- START											 [Operation].[usp_SIDetailUpdate]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	updates the [SIDetail] Record Into [SIDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIDetailUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIDetailUpdate] 
END 
GO
CREATE PROC [Operation].[usp_SIDetailUpdate] 
    @DocumentNo varchar(50),
    @ProductCode nvarchar(50),
    @Quantity float,
	@UOM nvarchar(50),
    @UnitPrice decimal(18, 2),
	@CurrencyCode varchar(3),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 
	
BEGIN

	UPDATE	[Operation].[SIDetail]
	SET		[DocumentNo] = @DocumentNo, [ProductCode] = @ProductCode, [Quantity] = @Quantity, [UnitPrice] = @UnitPrice, UOM=@UOM,CurrencyCode = @CurrencyCode,
			[ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE	[DocumentNo] = @DocumentNo
			AND [ProductCode] = @ProductCode
	

END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIDetailUpdate]
-- ========================================================================================================================================

GO


-- ========================================================================================================================================
-- START											 [Operation].[usp_SIDetailSave]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Either INSERT or UPDATE the [SIDetail] Record Into [SIDetail] Table.

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIDetailSave]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIDetailSave] 
END 
GO
CREATE PROC [Operation].[usp_SIDetailSave] 
    @DocumentNo varchar(50),
    @ProductCode nvarchar(50),
    @Quantity float,
	@UOM nvarchar(50),
    @UnitPrice decimal(18, 2),
	@CurrencyCode varchar(3),
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25)
AS 
 

BEGIN

	IF (SELECT COUNT(0) FROM [Operation].[SIDetail] 
		WHERE 	[DocumentNo] = @DocumentNo
	       AND [ProductCode] = @ProductCode)>0
	BEGIN
	    Exec [Operation].[usp_SIDetailUpdate] 
				@DocumentNo, @ProductCode, @Quantity, @UOM,@UnitPrice,@CurrencyCode, @CreatedBy, @ModifiedBy 


	END
	ELSE
	BEGIN
	    Exec [Operation].[usp_SIDetailInsert] 
				@DocumentNo, @ProductCode, @Quantity, @UOM,@UnitPrice,@CurrencyCode, @CreatedBy, @ModifiedBy 


	END
	

END

	

-- ========================================================================================================================================
-- END  											 [Operation].usp_[SIDetailSave]
-- ========================================================================================================================================

GO




-- ========================================================================================================================================
-- START											 [Operation].[usp_SIDetailDelete]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Deletes the [SIDetail] Record  based on [SIDetail]

-- ========================================================================================================================================

IF OBJECT_ID('[Operation].[usp_SIDetailDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SIDetailDelete] 
END 
GO
CREATE PROC [Operation].[usp_SIDetailDelete] 
    @DocumentNo varchar(50),
    @ProductCode nvarchar(50)
AS 

	
BEGIN

	 
	DELETE
	FROM   [Operation].[SIDetail]
	WHERE  [DocumentNo] = @DocumentNo
	       AND [ProductCode] = @ProductCode
	 
END

-- ========================================================================================================================================
-- END  											 [Operation].[usp_SIDetailDelete]
-- ========================================================================================================================================

GO
 