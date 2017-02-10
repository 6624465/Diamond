

/* 
=======================================================================
 START		[Operation].[usp_StockCount]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[StockLedger] Table


-- exec [Operation].[usp_StockCount] @ProductCode=NULL,@ProductCategory=NULL,@ProductLocation=NULL,@SupplierCode=NULL
=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockCount]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockCount] 
END 
GO
CREATE PROC [Operation].[usp_StockCount] 
    @ProductCode nvarchar(50),
    @ProductCategory nvarchar(50),
	@ProductLocation nvarchar(50),
    @SupplierCode nvarchar(50)
    
AS 
BEGIN 
	

	If @ProductCode IS NULL
		Set @ProductCode = ''


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
		(Pr.BarCode = ISNULL(@ProductCode,Pr.BarCode) Or Pr.ProductCode = ISNULL(@ProductCode,Pr.BarCode))
		--Pr.Description like '%'+ @ProductCode+'%'
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
		(Pr.BarCode = ISNULL(@ProductCode,Pr.BarCode) Or Pr.ProductCode = ISNULL(@ProductCode,Pr.BarCode))
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
 END		[Operation].[usp_StockCount]
=======================================================================
*/
 