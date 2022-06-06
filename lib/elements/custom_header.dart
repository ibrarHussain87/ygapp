import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper_utils/app_colors.dart';

PreferredSize appBar(BuildContext context,String title)
{
  return PreferredSize(
    preferredSize:AppBar().preferredSize,
    child: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height:AppBar().preferredSize.height,
        padding: EdgeInsets.all(10),
        decoration:BoxDecoration(
          gradient:LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: <Color>[appBarColor2,appBarColor1]) ,
          borderRadius:const BorderRadius.only(
              bottomRight:  Radius.circular(/*20.0*/0),
              bottomLeft: Radius.circular(/*20.0*/0))

        ),
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                  padding: EdgeInsets.only(left: 4.w,top: 8.w),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 22.w,
                  )),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20.0.w,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            )
          ],
        ),
      ),
    ),
  );
}