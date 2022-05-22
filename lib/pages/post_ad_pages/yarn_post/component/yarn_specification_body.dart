import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/bottom_sheets/yarn_specs_bottom_sheet.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';
import 'package:yg_app/providers/yarn_providers/yarn_specifications_provider.dart';

import '../../../../api_services/api_service_class.dart';
import '../../../../elements/decoration_widgets.dart';
import '../../../../helper_utils/dialog_builder.dart';
import '../../../../helper_utils/navigation_utils.dart';
import '../../../../helper_utils/progress_dialog_util.dart';
import '../../../../helper_utils/util.dart';
import 'lab_parameter_body.dart';
import 'lab_parameter_body.dart';

class YarnSpecificationComponent extends StatefulWidget {
  // final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;
  final Function? callback;

  const YarnSpecificationComponent(
      {Key? key,
      this.callback,
      // required this.yarnSyncResponse,
      required this.locality,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  YarnSpecificationComponentState createState() =>
      YarnSpecificationComponentState();
}

class YarnSpecificationComponentState extends State<YarnSpecificationComponent>
    with AutomaticKeepAliveClientMixin {
  List<PickedFile> imageFiles = [];
  final GlobalKey<LabParameterPageState> _labParameterPage =
      GlobalKey<LabParameterPageState>();

  final _yarnPostProvider = locator<PostYarnProvider>();
  final  _yarnSpecificationProvider = locator<YarnSpecificationsProvider>();
  final ValueNotifier<bool> _notifierPlySheet = ValueNotifier(false);


  // ValueChanged<Color> callback
  _changeColor(Color color) {
    setState(() {
      pickerColor = color;
      _textEditingController.text = '#${pickerColor.value.toRadixString(16)}';
    });
  }

  _openDialogBox() {
    // raise the [showDialog] widget
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: _changeColor,
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

  Widget _showPatternCharWidget() {
    if (_patternTLPIdList.contains(int.parse(_selectedPatternId ?? "-1"))) {
      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 15.w,
                ),
//                Padding(
//                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                    child: const TitleSmallTextWidget(title: "Thickness")),
                YgTextFormFieldWithoutRange(
                  onSaved: (input) => _createRequestModel
                      .ys_pattern_charectristic_thickness = input!,
                  errorText: "Thickness",
                  label: 'Thickness',
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // modified by (asad_m)
                SizedBox(
                  height: 15.w,
                ),
//                Padding(
//                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                    child: const TitleSmallTextWidget(title: "Length")),
                YgTextFormFieldWithoutRange(
                  onSaved: (input) => _createRequestModel
                      .ys_length_pattern_charactristics = input!,
                  errorText: "Length",
                  label: 'Length',
                ),
              ],
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
//                Padding(
//                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                    child: const TitleSmallTextWidget(title: "Pause")),
                SizedBox(
                  height: 15.w,
                ),
                YgTextFormFieldWithoutRange(
                  errorText: "Pause",
                  label: 'Pause',
                  onSaved: (input) => _createRequestModel
                      .ys_pause_patteren_charactristics = input!,
                ),
              ],
            ),
          ),
        ],
      );
    } else if (_patternGRIdList
        .contains(int.parse(_selectedPatternId ?? "-1"))) {
      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 8.w,
                ),
//                Padding(
//                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                    child: const TitleSmallTextWidget(title: "Grain")),
                YgTextFormFieldWithoutRange(
                  onSaved: (input) => _createRequestModel
                      .ys_grain_patteren_charactristics = input!,
                  errorText: "Grain",
                  label: 'Grain',
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.w,
                ),
