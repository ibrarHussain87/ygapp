
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/pages/auth_pages/signup/bussines_info.dart';
import 'package:yg_app/pages/auth_pages/signup/personal_info.dart';
import 'package:yg_app/pages/auth_pages/signup/select_country.dart';


class SignUpStepsSegments extends StatefulWidget {

  final Function? stepsCallback;
  final Map<int, String>? stepsMapping;
  final String? selectedTab;

  const SignUpStepsSegments(
      {Key? key,
        // required this.syncFiberResponse,
        required this.stepsCallback,
        required this.selectedTab,
        this.stepsMapping})
      : super(key: key);

  @override
  _SignUpStepsSegmentsState createState() => _SignUpStepsSegmentsState();
}

class _SignUpStepsSegmentsState extends State<SignUpStepsSegments> {

  int selectedValue = 1;
  late PageController _pageController;
  late List<Widget> _samplePages;

  final GlobalKey<CountryComponentState> _countryState = GlobalKey<CountryComponentState>();
  final GlobalKey<BusinessInfoComponentState> _packingStateKey = GlobalKey<BusinessInfoComponentState>();
  final GlobalKey<PersonalInfoComponentState> _labParameterState = GlobalKey<PersonalInfoComponentState>();


  @override
  void initState() {
    _pageController = PageController();

    _samplePages = [
      CountryComponent(
        key: _countryState,
        selectedTab: widget.selectedTab,
        callback: (value) {
          setState(() {
            selectedValue++;
          });
          widget.stepsCallback!(value);
          _pageController.animateToPage(selectedValue - 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
      ),
      BusinessInfoComponent(
        key: _packingStateKey,
        selectedTab: widget.selectedTab,
        callback: (value) {
          setState(() {
            selectedValue++;
          });
          widget.stepsCallback!(value);
          _pageController.animateToPage(selectedValue - 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
      ),

      PersonalInfoComponent(
        key: _labParameterState,
        selectedTab: widget.selectedTab,
        callback: (value) {
          setState(() {
            selectedValue++;
          });
          widget.stepsCallback!(value);
          _pageController.animateToPage(selectedValue - 1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        },
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    final postFabricProvider = Provider.of<PostFabricProvider>(context);

    return /*postFabricProvider.updateSegments == true ? */Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Visibility(
                visible:false,
                maintainSize: false,
                child: CupertinoSegmentedControl(
                  borderColor: Colors.grey.shade300,
                  selectedColor: lightBlueTabs,
                  pressedColor: Colors.transparent,
                  groupValue: selectedValue,
                  children: {
                    1: Container(
                      padding: EdgeInsets.all(8.w),
                      child: Text(
                        "Select Country",
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
                        "Business Info",
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
                        "Personal Info",
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

                    switch (value) {
                      case 1:
                        if (selectedValue == 3) {
                          if (_labParameterState.currentState != null &&
                              _labParameterState.currentState!
                                  .validateAndSave()) {
                            _moveToNextPage(value);
                          }
                        }
                        break;
                      case 2:
                        if (selectedValue == 1) {

                          if(_countryState.currentState != null){

                            _countryState.currentState!.handleNextClick();
                            print("Country"+widget.stepsCallback.toString());
                          }
                          else
                            {
                              print("null");
                            }
                        }
                        break;

                        case 3:
                        if (selectedValue == 2) {

                          if(_packingStateKey.currentState != null){
                            _packingStateKey.currentState!.handleNextClick();
                          }
                          else
                            {
                              print("null");
                            }
                        }
                        break;
                    }
                  },
                ),
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
    ) /*: Container()*/;
  }

  _moveToNextPage(value){
    setState(() {
      selectedValue = value as int;
    });
    widget.stepsCallback!(value);
    _pageController.animateToPage(selectedValue - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut);
  }
}
