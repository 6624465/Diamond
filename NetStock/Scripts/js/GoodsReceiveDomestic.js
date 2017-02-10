function frmGoodsReceiveDomesticModalValidation() {
    $("#frmgoodsReveiveModal").bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {


            modalObj_ProductCode: {
                validators: {
                    notEmpty: {
                        message: 'Product Code is required and cannot be empty'
                    }
                }
            },
            modalObj_Qty: {
                validators: {
                    notEmpty: {
                        message: 'Quantity is required and cannot be empty'
                    }
                }
            },
            modalObj_UOM: {
                validators: {
                    notEmpty: {
                        message: 'U O M is required and cannot be empty'
                    }
                }
            }
        }
    });
}



function btnAddInspection() {
    debugger;
    var insCount = $('.insCss').length;

    var Obj = {
        ReceivedDate: $('#isObj_ReceivedDate').val(),
        SupplierName: $('#isObj_SupplierName').val(),
        ChemicalName: $('#isObj_ChemicalName').val(),
        InspectionDate: $('#isObj_InspectionDate').val(),
        SupplierType: $('#isObj_SupplierType').val(),
        PINo: $('#isObj_PINo').val(),
        ReceivedTime: $('#isObj_ReceivedTime').val(),
        IsRequireLabour: $('#isObj_IsRequireLabour').val(),
        ReceivedQty: $('#isObj_ReceivedQty').val(),
        InspectionQty: $('#isObj_InspectionQty').val(),
        InvoiceNo: $('#isObj_InvoiceNo').val(),
        PONo: $('#isObj_PONo').val(),
        ReceivedQty: $('#isObj_ReceivedQty').val(),
        COASupplier: $('#isObj_COASupplier').val(),
        //IsRequireLabour: $('#isObj_IsRequireLabour').val(),
        BatchNo: $('#isObj_BatchNo').val(),
        IsSpecifyBatchNo: $('#isObj_IsSpecifyBatchNo').val(),
        ManufacturerDate: $('#isObj_ManufacturerDate').val(),
        IsCOAManufactureDate: $('#isObj_IsCOAManufactureDate').val(),
        ExpiryDate: $('#isObj_ExpiryDate').val(),
        IsCOAExpiryDate: $('#isObj_IsCOAExpiryDate').val(),
        TestResult: $('#isObj_TestResult').val(),
        InspectionResult: $('#isObj_InspectionResult').val(),
        Manufacturer: $('#isObj_Manufacturer').val(),
        ContainerNo: $('#isObj_ContainerNo').val(),
        ContainerType: $('#isObj_ContainerType').val(),
        StoreQtyBatchNo: $('#isObj_StoreQtyBatchNo').val(),
        Homogenious: $('#isObj_Homogenious').val(),
        IsGoodCondition: $('#isObj_IsGoodCondition').val(),
        IsSameAsSampleProduct: $('#isObj_IsSameAsSampleProduct').val(),
        IsWet: $('#isObj_IsWet').val(),
        ChemicalCondition: $('#isObj_ChemicalCondition').val(),
        ContaminationRemarks: $('#isObj_ContaminationRemarks').val(),
        AcceptStatus: $('#isObj_AcceptStatus').val(),
        AcceptRemarks: $('#isObj_AcceptRemarks').val(),
        BagWeight: $('#isObj_BagWeight').val(),
        BagCondition: $('#isObj_BagCondition').val()
    };

    var hdnInsVal = parseInt($('#hdnInsFlag').val());
    debugger;
    if (hdnInsVal != -1) {
        insCount = hdnInsVal;
        $('#hdnInsFlag').val('-1');
        $('#InspectionOverSeasList_' + insCount).val(JSON.stringify(Obj));
    }
    else {
        debugger;
        $('<input>').attr({
            type: 'hidden',
            id: 'InspectionOverSeasList_' + insCount,
            name: 'obj.InspectionOverSeasList[' + insCount + ']',
            value: JSON.stringify(Obj),
            'class': 'insCss'
        }).appendTo('#InspectionOverseasArea');
    }
    $('#checkSheetModal').modal('hide');
    //$('#insData').val(JSON.stringify(Obj))
}
var parentFlag = -1;
function PEditInspectionDomestic(index) {
    debugger;
    $('.domesticRowCss').find('.form-control').val('');
    $('#dCantMelt, #dNotClean').removeAttr('checked');
    $('#tblDomesticBody').empty();
    sessionStorage.removeItem('SsnTempDomestic');
    var isEleExists = $('#InspectionDomesticList_' + index).length > 0;
    if (isEleExists) {
        var jsonData = JSON.parse($('#InspectionDomesticList_' + index).val());

        $('#dinspectorDate').val($('#InspectionDomesticList_' + index + '_inpectionDate').val());
        $('#dinspectorName').val($('#InspectionDomesticList_' + index + '_inspectorName').val());
        $('#dproductName').val($('#InspectionDomesticList_' + index + '_productName').val());

        for (var i = 0; i < jsonData.length; i++) {
            var obj = jsonData[i];
            var htmlRow = '<tr class="tblDomenticCss">';
            htmlRow += '<td>' + obj.dbatchNo + '</td>';
            htmlRow += '<td>' + obj.dQty + '</td>';
            htmlRow += '<td>' + obj.dUom + '</td>';
            htmlRow += '<td>' + obj.dColor + '</td>';
            htmlRow += '<td>' + obj.dWeight + '</td>';
            htmlRow += '<td>' + obj.dPhlevel + '</td>';
            htmlRow += '<td><a style="cursor:pointer" onclick="tblEditDomestic(' + i + ')">Edit</a>&nbsp;|&nbsp;<a style="cursor:pointer" onclick="tblCancelDomestic(' + i + ')">Cancel</a></td>';
            htmlRow += '</tr>';
            $(htmlRow).appendTo('#tblDomesticBody');
        }

        sessionStorage.setItem('SsnTempDomestic', JSON.stringify(jsonData));
    }
    else {
        $('#dproductName').val($('#GoodsReceiveDetails_' + index + '__ProductCode').val());
    }

    $('#inspectionModal').modal('show');
    parentFlag = index;
}

