import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../locators.dart';
import '../../providers/yarn_providers/post_yarn_provider.dart';

class PureBlendSelectTileWidget extends StatefulWidget {
  final Function? callback;
  final Function? selectedValue;
  final List<dynamic> listOfItems;
  final int? spanCount;
  final int? selectedIndex;

  const PureBlendSelectTileWidget(
      {Key? key,
        required this.spanCount,
        required this.callback,
        required this.selectedValue,
        required this.listOfItems,
        this.selectedIndex,
      })
      : super(key: key);

  @override
  PureBlendSelectTileWidgetState createState() => PureBlendSelectTileWidgetState();
}

class PureBlendSelectTileWidgetState extends State<PureBlendSelectTileWidget> {
  int? checkedTile;
  late double aspectRatio;
  var looger = Logger();
  final _postYarnProvider = locator<PostYarnProvider>();
  dynamic selectedBlend;

  @override
  void initState() {
    print("Index"+widget.selectedIndex.toString());

    checkedTile = widget.selectedIndex ?? 0;
    if (widget.spanCount == 2) {
      aspectRatio = 4.5;
    } else if (widget.spanCount == 3) {
      aspectRatio = 2.9;
    } else {
      aspectRatio = 2.2;
    }
   // selectedBlend = widget.listOfItems.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          mainAxisSpacing: 2,
          crossAxisCount: 1,
          childAspectRatio: 9.5),
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
        selectedBlend = widget.listOfItems[index];
        widget.callback!(widget.listOfItems[index]);
        widget.selectedValue!(checkedTile);

        looger.e(widget.listOfItems[index].toString());
      },
      child: buildContainer(checked, index),
    );
  }


  Container buildContainer(bool checked, int index) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
//          color: checked
//              ? darkBlueChip
//              : lightBlueChip,
//          borderRadius: BorderRadius.all(Radius.circular(5.w))
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  widget.listOfItems[index].toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color:Colors.black87),
//                      color: checked ? Colors.white : darkBlueChip),
                ),
              ),
              Expanded(
                child:GestureDetector(
                  onTap: () {
                    setState(() {
                      checkedTile = index;
                    });
                    selectedBlend = widget.listOfItems[index];
                    widget.callback!(widget.listOfItems[index]);
                    widget.selectedValue!(checkedTile);
                  },
                  child: widget.listOfItems[index] == selectedBlend ?
                  const Icon(Icons.radio_button_checked,
                    size: 14,
                    color: Colors.blueAccent,
                  ):
                  const Icon(Icons.radio_button_off,
                    size: 14,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.black12,),
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
