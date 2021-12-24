import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/fliter_pages/fiber_filter_view.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_family_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_listing_component.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';

class FiberPage extends StatefulWidget {

  final String? locality;
  const FiberPage({Key? key, required this.locality}) : super(key: key);

  @override
  FiberPageState createState() => FiberPageState();
}

class FiberPageState extends State<FiberPage> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  final GlobalKey<FiberListingComponentState> fiberListingState =
      GlobalKey<FiberListingComponentState>();

  final GlobalKey<FiberFamilyComponentState> familySateFiber = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: bodyContent(),
    );
  }

  bodyContent() {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          openCloseDial: isDialOpen,
          backgroundColor: Colors.blueAccent,
          overlayColor: Colors.grey,
          overlayOpacity: 0.5,
          spacing: 3.w,
          spaceBetweenChildren: 3.w,
          closeManually: true,
          children: [
            SpeedDialChild(
                label: requirement,
                backgroundColor: Colors.blue,
                onTap: () {
                  setState(() {
                    isDialOpen.value = false;
                  });
                  openFiberPostPage(context,widget.locality,'Fiber','0');
                }),
            SpeedDialChild(
                label: offering,
                onTap: () {
                  setState(() {
                    isDialOpen.value = false;
                  });
                  openFiberPostPage(context,widget.locality,'Fiber','1');
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
                  FiberFamilyComponent(
                    key: familySateFiber,
                    callback: (FiberMaterial value) {
                      fiberListingState.currentState!.refreshListing(
                          GetSpecificationRequestModel(
                              fiberMaterialId: [value.fbmId]));
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: OfferingRequirementSegmentComponent(
                            callback: (value) {
                              fiberListingState.currentState!.refreshListing(
                                  GetSpecificationRequestModel(
                                      isOffering: value.toString()));
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Center(

                          child: GestureDetector(
                            onTap: () async {
                              if (familySateFiber
                                      .currentState!.fiberSyncResponse !=
                                  null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FiberFilterView(
                                            syncFiberResponse: familySateFiber
                                                .currentState!
                                                .fiberSyncResponse!,
                                          )),
                                ).then((value) {
                                  //Getting result from filter
                                  if (value != null) {
                                    fiberListingState.currentState!
                                        .refreshListing(value);
                                  }
                                });
                              } else {
                                Fluttertoast.showToast(msg: "Please wait...");
                              }
                            },
                            child: Card(
                                color: Colors.white,
                                elevation: 1,
                                child: Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Icon(
                                      Icons.filter_alt_sharp,
                                      color: lightBlueTabs,
                                      size: 16.w,
                                    ))),
                          ),
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
                child: FiberListingComponent(
                    key: fiberListingState, locality: widget.locality),
              ),
            )
          ],
        ),
      ),
    );
  }
}
