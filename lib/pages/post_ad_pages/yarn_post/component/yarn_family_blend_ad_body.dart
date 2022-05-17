import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/bottom_sheets/yarn_blend_bottom_sheet.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/dynamic_list_container.dart';
import 'package:yg_app/elements/yarn_selected_blend_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yarn_widgets/listview_famiy_tile.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/component/yarn_steps_segments.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';

import '../../../../elements/bottom_sheets/family_blends_bottom_sheet.dart';
import '../../../../elements/bottom_sheets/family_bottom_sheet.dart';
import '../../../../elements/list_widgets/single_select_tile_widget.dart';
import '../../../../helper_utils/navigation_utils.dart';
import '../../../../helper_utils/util.dart';
import '../../../../model/blend_model_extended.dart';

class FamilyBlendAdsBody extends StatefulWidget {
  // final YarnSyncResponse yarnSyncResponse;
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const FamilyBlendAdsBody(
      {Key? key,
      // required this.yarnSyncResponse,
      required this.selectedTab,
      required this.locality,
      required this.businessArea})
      : super(key: key);

  @override
  _FamilyBlendAdsBodyState createState() => _FamilyBlendAdsBodyState();
}

class _FamilyBlendAdsBodyState extends State<FamilyBlendAdsBody> {
  //Globel Keys
  GlobalKey<YarnStepsSegmentsState> yarnStepStateKey =
      GlobalKey<YarnStepsSegmentsState>();

  final GlobalKey<FamilyTileWidgetState> _familyTileKey =
      GlobalKey<FamilyTileWidgetState>();
  final GlobalKey<BlendsWithImageListWidgetState> _blendTileKey =
      GlobalKey<BlendsWithImageListWidgetState>();


  late CreateRequestModel _createRequestModel;
  YarnSetting _yarnSetting = YarnSetting();
  String? selectedFamilyId;
  List<Family> _familyList = [];

  final _yarnPostProvider = locator<PostYarnProvider>();

  _getSyncedData() async {
    await AppDbInstance().getYarnFamilyData().then((value) => setState(() {
          _familyList = value;
          selectedFamilyId = value.first.famId.toString();
        }));
    await AppDbInstance()
        .getYarnBlendData()
        .then((value) => _yarnPostProvider.setBlendList = value);
    await AppDbInstance().getYarnSettings().then((value) {
      setState(() {
        _yarnSetting = value.first;
      });
    });
  }