function EditInspectionOverseas(index) {
    var isEleExists = $('#InspectionOverSeasList_' + index).length > 0;
    if (isEleExists) {
        var insObj = JSON.parse($('#InspectionOverSeasList_' + index).val());
        debugger;
        $('#isObj_ReceivedDate').val(insObj.ReceivedDate);
        $('#isObj_SupplierName').val(insObj.SupplierName);
        $('#isObj_ChemicalName').val(insObj.ChemicalName);
        $('#isObj_InspectionDate').val(insObj.InspectionDate);
        $('#isObj_SupplierType').val(insObj.SupplierType);
        $('#isObj_PINo').val(insObj.PINo);
        $('#isObj_ReceivedTime').val(insObj.ReceivedTime);
        $('#isObj_IsRequireLabour').val(insObj.IsRequireLabour);
        $('#isObj_ReceivedQty').val(insObj.ReceivedQty);
        $('#isObj_InspectionQty').val(insObj.InspectionQty);
        $('#isObj_InvoiceNo').val(insObj.InvoiceNo);
        $('#isObj_PONo').val(insObj.PONo);
        $('#isObj_ReceivedQty').val(insObj.ReceivedQty);
        $('#isObj_COASupplier').val(insObj.COASupplier);
        $('#isObj_BatchNo').val(insObj.BatchNo);
        $('#isObj_IsSpecifyBatchNo').val(insObj.IsSpecifyBatchNo);
        $('#isObj_ManufacturerDate').val(insObj.ManufacturerDate);
        $('#isObj_IsCOAManufactureDate').val(insObj.IsCOAManufactureDate);
        $('#isObj_ExpiryDate').val(insObj.ExpiryDate);
        $('#isObj_IsCOAExpiryDate').val(insObj.IsCOAExpiryDate);
        $('#isObj_TestResult').val(insObj.TestResult);
        $('#isObj_InspectionResult').val(insObj.InspectionResult);
        $('#isObj_Manufacturer').val(insObj.Manufacturer);
        $('#isObj_ContainerNo').val(insObj.ContainerNo);
        $('#isObj_ContainerType').val(insObj.ContainerType);
        $('#isObj_StoreQtyBatchNo').val(insObj.StoreQtyBatchNo);
        $('#isObj_Homogenious').val(insObj.Homogenious);
        $('#isObj_IsGoodCondition').val(insObj.IsGoodCondition);
        $('#isObj_IsSameAsSampleProduct').val(insObj.IsSameAsSampleProduct);
        $('#isObj_IsWet').val(insObj.IsWet);
        $('#isObj_ChemicalCondition').val(insObj.ChemicalCondition);
        $('#isObj_ContaminationRemarks').val(insObj.ContaminationRemarks);
        $('#isObj_AcceptStatus').val(insObj.AcceptStatus);
        $('#isObj_AcceptRemarks').val(insObj.AcceptRemarks);
        $('#isObj_BagWeight').val(insObj.BagWeight);
        $('#isObj_BagCondition').val(insObj.BagCondition);

        $('#hdnInsFlag').val(index);
    }
    else {

        $('#inspectionModalBody').find('.form-control').val('');
        $('#hdnInsFlag').val('-1');
    }
}
/*
function EditGoodsReceiveOverseasDetails(index) {    

    $('#modalObj_ProductCode').val($('#GoodsReceiveDetailsOverseasList_' + index + '__ProductCode').val());
    $('#modalObj_Quantity').val($('#GoodsReceiveDetailsOverseasList_' + index + '__Quantity').val());
    $('#modalObj_UOM').val($('#GoodsReceiveDetailsOverseasList_' + index + '__UOM').val());
    $('#modalObj_ContainerNo').val($('#GoodsReceiveDetailsOverseasList_' + index + '__ContainerNo').val());

    $('.ContainerConditionCss').removeClass('checked');
    $('.ContainerConditionCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__ContainerCondition').val() + '"]').addClass('checked');

    $('.SealConditionCss').removeClass('checked');
    $('.SealConditionCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__SealCondition').val() + '"]').addClass('checked');

    $('#modalObj_SealNo').val($('#GoodsReceiveDetailsOverseasList_' + index + '__SealNo').val());

    $('.isSortCss').removeClass('checked');
    $('.isSortCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__IsSort').val() + '"]').addClass('checked');

    $('.isFCLCss').removeClass('checked');
    $('.isFCLCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__IsFCL').val() + '"]').addClass('checked');

    $('.isHumidityCss').removeClass('checked');
    $('.isHumidityCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__IsHumidity').val() + '"]').addClass('checked');

    $('.isProperPackageCss').removeClass('checked');
    $('.isProperPackageCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__IsProperPackage').val() + '"]').addClass('checked');

    $('#modalObj_DamageDetails').val($('#GoodsReceiveDetailsOverseasList_' + index + '__DamageDetails').val());
    $('#modalObj_SortRemarks').val($('#GoodsReceiveDetailsOverseasList_' + index + '__SortRemarks').val());

    $('.isCleanCss').removeClass('checked');
    $('.isCleanCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__IsClean').val() + '"]').addClass('checked');

    $('.isCompressedCss').removeClass('checked');
    $('.isCompressedCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__IsCompressed').val() + '"]').addClass('checked');

    $('.isCorrectWeightCss').removeClass('checked');
    $('.isCorrectWeightCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__IsCorrectWeight').val() + '"]').addClass('checked');

    $('.isProductLabelCss').removeClass('checked');
    $('.isProductLabelCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__IsProductLabel').val() + '"]').addClass('checked');

    $('.isInspectContainerCss').removeClass('checked');
    $('.isInspectContainerCss[data-value="' + $('#GoodsReceiveDetailsOverseasList_' + index + '__IsInspectContainer').val() + '"]').addClass('checked');

    $('#goodsReveiveModal').modal('show');
    $('#hdnFlag').val(index);
}
*/
function DeleteGoodsReceiveOverseasDetails(index) {

}

