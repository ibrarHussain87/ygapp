import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_items/fiber_porduct_list_item.dart';
import 'package:yg_app/elements/offering_requirment_bottom_sheet.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/market_pages/common_components/offering_requirment__segment_component.dart';
import 'package:yg_app/pages/market_pages/fiber_page/nature_family_body_component.dart';

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

  List<FiberNature> fiberNatureList = [];
  List<FiberMaterial> fiberMaterialList = [];
  List<Specification?>? _specification;
  List<Specification?>? _filteredSpecification;
  String isOffering = "1";

  @override
  void initState() {

    _specification = widget.specification;
    _filteredSpecification = _specification!.where((element) => element!.is_offering == isOffering).toList();

    AppDbInstance.getDbInstance().then((db) async {
      await db.fiberNatureDao
          .findAllFiberNatures()
          .then((value) => setState(() {
                fiberNatureList = value;
              }));
      await db.fiberMaterialDao.findAllFiberMaterials().then((value) {
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
                                    "You are currently seeing your requirment")
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: ElevatedButtonWithoutIcon(
                            callback: () {
                              showBottomSheetOR(context, (value){
                                openFiberPostPage(context,"Local",'Fiber',value);
                              });
                            },
                            btnText: "Post Offer",
                            color: Colors.green,
                          ))
                    ],
                  ),
                ),
                NatureFamilyBodyComponent(
                  natureId: fiberNatureList.first.id.toString(),
                  fiberNaturesList: fiberNatureList,
                  fiberMaterialList: fiberMaterialList,
                  callback: (FiberMaterial? value) {
                    _filterMaterial(value!.fbmName.toString());
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
                          _filteredSpecification = _specification!.where((element) => isOffering == value.toString()).toList();
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
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                openDetailsScreen(
                                    context,specification: widget.specification![index]!);
                              },
                              child: buildFiberProductWidget(
                                  _filteredSpecification![index]!)),
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
