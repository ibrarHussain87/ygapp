import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yg_app/pages/list_items_widgets/market_list_item.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';

class FiberPage extends StatefulWidget {
  const FiberPage({Key? key}) : super(key: key);

  @override
  _FiberPageState createState() => _FiberPageState();
}

class _FiberPageState extends State<FiberPage> {

  Color offeringColor = AppColors.lightBlueTabs;
  Color requirementColor = Colors.white;
  Color textOfferClr = Colors.white;
  Color textReqClr = AppColors.textColorGreyLight;
  bool offeringClick = false,requirementClick = false;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: bodyContent(),
    );
  }

  bodyContent() {
    return SafeArea(
      child: Scaffold(
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
                onTap: (){
                  setState(() {
                    isDialOpen.value = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FiberPostPage(businessArea:"Fiber",selectedTab:"requirement"),
                    ),
                  );
                }
            ),
            SpeedDialChild(
                label: 'Offering',
                onTap: (){
                  setState(() {
                    isDialOpen.value = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FiberPostPage(businessArea:"Fiber",selectedTab:"Offering"),
                    ),
                  );
                }
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w,right: 8.w),
              child: SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 60.w,
                        child: Column(
                          children: [
                            Image.asset(
                              'images/cotton.png',
                              height: 24.h,
                              width: 24.w,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Text(
                              "Cotton",
                              style: TextStyle(
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.strokeGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(6.w))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            offeringClick = true;
                            requirementClick = false;
                            if (!offeringClick) {
                              changeTabColor(true);
                            } else {
                              changeTabColor(false);
                            }
                          });
                        },
                        child: Container(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(
                                'Offering',
                                style: TextStyle(color: textOfferClr,fontSize: 11.sp),
                              ),
                            ),
                          ),
                          decoration: getOfferingDec(offeringColor),
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            offeringClick = false;
                            requirementClick = true;
                            if (!requirementClick) {
                              changeTabColor(false);
                            } else {
                              changeTabColor(true);
                            }
                          });
                        },
                        child: Container(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0.w),
                                child: Text(
                                  'Requirements',
                                  style: TextStyle(color: textReqClr,fontSize: 11.sp),
                                ),
                              ),
                            ),
                            decoration: getRequirementDec(requirementColor)),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 16.w),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: 17,
                  itemBuilder: (context, index) => buildWidget(/*Your params here*/),
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changeTabColor(bool value) {
    if (value) {
      offeringColor = Colors.white;
      requirementColor = AppColors.lightBlueTabs;
      textOfferClr = AppColors.textColorGreyLight;
      textReqClr = Colors.white;
    } else {
      offeringColor = AppColors.lightBlueTabs;
      requirementColor = Colors.white;
      textReqClr = AppColors.textColorGreyLight;
      textOfferClr = Colors.white;
    }
  }
}
