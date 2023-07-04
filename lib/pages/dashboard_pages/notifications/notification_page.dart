import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';

import '../../../model/home_model.dart';
import '../../../model/notifications_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<NotificationsModel> notificationsList=
  [
    NotificationsModel(id: "1", title: 'SALE IS LIVE',subTitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit.', image:notificationImage_1,date:"2m ago.",count:2),
    NotificationsModel(id: "2", title: 'SALE IS LIVE',subTitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit.', image:notificationImage_2,date:"6m ago.",count:2),
    NotificationsModel(id: "3", title: 'SALE IS LIVE',subTitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit.', image:notificationImage_3,date:"1m ago.",count:0),
    NotificationsModel(id: "4", title: 'SALE IS LIVE',subTitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit.', image:notificationImage_4,date:"9m ago.",count:0),
    NotificationsModel(id: "5", title: 'SALE IS LIVE',subTitle: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit dolor sit amet, consectetur adipiscing elit.', image:notificationImage_5,date:"2m ago.",count:0),
  ];

  var counter=2;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: appBar(context,"Notifications"),
      body: Container(
          padding: EdgeInsets.only(left:16.w,right: 16.w,bottom: 12.w,top: 12.w),
          margin: EdgeInsets.only(bottom: 4.w),
          child:ListView.builder(

            physics: const BouncingScrollPhysics(),
            itemCount: notificationsList.length,
            shrinkWrap: true,
            primary: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){

                },
                child: Padding(
                  padding: const EdgeInsets.only(top:12.0,bottom: 12.0),
                  child: Row(
                    children: [
                      Stack(
                        children: <Widget>[
                          Image.asset(
                            notificationsList[index].image.toString(),
                            // color: Colors.transparent,
                            fit: BoxFit.fill,
                            height: 55,
                            width: 55,
                          ),
                          // SvgPicture.asset(
                          //   notificationsList[index].image.toString(),
                          //   // color: Colors.transparent,
                          //   fit: BoxFit.cover,
                          //   height: 55,
                          //   width: 55,
                          // ),
                          notificationsList[index].count != 0 ?  Positioned(
                            right: 0,
                            top: 0,
                            child:  Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: notificationCountColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 19,
                                minHeight: 19,
                              ),
                              child: Text(
                                notificationsList[index].count.toString(),
                                style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ) : Container()
                        ],
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(notificationsList[index].title.toString().toUpperCase(),style: TextStyle(color:Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                            Text(notificationsList[index].subTitle ?? "N/A",style: TextStyle(color:Colors.black,fontSize: 10.sp,fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notificationsList[index].date ?? "N/A",style: TextStyle(color:notificationDateColor,fontSize: 12.sp,fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )

      ),
    );
  }
}


