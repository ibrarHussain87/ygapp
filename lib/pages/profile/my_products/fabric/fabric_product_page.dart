import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/elevated_button_without_icon_widget.dart';
import 'package:yg_app/elements/list_items/fabric_list_items_renewed_again.dart';
import 'package:yg_app/elements/no_data_found_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/fabric_page/fabric_components/fabric_blend_body.dart';

class FabricProductPage extends StatefulWidget {
  final List<FabricSpecification?>? specification;

  const FabricProductPage({Key? key, required this.specification})
      : super(key: key);

  @override
  FabricProductPageState createState() => FabricProductPageState();
}

class FabricProductPageState extends State<FabricProductPage> {
  void _filterMaterial(value) {
    setState(() {
      _filteredSpecification = _specification!
          .where((element) => (element!.fabricBlend!.toLowerCase() ==
                  value.toString().toLowerCase() &&
              element.isOffering == isOffering))
          .toList();
    });
  }

  filterListSearch(value) {
    setState(() {
      _filteredSpecification = _specification!
          .where((element) =>
              (element!.fabricBlend.toString().toLowerCase().contains(value) ||
                  element.fabricGrade.toString().contains(value)))
          .toList();
    });
  }

  List<FabricFamily> fabricFamilyList = [];
  List<FabricBlends> fabricBlendsList = [];
  List<FabricSpecification?>? _specification;
  List<FabricSpecification?>? _filteredSpecification = [];
  List<FabricSpecification?>? _familyFilteredSpecification = [];
  List<FabricSpecification?>? _blendFilteredSpecification = [];
  String isOffering = "1";

  @override
  void initState() {
    _specification = widget.specification;
    _filteredSpecification = _specification!
        .where((element) => element!.isOffering == isOffering)
        .toList();

    AppDbInstance().getDbInstance().then((db) async {
      await db.fabricFamilyDao
          .findAllFabricFamily()
          .then((value) => setState(() {
                fabricFamilyList = value;
              }));
      await db.fabricBlendsDao.findAllFabricBlends().then((value) {
        setState(() {
          fabricBlendsList = value;
        });
      });
      return true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (fabricFamilyList.isNotEmpty && fabricBlendsList.isNotEmpty)
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
                                    "You are currently seeing your requirment")
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: ElevatedButtonWithoutIcon(
                            callback: () {
                              showBottomSheetOR(context, (value) {
                                openFabricPostPage(
                                    context, local, 'Fabric', value);
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FabricBlendFamily(
                      showBlends: false,
                      fabricFamilyCallback: (FabricFamily fabricFamily) {
                        setState(() {
                          _familyFilteredSpecification = _specification!
                              .where((element) =>
                                  element!.fabricFamilyId.toString() ==
                                  fabricFamily.fabricFamilyId.toString())
                              .toList();
                          _filteredSpecification = _familyFilteredSpecification;
                        });
                      },
                      blendCallback: (FabricBlends blend, int familyId) {
                        _filterBlend(blend);
                      },
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(bottom: 8.0,),
                  child: Center(
                    child: OfferingRequirementSegmentComponent(
                      callback: (value) {
                        setState(() {
                          isOffering = value.toString();
                          _filteredSpecification = _specification!
                              .where((element) =>
                                  element!.isOffering.toString() ==
                                  value.toString())
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
                          itemBuilder: (context, index) => GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                openDetailsScreen(context,
                                    specObj: widget.specification![index]!);
                              },
                              child: buildFabricRenewedAgainWidget(
                                  _filteredSpecification![index]!, context,
                                  showCounts: true)),
                          // separatorBuilder: (context, index) {
                          //   return Divider(
                          //     height: 1,
                          //     color: Colors.grey.shade400,
                          //   );
                          // },
                        )
                      : const NoDataFoundWidget(),
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

  void _filterBlend(FabricBlends value) {
    _blendFilteredSpecification!.clear();
    setState(() {
      if(_familyFilteredSpecification!.isNotEmpty) {
        for (var element in _familyFilteredSpecification!) {
          if (element!.formation != null &&
              element.formation!.isNotEmpty) {
            for (var formation in element.formation!) {
              if (formation.blendName.toString().toLowerCase() ==
                  value.toString().toLowerCase() &&
                  formation.blendIdfk == value.blnId.toString() &&
                  element.isOffering == isOffering) {
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
}
