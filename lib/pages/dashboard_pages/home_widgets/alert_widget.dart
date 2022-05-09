import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_images.dart';

class SlidingAlertWidget extends StatelessWidget {
  const SlidingAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 4.w, bottom: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:4.0),
            child: Image.asset(
              ALERT_IMAGE,
              width: 14.w,
              height: 14.w,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 6.w),
              child: CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 32 / 2,
                    scrollDirection: Axis.vertical,
                    autoPlay: true,
                    reverse: false,
                    viewportFraction: 1,
                    enlargeCenterPage: false,
                    pageSnapping: true,
                    disableCenter: false),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: StrutStyle(fontSize: 11.0.sp),
                              text: TextSpan(
                                  text:
                                      'Alert text with animation that get from server $i',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    /*fontFamily: 'Metropolis',*/
                                  )),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.arrow_downward_outlined,
                                color: Colors.red,
                                size: 9,
                              ),
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 9.0.sp),
                                text: TextSpan(
                                    text: '+21.20%',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 9.sp,
                                        /*fontFamily: 'Metropolis',*/)),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
