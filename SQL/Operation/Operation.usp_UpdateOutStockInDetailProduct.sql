/****** Object:  StoredProcedure [Operation].[usp_UpdateOutStockInDetailProduct]    Script Date: 07/12/2015 10:03:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [Operation].[usp_UpdateOutStockInDetailProduct] 
    @ProductCode varchar(50),
    @OutQuantity float
    
AS 
BEGIN 
	
	 Declare @vCutQty smallint

	Select @vCutQty = @OutQuantity

	 Declare @tbl table(id int primary key identity(1,1),productCode varchar(50), documentNo varchar(50), transactionDate datetime, PendingQty smallint,Qty smallint)

	 Insert Into @tbl
	 Select ProductCode,DocumentNo,CreatedOn,(Quantity - OutQuantity),Quantity
	 From Operation.StockInDetail 
	 Where ProductCode = @ProductCode
	 And (Quantity - OutQuantity) >0
	 Order by CreatedOn


	--Select * From @tbl

	declare @rowCount int,
			@counter int,
			@vproductcode varchar(50),
			@vpendingQty int,
			@vDocNo varchar(50),
			@vINQty int

	select @rowCount = COUNT(0), @counter = 1 From @tbl

	while @counter <= @rowCount
	Begin

		Select @vDocNo = DocumentNo,@vINQty = Qty
		From @tbl Where id = @counter

		If @vCutQty > 0
			Begin
			If @vCutQty > @vINQty
			Begin
				Update Operation.StockInDetail Set OutQuantity = @vINQty
				Where DocumentNo = @vDocNo

				Set @vCutQty = @vCutQty - @vINQty 

			End
			Else If @vCutQty < @vINQty
			Begin
				Update Operation.StockInDetail Set OutQuantity = @vCutQty
				Where DocumentNo = @vDocNo

				Set @vCutQty = @vCutQty -@vInQty

			End
			Else If @vCutQty = @vINQty
			Begin
				Update Operation.StockInDetail Set OutQuantity = @vCutQty
				Where DocumentNo = @vDocNo

				Set @vCutQty = @vCutQty -@vInQty

			End
		End
		set @counter= @counter+1
	End


		

	       
END
