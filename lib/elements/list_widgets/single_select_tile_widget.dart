import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class SingleSelectTileWidget extends StatefulWidget {
  final Function? callback;
  final List<dynamic> listOfItems;
  final int? spanCount;
  final int? selectedIndex;

  const SingleSelectTileWidget(
      {Key? key,
      required this.spanCount,
      required this.callback,
      required this.listOfItems,
      this.selectedIndex,
      })
      : super(key: key);

  @override
  SingleSelectTileWidgetState createState() => SingleSelectTileWidgetState();
}

class SingleSelectTileWidgetState extends State<SingleSelectTileWidget> {
  int? checkedTile;
  late double aspectRatio;
  var looger = Logger();

  @override
  void initState() {
    checkedTile = widget.selectedIndex ?? 0;
    if (widget.spanCount == 2) {
      aspectRatio = 4.5;
    } else if (widget.spanCount == 3) {
      aspectRatio = 2.9;
    } else {
      aspectRatio = 2.2;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: widget.spanCount! == 2 ? 16 : 6,
          mainAxisSpacing: 8,
          crossAxisCount: widget.spanCount!,
          childAspectRatio: aspectRatio),
      itemCount: widget.listOfItems.length,
      itemBuilder: (context, index) {
        return buildGrid(index);
      },
    );
  }

  Widget buildGrid(int index) {
    bool checked = index == checkedTile;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          checkedTile = index;
        });
        widget.callback!(widget.listOfItems[index]);
        looger.e(widget.listOfItems[index].toString());
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            color: checked
                ? lightBlueTabs.withOpacity(0.1)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.all(Radius.circular(24.w))),
        child: Center(
          child: Text(
            widget.listOfItems[index].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11.sp,
                color: checked ? lightBlueTabs : Colors.black54),
          ),
        ),
      ),
    );
  }

  resetWidget(){
    setState(() {
      checkedTile = 0;
    });
  }
}
