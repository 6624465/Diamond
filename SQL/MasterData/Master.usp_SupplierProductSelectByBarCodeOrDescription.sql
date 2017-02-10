
/* 
=======================================================================
 START		[Master].[usp_SupplierProductSelectByBarCodeOrDescription]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Product] Table

Exec [Master].[usp_SupplierProductSelectByBarCodeOrDescription] 'DHL','doll','doll'

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_SupplierProductSelectByBarCodeOrDescription]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_SupplierProductSelectByBarCodeOrDescription] 
END 
GO
CREATE PROC [Master].[usp_SupplierProductSelectByBarCodeOrDescription] 
	@SupplierCode varchar(50),
	@BarCode varchar(50) = NULL,
    @ProductDescription nvarchar(255) = NULL
AS 
BEGIN 

	;With ProductCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='PRODUCTCATEGORY'),
	UOMCategory As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='UOM'),
	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	Prd.[ProductCode], Prd.[BarCode], [UOM], [Size], [Color],Prd.BuyingPrice, Prd.SellingPrice, Prd.[Description], [ProductCategory], [CurrentQty],[ReorderQty],[Location], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn],
			ISNULL(pct.Description,'') As ProductCategoryDescription ,ISNULL(uom.Description,'') As UOMDescription, ISNULL(Lc.Description,'') As LocationDescription
	FROM	Master.CustomerProduct CP 
	Left Outer Join [Master].[Product] Prd ON
		CP.MatchProductCode = Prd.ProductCode
	Left Outer Join ProductCategory Pct ON
		Prd.ProductCategory = pct.LookupCode
	Left Outer Join UOMCategory uom ON
		Prd.UOM = uom.LookupCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	WHERE	CP.[BarCode] = ISNULL(@BarCode,'') 
		And CP.CustomerCode = @SupplierCode
	UNION 
	SELECT	Prd.[ProductCode], Prd.[BarCode], [UOM], [Size], [Color],Prd.BuyingPrice, Prd.SellingPrice, Prd.[Description], [ProductCategory], [CurrentQty],[ReorderQty],[Location], [Status], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn],
			ISNULL(pct.Description,'') As ProductCategoryDescription ,ISNULL(uom.Description,'') As UOMDescription, ISNULL(Lc.Description,'') As LocationDescription
	FROM	Master.CustomerProduct CP 
	Left Outer Join [Master].[Product] Prd ON
		CP.MatchProductCode = Prd.ProductCode 
	Left Outer Join ProductCategory Pct ON
		Prd.ProductCategory = pct.LookupCode
	Left Outer Join UOMCategory uom ON
		Prd.UOM = uom.LookupCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	WHERE	CP.[ProductCode] = ISNULL(@ProductDescription  ,'')
		And CP.CustomerCode = @SupplierCode
END
GO

/* 
=======================================================================
 END		[Master].[usp_SupplierProductSelectByBarCodeOrDescription]
=======================================================================
*/