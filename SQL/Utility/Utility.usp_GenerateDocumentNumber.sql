
/****** Object:  StoredProcedure [dbo].[spGetDocumentNo]    Script Date: 01/14/2012 07:25:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


/*Call FROM PROC

select * from Utility.DocumentNumberHeader



DECLARE @DocNo AS varchar(25)
EXEC [Utility].[usp_GenerateDocumentNumber] 240, 'TMS\Order(EXPORT)', '2012-02-01' ,'SYSTEM', @DocNo OUTPUT

select @DocNo

*/


IF OBJECT_ID('[Utility].[usp_GenerateDocumentNumber]') IS NOT NULL
BEGIN 
    DROP PROC [Utility].[usp_GenerateDocumentNumber] 
END 
GO
Create PROC [Utility].[usp_GenerateDocumentNumber]
	@BranchID smallint,
	@DocumentId VARCHAR(30),
	@TrxDate DATETIME,
	@UserId VARCHAR(10),
	@DocumentNo VARCHAR(20) = '' OUTPUT

AS
BEGIN

SET NOCOUNT ON
--Set the date format during run time, system is passing in dd/mm/yyyy
SET DATEFORMAT dmy
DECLARE	@FromSystem BIT 
DECLARE	@Increment BIT 

--DECLARE @DocumentNo AS VARCHAR(20)

DECLARE @CompanyCode AS VARCHAR(10)
DECLARE @BranchCode AS VARCHAR(10)
DECLARE @DocumentKey AS VARCHAR(10)
DECLARE @Prefix AS VARCHAR(10)
DECLARE @LastNumber AS INTEGER
DECLARE @NumberLength AS INTEGER
DECLARE @WithCompany AS BIT
DECLARE @WithBranch AS BIT
DECLARE @WithYear AS BIT
DECLARE @WithMonth AS BIT
DECLARE @ItemFound AS BIT
DECLARE @MonthField AS VARCHAR(10)
DECLARE @SQL AS NVARCHAR(200)

DECLARE @JANUARY AS INTEGER
DECLARE @FEBRUARY AS INTEGER
DECLARE @MARCH AS INTEGER
DECLARE @APRIL AS INTEGER
DECLARE @MAY AS INTEGER
DECLARE @JUNE AS INTEGER
DECLARE @JULY AS INTEGER
DECLARE @AUGUST AS INTEGER
DECLARE @SEPTEMBER AS INTEGER
DECLARE @OCTOBER AS INTEGER
DECLARE @NOVEMBER AS INTEGER
DECLARE @DECEMBER AS INTEGER



