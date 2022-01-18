import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class FamilyTileWidget extends StatefulWidget {

  final List<dynamic>? listItems;
  final Function? callback;
  final int? selectedIndex;

  const FamilyTileWidget({Key? key, required this.listItems,required this.callback,this.selectedIndex}) : super(key: key);

  @override
  _FamilyTileWidgetState createState() => _FamilyTileWidgetState();
}

class _FamilyTileWidgetState extends State<FamilyTileWidget> {

  int? checkedFamily;

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
      onTap: () {
        setState(() {
          checkedFamily = index;
        });
        widget.callback!(index);
      },
      child: Container(
        width: 0.2*MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            color: checked
                ? lightBlueTabs.withOpacity(0.1)
                : Colors.grey.shade200,
            borderRadius: BorderRadius.all(Radius.circular(24.w))),
        child: Center(
          child: Text(
            widget.listItems![index].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11.sp,
                color: checked ? lightBlueTabs : Colors.black54),
          ),
        ),
      ),
    );
  }
}
