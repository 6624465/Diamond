
IF OBJECT_ID('[Utility].[udf_PADL]') IS NOT NULL
BEGIN 
    DROP FUNCTION [Utility].[udf_PADL]
END 
GO
Create   FUNCTION [Utility].[udf_PADL](  @vcValue AS varchar(8000), 
			  @iNoOfChar AS int,
			  @vcChar AS varchar(1))

RETURNS varchar(8000) AS  
BEGIN 
  DECLARE @vcRESULT varchar(8000)
  
  IF Len(@vcValue) > @iNoOfChar BEGIN
     SET @vcRESULT = Left(@vcValue, @iNoOfChar)
  END ELSE BEGIN
     SET @vcRESULT = Replicate(@vcChar, @iNoOfChar - Len(@vcValue)) + @vcValue 
  END

  RETURN @vcRESULT
END
