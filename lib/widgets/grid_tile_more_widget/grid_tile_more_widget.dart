import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../grid_family_widget.dart';

class GridMoreWidget extends StatefulWidget {
  Function? callback;
  List<dynamic> listOfItems;
  int? spanCount;
  int? selectedIndex;

  GridMoreWidget(
      {Key? key,
      required this.spanCount,
      required this.callback,
      required this.listOfItems,
      this.selectedIndex})
      : super(key: key);

  @override
  _GridMoreWidgetState createState() => _GridMoreWidgetState();
}

class _GridMoreWidgetState extends State<GridMoreWidget> {
  int? checkedTile;

  @override
  void initState() {
    checkedTile = widget.selectedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 3,
          mainAxisSpacing: 4,
          crossAxisCount: widget.spanCount!,
          childAspectRatio: 16 / 9),
      itemCount: 8,
      itemBuilder: (context, index) {
        return buildGrid(index);
      },
    );
  }

  Widget buildGrid(int index) {
    bool checked = index == checkedTile;
    return GestureDetector(
      onTap: () {
        if (index != 7) {
          setState(() {
            checkedTile = widget.selectedIndex ?? index;
          });
          widget.callback!(index);
        } else {
          _showBottomSheet();
        }
      },
      child: Center(
          child: Column(
        children: [
          Image.asset(
            index != 7
                ? checked
                    ? widget.listOfItems[index].imageUrl
                    : widget.listOfItems[index].unselectedImage
                : 'images/more_icon.png',
            height: 16.h,
            width: 16.w,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            index != 7 ? widget.listOfItems[index].familyName : 'Load More',
            style: TextStyle(
              fontSize: 11.sp,
            ),
          ),
        ],
      )),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            height: MediaQuery.of(context).size.height/3,
            padding: EdgeInsets.all(16.w),
            child: GridFamilyWidget(
              callback: (value) {
                Navigator.pop(context);
              },
              familyList: widget.listOfItems,
            ),
          );
        });
  }
}