function EditInspectionDomestic() {

}

function btnAddDomesticRow() {

}

function addDomesticItem() {
    debugger;
    var rowCount = $('.tblDomenticCss').length;
    var obj = {
        dbatchNo: $('#dbatchNo').val(),
        dQty: $('#dQty').val(),
        dUom: $('#dUom').val(),
        dColor: $('#dColor').val(),
        dWeight: $('#dWeight').val(),
        dMeltingMin: $('#dMeltingMin').val(),
        dCantMelt: $('#dCantMelt').is(':checked'),
        dCleanAfter: $('#dCleanAfter').val(),
        dNotClean: $('#dNotClean').is(':checked'),
        dPhlevel: $('#dPhlevel').val(),
        dRemarks: $('#dRemarks').val()
    }

    if (domesticFlag == -1) {
        var htmlRow = '<tr class="tblDomenticCss">';
        htmlRow += '<td>' + obj.dbatchNo + '</td>';
        htmlRow += '<td>' + obj.dQty + '</td>';
        htmlRow += '<td>' + obj.dUom + '</td>';
        htmlRow += '<td>' + obj.dColor + '</td>';
        htmlRow += '<td>' + obj.dWeight + '</td>';
        htmlRow += '<td>' + obj.dPhlevel + '</td>';
        htmlRow += '<td><a style="cursor:pointer" onclick="tblEditDomestic(' + rowCount + ')">Edit</a>&nbsp;|&nbsp;<a style="cursor:pointer" onclick="tblCancelDomestic(' + rowCount + ')">Cancel</a></td>';
        htmlRow += '</tr>';
        $(htmlRow).appendTo('#tblDomesticBody');

        var data = sessionStorage.getItem('SsnTempDomestic');
        if (typeof data == 'undefined' || data == null) {
            var arr = new Array();
            arr.push(obj);
            sessionStorage.setItem('SsnTempDomestic', JSON.stringify(arr))
        }
        else {
            var jsonArr = JSON.parse(data);
            jsonArr.push(obj);
            sessionStorage.setItem('SsnTempDomestic', JSON.stringify(jsonArr))
        }
    }
    else {
        var data = sessionStorage.getItem('SsnTempDomestic');
        var jsonArr = JSON.parse(data);
        //debugger;
        for (var i = 0; i < jsonArr.length; i++) {
            if (i == domesticFlag) {
                jsonArr[i].dbatchNo = $('#dbatchNo').val();
                jsonArr[i].dQty = $('#dQty').val();
                jsonArr[i].dUom = $('#dUom').val();
                jsonArr[i].dColor = $('#dColor').val();
                jsonArr[i].dWeight = $('#dWeight').val();
                jsonArr[i].dMeltingMin = $('#dMeltingMin').val();
                jsonArr[i].dCantMelt = $('#dCantMelt').is(':checked');
                jsonArr[i].dCleanAfter = $('#dCleanAfter').val();
                jsonArr[i].dNotClean = $('#dNotClean').is(':checked');
                jsonArr[i].dPhlevel = $('#dPhlevel').val();
                jsonArr[i].dRemarks = $('#dRemarks').val();

                break;
            }
        }

        sessionStorage.setItem('SsnTempDomestic', JSON.stringify(jsonArr))
        domesticFlag = -1;
    }
    $('.domesticRowCss').find('.form-control').val('');
    $('#dCantMelt, #dNotClean').removeAttr('checked');

}

