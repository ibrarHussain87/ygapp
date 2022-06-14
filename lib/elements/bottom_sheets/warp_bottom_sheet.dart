import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

import '../../helper_utils/top_round_corners.dart';
import '../../helper_utils/ui_utils.dart';
import '../../model/request/post_fabric_request/create_fabric_request_model.dart';
import '../list_widgets/single_select_tile_widget.dart';


List<TextEditingController> textFieldControllers = [];
GlobalKey<FormState> wrapFormKey = GlobalKey<FormState>();

warpSheet(BuildContext context,FabricSetting? fabricSetting,
    FabricCreateRequestModel? fabricCreateRequestModel, Function callback, String familyId, List<FabricPly> plyList)
{

  String? selectedWarpPlyId;
  if(fabricCreateRequestModel!.fs_warp_ply_idfk !=null){
    selectedWarpPlyId = fabricCreateRequestModel.fs_warp_ply_idfk;
  }


  showModalBottomSheet<int>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                decoration: getRoundedTopCorners(),
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 15.0,right: 15.0),
//              height: MediaQuery.of(context).size.height/1.5,
                child: Form(
                  key: wrapFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              "Enter Warp Details",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18.0.sp,
                                  color: headingColor,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          const Divider(color: Colors.black12,),
                          SizedBox(height:20.w ,),
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(fabricSetting!.showWarpCount),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Modified by (asad_m)
//                                            Padding(
//                                                padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
//                                                child: const TitleSmallTextWidget(title: 'Warp Count' + '*')),
//
                                      SizedBox(height:12.w ,),
                                      YgTextFormFieldWithRangeNonDecimal(
                                          errorText: 'Warp Count',
                                          value: fabricCreateRequestModel.fs_warp_count,
                                          label:'Warp Count',
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: fabricSetting.warpCountMinMax??'n/a',
                                          maxLength: 3,
                                          autoFocus: true,
                                          onSaved: (input) {
                                            fabricCreateRequestModel.fs_warp_count = input;
                                          })
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                          /*SizedBox(height:10.w ,),
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(fabricSetting.showWarpPly),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Modified by (asad_m)
//                                            Padding(
//                                                padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
//                                                child: const TitleSmallTextWidget(title: 'Warp Count' + '*')),
//
                                      SizedBox(height:12.w ,),
                                      YgTextFormFieldWithoutRange(
                                          value: fabricCreateRequestModel.fs_warp_ply_idfk ,
                                          errorText: 'Warp Ply',
                                          label: 'Warp Ply',
                                          onSaved: (input) {
                                            fabricCreateRequestModel.fs_warp_ply_idfk = input;
                                          })
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),*/
                          //Show Warp Ply
                          Visibility(
                            visible: Ui.showHide(fabricSetting.showWarpPly),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 0.w,top: 4,bottom: 4),
                                      child: const TitleSmallBoldTextWidget(title: 'Warp Ply*')),
                                  SingleSelectTileWidget(
                                    selectedIndex: fabricCreateRequestModel.fs_warp_ply_idfk == null
                                        ? -1 :  plyList.where((element) =>
                                    element.fabricFamilyIdfk == familyId)
                                        .toList().indexWhere((element) =>
                                    element.fabricPlyId.toString() == fabricCreateRequestModel.fs_warp_ply_idfk &&
                                    element.fabricPlyType == '1'),
                                    spanCount: 3,
                                    listOfItems: plyList.where((element) =>
                                    element.fabricFamilyIdfk == familyId && element.fabricPlyType == '1')
                                        .toList(),
                                    callback: (FabricPly value) {
                                      /*_createRequestModel.fs_ply_idfk =
                                              value.fabricPlyId.toString();*/
                                      selectedWarpPlyId = value.fabricPlyId.toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height:10.w ,),
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(fabricSetting.showNoOfEndsWarp),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // modified by (asad_m)
//                                            Padding(
//                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                                                child: const TitleSmallTextWidget(title: 'No of Ends' + '*')),
                                      SizedBox(height:12.w ,),
                                      YgTextFormFieldWithRangeNonDecimal(
                                          value: fabricCreateRequestModel.fs_no_of_ends_warp,
                                          label:'No of Ends',
                                          errorText: 'No of Ends',
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: fabricSetting.noOfEndsWarpMinMax??'n/a',
                                          onSaved: (input) {
                                            fabricCreateRequestModel.fs_no_of_ends_warp = input;
                                          })
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
                            return TextButton(
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
                                  if (validationAllPage(fabricSetting,selectedWarpPlyId)) {
                                    FocusScope.of(context).unfocus();
                                    fabricCreateRequestModel.fs_warp_ply_idfk = selectedWarpPlyId;
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

bool validateAndSaveWrap() {
  final form = wrapFormKey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  }
  return false;
}


bool validationAllPage(FabricSetting fabricSetting, String? selectedPlyId) {
  if (validateAndSaveWrap()) {
    if ((selectedPlyId == null || selectedPlyId == '') &&
        Ui.showHide(fabricSetting.showWarpPly)) {
      Fluttertoast.showToast(msg: 'Please Select Warp Ply');
      return false;
    }else{
      return true;
    }
  }
  return false;
}


