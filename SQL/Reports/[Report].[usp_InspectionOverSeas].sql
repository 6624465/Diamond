
-- ========================================================================================================================================
-- START											 [Report].[usp_InspectionOverSeas]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [InspectionOverSeas] Record based on [InspectionOverSeas] table
-- ========================================================================================================================================


IF OBJECT_ID('[Report].[usp_InspectionOverSeas]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_InspectionOverSeas] 
END 
GO
CREATE PROC [Report].[usp_InspectionOverSeas] 
    @DocumentNo VARCHAR(50)
AS 
 

BEGIN

	SELECT	Dt.[DocumentNo], Dt.[ProductCode], Dt.[ChemicalName], Dt.[ReceivedDate], Dt.[InspectionDate], Dt.[InspectionQty], Dt.[IsRequireLabour], Dt.[InvoiceNo], Dt.[IsGetCOA], 
			Dt.[COASupplier],Dt.[PINumber], Dt.[IsGetAllItem], Dt.[MissingItem], Dt.[IsGetCOABatchNo], Dt.[COABatchNo], Dt.[IsCOAManufactureDate], Dt.[IsCOAExpiryDate], 
			Dt.[TestResult], Dt.[FailedItem], Dt.[InspectionResult], Dt.[Manufacturer], Dt.[ContainerNo], Dt.[SizeType], Dt.[ChemicalReceiveBatchNo], Dt.[BatchNo], 
			Dt.[Homogenious], Dt.[IsLabelOK], Dt.[IsColorOK], Dt.[IsWet], Dt.[ChemicalCondition], Dt.[ContaminationRemarks], Dt.[AcceptStatus], Dt.[AcceptRemarks], 
			Dt.[BagWeight], Dt.[BagCondition], Dt.[PreparedBy], Dt.[PreparedOn], Dt.[CheckedBy], Dt.[CheckedOn], Dt.[ApprovedBy], Dt.[ApprovedOn] ,
			Prd.Description As ProductName,Cst.CustomerName As SupplierName
	FROM	[Operation].[InspectionOverSeas] Dt
	
	Left Outer Join Operation.GoodsReceiveHeader Hd ON 
		Dt.DocumentNo = Hd.DocumentNo
	Left Outer Join master.Product Prd On 
		Prd.ProductCode = Dt.ProductCode
	Left Outer Join Master.Customer Cst On 
		Hd.SupplierCode = Cst.CustomerCode
	
	WHERE	Hd.[DocumentNo] = @DocumentNo
	 
			

END
-- ========================================================================================================================================
-- END  											 [Report].[usp_InspectionOverSeas]
-- ========================================================================================================================================

GO
