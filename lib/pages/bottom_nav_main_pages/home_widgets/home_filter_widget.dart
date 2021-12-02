import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeFilterWidget extends StatefulWidget {
  const HomeFilterWidget({Key? key}) : super(key: key);

  @override
  _HomeFilterWidgetState createState() => _HomeFilterWidgetState();
}

class _HomeFilterWidgetState extends State<HomeFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, right: 8.w,top: 16.w),
      child: SizedBox(
          height: 50.h,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 60.w,
                child: Column(
                  children: [
                    Image.asset(
                      'images/cotton.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "Cotton",
                      style: TextStyle(
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
