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
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';

import '../../helper_utils/app_constants.dart';
import '../../helper_utils/top_round_corners.dart';
import '../../helper_utils/ui_utils.dart';
import '../../locators.dart';
import '../../model/request/post_ad_request/create_request_model.dart';
import '../../model/request/post_fabric_request/create_fabric_request_model.dart';
import '../list_widgets/single_select_tile_widget.dart';


List<TextEditingController> textFieldControllers = [];
GlobalKey<FormState> plyFormKey = GlobalKey<FormState>();

fabricPlySheet(
    BuildContext context,
    FabricSetting? _fabricSettings,
    FabricCreateRequestModel? _createRequestModel,
    Function callback,
    List<FabricPly> _plyList,
    String familyId,
    )
{

  String? selectedPlyId;
  if(_createRequestModel!.fs_ply_idfk !=null){
    selectedPlyId = _createRequestModel.fs_ply_idfk;
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
                decoration: getRoundedTopCorners(),
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

                              // Count
                              Visibility(
                                visible: Ui.showHide(_fabricSettings!.showCount),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // modified by (asad_m)
//                                            Padding(
//                                                padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
//                                                child: TitleSmallTextWidget(title: count + '*')),
                                    SizedBox(height:12.w ,),
                                    YgTextFormFieldWithRangeNonDecimal(
                                        errorText: count,
                                        label: count,
                                        // onChanged:(value) => globalFormKey.currentState!.reset(),
                                        value: _createRequestModel.fs_count,
                                        minMax: _fabricSettings.countMinMax!,
                                        maxLength: 3,
                                        autoFocus: true,
                                        onSaved: (input) {
                                          _createRequestModel.fs_count = input;
                                        })
                                  ],
                                ),
                              ),
                              //Show Ply
                              Visibility(
                                visible: Ui.showHide(_fabricSettings.showPly),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 0.w,top: 4,bottom: 4),
                                          child: TitleSmallBoldTextWidget(title: ply + '*')),
                                      SingleSelectTileWidget(
                                        selectedIndex: _createRequestModel.fs_ply_idfk == null
                                            ? -1 :  _plyList.where((element) =>
                                        element.fabricFamilyIdfk == familyId)
                                            .toList().indexWhere((element) => element.fabricPlyId.toString() == _createRequestModel.fs_ply_idfk),
                                        spanCount: 3,
                                        listOfItems: _plyList.where((element) =>
                                        element.fabricFamilyIdfk == familyId)
                                            .toList(),
                                        callback: (FabricPly value) {
                                          /*_createRequestModel.fs_ply_idfk =
                                              value.fabricPlyId.toString();*/
                                          selectedPlyId = value.fabricPlyId.toString();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //Show Once
                              Visibility(
                                visible: Ui.showHide(_fabricSettings.showOnce),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Modified by (asad_m)
//                                        Padding(
//                                            padding: EdgeInsets.only(
//                                                left: 8.w,bottom: 4),
//                                            child: const TitleSmallTextWidget(
//                                                title: 'Once')),
                                      SizedBox(height:12.w ,),
                                      YgTextFormFieldWithRangeNonDecimal(
                                          errorText: 'Once',
                                          label: 'Once',
                                          minMax: _fabricSettings.onceMinMax??'n/a',
                                          value: _createRequestModel.fs_once,
                                          onSaved: (input) {
                                            _createRequestModel.fs_once =
                                                input;
                                          }),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //Show GSM
                              Visibility(
                                visible: Ui.showHide(_fabricSettings.showGsm),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      //Modified by (asad_m)
//                                        Padding(
//                                            padding: EdgeInsets.only(
//                                                left: 8.w,bottom: 4),
//                                            child: const TitleSmallTextWidget(
//                                                title: 'GSM')),
                                      SizedBox(height:12.w ,),
                                      YgTextFormFieldWithRangeNonDecimal(
                                          errorText: 'GSM',
                                          label: 'GSM',
                                          minMax: _fabricSettings.gsmCountMinMax??'n/a',
                                          value: _createRequestModel.fs_gsm_count,
                                          onSaved: (input) {
                                            _createRequestModel.fs_gsm_count = input;
                                          }),
                                      SizedBox(
                                        width: 16.w,
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
                                  if (validationAllPage(_createRequestModel,_fabricSettings,contextBuilder,selectedPlyId)) {
                                    //showDoublingMethod.dispose();
                                    FocusScope.of(context).unfocus();
                                    _createRequestModel.fs_ply_idfk = selectedPlyId;
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

bool validationAllPage(FabricCreateRequestModel createRequestModel, FabricSetting fabricSetting, BuildContext context, String? selectedPlyId) {
  if (validateAndSavePly()) {
    if ((selectedPlyId == null || selectedPlyId == '') &&
        Ui.showHide(fabricSetting.showPly)) {
      Fluttertoast.showToast(msg: 'Please Select Ply');
      return false;
    }else{
      return true;
    }
  }
  return false;
}




