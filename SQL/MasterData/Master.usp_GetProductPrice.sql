 
/****** Object:  StoredProcedure [Master].[usp_GetProductPrice]    Script Date: 25-04-2016 23:45:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [Master].[usp_GetProductPrice] 
    @CustomerCode nvarchar(50),
    @ProductBarCode nvarchar(50),
	@BranchID smallint
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
	,ISNULL(Prd.Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription,QC.CurrencyCode 
	From Master.Product Prd
	Left Outer Join Master.Quotationview QC ON
		QC.CustomerCode = @CustomerCode
		AND QC.ProductCode = Prd.ProductCode
		AND Convert(char(10),QC.EffectiveDate,120) <= Convert(char(10),GETDATE(),120)
		AND Convert(char(10),QC.ExpiryDate,120) >= Convert(char(10),GETDATE(),120)
		And Qc.Status=CAST(1 as bit)
		And Qc.BranchID = ISNULL(@BranchID,Qc.BranchID)
	Left Outer Join Master.StandardQuotationview ST ON
		ST.ProductCode = Prd.ProductCode
		And St.BranchID = ISNULL(@BranchID,Qc.BranchID)
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode
	Where 
		Prd.ProductCode = @ProductBarCode


END
