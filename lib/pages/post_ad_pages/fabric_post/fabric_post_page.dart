import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/bottom_sheets/fabric_blend_bottom_sheet.dart';
import 'package:yg_app/elements/bottom_sheets/family_bottom_sheet.dart';
import 'package:yg_app/elements/bottom_sheets/yarn_blend_bottom_sheet.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/model/blend_model_extended.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/pages/post_ad_pages/fabric_post/component/fabric_nature_material_component.dart';

import '../../../providers/fabric_providers/post_fabric_provider.dart';
import 'component/fabric_steps_segments.dart';

class FabricPostPage extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FabricPostPage(
      {Key? key, required this.locality, this.businessArea, this.selectedTab})
      : super(key: key);

  @override
  _FabricPostPageState createState() => _FabricPostPageState();
}

class _FabricPostPageState extends State<FabricPostPage> {
  String blendString = "";

  final postFabricProvider = locator<PostFabricProvider>();

  @override
  void initState() {
    super.initState();
    postFabricProvider.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {});
  }

  @override
  void dispose() {
    //Dispose broadcast
    /*BroadcastReceiver().unsubscribe(segmentIndexBroadcast);
    BroadcastReceiver().unsubscribe(requestModelBroadCast);*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final postFabricProvider = Provider.of<PostFabricProvider>(context);
    blendString = setFormations();
    Logger().e('Blend String : $blendString');
    return SafeArea(
        child: Scaffold(
            appBar: appBar(context, "Fabric"),
            backgroundColor: Colors.white,
            body: setFabricBody(postFabricProvider)));
  }

  Widget setFabricBody(PostFabricProvider postFabricProvider) {
    if (postFabricProvider.dataSynced) {
      return getView(postFabricProvider);
    } else {
      return const Center(
          child: TitleSmallTextWidget(title: 'Something went wrong'));
    }
  }

  Widget getView(PostFabricProvider postFabricProvider) {
    int selectedSegment = 1;
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // FabricNatureMaterialComponent(
          //     natureList: postFabricProvider.fabricFamilyList,
          //     materialList: postFabricProvider.fabricBlendsList),
          SizedBox(height: 8.h),
          SizedBox(
            height: 0.060 * MediaQuery.of(context).size.height,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if (!postFabricProvider.familyDisabled) {
                        postFabricProvider.selectedFabricFamily =
                            FabricFamily();
                        familySheet(context, (int checkedIndex) {},
                                (FabricFamily family) {
                              postFabricProvider.selectedFabricFamily =
                                  family;
                              Navigator.of(context).pop();
                              if (postFabricProvider.blendList
                                  .where((element) =>
                              element.familyIdfk ==
                                  family.fabricFamilyId.toString())
                                  .toList()
                                  .isNotEmpty) {
                                postFabricProvider.resetData();
                                postFabricProvider.textFieldControllers
                                    .clear();
                                FabricBlendBottomSheet(
                                    context,
                                    postFabricProvider.blendList
                                        .toList()
                                        .where((element) =>
                                    element.familyIdfk ==
                                        family.fabricFamilyId.toString())
                                        .toList(),
                                    0, () {
                                  Navigator.pop(context);
                                  // openYarnPostPage(context, widget.locality,
                                  //     yarn, widget.selectedTab);
                                });
                              } else {
                                /*openFabricPostPage(context, widget.locality,
                                    "Fabric", widget.selectedTab);*/
                              }
                            }, postFabricProvider.fabricFamilyList, -1, "Fabric");
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 0.w, right: 0.w, top: 2.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 5.w, left: 8.w, bottom: 5.w),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 6.w, top: 6, bottom: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleMediumTextWidget(
                                    title: blendString.isEmpty
                                        ? postFabricProvider.selectedFabricFamily
                                                .toString()
                                                .isNotEmpty
                                            ? postFabricProvider
                                                .selectedFabricFamily
                                                .fabricFamilyName
                                            : 'Select'
                                        : blendString,
                                    color: Colors.black54,
                                    weight: FontWeight.normal,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, right: 6, bottom: 4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 24,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

//                FamilyTileWidget(
//                  key: _familyTileKey,
//                  listItems: _familyList,
//                  callback: (Family value) {
//                    //Family Id
//                    setState(() {
//                      selectedFamilyId = value.famId.toString();
//                    });
//                    _createRequestModel.ys_family_idfk = selectedFamilyId;
//                    _yarnPostProvider.resetData();
//                    queryFamilySettings(value.famId!);
//                    yarnStepStateKey.currentState!.onClickFamily(value.famId);
//                  },
//                ),
          ),
          Visibility(
              visible: widget.businessArea == offering_type,
              child: const SizedBox(
                height: 20,
              )),
          Expanded(
            child: FabricStepsSegments(
              // syncFiberResponse: data,
              locality: widget.locality,
              businessArea: widget.businessArea,
              selectedTab: widget.selectedTab,
              stepsCallback: (value) {
                if (value is int) {
                  selectedSegment = value;
                  /*BroadcastReceiver().publish<int>(segmentIndexBroadcast,
                      arguments: selectedSegment);*/
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String setFormations() {
    List<Map<String, String>> formations = [];
    var value = '';
    List<String?> stringList = [];
    if(postFabricProvider.selectedBlends.isNotEmpty) {
      for (var element in postFabricProvider.selectedBlends) {
        var blend = element as FabricBlends;
        if (element.isSelected ?? false) {
          stringList.add(element.blnName);
          String? relateId;
          if (blend.bln_ratio_json != null) {
            relateId = getRelatedId(blend);
          }
          BlendModel formationModel = BlendModel(
              id: element.blnId,
              relatedBlnId: relateId,
              ratio: element.blendRatio);
          formations.add(formationModel.toJson());
        }
      }
    }else{
      BlendModel formationModel = BlendModel(id: postFabricProvider.selectedFabricFamily.fabricFamilyId,
          relatedBlnId: null,
          ratio: "100");
      formations.add(formationModel.toJson());
    }
    value = Utils.createStringFromList(stringList);
    Logger().e(formations.toString());
    postFabricProvider.fabricCreateRequestModel.fs_formation = formations;
    return value;
  }

  String getRelatedId(FabricBlends blend) {
    var blendModelArrayList = json.decode(blend.bln_ratio_json!);
    List<BlendModelExtended> formationList = [];
    for (var element in blendModelArrayList) {
      formationList.add(BlendModelExtended.fromJson(element));
    }
    Logger().e(formationList.first.default_bln_id);
    return formationList.first.default_bln_id.toString();
  }
}
