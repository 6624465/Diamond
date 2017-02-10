--select * from master.quotationitem where quotationno ='STANDARD'
--delete from master.quotationitem where quotationno ='STANDARD'

declare @tbl table(itemID smallint primary key identity(1,1), productcode varchar(50), barcode varchar(50), sellrate decimal(18,2))

insert into @tbl
select productcode,barcode,100.00
from master.Product

declare @rows smallint,
		@count smallint,
		@vproductcode varchar(50),
		
		@vbarcode varchar(50),
		@vsellrate decimal(18,2)

select @rows=Count(0),@count=1 from @tbl
while @count <= @rows
Begin
	select @vproductcode = productcode, 
		   @vbarcode = barcode, 
		   @vsellrate = sellrate
	from @tbl where itemID= @count
	
	Insert into master.QuotationItem
	Select 'STANDARD',@count,@vproductcode,@vbarcode,@vsellrate,1,'SYSTEM',getdate(),'SYSTEM',GETDATE()

	print @vproductcode 

	set @count = @count +1 

end