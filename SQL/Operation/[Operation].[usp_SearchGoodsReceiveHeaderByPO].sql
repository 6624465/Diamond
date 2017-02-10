
 
-- ========================================================================================================================================
-- START											 [Operation].[usp_SearchGoodsReceiveHeaderByPO]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceivePODetail] Record based on [GoodsReceivePODetail] table

-- EXEC [Operation].[usp_SearchGoodsReceiveHeaderByPO] '1607001'
-- ========================================================================================================================================


IF OBJECT_ID('[Operation].[usp_SearchGoodsReceiveHeaderByPO]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_SearchGoodsReceiveHeaderByPO] 
END 
GO
CREATE PROC [Operation].[usp_SearchGoodsReceiveHeaderByPO] 
    @PONo VARCHAR(50)
AS 
 

BEGIN

SELECT	'' As DocumentNo,  [BranchID], GETUTCDATE() As DocumentDate, '' As DocumentType,  [SupplierCode], 
			 [PONo], 1 As Status, 0 As  [IsApproved], '' As  [ApprovedBy], GETUTCDATE() As [ApprovedOn], 
			 Hd.[CreatedBy],  Hd.[CreatedOn],  Hd.[ModifiedBy], Hd.[ModifiedOn],
			ISNULL(Cus.CustomerName,'') As SupplierName
	FROM	[Operation].PurchaseOrderHeader Hd  
	LEFT OUTER JOIN Master.Customer Cus ON 
		Hd.SupplierCode = Cus.CustomerCode 
	WHERE	PONo = @PONo 
			 

END
-- ========================================================================================================================================
-- END  											 [Operation].[usp_SearchGoodsReceiveHeaderByPO]
-- ========================================================================================================================================

GO


