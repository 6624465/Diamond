-- exec [Operation].[usp_UnbilledInvoices] 'CASH','2015-06-01','2015-06-10',1,0

--exec [Operation].[usp_UnbilledInvoices] @CustomerCode='CASH',@DateFrom='2015-06-01 00:00:00',@DateTo='2015-06-16 00:00:00',@OverDue=1,@PaymentDays=0


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