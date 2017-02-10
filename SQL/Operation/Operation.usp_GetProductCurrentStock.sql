
/* 
=======================================================================
 START		[Operation].[usp_GetProductCurrentStock]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[StockLedger] Table

=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_GetProductCurrentStock]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_GetProductCurrentStock] 
END 
GO
CREATE PROC [Operation].[usp_GetProductCurrentStock] 
     
    @ProductCode nvarchar(50)
	 
    
AS 
BEGIN 

	 Select ISNULL(SUM(Quantity*StockFlag),0)
	 From Operation.StockLedger
	 Where ProductCode	= @ProductCode
	       
END
GO

/* 
=======================================================================
 END		[Operation].[usp_GetProductCurrentStock]
=======================================================================
*/
