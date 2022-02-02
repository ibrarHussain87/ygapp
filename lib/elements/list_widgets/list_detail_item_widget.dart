import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/pages/detail_pages/detail_page/detail_tab.dart';

Widget listDetailItemWidget(BuildContext context, GridTileModel detailSpecification) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width,
    child: Row(
      children: [
        Expanded(
          child: Text(
            detailSpecification.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
          ),
          flex: 6,
        ),
        Expanded(
          child: Text(
            detailSpecification.detail,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
          flex: 4,
        ),
      ],
    ),
  );
}