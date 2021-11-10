import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

class GridTileWidget extends StatefulWidget {
  Function? callback;
  List<String> listOfItems;
  int? spanCount;

  GridTileWidget(
      {Key? key,
      required this.spanCount,
      required this.callback,
      required this.listOfItems})
      : super(key: key);

  @override
  _GridTileWidgetState createState() => _GridTileWidgetState();
}

class _GridTileWidgetState extends State<GridTileWidget> {
  int checkedTile = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: widget.spanCount! == 2? 16: 6,
          mainAxisSpacing: 8,
          crossAxisCount: widget.spanCount!,
          childAspectRatio: widget.spanCount == 2 ? 4.5:2.4),
      itemCount: widget.listOfItems.length,
      itemBuilder: (context, index) {
        return buildGrid(index);
      },
    );
  }

  Widget buildGrid(int index) {
    bool checked = index == checkedTile;
    return GestureDetector(
      onTap: () {
        setState(() {
          checkedTile = index;
        });
        widget.callback!(index);
      },
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.lightBlueTabs,
            ),
            color: checked ? AppColors.lightBlueTabs : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(24.w))),
        child: Center(
          child: Text(
            widget.listOfItems[index],
            style: TextStyle(
                fontSize: 11.sp,
                color: checked ? Colors.white : AppColors.lightBlueTabs),
          ),
        ),
      ),
    );
  }
}
