import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/fiber_response/sync/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/constants.dart';
import 'package:yg_app/utils/numeriacal_range_text_field.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberSpecificationComponent extends StatefulWidget {
  Function? callback;
  SyncFiberResponse syncFiberResponse;
  final String? businessArea;
  final String? selectedTab;

  FiberSpecificationComponent(
      {Key? key,
      required this.syncFiberResponse,
      required this.callback,
      required this.businessArea,
      required this.selectedTab})
      : super(key: key);

  @override
  _FiberSpecificationComponentState createState() =>
      _FiberSpecificationComponentState();
}

class _FiberSpecificationComponentState
    extends State<FiberSpecificationComponent>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedMaterialIndex = 0;
  DateTime selectedDate = DateTime.now();
  final TextEditingController _textEditingController = TextEditingController();
  FiberSettings? _fiberSettings;
  FiberRequestModel? _fiberRequestModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    BroadcastReceiver().subscribe<int> // Data Type returned from publisher
        (AppStrings.materialIndexBroadcast, (index) {
      setState(() {
        _selectedMaterialIndex = index;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _fiberRequestModel = Provider.of<FiberRequestModel?>(context);
    _fiberRequestModel!.spc_grade_idfk =
        widget.syncFiberResponse.data.fiber.grades.first.grdId.toString();
    _fiberRequestModel!.spc_certificate_idfk = widget
        .syncFiberResponse.data.fiber.certification.first.cerId
        .toString();

    return FutureBuilder<List<FiberSettings>>(
      future: getDbInstance().then((value) async {
        return value.fiberSettingDao.findFiberSettings(widget.syncFiberResponse
            .data.fiber.material[_selectedMaterialIndex].fbmId);
      }),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          _fiberSettings = snapshot.data![0];

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
                    padding:
                        EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleTextWidget(
                            title: AppStrings.specifications,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.w),
                            child: Text(
                              AppStrings.selectSpecifications,
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
                                                  EdgeInsets.only(left: 8.w),
                                              child: TitleSmallTextWidget(
                                                  title: 'Grades')),
                                          GridTileWidget(
                                            spanCount: 3,
                                            listOfItems: widget
                                                .syncFiberResponse
                                                .data
                                                .fiber
                                                .grades,
                                            callback: (value) {
                                              _fiberRequestModel!
                                                      .spc_grade_idfk =
                                                  widget.syncFiberResponse.data
                                                      .fiber.grades[value].grdId
                                                      .toString();
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
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'Fiber Length')),
                                              TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      AppColors.lightBlueTabs,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  inputFormatters: [
                                                    NumericalRangeFormatter(
                                                        min: splitMin(snapshot
                                                            .data![0]
                                                            .lengthMinMax),
                                                        max: splitMax(snapshot
                                                            .data![0]
                                                            .lengthMinMax))
                                                  ],
                                                  onSaved: (input) =>
                                                      _fiberRequestModel!
                                                              .spc_fiber_length_idfk =
                                                          input!,
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty) {
                                                      return "Fiber length";
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      roundedTextFieldDecoration(
                                                          "${snapshot.data![0].lengthMinMax} mm")),
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
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title:
                                                          'Micronaire (Mic)')),
                                              TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      AppColors.lightBlueTabs,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  inputFormatters: [
                                                    NumericalRangeFormatter(
                                                        min: splitMin(snapshot
                                                            .data![0]
                                                            .micMinMax),
                                                        max: splitMax(snapshot
                                                            .data![0]
                                                            .micMinMax))
                                                  ],
                                                  onSaved: (input) =>
                                                      _fiberRequestModel!
                                                              .spc_micronaire_idfk =
                                                          input!,
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty) {
                                                      return "Micronaire (Mic)";
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      roundedTextFieldDecoration(
                                                          '${snapshot.data![0].micMinMax} mic')),
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
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'Moisture')),
                                              TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      AppColors.lightBlueTabs,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  onSaved: (input) =>
                                                      _fiberRequestModel!
                                                              .spc_moisture_idfk =
                                                          input!,
                                                  inputFormatters: [
                                                    NumericalRangeFormatter(
                                                        min: splitMin(snapshot
                                                            .data![0]
                                                            .moiMinMax),
                                                        max: splitMax(snapshot
                                                            .data![0]
                                                            .moiMinMax))
                                                  ],
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty) {
                                                      return "Moisture";
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      roundedTextFieldDecoration(
                                                          '${snapshot.data![0].moiMinMax} %')),
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
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.w),
                                                    child: TitleSmallTextWidget(
                                                        title: 'Trash')),
                                                TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor:
                                                        AppColors.lightBlueTabs,
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                    textAlign: TextAlign.center,
                                                    cursorHeight: 16.w,
                                                    onSaved: (input) =>
                                                        _fiberRequestModel!
                                                                .spc_trash_idfk =
                                                            input!,
                                                    inputFormatters: [
                                                      NumericalRangeFormatter(
                                                          min: splitMin(snapshot
                                                              .data![0]
                                                              .trashMinMax),
                                                          max: splitMax(snapshot
                                                              .data![0]
                                                              .trashMinMax))
                                                    ],
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return "Trash";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        roundedTextFieldDecoration(
                                                            '${snapshot.data![0].trashMinMax} %')),
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
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'RD')),
                                              TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      AppColors.lightBlueTabs,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  onSaved: (input) =>
                                                      _fiberRequestModel!
                                                          .spc_rd_idfk = input!,
                                                  inputFormatters: [
                                                    NumericalRangeFormatter(
                                                        min: splitMin(snapshot
                                                            .data![0].rdMinMax),
                                                        max: splitMax(snapshot
                                                            .data![0].rdMinMax))
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
                                                          '${snapshot.data![0].rdMinMax} %')),
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
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'GPT')),
                                              TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  cursorColor:
                                                      AppColors.lightBlueTabs,
                                                  style: TextStyle(
                                                      fontSize: 11.sp),
                                                  textAlign: TextAlign.center,
                                                  cursorHeight: 16.w,
                                                  inputFormatters: [
                                                    NumericalRangeFormatter(
                                                        min: splitMin(snapshot
                                                            .data![0]
                                                            .gptMinMax),
                                                        max: splitMax(snapshot
                                                            .data![0]
                                                            .gptMinMax))
                                                  ],
                                                  onSaved: (input) =>
                                                      _fiberRequestModel!
                                                              .spc_gpt_idfk =
                                                          input!,
                                                  validator: (input) {
                                                    if (input == null ||
                                                        input.isEmpty) {
                                                      return "Enter GPT";
                                                    }
                                                    return null;
                                                  },
                                                  decoration:
                                                      roundedTextFieldDecoration(
                                                          '${snapshot.data![0].gptMinMax} %')),
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
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(
                                                title: 'Apperance')),
                                        GridTileWidget(
                                          spanCount: 2,
                                          listOfItems: widget.syncFiberResponse
                                              .data.fiber.apperance,
                                          callback: (value) {
                                            _fiberRequestModel!
                                                    .spc_appearance_idfk =
                                                widget
                                                    .syncFiberResponse
                                                    .data
                                                    .fiber
                                                    .apperance[value]
                                                    .aprId
                                                    .toString();
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
                                          padding: EdgeInsets.only(top: 8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'Brand')),
                                              SizedBox(
                                                height: 36.w,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppColors
                                                            .lightBlueTabs,
                                                        width:
                                                            1, //                   <--- border width here
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  24.w))),
                                                  child:
                                                      DropdownButtonFormField(
                                                    hint: Text('Select Brand'),
                                                    items: widget
                                                        .syncFiberResponse
                                                        .data
                                                        .fiber
                                                        .brands
                                                        .map((value) =>
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  value.brdName,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                              value: value,
                                                            ))
                                                        .toList(),
                                                    onChanged:
                                                        (BrandsModel? value) {
                                                      _fiberRequestModel!
                                                              .spc_brand_idfk =
                                                          value!.brdId
                                                              .toString();
                                                    },

                                                    // value: widget.syncFiberResponse.data.fiber.brands.first,
                                                    decoration: InputDecoration(
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
                                                        color: AppColors
                                                            .textColorGrey),
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
                                          (snapshot.data![0].showBrand == "1")
                                              ? 16.w
                                              : 0,
                                    ),
                                    Visibility(
                                      visible: true,
                                      child: Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title:
                                                          'Production Year')),
                                              TextFormField(
                                                keyboardType:
                                                    TextInputType.none,
                                                controller:
                                                    _textEditingController,
                                                cursorColor:
                                                    AppColors.lightBlueTabs,
                                                autofocus: false,
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                                textAlign: TextAlign.center,
                                                showCursor: false,
                                                readOnly: true,
                                                onSaved: (input) =>
                                                    _fiberRequestModel!
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
                                                    roundedTextFieldDecoration(
                                                        'Production year'),
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
                                      int.parse(snapshot.data![0].showOrigin) ==
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
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: const TitleSmallTextWidget(
                                                title: 'Country')),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColors.lightBlueTabs,
                                                width:
                                                    1, //                   <--- border width here
                                              ),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24.w))),
                                          child: SizedBox(
                                            height: 36.w,
                                            child: DropdownButtonFormField(
                                              hint:
                                                  const Text('Select country'),
                                              items: widget.syncFiberResponse
                                                  .data.fiber.countries
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        child: Text(
                                                            value.conName,
                                                            textAlign: TextAlign
                                                                .center),
                                                        value: value,
                                                      ))
                                                  .toList(),
                                              onChanged:
                                                  (CountriesModel? value) {
                                                _fiberRequestModel!
                                                        .spc_origin_idfk =
                                                    value!.conId.toString();
                                              },
                                              // value: widget.syncFiberResponse.data.fiber.countries.first,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 16.w,
                                                    right: 6.w,
                                                    top: 0,
                                                    bottom: 0),
                                                border: const OutlineInputBorder(
                                                    borderSide: BorderSide
                                                        .none) /*OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.lightBlueTabs),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(24.w),
                                          ))*/
                                                ,
                                              ),
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color:
                                                      AppColors.textColorGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 8.w),
                                          child: const TitleSmallTextWidget(
                                              title: 'City State')),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.lightBlueTabs,
                                              width:
                                                  1, //                   <--- border width here
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24.w))),
                                        child: SizedBox(
                                          height: 36.w,
                                          child: DropdownButtonFormField(
                                            hint:
                                                const Text('Select City State'),
                                            items: widget.syncFiberResponse.data
                                                .fiber.cityState
                                                .map((value) =>
                                                    DropdownMenuItem(
                                                      child: Text(value.name,
                                                          textAlign:
                                                              TextAlign.center),
                                                      value: value,
                                                    ))
                                                .toList(),
                                            onChanged: (CityState? value) {
                                              _fiberRequestModel!
                                                      .spc_city_state_idfk =
                                                  value!.id.toString();
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 16.w,
                                                  right: 6.w,
                                                  top: 0,
                                                  bottom: 0),
                                              border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                color: AppColors.textColorGrey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Visibility(
                                //   visible: int.parse(snapshot
                                //       .data![0].showLotNumber) ==
                                //       1
                                //       ? true
                                //       : false,
                                  /*child:*/ Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding:
                                            EdgeInsets.only(left: 8.w),
                                            child: const TitleSmallTextWidget(
                                                title: 'Lot Number')),
                                        TextFormField(
                                            keyboardType: TextInputType.text,
                                            cursorColor:
                                            AppColors.lightBlueTabs,
                                            style: TextStyle(fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                            cursorHeight: 16.w,
                                            onSaved: (input) =>
                                            _fiberRequestModel!
                                                .spc_lot_number = input!,
                                            validator: (input) {
                                              if (input == null ||
                                                  input.isEmpty) {
                                                return "Enter Lot Number";
                                              }
                                              return null;
                                            },
                                            decoration:
                                            roundedTextFieldDecoration(
                                                'Lot Number')),
                                      ],
                                    ),
                                  ),
                                // ),
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
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: const TitleSmallTextWidget(
                                                title: 'Certification')),
                                        GridTileWidget(
                                          spanCount: widget.syncFiberResponse
                                              .data.fiber.certification.length,
                                          listOfItems: widget.syncFiberResponse
                                              .data.fiber.certification,
                                          callback: (value) {
                                            _fiberRequestModel!
                                                    .spc_certificate_idfk =
                                                widget
                                                    .syncFiberResponse
                                                    .data
                                                    .fiber
                                                    .certification[value]
                                                    .cerId
                                                    .toString();
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
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButtonWithIcon(
                        callback: () {
                          if (validationAllPage()) {
                            _fiberRequestModel!.spc_category_idfk = widget.syncFiberResponse
                                .data.fiber.material[_selectedMaterialIndex].fbmCategoryIdfk;

                            _fiberRequestModel!.spc_fiber_material_idfk = widget
                                .syncFiberResponse
                                .data
                                .fiber
                                .material[_selectedMaterialIndex]
                                .fbmId
                                .toString();
                            widget.callback!(1);
                          }
                        },
                        color: AppColors.btnColorLogin,
                        btnText: "Next",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
              child: TitleTextWidget(title: snapshot.error.toString()));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
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
      if (_fiberRequestModel!.spc_grade_idfk == null &&
          _fiberSettings!.showGrade == "1") {
        Scaffold.of(context)
            .showSnackBar(const SnackBar(content: Text('Please select Grade')));
      } else if (_fiberRequestModel!.spc_appearance_idfk == null &&
          _fiberSettings!.showAppearance == "1") {
        Scaffold.of(context).showSnackBar(
            const SnackBar(content: Text('Please select Appearance')));
      } else if (_fiberRequestModel!.spc_brand_idfk == null &&
          _fiberSettings!.showBrand == "1") {
        Scaffold.of(context)
            .showSnackBar(const SnackBar(content: Text('Please select Brand')));
      } else if (_fiberRequestModel!.spc_origin_idfk == null &&
          _fiberSettings!.showOrigin == "1") {
        Scaffold.of(context).showSnackBar(
            const SnackBar(content: Text('Please select Country')));
      } else if (_fiberRequestModel!.spc_certificate_idfk == null &&
          _fiberSettings!.showCertification == "1") {
        Scaffold.of(context).showSnackBar(
            const SnackBar(content: Text('Please select Certification')));
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
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now(),
                onChanged: (val) {
                  _textEditingController.text = val.year.toString();
                  Navigator.pop(context);
                },
              ),
            ));
  }
}

double splitMin(String minMax) {
  var splitValue = minMax.split('-');
  return double.parse(splitValue[0]);
}

double splitMax(String minMax) {
  var splitValue = minMax.split('-');
  return double.parse(splitValue[1]);
}

Future<AppDatabase> getDbInstance() async {
  var databaseInstance;
  final database =
      $FloorAppDatabase.databaseBuilder(AppConstants.APP_DATABASE_NAME).build();
  await database.then((value) => {databaseInstance = value});

  return databaseInstance;
}
