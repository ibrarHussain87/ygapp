import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/network_icon_widget.dart';

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
    List<FiberMaterial>? castedList;
    if (widget.listItem is List<FiberMaterial>) {
      castedList = widget.listItem!.cast<FiberMaterial>();
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex.contains(index)? selectedIndex.remove(index):selectedIndex.add(index);
        });
        widget.onClickCallback!(index);
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
                  ? 'https://static.thenounproject.com/png/18663-200.png'
                  : 'https://static.thenounproject.com/png/223920-200.png',
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: Text(
                castedList![index].fbmName,
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
