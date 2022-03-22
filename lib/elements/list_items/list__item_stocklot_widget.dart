import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/stocklot_waste_model.dart';
import 'package:yg_app/pages/detail_pages/detail_page/detail_tab.dart';

Widget listItemStocklot(BuildContext context, StocklotWasteModel stocklotWaste, bool addMore,callback, int i,) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width,
    child: Row(
      children: [
        Container(
          width: MediaQuery.of(context)
              .size
              .width *
              0.1,
          child: Text(
            i.toString(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight:
                FontWeight.w600),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.25,
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Text(
              stocklotWaste.name!,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.15,
          child: Center(
            child: Text(
              stocklotWaste.price!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.2,
          child: Center(
            child: Text(
              stocklotWaste.quantity!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.2,
          child: Center(
            child: Text(
              stocklotWaste.unitOfCount!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.05,
          child: Visibility(
            visible: /*addMore*/true,
            child: GestureDetector(
              onTap: () => callback(stocklotWaste),
              child: const Icon(
                Icons.clear,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
