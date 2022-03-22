import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/stocklot_waste_model.dart';
import 'package:yg_app/pages/detail_pages/detail_page/detail_tab.dart';

Widget listItemStocklot(BuildContext context, StocklotWasteModel stocklotWaste, bool addMore,callback,) {
  double width = MediaQuery.of(context).size.width;
  return Container(
    width: width,
    child: Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.3,
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: Text(
              stocklotWaste.description!,
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
          width: MediaQuery.of(context).size.width*0.2,
          child: Text(
            stocklotWaste.quantity!,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.2,
          child: Text(
            stocklotWaste.unitOfCount!,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.2,
          child: Text(
            stocklotWaste.price!,
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.05,
          child: Visibility(
            visible: addMore,
            child: GestureDetector(
              onTap: callback,
              child: const Icon(
                Icons.add,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
