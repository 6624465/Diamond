
-- ========================================================================================================================================
-- START											 [Report].[usp_InspectionDomestic]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [InspectionDomestic] Record based on [InspectionDomestic] table
-- ========================================================================================================================================


IF OBJECT_ID('[Report].[usp_InspectionDomestic]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_InspectionDomestic] 
END 
GO
CREATE PROC [Report].[usp_InspectionDomestic] 
    @DocumentNo VARCHAR(50) 
AS 
 

BEGIN

	SELECT	Dt.[DocumentNo], Dt.[ProductCode], Dt.[InspectionDate], Dt.[InspectedBy], Dt.[BatchNo], Dt.[Qty], Dt.[UOM], Dt.[BagNo], Dt.[BagWeight], Dt.[Color], Dt.[MeltingMinute], 
			Dt.[IsMeltAll], Dt.[IsClean], Dt.[PHLevel], Dt.[Remarks], Prd.Description As ProductName
	FROM	[Operation].[InspectionDomestic] Dt
	Left Outer Join Operation.GoodsReceiveHeader Hd ON 
		Dt.DocumentNo = Hd.DocumentNo
	Left Outer Join master.Product Prd On 
		Prd.ProductCode = Dt.ProductCode
	WHERE	Hd.[DocumentNo] = @DocumentNo  
			

END
-- ========================================================================================================================================
-- END  											 [Report].[usp_InspectionDomestic]
-- ========================================================================================================================================

GO
