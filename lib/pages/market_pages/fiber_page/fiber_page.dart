import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_family_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_listing_component.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';

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
                label: AppStrings.requirement,
                backgroundColor: Colors.blue,
                onTap: () {
                  setState(() {
                    isDialOpen.value = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FiberPostPage(
                          locality: widget.locality,
                          businessArea: 'Fiber',
                          selectedTab: '0'),
                    ),
                  );
                }),
            SpeedDialChild(
                label: AppStrings.offering,
                onTap: () {
                  setState(() {
                    isDialOpen.value = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FiberPostPage(
                          locality: widget.locality,
                          businessArea: 'Fiber',
                          selectedTab: '1'),
                    ),
                  );
                }),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            FiberFamilyComponent(
              callback: (FiberMaterial value) {
                fiberListingState.currentState!.refreshListing(
                    GetSpecificationRequestModel(
                        fiberMaterialId: [value.fbmId]));
              },
            ),
            OfferingRequirementSegmentComponent(callback: (value) {
              fiberListingState.currentState!.refreshListing(
                  GetSpecificationRequestModel(isOffering: value.toString()));
            }),
            Expanded(
                child: FiberListingComponent(
                    key: fiberListingState, locality: widget.locality))
          ],
        ),
      ),
    );
  }
}
