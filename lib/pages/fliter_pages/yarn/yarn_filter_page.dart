import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/filter_widget/filter_category_single_select_widget.dart';
import 'package:yg_app/elements/filter_widget/filter_grid_tile_widget.dart';
import 'package:yg_app/elements/filter_widget/filter_range_slider.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

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

  _getPattern() {
    if (_selectedSpunTechId != null) {
      if (_selectedSpunTechId == "1") {
        return _patternList!
            .where((element) => element.spun_technique_id == "1")
            .toList();
      }
      return _patternList!
          .where((element) => element.familyId == selectedFamilyId)
          .toList();
    }

    return _patternList!
        .where((element) => element.familyId == selectedFamilyId)
        .toList();
  }

  _getQuality() {
    if (_selectedSpunTechId != null) {
      if (_selectedSpunTechId == "1") {
        return _qualityList!
            .where((element) => element.spun_technique_id == "1")
            .toList();
      }
      return _qualityList!
          .where((element) => element.familyId == selectedFamilyId)
          .toList();
    }

    return _qualityList!
        .where((element) => element.familyId == selectedFamilyId)
        .toList();
  }

  _getSyncedData() async {
    await AppDbInstance().getYarnFamilyData()
        .then((value) => setState(() => _familyList = value));
    await AppDbInstance().getYarnBlendData()
        .then((value) => setState(() => _blendsList = value));
    await AppDbInstance().getYarnAppearance().then((value) => _appearanceList = value);
    await AppDbInstance().getYarnTypeData()
        .then((value) => setState(() => _yarnTypesList = value));
    await AppDbInstance().getYarnUsage()
        .then((value) => setState(() => _usageList = value));
    await AppDbInstance().getColorTreatmentMethodData()
        .then((value) => setState(() => _colorTreatmentMethodList = value));
    await AppDbInstance().getYarnDyingMethod()
        .then((value) => setState(() => _dyingMethodList = value));
    await AppDbInstance().getYarnPly()
        .then((value) => setState(() => _plyList = value));
    await AppDbInstance().getDoublingMethod()
        .then((value) => _doublingMethodList = value);
    await AppDbInstance().getOrientationData()
        .then((value) => _orientationList = value);
    await AppDbInstance().getSpunTech().then((value) => _spunTechList = value);
    await AppDbInstance().getYarnQuality().then((value) => _qualityList = value);
    await AppDbInstance().getPattern().then((value) => _patternList = value);
    await AppDbInstance().getTwistDirections().then((value) => _twistDirectionList = value);
    await AppDbInstance().getPatternCharacteristics()
        .then((value) => _patternCharList = value);
    await AppDbInstance().getCertificationsData()
        .then((value) => _certificationList = value);
    await AppDbInstance().getYarnGradesDao().then((value) => _gradesList = value);
    await AppDbInstance().getYarnSettings().then((value) {
      _yarnSettingsList = value;
      selectedFamilyId = "1";
      _getSpecificationRequestModel = GetSpecificationRequestModel();
      _querySetting(int.parse(selectedFamilyId!));
      /*added this to fix bug*/
      _getSpecificationRequestModel!.ysFamilyIdFk = [1];
      setState(() {
        _isGetSyncedData = true;
        _minMaxConfiguration();
      });
    });
  }

  List<Family>? _familyList;
  List<Blends>? _blendsList;
  List<Usage>? _usageList;
  List<ColorTreatmentMethod>? _colorTreatmentMethodList;
  List<Ply>? _plyList;
  List<DoublingMethod>? _doublingMethodList;
  List<DyingMethod>? _dyingMethodList;
  List<OrientationTable>? _orientationList;
  List<TwistDirection>? _twistDirectionList;
  List<SpunTechnique>? _spunTechList;
  List<Quality>? _qualityList;
  List<PatternModel>? _patternList;
  List<PatternCharectristic>? _patternCharList;
  List<YarnGrades>? _gradesList;
  List<YarnAppearance>? _appearanceList;
  List<Certification>? _certificationList;
  List<YarnTypes>? _yarnTypesList;
  List<YarnSetting>? _yarnSettingsList;

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
  List<int> listAppearanceId = [];
  List<int> listOfDyingMethod = [];
  List<int> listOfPatternChar = [];
  List<int> listOfDoublingMethod = [];

  String? selectedFamilyId;
  String? selectedBlendId;

  bool _isGetSyncedData = false;

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
  bool? showColorTreatmentMethod;
  bool? showOrientation;
  bool? showTwistDirection;
  bool? showSpunTechnique;
  bool? showQuality;
  bool? showPattern;

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

  //Show Hide on dependency
  bool? showDyingMethod;
  bool? showPatternCharc;
  bool? showDoublingMethod;

  final List<int> _colorTreatmentIdList = [3, 5, 8, 11, 13];
  final List<int> _plyIdList = [1, 5, 9, 13];
  final List<int> _patternIdList = [1, 2, 3, 4, 9, 10, 12];
  final List<int> _patternTLPIdList = [2, 9, 12];
  final List<int> _patternGRIdList = [10];

  String? _selectedPlyId;
  String? _selectedPatternId;
  String? _selectedAppearenceId;
  String? _selectedColorTreatMethodId;
  String? _selectedSpunTechId;

  @override
  void initState() {
    _getSyncedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isGetSyncedData ? Container(
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
                            height: 0.04 * MediaQuery.of(context).size.height,
                            child: SingleSelectTileRenewedWidget(
                              spanCount: 4,
                              listOfItems: _familyList!,
                              callback: (value) {
                                //Family Id

                                setState(() {
                                  selectedFamilyId =
                                      (value as Family).famId!.toString();
                                });
                                _querySetting((value as Family).famId!);
                                _getSpecificationRequestModel!.ysFamilyIdFk = [
                                  (value).famId!
                                ];
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
                              child: BlendsWithImageListWidget(
                                listItem: _blendsList!
                                    .where((element) =>
                                        element.familyIdfk == selectedFamilyId)
                                    .toList(),
                                onClickCallback: (value) {
                                  setState(() {
                                    selectedBlendId = _blendsList!
                                        .where((element) =>
                                            element.familyIdfk == selectedFamilyId)
                                        .toList()[value]
                                        .blnId
                                        .toString();
                                  });
                                  _getSpecificationRequestModel!.ysBlendIdFk = [
                                    int.parse(selectedBlendId!)
                                  ];
                                  _querySettingWithBlend(
                                      int.parse(selectedBlendId!),
                                      int.parse(selectedFamilyId!));
                                },
                                selectedItem: -1,
                              ),
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                          ],
                        ),
                      ),

                      //Show Texturzed
                      Visibility(
                        visible: showTexturized ?? true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                                child:
                                TitleSmallTextWidget(title: yarnTexturedType)),
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 3,
                              listOfItems: _yarnTypesList!,
                              callback: (YarnTypes yarnType) {
                                _getSpecificationRequestModel!.yarnYypeId =
                                    filterList(listOfYarnType, yarnType.ytId!);
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
                        visible: showUsage ?? false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                                child: TitleSmallTextWidget(title: usage)),
                            SingleSelectTileWidget(
                              spanCount: 2,
                              listOfItems: _usageList!
                                  .where((element) =>
                              element.ysFamilyId == selectedFamilyId)
                                  .toList(),
                              callback: (Usage usage) {
                                _getSpecificationRequestModel!.yuId =
                                    filterList(listOfUsageId, usage.yuId!);
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
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 3,
                              listOfItems: _plyList!
                                  .where((element) =>
                              element.familyId == selectedFamilyId)
                                  .toList(),
                              callback: (Ply ply) {
                                _getSpecificationRequestModel!.plyId =
                                    filterList(listOfPlyId, ply.plyId!);
                                _showDoublingMethod(ply);
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
                        visible: showDoublingMethod ?? false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                                child: const TitleSmallTextWidget(
                                    title: "Doubling Method")),
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 3,
                              listOfItems: _doublingMethodList!
                                  .where(
                                      (element) => element.plyId == _selectedPlyId)
                                  .toList(),
                              callback: (DoublingMethod doublingMethod) {
                                _getSpecificationRequestModel!.doublingMethodId =
                                    filterList(
                                        listOfDoublingMethod, doublingMethod.dmId!);
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
                                child: const TitleSmallTextWidget(
                                    title: 'Orientation')),
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 2,
                              listOfItems: _orientationList!
                                  .where((element) =>
                              element.familyId == selectedFamilyId)
                                  .toList(),
                              callback: (OrientationTable orientation) {
                                _getSpecificationRequestModel!.orientationId =
                                    filterList(
                                        listOfOrientation, orientation.yoId!);
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
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 3,
                              listOfItems: _colorTreatmentMethodList!
                                  .where((element) =>
                                      element.familyId == selectedFamilyId)
                                  .toList(),
                              callback:
                                  (ColorTreatmentMethod colorTreatmentMethod) {
                                _getSpecificationRequestModel!.colorTreatmentId =
                                    filterList(listOfColorTreatmentId,
                                        colorTreatmentMethod.yctmId!);
                                _showDyingMethod(colorTreatmentMethod);
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
                        visible: /*showDyingMethod ?? */false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                                child: const TitleSmallTextWidget(
                                    title: "Dying Method")),
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 3,
                              listOfItems: _dyingMethodList!
                                  .where((element) =>
                                      element.ydmColorTreatmentMethodIdfk ==
                                      _selectedColorTreatMethodId)
                                  .toList(),
                              callback: (DyingMethod dyingMethod) {
                                _getSpecificationRequestModel!
                                        .ys_dying_method_idfk =
                                    filterList(
                                        listOfDyingMethod, dyingMethod.ydmId!);
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
                          visible: showDyingMethod ?? false,
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
                                    width: double.infinity,
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

                      //Show Appearance
                      Visibility(
                        visible: /*showAppearance ??*/ false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                                child: TitleSmallTextWidget(title: apperance)),
                            SingleSelectTileWidget(
                                selectedIndex: -1,
                                spanCount: 3,
                                listOfItems: _appearanceList!
                                    .where((element) =>
                                        element.familyId == selectedFamilyId)
                                    .toList(),
                                callback: (YarnAppearance yarnAppearance) {
                                  _getSpecificationRequestModel!.apperanceYarnId =
                                      filterList(
                                          listAppearanceId, yarnAppearance.yaId!);
                                }),
                            SizedBox(
                              height: 4.w,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),



                     /* //Show Ratio
                      Visibility(
                        visible: *//*showRatio ?? *//*false,
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
                      ),*/




                   /*   //Show Twist Direction
                      Visibility(
                        visible: showTwistDirection ?? false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                                child: TitleSmallTextWidget(title: twistDirection)),
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 2,
                              listOfItems: _twistDirectionList!
                                  .where((element) =>
                                      element.familyId == selectedFamilyId)
                                  .toList(),
                              callback: (TwistDirection twistDirection) {
                                _getSpecificationRequestModel!.twistDirectionId =
                                    filterList(listOfTwistDirectionId,
                                        twistDirection.ytdId!);
                              },
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),*/

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
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 3,
                              listOfItems: _spunTechList!
                                  .where((element) =>
                                      element.familyId == selectedFamilyId)
                                  .toList(),
                              callback: (SpunTechnique spunTech) {
                                setState(() {
                                  _selectedSpunTechId = spunTech.ystId.toString();
                                });
                                _getSpecificationRequestModel!.spunTechId =
                                    filterList(listOfSpunTechId, spunTech.ystId!);
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
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 2,
                              listOfItems: _getQuality(),
                              callback: (Quality quality) {
                                _getSpecificationRequestModel!.qualityId =
                                    filterList(listOfQualityId, quality.yqId!);
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
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 3,
                              listOfItems: _getPattern(),
                              callback: (PatternModel pattern) {
                                _getSpecificationRequestModel!.patternId =
                                    filterList(listOfPattern, pattern.ypId!);
                                _showPatternChar(pattern);
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
                     /* Visibility(
                        visible: showPatternCharc ?? false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                                child: TitleSmallTextWidget(title: patternChar)),
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 2,
                              listOfItems: _patternCharList!
                                  .where((element) =>
                                      element.ypcPatternIdfk ==
                                      _selectedPatternId.toString())
                                  .toList(),
                              callback: (PatternCharectristic patterChar) {
                                _getSpecificationRequestModel!.patternCharId =
                                    filterList(
                                        listOfPatternChar, patterChar.ypcId!);
                              },
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),*/

                      //Show Grade
                      Visibility(
                        visible: showGrade ?? false,
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: TitleSmallTextWidget(title: grades)),
                              SingleSelectTileWidget(
                                spanCount: 3,
                                listOfItems: _gradesList!
                                    .where((element) =>
                                        element.familyId == selectedFamilyId)
                                    .toList(),
                                callback: (Grades grades) {
                                  _getSpecificationRequestModel!.gradeId = [
                                    grades.grdId!
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Show Certifications
                    /*  Visibility(
                        visible: showCertification ?? false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                                child: const TitleSmallTextWidget(
                                    title: "Certifications")),
                            SingleSelectTileWidget(
                              selectedIndex: -1,
                              spanCount: 3,
                              listOfItems: _certificationList!,
                              callback: (Certification certification) {
                                _getSpecificationRequestModel!.certificationId = [
                                  certification.cerId
                                ];
                              },
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            const Divider(),
                          ],
                        ),
                      ),*/
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
                        // _resetData();
                        setState(() {
                          selectedFamilyId = "1";
                        });
                        _querySetting(_familyList!.first.famId!);
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
        ) : Container(),
      ),
    );
  }

  _querySetting(int id) {
    AppDbInstance().getDbInstance().then(
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

                  if (element.ysFamilyIdfk ==
                      _yarnSetting.ysFamilyIdfk) {
                    isSettingInList = true;
                    break;
                  } else {
                    isSettingInList = false;
                  }
                }

                isSettingInList
                    ? listOfSettings.removeWhere((element) =>
                        element.ysFamilyIdfk ==
                        _yarnSetting.ysFamilyIdfk)
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
    AppDbInstance().getDbInstance().then((db) => db.yarnSettingsDao
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

                if (element.ysFamilyIdfk ==
                    _yarnSetting.ysFamilyIdfk) {
                  isSettingInList = true;
                  break;
                } else {
                  isSettingInList = false;
                }
              }

              isSettingInList
                  ? listOfSettings.removeWhere((element) =>
                      element.ysFamilyIdfk ==
                      _yarnSetting.ysFamilyIdfk)
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
    for (var element
        in listOfSettings.isEmpty ? _yarnSettingsList! : listOfSettings) {
      _setMinMaxConfiguration(element);
    }
  }

  void _setMinMaxConfiguration(YarnSetting element) {
    setState(() {
      if (Utils.splitMin(element.countMinMax) > minCount) {
        minCount = Utils.splitMin(element.countMinMax);
      }
      if (Utils.splitMax(element.countMinMax) > maxCount) {
        maxCount = Utils.splitMax(element.countMinMax);
      }
      if (Utils.splitMin(element.filamentMinMax) > minFilament) {
        minFilament = Utils.splitMin(element.filamentMinMax);
      }
      if (Utils.splitMax(element.filamentMinMax) > maxFilament) {
        maxFilament = Utils.splitMax(element.filamentMinMax);
      }
      if (Utils.splitMin(element.dannierMinMax) > minDannier) {
        minDannier = Utils.splitMin(element.dannierMinMax);
      }
      if (Utils.splitMax(element.dannierMinMax) > maxDannier) {
        maxDannier = Utils.splitMax(element.dannierMinMax);
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

        tempShowUsage = tempShowUsage == null
            ? Ui.showHide(element.showUsage)
            : (showUsage! && Ui.showHide(element.showUsage) && tempShowUsage)
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

        // tempShowPatternCharc = tempShowPatternCharc == null
        //     ? Ui.showHide(element.showPatternCharectristic)
        //     : (showPatternCharc! &&
        //             Ui.showHide(element.showPatternCharectristic) &&
        //             tempShowPatternCharc)
        //         ? true
        //         : false;

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

        // tempShowDoublingMethod = tempShowDoublingMethod == null
        //     ? Ui.showHide(element.showDoublingMethod)
        //     : (showDoublingMethod! &&
        //             Ui.showHide(element.showDoublingMethod) &&
        //             tempShowDoublingMethod)
        //         ? true
        //         : false;

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
        // showPatternCharc = tempShowPatternCharc;
        showGrade = tempShowGrade;
      });
    } else {
      // _resetData();
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
        showPatternCharc = true;
        _selectedPatternId = pattern.ypId.toString();
      });
    } else {
      setState(() {
        showPatternCharc = false;
        _selectedPatternId = null;
        _getSpecificationRequestModel!.patternCharId = null;
      });
    }
  }

  void _showDoublingMethod(Ply ply) {
    if (ply.plyId != 1) {
      setState(() {
        showDoublingMethod = true;
        _selectedPlyId = ply.plyId.toString();
      });
    } else {
      setState(() {
        showDoublingMethod = false;
        _selectedPlyId = null;
        _getSpecificationRequestModel!.doublingMethodId = null;
      });
    }
  }

  void _showDyingMethod(ColorTreatmentMethod colorTreatmentMethod) {
    if (_colorTreatmentIdList.contains(colorTreatmentMethod.yctmId)) {
      setState(() {
        showDyingMethod = true;
        _selectedColorTreatMethodId = colorTreatmentMethod.yctmId.toString();
      });
    } else {
      setState(() {
        showDyingMethod = false;
        _selectedColorTreatMethodId = colorTreatmentMethod.yctmId.toString();
        _getSpecificationRequestModel!.doublingMethodId = null;
      });
    }
  }

  void _resetData() {
    setState(() {
      _getSpecificationRequestModel!.ysBlendIdFk = null;
      _getSpecificationRequestModel!.yuId = null;
      _getSpecificationRequestModel!.ys_color_code = null;
      _getSpecificationRequestModel!.patternCharId = null;
      _getSpecificationRequestModel!.patternId = null;
      _getSpecificationRequestModel!.spunTechId = null;
      _getSpecificationRequestModel!.orientationId = null;
      _getSpecificationRequestModel!.ys_dying_method_idfk = null;
      _getSpecificationRequestModel!.qualityId = null;
      _getSpecificationRequestModel!.twistDirectionId = null;
      _getSpecificationRequestModel!.colorTreatmentId = null;
      _getSpecificationRequestModel!.yarnYypeId = null;
      _getSpecificationRequestModel!.apperanceYarnId = null;
    });
  }
}
