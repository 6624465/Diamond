
IF OBJECT_ID('[Operation].[udf_GetProductHighestCostPrice]') IS NOT NULL
BEGIN 
    DROP function [Operation].[udf_GetProductHighestCostPrice] 
END 
GO
Create function [Operation].[udf_GetProductHighestCostPrice]
(
	@ProductCode nvarchar(50)
	
)
RETURNS decimal(18,2)  AS
Begin

	Declare @value decimal(18,2)=0

	SELECT @value = ISNULL(Max(BuyingPrice),0)   
	FROM Operation.StockInDetail SkDt
	where SkDt.ProductCode = @ProductCode
 
	
	 
	
	Return  @value

End


 
GO

 