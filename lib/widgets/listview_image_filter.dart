import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/widgets/network_icon_widget.dart';

class ListViewImageFilterWidget extends StatefulWidget {
  Function? onClickCallback;
  List<dynamic>? listItem;

  ListViewImageFilterWidget(
      {Key? key, required this.listItem, required this.onClickCallback})
      : super(key: key);

  @override
  _ListViewImageFilterWidgetState createState() =>
      _ListViewImageFilterWidgetState();
}

class _ListViewImageFilterWidgetState extends State<ListViewImageFilterWidget> {
  int checkedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return buildListBody(index);
      },
    );
  }

  Widget buildListBody(int index) {
    bool checked = index == checkedIndex;
    List<FiberMaterial>? castedList;
    if (widget.listItem is List<FiberMaterial>) {
      castedList = widget.listItem!.cast<FiberMaterial>();
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          checkedIndex = index;
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
              imageUrl: checked
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
