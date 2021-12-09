import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class LabParameterPage extends StatefulWidget {
  final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const LabParameterPage(
      {Key? key,
      required this.yarnSyncResponse,
      required this.locality,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  _LabParameterPageState createState() => _LabParameterPageState();
}

class _LabParameterPageState extends State<LabParameterPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CreateRequestModel? _createRequestModel;
  YarnSetting? _yarnSetting;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _createRequestModel = Provider.of<CreateRequestModel?>(context);
    _yarnSetting = Provider.of<YarnSetting?>(context);
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
                            title: AppStrings.labParameters,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.w),
                            child: Text(
                              'Enter ${AppStrings.labParameters} details',
                              style: TextStyle(
                                  fontSize: 11.sp, color: Colors.grey.shade600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    Form(
                      key: globalFormKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title: AppStrings.actualYarnCount),
                                      margin: EdgeInsets.only(left: 8.w,top:8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return AppStrings.actualYarnCount;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.actualYarnCount))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: TitleSmallTextWidget(
                                            title: AppStrings.CLSP),
                                    margin: EdgeInsets.only(left: 8.w,top:8.w),),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return AppStrings.CLSP;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.CLSP)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'U% (Uniformity)%'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "U% (Uniformity)";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            'U% (Uniformity)')),
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
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'CV%'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter CV%";
                                          }
                                          return null;
                                        },
                                        decoration:
                                            roundedTextFieldDecoration('CV%')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: TitleSmallTextWidget(
                                    title:'QLT'),
                                margin: EdgeInsets.only(left: 8.w,top: 8.w),
                              ),
                              GridTileWidget(
                                  spanCount: 4,
                                  callback: (value) {},
                                  listOfItems: widget
                                      .yarnSyncResponse.data.yarn.spunTechnique),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'Thin Places'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter actual thin places";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            'Thin Places')),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'Thick Places'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please thick places";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            'Thick Places')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'Naps'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter Naps";
                                          }
                                          return null;
                                        },
                                        decoration:
                                            roundedTextFieldDecoration('Naps')),
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
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'IPM/KM'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),

                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter IPM/KM*";
                                          }
                                          return null;
                                        },
                                        decoration:
                                            roundedTextFieldDecoration('IPM/KM')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'H% (Hairness)'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter H% (Hairness)";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            'H% (Hairness)')),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'RKM'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter RKM";
                                          }
                                          return null;
                                        },
                                        decoration:
                                            roundedTextFieldDecoration('RKM')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'Elongation%'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter Elongation %";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            'Elongation %')),
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
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title:'TPI'),
                                      margin: EdgeInsets.only(left: 8.w,top: 8.w),
                                    ),
                                    TextFormField(
                                        keyboardType: TextInputType.text,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter TPI";
                                          }
                                          return null;
                                        },
                                        decoration:
                                            roundedTextFieldDecoration('TPI')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: TitleSmallTextWidget(
                                    title:'TM'),
                                margin: EdgeInsets.only(left: 8.w,top: 8.w),
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.black,
                                  // onSaved: (input) =>
                                  // userName = input!,
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return "Please enter TM";
                                    }
                                    return null;
                                  },
                                  decoration: roundedTextFieldDecoration('TM')),
                            ],
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
}
