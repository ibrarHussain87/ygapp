import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/string_util.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/utils/ui_utils.dart';
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

  GetSpecificationRequestModel? _getSpecificationRequestModel;

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

  bool? showLength;
  bool? showGrade;
  bool? showMicronaire;
  bool? showMoisture;
  bool? showTrash;
  bool? showRd;
  bool? showGpt;
  bool? showAppearance;
  bool? showBrand;
  bool? showOrigin;
  bool? showCertification;
  bool? showCountUnit;
  bool? showDeliveryPeriod;
  bool? showAvailableForMarket;
  bool? showPriceTerms;
  bool? showLotNumber;

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
    _getSpecificationRequestModel = GetSpecificationRequestModel();
    setState(() {
      _minMaxConfiguration();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
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
                            _getSpecificationRequestModel!.fiberMaterialId =
                                filterList(listOfMaterials, (value).fbmId);
                          },
                        ),
                      ),
                      Visibility(
                        visible: showGrade ?? true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding:
                                EdgeInsets.only(left: 8.w, bottom: 8.w),
                                child: TitleSmallTextWidget(
                                    title: AppStrings.grades)),
                            FilterGridTileWidget(
                              spanCount: 3,
                              listOfItems:
                              widget.syncFiberResponse.data.fiber.grades,
                              callback: (index) {
                                _getSpecificationRequestModel!.gradeId =
                                    filterList(
                                        listOfGrades,
                                        widget.syncFiberResponse.data.fiber
                                            .grades[index].grdId);
                              },
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: showMicronaire ?? true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                          ],
                        ),
                      ),
                      Visibility(
                          visible: showMoisture ?? true,
                          child: Column(
                            children: [
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
                            ],
                          )),
                      Visibility(
                        visible: showRd ?? true,
                        child: Column(
                          children: [
                            FilterRangeSlider(
                              minValue: minRd,
                              maxValue: maxRd,
                              hintTxt: "RD",
                              minCallback: (value) {},
                              maxCallback: (value) {},
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: showAppearance ?? true,
                          child: Column(
                            children: [
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
                                    listOfItems: widget
                                        .syncFiberResponse.data.fiber.apperance,
                                    callback: (index) {
                                      _getSpecificationRequestModel!
                                          .apperanceId =
                                          filterList(
                                              listOfAppearance,
                                              widget
                                                  .syncFiberResponse
                                                  .data
                                                  .fiber
                                                  .apperance[index]
                                                  .aprId);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4.w,
                              ),
                              Divider(),
                            ],
                          )),
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
                          Visibility(
                              visible: showOrigin ?? true,
                              child: Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.w, top: 4.w, bottom: 8.w),
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
                                              style: TextStyle(
                                                  fontFamily: 'Metropolis'),
                                            ),
                                            items: widget.syncFiberResponse.data
                                                .fiber.countries
                                                .map((value) => DropdownMenuItem(
                                              child: Text(value.conName??"",
                                                  textAlign:
                                                  TextAlign.center,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                      'Metropolis')),
                                              value: value,
                                            ))
                                                .toList(),
                                            onChanged: (Countries? value) {
                                              List<int> originList = [
                                                value!.conId
                                              ];
                                              _getSpecificationRequestModel!
                                                  .originId = originList;
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
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Divider(),
                      Visibility(
                        visible: showCertification ?? true,
                        child: Column(
                          children: [
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
                                  listOfItems: widget.syncFiberResponse.data
                                      .fiber.certification,
                                  callback: (value) {
                                    _getSpecificationRequestModel!
                                        .certificationId =
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
                          ],
                        ),
                      ),
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
                              _getSpecificationRequestModel!.packingId =
                                  filterList(
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
                      callback: () {
                        setState(() {
                          _getSpecificationRequestModel =
                              GetSpecificationRequestModel();
                        });
                      },
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
                            _getSpecificationRequestModel!.micronaire =
                                listOfMic;
                          }

                          if (minValueMosParam != null &&
                              maxValueMosParam != null) {
                            listOfMos = [
                              minValueMosParam!.toInt(),
                              maxValueMosParam!.toInt()
                            ];
                            _getSpecificationRequestModel!.moisture = listOfMos;
                          }
                          Navigator.pop(context, _getSpecificationRequestModel);
                        },
                        color: AppColors.textColorBlue,
                        btnText: 'Apply Filter'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _querySetting(int id) {
    AppDbInstance.getDbInstance().then(
        (value) => value.fiberSettingDao.findFiberSettings(id).then((value) {
              late bool isSettingInList;
              late FiberSettings _fiberSettings;

              if (!isListClear) {
                listOfSettings.clear();
                isListClear = true;
              }
              if (listOfSettings.isNotEmpty) {
                for (var element in listOfSettings) {
                  _fiberSettings = value[0];

                  if (element.fbsFiberMaterialIdfk ==
                      _fiberSettings.fbsFiberMaterialIdfk) {
                    isSettingInList = true;
                    break;
                  } else {
                    isSettingInList = false;
                  }
                }

                isSettingInList
                    ? listOfSettings.removeWhere((element) =>
                        element.fbsFiberMaterialIdfk ==
                        _fiberSettings.fbsFiberMaterialIdfk)
                    // ? listOfSettings.toSet().toList()
                    : listOfSettings.add(_fiberSettings);
              } else {
                listOfSettings.add(value[0]);
              }
              _minMaxConfiguration();
              _showHideConfiguration();
            }));
  }

  _minMaxConfiguration() {
    for (var element in listOfSettings.isEmpty
        ? widget.syncFiberResponse.data.fiber.settings
        : listOfSettings) {
      _setMinMaxConfiguration(element);
    }
  }

  void _setMinMaxConfiguration(FiberSettings element) {
    setState(() {
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
    });
  }

  void _showHideConfiguration() {
    bool? tempShowGrade;
    bool? tempShowMic;
    bool? tempShowMos;
    bool? tempShowRd;
    bool? tempShowAppearance;
    bool? tempShowOrigin;
    bool? tempShowCertification;

    if (listOfSettings.isNotEmpty) {
      for (var element in listOfSettings) {
        // setState(() {
        tempShowGrade = tempShowGrade == null
            ? Ui.showHide(element.showGrade)
            : (showGrade! && Ui.showHide(element.showGrade) && tempShowGrade)
                ? true
                : false;

        tempShowMic = tempShowMic == null
            ? Ui.showHide(element.showMicronaire)
            : (showMicronaire! &&
                    Ui.showHide(element.showMicronaire) &&
                    tempShowMic)
                ? true
                : false;

        tempShowMos = tempShowMos == null
            ? Ui.showHide(element.showMoisture)
            : (showMoisture! &&
                    Ui.showHide(element.showMoisture) &&
                    tempShowMos)
                ? true
                : false;

        tempShowRd = tempShowRd == null
            ? Ui.showHide(element.showRd)
            : (showRd! && Ui.showHide(element.showRd) && tempShowRd)
                ? true
                : false;

        tempShowAppearance = tempShowAppearance == null
            ? Ui.showHide(element.showAppearance)
            : (showAppearance! &&
                    Ui.showHide(element.showAppearance) &&
                    tempShowAppearance)
                ? true
                : false;

        tempShowOrigin = tempShowOrigin == null
            ? Ui.showHide(element.showOrigin)
            : (showOrigin! &&
                    Ui.showHide(element.showOrigin) &&
                    tempShowOrigin)
                ? true
                : false;

        tempShowCertification = tempShowCertification == null
            ? Ui.showHide(element.showCertification)
            : (showCertification! &&
                    Ui.showHide(element.showCertification) &&
                    tempShowCertification)
                ? true
                : false;

        // });
      }

      setState(() {
        showGrade = tempShowGrade;
        showMicronaire = tempShowMic;
        showMoisture = tempShowMos;
        showCertification = tempShowCertification;
        showAppearance = tempShowAppearance;
        showOrigin = tempShowOrigin;
        showRd = tempShowRd;
      });
    } else {
      setState(() {
        showGrade = null;
        showMicronaire = null;
        showLength = null;
        showMoisture = null;
        showTrash = null;
        showRd = null;
        showGpt = null;
        showAppearance = null;
        showBrand = null;
        showOrigin = null;
        showCertification = null;
        showCountUnit = null;
        showDeliveryPeriod = null;
        showAvailableForMarket = null;
        showPriceTerms = null;
        showLotNumber = null;
      });
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
                  _getSpecificationRequestModel!.productionYear =
                      val.year.toString();
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
}
