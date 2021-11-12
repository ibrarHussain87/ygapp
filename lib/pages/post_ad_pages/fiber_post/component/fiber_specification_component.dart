import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_brands.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_countries.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/constants.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberSpecificationComponent extends StatefulWidget {
  Function? callback;
  SyncFiberResponse syncFiberResponse;

  FiberSpecificationComponent(
      {Key? key, required this.syncFiberResponse, required this.callback})
      : super(key: key);

  @override
  _FiberSpecificationComponentState createState() =>
      _FiberSpecificationComponentState();
}

class _FiberSpecificationComponentState
    extends State<FiberSpecificationComponent> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedMaterialIndex = 0;

  @override
  void initState() {
    /// Subscription Example
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
    return FutureBuilder<List<FiberSettings>>(
      future: getDbInstance().then((value) async {
        // await value.fiberSettingDao.deleteAll(data!.data.fiber.settings);
        return value.fiberSettingDao.findFiberSettings(widget.syncFiberResponse
            .data.fiber.material[_selectedMaterialIndex].fbmId);
      }),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
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
                              mainAxisSize: MainAxisSize.min,
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
                                            callback: (value) {},
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
                                          padding: EdgeInsets.only(top:8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'Fiber Length')),
                                              SizedBox(
                                                height: 36.w,
                                                child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor:
                                                        AppColors.lightBlueTabs,
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                    textAlign: TextAlign.center,
                                                    cursorHeight: 16.w,
                                                    // onSaved: (input) =>
                                                    // userName = input!,
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return "Please enter fiber length";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        roundedTextFieldDecoration(
                                                            "${snapshot.data![0].lengthMinMax} mm")),
                                              ),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (snapshot.data![0].showLength== "1" && snapshot.data![0].showMicronaire == "1")? 16.w: 0,
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
                                                  padding:
                                                      EdgeInsets.only(left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'Micronaire (Mic)')),
                                              SizedBox(
                                                height: 36.w,
                                                child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor:
                                                        AppColors.lightBlueTabs,
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                    textAlign: TextAlign.center,
                                                    cursorHeight: 16.w,
                                                    // onSaved: (input) =>
                                                    // userName = input!,
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return "Please enter Micronaire (Mic)";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        roundedTextFieldDecoration(
                                                            '${snapshot.data![0].micMinMax} mic')),
                                              ),
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
                                                  padding:
                                                      EdgeInsets.only(left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'Moisture')),
                                              SizedBox(
                                                height: 36.w,
                                                child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor:
                                                        AppColors.lightBlueTabs,
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                    textAlign: TextAlign.center,
                                                    cursorHeight: 16.w,
                                                    // onSaved: (input) =>
                                                    // userName = input!,
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return "Please enter Moisture";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        roundedTextFieldDecoration(
                                                            '${snapshot.data![0].moiMinMax} %')),
                                              ),
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
                                      width: (snapshot.data![0].showMoisture== "1" && snapshot.data![0].showTrash == "1")? 16.w: 0,
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
                                                SizedBox(
                                                  height: 36.w,
                                                  child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      cursorColor:
                                                          AppColors.lightBlueTabs,
                                                      style: TextStyle(
                                                          fontSize: 11.sp),
                                                      textAlign: TextAlign.center,
                                                      cursorHeight: 16.w,
                                                      // onSaved: (input) =>
                                                      // userName = input!,
                                                      validator: (input) {
                                                        if (input == null ||
                                                            input.isEmpty) {
                                                          return "Please enter Trash";
                                                        }
                                                        return null;
                                                      },
                                                      decoration:
                                                          roundedTextFieldDecoration(
                                                              '${snapshot.data![0].trashMinMax} %')),
                                                ),
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
                                                  padding:
                                                      EdgeInsets.only(left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'RD')),
                                              SizedBox(
                                                height: 36.w,
                                                child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor:
                                                        AppColors.lightBlueTabs,
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                    textAlign: TextAlign.center,
                                                    cursorHeight: 16.w,
                                                    // onSaved: (input) =>
                                                    // userName = input!,
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return "Please enter RD";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        roundedTextFieldDecoration(
                                                            '${snapshot.data![0].rdMinMax} %')),
                                              ),
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
                                      width: (snapshot.data![0].showRd== "1" && snapshot.data![0].showGpt == "1")? 16.w: 0,
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
                                                  padding:
                                                      EdgeInsets.only(left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'GPT')),
                                              SizedBox(
                                                height: 36.w,
                                                child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    cursorColor:
                                                        AppColors.lightBlueTabs,
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                    textAlign: TextAlign.center,
                                                    cursorHeight: 16.w,
                                                    // onSaved: (input) =>
                                                    // userName = input!,
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return "Please enter GPT";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        roundedTextFieldDecoration(
                                                            '${snapshot.data![0].gptMinMax} %')),
                                              ),
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
                                          callback: (value) {},
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
                                                  padding:
                                                      EdgeInsets.only(left: 8.w),
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
                                                  child: DropdownButtonFormField(
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
                                                        (FiberBrands? value) {},
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
                                      width: (snapshot.data![0].showBrand== "1")? 16.w: 0,
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
                                                  padding:
                                                      EdgeInsets.only(left: 8.w),
                                                  child: TitleSmallTextWidget(
                                                      title: 'Production Year')),
                                              SizedBox(
                                                height: 36.w,
                                                child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.text,
                                                    cursorColor:
                                                        AppColors.lightBlueTabs,
                                                    style: TextStyle(
                                                        fontSize: 11.sp),
                                                    textAlign: TextAlign.center,
                                                    showCursor: false,

                                                    // onSaved: (input) =>
                                                    // userName = input!,
                                                    validator: (input) {
                                                      if (input == null ||
                                                          input.isEmpty) {
                                                        return "Please enter production year";
                                                      }
                                                      return null;
                                                    },
                                                    decoration:
                                                        roundedTextFieldDecoration(
                                                            'Production year')),
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
                                            child: TitleSmallTextWidget(
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
                                              hint: Text('Select country'),
                                              items: widget.syncFiberResponse.data
                                                  .fiber.countries
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        child: Text(value.conName,
                                                            textAlign:
                                                                TextAlign.center),
                                                        value: value,
                                                      ))
                                                  .toList(),
                                              onChanged:
                                                  (FiberCountries? value) {},
                                              // value: widget.syncFiberResponse.data.fiber.countries.first,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 16.w,
                                                    right: 6.w,
                                                    top: 0,
                                                    bottom: 0),
                                                border: OutlineInputBorder(
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
                                                  color: AppColors.textColorGrey),
                                            ),
                                          ),
                                        ),
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
                                    padding: EdgeInsets.only(top: 8.w,bottom: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(
                                                title: 'Certification')),
                                        GridTileWidget(
                                          spanCount: widget.syncFiberResponse
                                              .data.fiber.certification.length,
                                          listOfItems: widget.syncFiberResponse
                                              .data.fiber.certification,
                                          callback: (value) {},
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
                        callback: () {},
                        color: AppColors.btnColorLogin,
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
}

Future<AppDatabase> getDbInstance() async {
  var databaseInstance;
  final database =
      $FloorAppDatabase.databaseBuilder(AppConstants.APP_DATABASE_NAME).build();
  await database.then((value) => {databaseInstance = value});

  return databaseInstance;
}
