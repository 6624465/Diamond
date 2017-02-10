
/* 
=======================================================================
 START		[Master].[usp_CustomerProductSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[CustomerProduct] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerProductSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerProductSelect] 
END 
GO
CREATE PROC [Master].[usp_CustomerProductSelect] 
    @CustomerCode nvarchar(25),
    @ProductCode nvarchar(50)
AS 
BEGIN 
	SELECT CP.[CustomerCode], CP.[ProductCode], CP.[MatchProductCode], CP.[BarCode], CP.[CostPrice], CS.CustomerName,Prd.Description As MatchProductName
	FROM   [Master].[CustomerProduct] CP
	LEFT OUTER JOIN [master].Customer CS ON
		CP.CustomerCode= CS.CustomerCode
	Left Outer Join master.Product Prd ON
		CP.MatchProductCode = prd.ProductCode
	WHERE  CP.[CustomerCode] = @CustomerCode  
	       AND CP.[ProductCode] = @ProductCode 
	       
END
GO

/* 
=======================================================================
 END		[Master].[usp_CustomerProductSelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CustomerProductList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[CustomerProduct] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerProductList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerProductList] 
END 
GO
CREATE PROC [Master].[usp_CustomerProductList] 
    @CustomerCode nvarchar(25)
    
AS 
BEGIN 
	SELECT CP.[CustomerCode], CP.[ProductCode], CP.[MatchProductCode], CP.[BarCode], CP.[CostPrice], CS.CustomerName,Prd.Description As MatchProductName
	FROM   [Master].[CustomerProduct] CP
	LEFT OUTER JOIN [master].Customer CS ON
		CP.CustomerCode= CS.CustomerCode
	Left Outer Join master.Product Prd ON
		CP.MatchProductCode = prd.ProductCode
	WHERE   CP.[CustomerCode] = @CustomerCode  
	       
	        
END
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerProductSelect]
=======================================================================
*/




/*
=======================================================================
START		[Master].[usp_CustomerProductInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[CustomerProduct] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerProductInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerProductInsert] 
END 
GO
CREATE PROC [Master].[usp_CustomerProductInsert] 
    @CustomerCode nvarchar(25),
    @ProductCode nvarchar(50),
    @MatchProductCode nvarchar(50),
    @BarCode varchar(50),
    @CostPrice decimal(18, 4)
AS 
BEGIN 
	INSERT INTO [Master].[CustomerProduct] ([CustomerCode], [ProductCode], [MatchProductCode], [BarCode], [CostPrice])
	SELECT @CustomerCode, @ProductCode, @MatchProductCode, @BarCode, @CostPrice
END	
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerProductInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_CustomerProductUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[CustomerProduct] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerProductUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerProductUpdate] 
END 
GO
CREATE PROC [Master].[usp_CustomerProductUpdate] 
    @CustomerCode nvarchar(25),
    @ProductCode nvarchar(50),
    @MatchProductCode nvarchar(50),
    @BarCode varchar(50),
    @CostPrice decimal(18, 4)
AS 
BEGIN 

	UPDATE [Master].[CustomerProduct]
	SET    [CostPrice] = @CostPrice
	WHERE  [CustomerCode] = @CustomerCode
	       AND [ProductCode] = @ProductCode
	       AND [MatchProductCode] = @MatchProductCode
	       AND [BarCode] = @BarCode
END	
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerProductUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_CustomerProductSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[CustomerProduct] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_CustomerProductSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerProductSave] 
END 
GO
CREATE PROC [Master].[usp_CustomerProductSave] 
    @CustomerCode nvarchar(25),
    @ProductCode nvarchar(50),
    @MatchProductCode nvarchar(50),
    @BarCode varchar(50),
    @CostPrice decimal(18, 4)
AS 
BEGIN 


	IF (SELECT COUNT(0) FROM [Master].[CustomerProduct]
		WHERE 	[CustomerCode] = @CustomerCode
	       AND [ProductCode] = @ProductCode
	       AND [MatchProductCode] = @MatchProductCode
	       AND [BarCode] = @BarCode)>0
	BEGIN	
		EXEC [Master].[usp_CustomerProductUpdate] @CustomerCode, @ProductCode, @MatchProductCode, @BarCode, @CostPrice
	END
	Else
	BEGIN
	    EXEC [Master].[usp_CustomerProductInsert] @CustomerCode, @ProductCode, @MatchProductCode, @BarCode, @CostPrice
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerProductUpdate]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_CustomerProductDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[CustomerProduct] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_CustomerProductDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerProductDelete] 
END 
GO
CREATE PROC [Master].[usp_CustomerProductDelete] 
    @CustomerCode nvarchar(25),
    @ProductCode nvarchar(50),
    @MatchProductCode nvarchar(50),
    @BarCode varchar(50)
AS 
BEGIN 

	DELETE
	FROM   [Master].[CustomerProduct]
	WHERE  [CustomerCode] = @CustomerCode
	       AND [ProductCode] = @ProductCode
	       AND [MatchProductCode] = @MatchProductCode
	       AND [BarCode] = @BarCode
END
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerProductDelete]
=======================================================================
*/
 


/*
=======================================================================
START		[Master].[usp_CustomerProductDeleteAll]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[CustomerProduct] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_CustomerProductDeleteAll]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_CustomerProductDeleteAll] 
END 
GO
CREATE PROC [Master].[usp_CustomerProductDeleteAll] 
    @CustomerCode nvarchar(25)
AS 
BEGIN 

	DELETE
	FROM   [Master].[CustomerProduct]
	WHERE  [CustomerCode] = @CustomerCode

END
GO
/* 
=======================================================================
 END		[Master].[usp_CustomerProductDeleteAll]
=======================================================================
*/
 
