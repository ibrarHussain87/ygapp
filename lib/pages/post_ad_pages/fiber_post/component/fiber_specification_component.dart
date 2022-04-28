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

class FiberSpecificationComponent extends StatefulWidget {
  final Function? callback;

  // final SyncFiberResponse syncFiberResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FiberSpecificationComponent(
      {Key? key,
      // required this.syncFiberResponse,
      required this.callback,
      required this.locality,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  FiberSpecificationComponentState createState() =>
      FiberSpecificationComponentState();
}

class FiberSpecificationComponentState
    extends State<FiberSpecificationComponent>
    with AutomaticKeepAliveClientMixin {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int? _selectedMaterial;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  FiberSettings? _fiberSettings;
  CreateRequestModel? _createRequestModel;

  late List<FiberMaterial> _fiberMaterialList;
  late List<FiberNature> _fiberNatureList;
  late List<FiberAppearance> _fiberAppearanceList;
  late List<Grades> _fiberGradesList;
  late List<Brands> _brands;
  late List<Countries> _countries;
  late List<CityState> _citySateList;
  late List<Certification> _certificationList;

  _getFiberSyncedData() {
    AppDbInstance.getFiberMaterialData().then((value) => setState(() {
          _fiberMaterialList = value;
          _selectedMaterial = value
              .where((element) => element.nature_id == "1")
              .toList()
              .first
              .fbmId;
        }));
    AppDbInstance.getFiberNatureData()
        .then((value) => setState(() => _fiberNatureList = value));
    AppDbInstance.getFiberAppearanceData()
        .then((value) => setState(() => _fiberAppearanceList = value));
    AppDbInstance.getFiberGradesData()
        .then((value) => setState(() => _fiberGradesList = value));
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
    _getFiberSyncedData();
    BroadcastReceiver().subscribe<int> // Data Type returned from publisher
        (materialIndexBroadcast, (index) {
      setState(() {
        _selectedMaterial = index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _createRequestModel = Provider.of<CreateRequestModel?>(context);
    return FutureBuilder<List<FiberSettings>>(
      future: AppDbInstance.getDbInstance().then((value) async {
        return value.fiberSettingDao.findFiberSettings(_selectedMaterial!);
      }),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data!.isNotEmpty) {
            _resetData();
            ApiService.logger.e(_createRequestModel!.toJson());
            _fiberSettings = snapshot.data![0];
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
                                                snapshot.data![0].showGrade) ==
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
                                                  EdgeInsets.only(left: 0.w,top: 4,bottom: 4),
                                              child: TitleSmallBoldTextWidget(
                                                  title: grades)),
                                          SingleSelectTileWidget(
                                            spanCount: 3,
                                            selectedIndex: -1,
                                            listOfItems: _fiberGradesList,
                                            callback: (value) {
                                              _createRequestModel!
                                                      .spc_grade_idfk =
                                                  value.grdId.toString();
                                            },
                                          ),
                                        ],
                                      ),
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: int.parse(snapshot
                                                  .data![0].showLength) ==
                                              1
                                          ? true
                                          : false,
                                      child: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //modified by (asad_m)
//                                              Padding(
//                                                  padding: EdgeInsets.only(
//                                                      left: 8.w),
//                                                  child: TitleSmallTextWidget(
//                                                      title: fiberLength)),


                                              // TextFormField(
                                              //     keyboardType:
                                              //         TextInputType.number,
                                              //     cursorColor: lightBlueTabs,
                                              //     style: TextStyle(
                                              //         fontSize: 11.sp),
                                              //     textAlign: TextAlign.center,
                                              //     cursorHeight: 16.w,
                                              //     inputFormatters: [
                                              //       NumericalRangeFormatter(
                                              //           min: StringUtils
                                              //               .splitMin(snapshot
                                              //                   .data![0]
                                              //                   .lengthMinMax),
                                              //           max: StringUtils
                                              //               .splitMax(snapshot
                                              //                   .data![0]
                                              //                   .lengthMinMax))
                                              //     ],
                                              //     onSaved: (input) =>
                                              //         _createRequestModel!
                                              //                 .spc_fiber_length_idfk =
                                              //             input!,
                                              //     validator: (input) {
                                              //       if (input == null ||
                                              //           input.isEmpty) {
                                              //         return fiberLength;
                                              //       }
                                              //       return null;
                                              //     },
                                              //     decoration:
                                              //         roundedTextFieldDecoration(
                                              //             "${snapshot.data![0].lengthMinMax} mm")),
                                              SizedBox(height:12.w ,),
                                              YgTextFormFieldWithRange(
                                                label: fiberLength,
                                                  errorText: fiberLength,
                                                  minMax: snapshot
                                                      .data![0].lengthMinMax,
                                                  onSaved: (input) {
                                                    _createRequestModel!
                                                            .spc_fiber_length_idfk =
                                                        input;
                                                  }),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (snapshot.data![0].showLength ==
                                                  "1" &&
                                              snapshot.data![0]
                                                      .showMicronaire ==
                                                  "1")
                                          ? 16.w
                                          : 0,
                                    ),
                                    Visibility(
                                      visible: int.parse(snapshot
                                                  .data![0].showMicronaire) ==
                                              1
                                          ? true
                                          : false,
                                      child: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [

                                              //modified by (asad_m)
                                              SizedBox(height:12.w ,),
//                                              Padding(
//                                                  padding: EdgeInsets.only(
//                                                      left: 8.w),
//                                                  child: TitleSmallTextWidget(
//                                                      title: micStr)),


                                              YgTextFormFieldWithRange(
                                                  errorText: micStr,
                                                  label: micStr,
                                                  minMax: snapshot
                                                      .data![0].micMinMax,
                                                  onSaved: (input) {
                                                    _createRequestModel!
                                                            .spc_micronaire_idfk =
                                                        input;
                                                  }),
                                              /* TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor: lightBlueTabs,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  inputFormatters: [
                                                    NumericalRangeFormatter(
                                                        min: StringUtils
                                                            .splitMin(snapshot
                                                                .data![0]
                                                                .micMinMax),
                                                        max: StringUtils
                                                            .splitMax(snapshot
                                                                .data![0]
                                                                .micMinMax))
                                                  ],
                                                  onSaved: (input) =>
                                                      _createRequestModel!
                                                              .spc_micronaire_idfk =
                                                          input!,
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty) {
                                                      return micStr;
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      roundedTextFieldDecoration(
                                                          '${snapshot.data![0].micMinMax} mic')),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      child: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //modified by (asad_m)
                                              SizedBox(height:12.w ,),
//                                              Padding(
//                                                  padding: EdgeInsets.only(
//                                                      left: 8.w),
//                                                  child: TitleSmallTextWidget(
//                                                      title: moistureStr)),
                                              YgTextFormFieldWithRange(
                                                  errorText: moistureStr,
                                                  label: moistureStr,
                                                  minMax: snapshot
                                                      .data![0].moiMinMax,
                                                  onSaved: (input) {
                                                    _createRequestModel!
                                                            .spc_moisture_idfk =
                                                        input;
                                                  }),
                                              // TextFormField(
                                              //     keyboardType:
                                              //         TextInputType.number,
                                              //     cursorColor: lightBlueTabs,
                                              //     style: TextStyle(
                                              //         fontSize: 11.sp),
                                              //     textAlign: TextAlign.center,
                                              //     cursorHeight: 16.w,
                                              //     onSaved: (input) =>
                                              //         _createRequestModel!
                                              //                 .spc_moisture_idfk =
                                              //             input!,
                                              //     inputFormatters: [
                                              //       NumericalRangeFormatter(
                                              //           min: StringUtils
                                              //               .splitMin(snapshot
                                              //                   .data![0]
                                              //                   .moiMinMax),
                                              //           max: StringUtils
                                              //               .splitMax(snapshot
                                              //                   .data![0]
                                              //                   .moiMinMax))
                                              //     ],
                                              //     validator: (input) {
                                              //       if (input == null ||
                                              //           input.isEmpty) {
                                              //         return moistureStr;
                                              //       }
                                              //       return null;
                                              //     },
                                              //     decoration:
                                              //         roundedTextFieldDecoration(
                                              //             '${snapshot.data![0].moiMinMax} %')),
                                            ],
                                          ),
                                        ),
                                      ),
                                      visible: int.parse(snapshot
                                                  .data![0].showMoisture) ==
                                              1
                                          ? true
                                          : false,
                                    ),
                                    SizedBox(
                                      width: (snapshot.data![0].showMoisture ==
                                                  "1" &&
                                              snapshot.data![0].showTrash ==
                                                  "1")
                                          ? 16.w
                                          : 0,
                                    ),
                                    Visibility(
                                        child: Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
//                                                Padding(
//                                                    padding: EdgeInsets.only(
//                                                        left: 8.w),
//                                                    child: TitleSmallTextWidget(
//                                                        title: trashStr)),

                                                SizedBox(height:12.w ,),
                                                YgTextFormFieldWithRange(
                                                    errorText: trashStr,
                                                    label: trashStr,
                                                    minMax: snapshot
                                                        .data![0].trashMinMax,
                                                    onSaved: (input) {
                                                      _createRequestModel!
                                                              .spc_trash_idfk =
                                                          input;
                                                    }),
                                                /* TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor: lightBlueTabs,
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                    textAlign: TextAlign.center,
                                                    cursorHeight: 16.w,
                                                    onSaved: (input) =>
                                                        _createRequestModel!
                                                                .spc_trash_idfk =
                                                            input!,
                                                    inputFormatters: [
                                                      NumericalRangeFormatter(
                                                          min: StringUtils
                                                              .splitMin(snapshot
                                                                  .data![0]
                                                                  .trashMinMax),
                                                          max: StringUtils
                                                              .splitMax(snapshot
                                                                  .data![0]
                                                                  .trashMinMax))
                                                    ],
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return trashStr;
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        roundedTextFieldDecoration(
                                                            '${snapshot.data![0].trashMinMax} %')),*/
                                              ],
                                            ),
                                          ),
                                        ),
                                        visible: int.parse(snapshot
                                                    .data![0].showTrash) ==
                                                1
                                            ? true
                                            : false),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      child: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //Modified by (asad_m)
                                              SizedBox(height:12.w ,),
