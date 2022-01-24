import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class FilterGridTileWidget extends StatefulWidget {

  final Function? callback;
  final List<dynamic> listOfItems;
  final int? spanCount;

  const FilterGridTileWidget(
      {Key? key,
      required this.spanCount,
      required this.callback,
      required this.listOfItems})
      : super(key: key);

  @override
  _FilterGridTileWidgetState createState() => _FilterGridTileWidgetState();
}

class _FilterGridTileWidgetState extends State<FilterGridTileWidget> {
  late double aspectRatio;
  List<int> selectedIndex = [];

  @override
  void initState() {
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
    bool isSelected = selectedIndex.contains(index);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          selectedIndex.contains(index)
              ? selectedIndex.remove(index)
              : selectedIndex.add(index);
        });
        widget.callback!(index);
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            border: Border.all(
                // color: isSelected ? lightBlueTabs : Colors.grey.shade400,
                color: Colors.transparent),
            color: isSelected
                ? lightBlueTabs.withOpacity(0.1)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.all(Radius.circular(24.w))),
        child: Center(
          child: Text(
            widget.listOfItems[index].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11.sp,
                color: isSelected ? lightBlueTabs : Colors.black54),
          ),
        ),
      ),
    );
  }
}
