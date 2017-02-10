
/* 
=======================================================================
 START		[Master].[usp_GetProductPrice]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[usp_GetPOBySupplierCode] Table

 

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_GetPOBySupplierCode]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GetPOBySupplierCode] 
END 
GO
CREATE PROC [Operation].[usp_GetPOBySupplierCode] 
    @PONo varchar(50),
    @SupplierCode varchar(50)
AS 
BEGIN 


Select ItemNo, ProductCode,'' As BarCode, Quantity,Hd.CreatedBy,Hd.CreatedOn,Hd.ModifiedBy, Hd.ModifiedOn
From Operation.PurchaseOrderHeader Hd
Left Outer Join Operation.PurchaseOrderDetail Dt ON 
Hd.PONo=Dt.PONo
Where Hd.PONo = @PONo
And Hd.SupplierCode = @SupplierCode


END
GO

/* 
=======================================================================
 END		[Operation].[usp_GetPOBySupplierCode]
=======================================================================
*/