  @override
  void initState() {
    _getSyncedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    print("PRovider"+_yarnPostProvider.yarnBlendsList.first.toString());
    _createRequestModel = Provider.of<CreateRequestModel>(context);
    var blendString = setFormations(_createRequestModel);
    Logger().e('Blend String : ${blendString}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 16.w, left: 10.w, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  visible: false, child: TitleTextWidget(title: yarnCategory)),
              SizedBox(
                height: 10.w,
              ),
              SizedBox(
                height: 0.060 * MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 0.w, right: 0.w,top: 2.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(6))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [

                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.w,
                                  left: 8.w,
                                  bottom: 5.w),
                              child:  Padding(
                                padding: EdgeInsets.only(left: 6.w, top: 6, bottom: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleMediumTextWidget(
                                      title:blendString.isEmpty ? _yarnPostProvider.selectedYarnFamily.toString().isNotEmpty ? _yarnPostProvider.selectedYarnFamily.famName :'Select' : blendString,
                                      color: Colors.black54,
                                      weight: FontWeight.normal,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if(!_yarnPostProvider.familyDisabled){
                                  _yarnPostProvider.selectedYarnFamily = Family();
                                  familySheet(context, (int checkedIndex) {}, (Family family) {
                                    _yarnPostProvider.selectedYarnFamily = family;
                                    Navigator.of(context).pop();
                                    if (_yarnPostProvider.blendList
                                        .where((element) =>
                                    element.familyIdfk == family.famId.toString())
                                        .toList()
                                        .isNotEmpty) {
                                      familyBlendsSheet(context, (int checkedIndex) {

                                      }, (Blends blends) {
                                        Navigator.of(context).pop();
                                        _yarnPostProvider.resetData();
                                        _yarnPostProvider.textFieldControllers.clear();
                                        blendedSheet(
                                            context,
                                            _yarnPostProvider.blendList.toList()
                                                .where((element) =>
                                            element.familyIdfk == family.famId.toString())
                                                .toList(),
                                            _yarnPostProvider.blendList
                                                .where((element) =>
                                            element.familyIdfk == family.famId.toString())
                                                .toList().indexWhere((element) => element == blends), () {
                                          /*List<Map<String,String>> formations = [];
                                          for (var element in _yarnPostProvider.selectedBlends) {
                                            if (element.isSelected??false) {
                                              var blend = element as Blends;
                                              String? relateId;
                                              if(blend.bln_ratio_json != null){
                                                relateId = getRelatedId(blend);
                                              }
                                              BlendModel formationModel = BlendModel(id: element.blnId,
                                                  relatedBlnId: relateId,
                                                  ratio: element.blendRatio);
                                              formations.add(formationModel.toJson());
                                            }
                                          }
                                          Logger().e(formations.toString());
                                          //  _createRequestModel.ys_formation = formations;*/

                                          Navigator.pop(context);
                                          openYarnPostPage(context, widget.locality, yarn, widget.selectedTab);
                                        });

                                      },
                                          _yarnPostProvider.blendList.where((element) =>
                                          element.familyIdfk == family.famId.toString()).toList(),
                                          -1, "Yarn");
                                    }
                                    else {
                                      openYarnPostPage(context, widget.locality, yarn, widget.selectedTab);
                                    }
                                  }, _familyList, -1, "Yarn");
                                }
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 5, right: 6, bottom: 4),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.keyboard_arrow_down_outlined,
                                  size: 24,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
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
            ],
          ),
        ),
        Visibility(
          visible: Ui.showHide(_yarnSetting.showBlend),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4,
              ),
              const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Divider()),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                child: YarnSelectedBlendWidget(
                  key: _blendTileKey,
                  listItem: _yarnPostProvider.blendList
                      .where(
                          (element) => element.familyIdfk == selectedFamilyId)
                      .toList(),
                  onClickCallback: (value) {
                    blendedSheet(
                        context,
                        _yarnPostProvider.blendList
                            .where((element) =>
                                element.familyIdfk == selectedFamilyId)
                            .toList(),
                        value, () {
                      List<Map<String,String>> formations = [];
                      for (var element in _yarnPostProvider.blendList) {
                        if (element.isSelected??false) {
                          BlendModel formationModel = BlendModel(id: element.blnId,
                              relatedBlnId: null,
                              ratio: element.blendRatio);
                          formations.add(formationModel.toJson());
                        }
                      }
                      _createRequestModel.ys_formation = formations;

                      Navigator.pop(context);
                    });
                    yarnStepStateKey.currentState!.onClickBlend(value);
                  },
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Divider()),
            ],
          ),
        ),
        Visibility(
          visible: widget.selectedTab == offering_type,
          child: const SizedBox(
            height: 8,
          ),
        ),
        Expanded(
          child: Provider(
            create: (_) => _yarnSetting,
            child: YarnStepsSegments(
              key: yarnStepStateKey,
              // yarnSyncResponse: widget.yarnSyncResponse,
              selectedTab: widget.selectedTab,
              businessArea: widget.businessArea,
              locality: widget.locality,
              callback: (int step) {
                if (step > 1) {
                  if (_familyTileKey.currentState != null) {
                    _familyTileKey.currentState!.disableClick = true;
                  }
                  if (_blendTileKey.currentState != null) {
                    _blendTileKey.currentState!.disableClick = true;
                  }
                }
              },
            ),
          ),
        )
      ],
    );
  }

  queryFamilySettings(int id) {
    AppDbInstance().getDbInstance().then((value) async {
      value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
        setState(() {
          if (value.isNotEmpty) {
            _yarnSetting = value[0];
          }
          // } else {
          //   Ui.showSnackBar(context, 'No Settings Found');
          // }
        });
      });
    });
  }

  String setFormations(CreateRequestModel createRequestModel) {
    List<Map<String,String>> formations = [];
    var value = '';
    List<String?> stringList = [];
    var _postYarnProvider = locator<PostYarnProvider>();
    for (var element in _postYarnProvider.selectedBlends) {
      if (element.isSelected??false) {
        var blend = element as Blends;
        stringList.add(element.blnName);
        String? relateId;
        if(blend.bln_ratio_json != null){
          relateId = getRelatedId(blend);
        }
        BlendModel formationModel = BlendModel(id: element.blnId,
            relatedBlnId: relateId,
            ratio: element.blendRatio);
        formations.add(formationModel.toJson());
      }
    }
    value = Utils.createStringFromList(stringList);
    Logger().e(formations.toString());
    createRequestModel.ys_formation = formations;
    return value;
  }

  String getRelatedId(Blends blend) {
    var blendModelArrayList = json.decode(blend.bln_ratio_json!);
    List<BlendModelExtended> formationList = [];
    for (var element in blendModelArrayList) {
     formationList.add(BlendModelExtended.fromJson(element));

    }
    Logger().e(formationList.first.default_bln_id);
    return formationList.first.default_bln_id.toString();
  }

}
