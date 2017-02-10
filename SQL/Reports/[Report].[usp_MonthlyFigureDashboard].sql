
/* 
=======================================================================
 START		[Report].[usp_MonthlyFigureDashboard]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Daily Sales Report

Exec [Report].[usp_MonthlyFigureDashboard] 

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_MonthlyFigureDashboard]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_MonthlyFigureDashboard]
END 
GO
CREATE PROC [Report].[usp_MonthlyFigureDashboard]
    
AS 
BEGIN 

Select TotalPO = 
(Select COUNT(0) From Operation.PurchaseOrderHeader
Where IsCancel= CAST(0 as bit) And MONTH(PODate) = MONTH(Getdate())),
TotalSales = 
(Select COUNT(0) From Operation.OrderHeader
Where Status= CAST(1 as bit) And MONTH(OrderDate) = MONTH(Getdate())),
TotalGoodsReceive = 
(Select COUNT(0) From Operation.GoodsReceiveHeader
Where Status= CAST(1 as bit) And MONTH(DocumentDate) = MONTH(Getdate())),
TotalGoodsIssue = 
(Select COUNT(0) From Operation.GoodsIssue
Where Status= CAST(1 as bit) And MONTH(DocumentDate) = MONTH(Getdate()))

 

END
Go

/* 
=======================================================================
 END		[Report].[usp_MonthlyFigureDashboard]
=======================================================================
*/
