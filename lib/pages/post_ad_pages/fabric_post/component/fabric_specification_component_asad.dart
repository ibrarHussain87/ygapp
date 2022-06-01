import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/bottom_sheets/weft_bottom_sheet.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/blended_single_tile.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/providers/fabric_providers/fabric_specifications_provider.dart';

import '../../../../providers/fabric_providers/post_fabric_provider.dart';
import '../../../../elements/bottom_sheets/fabric_ply_bottom_sheet.dart';
import '../../../../elements/bottom_sheets/warp_bottom_sheet.dart';
import '../../../../elements/decoration_widgets.dart';
import '../../../../helper_utils/dialog_builder.dart';
import '../../../../helper_utils/fabric_bottom_sheet.dart';
import '../../../../helper_utils/navigation_utils.dart';
import '../../../../helper_utils/progress_dialog_util.dart';
import '../../../../helper_utils/pure_single_tile.dart';
import '../../../../helper_utils/util.dart';
import '../../../../model/blend_model.dart';
import '../../../../model/request/post_fabric_request/create_fabric_request_model.dart';
import '../../../../model/response/fabric_response/sync/fabric_sync_response.dart';

class FabricSpecificationComponent extends StatefulWidget {
  final Function? callback;

  // final SyncFiberResponse syncFiberResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FabricSpecificationComponent(
      {Key? key,
      // required this.syncFiberResponse,
      required this.callback,
      required this.locality,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  FabricSpecificationComponentState createState() =>
      FabricSpecificationComponentState();
}

class FabricSpecificationComponentState
    extends State<FabricSpecificationComponent>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  // from key (asad_m)
  GlobalKey<FormState> blendedFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int? _selectedMaterial;
  String? familyId;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  FabricSetting? _fabricSettings;
  FabricCreateRequestModel? _createRequestModel;

  late PostFabricProvider postFabricProvider;

  late List<FabricBlends> _fabricBlendsList;
  late List<FabricFamily> _fabricFamilyList;
  late List<FabricAppearance> _fabricAppearanceList;
  late List<FabricGrades> _fabricGradesList;
  late List<Brands> _brands;
  late List<Countries> _countries;
  late List<CityState> _citySateList;
  late List<Certification> _certificationList;
  late List<FabricPly> _plyList;
  late List<KnittingTypes> _knittingTypeList;
  late List<FabricAppearance> _appearanceList;
  late List<FabricColorTreatmentMethod> _colorTreatmentMethodList;
  late List<FabricQuality> _qualityList;
  late List<FabricGrades> _gradeList;
  late List<FabricDyingTechniques> _dyingMethodList;
  late List<FabricWeave> _weaveList;
  late List<FabricLoom> _loomList;
  late List<FabricSalvedge> _salvedgeList;
  late List<FabricLayyer> _layyerList;
  late List<DenimTypes> _denimTypesList;

  Color pickerColor = const Color(0xffffffff);
  String? _selectedPlyId;
  bool _showDyingMethod = false;
  bool _showPatternChar = false;

  String? _selectedPatternId;
  String? _selectedAppearenceId;
  String? _selectedColorTreatMethodId;
  String? _selectedSpunTechId;
  String? weavePatternA;
  String? weavePatternB;

  final List<int> _colorTreatmentIdList = [3, 4, 5, 8, 11, 13,16,17];

  final GlobalKey<SingleSelectTileWidgetState> _plyKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _knittingTypeKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _appearanceKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _colorTreatmentMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _qualityKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _gradeKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _certificationKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _dyingMethodKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _weaveKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _loomKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _salvedgeKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _layyerKey =
      GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _denimTypeKey =
      GlobalKey<SingleSelectTileWidgetState>();

  //Nature Fabric key (asad_m)
  final GlobalKey<SingleSelectTileWidgetState> _natureFabricKey =
      GlobalKey<SingleSelectTileWidgetState>();

  // Nature of fabric List
  late List<String> _natureFabricList = ["Pure", "Blended"];
  List<TextEditingController> textFieldControllers = [];
  List<FabricBlends> blendValue = [];
  FabricBlends pureValue = FabricBlends();
  List<PickedFile> imageFiles = [];
  final ValueNotifier<bool> _notifierPlySheet = ValueNotifier(false);
  final ValueNotifier<bool> _notifierWarpSheet = ValueNotifier(false);
  final ValueNotifier<bool> _notifierWeftSheet = ValueNotifier(false);
  final ValueNotifier<bool> _notifierShowTuckingWidth = ValueNotifier(false);

  var checked = false;

//  String pureValue="";
  String blendString = "";
  List<BlendModel> values = [];

  _getFabricSyncedData(PostFabricProvider postFabricProvider) async {
    var dbInstance = await AppDbInstance().getDbInstance();

    AppDbInstance().getFabricBlendsData().then((value) => setState(() {
          _fabricBlendsList = value;
          _selectedMaterial = value
              .where((element) =>
                  element.familyIdfk ==
                  postFabricProvider.firstFamilyId.toString())
              .toList()
              .first
              .blnId;
          postFabricProvider.setBlendId(_selectedMaterial!);
          familyId = _fabricBlendsList
              .where((element) => element.blnId == postFabricProvider.blendId)
              .first
              .familyIdfk;
        }));
    _fabricFamilyList = await dbInstance.fabricFamilyDao.findAllFabricFamily();
    _fabricAppearanceList =
        await dbInstance.fabricAppearanceDao.findAllFabricAppearance();
    _fabricGradesList = await dbInstance.fabricGradesDao.findAllFabricGrade();
    _plyList = await dbInstance.fabricPlyDao.findAllFabricPly();
    _knittingTypeList =
        await dbInstance.knittingTypesDao.findAllKnittingTypes();
    _appearanceList =
        await dbInstance.fabricAppearanceDao.findAllFabricAppearance();
    _colorTreatmentMethodList = await dbInstance.fabricColorTreatmentMethodDao
        .findAllFabricColorTreatmentMethod();
    _qualityList = await dbInstance.fabricQualityDao.findAllFabricQuality();
    _gradeList = await dbInstance.fabricGradesDao.findAllFabricGrade();
    _dyingMethodList =
        await dbInstance.fabricDyingTechniqueDao.findAllFabricDyingTechniques();
    _weaveList = await dbInstance.fabricWeaveDao.findAllFabricWeave();
    _loomList = await dbInstance.fabricLoomDao.findAllFabricLoom();
    _salvedgeList = await dbInstance.fabricSalvedgeDao.findAllFabricSalvedge();
    _layyerList = await dbInstance.fabricLayyerDao.findAllFabricLayyer();
    _denimTypesList =
        await dbInstance.fabricDenimTypesDao.findAllFabricDenimTypes();
    Logger().e("message");
    AppDbInstance()
        .getFiberBrandsData()
        .then((value) => setState(() => _brands = value));
    AppDbInstance()
        .getOriginsData()
        .then((value) => setState(() => _countries = value));
    AppDbInstance()
        .getCityState()
        .then((value) => setState(() => _citySateList = value));

    _certificationList =
        await dbInstance.certificationDao.findCertificationWithCatId(3);
  }

