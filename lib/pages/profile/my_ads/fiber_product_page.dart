import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_items_widgets/fiber_porduct_list_item.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/market_pages/fiber_page/nature_family_body_component.dart';

class FiberProductPage extends StatefulWidget {
  final List<Specification?>? specification;

  const FiberProductPage({Key? key, required this.specification})
      : super(key: key);

  @override
  _FiberProductPageState createState() => _FiberProductPageState();
}

class _FiberProductPageState extends State<FiberProductPage> {
  List<FiberNature> fiberNatureList = [];
  List<FiberMaterial> fiberMaterialList = [];

  @override
  void initState() {
    AppDbInstance.getDbInstance().then((db) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: AppDbInstance.getDbInstance().then((db) {
        db.fiberNatureDao.findAllFiberNatures().then((value) => setState(() {
              fiberNatureList = value;
            }));
        db.fiberMaterialDao.findAllFiberMaterials().then((value) {
          setState(() {
            fiberMaterialList = value;
          });
        });
        return true;
      }),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16.0,right: 16.0,top:8.w,bottom: 8.w),
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
                                title: "You are currently seeing your requirment")
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: ElevatedButtonWithoutIcon(
                            callback: () {},
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
                  callback: (value) {
                    // widget.callback(value);
                  },
                ),

                Expanded(
                    child: Container(
                  child: widget.specification!.isNotEmpty
                      ? ListView.builder(
                          itemCount: widget.specification!.length,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                // openFiberDetailsScreen(
                                //     context, widget.specification![index]!);
                              },
                              child: buildFiberProductWidget(
                                  widget.specification![index]!)),
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
          );
        } else {
          return Container();
        }
      },
    );
  }
}
