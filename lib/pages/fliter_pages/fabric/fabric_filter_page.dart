import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';

import '../../../../model/response/fabric_response/sync/fabric_sync_response.dart';
import '../../../providers/fabric_providers/filter_fabric_provider.dart';
import '../../../elements/elevated_button_widget_2.dart';
import '../../../elements/list_widgets/cat_with_image_listview_widget.dart';
import '../../../elements/list_widgets/single_select_tile_renewed_widget.dart';
import '../../../model/request/filter_request/fabric_filter_request.dart';

class FabricFilterPage extends StatefulWidget {
  const FabricFilterPage({
    Key? key,
  }) : super(key: key);

  @override
  FabricFilterPageState createState() => FabricFilterPageState();
}

class FabricFilterPageState extends State<FabricFilterPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int? _selectedMaterial;
  String? familyId;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  FabricSetting? _fabricSettings;
  FabricSpecificationRequestModel? _filterRequestModel;

  late FilterFabricProvider filterFabricProvider;

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

  Color pickerColor = const Color(0xffffffff);
  String? _selectedPlyId;
  bool _showDyingMethod = false;
  bool _showPatternChar = false;

  String? _selectedPatternId;
  String? _selectedAppearenceId;
  String? _selectedColorTreatMethodId;
  String? _selectedSpunTechId;

  final List<int> _colorTreatmentIdList = [3, 5, 8, 11, 13];
  //String? _selectedNature;
  final GlobalKey<BlendsWithImageListWidgetState> _catWithImageListState = GlobalKey<BlendsWithImageListWidgetState>();

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

  _getFabricSyncedData(FilterFabricProvider filterFabricProvider) async {
    AppDbInstance().getFabricBlendsData().then((value) => setState(() {
          _fabricBlendsList = value;
          _selectedMaterial = value
              .where((element) =>
                  element.familyIdfk ==
                  filterFabricProvider.firstFamilyId.toString())
              .toList()
              .first
              .blnId;
          filterFabricProvider.setBlendId(_selectedMaterial!);
          familyId = _fabricBlendsList
              .where((element) => element.blnId == filterFabricProvider.blendId)
              .first
              .familyIdfk;
    }));
    var dbInstance = await AppDbInstance().getDbInstance();
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
   // _selectedNature = /*"1"*/_fabricFamilyList.first.fabricFamilyId.toString();
    AppDbInstance().getFiberBrandsData()
        .then((value) => setState(() => _brands = value));
    AppDbInstance().getOriginsData()
        .then((value) => setState(() => _countries = value));
    AppDbInstance().getCityState()
        .then((value) => setState(() => _citySateList = value));
    AppDbInstance().getCertificationsData()
        .then((value) => setState(() => _certificationList = value));
  }

  final ValueNotifier<bool> _notifier = ValueNotifier(false);
  final ValueNotifier<Color> _notifierColor =
      ValueNotifier(const Color(0xffffffff));

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _filterRequestModel = FabricSpecificationRequestModel();
    _resetData();
    final filterFabricProvider =
        Provider.of<FilterFabricProvider>(context, listen: false);
    filterFabricProvider.getSyncData();
    _getFabricSyncedData(filterFabricProvider);
    super.initState();
  }

  @override
  void dispose() {
    _notifier.dispose();
    _notifierColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    filterFabricProvider = Provider.of<FilterFabricProvider>(context);
    if (filterFabricProvider.blendId != null) {
      _selectedMaterial = filterFabricProvider.blendId;
      // _filterRequestModel = Provider.of<CreateRequestModel?>(context);
      familyId = _fabricBlendsList
          .where((element) => element.blnId == filterFabricProvider.blendId)
          .first
          .familyIdfk;
    } else {
      _selectedMaterial = null;
      // _filterRequestModel = Provider.of<CreateRequestModel?>(context);
      familyId = FABRIC_MIRCOFIBER_ID /*Microfiber*/;
    }
    return FutureBuilder<List<FabricSetting>>(
      future: filterFabricProvider.getFabricSettingsData(familyId!),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              _resetData();
              ApiService.logger.e(_filterRequestModel!.toJson());
              _fabricSettings = /*snapshot.data![0]*/
                  filterFabricProvider.fabricSetting!.first;
            }
          }
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            key: scaffoldKey,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.only(top: 8.w, left: 16.w, right: 16.w),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 16.w, /*left: 16.w,*/ right: 16.w, bottom: 16.w),
                                child: const TitleTextWidget(
                                  title: 'Fabric Family',
                                )),
                            SizedBox(
                              height: 0.04 * MediaQuery.of(context).size.height,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: SingleSelectTileRenewedWidget(
                                    spanCount: 4,
                                    selectedIndex: _fabricFamilyList.indexWhere((element) => familyId == element.fabricFamilyId.toString()),
                                    callback: (FabricFamily value) {
                                      setState(() {
                                        familyId = value.fabricFamilyId.toString();
                                        Logger().e(familyId);
                                      });
                                      if(familyId != FABRIC_MIRCOFIBER_ID/*Microfiber*/){
                                        var blend = _fabricBlendsList
                                            .where((element) =>
                                        element.familyIdfk == value.fabricFamilyId.toString())
                                            .toList().first
                                            .blnId;
                                        Logger().e(blend);
                                        //  if(blend!=null){
                                        filterFabricProvider.setBlendId(blend);
                                        //   }
                                        _catWithImageListState.currentState!.checkedIndex = 0;
                                      }else{
                                        filterFabricProvider.setBlendId(null);
                                      }
                                    },
                                    listOfItems: _fabricFamilyList),
                              ),
                            )
                          ],
                        ),
                        Visibility(
                          visible: familyId != FABRIC_MIRCOFIBER_ID,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 16.w, /*left: 16.w,*/ right: 16.w, bottom: 16.w),
                                  child: const TitleTextWidget(
                                    title: 'Fabric Blends',
                                  )),
                              BlendsWithImageListWidget(
                                key: _catWithImageListState,
                                selectedItem: _fabricBlendsList.indexWhere((element) => element.blnId == _selectedMaterial),
                                listItem: _fabricBlendsList
                                    .where((element) => element.familyIdfk == familyId)
                                    .toList(),
                                onClickCallback: (index) {
                                  var blend = _fabricBlendsList.where((element) => element.familyIdfk == familyId).toList()[index].blnId;
                                  _selectedMaterial = blend;
                                  Logger().e(blend);
                                  // filterFabricProvider.setBlendId(blend);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 8.w, left: 16.w, right: 16.w),
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
                                  //Show Ratio and Count
                                  /*Row(
                                    children: [
                                      Visibility(
                                        visible: Ui.showHide(
                                            _fabricSettings!.showRatio),
                                        child: Expanded(
                                          child: Column(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w, top: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: ratio + '*')),
                                              YgTextFormFieldWithoutRange(
                                                  errorText: ratio,
                                                  onSaved: (input) {
                                                    _filterRequestModel!
                                                        .rat = input;
                                                  })
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (Ui.showHide(
                                                    _fabricSettings!.showRatio) &&
                                                Ui.showHide(
                                                    _fabricSettings!.showCount))
                                            ? 16.w
                                            : 0,
                                      ),
                                      Visibility(
                                        visible: Ui.showHide(
                                            _fabricSettings!.showCount),
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w, top: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: count + '*')),
                                              YgTextFormFieldWithRangeNonDecimal(
                                                  errorText: count,
                                                  // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                  minMax: _fabricSettings!
                                                      .countMinMax!,
                                                  onSaved: (input) {
                                                    _filterRequestModel!
                                                        .fs_count = input;
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),*/
                                  //Show Warp count and No of Ends
                                  /*Row(
                                    children: [
                                      Visibility(
                                        visible: Ui.showHide(
                                            _fabricSettings!.showWarpCount),
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w, top: 8.w),
                                                  child:
                                                      const TitleSmallTextWidget(
                                                          title: 'Warp Count' +
                                                              '*')),
                                              YgTextFormFieldWithRangeNonDecimal(
                                                  errorText: 'Warp Count',
                                                  // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                  minMax: _fabricSettings!
                                                          .warpCountMinMax ??
                                                      'n/a',
                                                  onSaved: (input) {
                                                    _filterRequestModel!
                                                        .fs_warp_count = input;
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (Ui.showHide(
                                                    _fabricSettings!.showRatio) &&
                                                Ui.showHide(
                                                    _fabricSettings!.showCount))
                                            ? 16.w
                                            : 0,
                                      ),
                                      Visibility(
                                        visible: Ui.showHide(
                                            _fabricSettings!.showNoOfEndsWarp),
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w, top: 8.w),
                                                  child:
                                                      const TitleSmallTextWidget(
                                                          title: 'No of Ends' +
                                                              '*')),
                                              YgTextFormFieldWithRangeNonDecimal(
                                                  errorText: 'No of Ends',
                                                  // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                  minMax: _fabricSettings!
                                                          .noOfEndsWarpMinMax ??
                                                      'n/a',
                                                  onSaved: (input) {
                                                    _filterRequestModel!
                                                            .fs_no_of_ends_warp =
                                                        input;
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),*/
                                  //Show Weft count and No of Picks
                                  /*Row(
                                    children: [
                                      Visibility(
                                        visible: Ui.showHide(
                                            _fabricSettings!.showWeftCount),
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w, top: 8.w),
                                                  child:
                                                      const TitleSmallTextWidget(
                                                          title: 'Weft Count' +
                                                              '*')),
                                              YgTextFormFieldWithRangeNonDecimal(
                                                  errorText: 'Weft Count',
                                                  // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                  minMax: _fabricSettings!
                                                          .weftCountMinMax ??
                                                      'n/a',
                                                  onSaved: (input) {
                                                    _filterRequestModel!
                                                        .fs_weft_count = input;
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (Ui.showHide(
                                                    _fabricSettings!.showRatio) &&
                                                Ui.showHide(
                                                    _fabricSettings!.showCount))
                                            ? 16.w
                                            : 0,
                                      ),
                                      Visibility(
                                        visible: Ui.showHide(
                                            _fabricSettings!.showNoOfPickWeft),
                                        child: Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4.w, top: 8.w),
                                                  child:
                                                      const TitleSmallTextWidget(
                                                          title: 'No of Picks' +
                                                              '*')),
                                              YgTextFormFieldWithRangeNonDecimal(
                                                  errorText: 'No of Picks',
                                                  // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                  minMax: _fabricSettings!
                                                          .noOfPickWeftMinMax ??
                                                      'n/a',
                                                  onSaved: (input) {
                                                    _filterRequestModel!
                                                            .fs_no_of_pick_weft =
                                                        input;
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),*/
                                  //Show Warp Ply and Weft ply
                                  Row(
                                    children: [
                                      Visibility(
                                        visible: Ui.showHide(
                                            _fabricSettings!.showWarpPly),
                                        child: Expanded(
                                          child: Column(
                                            children: [
                                              // modified by (asad_m)

//                                              Padding(
//                                                  padding: EdgeInsets.only(
//                                                      left: 4.w, top: 8.w),
//                                                  child:
//                                                      const TitleSmallTextWidget(
//                                                          title:
//                                                              'Warp Ply' + '*')),

                                              YgTextFormFieldWithoutRange(
                                                  errorText: 'Warp Ply',
                                                  label: 'Warp Ply',
                                                  onSaved: (input) {
                                                    _filterRequestModel!
                                                        .fs_warp_ply_idfk = input;
                                                  })
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: (Ui.showHide(
                                                    _fabricSettings!.showRatio) &&
                                                Ui.showHide(
                                                    _fabricSettings!.showCount))
                                            ? 16.w
                                            : 0,
                                      ),
                                      Visibility(
                                        visible: Ui.showHide(
                                            _fabricSettings!.showWarpPly),
                                        child: Expanded(
                                          child: Column(
                                            children: [
                                              //Modified by (asad_m)
//                                              Padding(
//                                                  padding: EdgeInsets.only(
//                                                      left: 4.w, top: 8.w),
//                                                  child:
//                                                      const TitleSmallTextWidget(
//                                                          title:
//                                                              'Weft Ply' + '*')),
                                              YgTextFormFieldWithoutRange(
                                                  errorText: 'Weft Ply',
                                                  label: 'Weft Ply',
                                                  onSaved: (input) {
                                                    _filterRequestModel!
                                                        .fs_weft_ply_idfk = input;
                                                  })
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Width
                                  /*Visibility(
                                    visible:
                                        Ui.showHide(_fabricSettings!.showWidth),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: const TitleSmallTextWidget(
                                                  title: 'Width')),
                                          YgTextFormFieldWithRange(
                                              errorText: 'Width',
                                              minMax:
                                                  _fabricSettings!.widthMinMax ??
                                                      'n/a',
                                              onSaved: (input) {
                                                _filterRequestModel!.fs_width =
                                                    input;
                                              }),
                                          SizedBox(
                                            width: 16.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),*/
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
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: const TitleSmallTextWidget(
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
                                              _filterRequestModel!.fs_weave_idfk = [value.fabricWeaveId!];
                                            },
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
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: const TitleSmallTextWidget(
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
                                              _filterRequestModel!.fs_loom_idfk = [value.fabricLoomId!];
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
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: const TitleSmallTextWidget(
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
                                              _filterRequestModel!.fs_salvedge_idfk = [value.fabricSalvedgeId!];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //Show Tuckin Width
                                  /*Visibility(
                                    visible: Ui.showHide(
                                        _fabricSettings!.showTuckinWidth),
                                    child: Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 4.w, top: 8.w),
                                            child: const TitleSmallTextWidget(
                                                title: 'Tuckin Width' + '*')),
                                        YgTextFormFieldWithoutRange(
                                            errorText: 'Tuckin Width',
                                            onSaved: (input) {
                                              _filterRequestModel!
                                                  .fs_tuckin_width = input;
                                            })
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),*/
                                  //Show Ply
                                  Visibility(
                                    visible:
                                        Ui.showHide(_fabricSettings!.showPly),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
                                                  title: ply + '*')),
                                          SingleSelectTileWidget(
                                            selectedIndex: -1,
                                            key: _plyKey,
                                            spanCount: 3,
                                            listOfItems: _plyList
                                                .where((element) =>
                                                    element.fabricFamilyIdfk ==
                                                    familyId)
                                                .toList(),
                                            callback: (FabricPly value) {
                                              _filterRequestModel!.fs_ply_idfk = [value.fabricPlyId!];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: const TitleSmallTextWidget(
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
                                              _filterRequestModel!.fs_layyer_idfk = [value.fabricLayyerId!];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //Show Once
                                  /*Visibility(
                                    visible:
                                        Ui.showHide(_fabricSettings!.showOnce),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: const TitleSmallTextWidget(
                                                  title: 'Once')),
                                          YgTextFormFieldWithRange(
                                              errorText: 'Once',
                                              minMax:
                                                  _fabricSettings!.onceMinMax ??
                                                      'n/a',
                                              onSaved: (input) {
                                                _filterRequestModel!.fs_once =
                                                    input;
                                              }),
                                          SizedBox(
                                            width: 16.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),*/
                                  //Show GSM
                                  /*Visibility(
                                    visible:
                                        Ui.showHide(_fabricSettings!.showGsm),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: const TitleSmallTextWidget(
                                                  title: 'GSM')),
                                          YgTextFormFieldWithRange(
                                              errorText: 'GSM',
                                              minMax: _fabricSettings!
                                                      .gsmCountMinMax ??
                                                  'n/a',
                                              onSaved: (input) {
                                                _filterRequestModel!
                                                    .fs_gsm_count = input;
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
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
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
                                              _filterRequestModel!.fs_fctm_idfk = [value.fctmId!];

                                              if (_colorTreatmentIdList
                                                  .contains(value.fctmId)) {
                                                _showDyingMethod = true;
                                                _notifier.value = true;
                                                _selectedColorTreatMethodId =
                                                    value.fctmId.toString();
                                              } else {
                                                _showDyingMethod = false;
                                                _notifier.value = false;
                                                _filterRequestModel!
                                                    .fs_fdt_idfk = null;
                                                /*_filterRequestModel!.fs_color =
                                                    null;*/
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
                                                            left: 8.w),
                                                        child:
                                                            const TitleSmallTextWidget(
                                                                title:
                                                                    "Dying Method" +
                                                                        '*')),
                                                    SingleSelectTileWidget(
                                                      selectedIndex: -1,
                                                      key: _dyingMethodKey,
                                                      spanCount: 3,
                                                      listOfItems: _dyingMethodList
                                                          .where((element) =>
                                                              element
                                                                  .fabricFamilyIdfk ==
                                                              familyId)
                                                          .toList() /*_yarnData!.dyingMethod!.where((element) {
                                        if (element.ydmColorTreatmentMethodIdfk != _selectedColorTreatMethodId) {
                                          return element
                                                  .ydmColorTreatmentMethodIdfk ==
                                              _filterRequestModel
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
                                                            _filterRequestModel!.fs_fdt_idfk = [value.fdtId!];
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            //Here Color Code is missing
                                            /*Visibility(
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
                                                            left: 8.0),
                                                        child: TitleSmallTextWidget(
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
                                                          width: 120.w,
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
                                                                _filterRequestModel!
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
                                                )),*/
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  //Show Color
                                  /*Visibility(
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
                                              padding: EdgeInsets.only(left: 8.0),
                                              child: TitleSmallTextWidget(
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
                                                      width: 120.w,
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
                                                            _filterRequestModel!
                                                                .fs_color = null;
                                                          } else {
                                                            _filterRequestModel!
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
                                      )),*/
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
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: const TitleSmallTextWidget(
                                                  title: 'Knitting Type' + '*')),
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
                                              _filterRequestModel!.fs_knitting_type_idfk = [value.fabricKnittingTypeId!];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
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
                                              _filterRequestModel!.fs_appearance_idfk = [value.fabricAppearanceId!];

                                              /*if (value.fabricAppearanceId == 3) {
                                                setState(() {
                                                  _showDyingMethod = true;
                                                  _selectedAppearenceId = value.fabricAppearanceId.toString();
                                                });
                                              } else {
                                                setState(() {
                                                  _showDyingMethod = false;
                                                  _filterRequestModel!.fs_dying_method_idfk = null;
                                                  _filterRequestModel!.fs_color = null;
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
                                    visible:
                                        Ui.showHide(_fabricSettings!.showQuality),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
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
                                              _filterRequestModel!.fs_quality_idfk = [value.fabricQualityId!];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //Show Grade
                                  Visibility(
                                    visible:
                                        Ui.showHide(_fabricSettings!.showGrade),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.w, bottom: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
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
                                              _filterRequestModel!.fs_grade_idfk = [value.fabricGradeId!];
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //Show Certification
                                  Visibility(
                                    visible: Ui.showHide(
                                        _fabricSettings!.showCertification),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
                                                  title: certification + '*')),
                                          SingleSelectTileWidget(
                                            selectedIndex: -1,
                                            key: _certificationKey,
                                            spanCount: 3,
                                            listOfItems: _certificationList,
                                            callback: (Certification value) {
                                              _filterRequestModel!.certification_id = [value.cerId];
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButtonWithoutIcon(
                            btnText: "Reset",
                            textSize: 12.sp,
                            color: Colors.grey.shade300,
                            textColor: 'black',
                            callback: () {
                              resetFilters();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Expanded(
                          child: ElevatedButtonWithoutIcon(
                            btnText: "Apply Filter",
                            textSize: 12.sp,
                            color: Colors.green,
                            callback: () {
                              handleFilterClick();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        /*else if (snapshot.hasError) {
          return Center(
              child: TitleSmallTextWidget(title: snapshot.error.toString()));
        }*/
        else {
          return Center(
            child: Container(
              color: Colors.white,
              child: const SpinKitWave(
                color: Colors.green,
                size: 24.0,
              ),
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

  void handleFilterClick() async {
    _filterRequestModel!.category_id = "3";
    var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
   // _filterRequestModel!.user_id = userId;
    var selectedFamilyId = -1;
    if(_selectedMaterial != null){
      _filterRequestModel!.fs_blend_idfk = [_selectedMaterial!];
    }
    if(familyId != null){
      _filterRequestModel!.fs_family_idfk = [int.parse(familyId!)];
    }
    Navigator.pop(context, _filterRequestModel);
  }

  _resetData() {
    _showDyingMethod = false;
    _showPatternChar = false;
    _selectedSpunTechId = null;
    _selectedPatternId = null;
    _selectedColorTreatMethodId = null;
    _selectedAppearenceId = null;
    _selectedPlyId = null;
    Logger().e(_filterRequestModel!.toJson().toString());
    _filterRequestModel = FabricSpecificationRequestModel();
    Logger().e(_filterRequestModel!.toJson().toString());
    _textEditingController.text = "";
  }

  void resetFilters() {
    setState(() {
      _resetData();
    });
  }
}
