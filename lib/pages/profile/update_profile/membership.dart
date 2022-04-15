
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';

import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/pages/profile/update_profile/membership_card.dart';


class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageValue = 0;
  int previousPageValue = 0;
  int currentImageBanner = 1;
  PageController? controller;
  double _moveBar = 0.0;
  @override
  void initState() {
    super.initState();
    controller=PageController(initialPage: currentPageValue);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final List<Widget> introWidgetsList = <Widget>[
      buildFreeMembershipWidget(context,0),
      buildSuperMembershipWidget(context,1),
      buildPremiumMembershipWidget(context,2)
      ];
    return SafeArea(
      child: Scaffold(
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
          title: Text('Membership',
              style: TextStyle(
                  fontSize: 16.0.w,
                  color: appBarTextColor,
                  fontWeight: FontWeight.w400)),
        ),
        key: scaffoldKey,
        backgroundColor: Colors.grey.shade200,
        body:SizedBox(
          width:width,
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height/15,),
              Text("Choose Your Plan",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 22.0.w,
                  color: headingColor,
                  fontWeight: FontWeight.w700)),
              SizedBox(height: height/25,),


              GFCarousel(
                height: height/1.6,
                pagination: false,
                reverse: false,
                initialPage: 1,
                enlargeMainPage: true,
                enableInfiniteScroll: true,
                activeIndicator: btnTextColor,
                passiveIndicator: textColorGreyLight,
                items:[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: buildFreeMembershipWidget(context,currentImageBanner),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: buildSuperMembershipWidget(context,currentImageBanner),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: buildPremiumMembershipWidget(context,currentImageBanner),
                    ),
                  ),
                ],
                onPageChanged: (index) {
                  setState(() {
                    currentImageBanner=index;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 15.w),
                child: DotsIndicator(
                  dotsCount: introWidgetsList.length,
                  position: double.tryParse(currentImageBanner.toString())!,
                  decorator: DotsDecorator(
                    activeColor: btnTextColor,
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    size: Size.fromRadius(4.w),
                    spacing: const EdgeInsets.all(4.0),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


}
