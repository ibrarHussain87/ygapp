import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/decimal_text_input_formatter.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
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
    FamilyTileWidgetState.disableClick = true;
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                      YgTextFormFieldWithRange(
                                        errorText: actualYarnCount,
                                        onSaved: (input) => _createRequestModel
                                            .ys_actual_yarn_count = input!,
                                        // onChanged:(value) => globalFormKey.currentState!.reset(),
                                        minMax:
                                            _yarnSetting.actual_count_min_max!,
                                      )
                                    ],
                                  ),
                                ),
                                visible:
                                    Ui.showHide(_yarnSetting.show_actual_count),
                              ),
                              // SizedBox(
                              //   width: Ui.showHide(
                              //               _yarnSetting.show_actual_count) &&
                              //           Ui.showHide(_yarnSetting.showClsp)
                              //       ? 16.w
                              //       : 0,
                              // ),

                            ],
                          ),

                          Visibility(
                            visible: Ui.showHide(_yarnSetting.showClsp),
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
                                YgTextFormFieldWithRange(
                                  errorText: "CLSP",
                                  onSaved: (input) => _createRequestModel
                                      .ys_clsp = input!,
                                  // onChanged:(value) => globalFormKey.currentState!.reset(),

                                  minMax: _yarnSetting.clspMinMax!,
                                )
                              ],
                            ),
                          ),

                          //  IPI/KM && Thin Places
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showIpmKm),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child:
                                            TitleSmallTextWidget(title: IpmKm),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRange(
                                        errorText: "IPKM",
                                        onSaved: (input) => _createRequestModel
                                            .ys_ipm_km = input!,
                                        // onChanged:(value) => globalFormKey.currentState!.reset(),
                                        minMax: _yarnSetting.ipmKmMinMax!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Ui.showHide(_yarnSetting.showIpmKm) &&
                                        Ui.showHide(_yarnSetting.showThinPlaces)
                                    ? 16.w
                                    : 0,
                              ),
                              Visibility(
                                visible:
                                    Ui.showHide(_yarnSetting.showThinPlaces),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(
                                            title: thinPlaces),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRangeNoValidation(
                                        errorText: thinPlaces,
                                        onSaved: (input) => _createRequestModel
                                            .ys_thin_places = input!,
                                        minMax: _yarnSetting.thinPlacesMinMax!,
                                      ),
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
                                visible:
                                    Ui.showHide(_yarnSetting.showtThickPlaces),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(
                                            title: thickPlaces),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRangeNoValidation(
                                        errorText: thickPlaces,
                                        minMax: _yarnSetting.thickPlacesMinMax!,
                                        onSaved: (input) => _createRequestModel
                                            .ys_thick_places = input!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Ui.showHide(
                                            _yarnSetting.showtThickPlaces) &&
                                        Ui.showHide(_yarnSetting.showNaps)
                                    ? 16.w
                                    : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showNaps),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        child:
                                            TitleSmallTextWidget(title: naps),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRangeNoValidation(
                                        errorText: naps,
                                        minMax: _yarnSetting.napsMinMax!,
                                        onSaved: (input) => _createRequestModel
                                            .ys_naps = input!,
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //UNIFORMITY && CV
                          Row(
                            children: [
                              Visibility(
                                visible:
                                    Ui.showHide(_yarnSetting.showUniformity),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(
                                            title: unifomity),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRangeNoValidation(
                                        errorText: unifomity,
                                        minMax: _yarnSetting.uniformityMinMax!,
                                          onSaved: (input) =>
                                              _createRequestModel
                                                  .ys_uniformity = input!,
                                          ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    Ui.showHide(_yarnSetting.showUniformity) &&
                                            Ui.showHide(_yarnSetting.showCv)
                                        ? 16.w
                                        : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showCv),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(title: cv),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRangeNoValidation(
                                          errorText: cv,
                                          minMax: _yarnSetting.cvMinMax!,
                                          onSaved: (input) =>
                                              _createRequestModel.ys_cv =
                                                  input!,
                                         ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Hairness && RKM
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showHairness),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(
                                            title: hairness),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRangeNoValidation(
                                          errorText: hairness,
                                          minMax: _yarnSetting.hairnessMinMax!,
                                          onSaved: (input) =>
                                              _createRequestModel.ys_hairness =
                                                  input!,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Ui.showHide(_yarnSetting.showHairness) &&
                                        Ui.showHide(_yarnSetting.showRkm)
                                    ? 16.w
                                    : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showRkm),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(title: Rkm),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRangeNoValidation(
                                          errorText: Rkm,
                                          minMax: _yarnSetting.rkmMinMax!,
                                          onSaved: (input) =>
                                              _createRequestModel.ys_rkm =
                                                  input!,
                                          ),
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
                                visible:
                                    Ui.showHide(_yarnSetting.showElongation),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(
                                            title: elongation),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRangeNoValidation(
                                          errorText: elongation,
                                          minMax: _yarnSetting.elongationMinMax!,
                                          onSaved: (input) =>
                                              _createRequestModel
                                                  .ys_elongation = input!,
                                         ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    Ui.showHide(_yarnSetting.showElongation) &&
                                            Ui.showHide(_yarnSetting.showTpi)
                                        ? 16.w
                                        : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting.showTpi),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: TitleSmallTextWidget(title: tpi),
                                        margin: EdgeInsets.only(
                                            left: 8.w, top: 8.w),
                                      ),
                                      YgTextFormFieldWithRangeNoValidation(
                                          errorText: tpi,
                                          minMax: _yarnSetting.tpiMinMax!,
                                          onSaved: (input) =>
                                              _createRequestModel.ys_tpi =
                                                  input!,
                                         ),
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
                                YgTextFormFieldWithRangeNoValidation(
                                    errorText: tm,
                                    minMax: _yarnSetting.tmMinMax!,
                                    onSaved: (input) =>
                                        _createRequestModel.ys_tm = input!,
                                    ),
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
          Padding(
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
        ],
      ),
    );
  }

  _initGridValues() {
    if (widget.yarnSyncResponse.data.yarn.spunTechnique!.isNotEmpty) {
      _createRequestModel.ys_spun_technique_idfk = widget
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
