
/* 
=======================================================================
 START		[Master].[usp_GetProductPrice]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[QuotationItem] Table

Exec [Master].[usp_GetProductPrice] '','003'

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_GetProductPrice]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_GetProductPrice] 
END 
GO
CREATE PROC [Master].[usp_GetProductPrice] 
    @CustomerCode nvarchar(50),
    @ProductBarCode nvarchar(50)
AS 
BEGIN 

	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	Select '' As OrderNo, 0 As ItemNo,Prd.ProductCode, Prd.BarCode,1 As Quantity,COALESCE(QC.SellRate,ST.SellRate) As SellRate,
	COALESCE(QC.SellRate,ST.SellRate) As SellPrice,
	COALESCE(QC.QuotationNo,ST.QuotationNo) As MatchQuotation,'' As DiscountType,0 As DiscountRate,0 As DiscountAmount,0 As AdjustAmount,0 As PartialPayment,
	Prd.CreatedBy,Prd.CreatedOn,Prd.ModifiedBy,Prd.ModifiedOn,ISNULL(Prd.Description,'') As ProductDescription,0 As Cost
	,ISNULL(Prd.Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription
	From Master.Product Prd
	Left Outer Join Master.Quotationview QC ON
		QC.CustomerCode = @CustomerCode
		AND QC.ProductCode = Prd.ProductCode
		AND Convert(char(10),QC.EffectiveDate,120) <= Convert(char(10),GETDATE(),120)
		AND Convert(char(10),QC.ExpiryDate,120) >= Convert(char(10),GETDATE(),120)
		And Qc.Status=CAST(1 as bit)
	Left Outer Join Master.StandardQuotationview ST ON
		ST.ProductCode = Prd.ProductCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	Where 
		Prd.ProductCode = @ProductBarCode


END
GO

/* 
=======================================================================
 END		[Master].[usp_GetProductPrice]
=======================================================================
*/
