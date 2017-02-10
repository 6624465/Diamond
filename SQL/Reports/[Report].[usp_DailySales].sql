 

/* 
=======================================================================
 START		[Report].[usp_DailySales]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Daily Sales Report

Exec [Report].[usp_DailySales] '','2015-04-01','2016-04-30'

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_DailySales]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_DailySales]
END 
GO
CREATE PROC [Report].[usp_DailySales]
    @CustomerCode nvarchar(50),
	@DateFrom datetime,
	@DateTo datetime 
AS 
BEGIN 

If @CustomerCode =''
	Set @CustomerCode = NULL;



Select Hd.InvoiceNo,Hd.InvoiceDate,Hd.CustomerCode,Hd.InvoiceAmount,(Hd.InvoiceAmount-Hd.TotalAmount) As PendingAmount ,
Hd.InvoiceType,ISNULL(C.CustomerName,'') As CustomerName,
Case Hd.IsApproved
When 0 Then 'Pending Approval' 
Else 'Approved' END As ApprovalStatus

From Operation.InvoiceHeader  Hd
Left Outer Join Master.Customer C ON
	Hd.CustomerCode = C.CustomerCode
Where 
Hd.CustomerCode = ISNULL(@CustomerCode,Hd.CustomerCode)
And Convert(char(10),InvoiceDate,120) >= Convert(char(10),@DateFrom,120)
And Convert(char(10),InvoiceDate,120) <= Convert(char(10),@DateTo,120)

END
Go

/* 
=======================================================================
 END		[Report].[usp_DailySales]
=======================================================================
*/
