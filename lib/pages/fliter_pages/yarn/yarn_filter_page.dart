import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/elevated_button_without_icon_widget.dart';
import 'package:yg_app/elements/list_widgets/blend_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/providers/yarn_providers/yarn_filter_provider.dart';

import '../../../elements/custom_header.dart';

class YarnFilterBody extends StatefulWidget {
  // final YarnSyncResponse? syncResponse;

  const YarnFilterBody({
    Key? key,
    /* required this.syncResponse*/
  }) : super(key: key);

  @override
  _YarnFilterBodyState createState() => _YarnFilterBodyState();
}

class _YarnFilterBodyState extends State<YarnFilterBody> {
  final _yarnFilterProvider = locator<YarnFilterProvider>();

  void openDialogBox() {
    // raise the [showDialog] widget
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _yarnFilterProvider.pickerColor,
              onColorChanged: _yarnFilterProvider.pickColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                _yarnFilterProvider.setPickedColor;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //
  // _getPattern() {
  //   if (_selectedSpunTechId != null) {
  //     if (_selectedSpunTechId == "1") {
  //       return _patternList!
  //           .where((element) => element.spun_technique_id == "1")
  //           .toList();
  //     }
  //     return _patternList!;
  //   }
  //
  //   return _patternList!;
  // }
  //
  // _getQuality() {
  //   if (_selectedSpunTechId != null) {
  //     if (_selectedSpunTechId == "1") {
  //       return _qualityList!;
  //     }
  //     return _qualityList!;
  //   }
  //
  //   return _qualityList!;
  // }

  // int? selectedFamilyId;
  // String? selectedBlendId;

  //Show Hide on dependency
  // bool? showDyingMethod;
  // bool? showPatternCharc;
  // bool? showDoublingMethod;

  // final List<int> _colorTreatmentIdList = [3, 5, 8, 11, 13];
  // final List<int> _plyIdList = [1, 5, 9, 13];
  // final List<int> _patternIdList = [1, 2, 3, 4, 9, 10, 12];
  // final List<int> _patternTLPIdList = [2, 9, 12];
  // final List<int> _patternGRIdList = [10];
  //
  // String? _selectedPlyId;
  // String? _selectedPatternId;
  // String? _selectedAppearenceId;
  // String? _selectedColorTreatMethodId;
  // String? _selectedSpunTechId;

  //Keys
  final GlobalKey<SingleSelectTileRenewedWidgetState> _familyKey =
      GlobalKey<SingleSelectTileRenewedWidgetState>();
  final GlobalKey<SingleSelectTileRenewedWidgetState> _certificationKey =
      GlobalKey<SingleSelectTileRenewedWidgetState>();

  final GlobalKey<BlendWithImageListWidgetState> _blendKey =
      GlobalKey<BlendWithImageListWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _yarnTypeKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _colorTreatmentMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _usageKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _dyingMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _plyKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _doublingMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _orientationKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _qualityKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _patternKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _spunTechKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _gradeKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _appearanceKey =
      GlobalKey<SingleSelectTileWidgetState>();

  @override
  void initState() {
    super.initState();
    _yarnFilterProvider.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _yarnFilterProvider.getFamilyData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context,"Yarn Filter"),
        body: _yarnFilterProvider.isGetSyncedData
            ? Container(
                padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlendWithImageListWidget(
                              key: _familyKey,
                              listItem: _yarnFilterProvider.familyList,
                              onClickCallback: (value) {
                                _yarnFilterProvider.selectedYarnFamily = _yarnFilterProvider.familyList![value];
                                _resetData();
                                _yarnFilterProvider
                                    .getSpecificationRequestModel
                                    .ysFamilyIdFk = [_yarnFilterProvider.familyList![value].famId!];
                                _yarnFilterProvider
                                    .getSyncedData(_yarnFilterProvider.familyList![value].famId!);
                              },
                              selectedItem: 0,
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                            //Show Blends
                            Visibility(
                              visible: _yarnFilterProvider.showBlend ?? false,
                              child: SizedBox(
                                height:
                                    0.04 * MediaQuery.of(context).size.height,
                                child: SingleSelectTileRenewedWidget(
                                  key: _blendKey,
                                  spanCount: 4,
                                  selectedIndex: -1,
                                  listOfItems:
                                      _yarnFilterProvider.blendsList!,
                                  callback: (Blends value) {


                                    _yarnFilterProvider
                                        .getSpecificationRequestModel
                                        .ysBlendIdFk = [
                                      value.blnId!
                                    ];
                                    _yarnFilterProvider
                                        .getSpecificationRequestModel
                                        .ysBlendIdFk = [
                                    value.blnId!];



                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                            //Show Texturzed
                            Visibility(
                              visible:
                                  _yarnFilterProvider.showTexturized ?? false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: yarnTexturedType)),
                                  SingleSelectTileWidget(
                                    key: _yarnTypeKey,
                                    selectedIndex: -1,
                                    spanCount: 3,
                                    listOfItems:
                                        _yarnFilterProvider.yarnTypesList!,
                                    callback: (YarnTypes yarnType) {
                                      _yarnFilterProvider
                                              .getSpecificationRequestModel
                                              .yarnYypeId =
                                          filterList(
                                              _yarnFilterProvider
                                                  .listOfYarnType,
                                              yarnType.ytId!);
                                    },
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show Usage
                            Visibility(
                              visible: _yarnFilterProvider.showUsage ?? false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child:
                                          TitleSmallTextWidget(title: usage)),
                                  SingleSelectTileWidget(
                                    key: _usageKey,
                                    spanCount: 2,
                                    selectedIndex: -1,
                                    listOfItems: _yarnFilterProvider.usageList!,
                                    callback: (Usage usage) {
                                      _yarnFilterProvider
                                              .getSpecificationRequestModel
                                              .yuId =
                                          filterList(
                                              _yarnFilterProvider.listOfUsageId,
                                              usage.yuId!);
                                    },
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show Count
                            // Visibility(
                            //   visible: _yarnFilterProvider.showCount ?? false,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       FilterRangeSlider(
                            //         // minMaxRange: widget.syncFiberResponse.data.fiber
                            //         //     .settings[0].micMinMax,
                            //         minValue: _yarnFilterProvider.minCount,
                            //         maxValue: _yarnFilterProvider.maxCount,
                            //         hintTxt: "Count",
                            //         valueCallback: (value) {},
                            //       ),
                            //       SizedBox(
                            //         height: 8.w,
                            //       ),
                            //       Divider(),
                            //     ],
                            //   ),
                            // ),
                            //Show Dannier
                            // Visibility(
                            //   visible: _yarnFilterProvider.showDannier ?? false,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       FilterRangeSlider(
                            //         // minMaxRange: widget.syncFiberResponse.data.fiber
                            //         //     .settings[0].micMinMax,
                            //         minValue: _yarnFilterProvider.minDannier,
                            //         maxValue: _yarnFilterProvider.maxDannier,
                            //         hintTxt: "Dannier",
                            //         // minCallback: (value) {
                            //         //   minValueDannierParam = value;
                            //         // },
                            //         // maxCallback: (value) {
                            //         //   maxValueDannierParam = value;
                            //         // },
                            //         valueCallback: (value) {},
                            //       ),
                            //       SizedBox(
                            //         height: 8.w,
                            //       ),
                            //       Divider(),
                            //     ],
                            //   ),
                            // ),
                            // //Show Filament
                            // Visibility(
                            //   visible:
                            //       _yarnFilterProvider.showFilament ?? false,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       FilterRangeSlider(
                            //         // minMaxRange: widget.syncFiberResponse.data.fiber
                            //         //     .settings[0].micMinMax,
                            //         minValue: _yarnFilterProvider.minFilament,
                            //         maxValue: _yarnFilterProvider.maxFilament,
                            //         hintTxt: "Filament",
                            //         valueCallback: (value) {},
                            //       ),
                            //       SizedBox(
                            //         height: 8.w,
                            //       ),
                            //       Divider(),
                            //     ],
                            //   ),
                            // ),
                            //Show Ply
                            Visibility(
                              visible: _yarnFilterProvider.showPly ?? false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child: TitleSmallTextWidget(title: ply)),
                                  SingleSelectTileWidget(
                                    key: _plyKey,
                                    selectedIndex: -1,
                                    spanCount: 3,
                                    listOfItems: _yarnFilterProvider.plyList!,
                                    callback: (Ply ply) async {
                                      _yarnFilterProvider
                                              .getSpecificationRequestModel
                                              .plyId =
                                          filterList(
                                              _yarnFilterProvider.listOfPlyId,
                                              ply.plyId!);
                                      _yarnFilterProvider.plySelection(ply);
                                      if(_doublingMethodKey.currentState!= null){
                                        _doublingMethodKey.currentState!.resetWidget();
                                      }
                                      _yarnFilterProvider.getSpecificationRequestModel.doublingMethodId = null;
                                      // var dbInstance =
                                      //     await AppDbInstance().getDbInstance();
                                      // _yarnFilterProvider.doublingMethodList =
                                      //     await dbInstance.doublingMethodDao
                                      //         .findYarnDoublingMethodWithPlyId(
                                      //             ply.plyId!);
                                      // _showDoublingMethod(ply);
                                    },
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show Doubling Method
                            Visibility(
                              visible: _yarnFilterProvider.showDoublingMethod ??
                                  false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child: const TitleSmallTextWidget(
                                          title: "Doubling Method")),
                                  SingleSelectTileWidget(
                                    key: _doublingMethodKey,
                                    selectedIndex: -1,
                                    spanCount: 3,
                                    listOfItems:
                                        _yarnFilterProvider.doublingMethodList!,
                                    callback: (DoublingMethod doublingMethod) {
                                      _yarnFilterProvider
                                              .getSpecificationRequestModel
                                              .doublingMethodId =
                                          filterList(
                                              _yarnFilterProvider
                                                  .listOfDoublingMethod,
                                              doublingMethod.dmId!);
                                    },
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show Orientation
                            Visibility(
                              visible:
                                  _yarnFilterProvider.showOrientation ?? false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child: const TitleSmallTextWidget(
                                          title: 'Orientation')),
                                  SingleSelectTileWidget(
                                    key: _orientationKey,
                                    selectedIndex: -1,
                                    spanCount: 2,
                                    listOfItems:
                                        _yarnFilterProvider.orientationList!,
                                    callback: (OrientationTable orientation) {
                                      _yarnFilterProvider
                                              .getSpecificationRequestModel
                                              .orientationId =
                                          filterList(
                                              _yarnFilterProvider
                                                  .listOfOrientation,
                                              orientation.yoId!);
                                    },
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show Color Treatment Method
                            Visibility(
                              visible: _yarnFilterProvider
                                      .showColorTreatmentMethod ??
                                  false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: colorTreatmentMethod)),
                                  SingleSelectTileWidget(
                                    key: _colorTreatmentMethodKey,
                                    selectedIndex: -1,
                                    spanCount: 3,
                                    listOfItems: _yarnFilterProvider
                                        .colorTreatmentMethodList!,
                                    callback: (ColorTreatmentMethod
                                        colorTreatmentMethod) {
                                      _yarnFilterProvider
                                              .getSpecificationRequestModel
                                              .colorTreatmentId =
                                          filterList(
                                              _yarnFilterProvider
                                                  .listOfColorTreatmentId,
                                              colorTreatmentMethod.yctmId!);
                                      // _showDyingMethod(colorTreatmentMethod);
                                    },
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show color dying method
                            // Visibility(
                            //   visible: /*showDyingMethod ?? */ false,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Padding(
                            //           padding: EdgeInsets.only(
                            //               left: 8.w, bottom: 8.w),
                            //           child: const TitleSmallTextWidget(
                            //               title: "Dying Method")),
                            //       SingleSelectTileWidget(
                            //         key: _dyingMethodKey,
                            //         selectedIndex: -1,
                            //         spanCount: 3,
                            //         listOfItems:
                            //             _yarnFilterProvider.dyingMethodList!,
                            //         callback: (DyingMethod dyingMethod) {
                            //           _yarnFilterProvider
                            //                   .getSpecificationRequestModel
                            //                   .ys_dying_method_idfk =
                            //               filterList(
                            //                   _yarnFilterProvider
                            //                       .listOfDyingMethod,
                            //                   dyingMethod.ydmId!);
                            //         },
                            //       ),
                            //       SizedBox(
                            //         height: 4.w,
                            //       ),
                            //       const Divider(),
                            //     ],
                            //   ),
                            // ),
                            //Show Color Code
                            Visibility(
                                visible: _yarnFilterProvider.showDyingMethod ??
                                    false,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: TitleSmallTextWidget(
                                            title: "Select Color"),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: TextFormField(
                                            keyboardType: TextInputType.none,
                                            controller: _yarnFilterProvider
                                                .textEditingController,
                                            autofocus: false,
                                            showCursor: false,
                                            readOnly: true,
                                            style: TextStyle(fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                            onSaved: (input) =>
                                                _yarnFilterProvider
                                                    .getSpecificationRequestModel
                                                    .ys_color_code = input,
                                            validator: (input) {
                                              if (input == null ||
                                                  input.isEmpty) {
                                                return "Select Color Code";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    borderSide:
                                                        BorderSide.none),
                                                contentPadding:
                                                    const EdgeInsets.all(2.0),
                                                hintText: "Select Color",
                                                filled: true,
                                                fillColor: _yarnFilterProvider
                                                    .pickerColor),
                                            onTap: () {
                                              openDialogBox();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            //Show Appearance
                            Visibility(
                              visible: /*showAppearance ??*/ false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: apperance)),
                                  SingleSelectTileWidget(
                                      key: _appearanceKey,
                                      selectedIndex: -1,
                                      spanCount: 3,
                                      listOfItems:
                                          _yarnFilterProvider.appearanceList!,
                                      callback:
                                          (YarnAppearance yarnAppearance) {
                                        _yarnFilterProvider
                                                .getSpecificationRequestModel
                                                .apperanceYarnId =
                                            filterList(
                                                _yarnFilterProvider
                                                    .listAppearanceId,
                                                yarnAppearance.yaId!);
                                      }),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show Spun Technique
                            Visibility(
                              visible: _yarnFilterProvider.showSpunTechnique ??
                                  false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: spunTech)),
                                  SingleSelectTileWidget(
                                    key: _spunTechKey,
                                    selectedIndex: -1,
                                    spanCount: 3,
                                    listOfItems:
                                        _yarnFilterProvider.spunTechList!,
                                    callback: (SpunTechnique spunTech) {
                                      // setState(() {
                                      //   _yarnFilterProvider.selectedSpunTechId =
                                      //       spunTech.ystId.toString();
                                      // });
                                      _yarnFilterProvider.spunSelection(spunTech);
                                      if(_qualityKey.currentState!= null){
                                        _qualityKey.currentState!.resetWidget();
                                      }
                                      _yarnFilterProvider.getSpecificationRequestModel.qualityId = null;
                                      if(_patternKey.currentState!= null){
                                        _patternKey.currentState!.resetWidget();
                                      }
                                      _yarnFilterProvider.getSpecificationRequestModel.patternId = null;

                                      _yarnFilterProvider
                                              .getSpecificationRequestModel
                                              .spunTechId =
                                          filterList(
                                              _yarnFilterProvider
                                                  .listOfSpunTechId,
                                              spunTech.ystId!);
                                    },
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show Quality
                            Visibility(
                              visible: _yarnFilterProvider.showQuality ?? false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child:
                                          TitleSmallTextWidget(title: quality)),
                                  SingleSelectTileWidget(
                                    key: _qualityKey,
                                    selectedIndex: -1,
                                    spanCount: 2,
                                    listOfItems:
                                        _yarnFilterProvider.qualityList!,
                                    callback: (Quality quality) {
                                      _yarnFilterProvider
                                              .getSpecificationRequestModel
                                              .qualityId =
                                          filterList(
                                              _yarnFilterProvider
                                                  .listOfQualityId,
                                              quality.yqId!);
                                    },
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show Pattern
                            Visibility(
                              visible: _yarnFilterProvider.showPattern ?? false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w, bottom: 8.w),
                                      child:
                                          TitleSmallTextWidget(title: pattern)),
                                  SingleSelectTileWidget(
                                    key: _patternKey,
                                    selectedIndex: -1,
                                    spanCount: 3,
                                    listOfItems:
                                        _yarnFilterProvider.patternList!,
                                    callback: (PatternModel pattern) {
                                      _yarnFilterProvider
                                              .getSpecificationRequestModel
                                              .patternId =
                                          filterList(
                                              _yarnFilterProvider.listOfPattern,
                                              pattern.ypId!);
                                      _yarnFilterProvider.patternSelection(pattern);
                                    },
                                  ),
                                  SizedBox(
                                    height: 4.w,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            //Show Pattern charac
                            // Visibility(
                            //   visible: _yarnFilterProvider.showPatternCharc ?? false,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     mainAxisAlignment:
                            //     MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Padding(
                            //           padding: EdgeInsets.only(
                            //               left: 8.w, bottom: 8.w),
                            //           child:
                            //           TitleSmallTextWidget(title: pattern)),
                            //       SingleSelectTileWidget(
                            //         selectedIndex: -1,
                            //         spanCount: 3,
                            //         listOfItems:
                            //         _yarnFilterProvider.patternCharList!,
                            //         callback: (PatternCharectristic pattern) {
                            //           _yarnFilterProvider
                            //               .getSpecificationRequestModel
                            //               .patternCharId =
                            //               filterList(
                            //                   _yarnFilterProvider.listOfPattern,
                            //                   pattern.ypcId!);
                            //         },
                            //       ),
                            //       SizedBox(
                            //         height: 4.w,
                            //       ),
                            //       const Divider(),
                            //     ],
                            //   ),
                            // ),
                            //Show Grade
                            Visibility(
                              visible: _yarnFilterProvider.showGrade ?? false,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: grades)),
                                    SingleSelectTileWidget(
                                      selectedIndex: -1,
                                      key: _gradeKey,
                                      spanCount: 3,
                                      listOfItems:
                                          _yarnFilterProvider.gradesList!,
                                      callback: (YarnGrades grades) {
                                        _yarnFilterProvider
                                            .getSpecificationRequestModel
                                            .gradeId = [grades.grdId!];
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                              visible: _yarnFilterProvider.showCertification ?? false,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: certification)),
                                    SingleSelectTileWidget(
                                      key: _certificationKey,
                                      spanCount: 3,
                                      listOfItems:
                                      _yarnFilterProvider.certificationList!,
                                      callback: (Certification certification) {
                                        _yarnFilterProvider
                                            .getSpecificationRequestModel
                                            .certificationId = [certification.cerId];
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButtonWithoutIcon(
                            callback: () {
                              _resetData();
                              _yarnFilterProvider.selectedYarnFamily = _yarnFilterProvider.familyList!.first;
                              _yarnFilterProvider
                                  .getSyncedData(_yarnFilterProvider.familyList!.first.famId!);
                              _yarnFilterProvider.querySetting(_yarnFilterProvider.familyList!.first.famId!);
                            },
                            color: Colors.grey.shade300,
                            btnText: 'Reset',
                            textColor: 'black',
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Expanded(
                          child: ElevatedButtonWithoutIcon(
                              callback: () {
                                Navigator.pop(
                                    context,
                                    _yarnFilterProvider
                                        .getSpecificationRequestModel);
                              },
                              color: textColorBlue,
                              btnText: 'Apply Filter'),
                        ),
                      ],
                    )
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  void handleReadOnlyInputClick(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: YearPicker(
                selectedDate: DateTime(DateTime.now().year),
                firstDate: DateTime(DateTime.now().year - 4),
                lastDate: DateTime.now(),
                onChanged: (val) {
                  _yarnFilterProvider.textEditingController.text =
                      val.year.toString();
                  Navigator.pop(context);
                },
              ),
            ));
  }

  List<int> filterList(List<int> list, int value) {
    // if (list.contains(value)) {
    //   list.remove(value);
    // } else {
    list.clear();
    list.add(value);
    // }

    return list.toSet().toList();
  }

  void _showPatternChar(PatternModel pattern) {
    if (pattern.ypId == 1 ||
        pattern.ypId == 2 ||
        pattern.ypId == 3 ||
        pattern.ypId == 4) {
      setState(() {
        _yarnFilterProvider.showPatternCharc = true;
        // _yarnFilterProvider.selectedPatternId = pattern.ypId.toString();
      });
    } else {
      setState(() {
        _yarnFilterProvider.showPatternCharc = false;
        // _yarnFilterProvider.selectedPatternId = null;
        _yarnFilterProvider.getSpecificationRequestModel.patternCharId = null;
      });
    }
  }

  void _showDoublingMethod(Ply ply) {
    if (ply.plyId != 1) {
      setState(() {
        _yarnFilterProvider.showDoublingMethod = true;
        // _yarnFilterProvider.selectedPlyId = ply.plyId.toString();
      });
    } else {
      setState(() {
        _yarnFilterProvider.showDoublingMethod = false;
        // _yarnFilterProvider.selectedPlyId = null;
        _yarnFilterProvider.getSpecificationRequestModel.doublingMethodId =
            null;
      });
    }
  }

  // void _showDyingMethod(ColorTreatmentMethod colorTreatmentMethod) {
  //   if (colorTreatmentIdList.contains(colorTreatmentMethod.yctmId)) {
  //     setState(() {
  //       showDyingMethod = true;
  //       _selectedColorTreatMethodId = colorTreatmentMethod.yctmId.toString();
  //     });
  //   } else {
  //     setState(() {
  //       showDyingMethod = false;
  //       _selectedColorTreatMethodId = colorTreatmentMethod.yctmId.toString();
  //       _getSpecificationRequestModel!.doublingMethodId = null;
  //     });
  //   }
  // }

  void _resetData() {
    if (_yarnTypeKey.currentState != null) {
      _yarnTypeKey.currentState!.resetWidget();
    }
    if (_usageKey.currentState != null) {
      _usageKey.currentState!.resetWidget();
    }
    if (_appearanceKey.currentState != null) {
      _appearanceKey.currentState!.resetWidget();
    }
    if (_plyKey.currentState != null) _plyKey.currentState!.resetWidget();
    if (_patternKey.currentState != null) {
      _patternKey.currentState!.resetWidget();
    }

    if (_orientationKey.currentState != null) {
      _orientationKey.currentState!.resetWidget();
    }
    if (_spunTechKey.currentState != null) {
      _spunTechKey.currentState!.resetWidget();
    }
    if (_qualityKey.currentState != null) {
      _qualityKey.currentState!.resetWidget();
    }

    if (_gradeKey.currentState != null) {
      _gradeKey.currentState!.resetWidget();
    }
    if (_doublingMethodKey.currentState != null) {
      _doublingMethodKey.currentState!.resetWidget();
    }
    if (_dyingMethodKey.currentState != null) {
      _dyingMethodKey.currentState!.resetWidget();
    }
    if (_colorTreatmentMethodKey.currentState != null) {
      _colorTreatmentMethodKey.currentState!.resetWidget();
    }
    if (_certificationKey.currentState != null) {
      _certificationKey.currentState!.resetWidget();
    }
    _yarnFilterProvider.getSpecificationRequestModel =
        GetSpecificationRequestModel();
    _yarnFilterProvider.getSpecificationRequestModel.categoryId = '2';
    _yarnFilterProvider.showDyingMethod = false;
    _yarnFilterProvider.showDoublingMethod = false;
    _yarnFilterProvider.showPatternCharc = false;
    _yarnFilterProvider.showQuality = false;

  }





}
