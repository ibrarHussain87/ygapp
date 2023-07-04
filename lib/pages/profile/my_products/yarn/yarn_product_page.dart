import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/elevated_button_without_icon_widget.dart';
import 'package:yg_app/elements/list_items/yarn_list_items_renewed_again.dart';
import 'package:yg_app/elements/list_widgets/blend_with_image_listview_widget.dart';
import 'package:yg_app/elements/no_data_found_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/elements/yarn_widgets/famiy_tile_listview.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';

import '../../../../elements/list_widgets/single_select_tile_renewed_widget.dart';

class YarnProductPage extends StatefulWidget {
  final List<YarnSpecification?>? specification;

  const YarnProductPage({Key? key, required this.specification})
      : super(key: key);

  @override
  YarnProductPageState createState() => YarnProductPageState();
}

class YarnProductPageState extends State<YarnProductPage>
    with AutomaticKeepAliveClientMixin {

  void _filterFamily(value) {
    setState(() {
      _familyFilteredSpecification = _specification!
          .where((element) => (element!.yarnFamily!.toLowerCase() ==
                  value.toString().toLowerCase() &&
              element.is_offering == isOffering))
          .toList();

      _filteredSpecification = _familyFilteredSpecification;
    });
  }

  @override
  bool get wantKeepAlive => true;

  void _filterBlend(Blends value) {
    _blendFilteredSpecification!.clear();
    setState(() {
      if(_familyFilteredSpecification!.isNotEmpty) {
        for (var element in _familyFilteredSpecification!) {
          if (element!.yarnFormation != null &&
              element.yarnFormation!.isNotEmpty) {
            for (var formation in element.yarnFormation!) {
              if (formation.blendName.toString().toLowerCase() ==
                  value.toString().toLowerCase() &&
                  formation.blendIdfk == value.blnId.toString() &&
                  element.is_offering == isOffering) {
                _blendFilteredSpecification!.add(element);
              }
            }
          }
        }

        _filteredSpecification = _blendFilteredSpecification;
      }
      // _filteredSpecification = _specification!
      //     .where((element) => (element!.yarnBlend!.toLowerCase() ==
      //     value!.toString().toLowerCase() &&
      //     element.is_offering == isOffering))
      //     .toList();
    });
  }

  List<Family> yarnFamilyList = [];
  List<Blends> yarnBlendList = [];
  YarnSetting? _yarnSetting;
  int? famId;
  String? isOffering;
  List<YarnSpecification?>? _specification;
  List<YarnSpecification?>? _filteredSpecification = [];
  List<YarnSpecification?>? _familyFilteredSpecification = [];
  List<YarnSpecification?>? _blendFilteredSpecification = [];

  @override
  void initState() {
    AppDbInstance().getDbInstance().then((db) async {
      await db.yarnFamilyDao.findAllYarnFamily().then((value) => setState(() {
            yarnFamilyList = value;
          }));
      await db.yarnBlendDao.allYarnBlends().then((value) {
        setState(() {
          yarnBlendList = value;
        });
      });
    });
    isOffering = "1";
    _specification = widget.specification;
    _filteredSpecification = _specification!
        .where((element) => element!.is_offering == isOffering)
        .toList();
    // queryFamilySettings(yarnFamilyList.first.famId!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return yarnFamilyList.isNotEmpty && yarnBlendList.isNotEmpty
        ? Container(
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8.w, bottom: 8.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleTextWidget(title: "Add New"),
                            SizedBox(
                              height: 4.w,
                            ),
                            const TitleExtraSmallTextWidget(
                                title:
                                    "You are currently seeing your requirement")
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: ElevatedButtonWithoutIcon(
                            callback: () {
                              showBottomSheetOR(context, (value) {
                                openYarnPostPage(context, local, yarn, value);
                              });
                            },
                            btnText: "Post Offer",
                            color: Colors.green,
                          ))
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 4.w, left: 8.w, right: 8.w),
                  child: Column(
                    children: [
                      /*SizedBox(
                        height: 48.w,
                        child: FamilyTileWidget(
                          selectedIndex: -1,
                          listItems: yarnFamilyList,
                          callback: (value) {
                            setState(() {
                              famId = value.famId;
                              _filterFamily(value.famName);
                            });
                            queryFamilySettings(famId!);
                          },
                        ),
                      ),*/
                      SizedBox(
                        height: 8.w,
                      ),
                      BlendWithImageListWidget(
                        selectedItem: -1,
                        listItem: yarnFamilyList,
                        onClickCallback: (index) {
                          Family value = yarnFamilyList[index];
                          setState(() {
                            famId = value.famId;
                            _filterFamily(value.famName);
                          });
                          queryFamilySettings(famId!);
                        },
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      /*Visibility(
                        visible: _yarnSetting != null
                            ? Ui.showHide(_yarnSetting!.showBlend)
                            : false,
                        child: SizedBox(
                          height: 48.w,
                          child: BlendsWithImageListWidget(
                            selectedItem: -1,
                            listItem: yarnBlendList
                                .where((element) =>
                                    element.familyIdfk == famId.toString())
                                .toList(),
                            onClickCallback: (value) {
                              _filterBlend(yarnBlendList[value]);
                            },
                          ),
                        ),
                      ),*/
                      Visibility(
                        visible: /*_yarnSetting != null
                            ? Ui.showHide(_yarnSetting!.showBlend)
                            : false*/false,
                        child: SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.05,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
                            child: SingleSelectTileRenewedWidget(
                              selectedIndex: -1,
                              spanCount: 2,
                              listOfItems: yarnBlendList
                                  .where((element) =>
                              element.familyIdfk == famId.toString())
                                  .toList(),
                              callback: (value) {
                                _filterBlend(value);
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left:8,right:8,bottom: 8.0,),
                  child: Center(
                    child: OfferingRequirementSegmentComponent(
                      callback: (value) {
                        setState(() {
                          isOffering = value.toString();
                          _filteredSpecification = _specification!
                              .where((element) =>
                                  element!.is_offering == value.toString())
                              .toList();
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: _filteredSpecification!.isNotEmpty
                      ? ListView.builder(
                          itemCount: _filteredSpecification!.length,
                          addAutomaticKeepAlives: true,
                          // separatorBuilder: (context, index) {
                          //   return Divider(
                          //     height: 1,
                          //     color: Colors.grey.shade400,
                          //   );
                          // },
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                openDetailsScreen(context,
                                    specObj: widget.specification![index]!);
                              },
                              child: buildYarnRenewedAgainWidget(
                                  _filteredSpecification![index]!, context,
                                  showCount: true)),
                        )
                      : const NoDataFoundWidget()
                  // Center(
                  //         child: TitleSmallTextWidget(
                  //           title: 'No Data Found',
                  //         ),
                  //       ),
                ))
              ],
            ),
          )
        : Container();
  }

  queryFamilySettings(int id) {
    AppDbInstance().getDbInstance().then((value) async {
      value.yarnSettingsDao.findFamilyYarnSettings(id).then((value) {
        setState(() {
          if (value.isNotEmpty) {
            _yarnSetting = value[0];
          } /*else {
            Ui.showSnackBar(context, 'No Settings Found');
          }*/
        });
      });
    });
  }

  filterListSearch(value) {
    setState(() {
      _filteredSpecification = _specification!
          .where((element) =>
              (element!.yarnFamily.toString().toLowerCase().contains(value) ||
                  element.yarnBlend.toString().contains(value)))
          .toList();
    });
  }
}
