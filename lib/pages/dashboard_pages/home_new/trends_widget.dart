import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/model/trends_model.dart';

class HomeTrendsWidget extends StatefulWidget {
  const HomeTrendsWidget({Key? key}) : super(key: key);

  @override
  _HomeTrendsWidgetState createState() => _HomeTrendsWidgetState();
}

class _HomeTrendsWidgetState extends State<HomeTrendsWidget> {
  List<TrendsModel> trendsList = [
    TrendsModel(
        id: "1",
        title: 'Dollar',
        subTitle: '200.10',
        percent: "+1.76%",
        isDrop: false),
    TrendsModel(
        id: "2",
        title: 'Gold',
        subTitle: '375,175.75',
        percent: "-0.96%",
        isDrop: true),
    TrendsModel(
        id: "3",
        title: 'Crude Oil',
        subTitle: '180.10',
        percent: "+4.76%",
        isDrop: false),
    TrendsModel(
        id: "4",
        title: 'Bit Coin',
        subTitle: '3000.10',
        percent: "-11.76%",
        isDrop: true),
    TrendsModel(
        id: "5",
        title: 'Gold',
        subTitle: '200.10',
        percent: "+1.76%",
        isDrop: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 2.w, top: 16.w),
      margin: EdgeInsets.only(bottom: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //   child: TitleTextWidget(title: todayPremium),
          //   margin: EdgeInsets.only(bottom: 4.w),
          // ),
          SizedBox(
              height: 0.09 * MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: trendsList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 2.0,right: 2.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.w),
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              // decoration: BoxDecoration(color: const Color(0xFFEDF1F6)),
                              decoration: BoxDecoration(color:Colors.grey.shade100),
                              child: Padding(
                                padding: EdgeInsets.all(6.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment:
                                  // MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          trendsList[index].title.toString(),
                                          style: TextStyle(
                                              color: cardTitleColor,
                                              fontSize: 12.sp,
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(
                                          Icons.arrow_circle_right_outlined,
                                          color: cardTitleColor,
                                          size: 18.w,
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          trendsList[index].subTitle.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp,
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          trendsList[index].percent.toString(),
                                          style: TextStyle(
                                              color:
                                                  trendsList[index].isDrop == true
                                                      ? redDownColor
                                                      : greenUpColor,
                                              fontSize: 12.sp,
                                              fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          trendsList[index].isDrop == true
                                              ? red
                                              : green,
                                          scale: 1.4,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),

                                        Padding(
                                          padding: trendsList[index].isDrop == true ? const EdgeInsets.only(top: 2.0) : const EdgeInsets.only(bottom: 1.0),
                                          child: Text(
                                            trendsList[index].isDrop == true
                                                ? "Drop Quickly"
                                                : "Rose Quickly",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                color:
                                                    trendsList[index].isDrop == true
                                                        ? redDownColor
                                                        : greenUpColor,
                                                fontSize: 9.sp,
                                                fontFamily: 'Metropolis',
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
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
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