//                Padding(
//                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                    child: const TitleSmallTextWidget(title: "Rice")),
                YgTextFormFieldWithoutRange(
                  onSaved: (input) => _createRequestModel
                      .ys_rice_patteren_charactristics = input!,
                  errorText: "Rice",
                  label: 'Rice',
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                child: TitleSmallBoldTextWidget(title: patternChar)),
            SingleSelectTileWidget(
              selectedIndex: -1,
              key: _patternCharKey,
              spanCount: 3,
              listOfItems: _patternCharactristicList ?? [],
              callback: (PatternCharectristic value) {
                _createRequestModel.ys_pattern_charectristic_idfk =
                    value.ypcId.toString();
              },
            ),
          ],
        ),
      );
    }
  }

  List<DyingMethod> _getDyingMethodList() {
    if (_showDyingMethod &&
        Ui.showHide(_yarnSetting!.showColorTreatmentMethod)) {
      return _dyingMethodList!
          .where((element) =>
              element.ydmColorTreatmentMethodIdfk ==
              _selectedColorTreatMethodId)
          .toList();
    } else {
      return _dyingMethodList!
          .where((element) => element.apperanceId == _selectedAppearenceId)
          .toList();
    }
  }

  queryBlendSettings(int id) {
    AppDbInstance().getDbInstance().then((value) async {
      value.yarnSettingsDao
          .findFamilyAndBlendYarnSettings(
              _yarnPostProvider.blendList[id].blnId!, _yarnPostProvider.selectedYarnFamily.famId!)
          .then((value) {
        setState(() {
          _selectedBlendIndex = id;
          //Selected Blend Id
          if (value.isNotEmpty) {
            _resetData();
            _yarnSetting = value[0];
            // _initGridValues();
            // _createRequestModel.ys_family_idfk ??= _selectedFamilyId;
            // _createRequestModel.ys_blend_idfk = _selectedBlendIndex != null
            //     ? _blendsList![_selectedBlendIndex!].blnId.toString()
            //     : "";
          }
          _createRequestModel.ys_family_idfk ??= _yarnPostProvider.selectedYarnFamily.famId!.toString();
          // _createRequestModel.ys_blend_idfk = _blendsList![id].blnId.toString();

          /*else {
            Ui.showSnackBar(context, 'No Settings Found');
          }*/
        });
      });
    });
  }

  queryFamilySettings(int id) {
    AppDbInstance().getDbInstance().then((value) async {
      value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
        setState(() {
          // _selectedFamilyId = id.toString();
          if (value.isNotEmpty) {
            _resetData();
            _yarnSetting = value[0];
            // _initGridValues();
          }
          _isGetSyncedData = true;
          _createRequestModel.ys_family_idfk = _yarnPostProvider.selectedYarnFamily.famId!.toString();
        });
      });
    });
  }

  //RESET ALL DATA
  _resetData() {
    if (_yarnTypeKey.currentState != null) {
      _yarnTypeKey.currentState!.checkedTile = -1;
    }
    if (_usageKey.currentState != null) {
      _usageKey.currentState!.checkedTile = -1;
    }
    if (_appearanceKey.currentState != null) {
      _appearanceKey.currentState!.checkedTile = -1;
    }
    if (_plyKey.currentState != null) _plyKey.currentState!.checkedTile = -1;
    if (_patternKey.currentState != null) {
      _patternKey.currentState!.checkedTile = -1;
    }
    if (_patternCharKey.currentState != null) {
      _patternCharKey.currentState!.checkedTile = -1;
    }
    if (_orientationKey.currentState != null) {
      _orientationKey.currentState!.checkedTile = -1;
    }
    if (_spunTechKey.currentState != null) {
      _spunTechKey.currentState!.checkedTile = -1;
    }
    if (_qualityKey.currentState != null) {
      _qualityKey.currentState!.checkedTile = -1;
    }
    if (_certificateKey.currentState != null) {
      _certificateKey.currentState!.checkedTile = -1;
    }
    if (_gradeKey.currentState != null) {
      _gradeKey.currentState!.checkedTile = -1;
    }
    if (_twistDirectionKey.currentState != null) {
      _twistDirectionKey.currentState!.checkedTile = -1;
    }
    if (_doublingMethodKey.currentState != null) {
      _doublingMethodKey.currentState!.checkedTile = -1;
    }
    if (_dyingMethodKey.currentState != null) {
      _dyingMethodKey.currentState!.checkedTile = -1;
    }
    if (_colorTreatmentMethodKey.currentState != null) {
      _colorTreatmentMethodKey.currentState!.checkedTile = -1;
    }

    setState(() {
      _showDyingMethod = false;
      _showDoublingMethod = false;
      _showPatternChar = false;
      _selectedSpunTechId = null;
      _selectedPatternId = null;
      _selectedColorTreatMethodId = null;
      _selectedAppearenceId = null;
      _selectedPlyId = null;

      _createRequestModel.ys_family_idfk = null;
      _createRequestModel.ys_usage_idfk = null;
      _createRequestModel.ys_blend_idfk = null;
      _createRequestModel.ys_ratio = null;
      _createRequestModel.ys_twist_direction_idfk = null;
      _createRequestModel.ys_grade_idfk = null;
      _createRequestModel.ys_fdy_filament = null;
      _createRequestModel.ys_dty_filament = null;
      _createRequestModel.ys_apperance_idfk = null;
      _createRequestModel.ys_color_treatment_method_idfk = null;
      _createRequestModel.ys_dying_method_idfk = null;
      _createRequestModel.ys_color_code = null;
      _createRequestModel.ys_count = null;
      _createRequestModel.ys_ply_idfk = null;
      _createRequestModel.ys_doubling_method_idFk = null;
      _createRequestModel.ys_orientation_idfk = null;
      _createRequestModel.ys_quality_idfk = null;
      _createRequestModel.ys_pattern_idfk = null;
      _createRequestModel.ys_pattern_charectristic_idfk = null;
      _createRequestModel.ys_certification_idfk = null;
      _createRequestModel.ys_yarn_type_idfk = null;
    });
  }

  bool validateAndSave() {
    final form = _globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool validationAllPage() {
    if (validateAndSave()) {
      /*if (!_yarnPostProvider.isBlendSelected &&
          Ui.showHide(_yarnSetting!.showBlend)) {
        Ui.showSnackBar(context, 'Please Select Blend');
        return false;
      } else*/ if (_createRequestModel.ys_yarn_type_idfk == null &&
          Ui.showHide(_yarnSetting!.showTexturized)) {
        Ui.showSnackBar(context, 'Please Select Textured Yarn Type');
        return false;
      } else if (_createRequestModel.ys_usage_idfk == null &&
          Ui.showHide(_yarnSetting!.showUsage)) {
        Ui.showSnackBar(context, 'Please Select Usage');
        return false;
      } else if (_createRequestModel.ys_color_treatment_method_idfk == null &&
          Ui.showHide(_yarnSetting!.showColorTreatmentMethod)) {
        Ui.showSnackBar(context, 'Please Select Color Treatment Method');
        return false;
      } else if (_createRequestModel.ys_dying_method_idfk == null &&
          _showDyingMethod) {
        Ui.showSnackBar(context, 'Please Select Dying Method');
        return false;
      } else if (_createRequestModel.ys_ply_idfk == null &&
          Ui.showHide(_yarnSetting!.showPly)) {
        Ui.showSnackBar(context, 'Please Select Ply');
        return false;
      } else if (_createRequestModel.ys_doubling_method_idFk == null &&
          _showDoublingMethod &&
          Ui.showHide(_yarnSetting!.showDoublingMethod)) {
        Ui.showSnackBar(context, 'Please Select Doubling Method');
        return false;
      } else if (_createRequestModel.ys_orientation_idfk == null &&
          Ui.showHide(_yarnSetting!.showOrientation)) {
        Ui.showSnackBar(context, 'Please Select Orientation');
        return false;
      }else if (_createRequestModel.ys_count == null &&
          Ui.showHide(_yarnSetting!.showCount)) {
        Ui.showSnackBar(context, 'Please Select Count');
        return false;
      }else if (_createRequestModel.ys_dty_filament == null &&
          Ui.showHide(_yarnSetting!.showDannier)) {
        Ui.showSnackBar(context, 'Please Select Dannier');
        return false;
      }else if (_createRequestModel.ys_fdy_filament == null &&
          Ui.showHide(_yarnSetting!.showFilament)) {
        Ui.showSnackBar(context, 'Please Select Filament');
        return false;
      } else if (_createRequestModel.ys_spun_technique_idfk == null &&
          Ui.showHide(_yarnSetting!.showSpunTechnique)) {
        Ui.showSnackBar(context, 'Please Select Spun Technique');
        return false;
      } else if (_createRequestModel.ys_quality_idfk == null &&
          Ui.showHide(_yarnSetting!.showQuality)) {
        Ui.showSnackBar(context, 'Please Select Quality');
        return false;
      } else if (_createRequestModel.ys_pattern_idfk == null &&
          Ui.showHide(_yarnSetting!.showPattern)) {
        Ui.showSnackBar(context, 'Please Select Pattern');
        return false;
      } else if (_createRequestModel.ys_pattern_charectristic_idfk == null &&
          _showPatternChar &&
          !_patternTLPIdList.contains(int.parse(_selectedPatternId ?? "-1")) &&
          !_patternGRIdList.contains(int.parse(_selectedPatternId ?? "-1"))) {
        Ui.showSnackBar(context, 'Please Select Pattern Characteristics');
        return false;
      } else if (_createRequestModel.ys_grade_idfk == null &&
          Ui.showHide(_yarnSetting!.showGrade)) {
        Ui.showSnackBar(context, 'Please Select Grade');
        return false;
      } else if (_createRequestModel.ys_apperance_idfk == null &&
          Ui.showHide(_yarnSetting!.showAppearance)) {
        Ui.showSnackBar(context, 'Please Select Appearance');
        return false;
      } else if (_createRequestModel.ys_certification_idfk == null &&
          Ui.showHide(_yarnSetting!.showCertification)) {
        Ui.showSnackBar(context, 'Please Select Certification');
        return false;
      }/*else if (_createRequestModel.ys_formation == null ||
          _createRequestModel.ys_formation!.isEmpty) {
        Ui.showSnackBar(context, 'Please Select Formations');
        return false;
      }*/ else {
        _createRequestModel.spc_category_idfk = "2";
        return true;
      }
    }
    return false;
  }

  _getPattern() {
    if (_selectedSpunTechId != null) {
      if (_selectedSpunTechId == "1") {
        return _patternList!
            .where((element) => element.spun_technique_id == "1")
            .toList();
      }
      return _patternList;
    }

    return _patternList;
  }

  _getQuality() {
    if (_selectedSpunTechId != null) {
      if (_selectedSpunTechId == "1") {
        return _qualityList!
            .where((element) => element.spun_technique_id == "1")
            .toList();
      }
      return _qualityList;
    }

    return _qualityList;
  }

  _getSyncedData() async {
    // await AppDbInstance().getYarnFamilyData()
    //     .then((value) => setState(() => _familyList = value));
    // await AppDbInstance().getYarnBlendData()
    //     .then((value) => setState(() => _blendsList = value));
    await AppDbInstance().getYarnAppearance()
        .then((value) => _appearanceList = value);
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
    await AppDbInstance().getTwistDirections()
        .then((value) => _twistDirectionList = value);
    await AppDbInstance().getPatternCharacteristics()
        .then((value) => _patternCharList = value);
    await AppDbInstance().getCertificationsData()
        .then((value) => _certificationList = value);
    await AppDbInstance().getYarnGradesDao().then((value) => _gradesList = value);
    await AppDbInstance().getYarnSettings().then((value) {
      // _yarnSettingsList = value;
      // _selectedFamilyId = _familyList!.first.famId.toString();
    });
  }

  // List<Family>? _familyList;
  // List<Blends>? _blendsList;
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
  // List<YarnSetting>? _yarnSettingsList;

  //Keys
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<SingleSelectTileWidgetState> _usageKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _yarnTypeKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _colorTreatmentMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _dyingMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _certificateKey =
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
  final GlobalKey<SingleSelectTileWidgetState> _patternCharKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _spunTechKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _twistDirectionKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _gradeKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _appearanceKey =
      GlobalKey<SingleSelectTileWidgetState>();

  final List<int> _colorTreatmentIdList = [3, 5, 8, 11, 13];
  final List<int> _plyIdList = [1, 5, 9, 13];
  final List<int> _patternIdList = [1, 2, 3, 4, 9, 10, 12];
  final List<int> _patternTLPIdList = [2, 9, 12];
  final List<int> _patternGRIdList = [10];

  //Show Hide on dependency
  bool _showDyingMethod = false;
  bool _showDoublingMethod = false;
  bool _showPatternChar = false;

  Color pickerColor = const Color(0xffffffff);
  bool _isInit = false;

  // Yarn? _yarnData;
  final TextEditingController _textEditingController = TextEditingController();
  var logger = Logger();

  //Provider Models
  YarnSetting? _yarnSetting;
  late CreateRequestModel _createRequestModel;

//pattern charactristics List
  List<PatternCharectristic>? _patternCharactristicList;

//Id's of selection
//   String? _selectedFamilyId;
  int? _selectedBlendIndex;

  String? _selectedPlyId;
  String? _selectedPatternId;
  String? _selectedAppearenceId;
  String? _selectedColorTreatMethodId;
  String? _selectedSpunTechId;

  bool _isGetSyncedData = false;

  @override
  void initState() {
    // Utils.disableClick = false;
    // _yarnData = widget.yarnSyncResponse.data.yarn;
    _getSyncedData();
    _yarnPostProvider.familyDisabled = false;
    queryFamilySettings(_yarnPostProvider.selectedYarnFamily.famId!);
    super.initState();
    _yarnPostProvider.addListener(() {setState(() {});});
  }

  @override
  void dispose() {
    _notifierPlySheet.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit) {
      _createRequestModel = Provider.of<CreateRequestModel>(context);
      _yarnSetting ??= Provider.of<YarnSetting>(context);
      // _initGridValues();
      _isInit = true;
    }
    return _isGetSyncedData
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            body: _isGetSyncedData
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 0.w, left: 16.w, right: 16.w),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 0.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TitleTextWidget(
                                        title: specifications,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 2.w),
                                        child: Text(
                                          selectSpecifications,
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.grey.shade600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Form(
                                  key: _globalFormKey,
                                  child: setSpecificationParameters(
                                      _yarnPostProvider.selectedYarnFamily.famId!.toString()),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.selectedTab == requirement_type || _yarnPostProvider.selectedYarnFamily.famId!.toString() == 4.toString(),
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButtonWithIcon(
                              callback: () async {
                                if (widget.selectedTab == offering_type) {
                                if (validationAllPage()) {
                                  _createRequestModel.spc_category_idfk = "2";
                                  widget.callback!(1);
                                }
                                } else {
                                  if (validationAllPage()) {
                                    showGenericDialog(
                                      '',
                                      "Are you sure, you want to submit?",
                                      context,
                                      StylishDialogType.WARNING,
                                      'Yes',
                                      () {
                                        submitData(context);
                                      },
                                    );
                                  }
                                }
                              },
                              color: btnColorLogin,
                              btnText: widget.selectedTab == offering_type
                                  ? "Next"
                                  : submit,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
          )
        : Container();
  }

  void submitData(BuildContext context) {
    if (widget.businessArea == yarn) {
      _createRequestModel.ys_local_international =
          widget.locality!.toUpperCase();
    } else {
      _createRequestModel.spc_local_international =
          widget.locality!.toUpperCase();
    }

    ProgressDialogUtil.showDialog(context, 'Please wait...');

    ApiService.createSpecification(_createRequestModel,
            imageFiles.isNotEmpty ? imageFiles[0].path : "")
        .then((value) {
      ProgressDialogUtil.hideDialog();
      if (value.status) {
        Fluttertoast.showToast(msg: value.message);
        if (value.responseCode == 205) {
          showGenericDialog(
            '',
            value.message.toString(),
            context,
            StylishDialogType.WARNING,
            'Update',
            () {
              openMyAdsScreen(context);
            },
          );
        } else {
          _yarnSpecificationProvider.getUpdatedYarnSpecificationsData();
          Navigator.pop(context);
        }
      } else {
        //Ui.showSnackBar(context, value.message);
        showGenericDialog(
          '',
          value.message.toString(),
          context,
          StylishDialogType.ERROR,
          'Yes',
          () {},
        );
      }
    }).onError((error, stackTrace) {
      ProgressDialogUtil.hideDialog();
      //Ui.showSnackBar(context, error.toString());
      showGenericDialog(
        '',
        error.toString(),
        context,
        StylishDialogType.ERROR,
        'Yes',
        () {},
      );
    });
  }

  Widget setSpecificationParameters(String selectedFamilyId) {
    Widget widget1 = const Text('Error');
    switch (selectedFamilyId) {
      case '4':
        widget1 = Column(
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(
                            title: yarnTexturedType + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _yarnTypeKey,
                      spanCount: 3,
                      listOfItems: _yarnTypesList!,
                      callback: (YarnTypes value) {
                        _createRequestModel.ys_yarn_type_idfk =
                            value.ytId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            // show bottom sheet
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: GestureDetector(
                  onTap: (){
                    yarnSpecsSheet(context,_yarnSetting,_createRequestModel,(){
                      _notifierPlySheet.value = !_notifierPlySheet.value;
                    },
                        selectedFamilyId,_plyList!,_orientationList!,
                        _doublingMethodList!,_plyIdList);
                  },
                  child: ValueListenableBuilder(
                    valueListenable: _notifierPlySheet,
                    builder: (context, bool value, child){
                      return TextFormField(
                          key: Key(getPlyList(
                              _createRequestModel).toString()),
                          initialValue: getPlyList(
                              _createRequestModel) ??
                              '',
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          cursorColor: lightBlueTabs,
                          enabled: false,
                          style: TextStyle(fontSize: 11.sp),
                          textAlign: TextAlign.center,
                          cursorHeight: 16.w,
                          decoration: ygTextFieldDecoration('Enter count details','Count',true));
                    },
                  ),
                ),
              ),
            ),

            //Show Color Treatment Method
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showColorTreatmentMethod),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(
                            title: colorTreatmentMethod + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _colorTreatmentMethodKey,
                      spanCount: 3,
                      listOfItems: _colorTreatmentMethodList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (ColorTreatmentMethod value) {
                        _createRequestModel.ys_color_treatment_method_idfk =
                            value.yctmId.toString();

                        if (_colorTreatmentIdList.contains(value.yctmId)) {
                          setState(() {
                            _showDyingMethod = true;
                            _selectedColorTreatMethodId =
                                value.yctmId.toString();
                          });
                        } else {
                          setState(() {
                            _showDyingMethod = false;
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
              visible: _showDyingMethod
                  ? Ui.showHide(_yarnSetting!.showColor)
                  : false,
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: const TitleSmallBoldTextWidget(
                            title: "Dying Method" + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _dyingMethodKey,
                      spanCount: 3,
                      listOfItems:
                          _getDyingMethodList() /*_yarnData!.dyingMethod!.where((element) {
                                    if (element.ydmColorTreatmentMethodIdfk != _selectedColorTreatMethodId) {
                                      return element
                                              .ydmColorTreatmentMethodIdfk ==
                                          _createRequestModel
                                              .ys_color_treatment_method_idfk
                                              .toString();
                                    } else {
                                      return element.apperanceId ==
                                          _selectedAppearenceId.toString();
                                    }
                                  }).toList()*/
                      ,
                      callback: (DyingMethod value) {
                        _createRequestModel.ys_dying_method_idfk =
                            value.ydmId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Here Color Code is missing
            Visibility(
                visible: _showDyingMethod
                    ? Ui.showHide(_yarnSetting!.showColor)
                    : false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 0, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: "Select Color"),
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
                                _createRequestModel.ys_color_code = input!,
                            // validator: (input) {
                            //   if (input == null ||
                            //       input.isEmpty) {
                            //     return "Select Color Code";
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none),
                                contentPadding: const EdgeInsets.all(2.0),
                                hintText: "Select Color",
                                filled: true,
                                fillColor: pickerColor),
                            onTap: () {
                              _openDialogBox();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

            //Show Appearance
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showAppearance),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 0, top: 4, bottom: 4),
                        child:
                            TitleSmallBoldTextWidget(title: apperance + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _appearanceKey,
                      spanCount: 3,
                      listOfItems: _appearanceList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (YarnAppearance value) {
                        _createRequestModel.ys_apperance_idfk =
                            value.yaId.toString();

                        if (value.yaId == 3) {
                          setState(() {
                            _showDyingMethod = true;
                            _selectedAppearenceId = value.yaId.toString();
                          });
                        } else {
                          setState(() {
                            _showDyingMethod = false;
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

            //Show Quality
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showQuality),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 0, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: quality + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _qualityKey,
                      spanCount: 2,
                      listOfItems: _getQuality()
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (Quality value) {
                        _createRequestModel.ys_quality_idfk =
                            value.yqId.toString();
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
                        padding:
                            const EdgeInsets.only(left: 0, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: grades + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _gradeKey,
                      spanCount: 3,
                      listOfItems: _gradesList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (YarnGrades value) {
                        _createRequestModel.ys_grade_idfk =
                            value.grdId.toString();
                      },
                    ),
                  ],
                ),
              ),
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: usage + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _usageKey,
                      spanCount: 2,
                      listOfItems: _usageList!
                          .where((element) =>
                              element.ysFamilyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (Usage value) {
                        _createRequestModel.ys_usage_idfk =
                            value.yuId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Ratio and Count
            Row(
              children: [
                Visibility(
                  visible: Ui.showHide(_yarnSetting!.showRatio),
                  child: Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.w,
                        ),
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                            child: TitleSmallTextWidget(title: ratio + '*')),
                        YgTextFormFieldWithoutRange(
                            errorText: ratio,
                            label: ratio,
                            onSaved: (input) {
                              _createRequestModel.ys_ratio = input;
                            })
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                            child: TitleSmallTextWidget(title: count + '*')),
                        SizedBox(
                          height: 8.w,
                        ),
                        YgTextFormFieldWithRangeNonDecimal(
                            errorText: count,
                            label: count,
                            // onChanged:(value) => globalFormKey.currentState!.reset(),
                            minMax: _yarnSetting!.countMinMax!,
                            onSaved: (input) {
                              _createRequestModel.ys_count = input;
                            })
                      ],
                    ),
                  ),
                ),
              ],
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child:
                            TitleSmallBoldTextWidget(title: orientation + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _orientationKey,
                      spanCount: 2,
                      listOfItems: _orientationList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (OrientationTable value) {
                        _createRequestModel.ys_orientation_idfk =
                            value.yoId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Twist Direction
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showTwistDirection),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(
                            title: twistDirection + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _twistDirectionKey,
                      spanCount: 2,
                      listOfItems: _twistDirectionList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (TwistDirection value) {
                        _createRequestModel.ys_twist_direction_idfk =
                            value.ytdId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Spun Technique
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showSpunTechnique),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: spunTech + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _spunTechKey,
                      spanCount: 3,
                      listOfItems: _spunTechList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (SpunTechnique value) {
                        setState(() {
                          _selectedSpunTechId = value.ystId.toString();
                        });
                        _createRequestModel.ys_spun_technique_idfk =
                            value.ystId.toString();
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: pattern + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _patternKey,
                      spanCount: 3,
                      listOfItems: _getPattern()
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (PatternModel value) {
                        if (_patternIdList.contains(value.ypId)) {
                          setState(() {
                            _showPatternChar = true;
                            _selectedPatternId = value.ypId.toString();

                            _patternCharactristicList = _patternCharList!
                                .where((element) =>
                                    element.ypcPatternIdfk ==
                                    value.ypId.toString())
                                .toList();
                          });
                        } else {
                          setState(() {
                            _showPatternChar = false;
                            _createRequestModel.ys_pattern_charectristic_idfk =
                                null;
                          });
                        }
                        _createRequestModel.ys_pattern_idfk =
                            value.ypId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Pattern characteristics
            Visibility(
                visible: _showPatternChar, child: _showPatternCharWidget()),

            //Show Certification
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showCertification),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(
                            title: certification + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _certificateKey,
                      spanCount: 3,
                      listOfItems: _certificationList!,
                      callback: (Certification value) {
                        _createRequestModel.ys_certification_idfk =
                            value.cerId.toString();
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
        );
        break;
      default:
        widget1 = Column(
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(
                            title: yarnTexturedType + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _yarnTypeKey,
                      spanCount: 3,
                      listOfItems: _yarnTypesList!,
                      callback: (YarnTypes value) {
                        _createRequestModel.ys_yarn_type_idfk =
                            value.ytId.toString();
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
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w),
//                            child: TitleSmallTextWidget(title: dannier + '*')),
                        YgTextFormFieldWithRange(
                            onSaved: (input) =>
                                _createRequestModel.ys_dty_filament = input!,
                            // onChanged:(value) => globalFormKey.currentState!.reset(),
                            minMax: _yarnSetting!.dannierMinMax!,
                            label: dannier,
                            errorText: dannier),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
                SizedBox(
                  width: (Ui.showHide(_yarnSetting!.showDannier) &&
                          Ui.showHide(_yarnSetting!.showFilament))
                      ? 16.w
                      : 0,
                ),
                Visibility(
                  visible: Ui.showHide(_yarnSetting!.showFilament),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: TitleSmallTextWidget(title: filament + '*')),
                        YgTextFormFieldWithRange(
                          minMax: _yarnSetting!.filamentMinMax!,
                          onSaved: (input) =>
                              _createRequestModel.ys_fdy_filament = input!,
                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                          errorText: filament,
                          label: filament,
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: usage + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _usageKey,
                      spanCount: 2,
                      listOfItems: _usageList!
                          .where((element) =>
                              element.ysFamilyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (Usage value) {
                        _createRequestModel.ys_usage_idfk =
                            value.yuId.toString();
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child:
                            TitleSmallBoldTextWidget(title: apperance + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _appearanceKey,
                      spanCount: 3,
                      listOfItems: _appearanceList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (YarnAppearance value) {
                        _createRequestModel.ys_apperance_idfk =
                            value.yaId.toString();

                        if (value.yaId == 3) {
                          setState(() {
                            _showDyingMethod = true;
                            _selectedAppearenceId = value.yaId.toString();
                          });
                        } else {
                          setState(() {
                            _showDyingMethod = false;
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

            //Show Color Treatment Method
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showColorTreatmentMethod),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(
                            title: colorTreatmentMethod + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _colorTreatmentMethodKey,
                      spanCount: 3,
                      listOfItems: _colorTreatmentMethodList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (ColorTreatmentMethod value) {
                        _createRequestModel.ys_color_treatment_method_idfk =
                            value.yctmId.toString();

                        if (_colorTreatmentIdList.contains(value.yctmId)) {
                          setState(() {
                            _showDyingMethod = true;
                            _selectedColorTreatMethodId =
                                value.yctmId.toString();
                          });
                        } else {
                          setState(() {
                            _showDyingMethod = false;
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
              visible: _showDyingMethod
                  ? Ui.showHide(_yarnSetting!.showColor)
                  : false,
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: const TitleSmallBoldTextWidget(
                            title: "Dying Method" + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _dyingMethodKey,
                      spanCount: 3,
                      listOfItems:
                          _getDyingMethodList() /*_yarnData!.dyingMethod!.where((element) {
                                    if (element.ydmColorTreatmentMethodIdfk != _selectedColorTreatMethodId) {
                                      return element
                                              .ydmColorTreatmentMethodIdfk ==
                                          _createRequestModel
                                              .ys_color_treatment_method_idfk
                                              .toString();
                                    } else {
                                      return element.apperanceId ==
                                          _selectedAppearenceId.toString();
                                    }
                                  }).toList()*/
                      ,
                      callback: (DyingMethod value) {
                        _createRequestModel.ys_dying_method_idfk =
                            value.ydmId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Here Color Code is missing
            Visibility(
                visible: _showDyingMethod
                    ? Ui.showHide(_yarnSetting!.showColor)
                    : false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TitleSmallBoldTextWidget(title: "Select Color"),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
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
                                _createRequestModel.ys_color_code = input!,
                            // validator: (input) {
                            //   if (input == null ||
                            //       input.isEmpty) {
                            //     return "Select Color Code";
                            //   }
                            //   return null;
                            // },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none),
                                contentPadding: const EdgeInsets.all(2.0),
                                hintText: "Select Color",
                                filled: true,
                                fillColor: pickerColor),
                            onTap: () {
                              _openDialogBox();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

            // Show Ratio
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Visibility(
                visible: Ui.showHide(_yarnSetting!.showRatio),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8.w,
                    ),
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                            child: TitleSmallTextWidget(title: ratio + '*')),
                    YgTextFormFieldWithoutRange(
                        label: ratio,
                        errorText: ratio,
                        onSaved: (input) {
                          _createRequestModel.ys_ratio = input;
                        })
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
            // show bottom sheet
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: GestureDetector(
                  onTap: (){
                    yarnSpecsSheet(context,_yarnSetting,_createRequestModel,(){
                    _notifierPlySheet.value = !_notifierPlySheet.value;
                    },
                        selectedFamilyId,_plyList!,_orientationList!,
                        _doublingMethodList!,_plyIdList);
                  },
                  child: ValueListenableBuilder(
                    valueListenable: _notifierPlySheet,
                    builder: (context, bool value, child){
                      return TextFormField(
                          key: Key(getPlyList(
                              _createRequestModel).toString()),
                          initialValue: getPlyList(
                              _createRequestModel) ??
                              '',
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          cursorColor: lightBlueTabs,
                          enabled: false,
                          style: TextStyle(fontSize: 11.sp),
                          textAlign: TextAlign.center,
                          cursorHeight: 16.w,
                          decoration: ygTextFieldDecoration('Enter count details','Count',true));
                    },
                  ),
                ),
              ),
            ),
            /*Visibility(
              visible: true,
              child: GestureDetector(
                onTap: (){
                  yarnSpecsSheet(context,_yarnSetting,_createRequestModel,()=>{},
                      selectedFamilyId,_plyList!,_orientationList!,
                      _doublingMethodList!,_plyIdList);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 0.w, right: 0.w,top: 10.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(6))),
                  child: Container(
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
                                    title: 'Ply',
                                    color: Colors.black54,
                                    weight: FontWeight.normal,
                                  )),
                              GestureDetector(
                                onTap: () {
                                  // show sheet
                                  yarnSpecsSheet(context,_yarnSetting,_createRequestModel,()=>{},
                                      selectedFamilyId,_plyList!,_orientationList!,
                                  _doublingMethodList!,_plyIdList);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 4, right: 6, bottom: 4),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.keyboard_arrow_down_outlined,
                                    size: 24,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),*/
            /*// Count
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showCount),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w, top: 8.w),
//                            child: TitleSmallTextWidget(title: count + '*')),
                  SizedBox(
                    height: 12.w,
                  ),
                  YgTextFormFieldWithRangeNonDecimal(
                      errorText: count,
                      label: count,
                      // onChanged:(value) => globalFormKey.currentState!.reset(),
                      minMax: _yarnSetting!.countMinMax!,
                      onSaved: (input) {
                        _createRequestModel.ys_count = input;
                      })
                ],
              ),
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: ply + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _plyKey,
                      spanCount: 3,
                      listOfItems: _plyList!
                          .where((element) =>
                              element.familyId == _selectedFamilyId)
                          .toList(),
                      callback: (Ply value) {
                        _createRequestModel.ys_ply_idfk =
                            value.plyId.toString();

                        if (!_plyIdList.contains(value.plyId)) {
                          setState(() {
                            _showDoublingMethod = true;
                            _selectedPlyId = value.plyId.toString();
                          });
                        } else {
                          setState(() {
                            _showDoublingMethod = false;
                            _createRequestModel.ys_doubling_method_idFk = null;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Here Doubling Method
            Visibility(
              visible: _showDoublingMethod
                  ? Ui.showHide(_yarnSetting!.showDoublingMethod)
                  : false,
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: const TitleSmallBoldTextWidget(
                            title: "Doubling Method" + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _doublingMethodKey,
                      spanCount: 3,
                      listOfItems: _doublingMethodList!
                          .where((element) => element.plyId == _selectedPlyId)
                          .toList(),
                      callback: (DoublingMethod value) {
                        _createRequestModel.ys_doubling_method_idFk =
                            value.dmId.toString();
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child:
                            TitleSmallBoldTextWidget(title: orientation + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _orientationKey,
                      spanCount: 2,
                      listOfItems: _orientationList!
                          .where((element) =>
                              element.familyId == _selectedFamilyId)
                          .toList(),
                      callback: (OrientationTable value) {
                        _createRequestModel.ys_orientation_idfk =
                            value.yoId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),*/
            //Show Twist Direction
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showTwistDirection),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(
                            title: twistDirection + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _twistDirectionKey,
                      spanCount: 2,
                      listOfItems: _twistDirectionList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (TwistDirection value) {
                        _createRequestModel.ys_twist_direction_idfk =
                            value.ytdId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Spun Technique
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showSpunTechnique),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: spunTech + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _spunTechKey,
                      spanCount: 3,
                      listOfItems: _spunTechList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (SpunTechnique value) {
                        setState(() {
                          _selectedSpunTechId = value.ystId.toString();
                        });
                        _createRequestModel.ys_spun_technique_idfk =
                            value.ystId.toString();
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: quality + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _qualityKey,
                      spanCount: 2,
                      listOfItems: _getQuality()
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (Quality value) {
                        _createRequestModel.ys_quality_idfk =
                            value.yqId.toString();
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
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: pattern + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _patternKey,
                      spanCount: 3,
                      listOfItems: _getPattern()
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (PatternModel value) {
                        if (_patternIdList.contains(value.ypId)) {
                          setState(() {
                            _showPatternChar = true;
                            _selectedPatternId = value.ypId.toString();

                            _patternCharactristicList = _patternCharList!
                                .where((element) =>
                                    element.ypcPatternIdfk ==
                                    value.ypId.toString())
                                .toList();
                          });
                        } else {
                          setState(() {
                            _showPatternChar = false;
                            _createRequestModel.ys_pattern_charectristic_idfk =
                                null;
                          });
                        }
                        _createRequestModel.ys_pattern_idfk =
                            value.ypId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Pattern characteristics
            Visibility(
                visible: _showPatternChar, child: _showPatternCharWidget()),

            //Show Grade
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showGrade),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(title: grades + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _gradeKey,
                      spanCount: 3,
                      listOfItems: _gradesList!
                          .where((element) =>
                              element.familyId == _yarnPostProvider.selectedYarnFamily.famId!.toString())
                          .toList(),
                      callback: (YarnGrades value) {
                        _createRequestModel.ys_grade_idfk =
                            value.grdId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Certification
            Visibility(
              visible: Ui.showHide(_yarnSetting!.showCertification),
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: TitleSmallBoldTextWidget(
                            title: certification + '*')),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _certificateKey,
                      spanCount: 3,
                      listOfItems: _certificationList!,
                      callback: (Certification value) {
                        _createRequestModel.ys_certification_idfk =
                            value.cerId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 8.w,
            ),

            SizedBox(
              child: Visibility(
                visible:
                widget.selectedTab == offering_type,
                child: LabParameterPage(
                  callback: (value) {
                    widget.callback!(1);
                  },
                  key: _labParameterPage,
                  // yarnSyncResponse: widget.yarnSyncResponse,
                  locality: widget.locality,
                  businessArea: widget.businessArea,
                  selectedTab: widget.selectedTab,
                  newSettings: _yarnSetting!,
                  specKey: widget.key!,
                ),
              ),
            )
          ],
        );
        break;
    }
    return widget1;
  }

  @override
  bool get wantKeepAlive => true;

  String? getPlyList(CreateRequestModel createRequestModel) {
    List<String?> list = [];
    list.add(createRequestModel.ys_count);
    list.add(createRequestModel.ys_dty_filament);
    list.add(createRequestModel.ys_fdy_filament);
    if (_createRequestModel.ys_ply_idfk != null) {
      list.add(_plyList!
          .where((element) =>
      element.plyId.toString() == createRequestModel.ys_ply_idfk)
          .toList()
          .first
          .plyName);
    }
    if (_createRequestModel.ys_doubling_method_idFk != null) {
      list.add(_doublingMethodList!
          .where((element) =>
      element.dmId.toString() == createRequestModel.ys_doubling_method_idFk)
          .toList()
          .first
          .dmName);
    }
    if (_createRequestModel.ys_orientation_idfk != null) {
      list.add(_orientationList!
          .where((element) =>
      element.yoId.toString() == createRequestModel.ys_orientation_idfk)
          .toList()
          .first
          .yoName);
    }
    var responseString = Utils.createStringFromList(list);
    if (responseString.isNotEmpty) {
      return Utils.createStringFromList(list);
    } else {
      return '';
    }
  }
}
