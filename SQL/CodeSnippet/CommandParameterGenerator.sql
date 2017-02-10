--####Prorperty variable Declartions

 

SET NOCOUNT ON


Declare @table table (id int identity,tblName varchar(200),tblSchema varchar(50))

insert into @table
select TABLE_NAME,TABLE_SCHEMA from INFORMATION_SCHEMA.TABLES 
where TABLE_SCHEMA='Config'
AND TABLE_NAME='SystemWideConfiguration'
order by TABLE_NAME



DECLARE @NewLineChar AS CHAR(2) = CHAR(13) + CHAR(10)
DECLARE @Tab as CHAR(1) = Char(9)
DECLARE @Count as int=0
DECLARE @iCount as int
DECLARE @privateVariables as varchar(max)
DECLARE @publicMembers as varchar(max)
DECLARE @tableName as varchar(50)
DECLARE @ClassStart as varchar(max)
Declare @ClassEnd as varchar(max)
declare @ClassConstructor as varchar(500)
DECLARE @tableSchema as varchar(50)


Select @iCount=1,@Count = COUNT(0) from @table

IF @Count=0 
	RETURN;
	
	
set @Count =1
	


WHILE @iCount <=@Count	
BEGIN

select @tableName = tblName,@tableSchema=tblSchema  from @table where id=@iCount


-- NOTE : FOR BETTER RESULTS , RUN THIS QUERY IN "RESULTS TO TEXT" MODE (PRESS ctrl+T)


Select 'db.AddInParameter(savecommand, "'  + column_name + '",'+
		case when data_type='varchar' then 'System.Data.DbType.String'
		when data_type='char' then 'System.Data.DbType.String'
		when data_type='tinyint' then 'System.Data.DbType.Int16'
		when data_type='bit' then 'System.Data.DbType.Boolean'
		when data_type='datetime' then 'System.Data.DbType.DateTime'
		when data_type='date' then 'System.Data.DbType.Date'
		when data_type='money' then 'System.Data.DbType.Decimal'
		when data_type='int' then 'System.Data.DbType.Int32'
		when data_type='bigint' then 'System.Data.DbType.Int64'
		when data_type='float' then 'System.Data.DbType.Double'
		when data_type='text' then 'System.Data.DbType.String'	
		when data_type='smallint' then 'System.Data.DbType.Int16'		
		when data_type='smallmoney' then 'System.Data.DbType.Decimal'
		when data_type='numeric' then 'System.Data.DbType.Decimal'
		when data_type='nvarchar' then 'System.Data.DbType.String'			
		when data_type='xml' then 'System.Data.DbType.String'	
		when data_type='image' then 'System.Data.DbType.Object'	
		when data_type='decimal' then 'System.Data.DbType.Decimal'	
				
		end + ','+LOWER(@tableName) + '.' + column_name + ');' + @NewLineChar
		
from information_schema.columns where table_name=@tableName And TABLE_SCHEMA = @tableSchema
AND		column_name NOT IN ('CreatedOn','ModifiedOn','AuditID')
order by ordinal_position


Select 'db.AddInParameter(deleteCommand, "'  + cnst.COLUMN_NAME + '",'+
		case when data_type='varchar' then 'System.Data.DbType.String'
		when data_type='char' then 'System.Data.DbType.String'
		when data_type='tinyint' then 'System.Data.DbType.Int16'
		when data_type='bit' then 'System.Data.DbType.Boolean'
		when data_type='datetime' then 'System.Data.DbType.DateTime'
		when data_type='date' then 'System.Data.DbType.Date'
		when data_type='money' then 'System.Data.DbType.Decimal'
		when data_type='int' then 'System.Data.DbType.Int32'
		when data_type='bigint' then 'System.Data.DbType.Int64'
		when data_type='float' then 'System.Data.DbType.Double'
		when data_type='text' then 'System.Data.DbType.String'	
		when data_type='smallint' then 'System.Data.DbType.Int16'		
		when data_type='smallmoney' then 'System.Data.DbType.Decimal'
		when data_type='numeric' then 'System.Data.DbType.Decimal'
		when data_type='nvarchar' then 'System.Data.DbType.String'			
		when data_type='xml' then 'System.Data.DbType.String'	
		when data_type='image' then 'System.Data.DbType.Object'	
				
		end + ','+LOWER(@tableName) + '.' + cnst.COLUMN_NAME + ');' + @NewLineChar
		
from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE cnst
INNER JOIN INFORMATION_SCHEMA.COLUMNS clm ON
cnst.TABLE_NAME=clm.TABLE_NAME AND 
cnst.COLUMN_NAME = clm.COLUMN_NAME
where cnst.TABLE_NAME=@tableName And cnst.TABLE_SCHEMA = @tableSchema



Select	'parameter.ParameterName = "'  + cnst.COLUMN_NAME + '";'+ @NewLineChar +
		'parameter.Value = parameterValues[' + CAST(clm.ORDINAL_POSITION-1 as varchar(3)) + '];' + @NewLineChar
		
from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE cnst
INNER JOIN INFORMATION_SCHEMA.COLUMNS clm ON
cnst.TABLE_NAME=clm.TABLE_NAME AND
cnst.COLUMN_NAME = clm.COLUMN_NAME
where cnst.TABLE_NAME=@tableName And cnst.TABLE_SCHEMA = @tableSchema






set @iCount = @iCount+1

END


