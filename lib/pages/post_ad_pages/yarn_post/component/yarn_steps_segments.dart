
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/component/yarn_specification_body.dart';

import '../../packing_details_component.dart';
import 'lab_parameter_body.dart';

class YarnStepsSegments extends StatefulWidget {
  // final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;
  final Function callback;

  const YarnStepsSegments(
      {Key? key,
      // required this.yarnSyncResponse,
      required this.locality,
      this.selectedTab,
      required this.businessArea,
      required this.callback})
      : super(key: key);

  @override
  YarnStepsSegmentsState createState() => YarnStepsSegmentsState();
}

class YarnStepsSegmentsState extends State<YarnStepsSegments> {
  int selectedValue = 1;
  late PageController _pageController;
  late List<Widget> _samplePages;

  //Specification Page State
  GlobalKey<YarnSpecificationComponentState>
      yarnSpecificationComponentStateKey =
      GlobalKey<YarnSpecificationComponentState>();

  //Lab page State
  final GlobalKey<LabParameterPageState> _labParameterPage =
      GlobalKey<LabParameterPageState>();

  //Packing page State
  final GlobalKey<PackagingDetailsState> _packingStateKey =
      GlobalKey<PackagingDetailsState>();

  String? selectedFamily;

  @override
  void initState() {
    _pageController = PageController();
    _samplePages = [
      YarnSpecificationComponent(
        key: yarnSpecificationComponentStateKey,
        // yarnSyncResponse: widget.yarnSyncResponse,
        locality: widget.locality,
        businessArea: widget.businessArea,
        selectedTab: widget.selectedTab,
        callback: (value) {
          setState(() {
            selectedValue++;
          });
          widget.callback(selectedValue);
          _pageController.animateToPage(selectedValue - 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
      ),
      PackagingDetails(
        key: _packingStateKey,
        locality: widget.locality,
        businessArea: widget.businessArea,
        selectedTab: widget.selectedTab,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: false,
          child: Row(
            children: [
              Expanded(
                child: selectedFamily == "4"
                    ? CupertinoSegmentedControl(
                        borderColor: Colors.grey.shade300,
                        selectedColor: darkBlueChip,
                        pressedColor: Colors.transparent,
                        groupValue: selectedValue,
                        children: {
                          1: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Text(
                              "Step 1",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: selectedValue == 1
                                    ? Colors.white
                                    : textColorGrey,
                              ),
                            ),
                          ),
                          2: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Text(
                              "Step 2",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: selectedValue == 2
                                    ? Colors.white
                                    : textColorGrey,
                              ),
                            ),
                          ),
                        },
                        onValueChanged: (value) {
                          if (yarnSpecificationComponentStateKey.currentState !=
                                  null &&
                              yarnSpecificationComponentStateKey.currentState!
                                  .validationAllPage()) {
                            _moveToNext(value);
                          }
                        },
                      )
                    : CupertinoSegmentedControl(
                        borderColor: Colors.grey.shade300,
                        selectedColor: darkBlueChip,
                        pressedColor: Colors.transparent,
                        groupValue: selectedValue,
                        children: {
                          1: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Text(
                              "Step 1",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: selectedValue == 1
                                    ? Colors.white
                                    : textColorGrey,
                              ),
                            ),
                          ),
                          2: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Text(
                              "Step 2",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: selectedValue == 2
                                    ? Colors.white
                                    : textColorGrey,
                              ),
                            ),
                          ),
                          /*3: Container(
                            padding: EdgeInsets.all(8.w),
                            child: Text(
                              "Step 3",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: selectedValue == 3
                                    ? Colors.white
                                    : textColorGrey,
                              ),
                            ),
                          ),*/
                        },
                        onValueChanged: (value) {
                          switch (value) {
                            case 1:
                              if (selectedValue == 2) {
                                if (_labParameterPage.currentState != null &&
                                    _labParameterPage.currentState!
                                        .validateAndSave()) {
                                  _moveToNext(value);
                                }
                              } else if (selectedValue == 3) {
                                if (_packingStateKey.currentState != null &&
                                    _packingStateKey.currentState!
                                        .validateAndSave()) {
                                  _moveToNext(value);
                                }
                              }
                              break;
                            case 2:
                              if (selectedValue == 1) {
                                if (yarnSpecificationComponentStateKey
                                            .currentState !=
                                        null &&
                                    yarnSpecificationComponentStateKey
                                        .currentState!
                                        .validationAllPage()) {
                                  _moveToNext(value);
                                }
                              } else if (selectedValue == 3) {
                                if (_packingStateKey.currentState != null &&
                                    _packingStateKey.currentState!
                                        .validateAndSave()) {
                                  _moveToNext(value);
                                }
                              }
                              break;
                            case 3:
                              if (selectedValue == 2) {
                                if (_labParameterPage.currentState != null &&
                                    _labParameterPage.currentState!
                                        .validateAndSave()) {
                                  _moveToNext(value);
                                }
                              } else if (selectedValue == 1) {
                                if (yarnSpecificationComponentStateKey
                                            .currentState !=
                                        null &&
                                    yarnSpecificationComponentStateKey
                                        .currentState!
                                        .validationAllPage()) {
                                  _moveToNext(value);
                                }
                              }
                              break;
                          }
                          /*if (yarnSpecificationComponentStateKey.currentState !=
                              null &&
                              yarnSpecificationComponentStateKey.currentState!
                                  .validationAllPage()) {
                            _moveToNext(value);
                          }else if(_labParameterPage.currentState !=
                              null &&
                              _labParameterPage.currentState!
                                  .validateAndSave()){
                            _moveToNext(value);
                          }else if(_packingStateKey.currentState !=
                              null &&
                              _packingStateKey.currentState!
                                  .validateAndSave()){
                            _moveToNext(value);
                          }*/
                        },
                      ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _samplePages.length,
            itemBuilder: (BuildContext context, int index) {
              return _samplePages[index % _samplePages.length];
            },
          ),
        ),
      ],
    );
  }

  onClickBlend(value) {
    // yarnSpecificationComponentStateKey.currentState!.queryBlendSettings(value);
  }

  onClickFamily(value) {
    setState(() {
      selectedFamily = value.toString();
      if (selectedFamily == "4") {
        _samplePages = [
          YarnSpecificationComponent(
            key: yarnSpecificationComponentStateKey,
            // yarnSyncResponse: widget.yarnSyncResponse,
            locality: widget.locality,
            businessArea: widget.businessArea,
            selectedTab: widget.selectedTab,
            callback: (value) {
              setState(() {
                selectedValue++;
              });
              widget.callback(selectedValue);
              _pageController.animateToPage(selectedValue - 1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
            },
          ),
          PackagingDetails(
            locality: widget.locality,
            businessArea: widget.businessArea,
            selectedTab: widget.selectedTab,
            /* lcType: widget.yarnSyncResponse.data.yarn.lcTypes,
            cityState: widget.yarnSyncResponse.data.yarn.cityState!,
            countries: widget.yarnSyncResponse.data.yarn.countries!,
            packing: widget.yarnSyncResponse.data.yarn.packing,
            paymentType: widget.yarnSyncResponse.data.yarn.paymentTypes,
            ports: widget.yarnSyncResponse.data.yarn.ports!,
            coneType: widget.yarnSyncResponse.data.yarn.coneType,
            priceTerms: widget.yarnSyncResponse.data.yarn.priceTerms,
            deliveryPeriod: widget.yarnSyncResponse.data.yarn.deliveryPeriod,
            units: widget.yarnSyncResponse.data.yarn.units,*/
          ),
        ];
      } else {
        _samplePages = [
          YarnSpecificationComponent(
            key: yarnSpecificationComponentStateKey,
            // yarnSyncResponse: widget.yarnSyncResponse,
            locality: widget.locality,
            businessArea: widget.businessArea,
            selectedTab: widget.selectedTab,
            callback: (value) {
              setState(() {
                selectedValue++;
              });
              widget.callback(selectedValue);
              _pageController.animateToPage(selectedValue - 1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut);
            },
          ),
          /*LabParameterPage(
              callback: (value) {
                setState(() {
                  selectedValue++;
                });
                // widget.stepsCallback!(value);
                _pageController.animateToPage(selectedValue - 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              },
              key: _labParameterPage,
              // yarnSyncResponse: widget.yarnSyncResponse,
              locality: widget.locality,
              businessArea: widget.businessArea,
              selectedTab: widget.selectedTab),*/
          PackagingDetails(
            locality: widget.locality,
            businessArea: widget.businessArea,
            selectedTab: widget.selectedTab,
            /* lcType: widget.yarnSyncResponse.data.yarn.lcTypes,
            cityState: widget.yarnSyncResponse.data.yarn.cityState!,
            countries: widget.yarnSyncResponse.data.yarn.countries!,
            packing: widget.yarnSyncResponse.data.yarn.packing,
            paymentType: widget.yarnSyncResponse.data.yarn.paymentTypes,
            ports: widget.yarnSyncResponse.data.yarn.ports!,
            coneType: widget.yarnSyncResponse.data.yarn.coneType,
            priceTerms: widget.yarnSyncResponse.data.yarn.priceTerms,
            deliveryPeriod: widget.yarnSyncResponse.data.yarn.deliveryPeriod,
            units: widget.yarnSyncResponse.data.yarn.units,*/
          ),
        ];
      }
    });
    // yarnSpecificationComponentStateKey.currentState!.queryFamilySettings(value);
  }

  _moveToNext(value) {
    setState(() {
      selectedValue = value as int;
    });
    // widget.stepsCallback!(value);
    _pageController.animateToPage(selectedValue - 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
}
