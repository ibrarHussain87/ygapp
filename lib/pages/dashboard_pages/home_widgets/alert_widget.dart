import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/providers/home_providers/trends_widget_provider.dart';

class SlidingAlertWidget extends StatefulWidget {
  const SlidingAlertWidget({Key? key}) : super(key: key);

  @override
  State<SlidingAlertWidget> createState() => _SlidingAlertWidgetState();
}

class _SlidingAlertWidgetState extends State<SlidingAlertWidget> {

  final _trendWidgetProvider = locator<TrendsWidgetProvider>();

  @override
  void initState() {
    // TODO: implement initState
    _trendWidgetProvider.addListener(() {
      if(mounted){
        setState((){});
      }
    });
    _trendWidgetProvider.getAlertBars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w,),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

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
                items: _trendWidgetProvider.alertBarsList.map((value) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:4.0),
                            child: Image.asset(
                              ALERT_IMAGE,
                              width: 14.w,
                              height: 14.w,
                            ),
                          ),
                          Flexible(
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              strutStyle: StrutStyle(fontSize: 11.0.sp),
                              text: TextSpan(
                                  text:
                                  value.alertBarText,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w400,
                                    /**/
                                  )),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                value.alertBarDirection == 'down' ? Icons.arrow_downward_outlined : Icons.arrow_upward_outlined,
                                color:value.alertBarDirection == 'down'? Colors.red : Colors.green,
                                size: 9,
                              ),
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                strutStyle: StrutStyle(fontSize: 9.0.sp),
                                text: TextSpan(
                                    text: value.alertBarPercentage,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 9.sp,
                                      /**/)),
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

