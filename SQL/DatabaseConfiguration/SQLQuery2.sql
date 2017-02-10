
ALTER TABLE Operation.GoodsIssueDetail    DROP CONSTRAINT [DF_GoodsIssueDetail_Qty]
ALTER TABLE Operation.GoodsIssueDetail    DROP CONSTRAINT DF_GoodsIssueDetail_CurrentQty
ALTER TABLE Operation.GoodsIssueDetail    ALTER COLUMN Qty float 
ALTER TABLE Operation.GoodsIssueDetail    ALTER COLUMN CurrentQty float 
ALTER TABLE Operation.GoodsIssueDetail    ADD CONSTRAINT [DF_GoodsIssueDetail_Qty] DEFAULT 0 for Qty WITH VALUES 
ALTER TABLE Operation.GoodsIssueDetail    ADD CONSTRAINT DF_GoodsIssueDetail_CurrentQty DEFAULT 0 FOR CurrentQty WITH VALUES


ALTER TABLE Operation.GoodsReceiveDetail    DROP CONSTRAINT DF_GoodsReceiveDetail_Qty
ALTER TABLE Operation.GoodsReceiveDetail    ALTER COLUMN Qty float
ALTER TABLE Operation.GoodsReceiveDetail    ADD CONSTRAINT DF_GoodsReceiveDetail_Qty DEFAULT 0 FOR Qty WITH VALUES


ALTER TABLE Operation.GoodsReceiveDetailsOverseas    DROP CONSTRAINT DF_GoodsReceiveDetailsOverseas_QtyPerUOM
ALTER TABLE Operation.GoodsReceiveDetailsOverseas    DROP CONSTRAINT DF_GoodsReceiveDetailsOverseas_Quantity
ALTER TABLE Operation.GoodsReceiveDetailsOverseas    ALTER COLUMN Quantity float
ALTER TABLE Operation.GoodsReceiveDetailsOverseas    ALTER COLUMN QtyPerUOM float
ALTER TABLE Operation.GoodsReceiveDetailsOverseas    ADD CONSTRAINT DF_GoodsReceiveDetailsOverseas_QtyPerUOM DEFAULT 0 FOR Quantity  WITH VALUES
ALTER TABLE Operation.GoodsReceiveDetailsOverseas    ADD CONSTRAINT DF_GoodsReceiveDetailsOverseas_Quantity DEFAULT 0 FOR QtyPerUOM WITH VALUES


ALTER TABLE Operation.GoodsReceivePODetail    DROP CONSTRAINT DF_GoodsReceivePODetail_ReceiveQuantity
ALTER TABLE Operation.GoodsReceivePODetail    ALTER COLUMN Quantity float
ALTER TABLE Operation.GoodsReceivePODetail    ALTER COLUMN ReceiveQuantity float
ALTER TABLE Operation.GoodsReceivePODetail    ADD CONSTRAINT DF_GoodsReceivePODetail_ReceiveQuantity  DEFAULT 0 FOR ReceiveQuantity WITH VALUES

ALTER TABLE Operation.InspectionDomestic    DROP CONSTRAINT DF_InspectionDomestic_Qty
ALTER TABLE Operation.InspectionDomestic    ALTER COLUMN Qty float
ALTER TABLE Operation.InspectionDomestic    ADD CONSTRAINT DF_InspectionDomestic_Qty  DEFAULT 0 FOR Qty WITH VALUES




ALTER TABLE Operation.InspectionOverSeas    DROP CONSTRAINT DF_InspectionOverSeas_ReceivedQty
ALTER TABLE Operation.InspectionOverSeas    DROP CONSTRAINT DF_InspectionOverSeas_InspectionQty
ALTER TABLE Operation.InspectionOverSeas    DROP CONSTRAINT DF_InspectionOverSeas_PurchaseReceivedQty
ALTER TABLE Operation.InspectionOverSeas    ALTER COLUMN ReceivedQty float
ALTER TABLE Operation.InspectionOverSeas    ALTER COLUMN InspectionQty float
ALTER TABLE Operation.InspectionOverSeas    ALTER COLUMN PurchaseReceivedQty float
ALTER TABLE Operation.InspectionOverSeas    ADD CONSTRAINT DF_InspectionOverSeas_ReceivedQty  DEFAULT 0 FOR ReceivedQty WITH VALUES
ALTER TABLE Operation.InspectionOverSeas    ADD CONSTRAINT DF_InspectionOverSeas_InspectionQty  DEFAULT 0 FOR InspectionQty WITH VALUES
ALTER TABLE Operation.InspectionOverSeas    ADD CONSTRAINT DF_InspectionOverSeas_PurchaseReceivedQty  DEFAULT 0 FOR PurchaseReceivedQty WITH VALUES


ALTER TABLE Operation.InvoiceDetail    DROP CONSTRAINT DF_InvoiceDetail_Quantity
ALTER TABLE Operation.InvoiceDetail    ALTER COLUMN Quantity float
ALTER TABLE Operation.InvoiceDetail    ADD CONSTRAINT DF_InvoiceDetail_Quantity  DEFAULT 0 FOR Quantity WITH VALUES



ALTER TABLE Operation.OrderDetail    DROP CONSTRAINT DF_OrderDetail_Quantity
ALTER TABLE Operation.OrderDetail    ALTER COLUMN Quantity float
ALTER TABLE Operation.OrderDetail    ADD CONSTRAINT DF_OrderDetail_Quantity  DEFAULT 0 FOR Quantity WITH VALUES



ALTER TABLE Operation.PurchaseOrderDetail    ALTER COLUMN Quantity float

ALTER TABLE Operation.SIDetail    ALTER COLUMN Quantity float

ALTER TABLE Operation.StockAdjustmentDetail    ALTER COLUMN Quantity float

ALTER TABLE Operation.StockInDetail    DROP CONSTRAINT DF_StockInDetail_OutQuantity
ALTER TABLE Operation.StockInDetail    ALTER COLUMN Quantity float
ALTER TABLE Operation.StockInDetail    ALTER COLUMN OutQuantity float
ALTER TABLE Operation.StockInDetail    ADD CONSTRAINT DF_StockInDetail_OutQuantity  DEFAULT 0 FOR OutQuantity WITH VALUES

ALTER TABLE Operation.StockLedger    DROP CONSTRAINT DF_StockLedger_Quantity
ALTER TABLE Operation.StockLedger    ALTER COLUMN Quantity float
ALTER TABLE Operation.StockLedger    ADD CONSTRAINT DF_StockLedger_Quantity  DEFAULT 0 FOR Quantity WITH VALUES



