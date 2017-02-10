
/*
=======================================================================
START		[Operation].[usp_PurchaseOrderBySupplier]
=======================================================================
Author:		Sudarshan
Create date:	2015-06-13
Description:	List All Data From [Operation].[PurchaseOrderHeader] Table based on the supplier Code


Exec [Operation].[usp_PurchaseOrderBySupplier] 'A00001'

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_PurchaseOrderBySupplier]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_PurchaseOrderBySupplier] 
END 
GO
CREATE PROC [Operation].[usp_PurchaseOrderBySupplier] 
	@SupplierCode varchar(50)
AS 
BEGIN 

	SELECT	Hd.[PONo], Hd.[PODate], Hd.[SupplierCode], Hd.[POStatus], Hd.[IsCancel], 
			Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn],
			ISNULL(S.CustomerName,'') As SupplierName,Hd.TotalAmount,Hd.IsVAT,hd.VATAmount,Hd.NetAmount
	FROM	[Operation].[PurchaseOrderHeader] Hd
	Left Outer Join [Master].[Customer] S ON 
		Hd.SupplierCode = S.CustomerCode
	Where Hd.SupplierCode = @SupplierCode
	And Hd.IsCancel = CAST(0 as bit)
 
END
GO
/* 
=======================================================================
 END		[Operation].[usp_PurchaseOrderBySupplier]
=======================================================================
*/