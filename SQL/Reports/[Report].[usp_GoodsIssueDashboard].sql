 

/* 
=======================================================================
 START		[Report].[usp_GoodsIssueDashboard]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Daily Sales Report

Exec [Report].[usp_GoodsIssueDashboard] 

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_GoodsIssueDashboard]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_GoodsIssueDashboard]
END 
GO
CREATE PROC [Report].[usp_GoodsIssueDashboard]
    
AS 
BEGIN 
 
Select COUNT(0) As ItemData  From Operation.GoodsIssue Where Year(DocumentDate) = Year(DateAdd("MONTH",-5,Getdate())) And MONTH(documentdate) = Month(DateAdd("MONTH",-5,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsIssue Where Year(DocumentDate) = Year(DateAdd("MONTH",-4,Getdate())) And MONTH(documentdate) = Month(DateAdd("MONTH",-4,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsIssue Where Year(DocumentDate) = Year(DateAdd("MONTH",-3,Getdate())) And MONTH(documentdate) =  Month(DateAdd("MONTH",-3,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsIssue Where Year(DocumentDate) = Year(DateAdd("MONTH",-2,Getdate())) And MONTH(documentdate) =  Month(DateAdd("MONTH",-2,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsIssue Where Year(DocumentDate) = Year(DateAdd("MONTH",-1,Getdate())) And MONTH(documentdate) =  Month(DateAdd("MONTH",-1,Getdate()))
UNION ALL
select  COUNT(0) As ItemData  From Operation.GoodsIssue Where Year(DocumentDate) = Year(Getdate()) And MONTH(documentdate) = Month(Getdate())
 

END
Go

/* 
=======================================================================
 END		[Report].[usp_GoodsIssueDashboard]
=======================================================================
*/
