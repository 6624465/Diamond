 

/* 
=======================================================================
 START		[Report].[usp_Diamond_Quotation]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Daily Sales Report

Exec [Report].[usp_Diamond_Quotation] 'QDM01160400001',70

=======================================================================
*/

IF OBJECT_ID('[Report].[usp_Diamond_Quotation]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_Diamond_Quotation]
END 
GO
CREATE PROC [Report].[usp_Diamond_Quotation]
    @QuotationNo varchar(50), 
	@BranchID smallint 
AS 
BEGIN 

	Select Hd.QuotationNo,hd.QuotationDate,hd.CustomerCode,Cs.CustomerName,Ad.address1,Ad.address2,Ad.address3,Ad.address4,Ad.CityName,Ad.ZipCode,Ad.TelNo,Ad.FaxNo,
	Hd.ProductCode,Pr.Description,Hd.ItemID,hd.SellRate,Br.BranchName,br.BranchCode,
	Ad2.Address1 As BranchAddress1,Ad2.Address2 As BranchAddress2,Ad2.Address3 As BranchAddress3,Ad2.Address4 As BranchAddress4,
	ad2.TelNo As BranchTelNo,Ad2.FaxNo As BranchFaxNo
	From Master.QuotationView Hd
	Left Outer Join Master.Customer Cs On 
		Hd.CustomerCode= Cs.CustomerCode 
	Left Outer Join master.Address Ad On 
		Cs.CustomerCode = Ad.AddressLinkID
	Left Outer Join Master.Product Pr On 
		Hd.ProductCode = Pr.ProductCode
	Left Outer Join master.Branch Br On 
		Hd.BranchID = Br.BranchID
	Left Outer Join Master.Address Ad2 On 
		Br.BranchCode = Ad2.AddressLinkID
	Where Hd.BranchID = @BranchID
	And Hd.QuotationNo =  ISNULL(@QuotationNo,Hd.QuotationNo)

End

 