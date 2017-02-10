-- exec [Operation].[usp_UnbilledInvoices] 'CASH','2015-06-01','2015-06-10',1,0

--exec [Operation].[usp_UnbilledInvoices] @CustomerCode='CASH',@DateFrom='2015-06-01 00:00:00',@DateTo='2015-06-16 00:00:00',@OverDue=1,@PaymentDays=0

/* 
=======================================================================
 START		[Operation].[usp_UnbilledInvoices]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[InvoiceDetail] Table

=======================================================================
*/
IF OBJECT_ID('[Operation].[usp_UnbilledInvoices]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_UnbilledInvoices] 
END 
GO
CREATE PROC [Operation].[usp_UnbilledInvoices] 
    @CustomerCode varchar(50),
	@DateFrom datetime,
	@DateTo datetime,
	@OverDue bit,
	@PaymentDays int
AS 
BEGIN 


Select InvoiceNo,InvoiceDate,Hd.CustomerCode,InvoiceAmount,(InvoiceAmount-TotalAmount) As PendingAmount ,DueDate ,InvoiceType,ISNULL(C.CustomerName,'') As CustomerName,
Case 
	When IsApproved=0 then 'Pending Approval'
	Else 'Approved'
End As ApprovalStatus
From Operation.InvoiceHeader  Hd
Left Outer Join Master.Customer C ON
	Hd.CustomerCode = C.CustomerCode
Where Hd.CustomerCode = ISNULL(@CustomerCode,Hd.CustomerCode)
And InvoiceDate between @DateFrom And @DateTo
And PendingPayment = @OverDue
And DATEDIFF(DAY,InvoiceDate,DueDate)>@PaymentDays


END
Go

/* 
=======================================================================
 END		[Operation].[usp_UnbilledInvoices]
=======================================================================
*/




/* 
=======================================================================
 START		[Operation].[usp_InvoiceInquiry]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select For Invoice Inquiry.

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_InvoiceInquiry]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_InvoiceInquiry] 
END 
GO
CREATE PROC [Operation].[usp_InvoiceInquiry] 
    @CustomerCode varchar(50),
	@DateFrom datetime,
	@DateTo datetime,
	@InvoiceType varchar(50)
AS 
BEGIN 


Select InvoiceNo,InvoiceDate,Hd.CustomerCode,InvoiceAmount,(InvoiceAmount-TotalAmount) As PendingAmount ,DueDate ,InvoiceType,ISNULL(C.CustomerName,'') As CustomerName,
Case 
	When IsApproved=0 then 'Pending Approval'
	Else 'Approved'
End As ApprovalStatus
From Operation.InvoiceHeader  Hd
Left Outer Join Master.Customer C ON
	Hd.CustomerCode = C.CustomerCode
Where Hd.CustomerCode = ISNULL(@CustomerCode,Hd.CustomerCode)
And InvoiceDate between @DateFrom And @DateTo
And InvoiceType = ISNULL(@InvoiceType,InvoiceType)



END
GO


/* 
=======================================================================
 END		[Operation].[usp_InvoiceInquiry]
=======================================================================
*/




/* 
=======================================================================
 START		[Operation].[usp_UnApprovedInvoices]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Un Approved Inovices.

Exec [Operation].[usp_UnApprovedInvoices] NULL,'2015-09-01','2015-09-30'

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_UnApprovedInvoices]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_UnApprovedInvoices] 
END 
GO
CREATE PROC [Operation].[usp_UnApprovedInvoices] 
    @CustomerCode varchar(50),
	@DateFrom datetime,
	@DateTo datetime 
AS 
BEGIN 


Select Hd.InvoiceNo,Hd.InvoiceDate,Hd.CustomerCode,Hd.InvoiceAmount,(Hd.InvoiceAmount-Hd.TotalAmount) As PendingAmount ,Hd.DueDate ,
Hd.InvoiceType,ISNULL(C.CustomerName,'') As CustomerName,'Pending Approval' As ApprovalStatus
From Operation.InvoiceHeader  Hd
Left Outer Join Master.Customer C ON
	Hd.CustomerCode = C.CustomerCode
Where 
Hd.CustomerCode = ISNULL(@CustomerCode,Hd.CustomerCode)
And Convert(char(10),InvoiceDate,120) >= @DateFrom 
And Convert(char(10),InvoiceDate,120) <= @DateTo
And Hd.IsApproved = CAST(0 as bit)
And Hd.InvoiceType ='CASHBILL'

END
Go

/* 
=======================================================================
 END		[Operation].[usp_UnApprovedInvoices]
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

	--Insert into @tbl
	--Select InHd.InvoiceNo,InHd.InvoiceDate,Inhd.CustomerCode, InHd.InvoiceAmount,Inhd.InvoiceAmount As PendingAmount,
	--Inhd.DueDate, ISNULL(C.CustomerName,'') As CustomerName, Inhd.InvoiceType,InHd.IsApproved As ApprovalStatus
	--From Operation.InvoiceHeader InHd
	--Left Outer Join Master.Customer C ON 
	--	InHd.CustomerCode = C.CustomerCode
	--Where
	--InHd.InvoiceType =@InvoiceType
	--And Convert(char(10),Inhd.InvoiceDate,120) >= Convert(char(10),@DateFrom,120)
	--And Convert(char(10),Inhd.InvoiceDate,120) <= Convert(char(10),@DateFrom,120)
	 
	If @InvoiceType = 'CASHBILL'
	Begin
		Insert into @tbl
		Select InHd.InvoiceNo,InHd.InvoiceDate,Inhd.CustomerCode, InHd.InvoiceAmount,Inhd.InvoiceAmount As PendingAmount,
		Inhd.DueDate, ISNULL(C.CustomerName,'') As CustomerName, Inhd.InvoiceType,InHd.IsApproved As ApprovalStatus
		From Operation.InvoiceHeader InHd
		Left Outer Join Master.Customer C ON 
			InHd.CustomerCode = C.CustomerCode
		Where
		InHd.InvoiceType =@InvoiceType
		And InHd.PendingPayment>0
		--And InHd.PendingPayment = @PendingPayment 
		And InHd.IsApproved = Cast(0 as bit)
		And Convert(Char(10),InHd.InvoiceDate,120) >=Convert(char(10),@DateFrom,120)
		And Convert(Char(10),InHd.InvoiceDate,120) <=Convert(char(10),@DateTo,120)
		And InHd.CustomerCode = ISNULL(@CustomerCode,InHd.CustomerCode)

		--And Convert(char(10),Inhd.DueDate,120) <= Convert(char(10),GetDate(),120)
		--And DATEDIFF("D",InHd.InvoiceDate,GETDATE())>C.CreditTerm
	End
	Else If @InvoiceType='CREDITBILL'
	Begin
		Insert into @tbl
		Select InHd.InvoiceNo,InHd.InvoiceDate,Inhd.CustomerCode, InHd.InvoiceAmount,Inhd.InvoiceAmount As PendingAmount,
		DATEADD("D",C.CreditTerm,InHd.InvoiceDate) As DueDate,  ISNULL(C.CustomerName,'') As CustomerName, Inhd.InvoiceType,InHd.IsApproved As ApprovalStatus
		From Operation.InvoiceHeader InHd
		Left Outer Join Master.Customer C ON 
			InHd.CustomerCode = C.CustomerCode
		Where
		InHd.InvoiceType =@InvoiceType
		And InHd.IsApproved = Cast(0 as bit)
		And Convert(Char(10),InHd.InvoiceDate,120) >=Convert(char(10),@DateFrom,120)
		And Convert(Char(10),InHd.InvoiceDate,120) <=Convert(char(10),@DateTo,120)
		And DateDiff("D",InHd.InvoiceDate,GetDAte()) >=
			Case 
			When @PendingPayment=CAST(0 as bit) Then 0
			Else 
				ISNULL(C.CreditTerm,0)
			End
		And InHd.CustomerCode = ISNULL(@CustomerCode,InHd.CustomerCode)		


	End
	Select * From @tbl


END

GO
 


 

IF OBJECT_ID('[Operation].[usp_GetInvoiceNoByOrderNo]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GetInvoiceNoByOrderNo] 
END 
GO
CREATE PROC [Operation].[usp_GetInvoiceNoByOrderNo] 
@OrderNo varchar(50)  
AS 
BEGIN 
Select Top(1) InvoiceNo From 
Operation.InvoiceDetail
Where OrderNo = @OrderNo

END

GO
 