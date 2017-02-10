

/* 
=======================================================================
 START		[Report].[usp_InvoiceCashBill_Original]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[InvoiceHeader] Table

Exec [Report].[usp_InvoiceCashBill_Original] 'INV150600001'

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_InvoiceCashBill_Original]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_InvoiceCashBill_Original]
END 
GO
CREATE PROC [Report].[usp_InvoiceCashBill_Original]
    @InvoiceNo varchar(50)
AS 
BEGIN 
	SELECT InHd.[InvoiceNo], InHd.[InvoiceDate], InHd.[CustomerCode], InHd.[InvoiceType], InHd.[InvoiceAmount], InHd.[TaxAmount], InHd.[TotalAmount], 
	InHd.[PaymentDate], Indt.Price, Indt.Quantity,(Indt.Price * indt.Quantity) As Amount,
	ISNULL(Cus.CustomerName,'') As CustomerName , ISNULL(Cus.RegistrationNo,'') As RegistrationNo,
	ISNULL(Adr.Address1,'') As Address1, ISNULL(Adr.Address2,'') As Address2, ISNULL(Adr.Address3,'') As Address3, ISNULL(Adr.Address4,'') As Address4,
	OrdDt.ProductCode, prd.Description As ProductDescription
	FROM   [Operation].[InvoiceHeader] InHd
	Left Outer Join [Operation].[InvoiceDetail] InDt ON 
		InHd.InvoiceNo = InDt.InvoiceNo
	Left Outer Join [Operation].OrderDetail OrdDt ON
		InDt.OrderNo = OrdDt.OrderNo
		And Indt.ItemNo = OrdDt.ItemNo
	Left Outer Join Master.Product Prd ON
		OrdDt.ProductCode = Prd.ProductCode
	Left Outer Join [Master].[Customer] Cus ON
		Cus.CustomerCode = Inhd.CustomerCode
	Left Outer Join [Master].Address Adr ON 
		Adr.AddressLinkID = Cus.AddressID
		And Adr.AddressType ='Customer'
	WHERE  InHd.[InvoiceNo] = @InvoiceNo 
END
GO

/* 
=======================================================================
 END		[Report].[usp_InvoiceCashBill]
=======================================================================
*/

