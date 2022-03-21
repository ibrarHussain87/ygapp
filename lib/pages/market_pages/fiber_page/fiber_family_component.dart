import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/loading_widgets/loading_listing.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

import '../../../elements/list_widgets/single_select_tile_renewed_widget.dart';

class FiberFamilyComponent extends StatefulWidget {
  final Function callback;
  final int? selectedIndex;

  const FiberFamilyComponent({Key? key, required this.callback,
    this.selectedIndex})
      : super(key: key);

  @override
  FiberFamilyComponentState createState() => FiberFamilyComponentState();
}

class FiberFamilyComponentState extends State<FiberFamilyComponent> {

  // SyncFiberResponse? fiberSyncResponse;
  List<FiberMaterial>? materials;
  List<FiberNature>? fiberNature;
  String? natureId;
  int selectedNature=0;
  late int? selectedBlendIndex;
  late int? tempBlendIndex;



  _getFiberDataFromDb() {
    AppDbInstance.getDbInstance().then((value) async {
      await value.fiberNatureDao.findAllFiberNatures().then((value) {
        setState(() {
          fiberNature = value;
          natureId = fiberNature!.first.id.toString();
        });
      });
      await value.fiberMaterialDao.findAllFiberMaterials().then((value) {
        setState(() {
          materials = value;
        });
      });
    });
  }
  @override
  void initState() {
    tempBlendIndex = widget.selectedIndex??-1;
    _getFiberDataFromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedBlendIndex = tempBlendIndex??-1;
    return (fiberNature != null && materials != null)
        ? Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: false,
                      child: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: const TitleTextWidget(
                            title: 'Fiber Nature',
                          )),
                    ),
                    SizedBox(
                        height: 0.04 * MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: SingleSelectTileRenewedWidget(
                            spanCount: 2,
                            selectedIndex: selectedNature,
                            listOfItems: fiberNature!,
                            callback: (value) {
                              setState(() {
                                natureId = value.id.toString();
                                selectedNature = int.parse(natureId!)-1;
                              });
                            },
                          ),
                        )),
                    SizedBox(
                      height: 8.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: false,
                      child: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: const TitleTextWidget(
                            title: 'Fiber Material',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CatWithImageListWidget(
                        selectedItem: selectedBlendIndex?? -1,
                        listItem: materials!
                            .where((element) => element.nature_id == natureId)
                            .toList(),
                        onClickCallback: (index) {
                          widget.callback(materials!
                              .where((element) => element.nature_id == natureId)
                              .toList()[index]);
                        },
                      ),
                    ),
                  ],
                ),

              ],
            ),
          )
        : SizedBox(
            child: const LoadingListing(),
            height: 0.065 * MediaQuery.of(context).size.height,
          );
  }

  setNature(int index,int fiberMaterialId){
    setState(() {
      var material = materials!
          .where((element) => element.fbmId == fiberMaterialId)
          .toList().first;
      var materialsList = materials!
          .where((element) => element.nature_id == natureId)
          .toList();
      var blendIndex = materialsList.indexOf(material);
      tempBlendIndex =  blendIndex;
      selectedNature = index;
    });
  }


}
