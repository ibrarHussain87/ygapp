import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/filter_widget/filter_range_slider.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/common_response_models/packing_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_family_component.dart';

class FiberFilterView extends StatefulWidget {
  // final SyncFiberResponse syncFiberResponse;

  const FiberFilterView({Key? key}) : super(key: key);

  @override
  _FiberFilterViewState createState() => _FiberFilterViewState();
}

class _FiberFilterViewState extends State<FiberFilterView> {
  final TextEditingController _textEditingController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GetSpecificationRequestModel? _getSpecificationRequestModel;

  List<FiberMaterial>? _fiberMaterials;
  List<FiberAppearance>? _fiberAppearances;
  List<Grades>? _fiberGrades;
  List<Certification>? _fiberCertifications;
  List<Packing>? _fiberPacking;
  List<Countries>? _countries;
  List<FiberSettings>? _listOfSettings;
  List<int> _listOfMaterials = [];
  List<int> _listOfGrades = [];
  List<double> _listOfMic = [];
  List<double> _listOfMos = [];
  List<double> _listOfRd = [];
  List<double> _listOfGpt = [];
  List<int> _listOfAppearance = [];
  List<int> _listOfCertification = [];
  List<int> _listOfPacking = [];

  double? micValue;
  double? moisValue;
  double? rdValue;
  double? gptValue;

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

