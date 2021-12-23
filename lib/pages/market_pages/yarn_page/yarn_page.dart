import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/yarn_family_blend_listing_body.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/yarn_list_widget.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/spinning_post_ad.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';

class SpinningPage extends StatefulWidget {
  final String? locality;

  const SpinningPage({Key? key, required this.locality}) : super(key: key);

  @override
  _SpinningPageState createState() => _SpinningPageState();
}

class _SpinningPageState extends State<SpinningPage> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final GlobalKey<YarnSpecificationListState> _yarnSpecificationListState =
      GlobalKey<YarnSpecificationListState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (isDialOpen.value) {
            isDialOpen.value = false;
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            openCloseDial: isDialOpen,
            backgroundColor: AppColors.btnColorLogin,
            overlayColor: Colors.grey,
            overlayOpacity: 0.5,
            spacing: 3.w,
            spaceBetweenChildren: 3.w,
            closeManually: true,
            children: [
              SpeedDialChild(
                  label: 'Requirement',
                  backgroundColor: Colors.blue,
                  onTap: () {
                    setState(() {
                      isDialOpen.value = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpinningPostAdPage(
                            locality: widget.locality,
                            businessArea: AppStrings.yarn,
                            selectedTab: '0'),
                      ),
                    );
                  }),
              SpeedDialChild(
                  label: 'Offering',
                  onTap: () {
                    setState(() {
                      isDialOpen.value = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpinningPostAdPage(
                            locality: widget.locality,
                            businessArea: "Yarn",
                            selectedTab: '1'),
                      ),
                    );
                  }),
            ],
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration:  BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0.w), //(x,y)
                    blurRadius: 2.0.w,
                  ),
                ], color: Colors.white),
                child: Column(
                  children: [
                    YarnFamilyBlendListingBody(
                      blendCallback: (blend) {
                        _yarnSpecificationListState.currentState!
                            .searchData(GetSpecificationRequestModel());
                      },
                      yarnFamilyCallback: (yarnFamily) {
                        _yarnSpecificationListState.currentState!
                            .searchData(GetSpecificationRequestModel());
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Center(
                            child: OfferingRequirementSegmentComponent(callback: (value) {
                              _yarnSpecificationListState.currentState!.searchData(
                                  GetSpecificationRequestModel(isOffering: value.toString()));
                            },),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Card(
                                elevation: 1,
                                child: Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Icon(
                                      Icons.filter_alt_sharp,
                                      color: AppColors.lightBlueTabs,
                                      size: 16.w,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 8.w),
                  child: YarnSpecificationList(
                    key: _yarnSpecificationListState,
                    locality: widget.locality!,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
