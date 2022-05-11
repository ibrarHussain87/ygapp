import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
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
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/providers/post_fiber_provider.dart';

import '../../../../helper_utils/alert_dialog.dart';
import '../../../../helper_utils/navigation_utils.dart';
import '../../../../helper_utils/progress_dialog_util.dart';

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

class FiberSpecificationComponentState extends State<FiberSpecificationComponent> with AutomaticKeepAliveClientMixin {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  List<PickedFile> imageFiles = [];

  final _postFiberProvider = locator<PostFiberProvider>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _postFiberProvider.addListener(() {updateUI();});
    WidgetsBinding.instance?.addPostFrameCallback((_){
      _resetData();
      _postFiberProvider.getFiberAllSyncedData();
      _postFiberProvider.fiberSettingSelectedBlend();
    });
  }

  updateUI(){
    if(mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    /*FutureBuilder<List<FiberSettings>>(
      future: AppDbInstance().getDbInstance().then((value) async {
        return ;
      }),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          if (snapshot.data!.isNotEmpty) {
            _resetData();
            ApiService.logger.e(_postFiberProvider.createRequestModel!.toJson());
            _postFiberProvider.fiberSettings = _postFiberProvider.ffiberSettings;
          }*/
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            key: scaffoldKey,
            body: !_postFiberProvider.isLoading ?Column(
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
                                    visible: int.parse(_postFiberProvider.fiberSettings.showGrade) ==
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
                                            listOfItems: _postFiberProvider.fiberGradesList,
                                            callback: (value) {
                                              _postFiberProvider.createRequestModel
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
                                      visible: int.parse(_postFiberProvider.fiberSettings.showLength) ==
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
                                              //         _postFiberProvider.createRequestModel!
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
                                              //             "${_postFiberProvider.fiberSettings.lengthMinMax} mm")),
                                              SizedBox(height:12.w ,),
                                              YgTextFormFieldWithRange(
                                                label: fiberLength,
                                                  errorText: fiberLength,
                                                  minMax: _postFiberProvider.fiberSettings.lengthMinMax,
                                                  onSaved: (input) {
                                                    _postFiberProvider.createRequestModel
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
                                      width: (_postFiberProvider.fiberSettings.showLength ==
                                                  "1" &&
                                              _postFiberProvider.fiberSettings
                                                      .showMicronaire ==
                                                  "1")
                                          ? 16.w
                                          : 0,
                                    ),
                                    Visibility(
                                      visible: int.parse(_postFiberProvider.fiberSettings.showMicronaire) ==
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
                                                  minMax: _postFiberProvider.fiberSettings.micMinMax,
                                                  onSaved: (input) {
                                                    _postFiberProvider.createRequestModel
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
                                                      _postFiberProvider.createRequestModel!
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
                                                          '${_postFiberProvider.fiberSettings.micMinMax} mic')),*/
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
                                                  minMax: _postFiberProvider.fiberSettings.moiMinMax,
                                                  onSaved: (input) {
                                                    _postFiberProvider.createRequestModel
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
                                              //         _postFiberProvider.createRequestModel!
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
                                              //             '${_postFiberProvider.fiberSettings.moiMinMax} %')),
                                            ],
                                          ),
                                        ),
                                      ),
                                      visible: int.parse(_postFiberProvider.fiberSettings.showMoisture) ==
                                              1
                                          ? true
                                          : false,
                                    ),
                                    SizedBox(
                                      width: (_postFiberProvider.fiberSettings.showMoisture ==
                                                  "1" &&
                                              _postFiberProvider.fiberSettings.showTrash ==
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
                                                    minMax: _postFiberProvider.fiberSettings.trashMinMax,
                                                    onSaved: (input) {
                                                      _postFiberProvider.createRequestModel
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
                                                        _postFiberProvider.createRequestModel!
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
                                                            '${_postFiberProvider.fiberSettings.trashMinMax} %')),*/
                                              ],
                                            ),
                                          ),
                                        ),
                                        visible: int.parse(_postFiberProvider.fiberSettings.showTrash) ==
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
                                                  minMax: _postFiberProvider.fiberSettings.rdMinMax,
                                                  onSaved: (input) {
                                                    _postFiberProvider.createRequestModel
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
                                                      _postFiberProvider.createRequestModel!
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
                                                          '${_postFiberProvider.fiberSettings.rdMinMax} %')),*/
                                            ],
                                          ),
                                        ),
                                      ),
                                      visible:
                                          int.parse(_postFiberProvider.fiberSettings.showRd) ==
                                                  1
                                              ? true
                                              : false,
                                    ),
                                    SizedBox(
                                      width: (_postFiberProvider.fiberSettings.showRd == "1" &&
                                              _postFiberProvider.fiberSettings.showGpt == "1")
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
                                                  minMax: _postFiberProvider.fiberSettings.gptMinMax,
                                                  onSaved: (input) {
                                                    _postFiberProvider.createRequestModel
                                                        .spc_gpt_idfk = input;
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                      visible: int.parse(
                                                  _postFiberProvider.fiberSettings.showGpt) ==
                                              1
                                          ? true
                                          : false,
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: int.parse(_postFiberProvider.fiberSettings.showAppearance) ==
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
                                          listOfItems: _postFiberProvider.fiberAppearanceList,
                                          callback: (value) {
                                            _postFiberProvider.createRequestModel
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
                                                    items: _postFiberProvider.brandsList
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
                                                      _postFiberProvider.createRequestModel
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
                                                              /*fontFamily: 'Metropolis',*/
                                                              fontWeight: FontWeight.w500),),
                                                           Text("*", style: TextStyle(color: Colors.red,fontSize: 16.sp,
                                                              /*fontFamily: 'Metropolis',*/
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
                                      visible: int.parse(_postFiberProvider.fiberSettings.showBrand) ==
                                              1
                                          ? true
                                          : false,
                                    ),
                                    SizedBox(
                                      width:
                                          (_postFiberProvider.fiberSettings.showBrand == "1" && _postFiberProvider.fiberSettings.showProductionYear == "1")
                                              ? 16.w
                                              : 0,
                                    ),
                                    Visibility(
                                      visible: Ui.showHide(_postFiberProvider.fiberSettings.showProductionYear),
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
                                                    _postFiberProvider.createRequestModel
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
                                      Ui.showHide(_postFiberProvider.fiberSettings.showOrigin),
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
                                              items: _postFiberProvider.countries
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
                                                _postFiberProvider.createRequestModel
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
                                                        /*fontFamily: 'Metropolis',*/
                                                        backgroundColor: Colors.white,
                                                        fontWeight: FontWeight.w500),),
                                                    Text("*", style: TextStyle(color: Colors.red,fontSize: 16.sp,
                                                        /*fontFamily: 'Metropolis',*/
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
                                              items: _postFiberProvider.citySateList
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
                                                _postFiberProvider.createRequestModel
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
                                                        /*fontFamily: 'Metropolis',*/
                                                        fontWeight: FontWeight.w500),),
                                                    Text("*", style: TextStyle(color: Colors.red,fontSize: 16.sp,
                                                        /*fontFamily: 'Metropolis',*/
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
                                      _postFiberProvider.fiberSettings.showLotNumber),
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
                                                _postFiberProvider.createRequestModel
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
                                  visible: int.parse(_postFiberProvider.fiberSettings.showCertification) ==
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
                                          listOfItems: _postFiberProvider.certificationList,
                                          callback: (value) {
                                            _postFiberProvider.createRequestModel
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
                      btnText: widget.selectedTab == offering_type ? "Next" : submit,
                    ),
                  ),
                ),
              ],
            ) : Container(),

         /*else if (snapshot.hasError) {
          return Center(
              child: TitleSmallTextWidget(title: snapshot.error.toString()));
        }*/ /*else {
          return const Center(
            child: SpinKitWave(
              color: Colors.green,
              size: 24.0,
            ),
          );
        }*/
      // },
    );
  }

  void handleNextClick() {
    if (validationAllPage()) {
      _postFiberProvider.createRequestModel.spc_category_idfk = "1";

      _postFiberProvider.createRequestModel.spc_fiber_family_idfk =
          _postFiberProvider.selectedBlendId.toString();
      // var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      //
      // _postFiberProvider.createRequestModel!.spc_user_idfk = userId;

      _postFiberProvider.createRequestModel.spc_nature_idfk = _postFiberProvider.selectedFamilyId.toString();
      if(widget.selectedTab == offering_type){
        widget.callback!(1);
      }else{
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
    if (widget.businessArea == yarn) {
      _postFiberProvider.createRequestModel.ys_local_international =
          widget.locality!.toUpperCase();
    } else {
      _postFiberProvider.createRequestModel.spc_local_international =
          widget.locality!.toUpperCase();
    }

    ProgressDialogUtil.showDialog(context, 'Please wait...');

    ApiService.createSpecification(_postFiberProvider.createRequestModel,
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


  _resetData() {
    _postFiberProvider.createRequestModel.spc_grade_idfk = null;
    _postFiberProvider.createRequestModel.spc_appearance_idfk = null;
    _postFiberProvider.createRequestModel.spc_certificate_idfk = null;
    _postFiberProvider.createRequestModel.spc_lot_number = null;
    _postFiberProvider.createRequestModel.spc_brand_idfk = null;
    _postFiberProvider.createRequestModel.spc_gpt_idfk = null;
    _postFiberProvider.createRequestModel.spc_rd_idfk = null;
    _postFiberProvider.createRequestModel.spc_trash_idfk = null;
    _postFiberProvider.createRequestModel.spc_micronaire_idfk = null;
    _postFiberProvider.createRequestModel.spc_moisture_idfk = null;
    _postFiberProvider.createRequestModel.spc_production_year = null;
    _postFiberProvider.createRequestModel.spc_nature_idfk = null;
    _postFiberProvider.createRequestModel.spc_fiber_family_idfk = null;
    _postFiberProvider.createRequestModel.spc_origin_idfk = null;
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
      if (_postFiberProvider.createRequestModel.spc_grade_idfk == null &&
          Ui.showHide(_postFiberProvider.fiberSettings.showGrade)) {
        Ui.showSnackBar(context, 'Please Select Grade');
        return false;
      } else if (_postFiberProvider.createRequestModel.spc_appearance_idfk == null &&
          Ui.showHide(_postFiberProvider.fiberSettings.showAppearance)) {
        Ui.showSnackBar(context, 'Please Select Appearance');
        return false;
      } else if (_postFiberProvider.createRequestModel.spc_brand_idfk == null &&
          Ui.showHide(_postFiberProvider.fiberSettings.showBrand)) {
        Ui.showSnackBar(context, 'Please Select Brand');
        return false;
      } else if (_postFiberProvider.createRequestModel.spc_origin_idfk == null &&
          _postFiberProvider.fiberSettings.showOrigin == "1") {
        Ui.showSnackBar(context, 'Please Select Origin');
        return false;
      } else if (_postFiberProvider.createRequestModel.spc_certificate_idfk == null &&
          Ui.showHide(_postFiberProvider.fiberSettings.showCertification)) {
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
