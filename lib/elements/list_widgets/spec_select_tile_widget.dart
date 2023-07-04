
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class SpecSelectTileWidget extends StatefulWidget {
  final Function? callback;
  final Function? selectedValue;
  final List<dynamic> listOfItems;
  final int? spanCount;
  final int? selectedIndex;

  const SpecSelectTileWidget(
      {Key? key,
        required this.spanCount,
        required this.callback,
        required this.selectedValue,
        required this.listOfItems,
        this.selectedIndex,
      })
      : super(key: key);

  @override
  SpecSelectTileWidgetState createState() => SpecSelectTileWidgetState();
}

class SpecSelectTileWidgetState extends State<SpecSelectTileWidget> {
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
    return  GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: widget.spanCount! == 2 ? 16 : 6,
          mainAxisSpacing: 8,
          crossAxisCount: widget.spanCount!,
          childAspectRatio: aspectRatio),
      itemCount: widget.listOfItems.length,
      itemBuilder: (context, index) {
        return  buildGrid(index);
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
        widget.selectedValue!(checkedTile);

        looger.e(widget.listOfItems[index].toString());
      },
      child:  widget.listOfItems.length < 3
          ? buildRoundedContainer(checked, index)
          :  buildSquareContainer(checked, index),
    );
  }


  Container buildSquareContainer(bool checked, int index) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
          color: checked
              ? darkBlueChip
              : lightBlueChip,
          borderRadius: BorderRadius.all(Radius.circular(5.w))),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.listOfItems[index].toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: checked ? Colors.white : darkBlueChip),
            ),
          )
        ],
      ),
    );
  }

  Container buildRoundedContainer(bool checked, int index) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
          color: checked
              ? darkBlueChip
              : lightBlueChip,
          borderRadius: BorderRadius.all(Radius.circular(24.w))),
      child: Row(
        children: [
          Visibility(
            visible: checked,
            child: Padding(
              padding: const EdgeInsets.only(top: 4,bottom: 4,),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.check,color: darkBlueChip,),
              ),
            ),
          ),
          /*Visibility(
            visible: checked,
              child: const SizedBox(width: 5,)
          ),*/
          Expanded(
            child: Text(
              widget.listOfItems[index].toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              textAlign: checked ? TextAlign.start:TextAlign.center,
              style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: checked ? Colors.white : darkBlueChip),
            ),
          )
        ],
      ),
    );
  }

  resetWidget(){
    setState(() {
      checkedTile = 0;

    });
  }
}
