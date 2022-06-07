import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/elements/bottom_sheets/family_bottom_sheet.dart';
import 'package:yg_app/elements/bottom_sheets/generic_blend_bottom_sheet.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/blend_model.dart';
import 'package:yg_app/model/blend_model_extended.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/component/yarn_steps_segments.dart';
import 'package:yg_app/providers/yarn_providers/post_yarn_provider.dart';

class YarnPostAdPage extends StatefulWidget {
  final String? locality;
  final String? businessArea;
  final String? selectedTab;

  const YarnPostAdPage(
      {Key? key,
      required this.businessArea,
      required this.selectedTab,
      required this.locality})
      : super(key: key);

  @override
  _YarnPostAdPageState createState() => _YarnPostAdPageState();
}

class _YarnPostAdPageState extends State<YarnPostAdPage> {
  final _postYarnProvider = locator<PostYarnProvider>();
  String blendString = '';

  @override
  void initState() {
    super.initState();
    _postYarnProvider.createRequestModel ??= CreateRequestModel();
    _postYarnProvider.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      showBlendsSheets(context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _postYarnProvider.createRequestModel = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(context, "Yarn"),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 8.w, left: 10.w, right: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showBlendsSheets(context);
                        },
                        child: SizedBox(
                          height: 0.060 * MediaQuery.of(context).size.height,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 0.w, right: 0.w, top: 2.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(6))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 5.w, left: 8.w, bottom: 5.w),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 6.w, top: 6, bottom: 6),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TitleMediumTextWidget(
                                                title: blendString.isEmpty
                                                    ? _postYarnProvider
                                                            .selectedYarnFamily
                                                            .toString()
                                                            .isNotEmpty
                                                        ? _postYarnProvider
                                                            .selectedYarnFamily
                                                            .famName
                                                        : 'Select'
                                                    : "${_postYarnProvider.selectedYarnFamily.famName},$blendString",
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: YarnStepsSegments(
                    selectedTab: widget.selectedTab,
                    businessArea: widget.businessArea,
                    locality: widget.locality,
                    callback: (int step) {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showBlendsSheets(BuildContext context) async {
    await _postYarnProvider.getFamilyData();
    if (!_postYarnProvider.familyDisabled) {
      familySheet(context, (int checkedIndex) {}, (Family family) async {
        _postYarnProvider.selectedYarnFamily = family;
        _postYarnProvider.createRequestModel!.ys_family_idfk =
            family.famId.toString();
        await _postYarnProvider.queryFamilySettings(family.famId!);
        await _postYarnProvider.getSyncedData();
        await _postYarnProvider.getYarnBlendData(family.famId!, 2);
        Navigator.of(context).pop();
        if (_postYarnProvider.blendList.isNotEmpty) {
          _postYarnProvider.resetData();
          _postYarnProvider.textFieldControllers.clear();
          _postYarnProvider.notifyUI();
          genericBlendBottomSheet(
              context, _postYarnProvider, _postYarnProvider.blendList, 0, () {
            resetYarnPlySheet(_postYarnProvider);
            blendString = setFormations();
            Navigator.pop(context);
          });
        } else {
          blendString = setFormations();
          _postYarnProvider.resetData();
          _postYarnProvider.textFieldControllers.clear();
          blendString = '';
          setState(() {});
        }
      }, _postYarnProvider.yarnFamilyList, -1, "Yarn");
    }
  }

  String setFormations() {
    List<Map<String, dynamic>> formations = [];
    var value = '';
    List<String?> stringList = [];
    if (_postYarnProvider.selectedBlends.isNotEmpty) {
      for (var element in _postYarnProvider.selectedBlends) {
        if (element.isSelected ?? false) {
          var blend = element as Blends;
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
      if ((_postYarnProvider.selectedBlends.first as Blends).bln_nature ==
          'Blended') {
        Logger().e('Blended : ${_postYarnProvider.selectedBlends.length}');
        for (var element in _postYarnProvider.selectedBlends) {
          if (element.isSelected ?? false) {
            var blend = element as Blends;
            if (blend.blendRatio!.isNotEmpty) {
              String blendFormat;
              if(blend.bln_nature == "Pure"){
                blendFormat = '${blend.blnName} (${element.blendRatio}:${(100 - int.parse(element.blendRatio!)).toString()})';
              }else{
                blendFormat = '${blend.bln_abrv} (${element.blendRatio}:${(100 - int.parse(element.blendRatio!)).toString()})';
              }
              stringList.add(blendFormat);
            }
          }
        }
      } else {
        Logger().e('Pure : ${_postYarnProvider.selectedBlends.length}');
        if (_postYarnProvider.selectedBlends.length == 1) {
          var blend = _postYarnProvider.selectedBlends.first as Blends;
          if (blend.isSelected ?? false) {
            if(blend.bln_nature == "Pure"){
              stringList.add(blend.blnName);
            }else{
              stringList.add(blend.bln_abrv);

            }
          }
        } else {
          var blendAbrevs = '';
          var blendRatios = '';
          for (var element in _postYarnProvider.selectedBlends) {
            if (element.isSelected ?? false) {
              var blend = element as Blends;
              if(blend.bln_abrv != null && blend.bln_abrv!.isNotEmpty){
                blendAbrevs += blend.bln_abrv!;
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
    _postYarnProvider.createRequestModel!.ys_formation = formations;
    return value;
  }

  resetYarnPlySheet(PostYarnProvider postYarnProvider) {
    _postYarnProvider.createRequestModel!.ys_count = null;
    _postYarnProvider.createRequestModel!.ys_dty_filament = null;
    _postYarnProvider.createRequestModel!.ys_fdy_filament = null;
    _postYarnProvider.createRequestModel!.ys_ply_idfk = null;
    _postYarnProvider.createRequestModel!.ys_doubling_method_idFk = null;
    _postYarnProvider.createRequestModel!.ys_orientation_idfk = null;
  }

//
// String getRelatedId(Blends blend) {
//   var blendModelArrayList = json.decode(blend.bln_ratio_json!);
//   List<BlendModelExtended> formationList = [];
//   for (var element in blendModelArrayList) {
//     formationList.add(BlendModelExtended.fromJson(element));
//   }
//   Logger().e(formationList.first.default_bln_id);
//   return formationList.first.default_bln_id.toString();
// }

}
