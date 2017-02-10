
/****** Object:  UserDefinedFunction [Operation].[udf_GetProductHighestCostPrice]    Script Date: 19/05/2016 17:59:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create function [Master].[udf_FullAddress]
(
	@AddressLinkID nvarchar(50)
	
)
RETURNS nvarchar(max)  AS
Begin

	Declare @value nvarchar(max)=N''

Select @value= CONCAT(
Address1 , 
Case When LEN(ISNULL(Address2,'')) =0 	Then '' 	Else ',' End,
ISNULL(Address2,'') , Case When LEN(ISNULL(CityName,''))=0  Then '' 	Else ',' End,
ISNULL(CityName,'') , Case When LEN(ISNULL(Statename,''))=0  Then '' 	Else ',' End,
ISNULL(Statename,'') , Case When LEN(ISNULL(Zipcode,''))=0  Then '' 	Else ',' End,
ISNULL(Zipcode,'')	 , Case When LEN(ISNULL(C.CountryName,''))=0  Then '' 	Else ',' End,	  
ISNULL(C.CountryName,'')) 
From master.Address Ad
Left Outer Join Master.Country C on 
ad.CountryCode = C.CountryCode
where AddressLinkID = @AddressLinkID

 
	Return  @value

End


 

