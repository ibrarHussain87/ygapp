import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
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

class YarnSpecificationComponentState
    extends State<YarnSpecificationComponent> {
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
                Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
                    child: const TitleSmallTextWidget(title: "Thickness")),
                YgTextFormFieldWithoutRange(
                  onSaved: (input) => _createRequestModel
                      .ys_pattern_charectristic_thickness = input!,
                  errorText: "Thickness",
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
                Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
                    child: const TitleSmallTextWidget(title: "Length")),
                YgTextFormFieldWithoutRange(
                  onSaved: (input) => _createRequestModel
                      .ys_length_pattern_charactristics = input!,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
                    child: const TitleSmallTextWidget(title: "Pause")),
                YgTextFormFieldWithoutRange(
                  errorText: "Pause",
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
                Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
                    child: const TitleSmallTextWidget(title: "Grain")),
                YgTextFormFieldWithoutRange(
                  onSaved: (input) => _createRequestModel
                      .ys_grain_patteren_charactristics = input!,
                  errorText: "Grain",
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
                Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
                    child: const TitleSmallTextWidget(title: "Rice")),
                YgTextFormFieldWithoutRange(
                  onSaved: (input) => _createRequestModel
                      .ys_rice_patteren_charactristics = input!,
                  errorText: "Rice",
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
                padding: EdgeInsets.only(left: 8.w),
                child: TitleSmallTextWidget(title: patternChar)),
            SingleSelectTileWidget(
              key: _patternCharKey,
              spanCount: 4,
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
      return _yarnData!.dyingMethod!
          .where((element) =>
              element.ydmColorTreatmentMethodIdfk ==
              _selectedColorTreatMethodId)
          .toList();
    } else {
      return _yarnData!.dyingMethod!
          .where((element) => element.apperanceId == _selectedAppearenceId)
          .toList();
    }
  }

  queryBlendSettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {
      value.yarnSettingsDao
          .findFamilyAndBlendYarnSettings(
              _yarnData!.blends![id].blnId!, int.parse(_selectedFamilyId!))
          .then((value) {
        setState(() {
          _selectedBlendIndex = id;
          //Selected Blend Id
          if (value.isNotEmpty) {
            _resetData();
            _yarnSetting = value[0];
            _initGridValues();
            _createRequestModel.ys_family_idfk ??= _selectedFamilyId;
            _createRequestModel.ys_blend_idfk = _selectedBlendIndex != null
                ? widget.yarnSyncResponse.data.yarn
                    .blends![_selectedBlendIndex!].blnId
                    .toString()
                : "";
          }
          _createRequestModel.ys_family_idfk ??= _selectedFamilyId;
          _createRequestModel.ys_blend_idfk =
              widget.yarnSyncResponse.data.yarn.blends![id].blnId.toString();

          /*else {
            Ui.showSnackBar(context, 'No Settings Found');
          }*/
        });
      });
    });
  }

  queryFamilySettings(int id) {
    AppDbInstance.getDbInstance().then((value) async {
      value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
        setState(() {
          _selectedFamilyId = id.toString();
          if (value.isNotEmpty) {
            _resetData();
            _yarnSetting = value[0];
            _initGridValues();
          }
          _createRequestModel.ys_family_idfk = _selectedFamilyId;
        });
      });
    });
  }

  _initGridValues() async {
    var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
    _createRequestModel.ys_user_idfk = userID.toString();

    //Category Id
    _createRequestModel.spc_category_idfk = YARN_CATEGORY_ID.toString();

    //Blend Id
    if (Ui.showHide(_yarnSetting!.showBlend)) {
      _createRequestModel.ys_blend_idfk = _yarnData!.blends!
          .where(
              (element) => element.familyIdfk.toString() == _selectedFamilyId)
          .toList()
          .first
          .blnId
          .toString();
    }

    //Grade ID
    if (Ui.showHide(_yarnSetting!.showGrade) && _yarnData!.grades!.isNotEmpty) {
      _createRequestModel.ys_grade_idfk = _yarnData!.grades!
          .where((element) => element.familyId.toString() == _selectedFamilyId)
          .toList()
          .first
          .grdId
          .toString();
    }

    //Certification ID
    if (Ui.showHide(_yarnSetting!.showCertification)) {
      _createRequestModel.ys_certification_idfk =
          _yarnData!.certification!.first.cerId.toString();
    }

    //PLY ID
    if (Ui.showHide(_yarnSetting!.showPly) && _yarnData!.ply!.isNotEmpty) {
      _createRequestModel.ys_ply_idfk = _yarnData!.ply!
          .where((element) => element.familyId.toString() == _selectedFamilyId)
          .toList()
          .first
          .plyId
          .toString();
    }

    //Quality ID
    if (Ui.showHide(_yarnSetting!.showQuality)) {
      if (_selectedSpunTechId == "1") {
        _createRequestModel.ys_quality_idfk = _yarnData!.quality!
            .where(
                (element) => element.familyId.toString() == _selectedFamilyId)
            .toList()
            .where(
                (element) => element.spun_technique_id == _selectedSpunTechId)
            .toList()
            .first
            .yqId
            .toString();
      } else {
        _createRequestModel.ys_quality_idfk = _yarnData!.quality!
            .where(
                (element) => element.familyId.toString() == _selectedFamilyId)
            .toList()
            .first
            .yqId
            .toString();
      }
    }

    //ORIENTATION ID
    if (Ui.showHide(_yarnSetting!.showOrientation) &&
        _yarnData!.orientation!.isNotEmpty) {
      _createRequestModel.ys_orientation_idfk = _yarnData!.orientation!
          .where((element) => element.familyId.toString() == _selectedFamilyId)
          .toList()
          .first
          .yoId
          .toString();
    }

    //USAGE ID
    if (Ui.showHide(_yarnSetting!.showUsage) && _yarnData!.usage!.isNotEmpty) {
      _createRequestModel.ys_usage_idfk = _yarnData!.usage!
          .where(
              (element) => element.ysFamilyId.toString() == _selectedFamilyId)
          .toList()
          .first
          .yuId
          .toString();
    }

    //PATTERN ID
    if (Ui.showHide(_yarnSetting!.showPattern) &&
        _yarnData!.pattern!.isNotEmpty) {

      if (_selectedSpunTechId == "1") {
        _createRequestModel.ys_pattern_idfk = _yarnData!.pattern!
            .where(
                (element) => element.familyId.toString() == _selectedFamilyId)
            .toList()
            .where(
                (element) => element.spun_technique_id == _selectedSpunTechId)
            .toList()
            .first
            .ypId
            .toString();
      } else {
        _createRequestModel.ys_pattern_idfk = _yarnData!.pattern!
            .where(
                (element) => element.familyId.toString() == _selectedFamilyId)
            .toList()
            .first
            .ypId
            .toString();
      }
      // _createRequestModel.ys_pattern_idfk = _yarnData!.pattern!
      //     .where((element) => element.familyId.toString() == _selectedFamilyId)
      //     .toList()
      //     .first
      //     .ypId
      //     .toString();
    }

    //PATTERN CHAR ID
    if (_showPatternChar) {
      if (_yarnData!.patternCharectristic!.isNotEmpty) {
        if (widget.yarnSyncResponse.data.yarn.patternCharectristic!
            .where((element) =>
                element.ypcPatternIdfk.toString() == _selectedPatternId)
            .toList()
            .isNotEmpty) {
          _createRequestModel.ys_pattern_charectristic_idfk = widget
              .yarnSyncResponse.data.yarn.patternCharectristic!
              .where((element) =>
                  element.ypcPatternIdfk.toString() == _selectedPatternId)
              .toList()
              .first
              .ypcId
              .toString();
        }
      }
    }

    //TWIST DIRECTION ID
    if (Ui.showHide(_yarnSetting!.showTwistDirection) &&
        _yarnData!.twistDirection!.isNotEmpty) {
      _createRequestModel.ys_twist_direction_idfk = widget
          .yarnSyncResponse.data.yarn.twistDirection!
          .where((element) => element.familyId.toString() == _selectedFamilyId)
          .toList()
          .first
          .ytdId
          .toString();
    }

    //SPUN TECH ID
    if (Ui.showHide(_yarnSetting!.showSpunTechnique) &&
        _yarnData!.spunTechnique!.isNotEmpty) {
      setState(() {
        _selectedSpunTechId = widget.yarnSyncResponse.data.yarn.spunTechnique!
            .where(
                (element) => element.familyId.toString() == _selectedFamilyId)
            .toList()
            .first
            .ystId
            .toString();
      });

      _createRequestModel.ys_spun_technique_idfk = widget
          .yarnSyncResponse.data.yarn.spunTechnique!
          .where((element) => element.familyId.toString() == _selectedFamilyId)
          .toList()
          .first
          .ystId
          .toString();
    }

    //COLOR TREATMENT METHOD ID
    if (Ui.showHide(_yarnSetting!.showColorTreatmentMethod) &&
        _yarnData!.colorTreatmentMethod!.isNotEmpty) {
      _createRequestModel.ys_color_treatment_method_idfk = widget
          .yarnSyncResponse.data.yarn.colorTreatmentMethod!
          .where((element) => element.familyId.toString() == _selectedFamilyId)
          .toList()
          .first
          .yctmId
          .toString();
    }

    //APPEARANCE ID
    if (Ui.showHide(_yarnSetting!.showAppearance) &&
        _yarnData!.apperance!.isNotEmpty) {
      _createRequestModel.ys_apperance_idfk = _yarnData!.apperance!
          .where((element) => element.familyId.toString() == _selectedFamilyId)
          .toList()
          .first
          .yaId
          .toString();
    }

    //DYING METHOD ID
    if (Ui.showHide(_yarnSetting!.showDyingMethod) &&
        _showDyingMethod &&
        _yarnData!.dyingMethod!.isNotEmpty) {
      _createRequestModel.ys_dying_method_idfk = _yarnData!.dyingMethod!
          .where((element) =>
              element.apperanceId.toString() == _selectedAppearenceId)
          .toList()
          .first
          .ydmId
          .toString();
    }

    //Doubling method id
    if (_showDoublingMethod &&
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

    //Yarn Type
    if (Ui.showHide(_yarnSetting!.showTexturized) &&
        _yarnData!.yarnTypes!.isNotEmpty) {
      _createRequestModel.ys_yarn_type_idfk = widget
          .yarnSyncResponse
          .data
          .yarn
          .yarnTypes! /*
          .where((element) => element.plyId == _createRequestModel.ys_ply_idfk)
          .toList()*/
          .first
          .ytId
          .toString();
    }
  }

  //RESET ALL DATA
  _resetData() {
    if (_yarnTypeKey.currentState != null) {
      _yarnTypeKey.currentState!.checkedTile = 0;
    }
    if (_usageKey.currentState != null) _usageKey.currentState!.checkedTile = 0;
    if (_appearanceKey.currentState != null) {
      _appearanceKey.currentState!.checkedTile = 0;
    }
    if (_plyKey.currentState != null) _plyKey.currentState!.checkedTile = 0;
    if (_patternKey.currentState != null) {
      _patternKey.currentState!.checkedTile = 0;
    }
    if (_patternCharKey.currentState != null) {
      _patternCharKey.currentState!.checkedTile = 0;
    }
    if (_orientationKey.currentState != null) {
      _orientationKey.currentState!.checkedTile = 0;
    }
    if (_spunTechKey.currentState != null) {
      _spunTechKey.currentState!.checkedTile = 0;
    }
    if (_qualityKey.currentState != null) {
      _qualityKey.currentState!.checkedTile = 0;
    }
    if (_certificateKey.currentState != null) {
      _certificateKey.currentState!.checkedTile = 0;
    }
    if (_gradeKey.currentState != null) _gradeKey.currentState!.checkedTile = 0;
    if (_twistDirectionKey.currentState != null) {
      _twistDirectionKey.currentState!.checkedTile = 0;
    }
    if (_doublingMethodKey.currentState != null) {
      _doublingMethodKey.currentState!.checkedTile = 0;
    }
    if (_dyingMethodKey.currentState != null) {
      _dyingMethodKey.currentState!.checkedTile = 0;
    }
    if (_colorTreatmentMethodKey.currentState != null) {
      _colorTreatmentMethodKey.currentState!.checkedTile = 0;
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

  _getPattern() {
    if (_selectedSpunTechId != null) {
      if (_selectedSpunTechId == "1") {
        return _yarnData!.pattern!
            .where((element) => element.spun_technique_id == "1")
            .toList();
      }
      return _yarnData!.pattern;
    }

    return _yarnData!.pattern;
  }

  _getQuality() {
    if (_selectedSpunTechId != null) {
      if (_selectedSpunTechId == "1") {
        return _yarnData!.quality!
            .where((element) => element.spun_technique_id == "1")
            .toList();
      }
      return _yarnData!.quality;
    }

    return _yarnData!.quality;
  }

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

  Yarn? _yarnData;
  final TextEditingController _textEditingController = TextEditingController();
  var logger = Logger();

  //Provider Models
  YarnSetting? _yarnSetting;
  late CreateRequestModel _createRequestModel;

//pattern charactristics List
  List<PatternCharectristic>? _patternCharactristicList;

//Id's of selection
  String? _selectedFamilyId;
  int? _selectedBlendIndex;

  String? _selectedPlyId;
  String? _selectedPatternId;
  String? _selectedAppearenceId;
  String? _selectedColorTreatMethodId;
  String? _selectedSpunTechId;

  @override
  void initState() {
    // Utils.disableClick = false;
    _yarnData = widget.yarnSyncResponse.data.yarn;
    _selectedFamilyId = _yarnData!.family!.first.famId.toString();
    queryFamilySettings(int.parse(_selectedFamilyId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit) {
      _createRequestModel = Provider.of<CreateRequestModel>(context);
      _yarnSetting ??= Provider.of<YarnSetting>(context);
      _initGridValues();
      _isInit = true;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      key: _scaffoldKey,
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
                      key: _globalFormKey,
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
                                  SingleSelectTileWidget(
                                    key: _yarnTypeKey,
                                    spanCount: 3,
                                    listOfItems: _yarnData!.yarnTypes!,
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
                                  SingleSelectTileWidget(
                                    key: _usageKey,
                                    spanCount: 2,
                                    listOfItems: _yarnData!.usage!
                                        .where((element) =>
                                            element.ysFamilyId ==
                                            _selectedFamilyId)
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
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: apperance)),
                                  SingleSelectTileWidget(
                                    key: _appearanceKey,
                                    spanCount: 3,
                                    listOfItems: _yarnData!.apperance!
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
                                        .toList(),
                                    callback: (YarnAppearance value) {
                                      _createRequestModel.ys_apperance_idfk =
                                          value.yaId.toString();

                                      if (value.yaId == 3) {
                                        setState(() {
                                          _showDyingMethod = true;
                                          _selectedAppearenceId =
                                              value.yaId.toString();
                                        });
                                      } else {
                                        setState(() {
                                          _showDyingMethod = false;
                                          _createRequestModel
                                              .ys_dying_method_idfk = null;
                                          _createRequestModel.ys_color_code =
                                              null;
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
                                  SingleSelectTileWidget(
                                    key: _colorTreatmentMethodKey,
                                    spanCount: 3,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.colorTreatmentMethod!
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
                                        .toList(),
                                    callback: (ColorTreatmentMethod value) {
                                      _createRequestModel
                                              .ys_color_treatment_method_idfk =
                                          value.yctmId.toString();

                                      if (_colorTreatmentIdList
                                          .contains(value.yctmId)) {
                                        setState(() {
                                          _showDyingMethod = true;
                                          _selectedColorTreatMethodId =
                                              value.yctmId.toString();
                                        });
                                      } else {
                                        setState(() {
                                          _showDyingMethod = false;
                                          _createRequestModel
                                              .ys_dying_method_idfk = null;
                                          _createRequestModel.ys_color_code =
                                              null;
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
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: const TitleSmallTextWidget(
                                          title: "Dying Method")),
                                  SingleSelectTileWidget(
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
                                      child: TitleSmallTextWidget(
                                          title: "Select Color"),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                                              _createRequestModel
                                                  .ys_color_code = input!,
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
                                                  borderSide: BorderSide.none),
                                              contentPadding:
                                                  const EdgeInsets.all(2.0),
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
                                      YgTextFormFieldWithRangeNonDecimal(
                                          errorText: count,
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: _yarnSetting!.countMinMax!,
                                          onSaved: (input) {
                                            _createRequestModel.ys_count =
                                                input;
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
                                  SingleSelectTileWidget(
                                    key: _plyKey,
                                    spanCount: 4,
                                    listOfItems: _yarnData!.ply!
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
                                        .toList(),
                                    callback: (Ply value) {
                                      _createRequestModel.ys_ply_idfk =
                                          value.plyId.toString();

                                      if (!_plyIdList.contains(value.plyId)) {
                                        setState(() {
                                          _showDoublingMethod = true;
                                          _selectedPlyId =
                                              value.plyId.toString();
                                        });
                                      } else {
                                        setState(() {
                                          _showDoublingMethod = false;
                                          _createRequestModel
                                              .ys_doubling_method_idFk = null;
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
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: const TitleSmallTextWidget(
                                          title: "Doubling Method")),
                                  SingleSelectTileWidget(
                                    key: _doublingMethodKey,
                                    spanCount: 3,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.doublingMethod!
                                        .where((element) =>
                                            element.plyId == _selectedPlyId)
                                        .toList(),
                                    callback: (DoublingMethod value) {
                                      _createRequestModel
                                              .ys_doubling_method_idFk =
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
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: orientation)),
                                  SingleSelectTileWidget(
                                    key: _orientationKey,
                                    spanCount: 2,
                                    listOfItems: _yarnData!.orientation!
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
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
                                  SingleSelectTileWidget(
                                    key: _twistDirectionKey,
                                    spanCount: 2,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.twistDirection!
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
                                        .toList(),
                                    callback: (TwistDirection value) {
                                      _createRequestModel
                                              .ys_twist_direction_idfk =
                                          value.ytdId.toString();
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
                                  SingleSelectTileWidget(
                                    key: _spunTechKey,
                                    spanCount: 4,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.spunTechnique!
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
                                        .toList(),
                                    callback: (SpunTechnique value) {
                                      setState(() {
                                        _selectedSpunTechId =
                                            value.ystId.toString();
                                      });
                                      _createRequestModel
                                              .ys_spun_technique_idfk =
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
                                      padding: EdgeInsets.only(left: 8.w),
                                      child:
                                          TitleSmallTextWidget(title: quality)),
                                  SingleSelectTileWidget(
                                    key: _qualityKey,
                                    spanCount: 2,
                                    listOfItems: _getQuality()
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
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
                                      padding: EdgeInsets.only(left: 8.w),
                                      child:
                                          TitleSmallTextWidget(title: pattern)),
                                  SingleSelectTileWidget(
                                    key: _patternKey,
                                    spanCount: 3,
                                    listOfItems: _getPattern()
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
                                        .toList(),
                                    callback: (PatternModel value) {
                                      if (_patternIdList.contains(value.ypId)) {
                                        setState(() {
                                          _showPatternChar = true;
                                          _selectedPatternId =
                                              value.ypId.toString();

                                          _patternCharactristicList = widget
                                              .yarnSyncResponse
                                              .data
                                              .yarn
                                              .patternCharectristic!
                                              .where((element) =>
                                                  element.ypcPatternIdfk ==
                                                  value.ypId.toString())
                                              .toList();
                                        });
                                      } else {
                                        setState(() {
                                          _showPatternChar = false;
                                          _createRequestModel
                                                  .ys_pattern_charectristic_idfk =
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
                              visible: _showPatternChar,
                              child: _showPatternCharWidget()),

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
                                  SingleSelectTileWidget(
                                    key: _gradeKey,
                                    spanCount: 3,
                                    listOfItems: _yarnData!.grades!
                                        .where((element) =>
                                            element.familyId ==
                                            _selectedFamilyId)
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
                                  SingleSelectTileWidget(
                                    key: _certificateKey,
                                    spanCount: 4,
                                    listOfItems: widget.yarnSyncResponse.data
                                        .yarn.certification!,
                                    callback: (Certification value) {
                                      _createRequestModel
                                              .ys_certification_idfk =
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
        ],
      ),
    );
  }
}
