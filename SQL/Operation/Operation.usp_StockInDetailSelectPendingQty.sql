
/* 
=======================================================================
 START		[Operation].[usp_StockInDetailSelectPendingQty]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Operation].[StockInDetail] Table


-- Exec [Operation].[usp_StockInDetailSelectPendingQty] 'P151000001'
=======================================================================
*/

IF OBJECT_ID('[Operation].[usp_StockInDetailSelectPendingQty]') IS NOT NULL
BEGIN 
    DROP PROC [Operation].[usp_StockInDetailSelectPendingQty] 
END 
GO
CREATE PROC [Operation].[usp_StockInDetailSelectPendingQty] 
    @ProductCode varchar(50),
	@Qty float
AS 
BEGIN 

/*
	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	SELECT	Dt.[DocumentNo], Dt.[ItemNo], Dt.[ProductCode], Dt.[BarCode], Dt.[Quantity], Dt.[CreatedBy], Dt.[CreatedOn], 
			Dt.[ModifiedBy], Dt.[ModifiedOn] ,dt.Quantity As POQty,0 As PendingQty ,
			ISNULL(Prd.Description,'') As ProductDescription,Dt.BuyingPrice,(Dt.Quantity * Dt.BuyingPrice) As BuyingAmount,Dt.OutQuantity,
			ISNULL(Prd.Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription
	FROM   [Operation].[StockInDetail] Dt
	Left Outer Join [Master].[Product] Prd ON 
		Dt.ProductCode = Prd.ProductCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode

	WHERE  Dt.[ProductCode] = @ProductCode 
		And (Quantity - OutQuantity) > 0
	Order By CreatedOn
*/

	Declare @tbl table

		(item int primary key identity(1,1), DocumentNo varchar(50),ItemNo int,ProductCode nvarchar(100),BarCode varchar(50),Quantity int,CreatedBy varchar(25), CreatedOn datetime,
		ModifiedBy varchar(50),ModifiedOn datetime,POQty int, PendingQty int,ProductDescription nvarchar(200),BuyingPrice decimal(18,2), 
		BuyingAmount decimal(18,2), OutQuantity int,Location nvarchar(50),LocationDescription nvarchar(200),RecordStatus smallint)


	;WITH 	WHLocation As (
	Select LookupCode,Description 
	From Config.Lookup
	Where Category='LOCATION')
	insert into @tbl
	SELECT	Dt.[DocumentNo], Dt.[ItemNo], Dt.[ProductCode], Dt.[BarCode], Dt.[Quantity], Dt.[CreatedBy], Dt.[CreatedOn], 
			Dt.[ModifiedBy], Dt.[ModifiedOn] ,dt.Quantity As POQty,0 As PendingQty ,
			ISNULL(Prd.Description,'') As ProductDescription,Dt.BuyingPrice,(Dt.Quantity * Dt.BuyingPrice) As BuyingAmount,Dt.OutQuantity,
			ISNULL(Prd.Location,'') As Location,ISNULL(Lc.Description,'') As LocationDescription,0 As RecordStatus
	FROM   [Operation].[StockInDetail] Dt
	Left Outer Join [Master].[Product] Prd ON 
		Dt.ProductCode = Prd.ProductCode
	Left Outer Join WHLocation Lc ON 
		Prd.Location = Lc.LookupCode

	WHERE  Dt.[ProductCode] = @ProductCode 
		And (Quantity - OutQuantity) > 0
	Order By CreatedOn


	declare @counter int,
			@rowcount int,
			@documentNo varchar(50),
			@curqty int,
			@outqty int,
			@instock int

	select @counter=1, @rowcount=COUNT(0),@curqty=@Qty from @tbl

	while @counter<=@rowcount
	begin

		select @documentno=documentno,@outqty=Quantity
		From @tbl
		where item = @counter



		select @instock = item 
		from @tbl
		where 
		item = @counter
		and (Quantity -(OutQuantity+@curqty)) >0

		if @instock >0 
			break;


		select @counter = @counter +1, @instock=0,@curqty= @curqty-@outqty
	end


	select * from @tbl where item=@instock
	        
END
GO

/* 
=======================================================================
 END		[Operation].[usp_StockInDetailSelectPendingQty]
=======================================================================
*/
 