import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../helper_utils/app_colors.dart';

PreferredSize appBar(BuildContext context, String title,
    {bool isBackVisible = true,
    bool isFilterVisible = false,
    Function? filterCallback}) {
  return PreferredSize(
    preferredSize: AppBar().preferredSize,
    child: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: AppBar().preferredSize.height * 1,
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: <Color>[appBarColor2, appBarColor1]),
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0))),
        child: Stack(
          children: [
            Visibility(
              visible: isBackVisible,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                    padding: EdgeInsets.only(left: 4.w, top: 8.w),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 22.w,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0.w,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
            Visibility(
              visible: isFilterVisible,
              child: GestureDetector(
                onTap: () {
                  if(filterCallback!= null) {
                    filterCallback();
                  }
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    'assets/ic_filter.svg',
                    height: 16.h,
                    width: 16.w,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
