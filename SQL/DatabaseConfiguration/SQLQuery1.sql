

--select * from p

update p set productcode =''

update p set barcode ='' where barcode is null
update p set [sell price] =0 where [sell price] is null
update p set [buy price] =0 where [buy price] is null
update p set [stock quantity] ='0' where [stock quantity] is null

declare @i int=0
update p set productcode = @i,@i=@i+1



delete master.Product
delete master.ProductImage

delete master.Quotation where quotationno <>'STANDARD'
delete master.QuotationItem

delete Operation.StockInDetail
delete Operation.StockInHeader
delete Operation.StockLedger

Declare     
	@ProductCode nvarchar(50)='',
    @BarCode nvarchar(50)=N'',
    @UOM nvarchar(50)=N'',
    @Size nvarchar(50)=N'',
    @Color nvarchar(50)=N'',
	@BuyingPrice decimal(18,2)=0,
	@SellingPrice decimal(18,2)=0,
    @Description nvarchar(250)=N'',
    @ProductCategory nvarchar(50)=N'',
	@ReorderQty int=0,
	@Location nvarchar(50)=N'',
    @Status bit=1,
    @CreatedBy varchar(25)='SYSTEM',
    @ModifiedBy varchar(25)='SYSTEM',
	@NewProductCode varchar(50) ='' 





declare @tbl table
	(id int,
	 productcode varchar(50),
	 Description nvarchar(250),
	 barcode varchar(50),
	 SellPrice decimal(18,2),
	 Qty int,
	 status bit)

declare @count int,
		@rowcount int,
		@Qty int


 declare @vDate datetime = getdate()
 declare @vStockDoc varchar(25)=''
 Exec [Operation].[usp_StockInHeaderSave] '',@vDate,'','NONE',1,0.00,0,0.00,0.00,1,'SYSTEM','SYSTEM', @NewDocumentNo = @vStockDoc  OUTPUT

insert into @tbl
select cast(productcode as int),productcode,Description,barcode,[Sell Price],[Stock Quantity],1
from p
	 
--select * From @tbl




select @count=1,@rowcount = @@rowcount from @tbl

while @count <= @rowcount
begin

	select @Description = description,@BarCode=barcode,@SellingPrice = SellPrice,@Qty = Qty
	from @tbl where id = @count
	and description is not null



	Exec [Master].[usp_ProductSave] 
    @ProductCode ,
    @BarCode ,
    @UOM ,
    @Size, 
    @Color, 
	@BuyingPrice ,
	@SellingPrice ,
    @Description ,
    @ProductCategory ,
	@ReorderQty ,
	@Location ,
    @Status ,
    @CreatedBy ,
    @ModifiedBy ,
	@NewProductCode = @NewProductCode OUTPUT

	print @NewProductCode + ' = ' + @Description

	
	insert Into Master.QuotationItem 
	Select 'STANDARD',@count,@NewProductCode,@BarCode,@SellingPrice,1,'SYSTEM',GetDate(),'SYSTEM',GETDATE()


	insert Into Operation.StockInDetail
	Select @vStockDoc,@count,@NewProductCode,@BarCode,@Qty,0.00,0,'NONE','SYSTEM',GetDate(),'SYSTEM',GETDATE()


	Exec [Operation].[usp_StockLedgerSave] '','IN',@NewProductCode,'',@Qty,1,@vStockDoc,'NONE','SYSTEM','SYSTEM'


	set @count = @count+1

end


