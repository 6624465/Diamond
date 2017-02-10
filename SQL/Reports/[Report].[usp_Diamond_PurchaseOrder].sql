 

/* 
=======================================================================
 START		[Report].[usp_Diamond_PurchaseOrder]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Daily Sales Report

Exec [Report].[usp_Diamond_PurchaseOrder] '1610002',70

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_Diamond_PurchaseOrder]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_Diamond_PurchaseOrder]
END 
GO
CREATE PROC [Report].[usp_Diamond_PurchaseOrder]
    @PONo varchar(50), 
	@BranchID smallint 
AS 
BEGIN 

	;With PaymentTypeDescription As (Select LookupCode,Description from Config.Lookup Where Category ='PAYMENTTYPE')
	Select Hd.PONo,Hd.PODate,Cs.CustomerName,Ad.address1,Ad.address2,Ad.address3,Ad.address4,Ad.CityName,Ad.ZipCode,Ad.TelNo,Ad.FaxNo,
	Hd.TotalAmount,Hd.VATAmount,Hd.NetAmount,
	Dt.ProductCode,Pr.Description,dt.Quantity,dt.UnitPrice,(dt.UnitPrice * dt.Quantity) As UnitAmount ,Hd.ReceiveDate,Hd.EstimateDate,Br.BranchName,
	Ad2.Address1 As BranchAddress1,Ad2.Address2 As BranchAddress2,Ad2.Address3 As BranchAddress3,Ad2.Address4 As BranchAddress4,
	ad2.TelNo As BranchTelNo,Ad2.FaxNo As BranchFaxNo,Br.BranchCode,Ad2.Email As BranchEmail,
	Dt.UOM,Dt.CurrencyCode,Cr.Description As CurrencyDescription,
	Case 
		When Hd.VATAmount>0 Then 'VAT 7%'
		Else 'NO VAT'
	End As VAT,
	ISNULL(Ptm.Description,'') As PaymentTypeDescription
	From Operation.PurchaseOrderHeader Hd
	Left Outer Join Operation.PurchaseOrderDetail Dt ON 
		Hd.PONo = Dt.PONo
	Left Outer Join Master.Customer Cs On 
		Hd.SupplierCode = Cs.CustomerCode 
	Left Outer Join master.Address Ad On 
		Cs.CustomerCode = Ad.AddressLinkID
	Left Outer Join Master.Product Pr On 
		Dt.ProductCode = Pr.ProductCode
	Left Outer Join master.Branch Br On 
		Hd.BranchID = Br.BranchID
	Left Outer Join Master.Address Ad2 On 
		Br.BranchCode = Ad2.AddressLinkID
	Left Outer Join master.Currency Cr On 
		Dt.CurrencyCode = Cr.CurrencyCode
	Left Outer Join PaymentTypeDescription Ptm ON
		Hd.PaymentTerm = Ptm.LookupCode
	Where Hd.BranchID = @BranchID
	And Hd.PONo = ISNULL(@PONo,Hd.PONo)

End