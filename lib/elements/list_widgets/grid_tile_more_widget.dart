import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/model/response/family_data.dart';

import '../network_icon_widget.dart';
import 'grid_family_widget.dart';

class GridMoreWidget extends StatefulWidget {
  final Function? callback;
  final List<FamilyData> listOfItems;
  final int? spanCount;
  final int? selectedIndex;

  const GridMoreWidget(
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
    checkedTile = widget.selectedIndex ?? -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 3,
          mainAxisSpacing: 16,
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

      behavior: HitTestBehavior.opaque,
      onTap: () {
        // if (index != 7) {
          setState(() {
            checkedTile = widget.selectedIndex ?? index;
          });
          widget.callback!(index);
        // } else {
        //   _showBottomSheet();
        // }
      },
      child: Center(
          child: Column(
        children: [
         /* Image.asset(
            *//*index != 7
                ?*//* checked
                    ? widget.listOfItems[index].imageUrl
                    : widget.listOfItems[index].unselectedImage,
                // : 'images/ic_load_more.png',
            height: 18.h,
            width: 18.w,
          ),*/
          NetworkImageIconWidget(
            imageUrl: "${ApiService.BASE_URL}${widget.listOfItems[index].imageUrl}"
          ),
          SizedBox(
            height: 5.h,
          ),
          FittedBox(
            child: TitleExtraSmallBoldTextWidget(
              /*index != 7 ? */title:widget.listOfItems[index].familyName /*: 'Load More'*/,
            ),
          ),
        ],
      )),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w)),
        ),
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.only(left: 8.w, right: 8.w),
                    child: const TitleTextWidget(title: 'Please Select')),
                SizedBox(
                  height: 8.w,
                ),
                GridFamilyWidget(
                  callback: (value) {
                    Navigator.pop(context);
                  },
                  familyList: widget.listOfItems,
                )
              ],
            ),
          );
        });
  }
}
