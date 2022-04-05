import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

class SingleSelectTileRenewedWidget extends StatefulWidget {

  final Function? callback;
  final List<dynamic> listOfItems;
  final int? spanCount;
  final int? selectedIndex;

  const SingleSelectTileRenewedWidget(
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

class SingleSelectTileWidgetState extends State<SingleSelectTileRenewedWidget> {
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

  /*@override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: widget.spanCount! == 2 ? 16 : 6,
          mainAxisSpacing: 8,
          crossAxisCount: widget.spanCount!,
          childAspectRatio: 6
      ),
      itemCount: widget.listOfItems.length,
      itemBuilder: (context, index) {
        return buildGrid(index);
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    /*checkedTile = widget.selectedIndex ?? 0;*/
    return SizedBox(
      height: 0.01 * MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.listOfItems.length,
        itemBuilder: (context, index) {
          return buildGrid(index);
        },
      ),
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
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Container(
          width: MediaQuery.of(context).size.width*0.25,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
              ),
              color: checked
                  ? Colors.grey.shade200
                  : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(3.w))),
          child: Center(
            child: Text(
              widget.listOfItems[index].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: checked ? Colors.black : Colors.grey),
            ),
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
