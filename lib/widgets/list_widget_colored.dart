import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/family_data.dart';
import 'package:yg_app/utils/colors.dart';

class ListViewWidgetColored extends StatefulWidget {

  List<FamilyData>? listItems;
  Function? callback;

  ListViewWidgetColored({Key? key,required this.listItems,required this.callback}) : super(key: key);

  @override
  _ListViewWidgetColoredState createState() => _ListViewWidgetColoredState();
}

class _ListViewWidgetColoredState extends State<ListViewWidgetColored> {

  int checkCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listItems!.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return buildCardTile(index);
      },
    );
  }

  Widget buildCardTile(int index) {
    bool checkedCard = index == checkCardIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          checkCardIndex = index;
        });

        widget.callback!(index);
      },
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Container(
          width: 96.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0), // shadow direction: bottom right
              )
            ],
            gradient: LinearGradient(
                colors: [
                  checkedCard ? const Color(0xFF00CCFF) : Colors.white,
                  checkedCard ? const Color(0xFF3366FF) : Colors.white,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.listItems![index].familyName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 9.sp,
                      color: checkedCard ? Colors.white : AppColors.textColorGrey,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
