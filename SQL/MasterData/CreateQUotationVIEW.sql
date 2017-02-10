USE [NetStock]
GO

/****** Object:  View [dbo].[QuotationView]    Script Date: 03-10-2015 11:06:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW Master.[STANDARDQuotationView]
AS
SELECT        Master.Quotation.QuotationDate, Master.Quotation.EffectiveDate , Master.Quotation.ExpiryDate , 
                         Master.Quotation.CustomerCode , Master.Quotation.QuotationNo, Master.Quotation.BranchID, Master.Quotation.CreatedBy, Master.Quotation.Status, 
                         Master.Quotation.CreatedOn, Master.Quotation.ModifiedBy, Master.Quotation.ModifiedOn, Master.Quotation.QuotationType, Master.QuotationItem.ItemID, 
                         Master.QuotationItem.ProductCode, Master.QuotationItem.BarCode, Master.QuotationItem.SellRate
FROM            Master.Quotation INNER JOIN
                         Master.QuotationItem ON Master.Quotation.QuotationNo = Master.QuotationItem.QuotationNo
Where Master.Quotation.QuotationNo='STANDARD'

GO
 



 USE [NetStock]
GO

/****** Object:  View [dbo].[QuotationView]    Script Date: 03-10-2015 11:06:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

alter VIEW Master.[QuotationView]
AS
SELECT        Master.Quotation.QuotationDate, Master.Quotation.EffectiveDate , Master.Quotation.ExpiryDate , 
                         Master.Quotation.CustomerCode , Master.Quotation.QuotationNo, Master.Quotation.BranchID, Master.Quotation.CreatedBy, Master.Quotation.Status, 
                         Master.Quotation.CreatedOn, Master.Quotation.ModifiedBy, Master.Quotation.ModifiedOn, Master.Quotation.QuotationType, Master.QuotationItem.ItemID, 
                         Master.QuotationItem.ProductCode, Master.QuotationItem.BarCode, Master.QuotationItem.SellRate
FROM            Master.Quotation INNER JOIN
                         Master.QuotationItem ON Master.Quotation.QuotationNo = Master.QuotationItem.QuotationNo
Where Master.Quotation.QuotationNo<>'STANDARD'

GO
 