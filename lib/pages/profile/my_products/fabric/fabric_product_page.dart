import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_items/fabric_list_items_renewed_again.dart';
import 'package:yg_app/elements/list_items/fiber_porduct_list_item.dart';
import 'package:yg_app/elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/request/filter_request/fabric_filter_request.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/fabric_page/fabric_components/fabric_blend_body.dart';
import 'package:yg_app/pages/profile/my_products/fiber/fiber_family_component.dart';

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
          .where((element) =>
      (element!.fabricBlend!.toLowerCase() ==
          value.toString().toLowerCase() && element.isOffering == isOffering))
          .toList();
    });
  }

  filterListSearch(value) {
    setState(() {
      _filteredSpecification = _specification!
          .where(
              (element) =>
          (element!.fabricBlend.toString()
              .toLowerCase()
              .contains(value) ||
              element.fabricGrade.toString().contains(value)))
          .toList();
    });
  }

  List<FabricFamily> fabricFamilyList = [];
  List<FabricBlends> fabricBlendsList = [];
  List<FabricSpecification?>? _specification;
  List<FabricSpecification?>? _filteredSpecification;
  String isOffering = "1";

  @override
  void initState() {
    _specification = widget.specification;
    _filteredSpecification =
        _specification!.where((element) => element!.isOffering == isOffering)
            .toList();

    AppDbInstance().getDbInstance().then((db) async {
      await db.fabricFamilyDao
          .findAllFabricFamily()
          .then((value) =>
          setState(() {
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
                          openFabricPostPage(context, local, 'Fabric', value);
                        });
                      },
                      btnText: "Post Offer",
                      color: Colors.green,
                    ))
              ],
            ),
          ),

          FabricBlendFamily(
            fabricFamilyCallback: (FabricFamily fabricFamily) {
              setState(() {
                _filteredSpecification = _specification!.where((element) =>
                element!.fabricFamilyId.toString() == fabricFamily.fabricFamilyId.toString()).toList();
              });
            },
            blendCallback: (FabricBlends blend,int familyId) {
              setState(() {
                _filteredSpecification = _specification!.where((element) =>
                element!.fabricBlend.toString() == blend.blnName.toString()).toList();
              });
            },
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: OfferingRequirementSegmentComponent(
                callback: (value) {
                  setState(() {
                    isOffering = value.toString();
                    _filteredSpecification = _specification!.where((element) => element!.isOffering.toString() == value.toString()).toList();
                  });
                },
              ),
            ),
          ),
          Expanded(
              child: Container(
                child: _filteredSpecification!.isNotEmpty
                    ? ListView.builder(
                  itemCount: _filteredSpecification!.length,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            openDetailsScreen(
                                context,
                                specObj: widget.specification![index]!);
                          },
                          child: buildFabricRenewedAgainWidget(
                              _filteredSpecification![index]!, context,showCounts: true)),
                  // separatorBuilder: (context, index) {
                  //   return Divider(
                  //     height: 1,
                  //     color: Colors.grey.shade400,
                  //   );
                  // },
                )
                    : const Center(
                  child: TitleSmallTextWidget(
                    title: 'No Data Found',
                  ),
                ),
              ))
        ],
      ),
    )
        : Container();
  }
}
