import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/filter_widget/filter_category_single_select_widget.dart';
import 'package:yg_app/elements/filter_widget/filter_grid_tile_widget.dart';
import 'package:yg_app/elements/filter_widget/filter_range_slider.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/string_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class YarnFilterBody extends StatefulWidget {
  final YarnSyncResponse? syncResponse;

  const YarnFilterBody({Key? key, required this.syncResponse})
      : super(key: key);

  @override
  _YarnFilterBodyState createState() => _YarnFilterBodyState();
}

class _YarnFilterBodyState extends State<YarnFilterBody> {
  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      _textEditingController.text = '#${pickerColor.value.toRadixString(16)}';
    });
  }

  void openDialogBox() {
    // raise the [showDialog] widget
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                setState(() => pickerColor = pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _textEditingController = TextEditingController();

  Color pickerColor = const Color(0xffffffff);
  GetSpecificationRequestModel? _getSpecificationRequestModel;

  List<YarnSetting> listOfSettings = [];
  List<int> listOfMaterials = [];
  List<int> listOfYarnType = [];
  List<int> listOfPattern = [];
  List<int> listOfOrientation = [];
  List<int> listOfUsageId = [];
  List<int> listOfPlyId = [];
  List<int> listOfColorTreatmentId = [];
  List<int> listOfTwistDirectionId = [];
  List<int> listOfSpunTechId = [];
  List<int> listOfQualityId = [];
  List<int> listApperanceId = [];

  YarnSetting? _yarnSetting;
  String? selectedFamilyId;
  String? selectedBlendId;
  bool? showTexturized;
  bool? showBlend;
  bool? showDannier;
  bool? showFilament;
  bool? showUsage;
  bool? showAppearance;
  bool? showColorDyingMethod;
  bool? showColorCode;
  bool? showRatio;
  bool? showCount;
  bool? showPly;
  bool? showDoublingMethod;
  bool? showColorTreatmentMethod;
  bool? showOrientation;
  bool? showTwistDirection;
  bool? showSpunTechnique;
  bool? showQuality;
  bool? showPattern;
  bool? showPatternCharc;
  bool? showGrade;
  bool? showCertification;

  double minDannier = 0.0;
  double minFilament = 0.0;
  double minCount = 0.0;
  double minRatio = 0.0;
  double maxDannier = 0.0;
  double maxFilament = 0.0;
  double maxCount = 0.0;
  double maxRatio = 100.0;

  double? minValueDannierParam;
  double? maxValueDannierParam;
  double? minValueFilamentParam;
  double? maxValueFilamentParam;
  double? minValueCountParam;
  double? maxValueCountParam;
  double? minValueRatioParam;
  double? maxValueRatioParam;

  bool isListClear = false;

  @override
  void initState() {
    selectedFamilyId = "1";
    // selectedBlendId = "1";
    _getSpecificationRequestModel = GetSpecificationRequestModel();
    _querySetting(int.parse(selectedFamilyId!));
    setState(() {
      _minMaxConfiguration();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextWidget(title: yarnCategory),
                      SizedBox(
                        height: 8.w,
                      ),
                      SizedBox(
                        height: 0.055 * MediaQuery.of(context).size.height,
                        child: CategorySingleSelectWidget(
                          listItems: widget.syncResponse!.data.yarn.family,
                          callback: (value) {
                            //Family Id

                            setState(() {
                              selectedFamilyId =
                                  (value as Family).famId!.toString();
                            });
                            _querySetting((value as Family).famId!);
                            _getSpecificationRequestModel!.ysFamilyIdFk =
                                (value).famId!.toString();

                            // _querySetting(widget
                            //     .syncResponse!.data.yarn.family![value].famId!);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                    ],
                  ),
                  //Show Blends
                  Visibility(
                    visible: showBlend ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleTextWidget(title: blend)),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          child: CatWithImageListWidget(
                            listItem: widget.syncResponse!.data.yarn.blends!
                                .where((element) =>
                                    element.familyIdfk == selectedFamilyId)
                                .toList(),
                            onClickCallback: (value) {
                              setState(() {
                                selectedBlendId = widget
                                    .syncResponse!.data.yarn.blends!
                                    .where((element) =>
                                        element.familyIdfk == selectedFamilyId)
                                    .toList()[value]
                                    .blnId
                                    .toString();
                              });
                              _getSpecificationRequestModel!.ysBlendIdFk =
                                  selectedBlendId;
                              _querySettingWithBlend(
                                  int.parse(selectedBlendId!),
                                  int.parse(selectedFamilyId!));
                            },
                            selectedItem: -1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 8.w,
                  ),

                  //Show Texturzed
                  Visibility(
                    visible: widget.syncResponse!.data.yarn.yarnTypes!
                            .where((element) =>
                                element.ytBlendIdfk == selectedBlendId)
                            .toList()
                            .isNotEmpty
                        ? showTexturized ?? false
                        : false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child:
                                TitleSmallTextWidget(title: yarnTexturedType)),
                        FilterGridTileWidget(
                          spanCount: 3,
                          listOfItems: widget.syncResponse!.data.yarn.yarnTypes!
                              .where((element) =>
                                  element.ytBlendIdfk == selectedBlendId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.yarnYypeId =
                                filterList(
                                    listOfYarnType,
                                    widget.syncResponse!.data.yarn.yarnTypes!
                                        .where(
                                            (element) =>
                                                element.ytBlendIdfk ==
                                                selectedBlendId)
                                        .toList()[index]
                                        .ytId!);
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  //Show Dannier
                  Visibility(
                    visible: showDannier ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FilterRangeSlider(
                          // minMaxRange: widget.syncFiberResponse.data.fiber
                          //     .settings[0].micMinMax,
                          minValue: minDannier,
                          maxValue: maxDannier,
                          hintTxt: "Dannier",
                          // minCallback: (value) {
                          //   minValueDannierParam = value;
                          // },
                          // maxCallback: (value) {
                          //   maxValueDannierParam = value;
                          // },
                          valueCallback: (value) {},
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Divider(),
                      ],
                    ),
                  ),

                  //Show Filament
                  Visibility(
                    visible: showFilament ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FilterRangeSlider(
                          // minMaxRange: widget.syncFiberResponse.data.fiber
                          //     .settings[0].micMinMax,
                          minValue: minFilament,
                          maxValue: maxFilament,
                          hintTxt: "Filament",
                          valueCallback: (value) {},
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Divider(),
                      ],
                    ),
                  ),

                  //Show Count
                  Visibility(
                    visible: showCount ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FilterRangeSlider(
                          // minMaxRange: widget.syncFiberResponse.data.fiber
                          //     .settings[0].micMinMax,
                          minValue: minCount,
                          maxValue: maxCount,
                          hintTxt: "Count",
                          valueCallback: (value) {},
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Divider(),
                      ],
                    ),
                  ),

                  //Show Ratio
                  Visibility(
                    visible: showRatio ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FilterRangeSlider(
                          // minMaxRange: widget.syncFiberResponse.data.fiber
                          //     .settings[0].micMinMax,
                          minValue: minRatio,
                          maxValue: maxRatio,
                          hintTxt: "Ratio",
                          valueCallback: (value) {},
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                        Divider(),
                      ],
                    ),
                  ),

                  //Show Usage
                  Visibility(
                    visible: showUsage ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: usage)),
                        FilterGridTileWidget(
                          spanCount: 2,
                          listOfItems: widget.syncResponse!.data.yarn.usage!
                              .where((element) =>
                                  element.ysFamilyId == selectedFamilyId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.yuId = filterList(
                                listOfUsageId,
                                widget.syncResponse!.data.yarn.usage!
                                    .where((element) =>
                                        element.ysFamilyId == selectedFamilyId)
                                    .toList()[index]
                                    .yuId!);
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  //Show Appearance
                  Visibility(
                    visible: showAppearance ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: apperance)),
                        FilterGridTileWidget(
                          spanCount: 3,
                          listOfItems: widget.syncResponse!.data.yarn.apperance!
                              .where((element) =>
                                  element.familyId == selectedFamilyId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.apperanceYarnId =
                                filterList(
                                    listApperanceId,
                                    widget
                                        .syncResponse!.data.yarn.apperance!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList()[index]
                                        .yaId!);
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
                  Visibility(
                    visible: /*showColorDyingMethod ??*/ false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: "Dying Method")),
                        FilterGridTileWidget(
                          spanCount: 3,
                          listOfItems:
                              widget.syncResponse!.data.yarn.dyingMethod!,
                          callback: (index) {
                            // _getSpecificationRequestModel!.gradeId =
                            //     filterList(
                            //         listOfGrades,
                            //         widget.syncFiberResponse.data.fiber
                            //             .grades[index].grdId!);
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  //Show Color Code
                  Visibility(
                      visible: showColorCode ?? false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child:
                                  TitleSmallTextWidget(title: "Select Color"),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: SizedBox(
                                width: 120.w,
                                child: TextFormField(
                                  keyboardType: TextInputType.none,
                                  controller: _textEditingController,
                                  autofocus: false,
                                  showCursor: false,
                                  readOnly: true,
                                  style: TextStyle(fontSize: 11.sp),
                                  textAlign: TextAlign.center,
                                  onSaved: (input) =>
                                      _getSpecificationRequestModel!
                                          .ys_color_code = input,
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return "Select Color Code";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none),
                                      contentPadding: const EdgeInsets.all(2.0),
                                      hintText: "Select Color",
                                      filled: true,
                                      fillColor: pickerColor),
                                  onTap: () {
                                    openDialogBox();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                  //Show Ply
                  Visibility(
                    visible: showPly ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: ply)),
                        FilterGridTileWidget(
                          spanCount: 4,
                          listOfItems: widget.syncResponse!.data.yarn.ply!
                              .where((element) =>
                                  element.familyId == selectedFamilyId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.plyId = filterList(
                                listOfPlyId,
                                widget.syncResponse!.data.yarn.ply!
                                    .where((element) =>
                                        element.familyId == selectedFamilyId)
                                    .toList()[index]
                                    .plyId!);
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
                    visible: /*showDoublingMethod ?? */ false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child:
                                TitleSmallTextWidget(title: "Doubling Method")),
                        FilterGridTileWidget(
                          spanCount: 3,
                          listOfItems:
                              widget.syncResponse!.data.yarn.doublingMethod!,
                          callback: (index) {
                            // _getSpecificationRequestModel!.gradeId =
                            //     filterList(
                            //         listOfGrades,
                            //         widget.syncFiberResponse.data.fiber
                            //             .grades[index].grdId!);
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
                    visible: showColorTreatmentMethod ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(
                                title: colorTreatmentMethod)),
                        FilterGridTileWidget(
                          spanCount: 3,
                          listOfItems: widget
                              .syncResponse!.data.yarn.colorTreatmentMethod!
                              .where((element) =>
                                  element.familyId == selectedFamilyId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.colorTreatmentId =
                                filterList(
                                    listOfColorTreatmentId,
                                    widget.syncResponse!.data.yarn
                                        .colorTreatmentMethod!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList()[index]
                                        .yctmId!);
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
                    visible: showOrientation ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: 'Orientation')),
                        FilterGridTileWidget(
                          spanCount: 2,
                          listOfItems: widget
                              .syncResponse!.data.yarn.orientation!
                              .where((element) =>
                                  element.familyId == selectedFamilyId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.orientationId =
                                filterList(
                                    listOfOrientation,
                                    widget.syncResponse!.data.yarn.orientation!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList()[index]
                                        .yoId!);
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  //Show Twist Direction
                  Visibility(
                    visible: showTwistDirection ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: twistDirection)),
                        FilterGridTileWidget(
                          spanCount: 2,
                          listOfItems: widget
                              .syncResponse!.data.yarn.twistDirection!
                              .where((element) =>
                                  element.familyId == selectedFamilyId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.twistDirectionId =
                                filterList(
                                    listOfTwistDirectionId,
                                    widget
                                        .syncResponse!.data.yarn.twistDirection!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList()[index]
                                        .ytdId!);
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  //Show Spun Technique
                  Visibility(
                    visible: showSpunTechnique ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: spunTech)),
                        FilterGridTileWidget(
                          spanCount: 4,
                          listOfItems: widget
                              .syncResponse!.data.yarn.spunTechnique!
                              .where((element) =>
                                  element.familyId == selectedFamilyId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.spunTechId =  filterList(
                                listOfSpunTechId,
                                widget
                                    .syncResponse!.data.yarn.spunTechnique!
                                    .where((element) =>
                                element.familyId == selectedFamilyId)
                                    .toList()[index]
                                    .ystId!) ;
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
                    visible: showQuality ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: quality)),
                        FilterGridTileWidget(
                          spanCount: 2,
                          listOfItems: widget.syncResponse!.data.yarn.quality!
                              .where((element) =>
                                  element.familyId == selectedFamilyId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.qualityId = filterList(listOfQualityId,  widget
                                .syncResponse!.data.yarn.quality!
                                .where((element) =>
                            element.familyId == selectedFamilyId)
                                .toList()[index]
                                .yqId!);
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
                    visible: showPattern ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: pattern)),
                        FilterGridTileWidget(
                          spanCount: 3,
                          listOfItems: widget.syncResponse!.data.yarn.pattern!
                              .where((element) =>
                                  element.familyId == selectedFamilyId)
                              .toList(),
                          callback: (index) {
                            _getSpecificationRequestModel!.patternId = filterList(listOfPattern,  widget
                                .syncResponse!.data.yarn.pattern!
                                .where((element) =>
                            element.familyId == selectedFamilyId)
                                .toList()[index]
                                .ypId!) ;
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  //Show Pattern characteristics
                  Visibility(
                    visible: /*showPatternCharc ??*/ false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child: TitleSmallTextWidget(title: patternChar)),
                        FilterGridTileWidget(
                          spanCount: 2,
                          listOfItems: widget
                              .syncResponse!.data.yarn.patternCharectristic!,
                          callback: (index) {
                            // _getSpecificationRequestModel!.gradeId =
                            //     filterList(
                            //         listOfGrades,
                            //         widget.syncFiberResponse.data.fiber
                            //             .grades[index].grdId!);
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  //Show Certifications
                  Visibility(
                    visible: showPattern ?? false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                            child:
                                TitleSmallTextWidget(title: "Certifications")),
                        FilterGridTileWidget(
                          spanCount: 3,
                          listOfItems:
                              widget.syncResponse!.data.yarn.certification!,
                          callback: (index) {
                            _getSpecificationRequestModel!.certificationId = [
                              widget.syncResponse!.data.yarn
                                  .certification![index].cerId
                            ];
                          },
                        ),
                        SizedBox(
                          height: 4.w,
                        ),
                        const Divider(),
                      ],
                    ),
                  ),

                  // Visibility(
                  //   visible: showRatio ?? false,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       FilterRangeSlider(
                  //         // minMaxRange: widget.syncFiberResponse.data.fiber
                  //         //     .settings[0].micMinMax,
                  //         minValue: minDannier,
                  //         maxValue: maxDannier,
                  //         hintTxt: "Ratio",
                  //         // minCallback: (value) {
                  //         //   minValueRatioParam = value;
                  //         // },
                  //         // maxCallback: (value) {
                  //         //   maxValueRatioParam = value;
                  //         // },
                  //         valueCallback: (value){},
                  //
                  //       ),
                  //       SizedBox(
                  //         height: 8.w,
                  //       ),
                  //       Divider(),
                  //     ],
                  //   ),
                  // ),
                  // Visibility(
                  //   visible: showRatio ?? false,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       FilterRangeSlider(
                  //         // minMaxRange: widget.syncFiberResponse.data.fiber
                  //         //     .settings[0].micMinMax,
                  //         minValue: minDannier,
                  //         maxValue: maxDannier,
                  //         hintTxt: "Ratio",
                  //         // minCallback: (value) {
                  //         //   minValueRatioParam = value;
                  //         // },
                  //         // maxCallback: (value) {
                  //         //   maxValueRatioParam = value;
                  //         // },
                  //         valueCallback: (value){},
                  //
                  //       ),
                  //       SizedBox(
                  //         height: 8.w,
                  //       ),
                  //       Divider(),
                  //     ],
                  //   ),
                  // ),
                  // Visibility(
                  //   visible: showRatio ?? false,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       FilterRangeSlider(
                  //         // minMaxRange: widget.syncFiberResponse.data.fiber
                  //         //     .settings[0].micMinMax,
                  //         minValue: minDannier,
                  //         maxValue: maxDannier,
                  //         hintTxt: "Ratio",
                  //         valueCallback: (value){},
                  //
                  //         // minCallback: (value) {
                  //         //   minValueRatioParam = value;
                  //         // },
                  //         // maxCallback: (value) {
                  //         //   maxValueRatioParam = value;
                  //         // },
                  //       ),
                  //       SizedBox(
                  //         height: 8.w,
                  //       ),
                  //       Divider(),
                  //     ],
                  //   ),
                  // ),
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
                      Navigator.pop(context, _getSpecificationRequestModel);
                    },
                    color: textColorBlue,
                    btnText: 'Apply Filter'),
              ),
            ],
          )
        ],
      ),
    );
  }

  _querySetting(int id) {
    AppDbInstance.getDbInstance().then(
        (db) => db.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
              late bool isSettingInList;
              late YarnSetting _yarnSetting;

              if (!isListClear) {
                listOfSettings.clear();
                isListClear = false;
              }
              if (listOfSettings.isNotEmpty) {
                for (var element in listOfSettings) {
                  _yarnSetting = value[0];

                  if (element.ysFiberMaterialIdfk ==
                      _yarnSetting.ysFiberMaterialIdfk) {
                    isSettingInList = true;
                    break;
                  } else {
                    isSettingInList = false;
                  }
                }

                isSettingInList
                    ? listOfSettings.removeWhere((element) =>
                        element.ysFiberMaterialIdfk ==
                        _yarnSetting.ysFiberMaterialIdfk)
                    // ? listOfSettings.toSet().toList()
                    : listOfSettings.add(_yarnSetting);
              } else {
                listOfSettings.add(value[0]);
              }
              _minMaxConfiguration();
              _showHideConfiguration();
            }));
  }

  _querySettingWithBlend(int id, int blend) {
    AppDbInstance.getDbInstance().then((db) => db.yarnSettingsDao
            .findFamilyAndBlendYarnSettings(blend, id)
            .then((value) {
          if (value.isNotEmpty) {
            late bool isSettingInList;
            late YarnSetting _yarnSetting;

            if (!isListClear) {
              listOfSettings.clear();
              isListClear = false;
            }
            if (listOfSettings.isNotEmpty) {
              for (var element in listOfSettings) {
                _yarnSetting = value[0];

                if (element.ysFiberMaterialIdfk ==
                    _yarnSetting.ysFiberMaterialIdfk) {
                  isSettingInList = true;
                  break;
                } else {
                  isSettingInList = false;
                }
              }

              isSettingInList
                  ? listOfSettings.removeWhere((element) =>
                      element.ysFiberMaterialIdfk ==
                      _yarnSetting.ysFiberMaterialIdfk)
                  // ? listOfSettings.toSet().toList()
                  : listOfSettings.add(_yarnSetting);
            } else {
              listOfSettings.add(value[0]);
            }
            _minMaxConfiguration();
            _showHideConfiguration();
          }
        }));
  }

  _minMaxConfiguration() {
    for (var element in listOfSettings.isEmpty
        ? widget.syncResponse!.data.yarn.setting!
        : listOfSettings) {
      _setMinMaxConfiguration(element);
    }
  }

  void _setMinMaxConfiguration(YarnSetting element) {
    setState(() {
      if (StringUtils.splitMin(element.countMinMax) > minCount) {
        minCount = StringUtils.splitMin(element.countMinMax);
      }
      if (StringUtils.splitMax(element.countMinMax) > maxCount) {
        maxCount = StringUtils.splitMax(element.countMinMax);
      }
      if (StringUtils.splitMin(element.filamentMinMax) > minFilament) {
        minFilament = StringUtils.splitMin(element.filamentMinMax);
      }
      if (StringUtils.splitMax(element.filamentMinMax) > maxFilament) {
        maxFilament = StringUtils.splitMax(element.filamentMinMax);
      }
      if (StringUtils.splitMin(element.dannierMinMax) > minDannier) {
        minDannier = StringUtils.splitMin(element.dannierMinMax);
      }
      if (StringUtils.splitMax(element.dannierMinMax) > maxDannier) {
        maxDannier = StringUtils.splitMax(element.dannierMinMax);
      }
    });
  }

  void _showHideConfiguration() {
    bool? tempShowTexturized;
    bool? tempShowBlend;
    bool? tempShowDannier;
    bool? tempShowFilament;
    bool? tempShowUsage;
    bool? tempShowAppearance;
    bool? tempShowColorDyingMethod;
    bool? tempShowColorCode;
    bool? tempShowRatio;
    bool? tempShowCount;
    bool? tempShowPly;
    bool? tempShowDoublingMethod;
    bool? tempShowColorTreatmentMethod;
    bool? tempShowOrientation;
    bool? tempShowTwistDirection;
    bool? tempShowSpunTechnique;
    bool? tempShowQuality;
    bool? tempShowPattern;
    bool? tempShowPatternCharc;
    bool? tempShowGrade;
    bool? tempShowCertification;

    if (listOfSettings.isNotEmpty) {
      for (var element in listOfSettings) {
        // setState(() {

        tempShowBlend = tempShowBlend == null
            ? Ui.showHide(element.showBlend)
            : (showBlend! && Ui.showHide(element.showBlend) && tempShowBlend)
                ? true
                : false;

        tempShowGrade = tempShowGrade == null
            ? Ui.showHide(element.showGrade)
            : (showGrade! && Ui.showHide(element.showGrade) && tempShowGrade)
                ? true
                : false;

        tempShowTexturized = tempShowTexturized == null
            ? Ui.showHide(element.showTexturized)
            : (showTexturized! &&
                    Ui.showHide(element.showTexturized) &&
                    tempShowTexturized)
                ? true
                : false;

        tempShowFilament = tempShowFilament == null
            ? Ui.showHide(element.showFilament)
            : (showFilament! &&
                    Ui.showHide(element.showFilament) &&
                    tempShowFilament)
                ? true
                : false;

        tempShowDannier = tempShowDannier == null
            ? Ui.showHide(element.showDannier)
            : (showDannier! &&
                    Ui.showHide(element.showDannier) &&
                    tempShowDannier)
                ? true
                : false;

        tempShowAppearance = tempShowAppearance == null
            ? Ui.showHide(element.showAppearance)
            : (showAppearance! &&
                    Ui.showHide(element.showAppearance) &&
                    tempShowAppearance)
                ? true
                : false;

        tempShowCount = tempShowCount == null
            ? Ui.showHide(element.showCount)
            : (showCount! && Ui.showHide(element.showCount) && tempShowCount)
                ? true
                : false;

        tempShowRatio = tempShowRatio == null
            ? Ui.showHide(element.showRatio)
            : (showRatio! && Ui.showHide(element.showRatio) && tempShowRatio)
                ? true
                : false;

        tempShowCertification = tempShowCertification == null
            ? Ui.showHide(element.showCertification)
            : (showCertification! &&
                    Ui.showHide(element.showCertification) &&
                    tempShowCertification)
                ? true
                : false;

        tempShowColorDyingMethod = tempShowColorDyingMethod == null
            ? Ui.showHide(element.showDyingMethod)
            : (showColorDyingMethod! &&
                    Ui.showHide(element.showDyingMethod) &&
                    tempShowColorDyingMethod)
                ? true
                : false;

        tempShowColorTreatmentMethod = tempShowColorTreatmentMethod == null
            ? Ui.showHide(element.showColorTreatmentMethod)
            : (showColorTreatmentMethod! &&
                    Ui.showHide(element.showColorTreatmentMethod) &&
                    tempShowColorTreatmentMethod)
                ? true
                : false;

        tempShowPly = tempShowPly == null
            ? Ui.showHide(element.showPly)
            : (showPly! && Ui.showHide(element.showPly) && tempShowPly)
                ? true
                : false;

        tempShowPattern = tempShowPattern == null
            ? Ui.showHide(element.showPattern)
            : (showPattern! &&
                    Ui.showHide(element.showPattern) &&
                    tempShowPattern)
                ? true
                : false;

        tempShowPatternCharc = tempShowPatternCharc == null
            ? Ui.showHide(element.showPatternCharectristic)
            : (showPatternCharc! &&
                    Ui.showHide(element.showPatternCharectristic) &&
                    tempShowPatternCharc)
                ? true
                : false;

        tempShowOrientation = tempShowOrientation == null
            ? Ui.showHide(element.showOrientation)
            : (showOrientation! &&
                    Ui.showHide(element.showOrientation) &&
                    tempShowOrientation)
                ? true
                : false;

        tempShowSpunTechnique = tempShowSpunTechnique == null
            ? Ui.showHide(element.showSpunTechnique)
            : (showSpunTechnique! &&
                    Ui.showHide(element.showSpunTechnique) &&
                    tempShowSpunTechnique)
                ? true
                : false;

        tempShowTwistDirection = tempShowTwistDirection == null
            ? Ui.showHide(element.showTwistDirection)
            : (showTwistDirection! &&
                    Ui.showHide(element.showTwistDirection) &&
                    tempShowTwistDirection)
                ? true
                : false;

        tempShowColorCode = tempShowColorCode == null
            ? Ui.showHide(element.showColor)
            : (showColorCode! &&
                    Ui.showHide(element.showColor) &&
                    tempShowColorCode)
                ? true
                : false;

        tempShowDoublingMethod = tempShowDoublingMethod == null
            ? Ui.showHide(element.showDoublingMethod)
            : (showDoublingMethod! &&
                    Ui.showHide(element.showDoublingMethod) &&
                    tempShowDoublingMethod)
                ? true
                : false;

        tempShowQuality = tempShowQuality == null
            ? Ui.showHide(element.showQuality)
            : (showQuality! &&
                    Ui.showHide(element.showQuality) &&
                    tempShowQuality)
                ? true
                : false;

        // });
      }

      setState(() {
        showGrade = tempShowGrade;
        showBlend = tempShowBlend;
        showCount = tempShowCount;
        showRatio = tempShowRatio;
        showCertification = tempShowCertification;
        showAppearance = tempShowAppearance;
        showFilament = tempShowFilament;
        showDannier = tempShowDannier;
        showUsage = tempShowUsage;
        showTexturized = tempShowTexturized;

        showUsage = tempShowUsage;
        showColorDyingMethod = tempShowColorDyingMethod;
        showColorCode = tempShowColorCode;
        showPly = tempShowPly;
        showDoublingMethod = tempShowDoublingMethod;
        showColorTreatmentMethod = tempShowColorTreatmentMethod;
        showOrientation = tempShowOrientation;
        showTwistDirection = tempShowTwistDirection;
        showSpunTechnique = tempShowSpunTechnique;
        showQuality = tempShowQuality;
        showPattern = tempShowPattern;
        showPatternCharc = tempShowPatternCharc;
        showGrade = tempShowGrade;
      });
    } else {
      setState(() {
        showGrade = null;
        showBlend = null;
        showTexturized = null;
        showCount = null;
        showRatio = null;
        showDannier = null;
        showFilament = null;
        showUsage = null;
        showAppearance = null;
        showUsage = null;
        showCertification = null;

        showUsage = null;
        showColorDyingMethod = null;
        showColorCode = null;
        showPly = null;
        showDoublingMethod = null;
        showColorTreatmentMethod = null;
        showOrientation = null;
        showTwistDirection = null;
        showSpunTechnique = null;
        showQuality = null;
        showPattern = null;
        showPatternCharc = null;
        showGrade = null;
      });
    }
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
                  _textEditingController.text = val.year.toString();
                  Navigator.pop(context);
                },
              ),
            ));
  }

  List<int> filterList(List<int> list, int value) {
    if (list.contains(value)) {
      list.remove(value);
    } else {
      list.add(value);
    }

    return list;
  }
}
