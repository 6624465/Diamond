 /*
=======================================================================
 START		[Report].[usp_InvoiceCashBillByOrder]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[InvoiceHeader] Table

Exec [Report].[usp_InvoiceCashBillByOrder] 'INV151100005'

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_InvoiceCashBillByOrder]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_InvoiceCashBillByOrder]
END 
GO
CREATE  PROC [Report].[usp_InvoiceCashBillByOrder]
    @OrderNo varchar(50)
AS 
BEGIN 
	SELECT InHd.[InvoiceNo], InHd.[InvoiceDate], InHd.[CustomerCode], InHd.[InvoiceType], 
	InHd.[InvoiceAmount], InHd.[TaxAmount], InHd.[TotalAmount], 
	InHd.[PaymentDate], OrdDt.SellRate As Price, OrdDt.Quantity,(OrdDt.SellRate * OrdDt.Quantity) As Amount,
	Indt.Price As ItemTotalAmount,
	Convert(decimal(18,2),OrdDt.DiscountAmount) As DiscountAmount, 
	ISNULL(Cus.CustomerName,'') As CustomerName , ISNULL(Cus.RegistrationNo,'') As RegistrationNo,
	ISNULL(Adr.Address1,'') As Address1, ISNULL(Adr.Address2,'') As Address2, ISNULL(Adr.Address3,'') As Address3, ISNULL(Adr.Address4,'') As Address4,
	ISNULL(Adr.TelNo,'') As TelNo,Prd.UOM,
	OrdDt.ProductCode, prd.Description As ProductDescription,'' As TransporterName,OrHd.CreatedBy As UserID,
	ISNULL(OrHd.Remarks,'') As Remarks

	,0 as Discount, 0 As VATAmount,Orhd.PaidAmount As NetAmount , (Orhd.PaidAmount) As TotalAfterDiscount,OrHd.TotalAMount as OrderTotalAmount, OrdDt.DiscountType,
	0 As VATPercent
	FROM   Operation.OrderHeader OrHd 
	Left Outer Join [Operation].OrderDetail OrdDt ON
		OrHd.OrderNo = OrdDt.OrderNo
	Left Outer Join [Operation].[InvoiceDetail] InDt ON 
		InDt.OrderNo = OrdDt.OrderNo
		And Indt.ItemNo = OrdDt.ItemNo
	Left Outer Join [Operation].[InvoiceHeader] InHd ON
		InHd.InvoiceNo = InDt.InvoiceNo
	Left Outer Join Master.Product Prd ON
		OrdDt.ProductCode = Prd.ProductCode
	Left Outer Join [Master].[Customer] Cus ON
		Cus.CustomerCode = Orhd.CustomerCode
	Left Outer Join [Master].Address Adr ON 
		Adr.AddressLinkID = Cus.AddressID
		And Adr.AddressType ='Customer'
	WHERE  orHd.[OrderNo] = @OrderNo  
	
END

