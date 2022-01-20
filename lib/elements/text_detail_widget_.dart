import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class TextDetailWidget extends StatelessWidget {
  final String title;
  final String? detail;

  const TextDetailWidget(
      {Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: tileGreyClr,
          borderRadius: BorderRadius.all(Radius.circular(4.w))),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              child: Image.asset(
                'images/ic_weight.png',
                width: 10.w,
                height: 10.h,
              ),
              visible: false,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      child: Expanded(
                        child: Text(
                          title,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      visible: true,
                    ),
                    Expanded(
                      child: Text(
                        detail ?? "N/A",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w500,
                            color: textColorGreyLight),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
