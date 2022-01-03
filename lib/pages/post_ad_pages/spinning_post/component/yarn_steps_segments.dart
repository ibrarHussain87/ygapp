import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/component/lab_parameter_body.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/component/yarn_specification_body.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

import '../../packing_details_component.dart';

class YarnStepsSegments extends StatefulWidget {
  final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const YarnStepsSegments(
      {Key? key,
      required this.yarnSyncResponse,
      required this.locality,
      this.selectedTab,
      required this.businessArea})
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

  String? selectedFamily;

  @override
  void initState() {
    _pageController = PageController();
    _samplePages = [
      YarnSpecificationComponent(
        key: yarnSpecificationComponentStateKey,
        yarnSyncResponse: widget.yarnSyncResponse,
        locality: widget.locality,
        businessArea: widget.businessArea,
        selectedTab: widget.selectedTab,
        callback: (value) {
          setState(() {
            selectedValue++;
          });
          // widget.stepsCallback!(value);
          _pageController.animateToPage(selectedValue - 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
      ),
      LabParameterPage(
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
          yarnSyncResponse: widget.yarnSyncResponse,
          locality: widget.locality,
          businessArea: widget.businessArea,
          selectedTab: widget.selectedTab),
      PackagingDetails(
        locality: widget.locality,
        businessArea: widget.businessArea,
        selectedTab: widget.selectedTab,
        lcType: widget.yarnSyncResponse.data.yarn.lcTypes,
        cityState: widget.yarnSyncResponse.data.yarn.cityState!,
        countries: widget.yarnSyncResponse.data.yarn.countries!,
        packing: widget.yarnSyncResponse.data.yarn.packing,
        paymentType: widget.yarnSyncResponse.data.yarn.paymentTypes,
        ports: widget.yarnSyncResponse.data.yarn.ports!,
        priceTerms: widget.yarnSyncResponse.data.yarn.priceTerms,
        deliveryPeriod: widget.yarnSyncResponse.data.yarn.deliveryPeriod,
        units: widget.yarnSyncResponse.data.yarn.units,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: CupertinoSegmentedControl(
                borderColor: Colors.grey.shade300,
                selectedColor: lightBlueTabs,
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
                  3: Container(
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
                  ),
                },
                onValueChanged: (value) {
                  if (yarnSpecificationComponentStateKey.currentState!
                          .validateAndSave() &&
                      (_labParameterPage.currentContext != null &&
                          _labParameterPage.currentState!.validateAndSave())) {
                    _moveToNext(value);
                  }else if(yarnSpecificationComponentStateKey.currentState!
                      .validateAndSave() &&
                      (_labParameterPage.currentContext == null)){
                    _moveToNext(value);
                  }
                },
              ),
            ),
          ],
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
    yarnSpecificationComponentStateKey.currentState!.queryBlendSettings(value);
  }

  onClickFamily(value) {
    selectedFamily = value.toString();
    yarnSpecificationComponentStateKey.currentState!.queryFamilySettings(value);
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