Declare @ThaiYearValue nvarchar(50),
		@UseThaiYearFor nvarchar(50)

	-- Retrieve Document Number Set
	SELECT @DocumentKey=DocumentKey
	FROM Utility.DocumentNumberHeader
	WHERE 
		--BranchID = @BranchID And 
		DocumentID = @DocumentId

	Set @Increment = 1

	SELECT @BranchCode = BranchCode, @CompanyCode = CompanyCode
	FROM  Master.Branch 
	WHERE BranchID = @BranchID


	Select @ThaiYearValue=ConfigurationValue From Config.SystemWideConfiguration where DisplayName ='UseThaiYear'
	Select @UseThaiYearFor=ConfigurationValue From Config.SystemWideConfiguration where DisplayName ='Thai Year Doc For'

	IF LOWER(@DocumentId) <> LOWER(@UseThaiYearFor)
		Set @ThaiYearValue=0


	IF @@ERROR <> 0 GOTO ERROR_HANDLER

	IF LEN(@DocumentKey) > 0 BEGIN

		-- Retrieve Document No properties
		SELECT @Prefix = DocumentPrefix, @LastNumber = LastNumber, @NumberLength = NumberLength,
			@WithCompany = UseCompany, @WithBranch = UseBranch, @WithYear = UseYear,
			@WithMonth = UseMonth
		FROM Utility.DocumentNumberHeader
        WHERE 
			--BranchID = @BranchID And 
			DocumentKey = @DocumentKey

		IF @@ERROR <> 0 GOTO ERROR_HANDLER

		-- Generating Document No
		SET @DocumentNo = @Prefix

		IF @WithCompany = 1 SET @DocumentNo = @DocumentNo + @CompanyCode
		IF @WithBranch = 1 SET @DocumentNo = @DocumentNo + @BranchCode
		IF @WithYear = 1 SET @DocumentNo = @DocumentNo + RIGHT(STR((YEAR(@TrxDate) + Convert(int,@ThaiYearValue))), 2)
		IF @WithMonth = 1 SET @DocumentNo = @DocumentNo + Utility.udf_PADL(LTRIM(STR(MONTH(@TrxDate))), 2, '0')

		--Get the lastest no for the Document Id
		IF @WithYear = 1 OR @WithMonth = 1 BEGIN

			SET @ItemFound = 0

			SELECT @January = January, @February = February, @March = March, 
				@April = April, @May = May, @June = June, 
				@July = July, @August = August, @September = September, 
				@October = October, @November = November, @December = December, @ItemFound = 1
			FROM Utility.DocumentNumberDetail
			WHERE 
				--BranchID = @BranchID And 
				DocumentKey = @DocumentKey
				And YearNo = YEAR(@TrxDate)

			IF @@ERROR <> 0 GOTO ERROR_HANDLER

			IF @ItemFound <> 1 BEGIN
				SET @January = 0
				SET @February = 0
				SET @March = 0
				SET @April = 0
				SET @May = 0
				SET @June = 0
				SET @July = 0
				SET @August = 0
				SET @September = 0
				SET @October = 0
				SET @November = 0
				SET @December = 0
			END
		END

		-- Get the latest no base on month
		IF @WithMonth = 1 BEGIN
			IF MONTH(@TrxDate) = 1 BEGIN
				SET @LastNumber = @January 
			END ELSE IF MONTH(@TrxDate) = 2 BEGIN
				SET @LastNumber = @February
			END ELSE IF MONTH(@TrxDate) = 3 BEGIN
				SET @LastNumber = @March
			END ELSE IF MONTH(@TrxDate) = 4 BEGIN
				SET @LastNumber = @April
			END ELSE IF MONTH(@TrxDate) = 5 BEGIN
				SET @LastNumber = @May
			END ELSE IF MONTH(@TrxDate) = 6 BEGIN
				SET @LastNumber = @June
			END ELSE IF MONTH(@TrxDate) = 7 BEGIN
				SET @LastNumber = @July
			END ELSE IF MONTH(@TrxDate) = 8 BEGIN
				SET @LastNumber = @August
			END ELSE IF MONTH(@TrxDate) = 9 BEGIN
				SET @LastNumber = @September
			END ELSE IF MONTH(@TrxDate) = 10 BEGIN
				SET @LastNumber = @October
			END ELSE IF MONTH(@TrxDate) = 11 BEGIN
				SET @LastNumber = @November
			END ELSE IF MONTH(@TrxDate) = 12 BEGIN
				SET @LastNumber = @December
			END
		END ELSE BEGIN
			SET @LastNumber = @January
		END

		IF @Increment = 1 BEGIN
			SET @LastNumber = @LastNumber + 1
		END

		SET @DocumentNo = @DocumentNo + REPLICATE('0', @NumberLength - LEN(LTRIM(STR(@LastNumber)))) + LTRIM(STR(@LastNumber))

	END ELSE BEGIN
		RaisError ('The document number has not been setup properly ! Please contact your administrator for support.', 16, 1)
		GOTO ERROR_HANDLER
	END

	IF LEN(@DocumentNo) > 0 BEGIN

		IF @WithYear = 1 OR @WithMonth = 1 BEGIN

			IF @WithMonth = 1 BEGIN
				SET @MonthField = DATENAME(month,@TrxDate)
			END ELSE BEGIN
				SET @MonthField = 'January'
			END

			IF @ItemFound = 1 BEGIN
				SET @SQL = 'UPDATE Utility.DocumentNumberDetail' +
					' SET ' + @MonthField + '=' + convert(varchar(10),@LastNumber)  + 
					' WHERE ' + --BranchID =''' + convert(varchar(10),@BranchID) + ''''  And 
						' DocumentKey =''' + @DocumentKey + '''' + 
						' And YearNo=' + LTRIM(STR(YEAR(@TrxDate)))
			END ELSE BEGIN
				Declare @vTempBranchID smallint

				Select Top(1) @vTempBranchID = BranchID From Utility.DocumentNumberHeader

				SET @SQL = 'INSERT INTO Utility.DocumentNumberDetail' +
					' (BranchID,DocumentKey,YearNo,' + @MonthField + ')' +
					' VALUES (' + convert(varchar(10),@vTempBranchID) + ',''' + @DocumentKey + ''',' + LTRIM(STR(YEAR(@TrxDate))) + ',1)'
					
					
			END
			
			print @SQL

			IF LEN(@SQL) > 0 BEGIN
				EXEC SP_EXECUTESQL @SQL
			END

			IF @@ERROR <> 0 BEGIN
				SET @DocumentNo = ''
				RaisError ('Unable to update document number !', 16, 1)				
				GOTO ERROR_HANDLER
			END
		END ELSE BEGIN

	        UPDATE Utility.DocumentNumberHeader
			SET LastNumber=LastNumber + 1
			WHERE 
			--BranchID=@BranchID And 
			DocumentKey=@DocumentKey

			IF @@ERROR <> 0 BEGIN
				SET @DocumentNo = ''
				RaisError ('Unable to update document number !', 16, 1)
				GOTO ERROR_HANDLER
			END
		END
	END
	
	IF @FromSystem = 1 AND LEN(@DocumentNo) > 0 SELECT @DocumentNo

RETURN 0

ERROR_HANDLER:
	RETURN -2
END



