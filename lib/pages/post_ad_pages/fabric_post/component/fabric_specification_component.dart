import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  FabricSetting? _fabricSettings;
  CreateRequestModel? _createRequestModel;

  late List<FabricBlends> _fabricBlendsList;
  late List<FabricFamily> _fabricFamilyList;
  late List<FabricAppearance> _fabricAppearanceList;
  late List<FabricGrades> _fabricGradesList;
  late List<Brands> _brands;
  late List<Countries> _countries;
  late List<CityState> _citySateList;
  late List<Certification> _certificationList;

  _getFabricSyncedData(PostFabricProvider postFabricProvider)async {
    AppDbInstance.getFabricBlendsData().then((value) => setState(() {
          _fabricBlendsList = value;
          _selectedMaterial = value
              .where((element) => element.familyIdfk == postFabricProvider.firstFamilyId.toString())
              .toList()
              .first
              .blnId;
          postFabricProvider.setBlendId(_selectedMaterial!);
        }));
    var dbInstance = await AppDbInstance.getDbInstance();
    _fabricFamilyList = await dbInstance.fabricFamilyDao.findAllFabricFamily();
    _fabricAppearanceList = await dbInstance.fabricAppearanceDao.findAllFabricAppearance();
    _fabricGradesList = await dbInstance.fabricGradesDao.findAllFabricGrade();
    AppDbInstance.getFiberBrandsData()
        .then((value) => setState(() => _brands = value));
    AppDbInstance.getOriginsData()
        .then((value) => setState(() => _countries = value));
    AppDbInstance.getCityState()
        .then((value) => setState(() => _citySateList = value));
    AppDbInstance.getCertificationsData()
        .then((value) => setState(() => _certificationList = value));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    final postFabricProvider =
    Provider.of<PostFabricProvider>(context, listen: false);
    _getFabricSyncedData(postFabricProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final postFabricProvider = Provider.of<PostFabricProvider>(context);
    _selectedMaterial = postFabricProvider.blendId;
    _createRequestModel = Provider.of<CreateRequestModel?>(context);
    var familyId = _fabricBlendsList.where((element) => element.blnId == postFabricProvider.blendId).first.familyIdfk;
    return FutureBuilder<List<FabricSetting>>(
      future: postFabricProvider.getFabricSettingsData(familyId!),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data!.isNotEmpty) {
            _resetData();
            ApiService.logger.e(_createRequestModel!.toJson());
            _fabricSettings = /*snapshot.data![0]*/postFabricProvider.fabricSetting!.first;
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
                                Visibility(
                                    visible: int.parse(
                                                snapshot.data![0].showGrade!) ==
                                            1
                                        ? true
                                        : false,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
                                                  title: grades)),
                                          SingleSelectTileWidget(
                                            spanCount: 3,
                                            selectedIndex: -1,
                                            listOfItems: _fabricGradesList,
                                            callback: (value) {
                                              _createRequestModel!
                                                      .spc_grade_idfk =
                                                  value.grdId.toString();
                                            },
                                          ),
                                        ],
                                      ),
                                    )),

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

  void handleNextClick() {
    if (validationAllPage()) {
      _createRequestModel!.spc_category_idfk = "1";

      _createRequestModel!.spc_fiber_material_idfk =
          _selectedMaterial.toString();
      // var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      //
      // _createRequestModel!.spc_user_idfk = userId;

      _createRequestModel!.spc_nature_idfk = _fabricBlendsList
          .where((element) =>
              element.blnId == _selectedMaterial)
          .toList()
          .first
          .familyIdfk
          .toString();

      widget.callback!(1);
    }
  }

  _resetData() {
    _createRequestModel!.spc_grade_idfk = null;
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
    _createRequestModel!.spc_origin_idfk = null;
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
    /*if (validateAndSave()) {
      if (_createRequestModel!.spc_grade_idfk == null &&
          Ui.showHide(_fabricSettings!.showGrade)) {
        Ui.showSnackBar(context, 'Please Select Grade');
        return false;
      } else if (_createRequestModel!.spc_appearance_idfk == null &&
          Ui.showHide(_fabricSettings!.showAppearance)) {
        Ui.showSnackBar(context, 'Please Select Appearance');
        return false;
      } else if (_createRequestModel!.spc_brand_idfk == null &&
          Ui.showHide(_fabricSettings!.showBrand)) {
        Ui.showSnackBar(context, 'Please Select Brand');
        return false;
      } else if (_createRequestModel!.spc_origin_idfk == null &&
          _fabricSettings!.showOrigin == "1") {
        Ui.showSnackBar(context, 'Please Select Origin');
        return false;
      } else if (_createRequestModel!.spc_certificate_idfk == null &&
          Ui.showHide(_fabricSettings!.showCertification)) {
        Ui.showSnackBar(context, 'Please Select Certification');
        return false;
      } else {
        return true;
      }
    }*/
    return false;
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
