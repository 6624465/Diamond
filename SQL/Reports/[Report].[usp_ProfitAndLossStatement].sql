use [NetStock]
GO


/* 
=======================================================================
 START		[Report].[usp_ProfitAndLossStatement]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Daily Sales Report

Exec [Report].[usp_ProfitAndLossStatement] '2015-09-01','2015-09-30'

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_ProfitAndLossStatement]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_ProfitAndLossStatement]
END 
GO
CREATE PROC [Report].[usp_ProfitAndLossStatement]
	@DateFrom datetime,
	@DateTo datetime 
AS 
BEGIN 


Select Hd.InvoiceNo,Hd.InvoiceDate,Hd.CustomerCode,ISNULL(C.CustomerName,'') As CustomerName,
Prd.ProductCode, prd.BarCode, prd.Description,(prd.BuyingPrice*dt.Quantity) as BuyingPrice , dt.Price As InvoicePrice , (dt.Price-(prd.BuyingPrice*dt.Quantity)) As ProfitMargin
From Operation.InvoiceHeader  Hd
Left Outer Join Operation.InvoiceDetail Dt On 
	Hd.InvoiceNo = Dt.InvoiceNo
Left Outer Join Master.Customer C ON
	Hd.CustomerCode = C.CustomerCode
Left Outer Join Operation.OrderDetail OrDt On 
	Dt.OrderNo = OrDt.OrderNo
	And Dt.ItemNo = OrDt.ItemNo
Left Outer Join Master.Product Prd ON 
	OrDt.ProductCode = Prd.ProductCode
Where 
Convert(char(10),InvoiceDate,120) >= @DateFrom 
And Convert(char(10),InvoiceDate,120) <= @DateTo

END
Go

/* 
=======================================================================
 END		[Report].[usp_ProfitAndLossStatement]
=======================================================================
*/


 