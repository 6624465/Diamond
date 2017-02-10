
/* 
=======================================================================
 START		[Master].[usp_QuotationSelect]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Select All Columns From [Master].[Quotation] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationSelect]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationSelect] 
END 
GO
CREATE PROC [Master].[usp_QuotationSelect] 
    @QuotationNo varchar(50)
AS 
BEGIN 
	SELECT	Hd.[QuotationNo], Hd.[BranchID], Hd.[QuotationDate], Hd.[EffectiveDate], Hd.[ExpiryDate], Hd.[CustomerCode], Hd.[Status], 
			Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn], Hd.[QuotationType],
			ISNULL(Cs.CustomerName,'') As CustomerName
	FROM	[Master].[Quotation] Hd
	Left Outer Join Master.Customer Cs ON 
		Hd.CustomerCode = Cs.CustomerCode
	WHERE	[QuotationNo] = @QuotationNo  
END
GO

/* 
=======================================================================
 END		[Master].[usp_QuotationSelect]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_QuotationList]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	List All Data From [Master].[Quotation] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationList]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationList] 
END 
GO
CREATE PROC [Master].[usp_QuotationList] 

AS 
BEGIN 
	SELECT	Hd.[QuotationNo], Hd.[BranchID], Hd.[QuotationDate], Hd.[EffectiveDate], Hd.[ExpiryDate], Hd.[CustomerCode], Hd.[Status], 
			Hd.[CreatedBy], Hd.[CreatedOn], Hd.[ModifiedBy], Hd.[ModifiedOn], Hd.[QuotationType],
			ISNULL(Cs.CustomerName,'') As CustomerName
	FROM	[Master].[Quotation] Hd
	Left Outer Join Master.Customer Cs ON 
		Hd.CustomerCode = Cs.CustomerCode
 
END
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationSelect]
=======================================================================
*/
/*
=======================================================================
START		[Master].[usp_QuotationInsert]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Inserts New Record Into [Master].[Quotation] Table

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationInsert]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationInsert] 
END 
GO
CREATE PROC [Master].[usp_QuotationInsert] 
    @QuotationNo varchar(50),
    @BranchID smallint,
    @QuotationDate datetime,
    @EffectiveDate datetime,
    @ExpiryDate datetime,
    @CustomerCode nvarchar(50),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) ,
	@QuotationType varchar(20),
    @NewQuotationNo varchar(25) OUTPUT
AS 
BEGIN 
	INSERT INTO [Master].[Quotation] ([QuotationNo], [BranchID], [QuotationDate], [EffectiveDate], [ExpiryDate], [CustomerCode], [Status], [CreatedBy], [CreatedOn], [QuotationType] )
	SELECT @QuotationNo, @BranchID, @QuotationDate, @EffectiveDate, @ExpiryDate, @CustomerCode, @Status, @CreatedBy, GETDATE(),@QuotationType

	SELECT @NewQuotationNo = @QuotationNo 

END	
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationInsert]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_QuotationUpdate]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Updates Existing Record Into [Master].[Quotation] 
		Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationUpdate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationUpdate] 
END 
GO
CREATE PROC [Master].[usp_QuotationUpdate] 
    @QuotationNo varchar(50),
    @BranchID smallint,
    @QuotationDate datetime,
    @EffectiveDate datetime,
    @ExpiryDate datetime,
    @CustomerCode nvarchar(50),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) ,
	@QuotationType varchar(20),
    @NewQuotationNo varchar(25) OUTPUT
AS 
BEGIN 

	UPDATE [Master].[Quotation]
	SET    [BranchID] = @BranchID, [QuotationDate] = @QuotationDate, [EffectiveDate] = @EffectiveDate, [QuotationType]=@QuotationType,
			[ExpiryDate] = @ExpiryDate, [CustomerCode] = @CustomerCode, [Status] = @Status, [ModifiedBy] = @ModifiedBy, [ModifiedOn] = GetDate()
	WHERE  [QuotationNo] = @QuotationNo


	SELECT @NewQuotationNo = @QuotationNo 

END	
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationUpdate]
=======================================================================
*/


/*
=======================================================================
START		[Master].[usp_QuotationSave]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Either Inserts New Record / Updates Existing Record 
			Into [Master].[Quotation] Table.

=======================================================================
*/

