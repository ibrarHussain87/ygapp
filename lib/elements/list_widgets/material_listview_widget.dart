import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/network_icon_widget.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class MaterialListviewWidget extends StatefulWidget {
  final Function? onClickCallback;
  final List<dynamic>? listItem;

  const MaterialListviewWidget(
      {Key? key, required this.listItem, required this.onClickCallback})
      : super(key: key);

  @override
  _MaterialListviewWidgetState createState() => _MaterialListviewWidgetState();
}

class _MaterialListviewWidgetState extends State<MaterialListviewWidget> {
  int checkedIndex = 0;
  int _selectedSegmentIndex = 1;

  @override
  void initState() {
    BroadcastReceiver().subscribe<int> // Data Type returned from publisher
        (segmentIndexBroadcast, (index) {
      setState(() {
        _selectedSegmentIndex = index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.06 * MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: widget.listItem!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildListBody(index);
        },
      ),
    );
  }

  Widget buildListBody(int index) {
    bool checked = index == checkedIndex;
    String? name;
    int? castingCheckPos;
    if (widget.listItem is List<FiberMaterial>) {
      name = widget.listItem!.cast<FiberMaterial>()[index].fbmName;
      castingCheckPos = 0;
    } else if (widget.listItem is List<Blends>) {
      name = widget.listItem!.cast<Blends>()[index].blnName;
      castingCheckPos = 1;
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedSegmentIndex == 1) {
            checkedIndex = index;
          }
        });
        widget.onClickCallback!(index);
      },
      child: Center(
        child: SizedBox(
          width: 0.2 * MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              NetworkImageIconWidget(
                imageUrl: checked
                    ? castingCheckPos == 0
                        ? '${ApiService.BASE_URL}${widget.listItem!.cast<FiberMaterial>()[index].icon_selected??""}'
                        : widget.listItem!.cast<Blends>()[index].iconSelected !=
                                null
                            ? ApiService.BASE_URL +
                                widget.listItem!
                                    .cast<Blends>()[index]
                                    .iconSelected!
                            : ""
                    : castingCheckPos == 0
                        ? '${ApiService.BASE_URL}${widget.listItem!.cast<FiberMaterial>()[index].icon_unselected??""}'
                    : widget.listItem!
                                    .cast<Blends>()[index]
                                    .iconUnselected !=
                                null
                            ? ApiService.BASE_URL +
                                widget.listItem!
                                    .cast<Blends>()[index]
                                    .iconUnselected!
                            : "",
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Text(
                  name ?? "N/A",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
