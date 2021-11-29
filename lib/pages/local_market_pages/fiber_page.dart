import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/list_items_widgets/market_list_item.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/main_fiber_detail_page.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberPage extends StatefulWidget {

  const FiberPage({Key? key}) : super(key: key);

  @override
  FiberPageState createState() => FiberPageState();
}

class FiberPageState extends State<FiberPage> {

  Color offeringColor = AppColors.lightBlueTabs;
  Color requirementColor = Colors.white;
  Color textOfferClr = Colors.white;
  Color textReqClr = AppColors.textColorGreyLight;
  bool offeringClick = false, requirementClick = false;
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  FiberFilterRequestModel fiberRequestModel = FiberFilterRequestModel();

  @override
  void initState() {
    fiberRequestModel.isOffering = "1";
    super.initState();
  }

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
                      builder: (context) => const FiberPostPage(
                          businessArea: "LOCAL", selectedTab: "requirement"),
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
                      builder: (context) => const FiberPostPage(
                          businessArea: "INTERNATIONAL",
                          selectedTab: "Offering"),
                    ),
                  );
                }),
          ],
        ),
        body: FutureBuilder<FiberSpecificationResponse>(
          future: ApiService.getFiberSpecifications(mapParams: fiberRequestModel),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return getBody(snapshot.data);
            } else if (snapshot.hasError) {
              return Center(
                  child: TitleTextWidget(title: snapshot.error.toString()));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget getBody(FiberSpecificationResponse? data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: SizedBox(
              height: 50.h,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
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
                            style:
                                TextStyle(color: textOfferClr, fontSize: 11.sp),
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
                              style:
                                  TextStyle(color: textReqClr, fontSize: 11.sp),
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
        SizedBox(
          height: 8.w,
        ),
        Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: data!.data.specification.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FiberDetailPage(specification: data.data.specification[index]),
                    ),
                  );
                },
                child: buildWidget(data.data.specification[index])),
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
                color: Colors.grey.shade400,
              );
            },
          ),
        ),
      ],
    );
  }

  refreshListing(FiberFilterRequestModel filterRequestModel){
    setState(() {
      fiberRequestModel = filterRequestModel;
    });
  }

  void changeTabColor(bool value) {
    fiberRequestModel = FiberFilterRequestModel();
    if (value) {
      offeringColor = Colors.white;
      requirementColor = AppColors.lightBlueTabs;
      textOfferClr = AppColors.textColorGreyLight;
      textReqClr = Colors.white;
      fiberRequestModel.isOffering = "0";
    } else {
      offeringColor = AppColors.lightBlueTabs;
      requirementColor = Colors.white;
      textReqClr = AppColors.textColorGreyLight;
      textOfferClr = Colors.white;
      fiberRequestModel.isOffering = "1";
    }
  }
}
