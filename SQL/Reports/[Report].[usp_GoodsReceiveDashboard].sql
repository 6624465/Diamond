 

/* 
=======================================================================
 START		[Report].[usp_GoodsReceiveDashboard]
=======================================================================
Author:		Sudarshan
Create date:	2016-06-08
Description:	dashboard data for past 6 months for Goods receive.

Exec [Report].[usp_GoodsReceiveDashboard] 

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_GoodsReceiveDashboard]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_GoodsReceiveDashboard]
END 
GO
CREATE PROC [Report].[usp_GoodsReceiveDashboard]
    
AS 
BEGIN 
 
Select COUNT(0) As ItemData  From Operation.GoodsReceiveHeader Where Year(DocumentDate) = Year(DateAdd("MONTH",-5,Getdate())) And MONTH(documentdate) = Month(DateAdd("MONTH",-5,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsReceiveHeader Where Year(DocumentDate) = Year(DateAdd("MONTH",-4,Getdate())) And MONTH(documentdate) = Month(DateAdd("MONTH",-4,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsReceiveHeader Where Year(DocumentDate) = Year(DateAdd("MONTH",-3,Getdate())) And MONTH(documentdate) =  Month(DateAdd("MONTH",-3,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsReceiveHeader Where Year(DocumentDate) = Year(DateAdd("MONTH",-2,Getdate())) And MONTH(documentdate) =  Month(DateAdd("MONTH",-2,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsReceiveHeader Where Year(DocumentDate) = Year(DateAdd("MONTH",-1,Getdate())) And MONTH(documentdate) =  Month(DateAdd("MONTH",-1,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsReceiveHeader Where Year(DocumentDate) = Year(Getdate()) And MONTH(documentdate) = Month(Getdate())
 

END
Go

/* 
=======================================================================
 END		[Report].[usp_GoodsReceiveDashboard]
=======================================================================
*/
