import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class HomePremiumWidget extends StatefulWidget {
  const HomePremiumWidget({Key? key}) : super(key: key);

  @override
  _HomePremiumWidgetState createState() => _HomePremiumWidgetState();
}

class _HomePremiumWidgetState extends State<HomePremiumWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TitleTextWidget(title: AppStrings.todayPremium),
          SizedBox(
            height: 8.w,
          ),
          SizedBox(
              height: 60.h,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppColors.homePremiumGradientDark,
                              AppColors.homePremiumGradientLight,
                            ],
                          )),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w,right: 8.w,top: 8.w,bottom: 8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('20/S cdd Yarn for Weaving',style: TextStyle(color: Colors.white,fontSize: 11.sp),),
                                Text('(100%) Cotton',style: TextStyle(color: Colors.white,fontSize: 11.sp),),
                                Text('PKR.22,000',style: TextStyle(color: Colors.white,fontSize: 11.sp,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
