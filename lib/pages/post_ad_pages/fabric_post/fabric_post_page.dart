
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/bottom_sheets/family_bottom_sheet.dart';
import 'package:yg_app/elements/bottom_sheets/generic_blend_bottom_sheet.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/model/blend_model_extended.dart';
import 'package:yg_app/model/request/post_fabric_request/create_fabric_request_model.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';

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
  final postFabricProvider = locator<PostFabricProvider>();
  String blendString = "";

  @override
  void initState() {
    super.initState();
    postFabricProvider.fabricCreateRequestModel ??= FabricCreateRequestModel();
    postFabricProvider.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showBlendsSheets(context);
    });
  }

  @override
  void dispose() {
    postFabricProvider.fabricCreateRequestModel = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final postFabricProvider = Provider.of<PostFabricProvider>(context);
    // blendString = setFormations();
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
                    onTap: () {
                      showBlendsSheets(context);
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
                            padding: EdgeInsets.only(
                                top: 5.w, left: 8.w, bottom: 5.w),
                            child: Padding(
                              padding:
                                  EdgeInsets.only(left: 6.w, top: 6, bottom: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleMediumTextWidget(
                                    title: blendString.isEmpty
                                        ? postFabricProvider
                                                .selectedFabricFamily
                                                .toString()
                                                .isNotEmpty
                                            ? postFabricProvider
                                                .selectedFabricFamily
                                                .fabricFamilyName
                                            : 'Select'
                                        : "${postFabricProvider.selectedFabricFamily.fabricFamilyName},$blendString",
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
              visible: widget.businessArea == offeringType,
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

  void showBlendsSheets(BuildContext context) async {
    await postFabricProvider.getFamilyData();
    if (!postFabricProvider.familyDisabled) {
      familySheet(context, (int checkedIndex) {}, (FabricFamily family) async {
        postFabricProvider.selectedFabricFamily = family;
        postFabricProvider.fabricCreateRequestModel!.fs_family_idfk =
            family.fabricFamilyId.toString();
        await postFabricProvider.queryFamilySettings(family.fabricFamilyId!);
        await postFabricProvider.getSyncData();
        await postFabricProvider.getFabricBlendData(family.fabricFamilyId!);
        Navigator.of(context).pop();
        if (postFabricProvider.blendList.isNotEmpty) {
          postFabricProvider.resetData();
          postFabricProvider.textFieldControllers.clear();
          postFabricProvider.notifyUI();
          postFabricProvider.fabricCreateRequestModel!.fs_formation = null;
          genericBlendBottomSheet(
              context, postFabricProvider, postFabricProvider.blendList, 0, () {
            blendString = setFormations();
            Navigator.pop(context);
          });
        } else {
          blendString = setFormations();
          postFabricProvider.resetData();
          postFabricProvider.textFieldControllers.clear();
          blendString = '';
          setState(() {});
        }
      }, postFabricProvider.fabricFamilyList, -1, "Fabric");
    }
  }
  String setFormations() {
    List<Map<String, dynamic>> formations = [];
    var value = '';
    List<String?> stringList = [];
    if (postFabricProvider.selectedBlends.isNotEmpty) {
      for (var element in postFabricProvider.selectedBlends) {
        if (element.isSelected ?? false) {
          var blend = element as FabricBlends;
          // stringList.add(element.blnName);
          if (blend.has_blend_id_1 != null) {
            BlendModel formationModel = BlendModel(
                id: int.parse(blend.has_blend_id_1!),
                relatedBlnId: blend.blnId.toString(),
                ratio: element.blendRatio);
            formations.add(formationModel.toJson());
            // stringList.add('${element.blendRatio}%');
          }

          if (blend.has_blend_id_2 != null) {
            BlendModel formationModel = BlendModel(
                id: int.parse(blend.has_blend_id_2!),
                relatedBlnId: blend.blnId.toString(),
                ratio: element.blendRatio!.isNotEmpty
                    ? (100 - int.parse(element.blendRatio!)).toString()
                    : '');
            formations.add(formationModel.toJson());
            /*if (element.blendRatio!.isNotEmpty) {
              stringList.removeLast();
              if (element.bln_abrv2 != null) {
                stringList.add(
                    '${element.bln_abrv2}(${element.blendRatio}% : ${(100 - int.parse(element.blendRatio!)).toString()}%)');
              } else {
                stringList.add(
                    '${element.blendRatio}% : ${(100 - int.parse(element.blendRatio!)).toString()}%');
              }
            }*/
          }

          if (blend.has_blend_id_1 == null && blend.has_blend_id_2 == null) {
            BlendModel formationModel = BlendModel(
                id: blend.blnId,
                relatedBlnId: null,
                ratio: blend.blendRatio!.isEmpty ? "100" : blend.blendRatio);
            formations.add(formationModel.toJson());
            /*if (blend.blendRatio!.isNotEmpty) {
              stringList.add('${blend.blendRatio}%');
            }*/
          }
        }
      }
      if ((postFabricProvider.selectedBlends.first as FabricBlends).blnNature ==
          'Blended') {
        Logger().e('Blended : ${postFabricProvider.selectedBlends.length}');
        for (var element in postFabricProvider.selectedBlends) {
          if (element.isSelected ?? false) {
            var blend = element as FabricBlends;
            if (blend.blendRatio!.isNotEmpty) {
              String blendFormat;
              if(blend.blnNature == "Pure"){
                blendFormat = '${blend.blnName} (${element.blendRatio}:${(100 - int.parse(element.blendRatio!)).toString()})';
              }else{
                blendFormat = '${blend.blnAbrv} (${element.blendRatio}:${(100 - int.parse(element.blendRatio!)).toString()})';
              }
              stringList.add(blendFormat);
            }
          }
        }
      } else {
        Logger().e('Pure : ${postFabricProvider.selectedBlends.length}');
        if (postFabricProvider.selectedBlends.length == 1) {
          var blend = postFabricProvider.selectedBlends.first as FabricBlends;
          if (blend.isSelected ?? false) {
            if(blend.blnNature == "Pure"){
              stringList.add(blend.blnName);
            }else{
              stringList.add(blend.blnAbrv);

            }
          }
        } else {
          var blendAbrevs = '';
          var blendRatios = '';
          for (var element in postFabricProvider.selectedBlends) {
            if (element.isSelected ?? false) {
              var blend = element as FabricBlends;
              if(blend.blnAbrv != null && blend.blnAbrv!.isNotEmpty){
                blendAbrevs += blend.blnAbrv!;
              }
              if(blend.blendRatio != null && blend.blendRatio!.isNotEmpty){
                if(blendRatios.isEmpty){
                  blendRatios += blend.blendRatio!;
                }else{
                  blendRatios += ':';
                  blendRatios += blend.blendRatio!;
                }
              }
            }
          }
          if(blendAbrevs.isNotEmpty && blendRatios.isNotEmpty){
            var blendFormat = '$blendAbrevs ($blendRatios)';
            stringList.add(blendFormat);
          }
        }
      }
    } else {
      BlendModelExtended blendModelExtended = BlendModelExtended(
          default_bln_id: "0",
          bln_name: "",
          bln_id: "0",
          related_bln_id: "0",
          percentage: null);
      formations.add(blendModelExtended.toJson());
    }

    value = Utils.createStringFromList(stringList);
    Logger().e(formations.toString());
    postFabricProvider.fabricCreateRequestModel!.fs_formation = formations;
    return value;
  }

/*  String setFormations() {
    List<Map<String, dynamic>> formations = [];
    var value = '';
    List<String?> stringList = [];
    if (postFabricProvider.selectedBlends.isNotEmpty) {
      for (var element in postFabricProvider.selectedBlends) {
        if (element.isSelected ?? false) {
          var blend = element as FabricBlends;
        //  stringList.add(element.blnName);

          if (blend.has_blend_id_1 != null) {
            BlendModel formationModel = BlendModel(
                id: int.parse(blend.has_blend_id_1!),
                relatedBlnId: blend.blnId.toString(),
                ratio: element.blendRatio);
            formations.add(formationModel.toJson());
          //  stringList.add('${element.blendRatio}%');
          }

          if (blend.has_blend_id_2 != null) {
            BlendModel formationModel = BlendModel(
                id: int.parse(blend.has_blend_id_2!),
                relatedBlnId: blend.blnId.toString(),
                ratio: element.blendRatio!.isNotEmpty ?
                (100 - int.parse(element.blendRatio!)).toString():'');
            formations.add(formationModel.toJson());
            *//*if(element.blendRatio!.isNotEmpty){
              stringList.removeLast();
              if(element.blnAbrv2 != null){
                stringList.add('${element.blnAbrv2}(${element.blendRatio}% : ${(100 - int.parse(element.blendRatio!)).toString()}%)');
              }else{
                stringList.add('${element.blendRatio}% : ${(100 - int.parse(element.blendRatio!)).toString()}%');
              }
            }*//*
          }

          if (blend.has_blend_id_1 == null && blend.has_blend_id_2 == null) {
            BlendModel formationModel = BlendModel(
                id: blend.blnId,
                relatedBlnId: null,
                ratio: blend.blendRatio!.isEmpty ? "100" : blend.blendRatio);
            formations.add(formationModel.toJson());
            *//*if(blend.blendRatio!.isNotEmpty){
              stringList.add('${blend.blendRatio}%');
            }*//*
          }
        }
      }
      if ((postFabricProvider.selectedBlends.first as FabricBlends).blnNature ==
          'Blended') {
        Logger().e('Blended : ${postFabricProvider.selectedBlends.length}');
        postFabricProvider.selectedBlends.forEach((element) {
          if (element.isSelected ?? false) {
            var blend = element as FabricBlends;
            if (blend.blendRatio!.isNotEmpty) {
              var blendFormat =
                  '${blend.blnAbrv} (${element.blendRatio}:${(100 - int.parse(element.blendRatio!)).toString()})';
              stringList.add(blendFormat);
            }
          }
        });
      } else {
        Logger().e('Pure : ${postFabricProvider.selectedBlends.length}');
        if (postFabricProvider.selectedBlends.length == 1) {
          var blend = postFabricProvider.selectedBlends.first as FabricBlends;
          if (blend.isSelected ?? false) {
            stringList.add(blend.blnAbrv);
          }
        } else {
          var blendAbrevs = '';
          var blendRatios = '';
          postFabricProvider.selectedBlends.forEach((element) {
            if (element.isSelected ?? false) {
              var blend = element as FabricBlends;
              if(blend.blnAbrv != null && blend.blnAbrv!.isNotEmpty){
                blendAbrevs += blend.blnAbrv!;
              }
              if(blend.blendRatio != null && blend.blendRatio!.isNotEmpty){
                if(blendRatios.isEmpty){
                  blendRatios += blend.blendRatio!;
                }else{
                  blendRatios += ':';
                  blendRatios += blend.blendRatio!;
                }
              }
            }
          });
          if(blendAbrevs.isNotEmpty && blendRatios.isNotEmpty){
            var blendFormat = '$blendAbrevs ($blendRatios)';
            stringList.add(blendFormat);
          }
        }
      }
    } else {
      BlendModelExtended blendModelExtended = BlendModelExtended(
          default_bln_id: "0",
          bln_name: "",
          bln_id: "0",
          related_bln_id: "0",
          percentage: null);
      // BlendModel formationModel = BlendModel(
      //     id: _postYarnProvider.selectedYarnFamily.famId,
      //     relatedBlnId: null,
      //     ratio: "100");
      formations.add(blendModelExtended.toJson());
    }
    value = Utils.createStringFromList(stringList);
    Logger().e(formations.toString());
    postFabricProvider.fabricCreateRequestModel!.fs_formation = formations;
    return value;
  }*/
}
