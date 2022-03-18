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

import '../../../app_database/app_database_instance.dart';
import '../../../elements/title_text_widget.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/common_response_models/countries_response.dart';
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
  late List<Countries> _countries;

  @override
  void initState() {
    AppDbInstance.getOriginsData()
        .then((value) => setState(() => _countries = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
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
                  /*decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0.w), //(x,y)
                      blurRadius: 2.0.w,
                    ),
                  ], color: Colors.white),*/
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
                      const SizedBox(height: 8,),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: widget.locality==international ? 8: 10,
                              child: OfferingRequirementSegmentComponent(
                                callback: (value) {
                                  yarnSpecificationListState.currentState!
                                      .searchData(GetSpecificationRequestModel(
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
                                  hint: const TitleExtraSmallBoldTextWidget(title:'Country'),
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
                                    yarnSpecificationListState.currentState!.yarnListBodyState.currentState!.filterListSearch(value!.conName.toString());
                                  },
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: textColorGrey),
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
        ),
      ),
    );
  }
}
