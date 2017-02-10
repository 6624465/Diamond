
-- ========================================================================================================================================
-- START											 [Report].[usp_GoodsReceiveDetailsOverseasDetail]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceiveDetailsOverseas] Record based on [GoodsReceiveDetailsOverseas] table
-- ========================================================================================================================================


IF OBJECT_ID('[Report].[usp_GoodsReceiveDetailsOverseasDetail]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_GoodsReceiveDetailsOverseasDetail] 
END 
GO
CREATE PROC [Report].[usp_GoodsReceiveDetailsOverseasDetail] 
    @DocumentNo VARCHAR(50) 
     
AS 
 

BEGIN

	SELECT	 Dt.[DocumentNo],  Dt.[ProductCode], [Quantity],  Dt.[UOM], [ContainerNo], [ContainerCondition], [DamageDetails], [SealCondition], [SealNo], [IsSort], 
			[SortRemarks], [IsFCL], [IsHumidity], [IsProperPackage], [IsClean], [IsCompressed], [IsCorrectWeight], [QtyPerUOM], [IsProductLabel], 
			[IsInspectContainer],  Hd.DocumentDate,
			Br.BranchName , pr.Description As ProductName,cs.CustomerName As SupplierName
	FROM	[Operation].[GoodsReceiveDetailsOverseas] Dt  
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
-- END  											 [Report].[usp_GoodsReceiveDetailsOverseasDetail]
-- ========================================================================================================================================

GO