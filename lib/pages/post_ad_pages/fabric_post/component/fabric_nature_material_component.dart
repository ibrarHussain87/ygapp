import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

import '../../../../providers/fabric_providers/post_fabric_provider.dart';
import '../../../../elements/list_widgets/single_select_tile_renewed_widget.dart';
import '../../../../elements/yarn_widgets/listview_famiy_tile.dart';
import '../../../../model/response/fabric_response/sync/fabric_sync_response.dart';

class FabricNatureMaterialComponent extends StatefulWidget {

  final List<FabricBlends> materialList;
  final List<FabricFamily> natureList;

  const FabricNatureMaterialComponent(
      {Key? key, required this.natureList, required this.materialList})
      : super(key: key);

  @override
  _FabricNatureMaterialComponentState createState() =>
      _FabricNatureMaterialComponentState();
}

class _FabricNatureMaterialComponentState
    extends State<FabricNatureMaterialComponent> {
  String? _selectedNature;
  final GlobalKey<BlendsWithImageListWidgetState> _catWithImageListState = GlobalKey<BlendsWithImageListWidgetState>();

  @override
  void initState() {
    _selectedNature = /*"1"*/widget.natureList.first.fabricFamilyId.toString();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postFabricProvider = Provider.of<PostFabricProvider>(context);
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: false,
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 16.w, /*left: 16.w,*/ right: 16.w, bottom: 16.w),
                  child: const TitleTextWidget(
                    title: 'Fabric Family',
                  )),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 0.04 * MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: SingleSelectTileRenewedWidget(
                    spanCount: 4,
                    callback: (FabricFamily value) {
                      setState(() {
                        _selectedNature = value.fabricFamilyId.toString();
                        Logger().e(_selectedNature);
                      });
                      /*BroadcastReceiver().publish<int>(materialIndexBroadcast,
                          arguments: widget.materialList
                              .where((element) =>
                                  element.familyIdfk == value.fabricFamilyId.toString())
                              .toList().first
                              .blnId);*/
                      if(_selectedNature != FABRIC_MIRCOFIBER_ID/*Microfiber*/){
                        var blend = widget.materialList
                            .where((element) =>
                        element.familyIdfk == value.fabricFamilyId.toString())
                            .toList().first
                            .blnId;
                        Logger().e(blend);
                        //  if(blend!=null){
                        postFabricProvider.setBlendId(blend);
                        postFabricProvider.updateFabricSegments();
                        //   }
                        _catWithImageListState.currentState!.checkedIndex = 0;
                      }else{
                        postFabricProvider.setBlendId(null);
                      }
                    },
                    listOfItems: widget.natureList),
              ),
            )
          ],
        ),
        Visibility(
          visible: _selectedNature != FABRIC_MIRCOFIBER_ID,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 8,right: 8,top: 15),
                  child: Divider()
              ),
              Visibility(
                visible: false,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 16.w, /*left: 16.w,*/ right: 16.w, bottom: 16.w),
                    child: const TitleTextWidget(
                      title: 'Fabric Blends',
                    )),
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlendsWithImageListWidget(
                  key: _catWithImageListState,
                  listItem: widget.materialList
                      .where((element) => element.familyIdfk == _selectedNature)
                      .toList(),
                  onClickCallback: (index) {
                    /*BroadcastReceiver().publish<int>(materialIndexBroadcast,
                        arguments: widget.materialList.where((element) => element.familyIdfk == _selectedNature).toList()[index].blnId);*/
                    var blend = widget.materialList.where((element) => element.familyIdfk == _selectedNature).toList()[index].blnId;
                 //   if(blend!=null){
                      postFabricProvider.setBlendId(blend);
                    postFabricProvider.updateFabricSegments();
                    //    }
                  },
                ),
              ),
              const SizedBox(height: 4,),
              const Padding(
                  padding: EdgeInsets.only(left: 8,right: 8,),
                  child: Divider()
              ),
            ],
          ),
        ),
      ],
    );
  }


}
