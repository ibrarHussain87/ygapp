import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class CategoryWidget extends StatefulWidget {

  final List<dynamic>? listItems;
  final Function? callback;

  const CategoryWidget({Key? key, required this.listItems,required this.callback}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  // int checkedFamily = 0;
  List<int> selectedIndex = [];

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
    bool checked = selectedIndex.contains(index);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          selectedIndex.contains(index)? selectedIndex.remove(index):selectedIndex.add(index);
        });
        widget.callback!(widget.listItems![index]);
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
