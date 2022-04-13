
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/elements/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/fliter_pages/fiber_filter_view.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_family_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_listing_future_component.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';

import '../../../app_database/app_database_instance.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/common_response_models/countries_response.dart';

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
  List<Countries> _countries = [];

  @override
  void initState() {
    AppDbInstance.getOriginsData()
        .then((value) => setState(() => _countries = value));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: bodyContent(),
    );
  }

  bodyContent() {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showBottomSheetOR(context,(value){
              openFiberPostPage(context,widget.locality,'Fiber',value);
            });
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
          heroTag: null,
        ),
        body: Container(
          color: Colors.grey.shade100,
          child: Material(
            elevation: 5,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  /*decoration:  BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 1.0.w), //(x,y)
                      blurRadius: 2.0.w,
                    ),
                  ],
                      *//*color: Colors.white*//*
                  ),*/
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: FiberFamilyComponent(
                          key: familySateFiber,
                          callback: (FiberMaterial value) {
                            fiberListingState.currentState!.refreshListing(
                                GetSpecificationRequestModel(fiberMaterialId: [value.fbmId]));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: widget.locality==international ? 8: 10,
                              child: OfferingRequirementSegmentComponent(
                                callback: (value) {
                                  fiberListingState.currentState!.refreshListing(
                                      GetSpecificationRequestModel(
                                          isOffering: value.toString()));
                                },
                              ),
                            ),
                            Visibility(
                              visible: widget.locality==international,
                              maintainState: false,
                              maintainSize: false,
                              child: Expanded(
                                child: Image.asset(
                                  ic_products,
                                width: 12,
                                  height: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: widget.locality==international ? 2: 0,
                              child: Visibility(
                                maintainSize: false,
                                maintainState: false,
                                visible: widget.locality==international,
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: const InputDecoration.collapsed(hintText: ''),
                                  hint: const TitleExtraSmallBoldTextWidget(title: 'Country'),
                                  items: _countries
                                      .map((value) =>
                                      DropdownMenuItem(
                                        child: Text(
                                            value.conName ??
                                                Utils.checkNullString(false),
                                            textAlign: TextAlign
                                                .center),
                                        value: value,
                                      ))
                                      .toList(),
                                  onChanged: (Countries? value) {
                                    /*_createRequestModel!
                                      .spc_origin_idfk =
                                      value!.conId.toString();*/
                                    fiberListingState.currentState!.fiberListingBodyState.currentState!.filterListSearch(value!.conName.toString());
                                  },
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: textColorGrey),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: false,
                              child: Center(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () async {
                                    // if (familySateFiber
                                    //         .currentState!.fiberSyncResponse !=
                                    //     null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FiberFilterView()),
                                      ).then((value) {
                                        //Getting result from filter
                                        if (value != null) {
                                          fiberListingState.currentState!
                                              .refreshListing(value);
                                        }
                                      });
                                    // } else {
                                    //   Fluttertoast.showToast(msg: "Please wait...");
                                    // }
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
        ),
      ),
    );
  }

}
