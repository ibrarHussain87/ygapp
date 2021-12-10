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
  final Function? callback;

  const LabParameterPage(
      {Key? key,
      required this.callback,
      required this.yarnSyncResponse,
      required this.locality,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  LabParameterPageState createState() => LabParameterPageState();
}

class LabParameterPageState extends State<LabParameterPage>
    with AutomaticKeepAliveClientMixin {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late CreateRequestModel _createRequestModel;
  YarnSetting? _yarnSetting;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createRequestModel = Provider.of<CreateRequestModel>(context);
    _yarnSetting = Provider.of<YarnSetting?>(context);
    _initGridValues();

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
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) => _createRequestModel
                                            .ys_actual_yarn_count = input!,
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
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) => _createRequestModel
                                            .ys_clsp = input!,
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
                                          title: AppStrings.unifomity),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        // onSaved: (input) =>
                                        // userName = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return AppStrings.unifomity;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.unifomity)),
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
                                          title: AppStrings.cv),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) =>
                                            _createRequestModel.ys_cv = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter ${AppStrings.cv}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.cv)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child:
                                    TitleSmallTextWidget(title: AppStrings.QLT),
                                margin: EdgeInsets.only(left: 8.w, top: 8.w),
                              ),
                              GridTileWidget(
                                  spanCount: 4,
                                  callback: (value) {
                                    _createRequestModel.ys_qlt = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .spunTechnique[value]
                                        .ystId
                                        .toString();
                                  },
                                  listOfItems: widget.yarnSyncResponse.data.yarn
                                      .spunTechnique),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title: AppStrings.thinPlaces),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) => _createRequestModel
                                            .ys_thin_places = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return AppStrings.thinPlaces;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.thinPlaces)),
                                  ],
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                          title: AppStrings.thickPlaces),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) => _createRequestModel
                                            .ys_thick_places = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please ${AppStrings.thickPlaces}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.thickPlaces)),
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
                                          title: AppStrings.naps),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) => _createRequestModel
                                            .ys_naps = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Please enter ${AppStrings.naps}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.naps)),
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
                                          title: AppStrings.IpmKm),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) => _createRequestModel
                                            .ys_ipm_km = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Enter ${AppStrings.IpmKm}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.IpmKm)),
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
                                          title: AppStrings.hairness),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) => _createRequestModel
                                            .ys_hairness = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Enter ${AppStrings.hairness}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.hairness)),
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
                                          title: AppStrings.Rkm),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) =>
                                            _createRequestModel.ys_rkm = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Enter ${AppStrings.Rkm}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.Rkm)),
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
                                          title: AppStrings.elongation),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) => _createRequestModel
                                            .ys_elongation = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Enter ${AppStrings.elongation}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.elongation)),
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
                                          title: AppStrings.tpi),
                                      margin:
                                          EdgeInsets.only(left: 8.w, top: 8.w),
                                    ),
                                    TextFormField(
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        keyboardType: TextInputType.number,
                                        cursorColor: Colors.black,
                                        onSaved: (input) =>
                                            _createRequestModel.ys_tpi = input!,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Enter ${AppStrings.tpi}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            AppStrings.tpi)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child:
                                    TitleSmallTextWidget(title: AppStrings.tm),
                                margin: EdgeInsets.only(left: 8.w, top: 8.w),
                              ),
                              TextFormField(
                                  style: TextStyle(fontSize: 11.sp),
                                  textAlign: TextAlign.center,
                                  cursorHeight: 16.w,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.black,
                                  onSaved: (input) =>
                                      _createRequestModel.ys_tm = input!,
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return "Enter ${AppStrings.tm}";
                                    }
                                    return null;
                                  },
                                  decoration: roundedTextFieldDecoration(
                                      AppStrings.tm)),
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
                    if (validateAndSave()) {
                      widget.callback!(1);
                    }
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

  _initGridValues() {
    if (widget.yarnSyncResponse.data.yarn.spunTechnique.isNotEmpty) {
      _createRequestModel.ys_qlt = widget
          .yarnSyncResponse.data.yarn.spunTechnique.first.ystId
          .toString();
    }
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
