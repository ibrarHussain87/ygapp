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
  List<TrendsModel> trendsList=
  [
    TrendsModel(id: "1", title: 'Dollar',subTitle: '200.10',percent:"+1.76%",isDrop:false),
    TrendsModel(id: "2", title: 'Gold',subTitle: '375,175.75',percent:"-0.96%",isDrop:true),
    TrendsModel(id: "3", title: 'Dollar',subTitle: '200.10',percent:"+1.76%",isDrop:false),
    TrendsModel(id: "4", title: 'Gold',subTitle: '200.10',percent:"+1.76%",isDrop:false),
    TrendsModel(id: "5", title: 'Gold',subTitle: '200.10',percent:"+1.76%",isDrop:false),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:16.w,right: 16.w,bottom: 8.w,top: 8.w),
      margin: EdgeInsets.only(bottom: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Container(
          //   child: TitleTextWidget(title: todayPremium),
          //   margin: EdgeInsets.only(bottom: 4.w),
          // ),
          SizedBox(
              height: 0.12 * MediaQuery.of(context).size.height,

              child: ListView.builder(
                itemCount: trendsList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.w),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width/2.4,
                            decoration: BoxDecoration(
                            color: trendsBgColor
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        trendsList[index].title.toString(),
                                        style: TextStyle(
                                            color: cardTitleColor, fontSize: 11.sp,fontWeight: FontWeight.w400),
                                      ),
                                      Icon(
                                        Icons.arrow_circle_right_outlined,
                                        color: cardTitleColor,
                                        size: 18.w,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        trendsList[index].subTitle.toString(),
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 11.sp,fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        trendsList[index].percent.toString(),
                                        style: TextStyle(
                                            color: trendsList[index].isDrop==true ? Colors.red : Colors.green,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [

                                      Image.asset(
                                        trendsList[index].isDrop==true ? red : green,
                                        scale:1.00 ,

                                      ),
                                      const SizedBox(width: 3,),
                                      Text(
                                        trendsList[index].isDrop==true ? "Drop Quickly" : "Rose Quickly",
                                        style: TextStyle(
                                            color: trendsList[index].isDrop==true ? Colors.red : Colors.green,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400),
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
                  );
                },
              ))
        ],
      ),
    );
  }
}
