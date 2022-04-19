import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

import '../../../app_database/app_database_instance.dart';
import '../../../elements/offering_requirment_bottom_sheet.dart';
import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/app_constants.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/util.dart';
import '../../../model/request/filter_request/filter_request.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../common_components/offering_requirment__segment_component.dart';
import 'fabric_components/fabric_blend_body.dart';
import 'fabric_components/fabric_list_future_widget.dart';

class FabricPage extends StatefulWidget {

  final String? locality;

  const FabricPage({Key? key,required this.locality}) : super(key: key);

  @override
  FabricPageState createState() => FabricPageState();
}

class FabricPageState extends State<FabricPage> {

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  final GlobalKey<FabricSpecificationListFutureState> yarnSpecificationListState = GlobalKey<FabricSpecificationListFutureState>();
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
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheetOR(context, (value) {
              openFabricPostPage(context, widget.locality, "Fabric", value);
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
                      const SizedBox(height: 8,),
                      FabricBlendFamily(
                        fabricFamilyCallback: (FabricFamily fabricFamily) {
                          var model = GetSpecificationRequestModel();
                          model.ysFamilyIdFk = [fabricFamily.fabricFamilyId!];
                          yarnSpecificationListState.currentState!
                              .searchData(model);
                        },
                        blendCallback: (FabricBlends blend,int familyId) {
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
                                        child: Expanded(
                                          child: Text(
                                            value.conName ??
                                                Utils.checkNullString(false),
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                            softWrap: false,),
                                        ),
                                        value: value,
                                      ))
                                      .toList(),
                                  onChanged: (Countries? value) {
                                    yarnSpecificationListState.currentState!.fabricListBodyState.currentState!.filterListSearch(value!.conName.toString());
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
                    child: FabricSpecificationListFuture(
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