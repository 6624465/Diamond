
INSERT INTO [Config].[Lookup]([LookupCode], [Description], [Description2], [Category], [Status])
SELECT N'BAG', N'BAG', N'', N'UOM', 1 UNION ALL
SELECT N'BARREL', N'BARREL', N'', N'UOM', 1 UNION ALL
SELECT N'KG', N'KILO', N'', N'UOM', 1 UNION ALL
SELECT N'LTR', N'LITER', N'', N'UOM', 1 UNION ALL
SELECT N'UNIT', N'UNIT', N'', N'UOM', 1

INSERT INTO [Config].[Lookup]([LookupCode], [Description], [Description2], [Category], [Status])
SELECT N'CASH', N'CASH', N'', N'CREDITTERM', 1 UNION ALL
SELECT N'CREDIT', N'CREDIT', N'', N'CREDITTERM', 1  

INSERT INTO [Config].[Lookup]([LookupCode], [Description], [Description2], [Category], [Status])
SELECT N'CASHBILL', N'CASH BILL', N'', N'INVOICETYPE', 1 UNION ALL
SELECT N'CREDITBILL', N'CREDIT INVOICE', N'', N'INVOICETYPE', 1  

INSERT INTO [Config].[Lookup]([LookupCode], [Description], [Description2], [Category], [Status])
SELECT N'FOOD', N'FOOD ITEM', N'', N'PRODUCTCATEGORY', 1 UNION ALL
SELECT N'SPAREPART', N'SPARE PART', N'', N'PRODUCTCATEGORY', 1 

INSERT INTO [Config].[Lookup]([LookupCode], [Description], [Description2], [Category], [Status])
SELECT N'SUPPLIER', N'SUPPLIER', N'', N'CUSTOMERTYPE', 1 UNION ALL
SELECT N'CUSTOMER', N'CUSTOMER', N'', N'CUSTOMERTYPE', 1  

INSERT INTO [Config].[Lookup]([LookupCode], [Description], [Description2], [Category], [Status])
SELECT N'DISCOUNT-CASH', N'CASH', N'', N'DISCOUNTTYPE', 1 UNION ALL
SELECT N'DISCOUNT-PERCENT', N'PERCENT', N'', N'DISCOUNTTYPE', 1  



INSERT INTO [Config].[Lookup]([LookupCode], [Description], [Description2], [Category], [Status])
SELECT N'PAYMENT-CASH', N'CASH', N'', N'PAYMENTTYPE', 1 UNION ALL
SELECT N'PAYMENT-BANK', N'BANK-TRANSFER', N'', N'PAYMENTTYPE', 1 UNION ALL
SELECT N'PAYMENT-CHEQUE', N'CHEQUE', N'', N'PAYMENTTYPE', 1  