import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

class YurnAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? title;
  final double height;

  YurnAppBar({
    Key? key,
    required this.title,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.w,
      child: SizedBox(
        height: preferredSize.height,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 16.w,),
              Expanded(
                flex: 1,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(left:8.w,right: 4.w,top: 4.w,bottom: 4.w),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16.w,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title!,
                    style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColorBlue),
                  ),
                ),
                flex: 9,
              )
            ],
          ),
        ),
      ),
    );
  }
}