var domesticFlag = -1;
function tblEditDomestic(index) {
    //debugger;
    var tblData = JSON.parse(sessionStorage.getItem('SsnTempDomestic'));
    var rowData = tblData[index];

    $('#dbatchNo').val(rowData.dbatchNo);
    $('#dQty').val(rowData.dQty);
    $('#dUom').val(rowData.dUom);
    $('#dColor').val(rowData.dColor);
    $('#dWeight').val(rowData.dWeight);
    $('#dMeltingMin').val(rowData.dMeltingMin);

    if (rowData.dCantMelt) {
        $('#dCantMelt').attr('checked', 'checked');
    }

    $('#dCleanAfter').val(rowData.dCleanAfter);

    if (rowData.dNotClean) {
        $('#dNotClean').attr('checked', 'checked');
    }

    $('#dPhlevel').val(rowData.dPhlevel);
    $('#dRemarks').val(rowData.dRemarks);

    domesticFlag = index;
}

function tblCancelDomestic(index) {
    domesticFlag = -1;

    $('.domesticRowCss').find('.form-control').val('');
    $('#dCantMelt, #dNotClean').removeAttr('checked');
}

function cancelDomenticItem() {
    $('.domesticRowCss').find('.form-control').val('');
    $('#dCantMelt, #dNotClean').removeAttr('checked');
}

function btnAddSsnToHdn() {
    debugger;
    var insCount = parentFlag;
    var isExists = $('#InspectionDomesticList_' + parentFlag).length > 0;
    if (sessionStorage.getItem('SsnTempDomestic') != null && sessionStorage.getItem('SsnTempDomestic') != '') {
        var jsonData = JSON.parse(sessionStorage.getItem('SsnTempDomestic'));
        if (!isExists) {
            insCount = $('.insCss').length;
            $('<input>').attr({
                type: 'hidden',
                id: 'InspectionDomesticList_' + insCount,
                name: 'obj.InspectionDomesticList[' + insCount + ']',
                value: JSON.stringify(jsonData),
                'class': 'insCss'
            }).appendTo('#InspectionDomesticArea');

            $('<input>').attr({
                type: 'hidden',
                id: 'InspectionDomesticList_' + insCount + '_inpectionDate',
                value: $('#dinspectorDate').val()
            }).appendTo('#InspectionDomesticArea');

            $('<input>').attr({
                type: 'hidden',
                id: 'InspectionDomesticList_' + insCount + '_inspectorName',
                value: $('#dinspectorName').val()
            }).appendTo('#InspectionDomesticArea');

            $('<input>').attr({
                type: 'hidden',
                id: 'InspectionDomesticList_' + insCount + '_productName',
                value: $('#dproductName').val()
            }).appendTo('#InspectionDomesticArea');
        }
        else {
            insCount = parentFlag;
            $('#InspectionDomesticList_' + insCount).val(JSON.stringify(jsonData));
            $('#InspectionDomesticList_' + insCount + '_inpectionDate').val($('#dinspectorDate').val());
            $('#InspectionDomesticList_' + insCount + '_inspectorName').val($('#dinspectorName').val());
            $('#InspectionDomesticList_' + insCount + '_productName').val($('#dproductName').val());

        }
    }

    sessionStorage.removeItem('SsnTempDomestic');
    parentFlag = -1;
    $('#inspectionModal').modal('hide');
    $('#dinspectorDate, #dinspectorName, #dproductName').val('');
}