import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
                    bottomRight:  Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0))

            ),
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
//                    Navigator.pop(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.w,top: 8.w),
                      child: Icon(
                        Icons.segment,
                        color: Colors.white,
                        size: 22.w,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Yarn Guru",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0.w,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {

                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.w,top: 8.w),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 22.w,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left:16.w,right: 16.w,bottom: 8.w,top: 8.w),
        margin: EdgeInsets.only(bottom: 4.w),
        child:ListView(
          shrinkWrap: true,
          primary: true,
          children: [
            TitleTextWidget(title: todayPremium),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  )),
              child:  ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
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
              ),
            ),

          ],
        )


      ),
    );
  }
}
