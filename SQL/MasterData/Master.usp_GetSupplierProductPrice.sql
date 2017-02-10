
/* 
=======================================================================
 START		[Master].[usp_GetSupplierProductPrice]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[QuotationItem] Table

Exec [Master].[usp_GetSupplierProductPrice] 'SUPPLY1','CHEM1'

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_GetSupplierProductPrice]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_GetSupplierProductPrice] 
END 
GO
CREATE PROC [Master].[usp_GetSupplierProductPrice] 
    @SupplierCode nvarchar(50),
    @ProductBarCode nvarchar(50)
AS 
BEGIN 

	Select ISNULL(QC.[QuotationNo],'') As QuotationNo, ISNULL(QC.[ItemID],0) As ItemID, Prd.[ProductCode], Prd.[BarCode], ISNULL(QC.[SellRate],0) as SellRate, 
	1 as Status, Prd.[CreatedBy], Prd.[CreatedOn], 
			Prd.[ModifiedBy], Prd.[ModifiedOn] ,ISNULL(Prd.Description,'') As ProductDescription,0 As RecordStatus,QC.CurrencyCode 
	
	From Master.Product Prd
	Left Outer Join Master.Quotationview QC ON
		QC.CustomerCode = @SupplierCode
		AND QC.ProductCode = Prd.ProductCode
		AND Convert(char(10),QC.EffectiveDate,120) <= Convert(char(10),GETDATE(),120)
		AND Convert(char(10),QC.ExpiryDate,120) >= Convert(char(10),GETDATE(),120)
		
	Where 
		Prd.ProductCode = @ProductBarCode


END
GO

/* 
=======================================================================
 END		[Master].[usp_GetSupplierProductPrice]
=======================================================================
*/

