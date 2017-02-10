
IF OBJECT_ID('[Operation].[udf_GetProductSuppliers]') IS NOT NULL
BEGIN 
    DROP function [Operation].[udf_GetProductSuppliers] 
END 
GO
Create function [Operation].[udf_GetProductSuppliers]
(
	@ProductCode nvarchar(50)
	
)
RETURNS NVarchar(500)  AS
Begin

		Declare @value nvarchar(500)=''

	SELECT  @value +=  Cst.CustomerName + ',' 
	FROM Operation.StockInDetail SkDt
	Left Outer Join Operation.StockInHeader SkHd On
		SkDt.DocumentNo = SkHd.DocumentNo
	Left Outer Join Master.Customer Cst On 
		SkHd.CustomerCode = Cst.CustomerCode	 
	where SkDt.ProductCode = @ProductCode
	Group By skhd.CustomerCode,Cst.CustomerName
	
	IF LEN(@value)>1	
		select @value= SUBSTRING(@value,1,LEN(@value)-1)
	Else
		Select @value=''
	
	Return  @value

End


 
GO


