
-- ========================================================================================================================================
-- START											 [Report].[usp_GoodsReceiveDomesticDetail]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceiveDetail] Record based on [GoodsReceiveDetail] table
-- ========================================================================================================================================


IF OBJECT_ID('[Report].[usp_GoodsReceiveDomesticDetail]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_GoodsReceiveDomesticDetail] 
END 
GO
CREATE PROC [Report].[usp_GoodsReceiveDomesticDetail] 
    @DocumentNo VARCHAR(50) 
AS 
 

BEGIN

	SELECT	Dt.[DocumentNo], Dt.[ProductCode], Dt.[UOM], Dt.[IsCovered], Dt.[CoverRemarks], Dt.[IsSorted], Dt.[SortedRemarks], Dt.[IsHumidity], Dt.[IsSameAsPhoto], 
			Dt.[IsClean], Dt.[IsCompressed], Dt.[IsCorrectWeight], Dt.[Qty],Dt.[PalletQty],Dt.PalletUOM, 
			Dt.[CreatedBy], Dt.[CreatedOn], Dt.[ModifiedBy], Dt.[ModifiedOn], Dt.[Status] ,
			Br.BranchName , pr.Description As ProductName,cs.CustomerName As SupplierName,Hd.DocumentDate
	FROM	[Operation].[GoodsReceiveDetail] Dt 
	Left Outer Join Operation.GoodsReceiveHeader Hd On 
		Hd.DocumentNo = Dt.DocumentNo
	Left Outer Join master.Branch Br On 
		hd.BranchID = br.BranchID
	Left Outer Join Master.Product Pr On 
		Pr.ProductCode = dt.ProductCode 
	Left Outer Join master.Customer Cs ON
		cs.CustomerCode = hd.SupplierCode
	WHERE	Hd.[DocumentNo] = @DocumentNo 
			 

END
-- ========================================================================================================================================
-- END  											 [Report].[usp_GoodsReceiveDomesticDetail]
-- ========================================================================================================================================

GO