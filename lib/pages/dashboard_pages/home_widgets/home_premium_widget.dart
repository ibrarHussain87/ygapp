
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';

class HomePremiumWidget extends StatefulWidget {
  const HomePremiumWidget({Key? key}) : super(key: key);

  @override
  _HomePremiumWidgetState createState() => _HomePremiumWidgetState();
}

class _HomePremiumWidgetState extends State<HomePremiumWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left:16.w,right: 16.w,bottom: 8.w,top: 8.w),
      margin: EdgeInsets.only(bottom: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: TitleTextWidget(title: todayPremium),
            margin: EdgeInsets.only(bottom: 4.w),
          ),
          SizedBox(
              height: 0.09 * MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.w),
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                homePremiumGradientDark,
                                homePremiumGradientLight,
                              ],
                            )),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '20/S cdd Yarn for Weaving',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11.sp),
                                  ),
                                  Text(
                                    '(100%) Cotton',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11.sp),
                                  ),
                                  Text(
                                    'PKR.22,000',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      )
                    ],
                  );
                },
              ))
        ],
      ),
    );
  }
}
