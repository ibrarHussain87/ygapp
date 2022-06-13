import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/filter_widget/filter_range_slider.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_renewed_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/providers/fiber_providers/fiber_specification_provider.dart';

import '../../../elements/custom_header.dart';

class FiberFilterView extends StatefulWidget {
  // final SyncFiberResponse syncFiberResponse;

  const FiberFilterView({Key? key}) : super(key: key);

  @override
  _FiberFilterViewState createState() => _FiberFilterViewState();
}

class _FiberFilterViewState extends State<FiberFilterView> {
  final TextEditingController _textEditingController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _fiberSpecificationProvider = locator<FiberSpecificationProvider>();

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

  @override
  void initState() {
    super.initState();
    _fiberSpecificationProvider.addListener(() {
      updateUI();
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _fiberSpecificationProvider.getFiberSyncDataForFilter();
    });
  }

  updateUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: appBar(context,"Fiber Filter"),
            body: (!_fiberSpecificationProvider.isFilterPageLoading)
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
                                        left: 4.w, top: 16.w, right: 4.w),
                                    child: const TitleTextWidget(
                                        title: 'Select specification')),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: 0.04 *
                                                  MediaQuery.of(context)
                                                      .size
                                                      .height,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2.0),
                                                child:
                                                    SingleSelectTileRenewedWidget(
                                                  spanCount: 2,
                                                  selectedIndex: 0,
                                                  listOfItems:
                                                      _fiberSpecificationProvider
                                                          .fiberFamily,
                                                  callback:
                                                      (FiberFamily value) {
                                                        _fiberSpecificationProvider
                                                            .filterBlendWidgetKey
                                                            .currentState!
                                                            .checkedIndex = -1;
                                                    _fiberSpecificationProvider
                                                        .onClickFamily(value);
                                                  },
                                                ),
                                              )),
                                          SizedBox(
                                            height: 8.w,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.w,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: BlendsWithImageListWidget(
                                             key: _fiberSpecificationProvider.filterBlendWidgetKey,
                                              selectedItem: -1,
                                              listItem:
                                                  _fiberSpecificationProvider
                                                      .fiberBlends,
                                              onClickCallback: (index) {
                                                _fiberSpecificationProvider
                                                        .specificationRequestModel
                                                        .spcFiberFamilyIdfk =
                                                    _fiberSpecificationProvider
                                                        .fiberBlends[index]
                                                        .familyIdfk.toString();
                                                _fiberSpecificationProvider
                                                        .specificationRequestModel
                                                        .fbBlendIdfk =
                                                    [_fiberSpecificationProvider
                                                        .fiberBlends[index]
                                                        .blnId!];
                                                _fiberSpecificationProvider
                                                    .querySetting(
                                                        _fiberSpecificationProvider
                                                            .fiberBlends[index]
                                                            .blnId!);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ) /*FiberFamilyComponent(
                                      callback: (FiberBlends value) {

                                  })*/
                                  ,
                                ),
                                //Show Grade
                                Visibility(
                                  visible:
                                      _fiberSpecificationProvider.showGrade ??
                                          false,
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
                                        listOfItems: _fiberSpecificationProvider
                                                .fiberGrades ??
                                            [],
                                        callback: (Grades value) {
                                          _fiberSpecificationProvider
                                                  .specificationRequestModel
                                                  .gradeId =
                                              _filterList(
                                                  _fiberSpecificationProvider
                                                      .listOfGrades,
                                                  value.grdId!);
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
                                  visible: _fiberSpecificationProvider
                                          .showMicronaire ??
                                      true,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FilterRangeSlider(
                                        // minMaxRange: widget.syncFiberResponse.data.fiber
                                        //     .settings[0].micMinMax,
                                        minValue:
                                            _fiberSpecificationProvider.minMic,
                                        maxValue:
                                            _fiberSpecificationProvider.maxMic,
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
                                    visible: _fiberSpecificationProvider
                                            .showMoisture ??
                                        true,
                                    child: Column(
                                      children: [
                                        FilterRangeSlider(
                                          // minMaxRange: widget.syncFiberResponse.data.fiber
                                          //     .settings[0].moiMinMax,
                                          minValue: _fiberSpecificationProvider
                                              .minMois,
                                          maxValue: _fiberSpecificationProvider
                                              .maxMois,
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
                                  visible: _fiberSpecificationProvider.showRd ??
                                      true,
                                  child: Column(
                                    children: [
                                      FilterRangeSlider(
                                        minValue:
                                            _fiberSpecificationProvider.minRd,
                                        maxValue:
                                            _fiberSpecificationProvider.maxRd,
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
                                    visible: _fiberSpecificationProvider
                                            .showAppearance ??
                                        true,
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
                                              listOfItems:
                                                  _fiberSpecificationProvider
                                                      .fiberAppearances!,
                                              callback:
                                                  (FiberAppearance value) {
                                                _fiberSpecificationProvider
                                                        .specificationRequestModel
                                                        .apperanceId =
                                                    _filterList(
                                                        _fiberSpecificationProvider
                                                            .listOfAppearance,
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
                                        visible: _fiberSpecificationProvider
                                                .showOrigin ??
                                            true,
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
                                                      items: _fiberSpecificationProvider
                                                          .countries
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
                                                          value!.conId!
                                                        ];
                                                        _fiberSpecificationProvider
                                                            .specificationRequestModel
                                                            .originId = originList;
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
                                  visible: _fiberSpecificationProvider
                                          .showCertification ??
                                      true,
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
                                            spanCount: 3,
                                            listOfItems:
                                                _fiberSpecificationProvider
                                                    .fiberCertifications!,
                                            callback: (Certification value) {
                                              _fiberSpecificationProvider
                                                      .specificationRequestModel
                                                      .certificationId =
                                                  _filterList(
                                                      _fiberSpecificationProvider
                                                          .listOfCertification,
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

                              /*  Column(
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
                                      listOfItems: _fiberSpecificationProvider
                                          .fiberPacking!,
                                      callback: (Packing value) {
                                        _fiberSpecificationProvider
                                                .specificationRequestModel
                                                .packingId =
                                            _filterList(
                                                _fiberSpecificationProvider
                                                    .listOfPacking,
                                                value.pacId);
                                      },
                                    ),
                                  ],
                                ),*/

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
                                    _fiberSpecificationProvider
                                            .specificationRequestModel =
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
                                    if (_fiberSpecificationProvider.micValue !=
                                            null /*&&
                                maxValueMicParam != null*/
                                        ) {
                                      _fiberSpecificationProvider.listOfMic = [
                                        _fiberSpecificationProvider.micValue!
                                            .toDouble() /*,
                                maxValueMicParam!.toInt()*/
                                      ];
                                      _fiberSpecificationProvider
                                              .specificationRequestModel
                                              .micronaire =
                                          _fiberSpecificationProvider.listOfMic;
                                    }

                                    if (_fiberSpecificationProvider.moisValue !=
                                            null /* &&
                                maxValueMosParam != null*/
                                        ) {
                                      _fiberSpecificationProvider.listOfMos = [
                                        _fiberSpecificationProvider
                                            .moisValue! /*,
                                maxValueMosParam!.toInt()*/
                                      ];
                                      _fiberSpecificationProvider
                                              .specificationRequestModel
                                              .moisture =
                                          _fiberSpecificationProvider.listOfMos;
                                    }

                                    if (_fiberSpecificationProvider.rdValue !=
                                            null /* &&
                                maxValueMosParam != null*/
                                        ) {
                                      _fiberSpecificationProvider.listOfRd = [
                                        _fiberSpecificationProvider
                                            .rdValue! /*,
                                maxValueMosParam!.toInt()*/
                                      ];
                                      _fiberSpecificationProvider
                                              .specificationRequestModel.rd =
                                          _fiberSpecificationProvider.listOfMos;
                                    }

                                    if (_fiberSpecificationProvider.gptValue !=
                                            null /* &&
                                maxValueMosParam != null*/
                                        ) {
                                      _fiberSpecificationProvider.listOfGpt = [
                                        _fiberSpecificationProvider
                                            .gptValue! /*,
                                maxValueMosParam!.toInt()*/
                                      ];
                                      _fiberSpecificationProvider
                                              .specificationRequestModel.gpt =
                                          _fiberSpecificationProvider.listOfGpt;
                                    }

                                    Navigator.pop(
                                        context,
                                        _fiberSpecificationProvider
                                            .specificationRequestModel);
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
