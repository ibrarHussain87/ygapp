import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/decimal_text_input_formatter.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/component/yarn_specification_body.dart';

class LabParameterPage extends StatefulWidget {
  // final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;
  final Function? callback;
  final YarnSetting newSettings;
  final Key specKey;

  LabParameterPage(
      {Key? key,
        required this.callback,
        // required this.yarnSyncResponse,
        required this.locality,
        required this.businessArea,
        required this.selectedTab,
        required this.newSettings,
        required this.specKey})
      : super(key: key);

  @override
  LabParameterPageState createState() => LabParameterPageState();
}

class LabParameterPageState extends State<LabParameterPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late CreateRequestModel _createRequestModel;
  // late YarnSetting widget.newSettings;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // Utils.disableClick = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _createRequestModel = Provider.of<CreateRequestModel>(context);
    // widget.newSettings = Provider.of<YarnSetting>(context);
    // if(widget.newSettings != null){
    //   widget.newSettings = widget.newSettings!;
    // }
    //  widget.newSettings = getYarnSettings();
    // _initGridValues();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.w,),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.only(left: 0.w),
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
                  height: 12.w,
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
                            visible: Ui.showHide(widget.newSettings.show_actual_count),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  //Modified (asad_m)
                                  SizedBox(height:12.w ,),
