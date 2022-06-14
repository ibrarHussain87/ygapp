
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/app_images.dart';

class CustomerSupportPage extends StatefulWidget {
  const CustomerSupportPage({Key? key}) : super(key: key);

  @override
  _CustomerSupportPageState createState() => _CustomerSupportPageState();
}

class _CustomerSupportPageState extends State<CustomerSupportPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Card(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 12.w,
                      )),
                )),
          ),
          title: Text('Customer Support',
              style: TextStyle(
                  fontSize: 16.0.w,
                  color: appBarTextColor,
                  fontWeight: FontWeight.w400)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height/14,),
            Image.asset(support,scale:3,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(customerSupportMain,textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 20.0.w,
                  color: headingColor,
                  fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: height/20,),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 15.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: border_color_customer,width: 0.5),
                  color: tagsBackground,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:Stack(
                  children: [
                    Image.asset(chat,scale: 4,),
                    Positioned(
                      top: 3,
                      left: 30,
                      child: Text(
                        liveChat,
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                            color: text_color_customer,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      child: Icon(
                        Icons.navigate_next,
                        size: 16.0,
                        color: text_color_customer,
                      ),
                    ),
                  ],
                ),


              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 15.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: border_color_customer,width: 0.5),
                  color: tagsBackground,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:Stack(
                  children: [
                    Image.asset(faqs,scale: 4,),
                    Positioned(
                      top: 3,
                      left: 30,
                      child: Text(
                        faq,
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                            color: text_color_customer,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      child: Icon(
                        Icons.navigate_next,
                        size: 16.0,
                        color: text_color_customer,
                      ),
                    ),
                  ],
                ),


              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 15.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: border_color_customer,width: 0.5),
                  color: tagsBackground,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:Stack(
                  children: [
                    Image.asset(email_icon,scale: 4,),
                    Positioned(
                      top: 3,
                      left: 30,
                      child: Text(
                        email,
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                            color: text_color_customer,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      child: Icon(
                        Icons.navigate_next,
                        size: 16.0,
                        color: text_color_customer,
                      ),
                    ),
                  ],
                ),


              ),
            ),




          ],
        ),
      ),
    );
  }



}


