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

import '../../helper_utils/ui_utils.dart';
import '../../locators.dart';
import '../../model/request/post_fabric_request/create_fabric_request_model.dart';


List<TextEditingController> textFieldControllers = [];
GlobalKey<FormState> wrapFormKey = GlobalKey<FormState>();

warpSheet(BuildContext context,FabricSetting? fabricSetting,FabricCreateRequestModel? fabricCreateRequestModel, Function callback)
{
  showModalBottomSheet<int>(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
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
                                          value: fabricCreateRequestModel!.fs_warp_count,
                                          label:'Warp Count',
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: fabricSetting!.warpCountMinMax??'n/a',
                                          onSaved: (input) {
                                            fabricCreateRequestModel!.fs_warp_count = input;
                                          })
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height:10.w ,),
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(fabricSetting!.showWarpPly),
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
                                          value: fabricCreateRequestModel!.fs_warp_ply_idfk ,
                                          errorText: 'Warp Ply',
                                          label: 'Warp Ply',
                                          onSaved: (input) {
                                            fabricCreateRequestModel!.fs_warp_ply_idfk = input;
                                          })
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height:10.w ,),
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(fabricSetting!.showNoOfEndsWarp),
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
                                          value: fabricCreateRequestModel!.fs_no_of_ends_warp,
                                          label:'No of Ends',
                                          errorText: 'No of Ends',
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: fabricSetting!.noOfEndsWarpMinMax??'n/a',
                                          onSaved: (input) {
                                            fabricCreateRequestModel!.fs_no_of_ends_warp = input;
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
                                  if (validateAndSaveWrap()) {


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



