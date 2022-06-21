import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/blend_with_image_listview_widget.dart';
import 'package:yg_app/elements/loading_widgets/loading_listing.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/providers/fiber_providers/fiber_specification_provider.dart';

import '../../../../elements/list_widgets/single_select_tile_renewed_widget.dart';
import '../../../../locators.dart';

class FiberFamilyComponent extends StatefulWidget {
  final Function callback;
  const FiberFamilyComponent(
      {Key? key, required this.callback,})
      : super(key: key);

  @override
  FiberFamilyComponentState createState() => FiberFamilyComponentState();
}

class FiberFamilyComponentState extends State<FiberFamilyComponent> {

  final _fiberSpecificationProvider = locator<FiberSpecificationProvider>();

  @override
  void initState() {
    super.initState();
    _fiberSpecificationProvider.addListener(() {updateUI();});
    WidgetsBinding.instance?.addPostFrameCallback((_){
      _fiberSpecificationProvider.fiberSyncDataForMarketPage();
    });
  }

  updateUI(){
    if(mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // selectedBlendIndex = tempBlendIndex??-1;
    return (!_fiberSpecificationProvider.isLoading)
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
                    SizedBox(
                        height: 0.04 * MediaQuery.of(context).size.height,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: SingleSelectTileRenewedWidget(
                            spanCount: 2,
                            selectedIndex: 0,
                            listOfItems:
                                _fiberSpecificationProvider.fiberFamily,
                            callback: (FiberFamily value) {
                              _fiberSpecificationProvider.getFiberBlends(value.fiberFamilyId);
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: BlendWithImageListWidget(
                        selectedItem: -1,
                        listItem: _fiberSpecificationProvider.fiberBlends,
                        onClickCallback: (index) {
                          widget.callback(_fiberSpecificationProvider.fiberBlends[index]);
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

  setNature(int index, int fiberMaterialId) {
    // setState(() {
    //   var material = materials!
    //       .where((element) => element.blnId == fiberMaterialId)
    //       .toList().first;
    //   var materialsList = materials!
    //       .where((element) => element.familyIdfk == natureId)
    //       .toList();
    //   var blendIndex = materialsList.indexOf(material);
    //   tempBlendIndex =  blendIndex;
    //   selectedNature = index;
    // });
  }
}
