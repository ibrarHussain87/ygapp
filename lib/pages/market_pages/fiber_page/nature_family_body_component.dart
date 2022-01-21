import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/list_widgets/cat_with_image_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

class NatureFamilyBodyComponent extends StatefulWidget {
  // final SyncFiberResponse syncFiberResponse;
  final Function callback;
  final String? natureId;
  final List<FiberNature> fiberNaturesList;
  final List<FiberMaterial> fiberMaterialList;

  const NatureFamilyBodyComponent(
      {Key? key,this.natureId, required this.fiberNaturesList,required this.fiberMaterialList, required this.callback})
      : super(key: key);

  @override
  _NatureFamilyBodyComponentState createState() => _NatureFamilyBodyComponentState();
}

class _NatureFamilyBodyComponentState extends State<NatureFamilyBodyComponent> {
  // List<FiberMaterial> materialList = [];
  String? natureId;

  @override
  void initState() {
    super.initState();
    natureId = widget.natureId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  height: 0.055 * MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(top:2.0),
                    child: SingleSelectTileWidget(
                      spanCount: 2,
                      listOfItems: widget.fiberNaturesList,
                      callback: (value) {
                        setState(() {
                         natureId = value.id.toString();
                        });
                      },
                    ),
                  )),
              SizedBox(
                height: 8.w,
              ),
            ],
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
              CatWithImageListWidget(
                listItem: widget.fiberMaterialList.where((element) => element.nature_id == natureId).toList(),
                onClickCallback: (index) {
                  widget.callback(widget.fiberMaterialList.where((element) => element.nature_id == natureId).toList()[index]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
