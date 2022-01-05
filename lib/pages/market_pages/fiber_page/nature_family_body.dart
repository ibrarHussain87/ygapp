import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/list_widgets/grid_tile_widget.dart';
import 'package:yg_app/elements/list_widgets/material_listview_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';

class NatureFamilyBody extends StatefulWidget {
  final SyncFiberResponse syncFiberResponse;
  final Function callback;

  const NatureFamilyBody(
      {Key? key, required this.syncFiberResponse, required this.callback})
      : super(key: key);

  @override
  _NatureFamilyBodyState createState() => _NatureFamilyBodyState();
}

class _NatureFamilyBodyState extends State<NatureFamilyBody> {
  List<FiberMaterial> materialList = [];

  @override
  void initState() {
    materialList = widget.syncFiberResponse.data.fiber.material
        .where((element) =>
            element.nature_id ==
            widget.syncFiberResponse.data.fiber.natures.first.id.toString())
        .toList();
    super.initState();
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
                  child: GridTileWidget(
                    spanCount: 2,
                    listOfItems: widget.syncFiberResponse.data.fiber.natures,
                    callback: (value) {
                      setState(() {
                        materialList = widget
                            .syncFiberResponse.data.fiber.material
                            .where((element) =>
                                element.nature_id ==
                                widget.syncFiberResponse.data.fiber
                                    .natures[value].id
                                    .toString())
                            .toList();
                      });
                    },
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
              MaterialListviewWidget(
                listItem: materialList,
                onClickCallback: (index) {
                  widget.callback(
                      widget.syncFiberResponse.data.fiber.material[index]);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