IF OBJECT_ID('[Master].[usp_QuotationSave]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationSave] 
END 
GO
CREATE PROC [Master].[usp_QuotationSave] 
    @QuotationNo varchar(50),
    @BranchID smallint,
    @QuotationDate datetime,
    @EffectiveDate datetime,
    @ExpiryDate datetime,
    @CustomerCode nvarchar(50),
    @Status bit,
    @CreatedBy varchar(25),
    @ModifiedBy varchar(25) ,
	@QuotationType varchar(20),
    @NewQuotationNo varchar(25) OUTPUT
AS 
BEGIN 
Declare @dt DateTime,
	 @DocID varchar(50)
/*
Exec [Utility].[usp_GenerateDocumentNumber] @BranchID, @DocID, @Dt ,@CreatedBy, @OrderNo OUTPUT
*/


	IF (SELECT COUNT(0) FROM [Master].[Quotation]
		WHERE 	[QuotationNo] = @QuotationNo)>0
	BEGIN	
		EXEC [Master].[usp_QuotationUpdate] @QuotationNo, @BranchID, @QuotationDate, @EffectiveDate, @ExpiryDate, @CustomerCode, 
			@Status, @CreatedBy,   @ModifiedBy,@QuotationType, @NewQuotationNo  = @NewQuotationNo OUTPUT
	END
	Else
	BEGIN

		/*
		declare @ord varchar(50)
		declare @dt datetime
		set @dt =GETDATE()
		Exec [Utility].[usp_GenerateDocumentNumber] 10, 'Quotation', @dt ,'system', @ord   OUTPUT
		print @ord
		*/
		Set @Dt = GETDATE()

		if(@QuotationNo <> 'STANDARD_' + CONVERT(VARCHAR(2),@BranchID))
			Set @QuotationNo=''

		IF LEN(@QuotationNo)=0
			Exec [Utility].[usp_GenerateDocumentNumber] @BranchID,'Quotation', @Dt ,@CreatedBy, @QuotationNo OUTPUT
	
		--Print @QuotationNo 

	    EXEC [Master].[usp_QuotationInsert] @QuotationNo, @BranchID, @QuotationDate, @EffectiveDate, @ExpiryDate, @CustomerCode, 
				@Status, @CreatedBy, @ModifiedBy,@QuotationType ,@NewQuotationNo  = @NewQuotationNo OUTPUT 
	END
	

END	
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationUpdate]
=======================================================================
*/

/*
=======================================================================
START		[Master].[usp_QuotationDelete]
=======================================================================
Author:		Sudarshan
Create date:	2015-05-21
Description:	Deletes Existing Record Into [Master].[Quotation] 
			Table.

=======================================================================
*/


IF OBJECT_ID('[Master].[usp_QuotationDelete]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationDelete] 
END 
GO
CREATE PROC [Master].[usp_QuotationDelete] 
    @QuotationNo varchar(50),
	@ModifiedBy varchar(25)
AS 
BEGIN 

	--DELETE
	--FROM   [Master].[Quotation]
	--WHERE  [QuotationNo] = @QuotationNo

	Update [Master].[Quotation]
	Set Status = Cast(0 as bit),ModifiedBy=@ModifiedBy,ModifiedOn = GETDATE()
	WHERE  [QuotationNo] = @QuotationNo
END
GO
/* 
=======================================================================
 END		[Master].[usp_QuotationDelete]
=======================================================================
*/
 


-- ========================================================================================================================================
-- START											 [Master].[usp_QuotationIsDuplicate]
-- ========================================================================================================================================
-- Author:		Sudarshan
-- Create date: 01-Dec-2011
-- Description:	To Check the duplicate record in the Quotation table.

-- exec [Master].[usp_QuotationIsDuplicate] 'SONY','2015-09-06'

-- ========================================================================================================================================



IF OBJECT_ID('[Master].[usp_QuotationIsDuplicate]') IS NOT NULL
BEGIN 
    DROP PROC [Master].[usp_QuotationIsDuplicate] 
END 
GO
CREATE PROC [Master].[usp_QuotationIsDuplicate] 
    @CustomerCode nvarchar(50),
    @EffectiveDate datetime
    
AS 
	 
	 --//TODO: Add the audit trail number to the inserted / updated records
BEGIN	
	
Declare @count int
	
	
	Select COUNT(0) FROM [Master].[Quotation]
	WHERE	[CustomerCode] = @CustomerCode
			AND Convert(char(10),[ExpiryDate],120) >= CONVERT(char(10), @EffectiveDate,120)
			AND [QuotationNo] NOT LIKE '%STANDARD%'
			AND [Status]=CAST(1 As bit)

END	

-- ========================================================================================================================================
-- END  											 [Master].[usp_QuotationIsDuplicate]
-- ========================================================================================================================================


GO

