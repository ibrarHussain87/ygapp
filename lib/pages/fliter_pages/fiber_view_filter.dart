import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/constants.dart';
import 'package:yg_app/utils/string_util.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget_2.dart';
import 'package:yg_app/widgets/filter_widget/filter_grid_tile_widget.dart';
import 'package:yg_app/widgets/filter_widget/filter_material_listview.dart';
import 'package:yg_app/widgets/filter_widget/filter_range_slider.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberFilterView extends StatefulWidget {
  final SyncFiberResponse syncFiberResponse;

  const FiberFilterView({Key? key, required this.syncFiberResponse})
      : super(key: key);

  @override
  _FiberFilterViewState createState() => _FiberFilterViewState();
}

class _FiberFilterViewState extends State<FiberFilterView> {
  final TextEditingController _textEditingController = TextEditingController();

  // Map<String, dynamic> mapParams = {};
  GetSpecificationRequestModel? _fiberFilterRequestModel;

  List<FiberSettings> listOfSettings = [];
  List<int> listOfMaterials = [];
  List<int> listOfGrades = [];
  List<int> listOfMic = [];
  List<int> listOfMos = [];
  List<int> listOfAppearance = [];
  List<int> listOfCertification = [];
  List<int> listOfPacking = [];
  double? minValueMicParam;
  double? maxValueMicParam;
  double? minValueMosParam;
  double? maxValueMosParam;
  bool isListClear = false;
  double minMois = 0.0;
  double minRd = 0.0;
  double minTrash = 0.0;
  double minMic = 0.0;
  double minGpt = 0.0;
  double maxMois = 0.0;
  double maxRd = 0.0;
  double maxTrash = 0.0;
  double maxMic = 0.0;
  double maxGpt = 0.0;

