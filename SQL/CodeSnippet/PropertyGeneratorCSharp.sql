--####Prorperty variable Declartions


 

SET NOCOUNT ON


Declare @table table (id int identity,tblName varchar(200),tblSchema varchar(50))

insert into @table
select TABLE_NAME,TABLE_SCHEMA from INFORMATION_SCHEMA.TABLES 
where TABLE_SCHEMA='Operation'
AND TABLE_NAME='InspectionOverSeas'
order by TABLE_NAME




DECLARE @NewLineChar AS CHAR(2) = CHAR(13) + CHAR(10)
DECLARE @Tab as CHAR(1) = Char(9)
DECLARE @Count as int=0
DECLARE @iCount as int
DECLARE @privateVariables as varchar(max)
DECLARE @publicMembers as varchar(max)
DECLARE @tableName as varchar(50)
DECLARE @tableSchema as varchar(50)
DECLARE @ClassStart as varchar(max)
Declare @ClassEnd as varchar(max)
declare @ClassConstructor as varchar(500)


Select @iCount=1,@Count = COUNT(0) from @table

IF @Count=0 
	RETURN;
	
	
set @Count =1
	


WHILE @iCount <=@Count	
BEGIN

select @tableName = tblName,@tableSchema=tblSchema from @table where id=@iCount



select @ClassStart = 'using System;' +
@NewLineChar + 'using System.Collections.Generic;' +
@NewLineChar + 'using System.Linq;' +
@NewLineChar + 'using System.Text;' +
@NewLineChar + 'using System.Web.Mvc;' +
@NewLineChar + 'using System.ComponentModel;' +
@NewLineChar + 'using System.ComponentModel.DataAnnotations;' +
@NewLineChar + 'using System.Web;' +
@NewLineChar + 'using NetStock.Contract;' + 
@NewLineChar + 
@NewLineChar + 'namespace NetStock.Contract' +
@NewLineChar + '{' +
@NewLineChar + @tab + 'public class ' + @tableName + ': IContract' +
@NewLineChar + @tab + '{' 


print @classstart
-- NOTE : FOR BETTER RESULTS , RUN THIS QUERY IN "RESULTS TO TEXT" MODE (PRESS ctrl+T)

Print @tab + @tab + '// Constructor '

set @ClassConstructor = @tab + @tab + 'public ' + @tableName + '() { }' + @NewLineChar + @NewLineChar
print @ClassConstructor


--###Prorperty  Declartions

Print  @tab + @tab + '// Public Members '


Select @tab + @tab + '[DisplayName("' + column_name + '")] ' + @NewLineChar + @tab + @tab + 'public ' + 
	case when data_type='varchar' then 'string '
	when data_type='char' then 'string '
	when data_type='tinyint' then 'Int16 '
	when data_type='bit' then 'bool '
	when data_type='datetime' then 'DateTime '
	when data_type='date' then 'DateTime '
	when data_type='money' then 'decimal '
	when data_type='int' then 'Int32 '
	when data_type='bigint' then 'Int64 '
	when data_type='float' then 'double '
	when data_type='text' then 'string '	
	when data_type='smallint' then 'Int16 '	
	when data_type='smallmoney' then 'decimal '	
	when data_type='numeric' then 'decimal '	
	when data_type='nvarchar' then 'string'			
	when data_type='xml' then 'string'			
	when data_type='image' then 'object'
	when data_type='decimal' then 'decimal'
		
end + ' ' +  column_name + ' { get; set; }' + @NewLineChar + @NewLineChar 
	

from information_schema.columns where table_name=@tableName And TABLE_SCHEMA = @tableSchema
--And column_name NOT IN ('CreatedOn','ModifiedOn')
order by ordinal_position


select @ClassEnd = @tab + '}' + @NewLineChar + '}'+ @NewLineChar+ @NewLineChar+ @NewLineChar+ @NewLineChar


print @classend

set @iCount = @iCount+1

END


