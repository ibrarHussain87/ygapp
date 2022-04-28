import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

class FiberNatureMaterialComponent extends StatefulWidget {
  final List<FiberMaterial> materialList;
  final List<FiberNature> natureList;

  const FiberNatureMaterialComponent(
      {Key? key, required this.natureList, required this.materialList})
      : super(key: key);

  @override
  _FiberNatureMaterialComponentState createState() =>
      _FiberNatureMaterialComponentState();
}

class _FiberNatureMaterialComponentState
    extends State<FiberNatureMaterialComponent> {
  // CreateRequestModel? _createRequestModel;
  String? _selectedNature;
  // int? _materialIndex;
  final GlobalKey<CatWithImageListWidgetState> _catWithImageListState = GlobalKey<CatWithImageListWidgetState>();

  @override
  void initState() {
    // TODO: implement initState
    _selectedNature = "1";
    super.initState();
  }

  @override
  void dispose() {
    BroadcastReceiver().unsubscribe(materialIndexBroadcast);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _createRequestModel = Provider.of<CreateRequestModel?>(context)!;
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: false,
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 16.w, left: 16.w, right: 16.w, bottom: 16.w),
                  child: const TitleTextWidget(
                    title: 'Fiber Nature',
                  )),
            ),
            const SizedBox(height: 10,),
            SingleSelectTileWidget(
                spanCount: 2,
                callback: (FiberNature value) {
                  setState(() {
                    _selectedNature = value.id.toString();
                  });

                  // _createRequestModel!.spc_nature_idfk = _selectedNature;
                  /// Publishing Event
                  ///
                  BroadcastReceiver().publish<int>(materialIndexBroadcast,
                      arguments: widget.materialList
                          .where((element) =>
                              element.nature_id == value.id.toString())
                          .toList().first
                          .fbmId);
                  _catWithImageListState.currentState!.checkedIndex = 0;
                },
                listOfItems: widget.natureList)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: false,
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 16.w, left: 16.w, right: 16.w, bottom: 16.w),
                  child: const TitleTextWidget(
                    title: 'Fiber Material',
                  )),
            ),
            const SizedBox(height: 15,),
            CatWithImageListWidget(
              key: _catWithImageListState,
              listItem: widget.materialList
                  .where((element) => element.nature_id == _selectedNature)
                  .toList(),
              onClickCallback: (index) {
                // _createRequestModel!.spc_fiber_material_idfk =
                //     widget.materialList[index].fbmId.toString();
                // _materialIndex = index;
                /// Publishing Event
                BroadcastReceiver().publish<int>(materialIndexBroadcast,
                    arguments: widget.materialList.where((element) => element.nature_id == _selectedNature).toList()[index].fbmId);
              },
            ),
          ],
        ),
      ],
    );
  }
}
