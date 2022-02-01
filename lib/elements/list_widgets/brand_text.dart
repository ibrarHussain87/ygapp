import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/util.dart';

class BrandWidget extends StatelessWidget {
  final String? title;

  const BrandWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title??Utils.checkNullString(false),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: 11.sp,
          color: textColorGrey,
          fontWeight: FontWeight.w600),
    );
  }
}
