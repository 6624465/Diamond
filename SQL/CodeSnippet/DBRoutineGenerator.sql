 


SET NOCOUNT ON
DECLARE @Tab as CHAR(1) = Char(9)
DECLARE @NewLineChar AS CHAR(2) = CHAR(13) + CHAR(10)


DECLARE @Schema as varchar(50) ='Config'
DECLARE @TableName as varchar(50) ='SystemWideConfiguration'



Select  @Tab +@Tab + '/// <summary>'   +
		@NewLineChar + @Tab +@Tab + '/// [' + @Schema  + '].[' + @TableName + ']'  +
		@NewLineChar + @Tab +@Tab + '/// </summary>'  +
		@NewLineChar + @Tab +@Tab + ' '
UNION ALL
select	@Tab +@Tab + 
		
'public const string ' + 
Case when CharIndex('List',routine_name) > 0 then ' LIST' 
when CharIndex('Select',routine_name) > 0 then ' SELECT' 
when CharIndex('Delete',routine_name) > 0 then ' DELETE' 
when CharIndex('Save',routine_name) > 0 then ' SAVE' 
End 
+

Case when CharIndex('List',routine_name) > 0 then UPPER(REPLACE(REPLACE(ROUTINE_NAME,'usp_','') ,'List',''))
when CharIndex('Select',routine_name) > 0 then UPPER(REPLACE(REPLACE(ROUTINE_NAME,'usp_','') ,'Select','')) 
when CharIndex('Delete',routine_name) > 0 then UPPER(REPLACE(REPLACE(ROUTINE_NAME,'usp_','') ,'Delete',''))
when CharIndex('Save',routine_name) > 0 then UPPER(REPLACE(REPLACE(ROUTINE_NAME,'usp_','') ,'Save',''))
end  

+
' = "[' + ROUTINE_SCHEMA + '].[' + ROUTINE_NAME + ']";'   from information_schema.routines
where routine_type='PROCEDURE'
and ROUTINE_SCHEMA =@Schema 
and SPECIFIC_NAME not like '%Insert%'
and SPECIFIC_NAME not like '%Update%'
and SPECIFIC_NAME Like '%' +  @tableName + '%'

--order by ROUTINE_NAME



