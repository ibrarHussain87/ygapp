import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/elements/network_icon_widget.dart';

class FilterMaterialWidget extends StatefulWidget {

  final Function? onClickCallback;
  final List<dynamic>? listItem;

  const FilterMaterialWidget(
      {Key? key, required this.listItem, required this.onClickCallback})
      : super(key: key);

  @override
  _FilterMaterialWidgetState createState() =>
      _FilterMaterialWidgetState();
}

class _FilterMaterialWidgetState extends State<FilterMaterialWidget> {

  final List<int> selectedIndex = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listItem!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return buildListBody(index);
      },
    );
  }

  Widget buildListBody(int index) {
    bool isSelected = selectedIndex.contains(index);
    List<FiberMaterial> castedList = [];
    if (widget.listItem is List<FiberMaterial>) {
      castedList = widget.listItem!.cast<FiberMaterial>();
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex.contains(index)? selectedIndex.remove(index):selectedIndex.add(index);
        });
        widget.onClickCallback!(castedList[index]);
      },
      child: SizedBox(
        width: 60.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            NetworkImageIconWidget(
              imageUrl: isSelected
                  ? '${ApiService.BASE_URL}${castedList[index].icon_selected??""}'
                  : '${ApiService.BASE_URL}${castedList[index].icon_unselected??""}',
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Text(
                castedList[index].fbmName??"N/A",
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
    );
  }
}
