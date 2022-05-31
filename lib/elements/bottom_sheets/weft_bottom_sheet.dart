import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

import '../../helper_utils/top_round_corners.dart';
import '../../helper_utils/ui_utils.dart';
import '../../model/request/post_fabric_request/create_fabric_request_model.dart';
import '../list_widgets/single_select_tile_widget.dart';
import '../title_text_widget.dart';


List<TextEditingController> textFieldControllers = [];
GlobalKey<FormState> weftFormKey = GlobalKey<FormState>();

weftSheet(BuildContext context,FabricSetting? fabricSetting,FabricCreateRequestModel? fabricCreateRequestModel,
    Function callback, String familyId, List<FabricPly> plyList)
{

  String? selectedWeftPlyId;
  if(fabricCreateRequestModel!.fs_weft_ply_idfk !=null){
    selectedWeftPlyId = fabricCreateRequestModel.fs_weft_ply_idfk;
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
                  key: weftFormKey,
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
                              "Enter Weft Details",
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
                                visible: Ui.showHide(fabricSetting!.showWeftCount),
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
                                          errorText: 'Weft Count',
                                          value: fabricCreateRequestModel.fs_weft_count,
                                          label:'Weft Count',
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: fabricSetting.weftCountMinMax??'n/a',
                                          maxLength: 3,
                                          autoFocus: true,
                                          onSaved: (input) {
                                            fabricCreateRequestModel.fs_weft_count = input;
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
                                visible: Ui.showHide(fabricSetting.showWeftPly),
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
                                          value: fabricCreateRequestModel.fs_weft_ply_idfk ,
                                          errorText: 'Weft Ply',
                                          label: 'Weft Ply',
                                          onSaved: (input) {
                                            fabricCreateRequestModel.fs_weft_ply_idfk = input;
                                          })
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),*/
                          //Show Warp Ply
                          Visibility(
                            visible: Ui.showHide(fabricSetting.showWeftPly),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 0.w,top: 4,bottom: 4),
                                      child: const TitleSmallBoldTextWidget(title: 'Weft Ply' + '*')),
                                  SingleSelectTileWidget(
                                    selectedIndex: fabricCreateRequestModel.fs_weft_ply_idfk == null
                                        ? -1 :  plyList.where((element) =>
                                    element.fabricFamilyIdfk == familyId)
                                        .toList().indexWhere((element) => element.fabricPlyId.toString() == fabricCreateRequestModel.fs_weft_ply_idfk),
                                    spanCount: 3,
                                    listOfItems: plyList.where((element) =>
                                    element.fabricFamilyIdfk == familyId)
                                        .toList(),
                                    callback: (FabricPly value) {
                                      /*_createRequestModel.fs_ply_idfk =
                                              value.fabricPlyId.toString();*/
                                      selectedWeftPlyId = value.fabricPlyId.toString();
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
                                visible: Ui.showHide(fabricSetting.showNoOfPickWeft),
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
                                          value: fabricCreateRequestModel.fs_no_of_pick_weft,
                                          label:'No of Picks',
                                          errorText: 'No of Picks',
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: fabricSetting.noOfPickWeftMinMax??'n/a',
                                          onSaved: (input) {
                                            fabricCreateRequestModel.fs_no_of_pick_weft = input;
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
                                  if (validationAllPage(fabricSetting,selectedWeftPlyId)) {
                                    FocusScope.of(context).unfocus();
                                    fabricCreateRequestModel.fs_weft_ply_idfk = selectedWeftPlyId;
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

bool validateAndSaveWeft() {
  final form = weftFormKey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  }
  return false;
}

bool validationAllPage(FabricSetting fabricSetting, String? selectedPlyId) {
  if (validateAndSaveWeft()) {
    if ((selectedPlyId == null || selectedPlyId == '') &&
        Ui.showHide(fabricSetting.showWeftPly)) {
      Fluttertoast.showToast(msg: 'Please Select Weft Ply');
      return false;
    }else{
      return true;
    }
  }
  return false;
}

