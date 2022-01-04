import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/numeriacal_range_text_field.dart';
import 'package:yg_app/helper_utils/string_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

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
  late YarnSetting _yarnSetting;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _createRequestModel = Provider.of<CreateRequestModel>(context);
    _yarnSetting = Provider.of<YarnSetting>(context);
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
                              'Enter $labParameters details',
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

                          //Actual Yarn Count && CLSP
                          Row(
                            children: [
                              Visibility(
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(
                                            title: actualYarnCount),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      TextFormField(
                                          style: TextStyle(fontSize: 11.sp),
                                          textAlign: TextAlign.center,
                                          cursorHeight: 16.w,
                                          keyboardType: TextInputType.number,
                                          cursorColor: Colors.black,
                                          onSaved: (input) =>
                                              _createRequestModel
                                                      .ys_actual_yarn_count =
                                                  input!,
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return actualYarnCount;
                                            }
                                            return null;
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.countMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.countMinMax))
                                          ],
                                          decoration:
                                              roundedTextFieldDecoration(
                                                  actualYarnCount))
                                    ],
                                  ),
                                ),
                                visible: Ui.showHide(_yarnSetting.showCount),
                              ),
                              SizedBox(
                                width: Ui.showHide(_yarnSetting.showCount) &&
                                        Ui.showHide(_yarnSetting.showClsp)
                                    ? 16.w
                                    : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showClsp),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child:
                                            TitleSmallTextWidget(title: CLSP),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      TextFormField(
                                          style: TextStyle(fontSize: 11.sp),
                                          textAlign: TextAlign.center,
                                          cursorHeight: 16.w,
                                          keyboardType: TextInputType.number,
                                          cursorColor: Colors.black,
                                          onSaved: (input) =>
                                              _createRequestModel.ys_clsp =
                                                  input!,
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return CLSP;
                                            }
                                            return null;
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.clspMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.clspMinMax))
                                          ],
                                          decoration:
                                              roundedTextFieldDecoration(CLSP)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          //  IPI/KM && Thin Places
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showIpmKm),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(title: IpmKm),
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
                                              return "Enter $IpmKm";
                                            }
                                            return null;
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.ipmKmMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.ipmKmMinMax))
                                          ],
                                          decoration:
                                          roundedTextFieldDecoration(IpmKm)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Ui.showHide(_yarnSetting.showIpmKm) && Ui.showHide(_yarnSetting.showThinPlaces) ? 16.w : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showThinPlaces),
                                child: Expanded(
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
                                          // validator: (input) {
                                          //   if (input == null || input.isEmpty) {
                                          //     return thinPlaces;
                                          //   }
                                          //   return null;
                                          // },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.thinPlacesMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.thinPlacesMinMax))
                                          ],
                                          decoration: roundedTextFieldDecoration(
                                              thinPlaces)),
                                    ],
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Thick Places && Naps
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showtThickPlaces),
                                child: Expanded(
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
                                          // validator: (input) {
                                          //   if (input == null || input.isEmpty) {
                                          //     return "Please $thickPlaces";
                                          //   }
                                          //   return null;
                                          // },

                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.thickPlacesMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.thickPlacesMinMax))
                                          ],
                                          decoration: roundedTextFieldDecoration(
                                              thickPlaces)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Ui.showHide(_yarnSetting.showtThickPlaces) && Ui.showHide(_yarnSetting.showNaps) ? 16.w : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showNaps),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(title: naps),
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
                                          // validator: (input) {
                                          //   if (input == null || input.isEmpty) {
                                          //     return "Please enter ${naps}";
                                          //   }
                                          //   return null;
                                          // },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.napsMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.napsMinMax))
                                          ],
                                          decoration:
                                          roundedTextFieldDecoration(naps)),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //UNIFORMITY && CV
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showUniformity),
                                child: Expanded(
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
                                          onSaved: (input) =>
                                          _createRequestModel.ys_uniformity = input!,
                                          // validator: (input) {
                                          //   if (input == null || input.isEmpty) {
                                          //     return unifomity;
                                          //   }
                                          //   return null;
                                          // },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.uniformityMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.uniformityMinMax))
                                          ],
                                          decoration: roundedTextFieldDecoration(
                                              unifomity)),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Ui.showHide(_yarnSetting.showUniformity) && Ui.showHide(_yarnSetting.showCv) ? 16.w : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showCv),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(title: cv),
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
                                          // validator: (input) {
                                          //   if (input == null || input.isEmpty) {
                                          //     return "Please enter $cv";
                                          //   }
                                          //   return null;
                                          // },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.cvMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.cvMinMax))
                                          ],
                                          decoration:
                                              roundedTextFieldDecoration(cv)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Container(
                          //       child: TitleSmallTextWidget(title: QLT),
                          //       margin: EdgeInsets.only(left: 8.w, top: 8.w),
                          //     ),
                          //     GridTileWidget(
                          //         spanCount: 4,
                          //         callback: (value) {
                          //           _createRequestModel.ys_qlt = widget
                          //               .yarnSyncResponse
                          //               .data
                          //               .yarn
                          //               .spunTechnique![value]
                          //               .ystId
                          //               .toString();
                          //         },
                          //         listOfItems: widget.yarnSyncResponse.data.yarn
                          //             .spunTechnique!),
                          //   ],
                          // ),

                          //Hairness && RKM
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showHairness),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child:
                                            TitleSmallTextWidget(title: hairness),
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
                                          // validator: (input) {
                                          //   if (input == null || input.isEmpty) {
                                          //     return "Enter $hairness";
                                          //   }
                                          //   return null;
                                          // },

                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.hairnessMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.hairnessMinMax))
                                          ],
                                          decoration: roundedTextFieldDecoration(
                                              hairness)),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Ui.showHide(_yarnSetting.showHairness) && Ui.showHide(_yarnSetting.showRkm) ? 16.w : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showRkm),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(title: Rkm),
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
                                          // validator: (input) {
                                          //   if (input == null || input.isEmpty) {
                                          //     return "Enter ${Rkm}";
                                          //   }
                                          //   return null;
                                          // },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.rkmMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.rkmMinMax))
                                          ],
                                          decoration:
                                              roundedTextFieldDecoration(Rkm)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Elongation and TPI
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showElongation),
                                child: Expanded(
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
                                          // validator: (input) {
                                          //   if (input == null || input.isEmpty) {
                                          //     return "Enter ${elongation}";
                                          //   }
                                          //   return null;
                                          // },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.elongationMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.elongationMinMax))
                                          ],
                                          decoration: roundedTextFieldDecoration(
                                              elongation)),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:Ui.showHide(_yarnSetting.showElongation) && Ui.showHide(_yarnSetting.showTpi) ? 16.w : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showTpi),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(title: tpi),
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
                                          // validator: (input) {
                                          //   if (input == null || input.isEmpty) {
                                          //     return "Enter ${tpi}";
                                          //   }
                                          //   return null;
                                          // },

                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            FilteringTextInputFormatter.allow(
                                                RegExp('[0-9]')),
                                            NumericalRangeFormatter(
                                                min: StringUtils.splitMin(
                                                    _yarnSetting.tpiMinMax),
                                                max: StringUtils.splitMax(
                                                    _yarnSetting.tpiMinMax))
                                          ],
                                          decoration:
                                              roundedTextFieldDecoration(tpi)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //TM
                          Visibility(
                            visible: Ui.showHide(_yarnSetting.showTm),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: TitleSmallTextWidget(title: tm),
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
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly,
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]')),
                                      NumericalRangeFormatter(
                                          min: StringUtils.splitMin(
                                              _yarnSetting.tmMinMax),
                                          max: StringUtils.splitMax(
                                              _yarnSetting.tmMinMax))
                                    ],
                                    // validator: (input) {
                                    //   if (input == null || input.isEmpty) {
                                    //     return "Enter ${tm}";
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: roundedTextFieldDecoration(tm)),
                              ],
                            ),
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
