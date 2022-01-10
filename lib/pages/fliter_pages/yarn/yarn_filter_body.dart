import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/filter_widget/filter_grid_tile_widget.dart';
import 'package:yg_app/elements/filter_widget/filter_range_slider.dart';
import 'package:yg_app/elements/list_widgets/material_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
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


  YarnSetting? _yarnSetting;
  String? selectedFamilyId;
  bool? showTexturized;
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
  double min = 0.0;
  double maxDannier = 0.0;
  double maxFilament = 0.0;
  double maxCount = 0.0;
  double maxRatio = 0.0;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: SingleChildScrollView(
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
                      child: FamilyTileWidget(
                        listItems: widget.syncResponse!.data.yarn.family,
                        callback: (value) {
                          //Family Id
                          setState(() {
                            selectedFamilyId = widget
                                .syncResponse!.data.yarn.family![value].famId
                                .toString();
                          });
                          queryFamilySettings(
                              widget.syncResponse!.data.yarn.family![value].famId!);
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
                  visible: _yarnSetting != null
                      ? Ui.showHide(_yarnSetting!.showBlend)
                      : false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 16.w, bottom: 8.w),
                          child: TitleTextWidget(title: blend)),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        child: MaterialListviewWidget(
                          listItem: widget.syncResponse!.data.yarn.blends!
                              .where(
                                  (element) => element.familyIdfk == selectedFamilyId)
                              .toList(),
                          onClickCallback: (value) {},
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
                  visible: showTexturized ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: yarnTexturedType)),
                      FilterGridTileWidget(
                        spanCount: 3,
                        listOfItems: widget.syncResponse!.data.yarn.yarnTypes!,
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

                //Show Dannier
                Visibility(
                  visible: showDannier ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minDannier,
                        maxValue: maxDannier,
                        hintTxt: "Dannier",
                        minCallback: (value) {
                          minValueDannierParam = value;
                        },
                        maxCallback: (value) {
                          maxValueDannierParam = value;
                        },
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
                  visible: showFilament ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minFilament,
                        maxValue: maxFilament,
                        hintTxt: "Filament",
                        minCallback: (value) {
                          minValueFilamentParam = value;
                        },
                        maxCallback: (value) {
                          maxValueFilamentParam = value;
                        },
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
                  visible: showCount ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minCount,
                        maxValue: maxCount,
                        hintTxt: "Count",
                        minCallback: (value) {
                          minValueCountParam = value;
                        },
                        maxCallback: (value) {
                          maxValueCountParam = value;
                        },
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
                  visible: showRatio ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minDannier,
                        maxValue: maxDannier,
                        hintTxt: "Ratio",
                        minCallback: (value) {
                          minValueRatioParam = value;
                        },
                        maxCallback: (value) {
                          maxValueRatioParam = value;
                        },
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
                  visible: showUsage ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: usage)),
                      FilterGridTileWidget(
                        spanCount: 2,
                        listOfItems: widget.syncResponse!.data.yarn.usage!.where((element) => element.ysFamilyId == selectedFamilyId).toList(),
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
                //Show Appearance
                Visibility(
                  visible: showAppearance ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: yarnTexturedType)),
                      FilterGridTileWidget(
                        spanCount: 3,
                        listOfItems: widget.syncResponse!.data.yarn.apperance!.where((element) => element.familyId == selectedFamilyId).toList(),
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
                //Show color dying method
                Visibility(
                  visible: showColorDyingMethod ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: "Dying Method")),
                      FilterGridTileWidget(
                        spanCount: 3,
                        listOfItems: widget.syncResponse!.data.yarn.dyingMethod!.where((element) => element.apperanceId == selectedFamilyId).toList(),
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
                    visible: showColorCode ?? true,
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: TitleSmallTextWidget(
                                title: "Select Color"),
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
                                // onSaved: (input) => _createRequestModel
                                //     .ys_color_code = input!,
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

                //Show Ratio
                Visibility(
                  visible: showRatio ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minRatio,
                        maxValue: maxRatio,
                        hintTxt: "Ratio",
                        minCallback: (value) {
                          minValueRatioParam = value;
                        },
                        maxCallback: (value) {
                          maxValueRatioParam = value;
                        },
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
                  visible: showCount ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minCount,
                        maxValue: maxCount,
                        hintTxt: "Count",
                        minCallback: (value) {
                          minValueCountParam = value;
                        },
                        maxCallback: (value) {
                          maxValueCountParam = value;
                        },
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
                  visible: showPly ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: ply)),
                      FilterGridTileWidget(
                        spanCount: 4,
                        listOfItems: widget.syncResponse!.data.yarn.ply!.where((element) => element.familyId == selectedFamilyId).toList(),
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

                //Show Doubling Method
                Visibility(
                  visible: showDoublingMethod ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: "Doubling Method")),
                      FilterGridTileWidget(
                        spanCount: 3,
                        listOfItems: widget.syncResponse!.data.yarn.doublingMethod!.where((element) => element.plyId == selectedFamilyId).toList(),
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
                  visible: showTexturized ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: colorTreatmentMethod)),
                      FilterGridTileWidget(
                        spanCount: 3,
                        listOfItems: widget.syncResponse!.data.yarn.colorTreatmentMethod!.where((element) => element.familyId == selectedFamilyId).toList(),
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

                //Show Orientation
                Visibility(
                  visible: showOrientation ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: 'Orientation')),
                      FilterGridTileWidget(
                        spanCount: 2,
                        listOfItems: widget.syncResponse!.data.yarn.orientation!.where((element) => element.familyId == selectedFamilyId).toList(),
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

                //Show Twist Direction
                Visibility(
                  visible: showTwistDirection ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: twistDirection)),
                      FilterGridTileWidget(
                        spanCount: 2,
                        listOfItems: widget.syncResponse!.data.yarn.twistDirection!.where((element) => element.familyId == selectedFamilyId).toList(),
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

                //Show Spun Technique
                Visibility(
                  visible: showSpunTechnique ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: spunTech)),
                      FilterGridTileWidget(
                        spanCount: 4,
                        listOfItems: widget.syncResponse!.data.yarn.spunTechnique!.where((element) => element.familyId == selectedFamilyId).toList(),
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

                //Show Quality
                Visibility(
                  visible: showTexturized ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                          child: TitleSmallTextWidget(title: quality)),
                      FilterGridTileWidget(
                        spanCount: 2,
                        listOfItems: widget.syncResponse!.data.yarn.quality!.where((element) => element.familyId == selectedFamilyId).toList(),
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

                //Show Pattern
                Visibility(
                  visible: showRatio ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minDannier,
                        maxValue: maxDannier,
                        hintTxt: "Ratio",
                        minCallback: (value) {
                          minValueRatioParam = value;
                        },
                        maxCallback: (value) {
                          maxValueRatioParam = value;
                        },
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Visibility(
                  visible: showRatio ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minDannier,
                        maxValue: maxDannier,
                        hintTxt: "Ratio",
                        minCallback: (value) {
                          minValueRatioParam = value;
                        },
                        maxCallback: (value) {
                          maxValueRatioParam = value;
                        },
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Visibility(
                  visible: showRatio ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minDannier,
                        maxValue: maxDannier,
                        hintTxt: "Ratio",
                        minCallback: (value) {
                          minValueRatioParam = value;
                        },
                        maxCallback: (value) {
                          maxValueRatioParam = value;
                        },
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Visibility(
                  visible: showRatio ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minDannier,
                        maxValue: maxDannier,
                        hintTxt: "Ratio",
                        minCallback: (value) {
                          minValueRatioParam = value;
                        },
                        maxCallback: (value) {
                          maxValueRatioParam = value;
                        },
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Divider(),
                    ],
                  ),
                ),

              ],
            ),
          ),flex: 8,),
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

  queryFamilySettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {
      value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
        setState(() {
          if (value.isNotEmpty) {
            _yarnSetting = value[0];
          } else {
            Ui.showSnackBar(context, 'No Settings Found');
          }
        });
      });
    });
  }
}
