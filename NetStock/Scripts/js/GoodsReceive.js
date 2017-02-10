function frmGoodsReceiveOverseasModalValidation() {
    $("#frmGoodsReceiveOverseasModal").bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            isObj_ReceivedDate: {
                validators: {
                    notEmpty: {
                        message: 'The Received Date is required and cannot be empty'
                    }
                }
            },
            isObj_SupplierName: {
                validators: {
                    notEmpty: {
                        message: 'The Supplier Name is required and cannot be empty'
                    }
                }
            },
            isObj_ReceivedTime: {
                validators: {
                    notEmpty: {
                        message: 'The Received Time is required and cannot be empty'
                    }
                }
            },
            isObj_InspectionQty: {
                validators: {
                    notEmpty: {
                        message: 'The Inspection Quantity is required and cannot be empty'
                    }
                }
            },
            isObj_InvoiceNo: {
                validators: {
                    notEmpty: {
                        message: 'The InvoiceNo is required and cannot be empty'
                    }
                }
            },
            isObj_ChemicalName: {
                validators: {
                    notEmpty: {
                        message: 'The Chemical Name is required and cannot be empty'
                    }
                }
            },
            isObj_PINo: {
                validators: {
                    notEmpty: {
                        message: 'The PIN Number is required and cannot be empty'
                    }
                }
            },
            isObj_PONo: {
                validators: {
                    notEmpty: {
                        message: 'The PON Number is required and cannot be empty'
                    }
                }
            },
            isObj_ReceivedQty: {
                validators: {
                    notEmpty: {
                        message: 'The Received Quantity is required and cannot be empty'
                    }
                }
            }
        }
    });
}

$(function () {
    //$('#frmgoodsReveiveModal').bootstrapValidator({
    //    message: 'This value is not valid',
    //    feedbackIcons: {
    //        valid: 'glyphicon glyphicon-ok',
    //        invalid: 'glyphicon glyphicon-remove',
    //        validating: 'glyphicon glyphicon-refresh'
    //    },
    //    fields: {
    //        modalObj_ProductCode: {
    //            validators: {
    //                notEmpty: {
    //                    message: 'The Product Code is required and cannot be empty'
    //                }
    //            },
    //            modalObj_Qty: {
    //                validators: {
    //                    numeric: {
    //                        message: 'Quantity must be a numeric'
    //                    }
    //                }
    //            }
    //        }
    //    }
    //});

    //$('#frmgoodsReveiveModal').validate({
    //    rules: {

    //    }
    //});


    //$('#frmgoodsReveiveModalOver').bootstrapValidator({
    //    message: 'This value is not valid',
    //    feedbackIcons: {
    //        valid: 'glyphicon glyphicon-ok',
    //        invalid: 'glyphicon glyphicon-remove',
    //        validating: 'glyphicon glyphicon-refresh'
    //    },
    //    fields: {
    //        modalObj_ProductCode: {
    //            validators: {
    //                notEmpty: {
    //                    message: 'The Product Code is required and cannot be empty'
    //                }
    //            },
    //            modalObj_Quantity: {
    //                validators: {
    //                    numeric: {
    //                        message: 'Quantity must be a numeric'
    //                    }
    //                }
    //            },
    //            modalObj_UOM: {
    //                validators: {
    //                    numeric: {
    //                        message: 'The UOM is required and cannot be empty'
    //                    }
    //                }
    //            },
    //            modalObj_QtyPerUOM: {
    //                validators: {
    //                    numeric: {
    //                        message: 'Quantity per UOM is required and cannot be empty'
    //                    }
    //                }
    //            },
    //            modalObj_ContainerNo: {
    //                validators: {
    //                    numeric: {
    //                        message: 'Container Number is required and cannot be empty'
    //                    }
    //                }
    //            }
    //        }
    //    }
    //});


    $("#isObj_IsSpecifyBatchNo").change(function () {

        if ($('#isObj_IsSpecifyBatchNo').val() == 1) {
            $('#isObj_BatchNo').prop("disabled", false);
        } else if ($('#isObj_IsSpecifyBatchNo').val() == 0) {
            $('#isObj_BatchNo').prop("disabled", true);
        }
    });

    $("#isObj_IsCOAManufactureDate").change(function () {

        if ($('#isObj_IsCOAManufactureDate').val() == 1) {
            $('#isObj_ManufacturerDate').prop("disabled", false);
        } else if ($('#isObj_IsCOAManufactureDate').val() == 0) {
            $('#isObj_ManufacturerDate').prop("disabled", true);
        }
    });

   
    $("#isObj_IsCOAExpiryDate").change(function () {

        if ($('#isObj_IsCOAExpiryDate').val() == 1) {
            $('#isObj_ExpiryDate').prop("disabled", false);
        } else if ($('#isObj_IsCOAExpiryDate').val() == 0) {
            $('#isObj_ExpiryDate').prop("disabled", true);
        }
    });

  
    $("#isObj_AcceptStatus").change(function () {

        if ($('#isObj_AcceptStatus').val() != "" && $('#isObj_AcceptStatus').val() != null) {
            $('#isObj_AcceptRemarks').prop("disabled", false);
        } else  {
            $('#isObj_AcceptRemarks').prop("disabled", true);
        }
    });

    $("#isObj_BagCondition").change(function () {

        if ($('#isObj_BagCondition').val() != "" && $('#isObj_BagCondition').val() != null) {
            $('#isObj_BagWeight').prop("disabled", false);
        } else {
            $('#isObj_BagWeight').prop("disabled", true);
        }
    });
  
});


function btnAddInspection() {
    //debugger;
    //var validator = $('#frmGoodsReceiveOverseasModal').data('bootstrapValidator');
    //validator.validate();
    //if (validator.isValid()) {

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
}

    //$('#insData').val(JSON.stringify(Obj));
//}

function EditGRInspectionOverseas(index) {
    var isEleExists = $('#InspectionOverSeasList_' + index).length > 0;
    if (isEleExists) {
        var insObj = JSON.parse($('#InspectionOverSeasList_' + index).val());

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
    frmGoodsReceiveOverseasModalValidation();
    $('#inspectionModal').modal('show');
}


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

    frmGoodsReceiveOverseasModalValidation();
    $('#goodsReveiveModal').modal('show');
    $('#hdnFlag').val(index);
}
