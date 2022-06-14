
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/component/yarn_specification_body.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';

class LabParameterPage extends StatefulWidget {
  // final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;
  final Function? callback;
  // final YarnSetting newSettings;
  final Key specKey;

  const LabParameterPage(
      {Key? key,
        required this.callback,
        // required this.yarnSyncResponse,
        required this.locality,
        required this.businessArea,
        required this.selectedTab,
        // required this.newSettings,
        required this.specKey})
      : super(key: key);

  @override
  LabParameterPageState createState() => LabParameterPageState();
}

class LabParameterPageState extends State<LabParameterPage>
    with AutomaticKeepAliveClientMixin {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ValueNotifier<bool> showOptionalParams = ValueNotifier(false);
  final _postYarnProvider = locator<PostYarnProvider>();


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // Utils.disableClick = true;
    super.initState();
  }

  @override
  void dispose() {
    showOptionalParams.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
                      //Actual Yarn Count
                      Row(
                        children: [
                          Visibility(
                            visible: Ui.showHide(_postYarnProvider.yarnSetting!.show_actual_count),
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
                                    onSaved: (input) => _postYarnProvider.createRequestModel!.ys_actual_yarn_count = input!,
                                    // onChanged:(value) => globalFormKey.currentState!.reset(),
                                    minMax:
                                    _postYarnProvider.yarnSetting!.actual_count_min_max??"",
                                  )
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   width: Ui.showHide(
                          //               __postYarnProvider.yarnSetting!.show_actual_count) &&
                          //           Ui.showHide(__postYarnProvider.yarnSetting!.showClsp)
                          //       ? 16.w
                          //       : 0,
                          // ),

                        ],
                      ),
                      // CLSP
                      Visibility(
                        visible: Ui.showHide(_postYarnProvider.yarnSetting!.showClsp),
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
                              onSaved: (input) => _postYarnProvider.createRequestModel
                                  !.ys_clsp = input!,
                              // onChanged:(value) => globalFormKey.currentState!.reset(),

                              minMax: _postYarnProvider.yarnSetting!.clspMinMax??"",
                            )
                          ],
                        ),
                      ),

                      //  IPI/KM
                      Visibility(
                        visible: Ui.showHide(_postYarnProvider.yarnSetting!.showIpmKm),
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
                              label:ipmKm,
                              errorText: "IPKM",
                              onSaved: (input) => _postYarnProvider.createRequestModel
                                  !.ys_ipm_km = input!,
                              // onChanged:(value) => globalFormKey.currentState!.reset(),
                              minMax: _postYarnProvider.yarnSetting!.ipmKmMinMax??"",
                            ),
                          ],
                        ),
                      ),


                      Visibility(
                        visible: true,
                        maintainSize: false,
                        maintainState: false,
                        child: ValueListenableBuilder(
                            valueListenable: showOptionalParams,
                            builder: (BuildContext context, bool counterValue, child){
                              return Container(
                                margin: EdgeInsets.only(left: 0.w, right: 0.w,top: 8.w),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6))),
                                child: Container(
                                    color: newColorGrey.withOpacity(0.3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10.w,
                                                    left: 8.w,
                                                    bottom: 10.w),
                                                child: const TitleMediumTextWidget(
                                                  title: 'Optional Parameters',
                                                )),
                                            GestureDetector(
                                              onTap: () {
                                                showOptionalParams.value = !showOptionalParams.value;
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 4, right: 6, bottom: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.blueAccent.shade700
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  showOptionalParams.value == true
                                                      ? Icons
                                                      .keyboard_arrow_up_outlined
                                                      : Icons
                                                      .keyboard_arrow_down_outlined,
                                                  size: 24,
                                                  color: darkBlueChip,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Visibility(
                                          visible: showOptionalParams.value,
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 6,right: 6,bottom: 10),
                                              child: Column(
                                                children: [
                                                  const Divider(),
                                                  // Thin Places
                                                  Visibility(
                                                    visible:
                                                    Ui.showHide(_postYarnProvider.yarnSetting!.showThinPlaces),
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
                                                          mandatoryField: false,
                                                          onSaved: (input) => _postYarnProvider.createRequestModel
                                                              !.ys_thin_places = input!,
                                                          minMax: _postYarnProvider.yarnSetting!.thinPlacesMinMax??"",
                                                        ),
                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.stretch,
                                                    ),
                                                  ),

                                                  //Thick Places
                                                  Visibility(
                                                    visible:
                                                    Ui.showHide(_postYarnProvider.yarnSetting!.showtThickPlaces),
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
                                                          mandatoryField: false,
                                                          minMax: _postYarnProvider.yarnSetting!.thickPlacesMinMax??"",
                                                          onSaved: (input) => _postYarnProvider.createRequestModel
                                                              !.ys_thick_places = input!,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Naps
                                                  Visibility(
                                                    visible: Ui.showHide(_postYarnProvider.yarnSetting!.showNaps),
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
                                                          mandatoryField: false,
                                                          minMax: _postYarnProvider.yarnSetting!.napsMinMax??"",
                                                          onSaved: (input) => _postYarnProvider.createRequestModel
                                                              !.ys_naps = input!,
                                                        ),
                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    ),
                                                  ),

                                                  //UNIFORMITY
                                                  Visibility(
                                                    visible:
                                                    Ui.showHide(_postYarnProvider.yarnSetting!.showUniformity),
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
                                                          errorText: uniformityStr,
                                                          label: uniformityStr,
                                                          mandatoryField: false,
                                                          minMax: _postYarnProvider.yarnSetting!.uniformityMinMax??"",
                                                          onSaved: (input) =>
                                                          _postYarnProvider.createRequestModel
                                                              !.ys_uniformity = input!,
                                                        ),
                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    ),
                                                  ),
                                                  // CV
                                                  Visibility(
                                                    visible: Ui.showHide(_postYarnProvider.yarnSetting!.showCv),
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
                                                          mandatoryField: false,
                                                          minMax: _postYarnProvider.yarnSetting!.cvMinMax??"",
                                                          onSaved: (input) =>
                                                          _postYarnProvider.createRequestModel!.ys_cv =
                                                          input!,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  //Hairness
                                                  Visibility(
                                                    visible: Ui.showHide(_postYarnProvider.yarnSetting!.showHairness),
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
                                                          mandatoryField: false,
                                                          minMax: _postYarnProvider.yarnSetting!.hairnessMinMax??"",
                                                          onSaved: (input) =>
                                                          _postYarnProvider.createRequestModel!.ys_hairness =
                                                          input!,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // RKM
                                                  Visibility(
                                                    visible: Ui.showHide(_postYarnProvider.yarnSetting!.showRkm),
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
                                                          errorText: rkmStr,
                                                          label: rkmStr,
                                                          mandatoryField: false,
                                                          minMax: _postYarnProvider.yarnSetting!.rkmMinMax??"",
                                                          onSaved: (input) =>
                                                          _postYarnProvider.createRequestModel!.ys_rkm =
                                                          input!,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  //Elongation
                                                  Visibility(
                                                    visible:
                                                    Ui.showHide(_postYarnProvider.yarnSetting!.showElongation),
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
                                                          mandatoryField: false,
                                                          minMax: _postYarnProvider.yarnSetting!.elongationMinMax??"",
                                                          onSaved: (input) =>
                                                          _postYarnProvider.createRequestModel
                                                              !.ys_elongation = input!,
                                                        ),
                                                      ],
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                    ),
                                                  ),
                                                  // TPI
                                                  Visibility(
                                                    visible: Ui.showHide(_postYarnProvider.yarnSetting!.showTpi),
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
                                                          mandatoryField: false,
                                                          minMax: _postYarnProvider.yarnSetting!.tpiMinMax??"",
                                                          onSaved: (input) =>
                                                          _postYarnProvider.createRequestModel!.ys_tpi =
                                                          input!,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  //TM
                                                  Visibility(
                                                    visible: Ui.showHide(_postYarnProvider.yarnSetting!.showTm),
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
                                                          mandatoryField: false,
                                                          minMax: _postYarnProvider.yarnSetting!.tmMinMax??"",
                                                          onSaved: (input) =>
                                                          _postYarnProvider.createRequestModel!.ys_tm = input!,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              );
                            }
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
                  //    Logger().e(_yarnPostProvider..createRequestModel.toJson().toString());
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
    //   _yarnPostProvider..createRequestModel.ys_spun_technique_idfk = widget
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
