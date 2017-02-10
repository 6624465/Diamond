
-- ========================================================================================================================================
-- START											 [Report].[usp_ShipmentSchedule]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [PurchaseOrderHistory] Record based on [PurchaseOrderHistory] table
-- ========================================================================================================================================


IF OBJECT_ID('[Report].[usp_ShipmentSchedule]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_ShipmentSchedule] 
END 
GO
CREATE PROC [Report].[usp_ShipmentSchedule] 
    @DocumentNo VARCHAR(50),
    @DateFrom datetime = null,
	@DateTo datetime = null
AS 
 

BEGIN

	if @DocumentNo =''
		Set @DocumentNo=null

	SELECT	Hd.[TransactionType], Hd.[TransactionID], Hd.[PONo], Hd.[TransactionDate], Hd.[PODate], Hd.[SupplierCode], Hd.[ShipmentDate], 
			Hd.[ReceiveDate], Hd.[EstimateDate], Hd.[ReferenceNo], Hd.[Buyer], Hd.[PRNo], Hd.[IncoTerms],Hd.Remarks, 
			Dt.ProductCode,ISNULL(Prd.Description,'') As ProductDescription,Cs.CustomerName,
			Dt.Quantity,Dt.UnitPrice
	FROM	[Operation].[PurchaseOrderHistory] Hd
	left Outer Join Operation.PurchaseOrderDetail Dt On 
		Hd.PONo = Dt.PONo
	Left Outer Join master.Customer Cs On 
		Hd.SupplierCode = Cs.CustomerCode	
	Left Outer Join Master.Product Prd On
		Dt.ProductCode = Prd.ProductCode
	WHERE	Hd.[PONo] = ISNULL(@DocumentNo, Hd.[PONo])
			And Convert(char(10),Hd.PODate,120) >= Convert(char(10),ISNULL(@DateFrom,GetDate()),120) 
			And Convert(char(10),Hd.PODate,120) <= Convert(char(10),ISNULL(@DateTo,GetDate()),120) 

END
-- ========================================================================================================================================
-- END  											 [Report].[usp_ShipmentSchedule]
-- ========================================================================================================================================

GO
