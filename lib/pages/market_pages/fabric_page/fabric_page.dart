import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_choices/search_choices.dart';
import 'package:yg_app/elements/bottom_sheets/family_bottom_sheet.dart';
import 'package:yg_app/elements/bottom_sheets/generic_blend_bottom_sheet.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/providers/fabric_providers/post_fabric_provider.dart';

import '../../../app_database/app_database_instance.dart';
import '../../../elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/app_constants.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/util.dart';
import '../../../model/request/filter_request/fabric_filter_request.dart';
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
  final GlobalKey<FabricSpecificationListFutureState> fabricSpecificationListState = GlobalKey<FabricSpecificationListFutureState>();
  List<Countries> _countries = [];
  final _postFabricProvider = locator<PostFabricProvider>();

  @override
  void initState() {
    AppDbInstance().getOriginsData()
        .then((value) => setState(() => _countries = value));
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _postFabricProvider.getSyncData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheetOR(context, (value) {
              /*_postFabricProvider.selectedFabricFamily = FabricFamily();
              familySheet(context, (int checkedIndex) {}, (FabricFamily family) {
                _postFabricProvider.selectedFabricFamily = family;
                Navigator.of(context).pop();
                if (_postFabricProvider.fabricBlendsList
                    .where((element) =>
                element.familyIdfk == family.fabricFamilyId.toString())
                    .toList()
                    .isNotEmpty) {
                  _postFabricProvider.resetData();
                  _postFabricProvider.textFieldControllers.clear();
                  FabricBlendBottomSheet(
                      context,
                      _postFabricProvider.fabricBlendsList.toList()
                          .where((element) =>
                      element.familyIdfk == family.fabricFamilyId.toString())
                          .toList(),
                      0, () {
                    Navigator.pop(context);
                    openFabricPostPage(context, widget.locality, "Fabric", value);
                  });
                }
                else {
                  openFabricPostPage(context, widget.locality,"Fabric", value);
                }
              }, _postFabricProvider.fabricFamilyList, -1, "Fabric");*/
              _postFabricProvider.resetData();
              _postFabricProvider.selectedFabricFamily = null;
              openFabricPostPage(context, widget.locality,value, "Fabric");
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
                          var model = FabricSpecificationRequestModel();
                          model.fs_family_idfk = [fabricFamily.fabricFamilyId!];
                          fabricSpecificationListState.currentState!
                              .searchData(model);
                        },
                        blendCallback: (FabricBlends blend,int familyId) {
                          var model = FabricSpecificationRequestModel();
                          model.fs_blend_idfk = [blend.blnId!];
                          model.fs_family_idfk = [familyId];
                          fabricSpecificationListState.currentState!
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
                                  fabricSpecificationListState.currentState!
                                      .searchData(FabricSpecificationRequestModel(
                                      is_offering: value.toString()));
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
                                child:SearchChoices.single(
                                  displayClearIcon: false,
                                  isExpanded: true,
                                  hint: const TitleExtraSmallBoldTextWidget(title: 'Country'),
                                  items:_countries
                                      .map((value) =>
                                      DropdownMenuItem(
                                        child: Text(
                                          value.conName ??
                                              Utils.checkNullString(false),
                                          textAlign: TextAlign
                                              .center,style: TextStyle(fontSize: 12.sp,   overflow: TextOverflow.ellipsis,),),
                                        value: value,
                                      )).toList(),
                                  isCaseSensitiveSearch: false,
                                  onChanged: (Countries? value) {
                                    fabricSpecificationListState.currentState!.fabricListBodyState.currentState!.filterListSearch(value!.conName.toString());
                                  },
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: textColorGrey,overflow: TextOverflow.ellipsis,),
                                )


//                                DropdownButtonFormField(
//                                  isExpanded: true,
//                                  decoration: const InputDecoration.collapsed(hintText: ''),
//                                  hint: const TitleExtraSmallBoldTextWidget(title:'Country'),
//                                  items: _countries
//                                      .map((value) =>
//                                      DropdownMenuItem(
//                                        child: Text(
//                                          value.conName ??
//                                              Utils.checkNullString(false),
//                                          textAlign: TextAlign.start,
//                                          maxLines: 1,
//                                          overflow: TextOverflow.fade,
//                                          softWrap: false,),
//                                        value: value,
//                                      ))
//                                      .toList(),
//                                  onChanged: (Countries? value) {
//                                    yarnSpecificationListState.currentState!.fabricListBodyState.currentState!.filterListSearch(value!.conName.toString());
//                                  },
//                                  style: TextStyle(
//                                      fontSize: 11.sp,
//                                      color: textColorGrey),
//                                ),
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
                      key: fabricSpecificationListState,
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
