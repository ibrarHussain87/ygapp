import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/yarn_list_future_widget.dart';

import 'yarn_components/family_blend_body.dart';

class YarnPage extends StatefulWidget {
  final String? locality;

  const YarnPage({Key? key, required this.locality}) : super(key: key);

  @override
  YarnPageState createState() => YarnPageState();
}

class YarnPageState extends State<YarnPage> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final GlobalKey<YarnSpecificationListFutureState> yarnSpecificationListState =
      GlobalKey<YarnSpecificationListFutureState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheetOR(context, (value) {
              openYarnPostPage(context, widget.locality, yarn, value);
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
          heroTag: null,
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0.w), //(x,y)
                  blurRadius: 2.0.w,
                ),
              ], color: Colors.white),
              child: Column(
                children: [
                  // YarnFamilyBlendListingBody(
                  //   blendCallback: (Blends? blend) {
                  //     var model = GetSpecificationRequestModel();
                  //     model.ysBlendIdFk = [blend!.blnId!];
                  //     yarnSpecificationListState.currentState!
                  //         .searchData(model);
                  //   },
                  //   yarnFamilyCallback: (Family? yarnFamily) {
                  //     var model = GetSpecificationRequestModel();
                  //     model.ysFamilyIdFk = [yarnFamily!.famId!];
                  //     yarnSpecificationListState.currentState!
                  //         .searchData(model);
                  //   },
                  // ),
                  BlendFamily(
                    // yarnSyncResponse: snapshot.data!,
                    yarnFamilyCallback: (Family yarnFamily) {
                      var model = GetSpecificationRequestModel();
                      model.ysFamilyIdFk = [yarnFamily.famId!];
                      yarnSpecificationListState.currentState!
                          .searchData(model);
                    },
                    blendCallback: (Blends blend,int familyId) {
                      var model = GetSpecificationRequestModel();
                      model.ysBlendIdFk = [blend.blnId!];
                      model.ysFamilyIdFk = [familyId];
                      yarnSpecificationListState.currentState!
                          .searchData(model);
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: OfferingRequirementSegmentComponent(
                            callback: (value) {
                              yarnSpecificationListState.currentState!
                                  .searchData(GetSpecificationRequestModel(
                                      isOffering: value.toString()));
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Expanded(
                          flex: 1,
                          child: Center(
                            child: Card(
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
                child: YarnSpecificationListFuture(
                  key: yarnSpecificationListState,
                  locality: widget.locality!,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
