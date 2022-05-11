import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/fabric_bottom_sheet.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/providers/post_yarn_provider.dart';

import '../../helper_utils/app_constants.dart';
import '../../helper_utils/ui_utils.dart';
import '../../locators.dart';
import '../../model/request/post_ad_request/create_request_model.dart';
import '../../model/request/post_fabric_request/create_fabric_request_model.dart';
import '../list_widgets/single_select_tile_widget.dart';


GlobalKey<FormState> plyFormKey = GlobalKey<FormState>();

yarnSpecsSheet(BuildContext context,YarnSetting? _yarnSetting,
    CreateRequestModel? _createRequestModel,
    Function callback,
    String _selectedFamilyId,
    List<Ply> _plyList,
    List<OrientationTable> _orientationList,
    List<DoublingMethod> _doublingMethodList,
    List<int> _plyIdList,
    )
{

  final ValueNotifier<bool> showDoublingMethod = ValueNotifier(false);
  String? _selectedPlyId;

  if(_createRequestModel!.ys_ply_idfk != null){
    if (!_plyIdList.contains(int.parse(_createRequestModel.ys_ply_idfk!))) {
      showDoublingMethod.value = true;
      _selectedPlyId = _createRequestModel.ys_ply_idfk;
    } else {
      showDoublingMethod.value = false;
      _createRequestModel.ys_doubling_method_idFk = null;
    }
  }

  showModalBottomSheet<int>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext contextBuilder, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                /*padding: const EdgeInsets.only(left: 15.0,right: 15.0),*/
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 15.0,right: 15.0),
//              height: MediaQuery.of(context).size.height/1.5,
                child: Form(
                  key: plyFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Column(
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.close),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              "Enter Ply Details",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18.0.sp,
                                  color: headingColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const Divider(color: Colors.black12,),
                          SizedBox(height:2.w ,),
                          Column(
                            children: [

                              //Show Dannier
                              Visibility(
                                visible: Ui.showHide(_yarnSetting!.showDannier),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 8.w,
                                      ),
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w),
//                            child: TitleSmallBoldTextWidget(title: dannier + '*')),
                                      YgTextFormFieldWithRangeNonDecimal(
                                          onSaved: (input) =>
                                          _createRequestModel.ys_dty_filament = input!,
                                          value: _createRequestModel.ys_dty_filament,
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: _yarnSetting.dannierMinMax!,
                                          label: dannier,
                                          errorText: dannier),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                              // Show Filament
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showFilament),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8.w,
                                      ),
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w),
//                            child: TitleSmallTextWidget(title: filament + '*')),
                                      YgTextFormFieldWithRangeNonDecimal(
                                        minMax: _yarnSetting.filamentMinMax!,
                                        onSaved: (input) =>
                                        _createRequestModel.ys_fdy_filament = input!,
                                        value: _createRequestModel.ys_fdy_filament,
                                        // onChanged:(value) => globalFormKey.currentState!.reset(),
                                        errorText: filament,
                                        label: filament,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Count
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showCount),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                            child: TitleSmallTextWidget(title: count + '*')),
                                      SizedBox(
                                        height: 12.w,
                                      ),
                                      YgTextFormFieldWithRangeNonDecimal(
                                          errorText: count,
                                          label: count,
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          value: _createRequestModel.ys_count,
                                          minMax: _yarnSetting.countMinMax!,
                                          onSaved: (input) {
                                            _createRequestModel.ys_count = input;
                                          })
                                    ],
                                  ),
                                ),
                              ),

                              //Show Ply
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showPly),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                                          child: TitleSmallBoldTextWidget(title: ply + '*')),
                                      SingleSelectTileWidget(
                                        selectedIndex: _createRequestModel.ys_ply_idfk == null
                                            ? -1 : _plyList.where((element) =>
                                        element.familyId == _selectedFamilyId)
                                            .toList().indexWhere((element) => element.plyId.toString() == _createRequestModel.ys_ply_idfk),
                                        spanCount: 3,
                                        listOfItems: _plyList.where((element) =>
                                        element.familyId == _selectedFamilyId)
                                            .toList(),
                                        callback: (Ply value) {
                                          _createRequestModel.ys_ply_idfk =
                                              value.plyId.toString();
                                          if (!_plyIdList.contains(value.plyId)) {
                                              showDoublingMethod.value = true;
                                              _selectedPlyId = value.plyId.toString();
                                          } else {
                                              showDoublingMethod.value = false;
                                              _createRequestModel.ys_doubling_method_idFk = null;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //Here Doubling Method
                              ValueListenableBuilder(
                               valueListenable: showDoublingMethod,
                                builder: (context,bool showDoublingMethod,child){
                                  return Visibility(
                                    visible: showDoublingMethod
                                        ? Ui.showHide(_yarnSetting.showDoublingMethod)
                                        : false,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                                              child: const TitleSmallBoldTextWidget(
                                                  title: "Doubling Method" + '*')),
                                          SingleSelectTileWidget(
                                            selectedIndex: _createRequestModel.ys_doubling_method_idFk == null
                                                ? -1 :  _doublingMethodList.where((element) => element.plyId == _selectedPlyId)
                                                .toList().indexWhere((element) => element.dmId.toString() == _createRequestModel.ys_doubling_method_idFk),
                                            spanCount: 3,
                                            listOfItems: _doublingMethodList.where((element) => element.plyId == _selectedPlyId)
                                                .toList(),
                                            callback: (DoublingMethod value) {
                                              _createRequestModel.ys_doubling_method_idFk =
                                                  value.dmId.toString();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  }
                              ),
                              //Show Orientation
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showOrientation),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                                          child:
                                          TitleSmallBoldTextWidget(title: orientation + '*')),
                                      SingleSelectTileWidget(
                                        selectedIndex: _createRequestModel.ys_orientation_idfk == null
                                            ? -1 : _orientationList.where((element) =>
                                        element.familyId == _selectedFamilyId)
                                            .toList().indexWhere((element) => element.yoId.toString() == _createRequestModel.ys_orientation_idfk),
                                        spanCount: 2,
                                        listOfItems: _orientationList.where((element) =>
                                        element.familyId == _selectedFamilyId)
                                            .toList(),
                                        callback: (OrientationTable value) {
                                          _createRequestModel.ys_orientation_idfk =
                                              value.yoId.toString();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.w,),

                      SizedBox(
                          width: double.infinity,
                          child: Builder(builder: (BuildContext context1) {
                            return ElevatedButton(
                                child: Text("Done",
                                    style: TextStyle(
                                      /*fontFamily: 'Metropolis',*/ fontSize: 14.sp)),
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(
                                        Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        btnColorLogin),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(8)),
                                            side: BorderSide(
                                                color: Colors.transparent)))),
                                onPressed: () {
                                  if (validationAllPage(_createRequestModel,_yarnSetting,contextBuilder,showDoublingMethod.value)) {
                                    //showDoublingMethod.dispose();
                                    callback.call();
                                    Navigator.of(context).pop();
                                  }
                                });
                          })),
                    ],
                  ),
                ),
              ),
            );
          });
    },
  );



}

bool validateAndSavePly() {
  final form = plyFormKey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  }
  return false;
}

bool validationAllPage(CreateRequestModel createRequestModel, YarnSetting yarnSetting, BuildContext context, bool _showDoublingMethod) {
  if (validateAndSavePly()) {
    if (createRequestModel.ys_ply_idfk == null &&
        Ui.showHide(yarnSetting.showPly)) {
      Fluttertoast.showToast(msg: 'Please Select Ply');
    //  Ui.showSnackBar(context, 'Please Select Ply');
      return false;
    } else if (createRequestModel.ys_doubling_method_idFk == null &&
        _showDoublingMethod &&
        Ui.showHide(yarnSetting.showDoublingMethod)) {
      Fluttertoast.showToast(msg: 'Please Select Doubling Method');
    //  Ui.showSnackBar(context, 'Please Select Doubling Method');
      return false;
    } else if (createRequestModel.ys_orientation_idfk == null &&
        Ui.showHide(yarnSetting.showOrientation)) {
      Fluttertoast.showToast(msg: 'Please Select Orientation');
    //  Ui.showSnackBar(context, 'Please Select Orientation');
      return false;
    }else{
      return true;
    }
  }
  return false;
}