//                                              Padding(
//                                                  padding: EdgeInsets.only(
//                                                      left: 8.w),
//                                                  child:
//                                                      const TitleSmallTextWidget(
//                                                          title: 'RD')),

                                              YgTextFormFieldWithRange(
                                                  errorText: 'RD',
                                                  label: 'RD',
                                                  minMax: snapshot
                                                      .data![0].rdMinMax,
                                                  onSaved: (input) {
                                                    _createRequestModel!
                                                        .spc_rd_idfk = input;
                                                  }),
                                              /*TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor: lightBlueTabs,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  onSaved: (input) =>
                                                      _createRequestModel!
                                                          .spc_rd_idfk = input!,
                                                  inputFormatters: [
                                                    NumericalRangeFormatter(
                                                        min: StringUtils
                                                            .splitMin(snapshot
                                                                .data![0]
                                                                .rdMinMax),
                                                        max: StringUtils
                                                            .splitMax(snapshot
                                                                .data![0]
                                                                .rdMinMax))
                                                  ],
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty) {
                                                      return "Enter RD";
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      roundedTextFieldDecoration(
                                                          '${snapshot.data![0].rdMinMax} %')),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                      visible:
                                          int.parse(snapshot.data![0].showRd) ==
                                                  1
                                              ? true
                                              : false,
                                    ),
                                    SizedBox(
                                      width: (snapshot.data![0].showRd == "1" &&
                                              snapshot.data![0].showGpt == "1")
                                          ? 16.w
                                          : 0,
                                    ),
                                    Visibility(
                                      child: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //Modified by (asad_m)
                                              SizedBox(height:12.w ,),
//                                              Padding(
//                                                  padding: EdgeInsets.only(
//                                                      left: 8.w),
//                                                  child:
//                                                      const TitleSmallTextWidget(
//                                                          title: 'GPT')),

                                              YgTextFormFieldWithRange(
                                                  errorText: "GPT",
                                                  label: 'GPT',
                                                  minMax: snapshot
                                                      .data![0].gptMinMax,
                                                  onSaved: (input) {
                                                    _createRequestModel!
                                                        .spc_gpt_idfk = input;
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                      visible: int.parse(
                                                  snapshot.data![0].showGpt) ==
                                              1
                                          ? true
                                          : false,
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: int.parse(snapshot
                                              .data![0].showAppearance) ==
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
                                            padding: EdgeInsets.only(left: 0.w,top: 4,bottom: 4),
                                            child: const TitleSmallBoldTextWidget(
                                                title: 'Appearance')),
                                        SingleSelectTileWidget(
                                          spanCount: 2,
                                          selectedIndex: -1,
                                          listOfItems: _fiberAppearanceList,
                                          callback: (value) {
                                            _createRequestModel!
                                                    .spc_appearance_idfk =
                                                value.aprId.toString();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      child: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 14.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
//                                              Padding(
//                                                  padding: EdgeInsets.only(
//                                                      left: 8.w),
//                                                  child: TitleSmallTextWidget(
//                                                      title: brand)),
                                              SizedBox(
                                                height: 36.w,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width:
                                                            1, //                   <--- border width here
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.w))),
                                                  child:
                                                      DropdownButtonFormField(
                                                    hint: Text('Select $brand'),
                                                    items: _brands
                                                        .map((value) =>
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  value.brdName ??
                                                                      Utils.checkNullString(false),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                              value: value,
                                                            ))
                                                        .toList(),
                                                    onChanged: (Brands? value) {
                                                      _createRequestModel!
                                                              .spc_brand_idfk =
                                                          value!.brdId
                                                              .toString();
                                                    },

                                                    // value: widget.syncFiberResponse.data.fiber.brands.first,
                                                    decoration: InputDecoration(
                                                     label: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(brand,style:TextStyle(
                                                              color: Colors.black87,
                                                              fontSize: 14.sp,
                                                              backgroundColor: Colors.white,
                                                              fontFamily: 'Metropolis',
                                                              fontWeight: FontWeight.w500),),
                                                           Text("*", style: TextStyle(color: Colors.red,fontSize: 16.sp,
                                                              fontFamily: 'Metropolis',
                                                               backgroundColor: Colors.white,
                                                              fontWeight: FontWeight.w500)),
                                                        ],
                                                      ),
                                                      floatingLabelBehavior:FloatingLabelBehavior.always ,
//                                                      hintText: hintLabel,
//                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 16.w,
                                                              right: 6.w,
                                                              top: 0,
                                                              bottom: 0),
                                                      border:
                                                          const OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: textColorGrey),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      visible: int.parse(snapshot
                                                  .data![0].showBrand) ==
                                              1
                                          ? true
                                          : false,
                                    ),
                                    SizedBox(
                                      width:
                                          (snapshot.data![0].showBrand == "1" && snapshot.data![0].showProductionYear == "1")
                                              ? 16.w
                                              : 0,
                                    ),
                                    Visibility(
                                      visible: Ui.showHide(_fiberSettings!.showProductionYear),
                                      child: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 14.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
//                                              Padding(
//                                                  padding: EdgeInsets.only(
//                                                      left: 8.w),
//                                                  child:
//                                                      const TitleSmallTextWidget(
//                                                          title:
//                                                              'Production Year')),



                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.none,
                                                controller:
                                                    _textEditingController,
                                                cursorColor: lightBlueTabs,
                                                autofocus: false,
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                                textAlign: TextAlign.center,
                                                showCursor: false,
                                                readOnly: true,
                                                onSaved: (input) =>
                                                    _createRequestModel!
                                                            .spc_production_year =
                                                        input!.toString(),
                                                validator: (input) {
                                                  if (input == null ||
                                                      input.isEmpty) {
                                                    return "Please enter production year";
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    ygTextFieldDecoration(
                                                        'Production year','Production year'),
                                                onTap: () {
                                                  handleReadOnlyInputClick(
                                                      context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible:
                                      Ui.showHide(_fiberSettings!.showOrigin),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 14.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
//                                        Padding(
//                                            padding: EdgeInsets.only(left: 8.w),
//                                            child: const TitleSmallTextWidget(
//                                                title: 'Origin')),

                                        SizedBox(
                                          height: 36.w,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                  width:
                                                      1, //                   <--- border width here
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.w))),
                                            child: DropdownButtonFormField(
                                              hint: const Text('Select Origin'),
                                              items: _countries
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        child: Text(
                                                            value.conName ??
                                                                Utils.checkNullString(false),
                                                            textAlign: TextAlign
                                                                .center),
                                                        value: value,
                                                      ))
                                                  .toList(),
                                              onChanged: (Countries? value) {
                                                _createRequestModel!
                                                        .spc_origin_idfk =
                                                    value!.conId.toString();
                                              },

                                              // value: widget.syncFiberResponse.data.fiber.brands.first,
                                              decoration: InputDecoration(
                                                label: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text('Origin',style:TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14.sp,
                                                        fontFamily: 'Metropolis',
                                                        backgroundColor: Colors.white,
                                                        fontWeight: FontWeight.w500),),
                                                    Text("*", style: TextStyle(color: Colors.red,fontSize: 16.sp,
                                                        fontFamily: 'Metropolis',
                                                        backgroundColor: Colors.white,
                                                        fontWeight: FontWeight.w500)),
                                                  ],
                                                ),
                                                floatingLabelBehavior:FloatingLabelBehavior.always ,
//                                                      hintText: hintLabel,
//                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

                                                contentPadding:
                                                EdgeInsets.only(
                                                    left: 16.w,
                                                    right: 6.w,
                                                    top: 0,
                                                    bottom: 0),
                                                border:
                                                const OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide
                                                        .none),
                                              ),
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: textColorGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 14.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
//                                        Padding(
//                                            padding: EdgeInsets.only(left: 8.w),
//                                            child: const TitleSmallTextWidget(
//                                                title: 'City State')),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: lightBlueTabs,
                                                width:
                                                    1, //                   <--- border width here
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.w))),
                                          child: SizedBox(
                                            height: 36.w,
                                            child: DropdownButtonFormField(
                                              hint: const Text(
                                                  'Select City State'),
                                              items: _citySateList
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        child: Text(
                                                            value.name ?? Utils.checkNullString(false),
                                                            textAlign: TextAlign
                                                                .center),
                                                        value: value,
                                                      ))
                                                  .toList(),
                                              onChanged: (CityState? value) {
                                                _createRequestModel!
                                                        .spc_city_state_idfk =
                                                    value!.id.toString();
                                              },
                                              decoration: InputDecoration(
                                                label: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text('City State',style:TextStyle(
                                                        color: Colors.black87,
                                                        fontSize: 14.sp,
                                                        backgroundColor: Colors.white,
                                                        fontFamily: 'Metropolis',
                                                        fontWeight: FontWeight.w500),),
                                                    Text("*", style: TextStyle(color: Colors.red,fontSize: 16.sp,
                                                        fontFamily: 'Metropolis',
                                                        backgroundColor: Colors.white,
                                                        fontWeight: FontWeight.w500)),
                                                  ],
                                                ),
                                                floatingLabelBehavior:FloatingLabelBehavior.always ,
//                                                      hintText: hintLabel,
//                                                      hintStyle: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

                                                contentPadding:
                                                EdgeInsets.only(
                                                    left: 16.w,
                                                    right: 6.w,
                                                    top: 0,
                                                    bottom: 0),
                                                border:
                                                const OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide
                                                        .none),
                                              ),
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: textColorGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: Ui.showHide(
                                      _fiberSettings!.showLotNumber),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 14.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
//                                        Padding(
//                                            padding: EdgeInsets.only(left: 8.w),
//                                            child: const TitleSmallTextWidget(
//                                                title: 'Lot Number')),
                                        TextFormField(
                                            keyboardType: TextInputType.text,
                                            cursorColor: lightBlueTabs,
                                            style: TextStyle(fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                            cursorHeight: 16.w,
                                            onSaved: (input) =>
                                                _createRequestModel!
                                                    .spc_lot_number = input!,
                                            validator: (input) {
                                              if (input == null ||
                                                  input.isEmpty) {
                                                return "Enter Lot Number";
                                              }
                                              return null;
                                            },
                                            decoration:
                                                ygTextFieldDecoration(
                                                    'Lot Number','Lot Number')),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: int.parse(snapshot
                                              .data![0].showCertification) ==
                                          1
                                      ? true
                                      : false,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.w, bottom: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 0.w,top: 4,bottom: 4),
                                            child: const TitleSmallBoldTextWidget(
                                                title: 'Certification')),
                                        SingleSelectTileWidget(
                                          spanCount: 3,
                                          selectedIndex: -1,
                                          listOfItems: _certificationList,
                                          callback: (value) {
                                            _createRequestModel!
                                                    .spc_certificate_idfk =
                                                value.cerId.toString();
                                          },
                                        ),
                                        SizedBox(
                                          height: 8.w,
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

  void handleNextClick() {
    if (validationAllPage()) {
      _createRequestModel!.spc_category_idfk = "1";

      _createRequestModel!.spc_fiber_material_idfk =
          _selectedMaterial.toString();
      // var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      //
      // _createRequestModel!.spc_user_idfk = userId;

      _createRequestModel!.spc_nature_idfk = _fiberMaterialList
          .where((element) =>
              element.fbmId == _selectedMaterial)
          .toList()
          .first
          .nature_id
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
    if (validateAndSave()) {
      if (_createRequestModel!.spc_grade_idfk == null &&
          Ui.showHide(_fiberSettings!.showGrade)) {
        Ui.showSnackBar(context, 'Please Select Grade');
        return false;
      } else if (_createRequestModel!.spc_appearance_idfk == null &&
          Ui.showHide(_fiberSettings!.showAppearance)) {
        Ui.showSnackBar(context, 'Please Select Appearance');
        return false;
      } else if (_createRequestModel!.spc_brand_idfk == null &&
          Ui.showHide(_fiberSettings!.showBrand)) {
        Ui.showSnackBar(context, 'Please Select Brand');
        return false;
      } else if (_createRequestModel!.spc_origin_idfk == null &&
          _fiberSettings!.showOrigin == "1") {
        Ui.showSnackBar(context, 'Please Select Origin');
        return false;
      } else if (_createRequestModel!.spc_certificate_idfk == null &&
          Ui.showHide(_fiberSettings!.showCertification)) {
        Ui.showSnackBar(context, 'Please Select Certification');
        return false;
      } else {
        return true;
      }
    }
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