  _querySetting(int id) {
    AppDbInstance.getDbInstance()
        .then((db) => db.fiberSettingDao.findFiberSettings(id).then((value) {
      late bool isSettingInList;
      late FiberSettings _fiberSettings;

      if (!isListClear) {
        _listOfSettings!.clear();
        isListClear = false;
      }
      if (_listOfSettings!.isNotEmpty) {
        for (var element in _listOfSettings!) {
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
            ? _listOfSettings!.removeWhere((element) =>
        element.fbsFiberMaterialIdfk ==
            _fiberSettings.fbsFiberMaterialIdfk)
        // ? listOfSettings.toSet().toList()
            : _listOfSettings!.add(_fiberSettings);
      } else {
        _listOfSettings!.add(value[0]);
      }
      _minMaxConfiguration();
      _showHideConfiguration();
    }));
  }

  _minMaxConfiguration() {
    for (var element in _listOfSettings!) {
      _setMinMaxConfiguration(element);
    }
  }

  _setMinMaxConfiguration(FiberSettings element) {
    setState(() {
      if (Utils.splitMin(element.micMinMax) > minMic) {
        minMic = Utils.splitMin(element.micMinMax);
      }
      if (Utils.splitMax(element.micMinMax) > maxMic) {
        maxMic = Utils.splitMax(element.micMinMax);
      }
      if (Utils.splitMin(element.moiMinMax) > minMois) {
        minMois = Utils.splitMin(element.moiMinMax);
      }
      if (Utils.splitMax(element.moiMinMax) > maxMois) {
        maxMois = Utils.splitMax(element.moiMinMax);
      }
      if (Utils.splitMin(element.rdMinMax) > minRd) {
        minRd = Utils.splitMin(element.rdMinMax);
      }
      if (Utils.splitMax(element.rdMinMax) > maxRd) {
        maxRd = Utils.splitMax(element.rdMinMax);
      }
      if (Utils.splitMin(element.gptMinMax) > minGpt) {
        minGpt = Utils.splitMin(element.gptMinMax);
      }
      if (Utils.splitMax(element.gptMinMax) > maxGpt) {
        maxGpt = Utils.splitMax(element.gptMinMax);
      }
      if (Utils.splitMin(element.trashMinMax) > minTrash) {
        minTrash = Utils.splitMin(element.trashMinMax);
      }
      if (Utils.splitMax(element.trashMinMax) > maxTrash) {
        maxTrash = Utils.splitMax(element.trashMinMax);
      }
    });
  }

  _showHideConfiguration() {
    bool? tempShowGrade;
    bool? tempShowMic;
    bool? tempShowMos;
    bool? tempShowRd;
    bool? tempShowAppearance;
    bool? tempShowOrigin;
    bool? tempShowCertification;

    if (_listOfSettings!.isNotEmpty) {
      for (var element in _listOfSettings!) {
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
            : (showOrigin! && Ui.showHide(element.showOrigin) && tempShowOrigin)
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

  handleReadOnlyInputClick(context) {
    showModalBottomSheet(
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

  List<int> _filterList(List<int> list, int value) {
    // if (list.contains(value)) {
    //   list.remove(value);
    // } else {
    list.clear();
    list.add(value);
    // }

    return list.toSet().toList();
  }

  _getSyncedFiberData() {
    AppDbInstance.getDbInstance().then((value) async {
      await value.fiberMaterialDao
          .findFiberMaterialsWithNature(1)
          .then((value) => setState(() => _fiberMaterials = value));
      await value.gradesDao
          .findGradeWithCatId(1)
          .then((value) => setState(() => _fiberGrades = value));
      await value.countriesDao
          .findAllCountries()
          .then((value) => setState(() => setState(() => _countries = value)));
      await value.fiberAppearanceDoa
          .findAllFiberAppearance()
          .then((value) => setState(() => _fiberAppearances = value));
      await value.certificationDao
          .findCertificationWithCatId(1)
          .then((value) => _fiberCertifications = value);
      await value.packingDao
          .findAllPacking()
          .then((value) => setState(() => _fiberPacking = value));

      await value.fiberSettingDao
          .findFiberSettings(_fiberMaterials!.first.fbmId)
          .then((value) => setState(() {
        _listOfSettings = [value[0]];
        _minMaxConfiguration();
      }));
    });
  }

  @override
  void initState() {
    _getSpecificationRequestModel = GetSpecificationRequestModel();
    _getSyncedFiberData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: (_countries != null &&
                    _fiberAppearances != null &&
                    _fiberCertifications != null &&
                    _fiberGrades != null &&
                    _fiberPacking != null &&
                    _listOfSettings != null)
                ? Container(
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
                                        left: 4.w,top:16.w,right: 4.w),
                                    child: const TitleTextWidget(
                                        title: 'Select specification')),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: FiberFamilyComponent(
                                    selectedIndex: -1,
                                      callback: (FiberMaterial value) {
                                    _querySetting(value.fbmId);
                                    _getSpecificationRequestModel!
                                            .fiberMaterialId =
                                        _filterList(
                                            _listOfMaterials, (value).fbmId);
                                  }),
                                ),
                                //Show Grade
                                Visibility(
                                  visible: showGrade ?? true,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.w, bottom: 8.w),
                                          child: TitleSmallTextWidget(
                                              title: grades)),
                                      SingleSelectTileWidget(
                                        selectedIndex: -1,
                                        spanCount: 3,
                                        listOfItems: _fiberGrades!,
                                        callback: (Grades value) {
                                          _getSpecificationRequestModel!
                                                  .gradeId =
                                              _filterList(
                                                  _listOfGrades, value.grdId!);
                                        },
                                      ),
                                      SizedBox(
                                        height: 4.w,
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),

                                Visibility(
                                  visible: showMicronaire ?? true,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FilterRangeSlider(
                                        // minMaxRange: widget.syncFiberResponse.data.fiber
                                        //     .settings[0].micMinMax,
                                        minValue: minMic,
                                        maxValue: maxMic,
                                        hintTxt: "Micronaire (Mic)",
                                        valueCallback: (value) {},
                                        // minCallback: (value) {
                                        //   minValueMicParam = value;
                                        // },
                                        // maxCallback: (value) {
                                        //   maxValueMicParam = value;
                                        // },
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
                                          // minCallback: (value) {
                                          //   minValueMosParam = value;
                                          // },
                                          // maxCallback: (value) {
                                          //   maxValueMosParam = value;
                                          // },
                                          valueCallback: (value) {},
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
                                        // minCallback: (value) {},
                                        // maxCallback: (value) {},
                                        valueCallback: (value) {},
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 8.w,
                                                    top: 4.0.w,
                                                    bottom: 8.w),
                                                child:
                                                    const TitleSmallTextWidget(
                                                        title: 'Appearance')),
                                            SingleSelectTileWidget(
                                              selectedIndex: -1,
                                              spanCount: 2,
                                              listOfItems: _fiberAppearances!,
                                              callback:
                                                  (FiberAppearance value) {
                                                _getSpecificationRequestModel!
                                                        .apperanceId =
                                                    _filterList(
                                                        _listOfAppearance,
                                                        value.aprId!);
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.w,
                                                  top: 4.0.w,
                                                  bottom: 8.w),
                                              child: const TitleSmallTextWidget(
                                                  title: 'Production Year')),
                                          TextFormField(
                                            keyboardType: TextInputType.none,
                                            controller: _textEditingController,
                                            cursorColor: lightBlueTabs,
                                            autofocus: false,
                                            style: TextStyle(fontSize: 11.sp),
                                            textAlign: TextAlign.center,
                                            showCursor: false,
                                            readOnly: true,
                                            validator: (input) {
                                              if (input == null ||
                                                  input.isEmpty) {
                                                return "Please enter production year";
                                              }
                                              return null;
                                            },
                                            decoration: roundedTFDGrey(
                                                'Production year'),
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
                                            padding:
                                                EdgeInsets.only(left: 16.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.w,
                                                        top: 4.w,
                                                        bottom: 8.w),
                                                    child:
                                                        const TitleSmallTextWidget(
                                                            title: 'Country')),
                                                Container(
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
                                                                  24.w))),
                                                  child: SizedBox(
                                                    height: 36.w,
                                                    width: double.maxFinite,
                                                    child:
                                                        DropdownButtonFormField(
                                                      isExpanded: true,
                                                      hint: const Text(
                                                        'Select country',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Metropolis'),
                                                      ),
                                                      items: _countries!
                                                          .map((value) =>
                                                              DropdownMenuItem(
                                                                child: Text(
                                                                    value.conName ??
                                                                        "",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Metropolis')),
                                                                value: value,
                                                              ))
                                                          .toList(),
                                                      onChanged:
                                                          (Countries? value) {
                                                        List<int> originList = [
                                                          value!.conId
                                                        ];
                                                        _getSpecificationRequestModel!
                                                                .originId =
                                                            originList;
                                                      },
                                                      // value: widget.syncFiberResponse.data.fiber.countries.first,
                                                      decoration:
                                                          InputDecoration(
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
                                        ))
                                  ],
                                ),

                                SizedBox(
                                  height: 4.w,
                                ),

                                const Divider(),

                                Visibility(
                                  visible: showCertification ?? true,
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.w,
                                                  top: 4.2,
                                                  bottom: 8.w),
                                              child: const TitleSmallTextWidget(
                                                  title: 'Certification')),
                                          SingleSelectTileWidget(
                                            selectedIndex: -1,
                                            spanCount: 4,
                                            listOfItems: _fiberCertifications!,
                                            callback: (Certification value) {
                                              _getSpecificationRequestModel!
                                                      .certificationId =
                                                  _filterList(
                                                      _listOfCertification,
                                                      value.cerId);
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
                                        child: const TitleSmallTextWidget(
                                            title: 'Packing')),
                                    SingleSelectTileWidget(
                                      selectedIndex: -1,
                                      spanCount: 3,
                                      listOfItems: _fiberPacking!,
                                      callback: (Packing value) {
                                        _getSpecificationRequestModel!
                                                .packingId =
                                            _filterList(
                                                _listOfPacking, value.pacId);
                                      },
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 4.w,
                                ),

                                const Divider()
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
                                    if (micValue !=
                                            null /*&&
                                maxValueMicParam != null*/
                                        ) {
                                      _listOfMic = [
                                        micValue!
                                            .toDouble() /*,
                                maxValueMicParam!.toInt()*/
                                      ];
                                      _getSpecificationRequestModel!
                                          .micronaire = _listOfMic;
                                    }

                                    if (moisValue !=
                                            null /* &&
                                maxValueMosParam != null*/
                                        ) {
                                      _listOfMos = [
                                        moisValue! /*,
                                maxValueMosParam!.toInt()*/
                                      ];
                                      _getSpecificationRequestModel!.moisture =
                                          _listOfMos;
                                    }

                                    if (rdValue !=
                                            null /* &&
                                maxValueMosParam != null*/
                                        ) {
                                      _listOfRd = [
                                        rdValue! /*,
                                maxValueMosParam!.toInt()*/
                                      ];
                                      _getSpecificationRequestModel!.rd =
                                          _listOfMos;
                                    }

                                    if (gptValue !=
                                            null /* &&
                                maxValueMosParam != null*/
                                        ) {
                                      _listOfGpt = [
                                        gptValue! /*,
                                maxValueMosParam!.toInt()*/
                                      ];
                                      _getSpecificationRequestModel!.gpt =
                                          _listOfGpt;
                                    }

                                    Navigator.pop(
                                        context, _getSpecificationRequestModel);
                                  },
                                  color: textColorBlue,
                                  btnText: 'Apply Filter'),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(
                    color: Colors.white,
                  )));
  }


}