//                                      Container(
//                                        child: TitleSmallTextWidget(
//                                            title: '$actualYarnCount*'),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  YgTextFormFieldWithRange(
                                    label: actualYarnCount,
                                    errorText: actualYarnCount,
                                    onSaved: (input) => _createRequestModel
                                        .ys_actual_yarn_count = input!,
                                    // onChanged:(value) => globalFormKey.currentState!.reset(),
                                    minMax:
                                    widget.newSettings.actual_count_min_max??"",
                                  )
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: Ui.showHide(
                          //               widget.newSettings.show_actual_count) &&
                          //           Ui.showHide(widget.newSettings.showClsp)
                          //       ? 16.w
                          //       : 0,
                          // ),

                        ],
                      ),

                      Visibility(
                        visible: Ui.showHide(widget.newSettings.showClsp),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            //modified (asad_m)
                            SizedBox(height:12.w ,),
//                                Container(
//                                  child:
//                                  TitleSmallTextWidget(title: '$CLSP*'),
//                                  margin: EdgeInsets.only(
//                                      left: 8.w, top: 8.w),
//                                ),
                            YgTextFormFieldWithRange(
                              errorText: "CLSP",
                              label: 'CLSP',
                              onSaved: (input) => _createRequestModel
                                  .ys_clsp = input!,
                              // onChanged:(value) => globalFormKey.currentState!.reset(),

                              minMax: widget.newSettings.clspMinMax??"",
                            )
                          ],
                        ),
                      ),

                      //  IPI/KM && Thin Places
                      Row(
                        children: [
                          Visibility(
                            visible: Ui.showHide(widget.newSettings.showIpmKm),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  //modifed ((asad_m)
                                  SizedBox(height:12.w ,),
//                                      Container(
//                                        child:
//                                            TitleSmallTextWidget(title: '$IpmKm*'),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  YgTextFormFieldWithRange(
                                    label:IpmKm,
                                    errorText: "IPKM",
                                    onSaved: (input) => _createRequestModel
                                        .ys_ipm_km = input!,
                                    // onChanged:(value) => globalFormKey.currentState!.reset(),
                                    minMax: widget.newSettings.ipmKmMinMax??"",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Ui.showHide(widget.newSettings.showIpmKm) &&
                                Ui.showHide(widget.newSettings.showThinPlaces)
                                ? 16.w
                                : 0,
                          ),
                          Visibility(
                            visible:
                            Ui.showHide(widget.newSettings.showThinPlaces),
                            child: Expanded(
                              child: Column(
                                children: [
//                                      Container(
//                                        child: TitleSmallTextWidget(
//                                            title: thinPlaces),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  SizedBox(height:12.w ,),
                                  YgTextFormFieldWithRangeNoValidation(
                                    errorText: thinPlaces,
                                    label: thinPlaces,
                                    onSaved: (input) => _createRequestModel
                                        .ys_thin_places = input!,
                                    minMax: widget.newSettings.thinPlacesMinMax??"",
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
                            Ui.showHide(widget.newSettings.showtThickPlaces),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
//                                      Container(
//                                        child: TitleSmallTextWidget(
//                                            title: thickPlaces),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  SizedBox(height:12.w ,),
                                  YgTextFormFieldWithRangeNoValidation(
                                    errorText: thickPlaces,
                                    label: thickPlaces,
                                    minMax: widget.newSettings.thickPlacesMinMax??"",
                                    onSaved: (input) => _createRequestModel
                                        .ys_thick_places = input!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Ui.showHide(
                                widget.newSettings.showtThickPlaces) &&
                                Ui.showHide(widget.newSettings.showNaps)
                                ? 16.w
                                : 0,
                          ),
                          Visibility(
                            visible: Ui.showHide(widget.newSettings.showNaps),
                            child: Expanded(
                              child: Column(
                                children: [
//                                      Container(
//                                        child:
//                                            TitleSmallTextWidget(title: naps),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  SizedBox(height:12.w ,),
                                  YgTextFormFieldWithRangeNoValidation(
                                    errorText: naps,
                                    label:naps,
                                    minMax: widget.newSettings.napsMinMax??"",
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
                            Ui.showHide(widget.newSettings.showUniformity),
                            child: Expanded(
                              child: Column(
                                children: [
//                                      Container(
//                                        child: TitleSmallTextWidget(
//                                            title: unifomity),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  SizedBox(height:12.w ,),
                                  YgTextFormFieldWithRangeNoValidation(
                                    errorText: unifomity,
                                    label: unifomity,
                                    minMax: widget.newSettings.uniformityMinMax??"",
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
                            Ui.showHide(widget.newSettings.showUniformity) &&
                                Ui.showHide(widget.newSettings.showCv)
                                ? 16.w
                                : 0,
                          ),
                          Visibility(
                            visible: Ui.showHide(widget.newSettings.showCv),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
//                                      Container(
//                                        child: TitleSmallTextWidget(title: cv),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  SizedBox(height:12.w ,),
                                  YgTextFormFieldWithRangeNoValidation(
                                    errorText: cv,
                                    label: cv,
                                    minMax: widget.newSettings.cvMinMax??"",
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
                            visible: Ui.showHide(widget.newSettings.showHairness),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
//                                      Container(
//                                        child: TitleSmallTextWidget(
//                                            title: hairness),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  SizedBox(height:12.w ,),
                                  YgTextFormFieldWithRangeNoValidation(
                                    errorText: hairness,
                                    label: hairness,
                                    minMax: widget.newSettings.hairnessMinMax??"",
                                    onSaved: (input) =>
                                    _createRequestModel.ys_hairness =
                                    input!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Ui.showHide(widget.newSettings.showHairness) &&
                                Ui.showHide(widget.newSettings.showRkm)
                                ? 16.w
                                : 0,
                          ),
                          Visibility(
                            visible: Ui.showHide(widget.newSettings.showRkm),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
//                                      Container(
//                                        child: TitleSmallTextWidget(title: Rkm),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  SizedBox(height:12.w ,),
                                  YgTextFormFieldWithRangeNoValidation(
                                    errorText: Rkm,
                                    label: Rkm,
                                    minMax: widget.newSettings.rkmMinMax??"",
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
                            Ui.showHide(widget.newSettings.showElongation),
                            child: Expanded(
                              child: Column(
                                children: [
//                                      Container(
//                                        child: TitleSmallTextWidget(
//                                            title: elongation),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  SizedBox(height:12.w ,),
                                  YgTextFormFieldWithRangeNoValidation(
                                    errorText: elongation,
                                    label: elongation,
                                    minMax: widget.newSettings.elongationMinMax??"",
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
                            Ui.showHide(widget.newSettings.showElongation) &&
                                Ui.showHide(widget.newSettings.showTpi)
                                ? 16.w
                                : 0,
                          ),
                          Visibility(
                            visible: Ui.showHide(widget.newSettings.showTpi),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
//                                      Container(
//                                        child: TitleSmallTextWidget(title: tpi),
//                                        margin: EdgeInsets.only(
//                                            left: 8.w, top: 8.w),
//                                      ),
                                  SizedBox(height:12.w ,),
                                  YgTextFormFieldWithRangeNoValidation(
                                    errorText: tpi,
                                    label: tpi,
                                    minMax: widget.newSettings.tpiMinMax??"",
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
                        visible: Ui.showHide(widget.newSettings.showTm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
//                                Container(
//                                  child: TitleSmallTextWidget(title: tm),
//                                  margin: EdgeInsets.only(left: 8.w, top: 8.w),
//                                ),
                            SizedBox(height:12.w ,),
                            YgTextFormFieldWithRangeNoValidation(
                              errorText: tm,
                              label: tm,
                              minMax: widget.newSettings.tmMinMax??"",
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: SizedBox(
            width: double.maxFinite,
            child: ElevatedButtonWithIcon(
              callback: () {
                if ((widget.specKey as GlobalKey<YarnSpecificationComponentState>).currentState!.validationAllPage()
                    && validateAndSave()) {
                  //    Logger().e(_createRequestModel.toJson().toString());
                  widget.callback!(1);
                }
              },
              color: btnColorLogin,
              btnText: "Next",
            ),
          ),
        ),
      ],
    );
  }

  _initGridValues() {
    // if (widget.yarnSyncResponse.data.yarn.spunTechnique!.isNotEmpty) {
    //   _createRequestModel.ys_spun_technique_idfk = widget
    //       .yarnSyncResponse.data.yarn.spunTechnique!.first.ystId
    //       .toString();
    // }
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

/*YarnSetting getYarnSettings() {

  }*/
}
