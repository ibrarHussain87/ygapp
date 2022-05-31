import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
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
  final String? locality;
  final String? businessArea;
  final String? selectedTab;
  final Function? callback;

  const YarnSpecificationComponent(
      {Key? key,
      this.callback,
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

  final _yarnPostProvider = locator<PostYarnProvider>();
  final _yarnSpecificationProvider = locator<YarnSpecificationsProvider>();
  final ValueNotifier<bool> _notifierPlySheet = ValueNotifier(false);

  _changeColor(Color color) {
    pickerColor = color;
    _textEditingController.text = '#${pickerColor.value.toRadixString(16)}';
    _yarnPostProvider.notifyUI();
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
                pickerColor = pickerColor;
                _yarnPostProvider.notifyUI();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showPatternCharWidget() {
    if (_yarnPostProvider.patternCharList!.isEmpty) {
      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 15.w,
                ),
                YgTextFormFieldWithoutRangeNoValidation(
                  onSaved: (input) => _yarnPostProvider.createRequestModel!
                      .ys_pattern_charectristic_thickness = input!,
                  label: 'Thickness',
                  mandatoryField: false,
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
                YgTextFormFieldWithoutRangeNoValidation(
                  onSaved: (input) => _yarnPostProvider.createRequestModel!
                      .ys_length_pattern_charactristics = input!,
                  label: 'Length',
                  mandatoryField: false,
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
                YgTextFormFieldWithoutRangeNoValidation(
                  label: 'Pause',
                  mandatoryField: false,
                  onSaved: (input) => _yarnPostProvider.createRequestModel!
                      .ys_pause_patteren_charactristics = input!,
                ),
              ],
            ),
          ),
        ],
      );
    } /*else if (_patternGRIdList.contains(int.parse(_selectedPatternId!))) {
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
                  onSaved: (input) => _yarnPostProvider.createRequestModel!
                      .ys_grain_patteren_charactristics = input!,
                  errorText: "Grain",
                  label: 'Grain',
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Visibility(
            visible: _selectedPatternId != "16",
            child: Expanded(
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
                    onSaved: (input) => _yarnPostProvider.createRequestModel!
                        .ys_rice_patteren_charactristics = input!,
                    errorText: "Rice",
                    label: 'Rice',
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } */else {
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
              listOfItems: _yarnPostProvider.patternCharList!,
              callback: (PatternCharectristic value) {
                _yarnPostProvider.createRequestModel!
                    .ys_pattern_charectristic_idfk = value.ypcId.toString();
              },
            ),
          ],
        ),
      );
    }
  }

  // queryBlendSettings(int id) {
  //   AppDbInstance().getDbInstance().then((value) async {
  //     value.yarnSettingsDao
  //         .findFamilyAndBlendYarnSettings(
  //             _yarnPostProvider.blendList[id].blnId!,
  //             _yarnPostProvider.selectedYarnFamily.famId!)
  //         .then((value) {
  //       setState(() {
  //         if (value.isNotEmpty) {
  //           _resetData();
  //           _yarnPostProvider.yarnSetting = value[0];
  //         }
  //         _yarnPostProvider.createRequestModel!.ys_family_idfk ??= _yarnPostProvider.selectedYarnFamily.famId!.toString();
  //       });
  //     });
  //   });
  // }

  // queryFamilySettings(int id) {
  //   AppDbInstance().getDbInstance().then((value) async {
  //     value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
  //       setState(() {
  //         if (value.isNotEmpty) {
  //           _resetData();
  //           _yarnPostProvider.yarnSetting = value[0];
  //         }
  //         _yarnPostProvider.createRequestModel!.ys_family_idfk =
  //             _yarnPostProvider.selectedYarnFamily.famId!.toString();
  //       });
  //     });
  //   });
  // }

  //RESET ALL DATA
  _resetData() {
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
    if (_patternCharKey.currentState != null) {
      _patternCharKey.currentState!.resetWidget();
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
    if (_certificateKey.currentState != null) {
      _certificateKey.currentState!.resetWidget();
    }
    if (_gradeKey.currentState != null) {
      _gradeKey.currentState!.resetWidget();
    }
    if (_twistDirectionKey.currentState != null) {
      _twistDirectionKey.currentState!.resetWidget();
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

    _showDyingMethod = false;
    _showDoublingMethod = false;
    _showPatternChar = false;
    _selectedPatternId = null;
    _yarnPostProvider.createRequestModel!.ys_family_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_usage_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_blend_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_ratio = null;
    _yarnPostProvider.createRequestModel!.ys_twist_direction_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_grade_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_fdy_filament = null;
    _yarnPostProvider.createRequestModel!.ys_dty_filament = null;
    _yarnPostProvider.createRequestModel!.ys_apperance_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_color_treatment_method_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_dying_method_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_color_code = null;
    _yarnPostProvider.createRequestModel!.ys_count = null;
    _yarnPostProvider.createRequestModel!.ys_ply_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_doubling_method_idFk = null;
    _yarnPostProvider.createRequestModel!.ys_orientation_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_quality_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_pattern_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_pattern_charectristic_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_certification_idfk = null;
    _yarnPostProvider.createRequestModel!.ys_yarn_type_idfk = null;
    _yarnPostProvider.notifyUI();
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
      if (_yarnPostProvider.createRequestModel!.ys_yarn_type_idfk == null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showTexturized)) {
        Ui.showSnackBar(context, 'Please Select Textured Yarn Type');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_usage_idfk == null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showUsage)) {
        Ui.showSnackBar(context, 'Please Select Usage');
        return false;
      } else if (_yarnPostProvider
                  .createRequestModel!.ys_color_treatment_method_idfk ==
              null &&
          Ui.showHide(
              _yarnPostProvider.yarnSetting!.showColorTreatmentMethod)) {
        Ui.showSnackBar(context, 'Please Select Color Treatment Method');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_dying_method_idfk ==
              null &&
          _showDyingMethod) {
        Ui.showSnackBar(context, 'Please Select Dying Method');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_ply_idfk == null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showPly)) {
        Ui.showSnackBar(context, 'Please Select Ply');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_doubling_method_idFk ==
              null &&
          _showDoublingMethod &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showDoublingMethod)) {
        Ui.showSnackBar(context, 'Please Select Doubling Method');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_orientation_idfk ==
              null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showOrientation)) {
        Ui.showSnackBar(context, 'Please Select Orientation');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_count == null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showCount)) {
        Ui.showSnackBar(context, 'Please Select Count');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_dty_filament == null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showDannier)) {
        Ui.showSnackBar(context, 'Please Select Dannier');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_fdy_filament == null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showFilament)) {
        Ui.showSnackBar(context, 'Please Select Filament');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_spun_technique_idfk ==
              null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showSpunTechnique)) {
        Ui.showSnackBar(context, 'Please Select Spun Technique');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_quality_idfk == null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showQuality)) {
        Ui.showSnackBar(context, 'Please Select Quality');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_pattern_idfk == null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showPattern)) {
        Ui.showSnackBar(context, 'Please Select Pattern');
        return false;
      } else if (_yarnPostProvider
                  .createRequestModel!.ys_pattern_charectristic_idfk ==
              null &&
          _showPatternChar &&
          !_patternTLPIdList.contains(int.tryParse(_selectedPatternId!)) &&
          !_patternGRIdList.contains(int.tryParse(_selectedPatternId!))) {
        Ui.showSnackBar(context, 'Please Select Pattern Characteristics');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_grade_idfk == null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showGrade)) {
        Ui.showSnackBar(context, 'Please Select Grade');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_apperance_idfk ==
              null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showAppearance)) {
        Ui.showSnackBar(context, 'Please Select Appearance');
        return false;
      } else if (_yarnPostProvider.createRequestModel!.ys_certification_idfk ==
              null &&
          Ui.showHide(_yarnPostProvider.yarnSetting!.showCertification)) {
        Ui.showSnackBar(context, 'Please Select Certification');
        return false;
      } else {
        _yarnPostProvider.createRequestModel!.spc_category_idfk = "2";
        return true;
      }
    }
    return false;
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

  //FOR FILTERING DYED COLOR TREATMENT METHOD
  final List<int> _colorTreatmentIdList = [3, 5, 8, 11, 13];

  final List<int> _plyIdList = [1, 5, 9, 13];
  final List<int> _patternIdList = [1, 2, 3, 4, 9, 10, 12];
  final List<int> _patternTLPIdList = [2, 9, 12, 14];
  final List<int> _patternGRIdList = [10, 16];

  //Show Hide on dependency
  bool _showDyingMethod = false;
  bool _showDoublingMethod = false;
  bool _showPatternChar = false;

  Color pickerColor = const Color(0xffffffff);

  // Yarn? _yarnData;
  final TextEditingController _textEditingController = TextEditingController();
  var logger = Logger();
  String? _selectedPatternId = "-1";

  @override
  void initState() {
    super.initState();
    _yarnPostProvider.familyDisabled = false;
    _yarnPostProvider.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _notifierPlySheet.dispose();
    _yarnPostProvider.yarnSetting = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _yarnPostProvider.yarnSetting != null
        ? Scaffold(
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
                    padding: EdgeInsets.only(top: 8.w, left: 16.w, right: 16.w),
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
                            child: setSpecificationParameters(_yarnPostProvider
                                .selectedYarnFamily.famId!
                                .toString()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.selectedTab == requirement_type ||
                      _yarnPostProvider.selectedYarnFamily.famId!.toString() ==
                          4.toString(),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButtonWithIcon(
                        callback: () async {
                          if (widget.selectedTab == offering_type) {
                            if (validationAllPage()) {
                              _yarnPostProvider
                                  .createRequestModel!.spc_category_idfk = "2";
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
            ))
        : Container();
  }

  void submitData(BuildContext context) {
    if (widget.businessArea == yarn) {
      _yarnPostProvider.createRequestModel!.ys_local_international =
          widget.locality!.toUpperCase();
    } else {
      _yarnPostProvider.createRequestModel!.spc_local_international =
          widget.locality!.toUpperCase();
    }

    _yarnPostProvider.createRequestModel!.is_offering = widget.selectedTab;

    ProgressDialogUtil.showDialog(context, 'Please wait...');

    ApiService.createSpecification(_yarnPostProvider.createRequestModel!,
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
              visible:
                  Ui.showHide(_yarnPostProvider.yarnSetting!.showTexturized),
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
                      listOfItems: _yarnPostProvider.yarnTypesList!,
                      callback: (YarnTypes value) {
                        _yarnPostProvider.createRequestModel!.ys_yarn_type_idfk =
                            value.ytId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            // show ply bottom sheet
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: GestureDetector(
                  onTap: () {
                    yarnSpecsSheet(context, _yarnPostProvider.yarnSetting,
                        _yarnPostProvider.createRequestModel!, () {
                      _notifierPlySheet.value = !_notifierPlySheet.value;
                    },
                        selectedFamilyId,
                        _yarnPostProvider.plyList!,
                        _yarnPostProvider.orientationList!,
                        _yarnPostProvider.doublingMethodList!,
                        _plyIdList);
                  },
                  child: ValueListenableBuilder(
                    valueListenable: _notifierPlySheet,
                    builder: (context, bool value, child) {
                      return Stack(
                        children: [
                          TextFormField(
                              key: Key(
                                  getPlyList(_yarnPostProvider.createRequestModel!)
                                      .toString()),
                              initialValue: getPlyList(
                                  _yarnPostProvider.createRequestModel!) ??
                                  '',
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              cursorColor: lightBlueTabs,
                              enabled: false,
                              style: TextStyle(fontSize: 11.sp),
                              textAlign: TextAlign.center,
                              cursorHeight: 16.w,
                              decoration: ygTextFieldDecoration(
                                  'Enter count details', 'Count', true)),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 8, right: 6, bottom: 10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.keyboard_arrow_down_outlined,
                                size: 24,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            //Show Color Treatment Method
            Visibility(
              visible: Ui.showHide(
                  _yarnPostProvider.yarnSetting!.showColorTreatmentMethod),
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
                      listOfItems: _yarnPostProvider.colorTreatmentMethodList!,
                      callback: (ColorTreatmentMethod value) async {
                        _yarnPostProvider.createRequestModel!
                                .ys_color_treatment_method_idfk =
                            value.yctmId.toString();
                        await _yarnPostProvider
                            .getDyingMethodListWithCTMId(value.yctmId!);

                        if (_yarnPostProvider.dyingMethodList!.isNotEmpty) {
                          _showDyingMethod = true;
                        } else {
                          _showDyingMethod = false;
                          _yarnPostProvider
                              .createRequestModel!.ys_dying_method_idfk = null;
                          _yarnPostProvider.createRequestModel!.ys_color_code =
                              null;
                        }
                        _yarnPostProvider.notifyUI();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Color dying Method
            Visibility(
              visible: _showDyingMethod
                  ? Ui.showHide(_yarnPostProvider.yarnSetting!.showColor)
                  : false,
              child: Padding(
                padding: EdgeInsets.only(top: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                        child: const TitleSmallBoldTextWidget(
                            title: "Dying Method *")),
                    SingleSelectTileWidget(
                      selectedIndex: -1,
                      key: _dyingMethodKey,
                      spanCount: 3,
                      listOfItems: _yarnPostProvider.dyingMethodList!,
                      callback: (DyingMethod value) {
                        _yarnPostProvider.createRequestModel!
                            .ys_dying_method_idfk = value.ydmId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Here Color Code is missing
            Visibility(
                visible: _showDyingMethod
                    ? Ui.showHide(_yarnPostProvider.yarnSetting!.showColor)
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
                            onSaved: (input) => _yarnPostProvider
                                .createRequestModel!.ys_color_code = input!,
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
              visible:
                  Ui.showHide(_yarnPostProvider.yarnSetting!.showAppearance),
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
                      listOfItems: _yarnPostProvider.appearanceList!,
                      callback: (YarnAppearance value) {
                        _yarnPostProvider.createRequestModel!.ys_apperance_idfk =
                            value.yaId.toString();

                        if (value.yaId == 3) {
                          _showDyingMethod = true;
                          _yarnPostProvider
                              .getDyingMethodListWithAprId(value.yaId!);
                        } else {
                          _showDyingMethod = false;
                          _yarnPostProvider
                              .createRequestModel!.ys_dying_method_idfk = null;
                          _yarnPostProvider.createRequestModel!.ys_color_code =
                              null;
                        }
                        _yarnPostProvider.notifyUI();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Quality
            Visibility(
              visible: Ui.showHide(_yarnPostProvider.yarnSetting!.showQuality),
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
                      listOfItems: _yarnPostProvider.qualityList!,
                      callback: (Quality value) {
                        _yarnPostProvider.createRequestModel!.ys_quality_idfk =
                            value.yqId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Grade
            Visibility(
              visible: Ui.showHide(_yarnPostProvider.yarnSetting!.showGrade),
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
                      listOfItems: _yarnPostProvider.gradesList!,
                      callback: (YarnGrades value) {
                        _yarnPostProvider.createRequestModel!.ys_grade_idfk =
                            value.grdId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Usage
            Visibility(
              visible: Ui.showHide(_yarnPostProvider.yarnSetting!.showUsage),
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
                      listOfItems: _yarnPostProvider.usageList!,
                      callback: (Usage value) {
                        _yarnPostProvider.createRequestModel!.ys_usage_idfk =
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
                  visible:
                      Ui.showHide(_yarnPostProvider.yarnSetting!.showRatio),
                  child: Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.w,
                        ),
                        YgTextFormFieldWithoutRange(
                            errorText: ratio,
                            label: ratio,
                            onSaved: (input) {
                              _yarnPostProvider.createRequestModel!.ys_ratio =
                                  input;
                            })
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
                SizedBox(
                  width: (Ui.showHide(
                              _yarnPostProvider.yarnSetting!.showRatio) &&
                          Ui.showHide(_yarnPostProvider.yarnSetting!.showCount))
                      ? 16.w
                      : 0,
                ),
                Visibility(
                  visible:
                      Ui.showHide(_yarnPostProvider.yarnSetting!.showCount),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.w,
                        ),
                        YgTextFormFieldWithRangeNonDecimal(
                            errorText: count,
                            label: count,
                            minMax: _yarnPostProvider.yarnSetting!.countMinMax!,
                            onSaved: (input) {
                              _yarnPostProvider.createRequestModel!.ys_count =
                                  input;
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Show Orientation
            Visibility(
              visible:
                  Ui.showHide(_yarnPostProvider.yarnSetting!.showOrientation),
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
                      listOfItems: _yarnPostProvider.orientationList!,
                      callback: (OrientationTable value) {
                        _yarnPostProvider.createRequestModel!
                            .ys_orientation_idfk = value.yoId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Twist Direction
            /*Visibility(
              visible: Ui.showHide(
                  _yarnPostProvider.yarnSetting!.showTwistDirection),
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
                      listOfItems: _yarnPostProvider.twistDirectionList!,
                      callback: (TwistDirection value) {
                        _yarnPostProvider.createRequestModel!
                            .ys_twist_direction_idfk = value.ytdId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),*/

            //Show Spun Technique
            Visibility(
              visible:
                  Ui.showHide(_yarnPostProvider.yarnSetting!.showSpunTechnique),
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
                      listOfItems: _yarnPostProvider.spunTechList!,
                      callback: (SpunTechnique value) {
                        spunSelection(value);
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Pattern
            Visibility(
              visible: Ui.showHide(_yarnPostProvider.yarnSetting!.showPattern),
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
                      listOfItems: _yarnPostProvider.patternList!,
                      callback: (PatternModel value) {
                        patternSelection(value);
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
              visible:
                  Ui.showHide(_yarnPostProvider.yarnSetting!.showCertification),
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
                      listOfItems: _yarnPostProvider.certificationList!,
                      callback: (Certification value) {
                        _yarnPostProvider.createRequestModel!
                            .ys_certification_idfk = value.cerId.toString();
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
              visible:
                  Ui.showHide(_yarnPostProvider.yarnSetting!.showTexturized),
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
                      listOfItems: _yarnPostProvider.yarnTypesList!,
                      callback: (YarnTypes value) {
                        _yarnPostProvider.createRequestModel!.ys_yarn_type_idfk =
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
                  visible:
                      Ui.showHide(_yarnPostProvider.yarnSetting!.showDannier),
                  child: Expanded(
                    child: Column(
                      children: [
//                        Padding(
//                            padding: EdgeInsets.only(left: 4.w),
//                            child: TitleSmallTextWidget(title: dannier + '*')),
                        YgTextFormFieldWithRange(
                            onSaved: (input) => _yarnPostProvider
                                .createRequestModel!.ys_dty_filament = input!,
                            // onChanged:(value) => globalFormKey.currentState!.reset(),
                            minMax:
                                _yarnPostProvider.yarnSetting!.dannierMinMax!,
                            label: dannier,
                            errorText: dannier),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
                SizedBox(
                  width: (Ui.showHide(
                              _yarnPostProvider.yarnSetting!.showDannier) &&
                          Ui.showHide(
                              _yarnPostProvider.yarnSetting!.showFilament))
                      ? 16.w
                      : 0,
                ),
                Visibility(
                  visible:
                      Ui.showHide(_yarnPostProvider.yarnSetting!.showFilament),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: TitleSmallTextWidget(title: filament + '*')),
                        YgTextFormFieldWithRange(
                          minMax:
                              _yarnPostProvider.yarnSetting!.filamentMinMax!,
                          onSaved: (input) => _yarnPostProvider
                              .createRequestModel!.ys_fdy_filament = input!,
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
              visible: Ui.showHide(_yarnPostProvider.yarnSetting!.showUsage),
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
                      listOfItems: _yarnPostProvider.usageList!,
                      callback: (Usage value) {
                        _yarnPostProvider.createRequestModel!.ys_usage_idfk =
                            value.yuId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Appearance
            Visibility(
              visible:
                  Ui.showHide(_yarnPostProvider.yarnSetting!.showAppearance),
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
                      listOfItems: _yarnPostProvider.appearanceList!,
                      callback: (YarnAppearance value) {
                        _yarnPostProvider.createRequestModel!.ys_apperance_idfk =
                            value.yaId.toString();

                        if (value.yaId == 3) {
                          _showDyingMethod = true;
                          _yarnPostProvider
                              .getDyingMethodListWithAprId(value.yaId!);
                        } else {
                          _showDyingMethod = false;
                          _yarnPostProvider
                              .createRequestModel!.ys_dying_method_idfk = null;
                          _yarnPostProvider.createRequestModel!.ys_color_code =
                              null;
                        }

                        _yarnPostProvider.notifyUI();
                      },
                    ),
                  ],
                ),
              ),
            ),

            // show ply bottom sheet
            Visibility(
              visible: true,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: GestureDetector(
                  onTap: () {
                    yarnSpecsSheet(context, _yarnPostProvider.yarnSetting,
                        _yarnPostProvider.createRequestModel!, () {
                          _notifierPlySheet.value = !_notifierPlySheet.value;
                        },
                        selectedFamilyId,
                        _yarnPostProvider.plyList!,
                        _yarnPostProvider.orientationList!,
                        _yarnPostProvider.doublingMethodList!,
                        _plyIdList);
                  },
                  child: ValueListenableBuilder(
                    valueListenable: _notifierPlySheet,
                    builder: (context, bool value, child) {
                      return Stack(
                        children: [
                          TextFormField(
                              key: Key(
                                  getPlyList(_yarnPostProvider.createRequestModel!)
                                      .toString()),
                              initialValue: getPlyList(
                                  _yarnPostProvider.createRequestModel!) ??
                                  '',
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              cursorColor: lightBlueTabs,
                              enabled: false,
                              style: TextStyle(fontSize: 11.sp),
                              textAlign: TextAlign.center,
                              cursorHeight: 16.w,
                              decoration: ygTextFieldDecoration(
                                  'Enter count details', 'Count', true)),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 8, right: 6, bottom: 10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.keyboard_arrow_down_outlined,
                                size: 24,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),

            //Show Color Treatment Method
            Visibility(
              visible: Ui.showHide(
                  _yarnPostProvider.yarnSetting!.showColorTreatmentMethod),
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
                      listOfItems: _yarnPostProvider.colorTreatmentMethodList!,
                      callback: (ColorTreatmentMethod value) async {
                        _yarnPostProvider.createRequestModel!
                                .ys_color_treatment_method_idfk =
                            value.yctmId.toString();
                        await _yarnPostProvider
                            .getDyingMethodListWithCTMId(value.yctmId!);

                        if (_yarnPostProvider.dyingMethodList!.isNotEmpty) {
                          _showDyingMethod = true;
                        } else {
                          _showDyingMethod = false;
                          _yarnPostProvider
                              .createRequestModel!.ys_dying_method_idfk = null;
                          _yarnPostProvider.createRequestModel!.ys_color_code =
                              null;
                        }
                        _yarnPostProvider.notifyUI();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Color dying Method
            Visibility(
              visible: _showDyingMethod
                  ? Ui.showHide(_yarnPostProvider.yarnSetting!.showColor)
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
                      listOfItems: _yarnPostProvider.dyingMethodList!,
                      callback: (DyingMethod value) {
                        _yarnPostProvider.createRequestModel!
                            .ys_dying_method_idfk = value.ydmId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Here Color Code is missing
            Visibility(
                visible: _showDyingMethod
                    ? Ui.showHide(_yarnPostProvider.yarnSetting!.showColor)
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
                            onSaved: (input) => _yarnPostProvider
                                .createRequestModel!.ys_color_code = input!,
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
                visible: Ui.showHide(_yarnPostProvider.yarnSetting!.showRatio),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8.w,
                    ),
                    YgTextFormFieldWithoutRange(
                        label: ratio,
                        errorText: ratio,
                        onSaved: (input) {
                          _yarnPostProvider.createRequestModel!.ys_ratio = input;
                        })
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),

            //Show Twist Direction
            /*Visibility(
              visible: Ui.showHide(
                  _yarnPostProvider.yarnSetting!.showTwistDirection),
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
                      listOfItems: _yarnPostProvider.twistDirectionList!,
                      callback: (TwistDirection value) {
                        _yarnPostProvider.createRequestModel!
                            .ys_twist_direction_idfk = value.ytdId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),*/

            //Show Spun Technique
            Visibility(
              visible:
                  Ui.showHide(_yarnPostProvider.yarnSetting!.showSpunTechnique),
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
                      listOfItems: _yarnPostProvider.spunTechList!,
                      callback: (SpunTechnique value) {
                        spunSelection(value);
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Quality
            Visibility(
              visible: Ui.showHide(_yarnPostProvider.yarnSetting!.showQuality),
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
                      listOfItems: _yarnPostProvider.qualityList!,
                      callback: (Quality value) {
                        _yarnPostProvider.createRequestModel!.ys_quality_idfk =
                            value.yqId.toString();
                      },
                    ),
                  ],
                ),
              ),
            ),

            //Show Pattern
            Visibility(
              visible: Ui.showHide(_yarnPostProvider.yarnSetting!.showPattern),
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
                      listOfItems: _yarnPostProvider.patternList!,
                      callback: (PatternModel value) {
                        patternSelection(value);
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
              visible: Ui.showHide(_yarnPostProvider.yarnSetting!.showGrade),
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
                      listOfItems: _yarnPostProvider.gradesList!,
                      callback: (YarnGrades value) {
                        _yarnPostProvider.createRequestModel!.ys_grade_idfk =
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
                  Ui.showHide(_yarnPostProvider.yarnSetting!.showCertification),
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
                      listOfItems: _yarnPostProvider.certificationList!,
                      callback: (Certification value) {
                        _yarnPostProvider.createRequestModel!
                            .ys_certification_idfk = value.cerId.toString();
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
                visible: widget.selectedTab == offering_type,
                child: LabParameterPage(
                  callback: (value) {
                    widget.callback!(1);
                  },
                  locality: widget.locality,
                  businessArea: widget.businessArea,
                  selectedTab: widget.selectedTab,
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
    if (_yarnPostProvider.createRequestModel!.ys_ply_idfk != null) {
      list.add(_yarnPostProvider.plyList!
          .where((element) =>
              element.plyId.toString() == createRequestModel.ys_ply_idfk)
          .toList()
          .first
          .plyName);
    }
    if (_yarnPostProvider.createRequestModel!.ys_doubling_method_idFk != null) {
      list.add(_yarnPostProvider.doublingMethodList!
          .where((element) =>
              element.dmId.toString() ==
              createRequestModel.ys_doubling_method_idFk)
          .toList()
          .first
          .dmName);
    }
    if (_yarnPostProvider.createRequestModel!.ys_orientation_idfk != null) {
      list.add(_yarnPostProvider.orientationList!
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

  spunSelection(SpunTechnique value) async {
    _yarnPostProvider.createRequestModel!.ys_spun_technique_idfk =
        value.ystId.toString();
    await _yarnPostProvider.getPatternWithSpunId(value.ystId!);
    await _yarnPostProvider.getQualityWithSpunId(value.ystId!);
    if (_yarnPostProvider.qualityList!.isEmpty) {
      await _yarnPostProvider.getQuality();
    }
    if (_yarnPostProvider.patternList!.isEmpty) {
      await _yarnPostProvider.getPatternList();
    }
  }

  patternSelection(PatternModel value) async {
    await _yarnPostProvider.getPatternCharcIdWithPtrId(value.ypId!);
    _selectedPatternId = value.ypId.toString();
    if (_patternTLPIdList.contains(int.parse(_selectedPatternId!))) {
      _showPatternChar = true;
    } else if (_patternGRIdList.contains(int.parse(_selectedPatternId!))) {
      _showPatternChar = true;
    } else {
      _showPatternChar = false;
      _yarnPostProvider.createRequestModel!.ys_pattern_charectristic_idfk = null;
    }
    _yarnPostProvider.createRequestModel!.ys_pattern_idfk =
        value.ypId.toString();
  }
}