  @override
  void initState() {
    _fiberFilterRequestModel = GetSpecificationRequestModel();
    setState(() {
      listOfSettings = widget.syncFiberResponse.data.fiber.settings;
      _optimizeSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 16.w, left: 16.w, right: 16.w, bottom: 16.w),
                        child: const TitleTextWidget(
                          title: 'Fiber Material',
                        ),
                      ),
                      SizedBox(
                        height: 58.w,
                        child: FilterMaterialWidget(
                          listItem:
                              widget.syncFiberResponse.data.fiber.material,
                          onClickCallback: (value) {
                            _querySetting((value as FiberMaterial).fbmId);
                            _fiberFilterRequestModel!.fiberMaterialId =
                                filterList(listOfMaterials, (value).fbmId);
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                              child: TitleSmallTextWidget(
                                  title: AppStrings.grades)),
                          FilterGridTileWidget(
                            spanCount: 3,
                            listOfItems:
                                widget.syncFiberResponse.data.fiber.grades,
                            callback: (index) {
                              _fiberFilterRequestModel!.gradeId = filterList(
                                  listOfGrades,
                                  widget.syncFiberResponse.data.fiber
                                      .grades[index].grdId);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Divider(),
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].micMinMax,
                        minValue: minMic,
                        maxValue: maxMic,
                        hintTxt: "Micronaire (Mic)",
                        minCallback: (value) {
                          minValueMicParam = value;
                        },
                        maxCallback: (value) {
                          maxValueMicParam = value;
                        },
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Divider(),
                      FilterRangeSlider(
                        // minMaxRange: widget.syncFiberResponse.data.fiber
                        //     .settings[0].moiMinMax,
                        minValue: minMois,
                        maxValue: maxMois,
                        hintTxt: "Moisture",
                        minCallback: (value) {
                          minValueMosParam = value;
                        },
                        maxCallback: (value) {
                          maxValueMosParam = value;
                        },
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Divider(),
                      Visibility(
                        visible: true,
                        child: FilterRangeSlider(
                          minValue: minRd,
                          maxValue: maxRd,
                          hintTxt: "RD",
                          minCallback: (value) {},
                          maxCallback: (value) {},
                        ),
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 8.w, top: 4.0.w, bottom: 8.w),
                              child: const TitleSmallTextWidget(
                                  title: 'Appearance')),
                          FilterGridTileWidget(
                            spanCount: 2,
                            listOfItems:
                                widget.syncFiberResponse.data.fiber.apperance,
                            callback: (index) {
                              _fiberFilterRequestModel!.apperanceId =
                                  filterList(
                                      listOfAppearance,
                                      widget.syncFiberResponse.data.fiber
                                          .apperance[index].aprId);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.w, top: 4.0.w, bottom: 8.w),
                                    child: const TitleSmallTextWidget(
                                        title: 'Production Year')),
                                TextFormField(
                                  keyboardType: TextInputType.none,
                                  controller: _textEditingController,
                                  cursorColor: AppColors.lightBlueTabs,
                                  autofocus: false,
                                  style: TextStyle(fontSize: 11.sp),
                                  textAlign: TextAlign.center,
                                  showCursor: false,
                                  readOnly: true,
                                  onSaved: (input) {
                                    _fiberFilterRequestModel!.productionYear =
                                        input;
                                  },
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return "Please enter production year";
                                    }
                                    return null;
                                  },
                                  decoration: roundedTFDGrey('Production year'),
                                  onTap: () {
                                    handleReadOnlyInputClick(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.w, top: 4.2, bottom: 8.w),
                                    child: const TitleSmallTextWidget(
                                        title: 'Country')),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width:
                                            1, //                   <--- border width here
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24.w))),
                                  child: SizedBox(
                                    height: 36.w,
                                    width: double.maxFinite,
                                    child: DropdownButtonFormField(
                                      isExpanded: true,
                                      hint: const Text(
                                        'Select country',
                                        style:
                                            TextStyle(fontFamily: 'Metropolis'),
                                      ),
                                      items: widget.syncFiberResponse.data.fiber
                                          .countries
                                          .map((value) => DropdownMenuItem(
                                                child: Text(value.conName,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontFamily:
                                                            'Metropolis')),
                                                value: value,
                                              ))
                                          .toList(),
                                      onChanged: (Countries? value) {
                                        List<int> originList = [value!.conId];
                                        _fiberFilterRequestModel!.originId =
                                            originList;
                                      },
                                      // value: widget.syncFiberResponse.data.fiber.countries.first,
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
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 8.w, top: 4.2, bottom: 8.w),
                              child: const TitleSmallTextWidget(
                                  title: 'Certification')),
                          FilterGridTileWidget(
                            spanCount: 4,
                            listOfItems: widget
                                .syncFiberResponse.data.fiber.certification,
                            callback: (value) {
                              _fiberFilterRequestModel!.certificationId =
                                  filterList(
                                      listOfCertification,
                                      widget.syncFiberResponse.data.fiber
                                          .certification[value].cerId);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 8.w, top: 4.2, bottom: 8.w),
                              child:
                                  const TitleSmallTextWidget(title: 'Packing')),
                          FilterGridTileWidget(
                            spanCount: 3,
                            listOfItems:
                                widget.syncFiberResponse.data.fiber.packing,
                            callback: (value) {
                              // mapParams['packing_id[]'] = filterList(
                              //     listOfPacking,
                              //     widget.syncFiberResponse.data.fiber
                              //         .packing[value].pacId);
                              _fiberFilterRequestModel!.packingId = filterList(
                                  listOfPacking,
                                  widget.syncFiberResponse.data.fiber
                                      .packing[value].pacId);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButtonWithoutIcon(
                      callback: () {},
                      color: Colors.grey.shade300,
                      btnText: 'Reset',
                      textColor: 'black',
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: ElevatedButtonWithoutIcon(
                        callback: () {
                          if (minValueMicParam != null &&
                              maxValueMicParam != null) {
                            listOfMic = [
                              minValueMicParam!.toInt(),
                              maxValueMicParam!.toInt()
                            ];
                            // mapParams['micronaire[]'] = listOfMic;
                            _fiberFilterRequestModel!.micronaire = listOfMic;
                          }

                          if (minValueMosParam != null &&
                              maxValueMosParam != null) {
                            listOfMos = [
                              minValueMosParam!.toInt(),
                              maxValueMosParam!.toInt()
                            ];
                            // mapParams['moisture[]'] = listOfMos;
                            _fiberFilterRequestModel!.moisture = listOfMos;
                          }
                          // listOfMos = [minValueMosParam != null? minValueMosParam!.toInt() :"" ,maxValueMosParam != null? maxValueMosParam!.toInt() :""];
                          // print(mapParams);
                          Navigator.pop(context, _fiberFilterRequestModel);
                        },
                        color: AppColors.textColorBlue,
                        btnText: 'Apply Filter'),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  //
  // _queryAllSettings() {
  //   getDbInstance().then((value){
  //      value.fiberSettingDao.findAllFiberSettings().then((value) {
  //       setState(() {
  //         listOfSettings = value;
  //         _optimizeSettings();
  //       });
  //     });
  //   });
  // }

  _querySetting(int id) {
    getDbInstance().then(
        (value) => value.fiberSettingDao.findFiberSettings(id).then((value) {
              setState(() {
                if (!isListClear) {
                  listOfSettings.clear();
                  isListClear = true;
                }
                if (listOfSettings.contains(value[0])) {
                  listOfSettings.remove(value[0]);
                } else {
                  listOfSettings.add(value[0]);
                }
                _optimizeSettings();
              });
            }));
  }

  _optimizeSettings() {
    for (var element in listOfSettings) {
      if (StringUtils.splitMin(element.micMinMax) > minMic) {
        minMic = StringUtils.splitMin(element.micMinMax);
      }
      if (StringUtils.splitMax(element.micMinMax) > maxMic) {
        maxMic = StringUtils.splitMax(element.micMinMax);
      }
      if (StringUtils.splitMin(element.moiMinMax) > minMois) {
        minMois = StringUtils.splitMin(element.moiMinMax);
      }
      if (StringUtils.splitMax(element.moiMinMax) > maxMois) {
        maxMois = StringUtils.splitMax(element.moiMinMax);
      }
      if (StringUtils.splitMin(element.rdMinMax) > minRd) {
        minRd = StringUtils.splitMin(element.rdMinMax);
      }
      if (StringUtils.splitMax(element.rdMinMax) > maxRd) {
        maxRd = StringUtils.splitMax(element.rdMinMax);
      }
      if (StringUtils.splitMin(element.gptMinMax) > minGpt) {
        minGpt = StringUtils.splitMin(element.gptMinMax);
      }
      if (StringUtils.splitMax(element.gptMinMax) > maxGpt) {
        maxGpt = StringUtils.splitMax(element.gptMinMax);
      }
      if (StringUtils.splitMin(element.trashMinMax) > minTrash) {
        minTrash = StringUtils.splitMin(element.trashMinMax);
      }
      if (StringUtils.splitMax(element.trashMinMax) > maxTrash) {
        maxTrash = StringUtils.splitMax(element.trashMinMax);
      }
    }
  }

  void handleReadOnlyInputClick(context) {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) => SizedBox(
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

  List<int> filterList(List<int> list, int value) {
    if (list.contains(value)) {
      list.remove(value);
    } else {
      list.add(value);
    }

    return list;
  }

  Future<AppDatabase> getDbInstance() async {
    var databaseInstance;
    final database = $FloorAppDatabase
        .databaseBuilder(AppConstants.APP_DATABASE_NAME)
        .build();
    await database.then((value) => {databaseInstance = value});

    return databaseInstance;
  }
}
