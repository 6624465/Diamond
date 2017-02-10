using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NetStock.DataFactory
{
    public static class DBRoutine
    {

        
		/// <summary>
		/// [Master].[Address]
		/// </summary>
		 
		public const string  SELECTADDRESS = "[Master].[usp_AddressSelect]";
		public const string  LISTADDRESS = "[Master].[usp_AddressList]";
		public const string  SAVEADDRESS = "[Master].[usp_AddressSave]";
		public const string  DELETEADDRESS = "[Master].[usp_AddressDelete]";
        public const string  CONTACTLISTBYCUSTOMER = "[Master].[usp_ContactListByCustomer]";


        
		/// <summary>
		/// [Master].[Branch]
		/// </summary>
		 
		public const string  SELECTBRANCH = "[Master].[usp_BranchSelect]";
		public const string  LISTBRANCH = "[Master].[usp_BranchList]";
		public const string  SAVEBRANCH = "[Master].[usp_BranchSave]";
		public const string  DELETEBRANCH = "[Master].[usp_BranchDelete]";
        public const string LISTBRANCHBYCOMPANY = "[Master].[usp_BranchListByCompany]";


		/// <summary>
		/// [Master].[Company]
		/// </summary>
		 
		public const string  SELECTCOMPANY = "[Master].[usp_CompanySelect]";
		public const string  LISTCOMPANY = "[Master].[usp_CompanyList]";
		public const string  SAVECOMPANY = "[Master].[usp_CompanySave]";
		public const string  DELETECOMPANY = "[Master].[usp_CompanyDelete]";


		/// <summary>
		/// [Master].[Country]
		/// </summary>
		 
		public const string  SELECTCOUNTRY = "[Master].[usp_CountrySelect]";
		public const string  LISTCOUNTRY = "[Master].[usp_CountryList]";
		public const string  SAVECOUNTRY = "[Master].[usp_CountrySave]";
		public const string  DELETECOUNTRY = "[Master].[usp_CountryDelete]";



        
		/// <summary>
		/// [Master].[Customer]
		/// </summary>
		 
		public const string  SELECTCUSTOMER = "[Master].[usp_CustomerSelect]";
		public const string  LISTCUSTOMER = "[Master].[usp_CustomerList]";
		public const string  SAVECUSTOMER = "[Master].[usp_CustomerSave]";
		public const string  DELETECUSTOMER = "[Master].[usp_CustomerDelete]";


		/// <summary>
		/// [Master].[CustomerProduct]
		/// </summary>
		 
		public const string  SELECTCUSTOMERPRODUCT = "[Master].[usp_CustomerProductSelect]";
		public const string  LISTCUSTOMERPRODUCT = "[Master].[usp_CustomerProductList]";
		public const string  SAVECUSTOMERPRODUCT = "[Master].[usp_CustomerProductSave]";
		public const string  DELETECUSTOMERPRODUCT = "[Master].[usp_CustomerProductDelete]";
		public const string  DELETEALLCUSTOMERPRODUCT = "[Master].[usp_CustomerProductDeleteAll]";


        /// <summary>
        /// [Master].[ProductCategory]
        /// </summary>

        public const string SELECTPRODUCTCATEGORY = "[Master].[usp_ProductCategorySelect]";
        public const string LISTPRODUCTCATEGORY = "[Master].[usp_ProductCategoryList]";
        public const string SAVEPRODUCTCATEGORY = "[Master].[usp_ProductCategorySave]";
        public const string DELETEPRODUCTCATEGORY = "[Master].[usp_ProductCategoryDelete]";



		/// <summary>
		/// [Master].[Product]
		/// </summary>
		 
		public const string  SELECTPRODUCT = "[Master].[usp_ProductSelect]";
		public const string  LISTPRODUCT = "[Master].[usp_ProductList]";
		public const string  SAVEPRODUCT = "[Master].[usp_ProductSave]";
		public const string  DELETEPRODUCT = "[Master].[usp_ProductDelete]";
        public const string SELECTPRODUCTBYBARCODEORDESCRIPTION = "[Master].[usp_ProductSelectByBarCodeOrDescription]";
        public const string SELECTSUPPLIERPRODUCTBYBARCODEORDESCRIPTION = "[Master].[usp_SupplierProductSelectByBarCodeOrDescription]";
        public const string PRODUCTCHECKDUPLICATE = "[Master].[usp_ProductCheckDuplicate]";

        
        

        /// <summary>
        /// [Master].[ProductImage]
        /// </summary>

        public const string SAVEPRODUCTIMAGE = "[Master].[usp_ProductImageSave]";
        public const string SELECTPRODUCTIMAGE = "[Master].[usp_ProductImageSelect]";
        public const string DELETEPRODUCTIMAGE = "[Master].[usp_ProductImageDelete]";
        
		/// <summary>
		/// [Master].[QuotationItem]
		/// </summary>
		 
		public const string  SELECTQUOTATIONITEM = "[Master].[usp_QuotationItemSelect]";
		public const string  LISTQUOTATIONITEM = "[Master].[usp_QuotationItemList]";
		public const string  SAVEQUOTATIONITEM = "[Master].[usp_QuotationItemSave]";
        public const string DELETEQUOTATIONITEMALL = "[Master].[usp_QuotationItemDeleteAll]";
        public const string DELETEQUOTATIONITEM = "[Master].[usp_QuotationItemDelete]";

        public const string LISTQUOTATIONPRODUCTPRICE = "[Master].[usp_QuotationGetProductPrice]";


        public const string GETSUPPLIERPRODUCTPRICE = "[Master].[usp_GetSupplierProductPrice]";
        

		/// <summary>
		/// [Master].[Quotation]
		/// </summary>
		 
		public const string  SELECTQUOTATION = "[Master].[usp_QuotationSelect]";
		public const string  LISTQUOTATION = "[Master].[usp_QuotationList]";
		public const string  SAVEQUOTATION = "[Master].[usp_QuotationSave]";
		public const string  DELETEQUOTATION = "[Master].[usp_QuotationDelete]";
        public const string CHECKDUPLICATE = "[Master].[usp_QuotationIsDuplicate]";



		/// <summary>
		/// [Operation].[InvoiceDetail]
		/// </summary>
		 
		public const string  SELECTINVOICEDETAIL = "[Operation].[usp_InvoiceDetailSelect]";
		public const string  LISTINVOICEDETAIL = "[Operation].[usp_InvoiceDetailList]";
		public const string  SAVEINVOICEDETAIL = "[Operation].[usp_InvoiceDetailSave]";
		public const string  DELETEINVOICEDETAIL = "[Operation].[usp_InvoiceDetailDelete]";


		/// <summary>
		/// [Operation].[InvoiceHeader]
		/// </summary>
		 
		public const string  SELECTINVOICEHEADER = "[Operation].[usp_InvoiceHeaderSelect]";
		public const string  LISTINVOICEHEADER = "[Operation].[usp_InvoiceHeaderList]";
		public const string  SAVEINVOICEHEADER = "[Operation].[usp_InvoiceHeaderSave]";
		public const string  DELETEINVOICEHEADER = "[Operation].[usp_InvoiceHeaderDelete]";

        public const string LISTUNBILLEDORDERS = "[Operation].[usp_UnbilledInvoices]";
        public const string INVOICEINQUIRY = "[Operation].[usp_InvoiceInquiry]";
        public const string LISTUNAPPROVEDINVOICES = "[Operation].[usp_UnApprovedInvoices]";

        public const string APPROVEINVOICE = "[Operation].[usp_InvoiceApproval]";
        public const string UNBILLEDORDERS = "[Operation].[usp_UnBilledInvoiceList]";

        public const string GETINVOICENOBYORDERNO = "[Operation].[usp_GetInvoiceNoByOrderNo]";

        
        


		/// <summary>
		/// [Operation].[OrderHeader]
		/// </summary>
		 
		public const string  SELECTORDERHEADER = "[Operation].[usp_OrderHeaderSelect]";
		public const string  LISTORDERHEADER = "[Operation].[usp_OrderHeaderList]";
		public const string  SAVEORDERHEADER = "[Operation].[usp_OrderHeaderSave]";
		public const string  DELETEORDERHEADER = "[Operation].[usp_OrderHeaderDelete]";



        
		/// <summary>
		/// [Operation].[OrderDetail]
		/// </summary>
		 
		public const string  SELECTORDERDETAIL = "[Operation].[usp_OrderDetailSelect]";
		public const string  LISTORDERDETAIL = "[Operation].[usp_OrderDetailList]";
		public const string  SAVEORDERDETAIL = "[Operation].[usp_OrderDetailSave]";
		public const string  DELETEORDERDETAIL = "[Operation].[usp_OrderDetailDelete]";


        public const string GETPRODUCTPRICE = "[Master].[usp_GetProductPrice]";


		/// <summary>
		/// [Operation].[StockInHeader]
		/// </summary>
		 
		public const string  SELECTSTOCKINHEADER = "[Operation].[usp_StockInHeaderSelect]";
		public const string  LISTSTOCKINHEADER = "[Operation].[usp_StockInHeaderList]";
		public const string  SAVESTOCKINHEADER = "[Operation].[usp_StockInHeaderSave]";
		public const string  DELETESTOCKINHEADER = "[Operation].[usp_StockInHeaderDelete]";


		/// <summary>
		/// [Operation].[StockInDetail]
		/// </summary>
		 
		public const string  SELECTSTOCKINDETAIL = "[Operation].[usp_StockInDetailSelect]";
		public const string  LISTSTOCKINDETAIL = "[Operation].[usp_StockInDetailList]";
		public const string  SAVESTOCKINDETAIL = "[Operation].[usp_StockInDetailSave]";
		public const string  DELETESTOCKINDETAIL = "[Operation].[usp_StockInDetailDelete]";


        public const string GETPOBYSUPPLIERCODE = "[Operation].[usp_GetPOBySupplierCode]";
        public const string GETSTOCKINBYPENDINGQTY = "[Operation].[usp_StockInDetailSelectPendingQty]";




        /// <summary>
        /// [Operation].[GoodsReceiveHeader]
        /// </summary>

        public const string SELECTGOODSRECEIVEHEADER = "[Operation].[usp_GoodsReceiveHeaderSelect]";
        public const string LISTGOODSRECEIVEHEADER = "[Operation].[usp_GoodsReceiveHeaderList]";
        public const string SAVEGOODSRECEIVEHEADER = "[Operation].[usp_GoodsReceiveHeaderSave]";
        public const string DELETEGOODSRECEIVEHEADER = "[Operation].[usp_GoodsReceiveHeaderDelete]";
        public const string GOODSRECEIVEDASHBOARDATA = "[Report].[usp_GoodsReceiveDashboard]";
        public const string SEARCHGOODSRECEIVEBYPO = "[Operation].[usp_SearchGoodsReceiveHeaderByPO]";


        

        /// <summary>
        /// [Operation].[GoodsReceiveDetail]
        /// </summary>

        public const string SAVEGOODSRECEIVEDETAIL = "[Operation].[usp_GoodsReceiveDetailSave]";
        public const string DELETEGOODSRECEIVEDETAIL = "[Operation].[usp_GoodsReceiveDetailDelete]";
        public const string SELECTGOODSRECEIVEDETAIL = "[Operation].[usp_GoodsReceiveDetailSelect]";
        public const string LISTGOODSRECEIVEDETAIL = "[Operation].[usp_GoodsReceiveDetailList]";

        /// <summary>
        /// [Operation].[GoodsReceiveDetailsOverseas]
        /// </summary>

        public const string SELECTGOODSRECEIVEDETAILSOVERSEAS = "[Operation].[usp_GoodsReceiveDetailsOverseasSelect]";
        public const string LISTGOODSRECEIVEDETAILSOVERSEAS = "[Operation].[usp_GoodsReceiveDetailsOverseasList]";
        public const string SAVEGOODSRECEIVEDETAILSOVERSEAS = "[Operation].[usp_GoodsReceiveDetailsOverseasSave]";
        public const string DELETEGOODSRECEIVEDETAILSOVERSEAS = "[Operation].[usp_GoodsReceiveDetailsOverseasDelete]";

        /// <summary>
        /// [Operation].[InspectionDomestic]
        /// </summary>

        public const string SELECTINSPECTIONDOMESTIC = "[Operation].[usp_InspectionDomesticSelect]";
        public const string LISTINSPECTIONDOMESTIC = "[Operation].[usp_InspectionDomesticList]";
        public const string SAVEINSPECTIONDOMESTIC = "[Operation].[usp_InspectionDomesticSave]";
        public const string DELETEINSPECTIONDOMESTIC = "[Operation].[usp_InspectionDomesticDelete]";
        public const string DELETEINSPECTIONDOMESTICALL = "[Operation].[usp_InspectionDomesticDeleteALL]";



        /// <summary>
        /// [Operation].[InspectionOverSeas]
        /// </summary>

        public const string SELECTINSPECTIONOVERSEAS = "[Operation].[usp_InspectionOverSeasSelect]";
        public const string LISTINSPECTIONOVERSEAS = "[Operation].[usp_InspectionOverSeasList]";
        public const string SAVEINSPECTIONOVERSEAS = "[Operation].[usp_InspectionOverSeasSave]";
        public const string DELETEINSPECTIONOVERSEAS = "[Operation].[usp_InspectionOverSeasDelete]";
        
		/// <summary>
		/// [Operation].[StockLedger]
		/// </summary>
		 
		public const string  SELECTSTOCKLEDGER = "[Operation].[usp_StockLedgerSelect]";
		public const string  LISTSTOCKLEDGER = "[Operation].[usp_StockLedgerList]";
		public const string  SAVESTOCKLEDGER = "[Operation].[usp_StockLedgerSave]";
        public const string DELETESTOCKLEDGER = "[Operation].[usp_StockLedgerDelete]";
        public const string STOCKINQUIRY = "[Operation].[usp_StockInquiry]";
        public const string GETPRODUCTCURRENTSTOCK = "[Operation].[usp_GetProductCurrentStock]";
        


        /// <summary>
        /// [Config].[Lookup]
        /// </summary>

        public const string SELECTLOOKUP = "[Config].[usp_LookupSelect]";
        public const string LISTLOOKUP = "[Config].[usp_LookupList]";
        public const string SAVELOOKUP = "[Config].[usp_LookupSave]";
        public const string DELETELOOKUP = "[Config].[usp_LookupDelete]";

        /// <summary>
        /// [Master].[Currency]
        /// </summary>

        public const string SELECTCURRENCY = "[Master].[usp_CurrencySelect]";
        public const string LISTCURRENCY = "[Master].[usp_CurrencyList]";
        public const string SAVECURRENCY = "[Master].[usp_CurrencySave]";
        public const string DELETECURRENCY = "[Master].[usp_CurrencyDelete]";



		/// <summary>
		/// [Master].[Location]
		/// </summary>
		 
		public const string  SELECTLOCATION = "[Master].[usp_LocationSelect]";
		public const string  LISTLOCATION = "[Master].[usp_LocationList]";
		public const string  SAVELOCATION = "[Master].[usp_LocationSave]";
		public const string  DELETELOCATION = "[Master].[usp_LocationDelete]";


        /// <summary>
        /// [Operation].[PurchaseOrderHeader]
        /// </summary>

        public const string SAVEPURCHASEORDERHEADER = "[Operation].[usp_PurchaseOrderHeaderSave]";
        public const string DELETEPURCHASEORDERHEADER = "[Operation].[usp_PurchaseOrderHeaderDelete]";
        public const string SELECTPURCHASEORDERHEADER = "[Operation].[usp_PurchaseOrderHeaderSelect]";
        public const string LISTPURCHASEORDERHEADER = "[Operation].[usp_PurchaseOrderHeaderList]";

        public const string PURCHASEORDERBYSUPPLIER = "[Operation].[usp_PurchaseOrderBySupplier]";


        /// <summary>
        /// [Operation].[PurchaseOrderDetail]
        /// </summary>

        public const string SELECTPURCHASEORDERDETAIL = "[Operation].[usp_PurchaseOrderDetailSelect]";
        public const string LISTPURCHASEORDERDETAIL = "[Operation].[usp_PurchaseOrderDetailList]";
        public const string SAVEPURCHASEORDERDETAIL = "[Operation].[usp_PurchaseOrderDetailSave]";
        public const string DELETEPURCHASEORDERDETAIL = "[Operation].[usp_PurchaseOrderDetailDelete]";


        /// <summary>
        /// [Security].[Users]
        /// </summary>

        public const string SELECTUSERS = "[Security].[usp_UsersSelect]";
        public const string LISTUSERS = "[Security].[usp_UsersList]";
        public const string SAVEUSERS = "[Security].[usp_UsersSave]";
        public const string DELETEUSERS = "[Security].[usp_UsersDelete]";


        /// <summary>
        /// [Operation].[StockAdjustmentHeader]
        /// </summary>

        public const string SELECTSTOCKADJUSTMENTHEADER = "[Operation].[usp_StockAdjustmentHeaderSelect]";
        public const string LISTSTOCKADJUSTMENTHEADER = "[Operation].[usp_StockAdjustmentHeaderList]";
        public const string SAVESTOCKADJUSTMENTHEADER = "[Operation].[usp_StockAdjustmentHeaderSave]";
        public const string DELETESTOCKADJUSTMENTHEADER = "[Operation].[usp_StockAdjustmentHeaderDelete]";

        /// <summary>
        /// [Operation].[StockAdjustmentDetail]
        /// </summary>

        public const string SELECTSTOCKADJUSTMENTDETAIL = "[Operation].[usp_StockAdjustmentDetailSelect]";
        public const string LISTSTOCKADJUSTMENTDETAIL = "[Operation].[usp_StockAdjustmentDetailList]";
        public const string SAVESTOCKADJUSTMENTDETAIL = "[Operation].[usp_StockAdjustmentDetailSave]";
        public const string DELETESTOCKADJUSTMENTDETAIL = "[Operation].[usp_StockAdjustmentDetailDelete]";


        /// <summary>
        /// [Operation].[SIHeader]
        /// </summary>

        public const string SELECTSIHEADER = "[Operation].[usp_SIHeaderSelect]";
        public const string LISTSIHEADER = "[Operation].[usp_SIHeaderList]";
        public const string SAVESIHEADER = "[Operation].[usp_SIHeaderSave]";
        public const string DELETESIHEADER = "[Operation].[usp_SIHeaderDelete]";


        /// <summary>
        /// [Operation].[SIDetail]
        /// </summary>

        public const string SELECTSIDETAIL = "[Operation].[usp_SIDetailSelect]";
        public const string LISTSIDETAIL = "[Operation].[usp_SIDetailList]";
        public const string SAVESIDETAIL = "[Operation].[usp_SIDetailSave]";
        public const string DELETESIDETAIL = "[Operation].[usp_SIDetailDelete]";


        public const string SELECTGOODSRECEIVEPODETAIL = "[Operation].[usp_GoodsReceivePODetailSelect]";
        public const string LISTGOODSRECEIVEPODETAIL = "[Operation].[usp_GoodsReceivePODetailList]";
        public const string SAVEGOODSRECEIVEPODETAIL = "[Operation].[usp_GoodsReceivePODetailSave]";
        public const string DELETEGOODSRECEIVEPODETAIL = "[Operation].[usp_GoodsReceivePODetailDelete]";
        public const string SELECTGOODSRECEIVEDETAILPENDINGLIST = "[Operation].[usp_GoodsReceivePODetailPendingList]";


        /// <summary>
        /// [Operation].[GoodsIssue]
        /// </summary>
        public const string SELECTGOODSISSUE = "[Operation].[usp_GoodsIssueSelect]";
        public const string LISTGOODSISSUE = "[Operation].[usp_GoodsIssueList]";
        public const string SAVEGOODSISSUE = "[Operation].[usp_GoodsIssueSave]";
        public const string DELETEGOODSISSUE = "[Operation].[usp_GoodsIssueDelete]";

        public const string GOODSISSUEDASHBOARDATA = "[Report].[usp_GoodsIssueDashboard]";
        

        /// <summary>
        /// [Operation].[GoodsIssueDetail]
        /// </summary>
        public const string SELECTGOODSISSUEDETAIL = "[Operation].[usp_GoodsIssueDetailSelect]";
        public const string LISTGOODSISSUEDETAIL = "[Operation].[usp_GoodsIssueDetailList]";
        public const string SAVEGOODSISSUEDETAIL = "[Operation].[usp_GoodsIssueDetailSave]";
        public const string DELETEGOODSISSUEDETAIL = "[Operation].[usp_GoodsIssueDetailDelete]";

        /// <summary>
        /// [Operation].[DASHBOARD]
        /// </summary>
        //public const string GOODSISSUEDASHBOARDATA = "[Report].[usp_GoodsIssueDashboard]";
        public const string MONTHLYFIGUREDASHBOARDATA = "[Report].[usp_MonthlyFigureDashboard]";


        /// <summary>
        /// [Config].[SystemWideConfiguration]
        /// </summary>

        public const string SELECTSYSTEMWIDECONFIGURATION = "[Config].[usp_SystemWideConfigurationSelect]";
        public const string LISTSYSTEMWIDECONFIGURATION = "[Config].[usp_SystemWideConfigurationList]";
        public const string DELETESYSTEMWIDECONFIGURATION = "[Config].[usp_SystemWideConfigurationDelete]";
        public const string SAVESYSTEMWIDECONFIGURATION = "[Config].[usp_SystemWideConfigurationSave]";

        /// <summary>
        /// [Operation].[OrderIssueHeader]
        /// </summary>

        public const string SELECTORDERISSUEHEADER = "[Operation].[usp_OrderIssueHeaderSelect]";
        public const string LISTORDERISSUEHEADER = "[Operation].[usp_OrderIssueHeaderList]";
        public const string SAVEORDERISSUEHEADER = "[Operation].[usp_OrderIssueHeaderSave]";
        public const string DELETEORDERISSUEHEADER = "[Operation].[usp_OrderIssueHeaderDelete]";
        public const string SEARCHORDERISSUEBYREFNO = "[Operation].[usp_SearchOrderIssueHeaderByReferenceNo]";
        /// <summary>
        /// [Operation].[OrderIssueDetail]
        /// </summary>

        public const string SELECTORDERISSUEDETAIL = "[Operation].[usp_OrderIssueDetailSelect]";
        public const string LISTORDERISSUEDETAIL = "[Operation].[usp_OrderIssueDetailList]";
        public const string SAVEORDERISSUEDETAIL = "[Operation].[usp_OrderIssueDetailSave]";
        public const string DELETEORDERISSUEDETAIL = "[Operation].[usp_OrderIssueDetailDelete]";
        public const string SELECTORDERISSUEDETAILPENDINGLIST = "[Operation].[usp_OrderIssueDetailPendingList]";


    }
}
