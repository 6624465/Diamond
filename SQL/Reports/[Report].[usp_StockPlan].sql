
-- ========================================================================================================================================
-- START											 [Report].[usp_StockPlan]
-- ========================================================================================================================================
-- Author:		Sharma
-- Create date: 	01-May-2012
-- Description:	Select the [GoodsReceiveDetail] Record based on [GoodsReceiveDetail] table

--Exec [Report].[usp_StockPlan] '','2016-04-20','2016-04-28'

-- ========================================================================================================================================


IF OBJECT_ID('[Report].[usp_StockPlan]') IS NOT NULL
BEGIN 
    DROP PROC [Report].[usp_StockPlan] 
END 
GO
CREATE PROC [Report].[usp_StockPlan] 
    @DateFrom datetime = null,
	@DateTo datetime = null
AS 
BEGIN



Declare @tbl table(	ProductCode varchar(50), 
					ProductDescription nvarchar(255),
					CustomerCode varchar(50),
					CustomerName nvarchar(255),
					StockDate datetime,
					QtyIN int,
					QtyOut int)

Insert Into @tbl
select S.ProductCode, P.Description,C.CustomerCode,C.CustomerName,S.StockDate,S.Quantity,0
From operation.StockLedger S
Left Outer Join Master.Product P  ON 
s.ProductCode = P.ProductCode
Left Outer Join Master.Customer C On 
S.CustomerCode = C.CustomerCode
Where  Convert(char(10),S.StockDate,120) >= Convert(Char(10),@DateFrom,120)
And Convert(char(10),S.StockDate,120) <= Convert(Char(10),@DateTo,120)
And S.StockFlag = 1


Insert Into @tbl
select S.ProductCode, P.Description,C.CustomerCode,C.CustomerName,S.StockDate,0,S.Quantity
From operation.StockLedger S
Left Outer Join Master.Product P  ON 
s.ProductCode = P.ProductCode
Left Outer Join Master.Customer C On 
S.CustomerCode = C.CustomerCode
Where  Convert(char(10),S.StockDate,120) >= Convert(Char(10),@DateFrom,120)
And Convert(char(10),S.StockDate,120) <= Convert(Char(10),@DateTo,120)
And S.StockFlag = -1



select * From @tbl

END