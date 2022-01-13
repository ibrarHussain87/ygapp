import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class YarnSpecificationComponent extends StatefulWidget {
  final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;
  final Function? callback;

  const YarnSpecificationComponent(
      {Key? key,
      this.callback,
      required this.yarnSyncResponse,
      required this.locality,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  YarnSpecificationComponentState createState() =>
      YarnSpecificationComponentState();
}

class YarnSpecificationComponentState extends State<YarnSpecificationComponent> {
  // ValueChanged<Color> callback
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

  var logger = Logger();

  //Keys
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textEditingController = TextEditingController();

  Yarn? _yarnData;

  //Provider Models
  YarnSetting? _yarnSetting;
  late CreateRequestModel _createRequestModel;

  //pattern charactristics List
  List<PatternCharectristic>? _patternCharactristicList;

  //Id's of selection
  String? selectedFamilyId;
  int? selectedBlendIndex;

  //Show Hide on dependency
  bool showDyingMethod = false;
  bool showDoublingMethod = false;
  bool showPatternCharc = true;

  Color pickerColor = const Color(0xffffffff);

  String? selectedPlyId;
  String? selectedPatternId;
  String? selectedAppearenceId;
  bool isInit = false;


  @override
  void initState() {
    _yarnData = widget.yarnSyncResponse.data.yarn;

    setState(() {
      selectedFamilyId = _yarnData!.family!.first.famId.toString();
    });

    _patternCharactristicList = widget
        .yarnSyncResponse.data.yarn.patternCharectristic!
        .where((element) =>
            element.ypcPatternIdfk == _yarnData!.pattern![0].ypId.toString())
        .toList();

    queryFamilySettings(int.parse(selectedFamilyId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!isInit) {
      _createRequestModel = Provider.of<CreateRequestModel>(context);
      _yarnSetting ??= Provider.of<YarnSetting>(context);
      _yarnSetting ??= Provider.of<YarnSetting>(context);
      logger.e(_createRequestModel.toJson());
      _initGridValues();
      isInit = true;
    }
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
                            title: specifications,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.w),
                            child: Text(
                              selectSpecifications,
                              style: TextStyle(
                                  fontSize: 11.sp, color: Colors.grey.shade600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: globalFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          //Show Texturized
                          Visibility(
                            visible: Ui.showHide(_yarnSetting!.showTexturized),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: yarnTexturedType)),
                                  GridTileWidget(
                                    spanCount: 3,
                                    listOfItems: _yarnData!.yarnTypes!,
                                    callback: (value) {
                                      _createRequestModel.ys_yarn_type_idfk =
                                          _yarnData!.yarnTypes![value].ytId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Dannier and Show Filament
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(_yarnSetting!.showDannier),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 4.w),
                                          child: TitleSmallTextWidget(
                                              title: dannier)),
                                      YgTextFormFieldWithRange(
                                          onSaved: (input) =>
                                              _createRequestModel
                                                  .ys_dty_filament = input!,
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: _yarnSetting!.dannierMinMax!,
                                          errorText: dannier),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: (Ui.showHide(
                                            _yarnSetting!.showDannier) &&
                                        Ui.showHide(_yarnSetting!.showFilament))
                                    ? 16.w
                                    : 0,
                              ),
                              Visibility(
                                visible:
                                    Ui.showHide(_yarnSetting!.showFilament),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 4.w),
                                          child: TitleSmallTextWidget(
                                              title: filament)),
                                      YgTextFormFieldWithRange(
                                        minMax: _yarnSetting!.filamentMinMax!,
                                        onSaved: (input) => _createRequestModel
                                            .ys_fdy_filament = input!,
                                        // onChanged:(value) => globalFormKey.currentState!.reset(),
                                        errorText: filament,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Show Usage
                          Visibility(
                            visible: Ui.showHide(_yarnSetting!.showUsage),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child:
                                          TitleSmallTextWidget(title: usage)),
                                  GridTileWidget(
                                    spanCount: 2,
                                    listOfItems: _yarnData!.usage!
                                        .where((element) =>
                                            element.ysFamilyId.toString() ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel.ys_usage_idfk =
                                          _yarnData!.usage![value].yuId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Appearance
                          Visibility(
                            visible: Ui.showHide(_yarnSetting!.showAppearance),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: apperance)),
                                  GridTileWidget(
                                    spanCount: 3,
                                    listOfItems: _yarnData!.apperance!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel.ys_apperance_idfk =
                                          _yarnData!.apperance![value].yaId
                                              .toString();

                                      if (_yarnData!.apperance![value].yaId ==
                                          3) {
                                        setState(() {
                                          showDyingMethod = true;
                                          selectedAppearenceId = _yarnData!
                                              .apperance![value].yaId
                                              .toString();
                                        });
                                      } else {
                                        setState(() {
                                          showDyingMethod = false;
                                          _createRequestModel.ys_dying_method_idfk = null;
                                          _createRequestModel.ys_color_code = null;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Color dying Method
                          Visibility(
                            visible: showDyingMethod
                                ? Ui.showHide(_yarnSetting!.showDyingMethod)
                                : false,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: const TitleSmallTextWidget(
                                          title: "Dying Method")),
                                  GridTileWidget(
                                    spanCount: 3,
                                    listOfItems: _yarnData!.dyingMethod!
                                        .where((element) {
                                      if (element.ydmColorTreatmentMethodIdfk !=
                                          "0") {
                                        return element
                                                .ydmColorTreatmentMethodIdfk ==
                                            _createRequestModel
                                                .ys_color_treatment_method_idfk
                                                .toString();
                                      } else {
                                        return element.apperanceId ==
                                            selectedAppearenceId.toString();
                                      }
                                    }).toList(),
                                    callback: (value) {
                                      _createRequestModel.spc_grade_idfk =
                                          widget
                                              .yarnSyncResponse
                                              .data
                                              .yarn
                                              .colorTreatmentMethod![value]
                                              .yctmId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Here Color Code is missing
                          Visibility(
                              visible: showDyingMethod
                                  ? Ui.showHide(_yarnSetting!.showColor)
                                  : false,
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
                                          onSaved: (input) => _createRequestModel
                                              .ys_color_code = input!,
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

                          //Show Ratio and Count
                          Row(
                            children: [
                              Visibility(
                                visible: Ui.showHide(_yarnSetting!.showRatio),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.w, top: 8.w),
                                          child: TitleSmallTextWidget(
                                              title: ratio)),
                                      YgTextFormFieldWithoutRange(
                                          errorText: ratio,
                                          onSaved: (input) {
                                            _createRequestModel.ys_ratio =
                                                input;
                                          })
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: (Ui.showHide(_yarnSetting!.showRatio) &&
                                        Ui.showHide(_yarnSetting!.showCount))
                                    ? 16.w
                                    : 0,
                              ),
                              Visibility(
                                visible: Ui.showHide(_yarnSetting!.showCount),
                                child: Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 4.w, top: 8.w),
                                          child: TitleSmallTextWidget(
                                              title: count)),
                                      YgTextFormFieldWithRange(
                                          errorText: count,
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: _yarnSetting!.countMinMax!,
                                          onSaved: (input) {
                                            _createRequestModel
                                                .ys_actual_yarn_count = input;

                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Show Ply
                          Visibility(
                            visible: Ui.showHide(_yarnSetting!.showPly),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(title: ply)),
                                  GridTileWidget(
                                    spanCount: 4,
                                    listOfItems: _yarnData!.ply!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel.ys_ply_idfk = widget
                                          .yarnSyncResponse
                                          .data
                                          .yarn
                                          .ply![value]
                                          .plyId
                                          .toString();

                                      if (_yarnData!.ply![value].plyId != 1) {
                                        setState(() {
                                          showDoublingMethod = true;
                                          selectedPlyId = widget
                                              .yarnSyncResponse
                                              .data
                                              .yarn
                                              .ply![value]
                                              .plyId
                                              .toString();
                                        });
                                      } else {
                                        setState(() {
                                          showDoublingMethod = false;
                                          _createRequestModel.ys_doubling_method_idFk = "";
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Here Doubling Method is Missing
                          Visibility(
                            visible: showDoublingMethod
                                ? Ui.showHide(_yarnSetting!.showDoublingMethod)
                                : false,
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: colorTreatmentMethod)),
                                  GridTileWidget(
                                    spanCount: 3,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.doublingMethod!
                                        .where((element) =>
                                            element.plyId == selectedPlyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel
                                              .ys_doubling_method_idFk =
                                          _yarnData!.doublingMethod![value].dmId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Color Treatment Method
                          Visibility(
                            visible: Ui.showHide(
                                _yarnSetting!.showColorTreatmentMethod),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: colorTreatmentMethod)),
                                  GridTileWidget(
                                    spanCount: 3,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.colorTreatmentMethod!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel.spc_grade_idfk =
                                          widget
                                              .yarnSyncResponse
                                              .data
                                              .yarn
                                              .colorTreatmentMethod![value]
                                              .yctmId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Orientation
                          Visibility(
                            visible: Ui.showHide(_yarnSetting!.showOrientation),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: orientation)),
                                  GridTileWidget(
                                    spanCount: 2,
                                    listOfItems: _yarnData!.orientation!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel.ys_orientation_idfk =
                                          _yarnData!.orientation![value].yoId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Twist Direction
                          Visibility(
                            visible:
                                Ui.showHide(_yarnSetting!.showTwistDirection),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: twistDirection)),
                                  GridTileWidget(
                                    spanCount: 2,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.twistDirection!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel
                                              .ys_twist_direction_idfk =
                                          _yarnData!
                                              .twistDirection![value].ytdId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Spun Technique
                          Visibility(
                            visible:
                                Ui.showHide(_yarnSetting!.showSpunTechnique),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: spunTech)),
                                  GridTileWidget(
                                    spanCount: 4,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.spunTechnique!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel
                                              .ys_spun_technique_idfk =
                                          _yarnData!.spunTechnique![value].ystId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Quality
                          Visibility(
                            visible: Ui.showHide(_yarnSetting!.showQuality),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child:
                                          TitleSmallTextWidget(title: quality)),
                                  GridTileWidget(
                                    spanCount: 2,
                                    listOfItems: _yarnData!.quality!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel.ys_qlt = widget
                                          .yarnSyncResponse
                                          .data
                                          .yarn
                                          .quality![value]
                                          .yqId
                                          .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Pattern
                          Visibility(
                            visible: Ui.showHide(_yarnSetting!.showPattern),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child:
                                          TitleSmallTextWidget(title: pattern)),
                                  GridTileWidget(
                                    spanCount: 3,
                                    listOfItems: _yarnData!.pattern!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      if (_yarnData!
                                                  .pattern![value].ypId ==
                                              1 ||
                                          _yarnData!
                                                  .pattern![value].ypId ==
                                              2 ||
                                          _yarnData!.pattern![value].ypId ==
                                              3 ||
                                          _yarnData!.pattern![value].ypId ==
                                              4) {
                                        setState(() {
                                          showPatternCharc = true;
                                          selectedPatternId = _yarnData!
                                              .pattern![value].ypId
                                              .toString();

                                          _patternCharactristicList = widget
                                              .yarnSyncResponse
                                              .data
                                              .yarn
                                              .patternCharectristic!
                                              .where((element) =>
                                                  element.ypcPatternIdfk ==
                                                  widget.yarnSyncResponse.data
                                                      .yarn.pattern![value].ypId
                                                      .toString())
                                              .toList();
                                        });
                                      } else {
                                        setState(() {
                                          showPatternCharc = false;
                                          _createRequestModel
                                                  .ys_pattern_charectristic_idfk =
                                              null;
                                        });
                                      }
                                      _createRequestModel.ys_pattern_idfk =
                                          _yarnData!.pattern![value].ypId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Pattern characteristics
                          Visibility(
                            visible: showPatternCharc,
                            child: selectedPatternId ==
                                    PATTERN_CHARACTERISTCS_SLUB_ID.toString()
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4.w, top: 8.w),
                                                child:
                                                    const TitleSmallTextWidget(
                                                        title: "Thickness")),
                                            YgTextFormFieldWithoutRange(
                                              onSaved: (input) =>
                                                  _createRequestModel
                                                          .ys_pattern_charectristic_thickness =
                                                      input!,
                                              errorText: "Thickness",
                                            ),
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4.w, top: 8.w),
                                                child:
                                                    const TitleSmallTextWidget(
                                                        title: "Length")),
                                            YgTextFormFieldWithoutRange(
                                              onSaved: (input) =>
                                                  _createRequestModel
                                                          .ys_length_pattern_charactristics =
                                                      input!,
                                              errorText: "Length",
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4.w, top: 8.w),
                                                child:
                                                    const TitleSmallTextWidget(
                                                        title: "Pause")),
                                            YgTextFormFieldWithoutRange(
                                              errorText: "Pause",
                                              onSaved: (input) =>
                                                  _createRequestModel
                                                          .ys_pause_patteren_charactristics =
                                                      input!,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(
                                                title: patternChar)),
                                        GridTileWidget(
                                          spanCount: 4,
                                          listOfItems:
                                              _patternCharactristicList ?? [],
                                          callback: (value) {
                                            _createRequestModel
                                                    .ys_pattern_charectristic_idfk =
                                                widget
                                                    .yarnSyncResponse
                                                    .data
                                                    .yarn
                                                    .patternCharectristic![
                                                        value]
                                                    .ypcId
                                                    .toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ),

                          //Show Grade
                          Visibility(
                            visible: Ui.showHide(_yarnSetting!.showGrade),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child:
                                          TitleSmallTextWidget(title: grades)),
                                  GridTileWidget(
                                    spanCount: 3,
                                    listOfItems: _yarnData!.grades!
                                        .where((element) =>
                                            element.familyId ==
                                            selectedFamilyId)
                                        .toList(),
                                    callback: (value) {
                                      _createRequestModel.spc_grade_idfk =
                                          _yarnData!.grades![value].grdId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //Show Certification
                          Visibility(
                            visible:
                                Ui.showHide(_yarnSetting!.showCertification),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: certification)),
                                  GridTileWidget(
                                    spanCount: 4,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.certification!,
                                    callback: (value) {
                                      _createRequestModel.spc_grade_idfk =
                                          _yarnData!.certification![value].cerId
                                              .toString();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 8.w,
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
                  callback: () async {
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

  queryBlendSettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {
      value.yarnSettingsDao
          .findFamilyAndBlendYarnSettings(
              _yarnData!.blends![id].blnId!, int.parse(selectedFamilyId!))
          .then((value) {
        setState(() {
          selectedBlendIndex = id;
          //Selected Blend Id
          _createRequestModel.ys_blend_idfk = selectedBlendIndex != null
              ? widget
                  .yarnSyncResponse.data.yarn.blends![selectedBlendIndex!].blnId
                  .toString()
              : "";
          if (value.isNotEmpty) {
            _yarnSetting = value[0];
          } else {
            Ui.showSnackBar(context, 'No Settings Found');
          }
        });
      });
    });
  }

  queryFamilySettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {
      value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
        setState(() {
          selectedFamilyId = id.toString();
          if (value.isNotEmpty) {
            _yarnSetting = value[0];
          } else {
            Ui.showSnackBar(context, 'No Settings Found');
          }
        });
      });
    });
  }

  _initGridValues() async {
    var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
    _createRequestModel.ys_user_idfk = userID.toString();

    //Category Id
    _createRequestModel.spc_category_idfk = YARN_CATEGORY_ID.toString();

    //Grade ID
    if (Ui.showHide(_yarnSetting!.showGrade) && _yarnData!.grades!.isNotEmpty) {
      _createRequestModel.ys_grade_idfk =
          _yarnData!.grades!.first.grdId.toString();
    }

    //PLY ID
    if (Ui.showHide(_yarnSetting!.showPly) && _yarnData!.ply!.isNotEmpty) {
      _createRequestModel.ys_ply_idfk = _yarnData!.ply!.first.plyId.toString();
    }

    //ORIENTATION ID
    if (Ui.showHide(_yarnSetting!.showOrientation) &&
        _yarnData!.orientation!.isNotEmpty) {
      _createRequestModel.ys_orientation_idfk =
          _yarnData!.orientation!.first.yoId.toString();
    }

    //USAGE ID
    if (Ui.showHide(_yarnSetting!.showUsage) && _yarnData!.usage!.isNotEmpty) {
      _createRequestModel.ys_usage_idfk =
          _yarnData!.usage!.first.yuId.toString();
    }

    //PATTERN ID
    if (Ui.showHide(_yarnSetting!.showPattern) &&
        _yarnData!.pattern!.isNotEmpty) {
      _createRequestModel.ys_pattern_idfk =
          _yarnData!.pattern!.first.ypId.toString();
    }

    //PATTERN CHAR ID
    if (showPatternCharc) {
      if (_yarnData!.patternCharectristic!.isNotEmpty) {
        _createRequestModel.ys_pattern_charectristic_idfk = widget
            .yarnSyncResponse.data.yarn.patternCharectristic!.first.ypcId
            .toString();
      }
    }

    //TWIST DIRECTION ID
    if (Ui.showHide(_yarnSetting!.showTwistDirection) &&
        _yarnData!.twistDirection!.isNotEmpty) {
      _createRequestModel.ys_twist_direction_idfk = widget
          .yarnSyncResponse.data.yarn.twistDirection!.first.ytdId
          .toString();
    }

    //SPUN TECH ID
    if (Ui.showHide(_yarnSetting!.showSpunTechnique) &&
        _yarnData!.spunTechnique!.isNotEmpty) {
      _createRequestModel.ys_spun_technique_idfk = widget
          .yarnSyncResponse.data.yarn.spunTechnique!.first.ystId
          .toString();
    }

    //COLOR TREATMENT METHOD ID
    if (Ui.showHide(_yarnSetting!.showColorTreatmentMethod) &&
        _yarnData!.colorTreatmentMethod!.isNotEmpty) {
      _createRequestModel.ys_color_treatment_method_idfk = widget
          .yarnSyncResponse.data.yarn.colorTreatmentMethod!.first.yctmId
          .toString();
    }

    //DYING METHOD ID
    if (Ui.showHide(_yarnSetting!.showDyingMethod) &&
        showDyingMethod &&
        _yarnData!.dyingMethod!.isNotEmpty) {
      _createRequestModel.ys_dying_method_idfk =
          _yarnData!.dyingMethod!.first.ydmId.toString();
    }

    //APPEARANCE ID
    if (Ui.showHide(_yarnSetting!.showAppearance) &&
        _yarnData!.apperance!.isNotEmpty) {
      _createRequestModel.ys_apperance_idfk =
          _yarnData!.apperance!.first.yaId.toString();
    }

    //Doubling method id
    if (showDoublingMethod &&
        Ui.showHide(_yarnSetting!.showDoublingMethod) &&
        _yarnData!.doublingMethod!.isNotEmpty) {
      _createRequestModel.ys_doubling_method_idFk = widget
          .yarnSyncResponse.data.yarn.doublingMethod!
          .where((element) => element.plyId == _createRequestModel.ys_ply_idfk)
          .toList()
          .first
          .dmId
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
