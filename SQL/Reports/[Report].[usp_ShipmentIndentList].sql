
-- ========================================================================================================================================
-- START											 [Report].[usp_ShipmentIndentList]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceiveDetail] Record based on [GoodsReceiveDetail] table

--Exec [Report].[usp_ShipmentIndentList] '','2016-08-01','2016-11-19'

-- ========================================================================================================================================


IF OBJECT_ID('[Report].[usp_ShipmentIndentList]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_ShipmentIndentList] 
END 
GO
CREATE PROC [Report].[usp_ShipmentIndentList] 
    @DocumentNo VARCHAR(50),
	@DateFrom datetime = null,
	@DateTo datetime = null
AS 
 

BEGIN

	if @DocumentNo =''
		Set @DocumentNo=null

	;With PaymentTypeLookup as (Select LookupCode,Description From Config.Lookup Where Category='PaymentType')
	Select Hd.TransactionType, Hd.DocumentDate As IssueDate, Hd.CustomerCode,Hd.SupplierPI,hd.CustomerPO,Dt.ProductCode,Dt.Quantity,Dt.UnitPrice,Hd.SupplierCode,hd.PaymentTerm,
	hd.TTDate,'' As TTAction,hd.ConfirmETD,'' As ETDAction,Hd.ETD,Hd.IsOriginalDoc,'' As Action,hd.ConfirmETA,hd.ETA,hd.Remark ,Hd.POL,
	ISNULL(Prd.Description,'') As ProductDescription,Hd.DocumentDate,
	ISNULL(Sp.CustomerName,'') As SupplierName,
	ISNULL(Cs.CustomerName,'') As CustomerName,
	ISNULL(PT.Description,'') As PaymentTermDescription,
	Hd.DocumentNo
	From Operation.SIHeaderHistory Hd
	left Outer Join Operation.SIDetail Dt On 
		Hd.DocumentNo = Dt.DocumentNo
	Left Outer Join master.Customer Sp On 
		Hd.SupplierCode = Sp.CustomerCode	
	Left Outer Join master.Customer Cs On 
		Hd.CustomerCode = Cs.CustomerCode	
	Left Outer Join PaymentTypeLookup PT On
		Hd.PaymentTerm = PT.LookupCode
	Left Outer Join Master.Product Prd On
		Dt.ProductCode = Prd.ProductCode		 
	Where Hd.DocumentNo = ISNULL(@DocumentNo, Hd.DocumentNo)
	And Convert(char(10),Hd.DocumentDate,120) >= Convert(char(10),ISNULL(@DateFrom,GetDate()),120) 
	And Convert(char(10),Hd.DocumentDate,120) <= Convert(char(10),ISNULL(@DateTo,GetDate()),120) 


END
-- ========================================================================================================================================
-- END  											 [Report].[usp_ShipmentIndentList]
-- ========================================================================================================================================

GO