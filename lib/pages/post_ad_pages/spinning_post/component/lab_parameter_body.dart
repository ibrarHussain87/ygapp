import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';

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
                            title: labParameters,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.w),
                            child: Text(
                              'Enter ${labParameters} details',
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
                                          title: actualYarnCount),
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
                                            return actualYarnCount;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            actualYarnCount))
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
                                          title: CLSP),
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
                                            return CLSP;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            CLSP)),
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
                                          title: unifomity),
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
                                            return unifomity;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            unifomity)),
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
                                          title: cv),
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
                                            return "Please enter ${cv}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            cv)),
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
                                    TitleSmallTextWidget(title: QLT),
                                margin: EdgeInsets.only(left: 8.w, top: 8.w),
                              ),
                              GridTileWidget(
                                  spanCount: 4,
                                  callback: (value) {
                                    _createRequestModel.ys_qlt = widget
                                        .yarnSyncResponse
                                        .data
                                        .yarn
                                        .spunTechnique![value]
                                        .ystId
                                        .toString();
                                  },
                                  listOfItems: widget.yarnSyncResponse.data.yarn
                                      .spunTechnique!),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      child: TitleSmallTextWidget(
                                          title: thinPlaces),
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
                                            return thinPlaces;
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            thinPlaces)),
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
                                          title: thickPlaces),
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
                                            return "Please ${thickPlaces}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            thickPlaces)),
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
                                          title: naps),
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
                                            return "Please enter ${naps}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            naps)),
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
                                          title: IpmKm),
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
                                            return "Enter ${IpmKm}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            IpmKm)),
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
                                          title: hairness),
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
                                            return "Enter ${hairness}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            hairness)),
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
                                          title: Rkm),
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
                                            return "Enter ${Rkm}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            Rkm)),
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
                                          title: elongation),
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
                                            return "Enter ${elongation}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            elongation)),
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
                                          title: tpi),
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
                                            return "Enter ${tpi}";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            tpi)),
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
                                    TitleSmallTextWidget(title: tm),
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
                                      return "Enter ${tm}";
                                    }
                                    return null;
                                  },
                                  decoration: roundedTextFieldDecoration(
                                      tm)),
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
                  color: btnColorLogin,
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
    if (widget.yarnSyncResponse.data.yarn.spunTechnique!.isNotEmpty) {
      _createRequestModel.ys_qlt = widget
          .yarnSyncResponse.data.yarn.spunTechnique!.first.ystId
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
