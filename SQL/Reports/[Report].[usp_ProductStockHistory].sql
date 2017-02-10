 

/* 
=======================================================================
 START		[Report].[usp_ProductStockHistory]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Daily Sales Report

Exec [Report].[usp_ProductStockHistory] 'P150900237'

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_ProductStockHistory]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_ProductStockHistory]
END 
GO
CREATE PROC [Report].[usp_ProductStockHistory]
    @ProductCode nvarchar(50)
	 
AS 
BEGIN 



Select Dt.DocumentNo,Dt.ProductCode,Prd.BarCode,Dt.Quantity,Dt.BuyingPrice,Hd.CustomerCode,Hd.DocumentDate,Hd.PONo,
Prd.Description,Cst.CustomerName
From Operation.StockInDetail Dt
Left Outer Join Operation.StockInHeader Hd On 
	Dt.DocumentNo = Hd.DocumentNo
Left Outer Join Master.Product Prd On 
	Prd.ProductCode = Dt.ProductCode
Left Outer Join Master.Customer Cst ON
	Cst.CustomerCode = Hd.CustomerCode
Where
Dt.ProductCode = @ProductCode 

END
Go

/* 
=======================================================================
 END		[Report].[usp_ProductStockHistory]
=======================================================================
*/
