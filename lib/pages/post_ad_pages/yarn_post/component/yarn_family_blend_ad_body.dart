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
  String blendString = '';
  List<Family> _familyList = [];

  final _yarnPostProvider = locator<PostYarnProvider>();

  _getSyncedData() async {
    var dbIntstance = await AppDbInstance().getDbInstance();
    _familyList = await dbIntstance.yarnFamilyDao.findAllYarnFamily();
    selectedFamilyId = _familyList.first.famId.toString();
    _yarnPostProvider.setBlendList = await dbIntstance.yarnBlendDao.findAllYarnBlends();
    List<YarnSetting> yarnSettings = await dbIntstance.yarnSettingsDao.findAllYarnSettings();
    setState(() {
      _yarnSetting = yarnSettings.first;
    });
    showBlendsSheets(context);
  }

  @override
  void initState() {
    super.initState();
    _getSyncedData();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    // });
  }

  @override
  Widget build(BuildContext context) {
//    print("PRovider"+_yarnPostProvider.yarnBlendsList.first.toString());
    _createRequestModel = Provider.of<CreateRequestModel>(context);
    blendString = setFormations(_createRequestModel);
    Logger().e('Blend String : ${blendString}');
    Logger().e('Family String : ${_yarnPostProvider.selectedYarnFamily
        .toString()}');
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
//              SizedBox(
//                height: 4.w,
//              ),
              SizedBox(
                height: 0.060 * MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 0.w, right: 0.w, top: 2.w),
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
                                padding: EdgeInsets.only(
                                    left: 6.w, top: 6, bottom: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TitleMediumTextWidget(
                                      title: blendString.isEmpty
                                          ? _yarnPostProvider.selectedYarnFamily
                                                  .toString()
                                                  .isNotEmpty
                                              ? _yarnPostProvider
                                                  .selectedYarnFamily.famName
                                              : 'Select'
                                          : blendString,
                                      color: Colors.black54,
                                      weight: FontWeight.normal,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showBlendsSheets(context);
                              },
                              child: Container(
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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

  void showBlendsSheets(BuildContext context) {
    if (!_yarnPostProvider.familyDisabled) {
      // _yarnPostProvider.selectedYarnFamily = /*Family()*/_familyList.first;
      familySheet(context, (int checkedIndex) {}, (Family family) {
        _yarnPostProvider.selectedYarnFamily = family;
        _yarnPostProvider.notifyUI();
        Navigator.of(context).pop();
        if (_yarnPostProvider.blendList
            .where((element) => element.familyIdfk == family.famId.toString())
            .toList()
            .isNotEmpty) {
          _yarnPostProvider.resetData();
          _yarnPostProvider.textFieldControllers.clear();
          _yarnPostProvider.notifyUI();
          YarnBlendBottomSheet(
              context,
              _yarnPostProvider.blendList
                  .toList()
                  .where((element) =>
                      element.familyIdfk == family.famId.toString())
                  .toList(),
              0, () {
            Navigator.pop(context);
            setState(() {});
            /*openYarnPostPage(
                context, widget.locality, yarn, widget.selectedTab);*/
          });
          /*familyBlendsSheet(context, (int checkedIndex) {

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
              Navigator.pop(context);
              openYarnPostPage(context, widget.locality, yarn, widget.selectedTab);
            });

          },
              _yarnPostProvider.blendList.where((element) =>
              element.familyIdfk == family.famId.toString()).toList(),
              -1, "Yarn");*/
        } else {
          Logger().e("Here");
          _yarnPostProvider.resetData();
          _yarnPostProvider.textFieldControllers.clear();
          blendString = '';
          setState(() {

          });
         // Navigator.pop(context);
          /*openYarnPostPage(context, widget.locality, yarn, widget.selectedTab);*/
        }
      }, _familyList, -1, "Yarn");
    }
  }

  queryFamilySettings(int id) {
    AppDbInstance().getDbInstance().then((value) async {
      value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
        setState(() {
          if (value.isNotEmpty) {
            _yarnSetting = value[0];
            _yarnPostProvider.notifyUI();
          }
          // } else {
          //   Ui.showSnackBar(context, 'No Settings Found');
          // }
        });
      });
    });
  }

  String setFormations(CreateRequestModel createRequestModel) {
    List<Map<String, String>> formations = [];
    var value = '';
    List<String?> stringList = [];
    var _postYarnProvider = locator<PostYarnProvider>();
    if (_postYarnProvider.selectedBlends.isNotEmpty) {
      for (var element in _postYarnProvider.selectedBlends) {
        if (element.isSelected ?? false) {
          var blend = element as Blends;
          stringList.add(element.blnName);
          String? relateId;
          if (blend.bln_ratio_json != null) {
            relateId = getRelatedId(blend);
          }
          BlendModel formationModel = BlendModel(
              id: element.blnId,
              relatedBlnId: relateId,
              ratio: element.blendRatio == null ? '100' :element.blendRatio!.isEmpty ? '100':element.blendRatio);
          formations.add(formationModel.toJson());
        }
      }
    } else if(_postYarnProvider.selectedYarnFamily.famId!=null) {
      BlendModel formationModel = BlendModel(
          id: _postYarnProvider.selectedYarnFamily.famId,
          relatedBlnId: null,
          ratio: "100");
      formations.add(formationModel.toJson());
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
