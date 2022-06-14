
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/bottom_sheets/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/elevated_button_without_icon_widget.dart';
import 'package:yg_app/elements/list_items/fiber_list_items_renewed_again.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/profile/my_products/fiber/fiber_family_component.dart';

class FiberProductPage extends StatefulWidget {
  final List<Specification?>? specification;

  const FiberProductPage({Key? key, required this.specification})
      : super(key: key);

  @override
  FiberProductPageState createState() => FiberProductPageState();
}

class FiberProductPageState extends State<FiberProductPage> {


  void _filterMaterial(value) {
    setState(() {
      _filteredSpecification = _specification!
          .where((element) =>
      (element!.material!.toLowerCase() ==
          value.toString().toLowerCase() && element.is_offering == isOffering))
          .toList();
    });
  }

  filterListSearch(value) {
    setState(() {
      _filteredSpecification = _specification!
          .where(
              (element) => (element!.material.toString().toLowerCase().contains(value) || element.grade.toString().contains(value)))
          .toList();
    });
  }

  List<FiberFamily> fiberNatureList = [];
  List<FiberBlends> fiberMaterialList = [];
  List<Specification?>? _specification;
  List<Specification?>? _filteredSpecification = [];
  String isOffering = "1";

  @override
  void initState() {

    _specification = widget.specification;
    _filteredSpecification = _specification!.where((element) => element!.is_offering == isOffering).toList();

    AppDbInstance().getDbInstance().then((db) async {
      await db.fiberFamilyDao
          .findAllFiberNatures()
          .then((value) => setState(() {
                fiberNatureList = value;
              }));
      await db.fiberBlendsDao.findAllFiberBlends().then((value) {
        setState(() {
          fiberMaterialList = value;
        });
      });
      return true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (fiberNatureList.isNotEmpty && fiberMaterialList.isNotEmpty)
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
                              showBottomSheetOR(context, (value){
                                openFiberPostPage(context,local,'Fiber',value);
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FiberFamilyComponent(callback: (FiberBlends? value){
                      _filterMaterial(value!.blnName.toString());

                    }),
                  ),
                )
                /*NatureFamilyBodyComponent(
                  natureId: fiberNatureList.first.id.toString(),
                  fiberNaturesList: fiberNatureList,
                  fiberMaterialList: fiberMaterialList,
                  callback: (FiberMaterial? value) {
                    _filterMaterial(value!.fbmName.toString());
                  },
                )*/,
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: OfferingRequirementSegmentComponent(
                      callback: (value) {
                        setState(() {
                          isOffering = value.toString();
                          _filteredSpecification = _specification!.where((element) => element!.is_offering == value.toString()).toList();
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
                                openDetailsScreen(
                                    context,specObj: widget.specification![index]!);
                              },
                              child: buildFiberRenewedAgainWidget(
                                  _filteredSpecification![index]!,context,showCount: true)),
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
