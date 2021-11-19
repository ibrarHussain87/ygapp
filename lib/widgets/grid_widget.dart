import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/family_data.dart';

class GridWidet extends StatefulWidget {

  List<FamilyData>? familyList;
  Function? callback;

  GridWidet(
      {Key? key, required this.familyList,required this.callback})
      : super(key: key);


  @override
  _GridWidetState createState() => _GridWidetState();
}

class _GridWidetState extends State<GridWidet> {
  int checkedFamily = 0;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, childAspectRatio: 3 / 2),
      itemCount: widget.familyList!.length,
      itemBuilder: (context, index) {
        return buildGrid(index);
      },
    );
  }

  Widget buildGrid(int index) {
    bool checked = index == checkedFamily;
    return GestureDetector(
      onTap: () {
        setState(() {
          checkedFamily = index;
        });
        widget.callback!(index);

      },
      child: Column(
        children: [
          Container(
            child: Column(
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
            ),
          )
        ],
      ),
    );
  }
}