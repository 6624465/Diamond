
/* 
=======================================================================
 START		[Operation].[usp_UnBilledInvoiceList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[InvoiceDetail] Table


Exec [Operation].[usp_UnBilledInvoiceList] NULL,'2015-06-01','2015-11-01','CREDITINVOICE',0
=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_UnBilledInvoiceList]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_UnBilledInvoiceList] 
END 
GO
CREATE PROC [Operation].[usp_UnBilledInvoiceList] 
@CustomerCode varchar(50) = NULL,
@DateFrom datetime,
@Dateto datetime,
@InvoiceType varchar(50),
@PendingPayment bit
AS 
BEGIN 


	Declare @tbl table (InvoiceNo varchar(50), InvoiceDate datetime,CustomerCode varchar(50), InvoiceAmount decimal(18,2),PendingAmount decimal(18,2),
						DueDate datetime, CustomerName varchar(255), InvoiceType varchar(50), ApprovalStatus bit)

	Insert into @tbl
	Select InHd.InvoiceNo,InHd.InvoiceDate,Inhd.CustomerCode, InHd.InvoiceAmount,Inhd.InvoiceAmount As PendingAmount,
	Inhd.DueDate, ISNULL(C.CustomerName,'') As CustomerName, Inhd.InvoiceType,InHd.IsApproved As ApprovalStatus
	From Operation.InvoiceHeader InHd
	Left Outer Join Master.Customer C ON 
		InHd.CustomerCode = C.CustomerCode
	Where
	InHd.InvoiceType =@InvoiceType
	And Convert(char(10),Inhd.InvoiceDate,120) >= Convert(char(10),@DateFrom,120)
	And Convert(char(10),Inhd.InvoiceDate,120) <= Convert(char(10),@DateFrom,120)
	 
	If @PendingPayment = Cast(1 as bit)
	Begin
		Insert into @tbl
		Select InHd.InvoiceNo,InHd.InvoiceDate,Inhd.CustomerCode, InHd.InvoiceAmount,Inhd.InvoiceAmount As PendingAmount,
		Inhd.DueDate, ISNULL(C.CustomerName,'') As CustomerName, Inhd.InvoiceType,InHd.IsApproved As ApprovalStatus
		From Operation.InvoiceHeader InHd
		Left Outer Join Master.Customer C ON 
			InHd.CustomerCode = C.CustomerCode
		Where
		InHd.InvoiceType =@InvoiceType
		And InHd.PendingPayment = @PendingPayment 
		And Convert(char(10),Inhd.DueDate,120) <= Convert(char(10),GetDate(),120)
	End

	Select * From @tbl


END
GO

/* 
=======================================================================
 END		[Operation].[usp_UnBilledInvoiceList]
=======================================================================
*/



 