import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class FabricFamilyTileWidget extends StatefulWidget {
  final List<dynamic>? listItems;
  final Function? callback;
  final int? selectedIndex;

  const FabricFamilyTileWidget(
      {Key? key,
      required this.listItems,
      required this.callback,
      this.selectedIndex})
      : super(key: key);

  @override
  FabricFamilyTileWidgetState createState() => FabricFamilyTileWidgetState();
}

class FabricFamilyTileWidgetState extends State<FabricFamilyTileWidget> {
  int? checkedFamily;
  bool disableClick = false;

  @override
  void initState() {
    // TODO: implement initState
    checkedFamily = widget.selectedIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.listItems!.length,
        itemBuilder: (context, index) {
          return buildWidget(index);
        });
  }

  Widget buildWidget(int index) {
    bool checked = index == checkedFamily;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!disableClick) {
          setState(() {
            checkedFamily = index;
          });
          widget.callback!(widget.listItems![index]);
        }
      },
      child: Container(
        width: 0.2 * MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            color: checked ? darkBlueChip : lightBlueChip,
            borderRadius: BorderRadius.all(Radius.circular(5.w))),
        child: Center(
          child: Text(
            widget.listItems![index].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11.sp, color: checked ? Colors.white : darkBlueChip),
          ),
        ),
      ),
    );
  }
}