  final ValueNotifier<bool> _notifier = ValueNotifier(false);
  final ValueNotifier<Color> _notifierColor =
      ValueNotifier(const Color(0xffffffff));

  // Pure text notifier (asad_m)
  final ValueNotifier<String> _notifierPureText = ValueNotifier("");
  final ValueNotifier<String> _notifierBlendText = ValueNotifier("");

  final _fabricPostProvider = locator<PostFabricProvider>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    final postFabricProvider =
        Provider.of<PostFabricProvider>(context, listen: false);
    _createRequestModel = postFabricProvider.fabricCreateRequestModel;
    _resetData();
    _getFabricSyncedData(postFabricProvider);
    _fabricPostProvider.familyDisabled = false;
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _notifier.dispose();
    _notifierBlendText.dispose();
    _notifierPureText.dispose();
    _notifierColor.dispose();
    _notifierPlySheet.dispose();
    _notifierWarpSheet.dispose();
    _notifierWeftSheet.dispose();
    _notifierShowTuckingWidth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    postFabricProvider = Provider.of<PostFabricProvider>(context);
    /*if (postFabricProvider.blendId != null) {
     // _selectedMaterial = postFabricProvider.blendId;
      // _createRequestModel = Provider.of<CreateRequestModel?>(context);
      familyId = postFabricProvider.selectedFabricFamily.fabricFamilyId.toString();
    } else {
    //  _selectedMaterial = null;
      // _createRequestModel = Provider.of<CreateRequestModel?>(context);
      familyId = FABRIC_MIRCOFIBER_ID */ /*Microfiber*/ /*;
    }*/
    familyId =
        postFabricProvider.selectedFabricFamily.fabricFamilyId.toString();
    return FutureBuilder<List<FabricSetting>>(
      future: postFabricProvider.getFabricSettingsData(familyId!),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              _resetData();
              ApiService.logger.e(_createRequestModel!.toJson());
              _fabricSettings = /*snapshot.data![0]*/
                  postFabricProvider.fabricSetting!.first;
            }
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 8.w, left: 0.w, right: 0.w),
                    child: SingleChildScrollView(
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
                          Form(
                            key: globalFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 4,
                                ),
                                //Show Ratio
                                Visibility(
                                  visible:
                                      Ui.showHide(_fabricSettings!.showRatio),
                                  child: Column(
                                    children: [
                                      // Modified by (asad_m)
//                                            Padding(
//                                                padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
//                                                child: TitleSmallTextWidget(title: ratio + '*')),
                                      SizedBox(
                                        height: 12.w,
                                      ),
                                      YgTextFormFieldWithoutRange(
                                          errorText: ratio,
                                          label: ratio,
                                          onSaved: (input) {
                                            _createRequestModel!.fs_ratio =
                                                input;
                                          })
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                                // show bottom sheet
                                Visibility(
                                  visible:
                                      Ui.showHide(_fabricSettings!.showPly) ||
                                          Ui.showHide(_fabricSettings!.showGsm),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: GestureDetector(
                                      onTap: () {
                                        fabricPlySheet(context, _fabricSettings,
                                            _createRequestModel, () {
                                          _notifierPlySheet.value =
                                              !_notifierPlySheet.value;
                                        }, _plyList, familyId!);
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: _notifierPlySheet,
                                        builder: (context, bool value, child) {
                                          return Stack(
                                            children: [
                                              TextFormField(
                                                  key: Key(getPlyList(
                                                          _createRequestModel!)
                                                      .toString()),
                                                  initialValue: getPlyList(
                                                          _createRequestModel!) ??
                                                      '',
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor: lightBlueTabs,
                                                  enabled: false,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  decoration:
                                                      ygTextFieldDecoration(
                                                          'Enter count details',
                                                          'Count',
                                                          true)),
                                              Align(
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 8,
                                                      right: 6,
                                                      bottom: 10),
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_outlined,
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
                                /*Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showPly) ||
                                      Ui.showHide(_fabricSettings!.showGsm),
                                  child: GestureDetector(
                                    onTap: () {
                                      fabricPlySheet(context, _fabricSettings,
                                          _createRequestModel, () {
                                            _notifierPlySheet.value =
                                            !_notifierPlySheet.value;
                                          }, _plyList, familyId!);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 0.w, right: 0.w, top: 10.w),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(6))),
                                      child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
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
                                                      child: ValueListenableBuilder(
                                                        valueListenable: _notifierPlySheet,
                                                        builder: (context,
                                                            bool value, child) {
                                                          return TitleMediumTextWidget(
                                                            title: 'Ply${getPlyList(
                                                                _createRequestModel!) ??
                                                                ''}',
                                                            color: Colors
                                                                .black54,
                                                            weight: FontWeight
                                                                .normal,
                                                          );
                                                        },
                                                      )
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      // show sheet
                                                      fabricPlySheet(context,
                                                          _fabricSettings,
                                                          _createRequestModel, () =>
                                                          {
                                                            _notifierPlySheet
                                                                .value =
                                                            !_notifierPlySheet
                                                                .value
                                                          }, _plyList,
                                                          familyId!);
                                                    },
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                          .only(
                                                          top: 4,
                                                          right: 6,
                                                          bottom: 4),
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(Icons
                                                          .keyboard_arrow_down_outlined,
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
                                  visible: Ui.showHide(_fabricSettings!.showCount),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // modified by (asad_m)
//                                            Padding(
//                                                padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
//                                                child: TitleSmallTextWidget(title: count + '*')),
                                      SizedBox(height:12.w ,),
                                      YgTextFormFieldWithRangeNonDecimal(
                                          errorText: count,
                                          label: count,
                                          // onChanged:(value) => globalFormKey.currentState!.reset(),
                                          minMax: _fabricSettings!.countMinMax!,
                                          onSaved: (input) {
                                            _createRequestModel!.fs_count = input;
                                          })
                                    ],
                                  ),
                                ),*/
                                /*const SizedBox(height: 4,),*/
                                //Show Knitting Type
                                Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showKnittingType),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child:
                                                const TitleSmallBoldTextWidget(
                                                    title:
                                                        'Knitting Type' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _knittingTypeKey,
                                          spanCount: 2,
                                          listOfItems: _knittingTypeList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (KnittingTypes value) {
                                            _createRequestModel!
                                                    .fs_knitting_type_idfk =
                                                value.fabricKnittingTypeId
                                                    .toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showWarpCount),
                                  child: GestureDetector(
                                    onTap: () {
                                      warpSheet(context, _fabricSettings,
                                          _createRequestModel, () {
                                        _notifierWarpSheet.value =
                                            !_notifierWarpSheet.value;
                                      }, familyId!, _plyList);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: ValueListenableBuilder(
                                        valueListenable: _notifierWarpSheet,
                                        builder: (context, bool value, child) {
                                          return Stack(
                                            children: [
                                              TextFormField(
                                                  key: Key(getWarpList(
                                                          _createRequestModel!)
                                                      .toString()),
                                                  initialValue: getWarpList(
                                                          _createRequestModel!) ??
                                                      '',
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor: lightBlueTabs,
                                                  enabled: false,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  decoration:
                                                      ygTextFieldDecoration(
                                                          'Enter Warp',
                                                          'Warp',
                                                          true)),
                                              Align(
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 8,
                                                      right: 6,
                                                      bottom: 10),
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_outlined,
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
                                // New Wrap design (asad_m)
                                /*Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showWarpCount),
                                  child: GestureDetector(
                                    onTap: () {
                                      warpSheet(context, _fabricSettings,
                                          _createRequestModel, () {
                                            _notifierWarpSheet.value =
                                            !_notifierWarpSheet.value;
                                          });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(height: 12.w,),
//                                      const Divider(color: Colors.black12,),
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: Ui.showHide(
                                                  _fabricSettings!
                                                      .showWarpCount),
                                              child: Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    // Modified by (asad_m)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 0.w,
                                                          right: 0.w,
                                                          top: 2.w),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12),
                                                          borderRadius: const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  6))),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            mainAxisSize: MainAxisSize
                                                                .max,
                                                            children: [

                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      top: 10.w,
                                                                      left: 8.w,
                                                                      bottom: 10
                                                                          .w),
                                                                  child: ValueListenableBuilder(
                                                                      valueListenable: _notifierWarpSheet,
                                                                      builder: (context, bool value, child) {
                                                                        return TitleMediumTextWidget(
                                                                          title: 'Warp${getWarpList(
                                                                              _createRequestModel!) ??
                                                                              ''}',
                                                                          color: Colors
                                                                              .black54,
                                                                          weight: FontWeight
                                                                              .normal,
                                                                        );
                                                                      }
                                                                  )),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  // show sheet
                                                                  warpSheet(
                                                                      context,
                                                                      _fabricSettings,
                                                                      _createRequestModel, () {
                                                                    _notifierWarpSheet
                                                                        .value =
                                                                    !_notifierWarpSheet
                                                                        .value;
                                                                  });
                                                                },
                                                                child: Container(
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      top: 4,
                                                                      right: 6,
                                                                      bottom: 4),
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down_outlined,
                                                                    size: 24,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),*/
                                Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showWeftCount),
                                  child: GestureDetector(
                                    onTap: () {
                                      weftSheet(context, _fabricSettings,
                                          _createRequestModel, () {
                                        _notifierWeftSheet.value =
                                            !_notifierWeftSheet.value;
                                      }, familyId!, _plyList);
                                    },
                                    child: ValueListenableBuilder(
                                      valueListenable: _notifierWeftSheet,
                                      builder: (context, bool value, child) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Stack(
                                            children: [
                                              TextFormField(
                                                  key: Key(getWeftList(
                                                          _createRequestModel!)
                                                      .toString()),
                                                  initialValue: getWeftList(
                                                          _createRequestModel!) ??
                                                      '',
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor: lightBlueTabs,
                                                  enabled: false,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  decoration:
                                                      ygTextFieldDecoration(
                                                          'Enter Weft',
                                                          'Weft',
                                                          true)),
                                              Align(
                                                alignment: AlignmentDirectional
                                                    .centerEnd,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                    top: 8,
                                                    right: 6,
                                                  ),
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_outlined,
                                                    size: 24,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                /*Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showWeftCount),
                                  child: GestureDetector(
                                    onTap: () {
                                      weftSheet(context, _fabricSettings,
                                          _createRequestModel, (){
                                            _notifierWeftSheet.value = ! _notifierWeftSheet.value;
                                          });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(height: 12.w,),
//                                      const Divider(color: Colors.black12,),
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: Ui.showHide(
                                                  _fabricSettings!
                                                      .showWeftCount),
                                              child: Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    // Modified by (asad_m)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 0.w,
                                                          right: 0.w,
                                                          top: 2.w),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12),
                                                          borderRadius: const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  6))),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            mainAxisSize: MainAxisSize
                                                                .max,
                                                            children: [

                                                              Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      top: 10.w,
                                                                      left: 8.w,
                                                                      bottom: 10
                                                                          .w),
                                                                  child: ValueListenableBuilder(
                                                                      valueListenable: _notifierWeftSheet,
                                                                      builder: (context, bool value, child) {
                                                                        return TitleMediumTextWidget(
                                                                          title: 'Weft${getWeftList(
                                                                              _createRequestModel!) ??
                                                                              ''}',
                                                                          color: Colors
                                                                              .black54,
                                                                          weight: FontWeight
                                                                              .normal,
                                                                        );
                                                                      }
                                                                  )),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  // show sheet
                                                                  weftSheet(
                                                                      context,
                                                                      _fabricSettings,
                                                                      _createRequestModel, ()
                                                                  {
                                                                    _notifierWeftSheet.value = ! _notifierWeftSheet.value;
                                                                  });
                                                                },
                                                                child: Container(
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      top: 4,
                                                                      right: 6,
                                                                      bottom: 4),
                                                                  decoration: const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down_outlined,
                                                                    size: 24,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),*/

                                //Show Warp count and No of Ends
//                                Row(
//                                  children: [
//                                    Visibility(
//                                      visible: Ui.showHide(_fabricSettings!.showWarpCount),
//                                      child: Expanded(
//                                        child: Column(
//                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                          children: [
//                                            // Modified by (asad_m)
////                                            Padding(
////                                                padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
////                                                child: const TitleSmallTextWidget(title: 'Warp Count' + '*')),
////
//                                            SizedBox(height:12.w ,),
//                                            YgTextFormFieldWithRangeNonDecimal(
//                                                errorText: 'Warp Count',
//                                                label:'Warp Count',
//                                                // onChanged:(value) => globalFormKey.currentState!.reset(),
//                                                minMax: _fabricSettings!.warpCountMinMax??'n/a',
//                                                onSaved: (input) {
//                                                  _createRequestModel!.fs_warp_count = input;
//                                                })
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      width: (Ui.showHide(_fabricSettings!.showRatio) &&
//                                          Ui.showHide(_fabricSettings!.showCount))
//                                          ? 16.w
//                                          : 0,
//                                    ),
//                                    Visibility(
//                                      visible: Ui.showHide(_fabricSettings!.showNoOfEndsWarp),
//                                      child: Expanded(
//                                        child: Column(
//                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                          children: [
//                                            // modified by (asad_m)
////                                            Padding(
////                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
////                                                child: const TitleSmallTextWidget(title: 'No of Ends' + '*')),
//                                            SizedBox(height:12.w ,),
//                                            YgTextFormFieldWithRangeNonDecimal(
//                                              label:'No of Ends',
//                                                errorText: 'No of Ends',
//                                                // onChanged:(value) => globalFormKey.currentState!.reset(),
//                                                minMax: _fabricSettings!.noOfEndsWarpMinMax??'n/a',
//                                                onSaved: (input) {
//                                                  _createRequestModel!.fs_no_of_ends_warp = input;
//                                                })
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
                                //Show Weft count and No of Picks
//                                Row(
//                                  children: [
//                                    Visibility(
//                                      visible: Ui.showHide(_fabricSettings!.showWeftCount),
//                                      child: Expanded(
//                                        child: Column(
//                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                          children: [
//                                            //modified by (asad_m)
////                                            Padding(
////                                                padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
////                                                child: const TitleSmallTextWidget(title: 'Weft Count' + '*')),
////
//                                            SizedBox(height:12.w ,),
//                                            YgTextFormFieldWithRangeNonDecimal(
//                                                errorText: 'Weft Count',
//                                                label: 'Weft Count',
//                                                // onChanged:(value) => globalFormKey.currentState!.reset(),
//                                                minMax: _fabricSettings!.weftCountMinMax??'n/a',
//                                                onSaved: (input) {
//                                                  _createRequestModel!.fs_weft_count = input;
//                                                })
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      width: (Ui.showHide(_fabricSettings!.showRatio) &&
//                                          Ui.showHide(_fabricSettings!.showCount))
//                                          ? 16.w
//                                          : 0,
//                                    ),
//                                    Visibility(
//                                      visible: Ui.showHide(_fabricSettings!.showNoOfPickWeft),
//                                      child: Expanded(
//                                        child: Column(
//                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                          children: [
//                                            //Modified by (asad_m)
//
////                                            Padding(
////                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
////                                                child: const TitleSmallTextWidget(title: 'No of Picks' + '*')),
//                                            SizedBox(height:12.w ,),
//                                            YgTextFormFieldWithRangeNonDecimal(
//                                                errorText: 'No of Picks',
//                                                label: 'No of Picks',
//                                                // onChanged:(value) => globalFormKey.currentState!.reset(),
//                                                minMax: _fabricSettings!.noOfPickWeftMinMax??'n/a',
//                                                onSaved: (input) {
//                                                  _createRequestModel!.fs_no_of_pick_weft = input;
//                                                })
//                                          ],
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
                                //Show Warp Ply and Weft ply
//                                Row(
//                                  children: [
//                                   Visibility(
//                                      visible: Ui.showHide(_fabricSettings!.showWarpPly),
//                                      child: Expanded(
//                                        child: Column(
//                                          children: [
//                                           //Modifeid by (asad_m)
////                                            Padding(
////                                                padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
////                                                child: const TitleSmallTextWidget(title: 'Warp Ply' + '*')),
//                                            SizedBox(height:12.w ,),
//                                            YgTextFormFieldWithoutRange(
//                                                errorText: 'Warp Ply',
//                                                label: 'Warp Ply',
//                                                onSaved: (input) {
//                                                  _createRequestModel!.fs_warp_ply_idfk = input;
//                                                })
//                                          ],
//                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                        ),
//                                      ),
//                                    ),
//                                    SizedBox(
//                                      width: (Ui.showHide(_fabricSettings!.showRatio) &&
//                                          Ui.showHide(_fabricSettings!.showCount))
//                                          ? 16.w
//                                          : 0,
//                                    ),
//                                    Visibility(
//                                      visible: Ui.showHide(_fabricSettings!.showWarpPly),
//                                      child: Expanded(
//                                        child: Column(
//                                          children: [
//                                            // modified by (asad_m)
////                                            Padding(
////                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
////                                                child: const TitleSmallTextWidget(title: 'Weft Ply' + '*')),
//                                            SizedBox(height:12.w ,),
//                                            YgTextFormFieldWithoutRange(
//                                                errorText: 'Weft Ply',
//                                                label: 'Weft Ply',
//                                                onSaved: (input) {
//                                                  _createRequestModel!.fs_weft_ply_idfk = input;
//                                                })
//                                          ],
//                                          crossAxisAlignment: CrossAxisAlignment.start,
//                                        ),
//                                      ),
//                                    ),
//                                  ],
//                                ),
                                //Show Layyer
                                Visibility(
                                  visible:
                                      Ui.showHide(_fabricSettings!.showLayyer),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child:
                                                const TitleSmallBoldTextWidget(
                                                    title: 'Layyer' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _layyerKey,
                                          spanCount: 3,
                                          listOfItems: _layyerList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (FabricLayyer value) {
                                            _createRequestModel!
                                                    .fs_layyer_idfk =
                                                value.fabricLayyerId.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                //Show Weave
                                Visibility(
                                  visible:
                                      Ui.showHide(_fabricSettings!.showWeave),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child:
                                                const TitleSmallBoldTextWidget(
                                                    title: 'Weave' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _weaveKey,
                                          spanCount: 3,
                                          listOfItems: _weaveList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (FabricWeave value) {
                                            _createRequestModel!.fs_weave_idfk =
                                                value.fabricWeaveId.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Show Weave Pattern
                                Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showWeavePatternes),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Visibility(
                                          visible: true,
                                          child: Expanded(
                                            child: Column(
                                              children: [
                                                // Modified by (asad_m)
//                                              Padding(
//                                                  padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
//                                                  child: const TitleSmallTextWidget(title: 'Weave Pattern' + '*')),
                                                SizedBox(
                                                  height: 16.w,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                          YgTextFormFieldWithoutRange(
                                                              errorText:
                                                                  'Weave Pattern',
                                                              label:
                                                                  'Weave Pattern',
                                                              onSaved: (input) {
                                                                // _createRequestModel!.fs_ratio = input;
                                                                weavePatternA =
                                                                    input;
                                                              }),
                                                    ),
                                                    Container(
                                                      color: Colors.white,
                                                      width: 16.w,
                                                      child: const Center(
                                                          child: Text('/')),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          YgTextFormFieldWithoutRange(
                                                              errorText:
                                                                  'Weave Pattern',
                                                              label:
                                                                  'Weave Pattern',
                                                              onSaved: (input) {
                                                                // _createRequestModel!.fs_ratio = input;
                                                                weavePatternB =
                                                                    input;
                                                              }),
                                                    )
                                                  ],
                                                )
                                              ],
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Loom
                                Visibility(
                                  visible:
                                      Ui.showHide(_fabricSettings!.showLoom),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child:
                                                const TitleSmallBoldTextWidget(
                                                    title: 'Loom' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _loomKey,
                                          spanCount: 3,
                                          listOfItems: _loomList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (FabricLoom value) {
                                            _createRequestModel!.fs_loom_idfk =
                                                value.fabricLoomId.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Width
                                Visibility(
                                  visible:
                                      Ui.showHide(_fabricSettings!.showWidth),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 16.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Modified by (asad_m)
//                                        Padding(
//                                            padding: EdgeInsets.only(
//                                                left: 8.w,bottom: 4),
//                                            child: const TitleSmallTextWidget(
//                                                title: 'Width')),
                                        // SizedBox(height: 12.w,),
                                        YgTextFormFieldWithRange(
                                            errorText: 'Width',
                                            label: 'Width(Inches)',
                                            minMax:
                                                _fabricSettings!.widthMinMax ??
                                                    'n/a',
                                            onSaved: (input) {
                                              _createRequestModel!.fs_width =
                                                  input;
                                            }),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Nature of Fabric (asad_mehmood)
                                Visibility(
                                  visible: false,
//                                  visible: Ui.showHide(_fabricSettings!.showWeave),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child:
                                                const TitleSmallBoldTextWidget(
                                                    title: 'Nature of Fabric' +
                                                        '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _natureFabricKey,
                                          spanCount: 2,
//                                          listOfItems: _natureFabricList.where((element) =>
//                                          element.fabricFamilyIdfk == familyId)
//                                              .toList(),
                                          listOfItems:
                                              _natureFabricList.toList(),
                                          callback: (String value) {
                                            if (value == "Pure") {
                                              blendValue.clear();
                                              textFieldControllers.clear();
                                              _notifierBlendText.value = "";
                                              pureSheet(
                                                  context,
                                                  _fabricBlendsList
                                                      .where((element) =>
                                                          element.familyIdfk ==
                                                          familyId)
                                                      .toList());
                                            } else {
                                              pureValue = FabricBlends();
                                              _notifierPureText.value = "";
                                              blendedSheet(
                                                  context,
                                                  _fabricBlendsList
                                                      .where((element) =>
                                                          element.familyIdfk ==
                                                          familyId)
                                                      .toList());
                                            }
//                                            _createRequestModel!.fs_weave_idfk =
//                                                value.fabricWeaveId.toString();
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: ValueListenableBuilder(
                                                    valueListenable:
                                                        _notifierPureText,
                                                    builder: (context,
                                                        String string, child) {
                                                      return Visibility(
                                                          visible: string != ""
                                                              ? true
                                                              : false,
                                                          child: Text(
                                                            _notifierPureText
                                                                .value,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                            ),
                                                          ));
                                                    }),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: ValueListenableBuilder(
                                                    valueListenable:
                                                        _notifierBlendText,
                                                    builder: (context,
                                                        String string, child) {
                                                      return Visibility(
                                                          maintainState: false,
                                                          maintainSize: false,
                                                          visible: string != ""
                                                              ? true
                                                              : false,
                                                          child: Text(
                                                            _notifierBlendText
                                                                .value,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                            ),
                                                          ));
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                //Show Denim Types
                                Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showDenimType),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child:
                                                const TitleSmallBoldTextWidget(
                                                    title: 'Denim Type' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _denimTypeKey,
                                          spanCount: 3,
                                          listOfItems: _denimTypesList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (DenimTypes value) {
                                            _createRequestModel!
                                                    .fabric_denim_type_idfk =
                                                value.fabricDenimTypeId
                                                    .toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                //Show Salvedge
                                Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showSalvedge),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child:
                                                const TitleSmallBoldTextWidget(
                                                    title: 'Salvedge' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _salvedgeKey,
                                          spanCount: 3,
                                          listOfItems: _salvedgeList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (FabricSalvedge value) {
                                            _createRequestModel!
                                                    .fs_salvedge_idfk =
                                                value.fabricSalvedgeId
                                                    .toString();
                                            if(value.fabricSalvedgeId == 2 /*Tuckin*/){
                                            _notifierShowTuckingWidth.value = true;
                                            }else{
                                              _notifierShowTuckingWidth.value = false;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Tuckin Width
                                ValueListenableBuilder(
                                    valueListenable: _notifierShowTuckingWidth,
                                    builder: (context, bool value, child) {
                                      return Visibility(
                                        visible: Ui.showHide(
                                            _fabricSettings!.showTuckinWidth) && _notifierShowTuckingWidth.value,
                                        child: Column(
                                          children: [
                                            //Modified by (asad_m)
//                                      Padding(
//                                          padding: EdgeInsets.only(left: 4.w, top: 8.w,bottom: 4),
//                                          child: const TitleSmallTextWidget(title: 'Tuckin Width' + '*')),
                                            SizedBox(
                                              height: 18.w,
                                            ),
                                            YgTextFormFieldWithoutRange(
                                                errorText: 'Tuckin Width',
                                                label: 'Tuckin Width',
                                                onSaved: (input) {
                                                  _createRequestModel!
                                                      .fs_tuckin_width = input;
                                                })
                                          ],
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                      );
                                    }),

                                /*//Show Ply
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showPly),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 0.w,top: 4,bottom: 4),
                                            child: TitleSmallBoldTextWidget(title: ply + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _plyKey,
                                          spanCount: 3,
                                          listOfItems: _plyList.where((element) =>
                                          element.fabricFamilyIdfk == familyId)
                                              .toList(),
                                          callback: (FabricPly value) {
                                            _createRequestModel!.fs_ply_idfk =
                                                value.fabricPlyId.toString();

                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),*/

                                /*//Show Once
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showOnce),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        // Modified by (asad_m)
//                                        Padding(
//                                            padding: EdgeInsets.only(
//                                                left: 8.w,bottom: 4),
//                                            child: const TitleSmallTextWidget(
//                                                title: 'Once')),
                                        SizedBox(height:12.w ,),
                                        YgTextFormFieldWithRange(
                                            errorText: 'Once',
                                            label: 'Once',
                                            minMax: _fabricSettings!.onceMinMax??'n/a',
                                            onSaved: (input) {
                                              _createRequestModel!
                                                  .fs_once =
                                                  input;
                                            }),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show GSM
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showGsm),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [

                                        //Modified by (asad_m)
//                                        Padding(
//                                            padding: EdgeInsets.only(
//                                                left: 8.w,bottom: 4),
//                                            child: const TitleSmallTextWidget(
//                                                title: 'GSM')),
                                        SizedBox(height:12.w ,),
                                        YgTextFormFieldWithRange(
                                            errorText: 'GSM',
                                            label: 'GSM',
                                            minMax: _fabricSettings!.gsmCountMinMax??'n/a',
                                            onSaved: (input) {
                                              _createRequestModel!
                                                  .fs_gsm_count =
                                                  input;
                                            }),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),*/
                                //Show Color Treatment Method
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!
                                      .showColorTreatmentMethod),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child: TitleSmallBoldTextWidget(
                                                title: colorTreatmentMethod +
                                                    '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _colorTreatmentMethodKey,
                                          spanCount: 3,
                                          listOfItems: _colorTreatmentMethodList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (FabricColorTreatmentMethod
                                              value) {
                                            _createRequestModel!
                                                    .fs_color_treatment_method_idfk =
                                                value.fctmId.toString();

                                            if (_colorTreatmentIdList
                                                .contains(value.fctmId)) {
                                              _showDyingMethod = true;
                                              _notifier.value = true;
                                              _selectedColorTreatMethodId =
                                                  value.fctmId.toString();
                                              _createRequestModel!
                                                  .fs_dying_method_idfk = null;
                                              _createRequestModel!.fs_color = null;
                                            } else {
                                              _showDyingMethod = false;
                                              _notifier.value = false;
                                              _selectedColorTreatMethodId = null;
                                              _createRequestModel!
                                                  .fs_dying_method_idfk = null;
                                              _createRequestModel!.fs_color =
                                                  null;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Color dying Method & Color
                                ValueListenableBuilder(
                                  valueListenable: _notifier,
                                  builder: (context, bool value, child) {
                                    return Visibility(
                                      visible: /*_notifier.value*/ value,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          //Show Color dying Method
                                          Visibility(
                                            visible: true,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 0.w,
                                                          top: 4,
                                                          bottom: 4),
                                                      child:
                                                          const TitleSmallBoldTextWidget(
                                                              title:
                                                                  "Dying Method" +
                                                                      '*')),
                                                  SingleSelectTileWidget(
                                                    selectedIndex: -1,
                                                    key: _dyingMethodKey,
                                                    spanCount: 3,
                                                    listOfItems: _dyingMethodList
                                                        .where((element) =>
                                                    element.fabricFamilyIdfk == familyId && _selectedColorTreatMethodId != null ?
                                                    element.fctmIdfk == _selectedColorTreatMethodId : false)
                                                        .toList() /*_yarnData!.dyingMethod!.where((element) {
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
                                                    callback:
                                                        (FabricDyingTechniques
                                                            value) {
                                                      _createRequestModel!
                                                              .fs_dying_method_idfk =
                                                          value.fdtId
                                                              .toString();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          //Here Color Code is missing
                                          Visibility(
                                              visible: true,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0, bottom: 4),
                                                      child:
                                                          TitleSmallBoldTextWidget(
                                                              title:
                                                                  "Select Color"),
                                                    ),
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: SizedBox(
                                                        width: double.infinity,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .none,
                                                          controller:
                                                              _textEditingController,
                                                          autofocus: false,
                                                          showCursor: false,
                                                          readOnly: true,
                                                          style: TextStyle(
                                                              fontSize: 11.sp),
                                                          textAlign:
                                                              TextAlign.center,
                                                          onSaved: (input) =>
                                                              _createRequestModel!
                                                                      .fs_color =
                                                                  input!,
                                                          // validator: (input) {
                                                          //   if (input == null ||
                                                          //       input.isEmpty) {
                                                          //     return "Select Color Code";
                                                          //   }
                                                          //   return null;
                                                          // },
                                                          decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  borderSide:
                                                                      BorderSide
                                                                          .none),
                                                              contentPadding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              hintText:
                                                                  "Select Color",
                                                              filled: true,
                                                              fillColor:
                                                                  pickerColor),
                                                          onTap: () {
                                                            _openDialogBox();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                //Show Color
                                Visibility(
                                    visible:
                                        _fabricSettings!.fabricFamilyIdfk ==
                                            FABRIC_MIRCOFIBER_ID,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, bottom: 4),
                                            child: TitleSmallBoldTextWidget(
                                                title: "Color"),
                                          ),
                                          ValueListenableBuilder(
                                              valueListenable: _notifierColor,
                                              builder: (context, Color color,
                                                  child) {
                                                return Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.none,
                                                      controller:
                                                          _textEditingController,
                                                      autofocus: false,
                                                      showCursor: false,
                                                      readOnly: true,
                                                      style: TextStyle(
                                                          fontSize: 11.sp),
                                                      textAlign:
                                                          TextAlign.center,
                                                      onSaved: (input) {
                                                        if (input == null ||
                                                            input.isEmpty) {
                                                          _createRequestModel!
                                                              .fs_color = null;
                                                        } else {
                                                          _createRequestModel!
                                                              .fs_color = input;
                                                        }
                                                      },
                                                      // validator: (input) {
                                                      //   if (input == null ||
                                                      //       input.isEmpty) {
                                                      //     return "Select Color Code";
                                                      //   }
                                                      //   return null;
                                                      // },
                                                      decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                          hintText:
                                                              "Select Color",
                                                          filled: true,
                                                          fillColor: color),
                                                      onTap: () {
                                                        _openDialogBox();
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ],
                                      ),
                                    )),

                                //Show Appearance
                                Visibility(
                                  visible: Ui.showHide(
                                      _fabricSettings!.showAppearance),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child: TitleSmallBoldTextWidget(
                                                title: apperance + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _appearanceKey,
                                          spanCount: 3,
                                          listOfItems: _appearanceList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (FabricAppearance value) {
                                            _createRequestModel!
                                                    .fs_appearance_idfk =
                                                value.fabricAppearanceId
                                                    .toString();

                                            /*if (value.fabricAppearanceId == 3) {
                                              setState(() {
                                                _showDyingMethod = true;
                                                _selectedAppearenceId = value.fabricAppearanceId.toString();
                                              });
                                            } else {
                                              setState(() {
                                                _showDyingMethod = false;
                                                _createRequestModel!.fs_dying_method_idfk = null;
                                                _createRequestModel!.fs_color = null;
                                              });
                                            }*/
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Quality
                                Visibility(
                                  visible: Ui.showHide(
                                          _fabricSettings!.showQuality) &&
                                      Utils.setCottonVisibility(
                                          postFabricProvider.selectedBlends),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child: TitleSmallBoldTextWidget(
                                                title: quality + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _qualityKey,
                                          spanCount: 2,
                                          listOfItems: _qualityList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (FabricQuality value) {
                                            _createRequestModel!
                                                    .fs_quality_idfk =
                                                value.fabricQualityId
                                                    .toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Grade
                                Visibility(
                                  visible: Ui.showHide(
                                          _fabricSettings!.showGrade) &&
                                      Utils.setPolyesterVisibility(
                                          postFabricProvider.selectedBlends),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: 8.w,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child: TitleSmallBoldTextWidget(
                                                title: grades + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _gradeKey,
                                          spanCount: 3,
                                          listOfItems: _gradeList
                                              .where((element) =>
                                                  element.fabricFamilyIdfk ==
                                                  familyId)
                                              .toList(),
                                          callback: (FabricGrades value) {
                                            _createRequestModel!.fs_grade_idfk =
                                                value.fabricGradeId.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Certification
                                Visibility(
                                  visible: Ui.showHide(
                                          _fabricSettings!.showCertification) &&
                                      Utils.setCottonVisibility(
                                          postFabricProvider.selectedBlends),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 0.w, top: 4, bottom: 4),
                                            child: TitleSmallBoldTextWidget(
                                                title: certification + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _certificationKey,
                                          spanCount: 3,
                                          listOfItems: _certificationList,
                                          callback: (Certification value) {
                                            _createRequestModel!
                                                    .fs_certification_idfk =
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
                        handleNextClick();
                      },
                      color: btnColorLogin,
                      btnText: widget.businessArea == offering_type
                          ? "Next"
                          : submit,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        /*else if (snapshot.hasError) {
          return Center(
              child: TitleSmallTextWidget(title: snapshot.error.toString()));
        }*/
        else {
          return const Center(
            child: SpinKitWave(
              color: Colors.green,
              size: 24.0,
            ),
          );
        }
      },
    );
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
                //  setState(() => pickerColor = pickerColor);
                _notifierColor.value = pickerColor;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _changeColor(Color color) {
    /*setState(() {
      pickerColor = color;
      _textEditingController.text = '#${pickerColor.value.toRadixString(16)}';
    });*/
    pickerColor = color;
    _notifierColor.value = color;
    _textEditingController.text = '#${pickerColor.value.toRadixString(16)}';
  }

  void handleNextClick() {
    _createRequestModel!.spc_category_idfk = "3";
    /*_createRequestModel!.fs_blend_idfk =
    _selectedMaterial != null ? _selectedMaterial.toString() : '';*/
    if (validationAllPage()) {
      /*_createRequestModel!.spc_category_idfk = "3";
      _createRequestModel!.fs_blend_idfk = _selectedMaterial != null ? _selectedMaterial.toString():'';*/
      /* _createRequestModel!.fs_family_idfk = _fabricBlendsList
          .where((element) =>
              element.blnId == _selectedMaterial)
          .toList()
          .first
          .familyIdfk
          .toString();*/
      _createRequestModel!.fs_family_idfk = familyId ?? '';
      _createRequestModel!.fabric_weave_pattern =
          '$weavePatternA/$weavePatternB';
      /*if(_createRequestModel!.fs_ply_idfk == null){
        _createRequestModel!.fs_ply_idfk = null;
      }
      if(_createRequestModel!.fs_blend_idfk == null){
        _createRequestModel!.fs_blend_idfk = null;
      }
      if(_createRequestModel!.fs_quality_idfk == null){
        _createRequestModel!.fs_quality_idfk = null;
      }*/
      postFabricProvider.setRequestModel(_createRequestModel!);
      if (widget.businessArea == offering_type) {
        widget.callback!(1);
      } else {
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
  }

  void submitData(BuildContext context) {
    if (_createRequestModel != null) {
      /*if (widget.businessArea == yarn) {
        _createRequestModel!.fs_local_international =
            widget.locality!.toUpperCase();
      } else {
        _createRequestModel!.fs_local_international =
            widget.locality!.toUpperCase();
      }*/
      _createRequestModel!.fs_local_international =
          widget.locality!.toUpperCase();

      ProgressDialogUtil.showDialog(context, 'Please wait...');

      ApiService.createFabricSpecification(_createRequestModel!,
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
            final fabricSpecificationsProvider =
                Provider.of<FabricSpecificationsProvider>(context,
                    listen: false);
            fabricSpecificationsProvider.getUpdatedFabricSpecificationsData();
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
  }

  _resetData() {
    _showDyingMethod = false;
    _showPatternChar = false;
    _selectedSpunTechId = null;
    _selectedPatternId = null;
    _selectedColorTreatMethodId = null;
    _selectedAppearenceId = null;
    _selectedPlyId = null;
    Logger().e(_createRequestModel!.toJson().toString());
    // String? familyId = _createRequestModel!.fs_family_idfk;
    _createRequestModel = _fabricPostProvider.fabricCreateRequestModel;
    // _createRequestModel!.fs_family_idfk = familyId;
    Logger().e(_createRequestModel!.toJson().toString());
    _textEditingController.text = "";
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Blend form valiation (asad_m)
  bool validateAndSaveBlend() {
    final form = blendedFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool validationAllPage() {
    print("Model Value" + _createRequestModel!.fs_warp_ply_idfk.toString());
    if (validateAndSave()) {
      // Wrap and Wreft Check
      if (_createRequestModel!.fs_warp_count == null &&
          Ui.showHide(_fabricSettings!.showWarpCount)) {
        Ui.showSnackBar(context, 'Please Enter Warp Count');
        return false;
      } else if (_createRequestModel!.fs_warp_ply_idfk == null &&
          Ui.showHide(_fabricSettings!.showWarpPly)) {
        Ui.showSnackBar(context, 'Please Enter Warp Ply');
        return false;
      } else if (_createRequestModel!.fs_no_of_ends_warp == null &&
          Ui.showHide(_fabricSettings!.showNoOfEndsWarp)) {
        Ui.showSnackBar(context, 'Please Enter No of Ends');
        return false;
      } else if (_createRequestModel!.fs_weft_count == null &&
          Ui.showHide(_fabricSettings!.showWeftCount)) {
        Ui.showSnackBar(context, 'Please Enter Weft Count');
        return false;
      } else if (_createRequestModel!.fs_weft_ply_idfk == null &&
          Ui.showHide(_fabricSettings!.showWeftPly)) {
        Ui.showSnackBar(context, 'Please Enter Weft Ply');
        return false;
      } else if (_createRequestModel!.fs_no_of_pick_weft == null &&
          Ui.showHide(_fabricSettings!.showNoOfPickWeft)) {
        Ui.showSnackBar(context, 'Please Enter No of Picks');
        return false;
      }
      //
      /*else if (_createRequestModel!.fs_blend_idfk == null &&
          Ui.showHide(_fabricSettings!.showBlend)) {
        Ui.showSnackBar(context, 'Please Select Blend');
        return false;
      }*/
      else if (_createRequestModel!.fs_ply_idfk == null &&
          Ui.showHide(_fabricSettings!.showPly)) {
        Ui.showSnackBar(context, 'Please Select Ply');
        return false;
      } else if (_createRequestModel!.fs_color_treatment_method_idfk == null &&
          Ui.showHide(_fabricSettings!.showColorTreatmentMethod)) {
        Ui.showSnackBar(context, 'Please Select Color Treatment Method');
        return false;
      } else if (_createRequestModel!.fs_dying_method_idfk == null &&
          _showDyingMethod) {
        Ui.showSnackBar(context, 'Please Select Dying Method');
        return false;
      } else if ((_createRequestModel!.fs_color == null || _createRequestModel!.fs_color!.isEmpty) &&
          _showDyingMethod) {
        Ui.showSnackBar(context, 'Please Select Color');
        return false;
      } else if (_createRequestModel!.fs_knitting_type_idfk == null &&
          Ui.showHide(_fabricSettings!.showKnittingType)) {
        Ui.showSnackBar(context, 'Please Select Knitting Type');
        return false;
      } else if (_createRequestModel!.fs_weave_idfk == null &&
          Ui.showHide(_fabricSettings!.showWeave)) {
        Ui.showSnackBar(context, 'Please Select Weave');
        return false;
      } else if (_createRequestModel!.fabric_denim_type_idfk == null &&
          Ui.showHide(_fabricSettings!.showDenimType)) {
        Ui.showSnackBar(context, 'Please Select Denim Type');
        return false;
      } else if (_createRequestModel!.fs_loom_idfk == null &&
          Ui.showHide(_fabricSettings!.showLoom)) {
        Ui.showSnackBar(context, 'Please Select Loom');
        return false;
      } else if (_createRequestModel!.fs_layyer_idfk == null &&
          Ui.showHide(_fabricSettings!.showLayyer)) {
        Ui.showSnackBar(context, 'Please Select Layyer');
        return false;
      } else if (_createRequestModel!.fs_quality_idfk == null &&
          Ui.showHide(_fabricSettings!.showQuality) &&
          Utils.setCottonVisibility(postFabricProvider.selectedBlends)) {
        Ui.showSnackBar(context, 'Please Select Quality');
        return false;
      } else if (_createRequestModel!.fs_grade_idfk == null &&
          Ui.showHide(_fabricSettings!.showGrade) &&
          Utils.setPolyesterVisibility(postFabricProvider.selectedBlends)) {
        Ui.showSnackBar(context, 'Please Select Grade');
        return false;
      } else if (_createRequestModel!.fs_color == null &&
          _fabricSettings!.fabricFamilyIdfk == FABRIC_MIRCOFIBER_ID) {
        Ui.showSnackBar(context, 'Please Select Color');
        return false;
      } else if (_createRequestModel!.fs_appearance_idfk == null &&
          Ui.showHide(_fabricSettings!.showAppearance)) {
        Ui.showSnackBar(context, 'Please Select Appearance');
        return false;
      } else if (_createRequestModel!.fs_certification_idfk == null &&
          Ui.showHide(_fabricSettings!.showCertification) &&
          Utils.setCottonVisibility(postFabricProvider.selectedBlends)) {
        Ui.showSnackBar(context, 'Please Select Certification');
        return false;
      } else if (_createRequestModel!.fs_gsm_count == null &&
          Ui.showHide(_fabricSettings!.showGsm)) {
        Ui.showSnackBar(context, 'Please Select Gsm');
        return false;
      } else if (_createRequestModel!.fs_count == null &&
          Ui.showHide(_fabricSettings!.showCount)) {
        Ui.showSnackBar(context, 'Please Select Count');
        return false;
      } else if (_createRequestModel!.fs_once == null &&
          Ui.showHide(_fabricSettings!.showOnce)) {
        Ui.showSnackBar(context, 'Please Select Once');
        return false;
      } else {
        _createRequestModel!.spc_category_idfk = "3";
        return true;
      }
    }
    return false;
    //  return true;
  }

  void handleReadOnlyInputClick(context) {
    showBottomSheet(
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

  pureSheet(BuildContext context, List<FabricBlends> blends) {
    showModalBottomSheet<int>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
          return NatureFabricSheet(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5, top: 8),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close),
                        ),
                      )),
                  Text(
                    sheet_title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20.0.sp,
                        color: headingColor,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  PureTileWidget(
                    selectedIndex: pureValue,
                    listOfItems: blends,
                    callback: (FabricBlends value) {
                      pureValue = value;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: SizedBox(
                        width: double.infinity,
                        child: Builder(builder: (BuildContext context1) {
                          return ElevatedButton(
                              child: Text("Add",
                                  style: TextStyle(
                                      fontFamily: 'Metropolis',
                                      fontSize: 14.sp)),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          btnColorLogin),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          side: BorderSide(
                                              color: Colors.transparent)))),
                              onPressed: () {
                                if (pureValue != "") {
                                  _notifierPureText.value =
                                      pureValue.toString();
                                  Navigator.of(context).pop();
                                }
                              });
                        })),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  blendedSheet(BuildContext context, List<FabricBlends> blends) {
    values.clear();
    var result = 0.0;

    if (textFieldControllers.isEmpty) {
      for (var i = 0; i < blends.length; i++) {
        textFieldControllers.add(TextEditingController());
      }
    }

    showModalBottomSheet<int>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return NatureFabricSheet(
            child: SingleChildScrollView(
              child: Form(
                key: blendedFormKey,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5, top: 8),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close),
                          ),
                        )),
                    Text(
                      sheet_title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20.0.sp,
                          color: headingColor,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlendedTileWidget(
                      selectedIndex: blendValue,
                      listOfItems: blends,
                      listController: textFieldControllers,
                      blendsValue: values,
                      callback: (List<FabricBlends> value) {
                        blendValue = value;
                      },
                      textFieldcallback: (List<BlendModel> value) {
                        values = value;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: SizedBox(
                          width: double.infinity,
                          child: Builder(builder: (BuildContext context1) {
                            return ElevatedButton(
                                child: Text("Add",
                                    style: TextStyle(
                                        fontFamily: 'Metropolis',
                                        fontSize: 14.sp)),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            btnColorLogin),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            side: BorderSide(
                                                color: Colors.transparent)))),
                                onPressed: () {
                                  if (validateAndSaveBlend()) {
                                    blendString = "";
                                    for (int i = 0; i < values.length; i++) {
                                      blendString += values[i].id.toString() +
                                          "(" +
                                          values[i].ratio.toString() +
                                          "),";

                                      result +=
                                          int.parse(values[i].ratio.toString());
                                    }
                                    if (blendString.toString() != "") {
                                      print(
                                          "Percent(%):\t" + result.toString());
                                      if (result > 100) {
                                        result = 0.0;
                                        values.clear();

                                        Fluttertoast.showToast(
                                            msg: blend_message,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1);
                                      } else {
                                        if (blendString.endsWith(",")) {
                                          blendString = blendString.substring(
                                              0, blendString.length - 1);
                                        }
                                        _notifierBlendText.value =
                                            blendString.toString();

                                        Navigator.of(context).pop();
                                      }
                                    }
                                  }
                                });
                          })),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  String? getPlyList(FabricCreateRequestModel createRequestModel) {
    List<String?> list = [];
    list.add(createRequestModel.fs_count);
    if (_createRequestModel!.fs_ply_idfk != null) {
      list.add(_plyList
          .where((element) =>
              element.fabricPlyId.toString() == createRequestModel.fs_ply_idfk)
          .toList()
          .first
          .fabricPlyName);
    }
    list.add(createRequestModel.fs_gsm_count);
    list.add(createRequestModel.fs_once);
    var responseString = Utils.createStringFromList(list);
    if (responseString.isNotEmpty) {
      return Utils.createStringFromList(list);
    } else {
      return '';
    }
  }

  String? getWarpList(FabricCreateRequestModel createRequestModel) {
    List<String?> list = [];
    list.add(createRequestModel.fs_warp_count);
    // list.add(createRequestModel.fs_warp_ply_idfk);
    if (_createRequestModel!.fs_warp_ply_idfk != null) {
      list.add(_plyList
          .where((element) =>
              element.fabricPlyId.toString() ==
              createRequestModel.fs_warp_ply_idfk)
          .toList()
          .first
          .fabricPlyName);
    }
    list.add(createRequestModel.fs_no_of_ends_warp);
    var responseString = Utils.createStringFromList(list);
    if (responseString.isNotEmpty) {
      return '${Utils.createStringFromList(list)}';
    } else {
      return '';
    }
  }

  String? getWeftList(FabricCreateRequestModel createRequestModel) {
    List<String?> list = [];
    list.add(createRequestModel.fs_weft_count);
    // list.add(createRequestModel.fs_weft_ply_idfk);
    if (_createRequestModel!.fs_weft_ply_idfk != null) {
      list.add(_plyList
          .where((element) =>
              element.fabricPlyId.toString() ==
              createRequestModel.fs_weft_ply_idfk)
          .toList()
          .first
          .fabricPlyName);
    }
    list.add(createRequestModel.fs_no_of_pick_weft);
    var responseString = Utils.createStringFromList(list);
    if (responseString.isNotEmpty) {
      return Utils.createStringFromList(list);
    } else {
      return '';
    }
  }

}
