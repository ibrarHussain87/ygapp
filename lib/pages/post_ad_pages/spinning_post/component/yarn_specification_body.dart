import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class YarnSpecificationComponent extends StatefulWidget {
  final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  final Function? callback;

  const YarnSpecificationComponent(
      {Key? key,
      this.callback,
      required this.yarnSyncResponse,
      required this.locality,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  YarnSpecificationComponentState createState() =>
      YarnSpecificationComponentState();
}

class YarnSpecificationComponentState extends State<YarnSpecificationComponent>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // int _selectedMaterialIndex = 0;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  YarnSetting? _yarnSetting;
  FiberRequestModel? _fiberRequestModel;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _fiberRequestModel = Provider.of<FiberRequestModel?>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.only(top: 16.w, left: 24.w, right: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Padding(
                     padding: EdgeInsets.only(left: 8.w),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                       TitleTextWidget(
                         title: AppStrings.specifications,
                       ),
                       Padding(
                         padding: EdgeInsets.only(top: 2.w),
                         child: Text(
                           AppStrings.selectSpecifications,
                           style: TextStyle(
                               fontSize: 11.sp, color: Colors.grey.shade600),
                         ),
                       ),
                     ],),
                   ),
                    Form(
                      key: globalFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: AppStrings.grades)),
                                GridTileWidget(
                                  spanCount: 3,
                                  listOfItems:
                                      widget.yarnSyncResponse.data.yarn.grades,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Ratio')),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: AppColors.lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        // onSaved: (input) =>
                                        // _fiberRequestModel!
                                        //     .spc_lot_number = input!,
                                        // validator: (input) {
                                        //   if (input == null ||
                                        //       input.isEmpty) {
                                        //     return "Enter Lot Number";
                                        //   }
                                        //   return null;
                                        // },
                                        decoration: roundedTextFieldDecoration(
                                            'Ratio')),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Count')),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: AppColors.lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        // onSaved: (input) =>
                                        // _fiberRequestModel!
                                        //     .spc_lot_number = input!,
                                        // validator: (input) {
                                        //   if (input == null ||
                                        //       input.isEmpty) {
                                        //     return "Enter Lot Number";
                                        //   }
                                        //   return null;
                                        // },
                                        decoration: roundedTextFieldDecoration(
                                            'Count')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Texturized Yarn Type')),
                                GridTileWidget(
                                  spanCount: 3,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.grades,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Dannier')),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: AppColors.lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        // onSaved: (input) =>
                                        // _fiberRequestModel!
                                        //     .spc_lot_number = input!,
                                        // validator: (input) {
                                        //   if (input == null ||
                                        //       input.isEmpty) {
                                        //     return "Enter Lot Number";
                                        //   }
                                        //   return null;
                                        // },
                                        decoration: roundedTextFieldDecoration(
                                            'Dannier')),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Filament')),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: AppColors.lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        // onSaved: (input) =>
                                        // _fiberRequestModel!
                                        //     .spc_lot_number = input!,
                                        // validator: (input) {
                                        //   if (input == null ||
                                        //       input.isEmpty) {
                                        //     return "Enter Lot Number";
                                        //   }
                                        //   return null;
                                        // },
                                        decoration: roundedTextFieldDecoration(
                                            'Filament')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Ply')),
                                GridTileWidget(
                                  spanCount: 4,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.ply,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Orientation')),
                                GridTileWidget(
                                  spanCount: 2,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.orientation,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Usage')),
                                GridTileWidget(
                                  spanCount: 2,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.usage,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Pattern')),
                                GridTileWidget(
                                  spanCount: 3,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.pattern,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Pattern Charectristics')),
                                GridTileWidget(
                                  spanCount: 2,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.usage,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Twist Direction')),
                                GridTileWidget(
                                  spanCount: 2,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.twistDirection,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Spun Technique')),
                                GridTileWidget(
                                  spanCount: 4,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.spunTechnique,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Quality')),
                                GridTileWidget(
                                  spanCount: 2,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.quality,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Certification')),
                                GridTileWidget(
                                  spanCount: 4,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.certification,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Color Treatment Method')),
                                GridTileWidget(
                                  spanCount: 2,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.colorTreatmentMethod,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Dying Method')),
                                GridTileWidget(
                                  spanCount: 2,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.dyingMethod,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Appearence')),
                                GridTileWidget(
                                  spanCount: 2,
                                  listOfItems:
                                  widget.yarnSyncResponse.data.yarn.apperance,
                                  callback: (value) {
                                    _fiberRequestModel!.spc_grade_idfk = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .grades[value]
                                        .grdId
                                        .toString();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButtonWithIcon(
                  callback: () {
                    // if (validationAllPage()) {
                    //   _fiberRequestModel!.spc_category_idfk = widget
                    //       .syncFiberResponse
                    //       .data
                    //       .fiber
                    //       .material[_selectedMaterialIndex]
                    //       .fbmCategoryIdfk;
                    //
                    //   _fiberRequestModel!.spc_fiber_material_idfk = widget
                    //       .syncFiberResponse
                    //       .data
                    //       .fiber
                    //       .material[_selectedMaterialIndex]
                    //       .fbmId
                    //       .toString();
                    //   widget.callback!(1);
                    // }
                  },
                  color: AppColors.btnColorLogin,
                  btnText: "Next",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  querySettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {
      value.yarnSettingsDao
          .findYarnSettings(widget.yarnSyncResponse.data.yarn.blends[id].blnId)
          .then((value) {
        setState(() {
          _yarnSetting = value[0];
        });
      });
    });
  }
}

// bool validateAndSave() {
//   final form = globalFormKey.currentState;
//   if (form!.validate()) {
//     form.save();
//     return true;
//   }
//   return false;
// }
