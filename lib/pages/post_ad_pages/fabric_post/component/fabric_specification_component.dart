
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
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
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

import '../../../../Providers/post_fabric_provider.dart';
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
  FabricSpecificationComponentState createState() => FabricSpecificationComponentState();
}

class FabricSpecificationComponentState
    extends State<FabricSpecificationComponent>
    with AutomaticKeepAliveClientMixin {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
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

  Color pickerColor = const Color(0xffffffff);
  String? _selectedPlyId;
  bool _showDyingMethod = false;
  bool _showPatternChar = false;

  String? _selectedPatternId;
  String? _selectedAppearenceId;
  String? _selectedColorTreatMethodId;
  String? _selectedSpunTechId;

  final List<int> _colorTreatmentIdList = [3, 5, 8, 11, 13];


  final GlobalKey<SingleSelectTileWidgetState> _plyKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _knittingTypeKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _appearanceKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _colorTreatmentMethodKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _qualityKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _gradeKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _certificationKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _dyingMethodKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _weaveKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _loomKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _salvedgeKey = GlobalKey<SingleSelectTileWidgetState>();
  final GlobalKey<SingleSelectTileWidgetState> _layyerKey = GlobalKey<SingleSelectTileWidgetState>();


  _getFabricSyncedData(PostFabricProvider postFabricProvider)async {
    AppDbInstance.getFabricBlendsData().then((value) => setState(() {
          _fabricBlendsList = value;
          _selectedMaterial = value
              .where((element) => element.familyIdfk == postFabricProvider.firstFamilyId.toString())
              .toList()
              .first
              .blnId;
          postFabricProvider.setBlendId(_selectedMaterial!);
          familyId = _fabricBlendsList.where((element) => element.blnId == postFabricProvider.blendId).first.familyIdfk;
        }));
    var dbInstance = await AppDbInstance.getDbInstance();
    _fabricFamilyList = await dbInstance.fabricFamilyDao.findAllFabricFamily();
    _fabricAppearanceList = await dbInstance.fabricAppearanceDao.findAllFabricAppearance();
    _fabricGradesList = await dbInstance.fabricGradesDao.findAllFabricGrade();
    _plyList = await dbInstance.fabricPlyDao.findAllFabricPly();
    _knittingTypeList = await dbInstance.knittingTypesDao.findAllKnittingTypes();
    _appearanceList = await dbInstance.fabricAppearanceDao.findAllFabricAppearance();
    _colorTreatmentMethodList = await dbInstance.fabricColorTreatmentMethodDao.findAllFabricColorTreatmentMethod();
    _qualityList = await dbInstance.fabricQualityDao.findAllFabricQuality();
    _gradeList = await dbInstance.fabricGradesDao.findAllFabricGrade();
    _dyingMethodList = await dbInstance.fabricDyingTechniqueDao.findAllFabricDyingTechniques();
    _weaveList = await dbInstance.fabricWeaveDao.findAllFabricWeave();
    _loomList = await dbInstance.fabricLoomDao.findAllFabricLoom();
    _salvedgeList = await dbInstance.fabricSalvedgeDao.findAllFabricSalvedge();
    _layyerList = await dbInstance.fabricLayyerDao.findAllFabricLayyer();
    AppDbInstance.getFiberBrandsData()
        .then((value) => setState(() => _brands = value));
    AppDbInstance.getOriginsData()
        .then((value) => setState(() => _countries = value));
    AppDbInstance.getCityState()
        .then((value) => setState(() => _citySateList = value));
    AppDbInstance.getCertificationsData()
        .then((value) => setState(() => _certificationList = value));
  }

  final ValueNotifier<bool> _notifier = ValueNotifier(false);
  final ValueNotifier<Color> _notifierColor = ValueNotifier(const Color(0xffffffff));

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _createRequestModel = FabricCreateRequestModel();
    _resetData();
    final postFabricProvider =
    Provider.of<PostFabricProvider>(context, listen: false);
    _getFabricSyncedData(postFabricProvider);
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
    postFabricProvider = Provider.of<PostFabricProvider>(context);
    if(postFabricProvider.blendId != null){
      _selectedMaterial = postFabricProvider.blendId;
      // _createRequestModel = Provider.of<CreateRequestModel?>(context);
      familyId = _fabricBlendsList.where((element) => element.blnId == postFabricProvider.blendId).first.familyIdfk;
    }else{
      _selectedMaterial = null;
      // _createRequestModel = Provider.of<CreateRequestModel?>(context);
      familyId = FABRIC_MIRCOFIBER_ID/*Microfiber*/;
    }
    return FutureBuilder<List<FabricSetting>>(
      future: postFabricProvider.getFabricSettingsData(familyId!),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data!= null) {
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
                    padding:
                        EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
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
                                Row(
                                  children: [
                                    Visibility(
                                      visible: Ui.showHide(_fabricSettings!.showRatio),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
                                                child: TitleSmallTextWidget(title: ratio + '*')),
                                            YgTextFormFieldWithoutRange(
                                                errorText: ratio,
                                                onSaved: (input) {
                                                  _createRequestModel!.fs_ratio = input;
                                                })
                                          ],
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (Ui.showHide(_fabricSettings!.showRatio) &&
                                          Ui.showHide(_fabricSettings!.showCount))
                                          ? 16.w
                                          : 0,
                                    ),
                                    Visibility(
                                      visible: Ui.showHide(_fabricSettings!.showCount),
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
                                                child: TitleSmallTextWidget(title: count + '*')),
                                            YgTextFormFieldWithRangeNonDecimal(
                                                errorText: count,
                                                // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                minMax: _fabricSettings!.countMinMax!,
                                                onSaved: (input) {
                                                  _createRequestModel!.fs_count = input;
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Show Warp count and No of Ends
                                Row(
                                  children: [
                                    Visibility(
                                      visible: Ui.showHide(_fabricSettings!.showWarpCount),
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
                                                child: const TitleSmallTextWidget(title: 'Warp Count' + '*')),
                                            YgTextFormFieldWithRangeNonDecimal(
                                                errorText: 'Warp Count',
                                                // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                minMax: _fabricSettings!.warpCountMinMax??'n/a',
                                                onSaved: (input) {
                                                  _createRequestModel!.fs_warp_count = input;
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (Ui.showHide(_fabricSettings!.showRatio) &&
                                          Ui.showHide(_fabricSettings!.showCount))
                                          ? 16.w
                                          : 0,
                                    ),
                                    Visibility(
                                      visible: Ui.showHide(_fabricSettings!.showNoOfEndsWarp),
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
                                                child: const TitleSmallTextWidget(title: 'No of Ends' + '*')),
                                            YgTextFormFieldWithRangeNonDecimal(
                                                errorText: 'No of Ends',
                                                // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                minMax: _fabricSettings!.noOfEndsWarpMinMax??'n/a',
                                                onSaved: (input) {
                                                  _createRequestModel!.fs_no_of_ends_warp = input;
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Show Weft count and No of Picks
                                Row(
                                  children: [
                                    Visibility(
                                      visible: Ui.showHide(_fabricSettings!.showWeftCount),
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
                                                child: const TitleSmallTextWidget(title: 'Weft Count' + '*')),
                                            YgTextFormFieldWithRangeNonDecimal(
                                                errorText: 'Weft Count',
                                                // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                minMax: _fabricSettings!.weftCountMinMax??'n/a',
                                                onSaved: (input) {
                                                  _createRequestModel!.fs_weft_count = input;
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (Ui.showHide(_fabricSettings!.showRatio) &&
                                          Ui.showHide(_fabricSettings!.showCount))
                                          ? 16.w
                                          : 0,
                                    ),
                                    Visibility(
                                      visible: Ui.showHide(_fabricSettings!.showNoOfPickWeft),
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
                                                child: const TitleSmallTextWidget(title: 'No of Picks' + '*')),
                                            YgTextFormFieldWithRangeNonDecimal(
                                                errorText: 'No of Picks',
                                                // onChanged:(value) => globalFormKey.currentState!.reset(),
                                                minMax: _fabricSettings!.noOfPickWeftMinMax??'n/a',
                                                onSaved: (input) {
                                                  _createRequestModel!.fs_no_of_pick_weft = input;
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //Show Warp Ply and Weft ply
                                Row(
                                  children: [
                                    Visibility(
                                      visible: Ui.showHide(_fabricSettings!.showWarpPly),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
                                                child: const TitleSmallTextWidget(title: 'Warp Ply' + '*')),
                                            YgTextFormFieldWithoutRange(
                                                errorText: 'Warp Ply',
                                                onSaved: (input) {
                                                  _createRequestModel!.fs_warp_ply_idfk = input;
                                                })
                                          ],
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (Ui.showHide(_fabricSettings!.showRatio) &&
                                          Ui.showHide(_fabricSettings!.showCount))
                                          ? 16.w
                                          : 0,
                                    ),
                                    Visibility(
                                      visible: Ui.showHide(_fabricSettings!.showWarpPly),
                                      child: Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left: 4.w, top: 8.w),
                                                child: const TitleSmallTextWidget(title: 'Weft Ply' + '*')),
                                            YgTextFormFieldWithoutRange(
                                                errorText: 'Weft Ply',
                                                onSaved: (input) {
                                                  _createRequestModel!.fs_weft_ply_idfk = input;
                                                })
                                          ],
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Width
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showWidth),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.w),
                                            child: const TitleSmallTextWidget(
                                                title: 'Width')),

                                        YgTextFormFieldWithRange(
                                            errorText: 'Width',
                                            minMax: _fabricSettings!.widthMinMax??'n/a',
                                            onSaved: (input) {
                                              _createRequestModel!
                                                  .fs_width =
                                                  input;
                                            }),
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Weave
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showWeave),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: const TitleSmallTextWidget(title: 'Weave' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _weaveKey,
                                          spanCount: 4,
                                          listOfItems: _weaveList.where((element) =>
                                          element.fabricFamilyIdfk == familyId)
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
                                //Show Loom
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showLoom),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: const TitleSmallTextWidget(title: 'Loom' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _loomKey,
                                          spanCount: 4,
                                          listOfItems: _loomList.where((element) =>
                                          element.fabricFamilyIdfk == familyId)
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
                                //Show Salvedge
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showSalvedge),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: const TitleSmallTextWidget(title: 'Salvedge' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _salvedgeKey,
                                          spanCount: 4,
                                          listOfItems: _salvedgeList.where((element) =>
                                          element.fabricFamilyIdfk == familyId)
                                              .toList(),
                                          callback: (FabricSalvedge value) {
                                            _createRequestModel!.fs_salvedge_idfk =
                                                value.fabricSalvedgeId.toString();

                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Tuckin Width
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showTuckinWidth),
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 4.w, top: 8.w),
                                          child: const TitleSmallTextWidget(title: 'Tuckin Width' + '*')),
                                      YgTextFormFieldWithoutRange(
                                          errorText: 'Tuckin Width',
                                          onSaved: (input) {
                                            _createRequestModel!.fs_tuckin_width = input;
                                          })
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ),
                                //Show Ply
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showPly),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(title: ply + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _plyKey,
                                          spanCount: 4,
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
                                ),
                                //Show Layyer
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showLayyer),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: const TitleSmallTextWidget(title: 'Layyer' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _layyerKey,
                                          spanCount: 4,
                                          listOfItems: _layyerList.where((element) =>
                                          element.fabricFamilyIdfk == familyId)
                                              .toList(),
                                          callback: (FabricLayyer value) {
                                            _createRequestModel!.fs_layyer_idfk =
                                                value.fabricLayyerId.toString();

                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Once
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showOnce),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.w),
                                            child: const TitleSmallTextWidget(
                                                title: 'Once')),

                                        YgTextFormFieldWithRange(
                                            errorText: 'Once',
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
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.w),
                                            child: const TitleSmallTextWidget(
                                                title: 'GSM')),

                                        YgTextFormFieldWithRange(
                                            errorText: 'GSM',
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
                                ),
                                //Show Color Treatment Method
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showColorTreatmentMethod),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(
                                                title: colorTreatmentMethod + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _colorTreatmentMethodKey,
                                          spanCount: 3,
                                          listOfItems: _colorTreatmentMethodList!
                                              .where((element) =>
                                          element.fabricFamilyIdfk == familyId)
                                              .toList(),
                                          callback: (FabricColorTreatmentMethod value) {
                                            _createRequestModel!.fs_color_treatment_method_idfk =
                                                value.fctmId.toString();

                                            if (_colorTreatmentIdList.contains(value.fctmId)) {
                                                _showDyingMethod = true;
                                                _notifier.value = true;
                                                _selectedColorTreatMethodId = value.fctmId.toString();
                                            } else {
                                                _showDyingMethod = false;
                                                _notifier.value = false;
                                                _createRequestModel!.fs_dying_method_idfk = null;
                                                _createRequestModel!.fs_color = null;
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
                                  builder: (context,bool value, child) {
                                    return Visibility(
                                      visible: /*_notifier.value*/value,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          //Show Color dying Method
                                          Visibility(
                                            visible: true,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 8.w),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(left: 8.w),
                                                      child: const TitleSmallTextWidget(
                                                          title: "Dying Method" + '*')),
                                                  SingleSelectTileWidget(
                                                    selectedIndex: -1,
                                                    key: _dyingMethodKey,
                                                    spanCount: 3,
                                                    listOfItems:_dyingMethodList.where((element) =>
                                                    element.fabricFamilyIdfk == familyId)
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
                                                    callback: (FabricDyingTechniques value) {
                                                      _createRequestModel!.fs_dying_method_idfk =
                                                          value.fdtId.toString();
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
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(left: 8.0),
                                                      child: TitleSmallTextWidget(title: "Select Color"),
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
                                                          _createRequestModel!.fs_color = input!,
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
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                //Show Color
                                Visibility(
                                    visible: _fabricSettings!.fabricFamilyIdfk == FABRIC_MIRCOFIBER_ID,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: TitleSmallTextWidget(title: "Color"),
                                          ),
                                          ValueListenableBuilder(
                                            valueListenable: _notifierColor,
                                            builder: (context,Color color,child){
                                              return Card(
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
                                                    onSaved: (input) {
                                                      if( input==null || input.isEmpty){
                                                        _createRequestModel!.fs_color = null;
                                                      }else{
                                                        _createRequestModel!.fs_color = input;
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
                                                            borderRadius: BorderRadius.circular(10.0),
                                                            borderSide: BorderSide.none),
                                                        contentPadding: const EdgeInsets.all(2.0),
                                                        hintText: "Select Color",
                                                        filled: true,
                                                        fillColor: color),
                                                    onTap: () {
                                                      _openDialogBox();
                                                    },
                                                  ),
                                                  ),
                                                );
                                            }
                                          ),
                                        ],
                                      ),
                                    )),
                                //Show Knitting Type
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showKnittingType),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: const TitleSmallTextWidget(title: 'Knitting Type' + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _knittingTypeKey,
                                          spanCount: 2,
                                          listOfItems: _knittingTypeList
                                              .where(
                                                  (element) =>
                                              element.fabricFamilyIdfk == familyId)
                                              .toList(),
                                          callback: (KnittingTypes value) {
                                            _createRequestModel!.fs_knitting_type_idfk =
                                                value.fabricKnittingTypeId.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Appearance
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showAppearance),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(title: apperance + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _appearanceKey,
                                          spanCount: 3,
                                          listOfItems: _appearanceList.where((element) =>
                                          element.fabricFamilyIdfk == familyId)
                                              .toList(),
                                          callback: (FabricAppearance value) {
                                            _createRequestModel!.fs_appearance_idfk =
                                                value.fabricAppearanceId.toString();

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
                                  visible: Ui.showHide(_fabricSettings!.showQuality),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(title: quality + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _qualityKey,
                                          spanCount: 2,
                                          listOfItems: _qualityList
                                              .where((element) =>
                                          element.fabricFamilyIdfk == familyId)
                                              .toList(),
                                          callback: (FabricQuality value) {
                                            _createRequestModel!.fs_quality_idfk =
                                                value.fabricQualityId.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Show Grade
                                Visibility(
                                  visible: Ui.showHide(_fabricSettings!.showGrade),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w, bottom: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(title: grades + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _gradeKey,
                                          spanCount: 3,
                                          listOfItems: _gradeList.where((element) =>
                                          element.fabricFamilyIdfk == familyId)
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
                                  visible: Ui.showHide(_fabricSettings!.showCertification),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(
                                                title: certification + '*')),
                                        SingleSelectTileWidget(
                                          selectedIndex: -1,
                                          key: _certificationKey,
                                          spanCount: 4,
                                          listOfItems: _certificationList,
                                          callback: (Certification value) {
                                            _createRequestModel!.fs_certification_idfk =
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
                      btnText: "Next",
                    ),
                  ),
                ),
              ],
            ),
          );
        } /*else if (snapshot.hasError) {
          return Center(
              child: TitleSmallTextWidget(title: snapshot.error.toString()));
        }*/ else {
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
    _createRequestModel!.fs_blend_idfk = _selectedMaterial != null ? _selectedMaterial.toString():'';
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
      _createRequestModel!.fs_family_idfk = familyId??'';
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
      widget.callback!(1);
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
    _createRequestModel = FabricCreateRequestModel();
    Logger().e(_createRequestModel!.toJson().toString());
   /* _createRequestModel!.spc_grade_idfk = null;
    _createRequestModel!.spc_appearance_idfk = null;
    _createRequestModel!.spc_certificate_idfk = null;
    _createRequestModel!.spc_lot_number = null;
    _createRequestModel!.spc_brand_idfk = null;
    _createRequestModel!.spc_gpt_idfk = null;
    _createRequestModel!.spc_rd_idfk = null;
    _createRequestModel!.spc_trash_idfk = null;
    _createRequestModel!.spc_micronaire_idfk = null;
    _createRequestModel!.spc_moisture_idfk = null;
    _createRequestModel!.spc_production_year = null;
    _createRequestModel!.spc_nature_idfk = null;
    _createRequestModel!.spc_fiber_material_idfk = null;
    _createRequestModel!.spc_origin_idfk = null;*/
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

  bool validationAllPage() {
      if (validateAndSave()) {
        if (_createRequestModel!.fs_blend_idfk == null &&
            Ui.showHide(_fabricSettings!.showBlend)) {
          Ui.showSnackBar(context, 'Please Select Blend');
          return false;
        } else if (_createRequestModel!.fs_ply_idfk == null &&
            Ui.showHide(_fabricSettings!.showPly)) {
          Ui.showSnackBar(context, 'Please Select Ply');
          return false;
        } else if (_createRequestModel!.fs_color_treatment_method_idfk == null &&
            Ui.showHide(_fabricSettings!.showColorTreatmentMethod)) {
          Ui.showSnackBar(context, 'Please Select Color Treatment Method');
          return false;
        }  else if (_createRequestModel!.fs_dying_method_idfk == null &&
            _showDyingMethod) {
          Ui.showSnackBar(context, 'Please Select Dying Method');
          return false;
        }else if (_createRequestModel!.fs_knitting_type_idfk == null &&
            Ui.showHide(_fabricSettings!.showKnittingType)) {
          Ui.showSnackBar(context, 'Please Select Knitting Type');
          return false;
        }else if (_createRequestModel!.fs_weave_idfk == null &&
            Ui.showHide(_fabricSettings!.showWeave)) {
          Ui.showSnackBar(context, 'Please Select Weave');
          return false;
        }else if (_createRequestModel!.fs_loom_idfk == null &&
            Ui.showHide(_fabricSettings!.showLoom)) {
          Ui.showSnackBar(context, 'Please Select Loom');
          return false;
        }else if (_createRequestModel!.fs_layyer_idfk == null &&
            Ui.showHide(_fabricSettings!.showLayyer)) {
          Ui.showSnackBar(context, 'Please Select Layyer');
          return false;
        } else if (_createRequestModel!.fs_quality_idfk == null &&
            Ui.showHide(_fabricSettings!.showQuality)) {
          Ui.showSnackBar(context, 'Please Select Quality');
          return false;
        }  else if (_createRequestModel!.fs_grade_idfk == null &&
            Ui.showHide(_fabricSettings!.showGrade)) {
          Ui.showSnackBar(context, 'Please Select Grade');
          return false;
        }else if (_createRequestModel!.fs_color == null &&
            _fabricSettings!.fabricFamilyIdfk == FABRIC_MIRCOFIBER_ID) {
          Ui.showSnackBar(context, 'Please Select Color');
          return false;
        } else if (_createRequestModel!.fs_appearance_idfk == null &&
            Ui.showHide(_fabricSettings!.showAppearance)) {
          Ui.showSnackBar(context, 'Please Select Appearance');
          return false;
        } else if (_createRequestModel!.fs_certification_idfk == null &&
            Ui.showHide(_fabricSettings!.showCertification)) {
          Ui.showSnackBar(context, 'Please Select Certification');
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
}
