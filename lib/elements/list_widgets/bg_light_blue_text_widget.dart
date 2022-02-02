import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class BgLightBlueTextWidget extends StatelessWidget {

  final String title;
  final Color? color;

  const BgLightBlueTextWidget({Key? key,required this.title,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: tileGreyClr,
          borderRadius: BorderRadius.all(Radius.circular(2.w))),
      child: Padding(
        padding: EdgeInsets.only(
            left: 4.w, right: 4.w, top: 5.w, bottom: 4.w),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text.rich( TextSpan(
                    children: [
                      TextSpan(
                        text: title.split(' ')[0],
                        style: TextStyle(
                            fontSize: 8.sp, color: color??Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                    ]
                )),
              ),
              /*FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  " "+title.split(' ')[1],
                  style: TextStyle(
                      fontSize: 8.sp, color: color??Colors.black),
                ),
              )*/
              Expanded(
                child: Text(
                  " "+title.split(' ')[1],
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 8.sp, color: color??Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
