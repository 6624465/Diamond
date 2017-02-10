
/* 
=======================================================================
 START		[Master].[usp_GetSupplierProductQuotation]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[QuotationItem] Table

Exec [Master].[usp_GetSupplierProductQuotation] NULL,N'?001-00001-00/SCA'

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_GetSupplierProductQuotation]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_GetSupplierProductQuotation] 
END 
GO
CREATE PROC [Master].[usp_GetSupplierProductQuotation] 
    @SupplierCode nvarchar(50),
    @ProductCode nvarchar(50)
AS 
BEGIN 

	Select COALESCE(QC.[QuotationNo],ST.QuotationNo) As QuotationNo,
			COALESCE(QC.[ItemID],ST.[ItemID]) As [ItemID], COALESCE(QC.[ProductCode],ST.[ProductCode]) As [ProductCode], 
			COALESCE(QC.[BarCode],ST.[BarCode]) AS [BarCode], COALESCE(QC.[SellRate],ST.[SellRate]) As [SellRate], 
			COALESCE(QC.[Status],ST.[Status]) As [Status], COALESCE(QC.[CreatedBy],ST.[CreatedBy]) As [CreatedBy], 
			COALESCE(QC.[CreatedOn], ST.[CreatedOn]) As [CreatedOn], COALESCE(QC.[ModifiedBy],ST.[ModifiedBy]) As [ModifiedBy], 
			COALESCE(QC.[ModifiedOn],ST.[ModifiedOn]) As [ModifiedOn], ISNULL(Prd.Description,'') As ProductDescription,QC.CurrencyCode
	From Master.Product Prd
	Left Outer Join Master.Quotationview QC ON
		QC.CustomerCode = @SupplierCode
		AND QC.ProductCode = Prd.ProductCode
		AND Convert(char(10),QC.EffectiveDate,120) <= Convert(char(10),GETDATE(),120)
		AND Convert(char(10),QC.ExpiryDate,120) >= Convert(char(10),GETDATE(),120)
	Left Outer Join Master.[STANDARDQuotationView] ST ON
		ST.ProductCode = Prd.ProductCode
	Where 
		Prd.ProductCode = @ProductCode


END
GO

/* 
=======================================================================
 END		[Master].[usp_GetSupplierProductQuotation]
=======================================================================
*/
