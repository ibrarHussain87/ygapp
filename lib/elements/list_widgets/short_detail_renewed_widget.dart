import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/util.dart';

class ShortDetailRenewedWidget extends StatefulWidget {
  final String? title;
  final String? imageIcon;
  final double? size;
  final double? iconSize;

  const ShortDetailRenewedWidget(
      {Key? key, required this.title, required this.imageIcon,this.size,this.iconSize})
      : super(key: key);

  @override
  _ShortDetailWidgetState createState() => _ShortDetailWidgetState();
}

class _ShortDetailWidgetState extends State<ShortDetailRenewedWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.w, right: 4.w, bottom: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            widget.imageIcon ?? 'images/ic_weight.png',
            width: widget.iconSize??12.w,
            height: widget.iconSize??12.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  child: Text(
                    'Weight per Bag',
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.normal,
                        color: textColorGreyLight),
                  ),
                  visible: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1.0),
                  child: Text(
                    widget.title ?? Utils.checkNullString(false),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: widget.size??10.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Metropolis',
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
