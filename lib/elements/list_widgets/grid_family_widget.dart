
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridFamilyWidget extends StatefulWidget {

  final List<dynamic>? familyList;
  final Function? callback;

  const GridFamilyWidget({Key? key, required this.familyList, required this.callback})
      : super(key: key);

  @override
  _GridFamilyWidgetState createState() => _GridFamilyWidgetState();
}

class _GridFamilyWidgetState extends State<GridFamilyWidget> {
  int checkedFamily = -1;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 3 / 2),
      itemCount: widget.familyList!.length,
      itemBuilder: (context, index) {
        return buildGrid(index);
      },
    );
  }

  Widget buildGrid(int index) {
    bool checked = index == checkedFamily;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          checkedFamily = index;
        });
        widget.callback!(index);
      },
      child: Column(
        children: [
          Column(
            children: [
              Image.asset(
                checked
                    ? widget.familyList![index].imageUrl
                    : widget.familyList![index].unselectedImage,
                height: 24.h,
                width: 24.w,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                widget.familyList![index].familyName,
                style: TextStyle(
                  fontSize: 11.sp,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
