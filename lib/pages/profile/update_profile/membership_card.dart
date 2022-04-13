import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';


Widget buildSuperMembershipWidget(
    BuildContext context, int index,

    ) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.only(left:0.0),
    child: Material(

        color: index==1 ? cardColor :  Colors.white,
        elevation: /*18.0*/0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [

                  SizedBox(height: 20,),
                  Text('Super Offer',
                      style: TextStyle(
                          fontSize: 20.0.w,
                          color: index ==1 ? Colors.white : unSelectHeadingTextColor,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: height/40,),
                  Text('What You\'ll Get',
                      style: TextStyle(
                          fontSize: 12.0.w,
                          color: subHeadingColor,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: height/40,),
                  Row(
                    children: [
                      Image.asset(index ==1 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('Edit up to 1,000 hours of \npodcast audio files.',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color: index ==1 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: height/40,),
                  Row(
                    children: [
                      Image.asset(index ==1 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('Set your own landing page',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color: index ==1 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: height/40,),

                  Row(
                    children: [
                      Image.asset(index ==1 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('24/7 support',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color: index ==1 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),

                  SizedBox(height: height/40,),
                  Row(
                    children: [
                      Image.asset(index ==1 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('Advanced analytics',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color: index ==1 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: height/45,),
//                  Image.asset(white_tick),

                  Image.asset(divider_line,height:10,color: index ==1 ?  subHeadingColor : unSelectHeadingTextColor,),
                  SizedBox(height: height/15,),
                  RichText(
                    text: TextSpan(
                      text: '\$480',
                      style: TextStyle(
                          fontSize: 20.0.w,
                          color: index ==1 ? Colors.white : unSelectHeadingTextColor,
                          fontWeight: FontWeight.w700),
                      children:  <TextSpan>[
                        TextSpan(text: '/month ', style: TextStyle(
                            fontSize: 14.0.w,
                            color: index ==1 ? Colors.white : unSelectHeadingTextColor,
                            fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),

                  SizedBox(height: height/60,),
                  SizedBox(
                      width: double.infinity,
                      height: height/15,
                      child: Builder(builder: (BuildContext context1) {
                        return ElevatedButton(
                            child: Text("Choose",
                                style: TextStyle(
                                    fontFamily: 'Metropolis', fontSize: 16.sp,fontWeight: FontWeight.w600)),
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(btnTextColor),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                        side: BorderSide(color: Colors.transparent)))),
                            onPressed: () {

                            });
                      })),
                  SizedBox(height: 20,)

                ],
              ),
            ),
          ],
        )
    ),
  );
}

Widget buildFreeMembershipWidget(
    BuildContext context, int index,
    ) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Material(
        color: index==0 ? cardColor :  Colors.white,
        elevation: /*18.0*/0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 20,),
                  Text('Basic Plan',
                      style: TextStyle(
                          fontSize: 20.0.w,
                          color: index ==0 ? Colors.white : unSelectHeadingTextColor,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: height/90,),
                  Text('What You\'ll Get',
                      style: TextStyle(
                          fontSize: 12.0.w,
                          color: subHeadingColor,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: height/40,),
                  Row(
                    children: [
                      Image.asset(index ==0 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('Edit up to 1,000 hours of \npodcast audio files.',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color: index ==0 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: height/40,),
                  Row(
                    children: [
                      Image.asset(index ==0 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('Set your own landing page',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color:index ==0 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: height/45,),

                  Image.asset(divider_line,height:10,color: index ==0 ?  subHeadingColor : unSelectHeadingTextColor,),

                  SizedBox(height: height/6,),
                  RichText(
                    text: TextSpan(
                      text: 'Free Forever',
                      style: TextStyle(
                          fontSize: 20.0.w,
                          color: index ==0 ? Colors.white : unSelectHeadingTextColor,
                          fontWeight: FontWeight.w700),

                    ),
                  ),
                  SizedBox(height: height/80,),
                  SizedBox(
                      width: double.infinity,
                      height: height/15,
                      child: Builder(builder: (BuildContext context1) {
                        return ElevatedButton(
                            child: Text("Choose",
                                style: TextStyle(
                                    fontFamily: 'Metropolis', fontSize: 16.sp,fontWeight: FontWeight.w600)),
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(btnTextColor),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(unSelectBtnTextColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                        side: BorderSide(color: Colors.transparent)))),
                            onPressed: () {

                            });
                      })),

                  SizedBox(height:20,),
                ],
              ),
            ),
          ],
        )
    ),
  );
}


Widget buildPremiumMembershipWidget(
    BuildContext context, int index,
    ) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.only(left:0.0),
    child: Material(
        color: index==2 ? cardColor :  Colors.white,
        elevation: /*18.0*/0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:20.0,right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [

                  SizedBox(height: 20,),
                  Text('Premium Offer',
                      style: TextStyle(
                          fontSize: 20.0.w,
                          color: index ==2 ? Colors.white : unSelectHeadingTextColor,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: height/40,),
                  Text('What You\'ll Get',
                      style: TextStyle(
                          fontSize: 12.0.w,
                          color: subHeadingColor,
                          fontWeight: FontWeight.w400)),
                  SizedBox(height: height/40,),
                  Row(
                    children: [
                      Image.asset(index ==2 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('Edit up to 1,000 hours of \npodcast audio files.',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color: index ==2 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: height/40,),
                  Row(
                    children: [

                      Image.asset(index ==2 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('Set your own landing page',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color: index ==2 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: height/40,),

                  Row(
                    children: [
                      Image.asset(index ==2 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('24/7 support',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color: index ==2 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),

                  SizedBox(height: height/40,),
                  Row(
                    children: [

                      Image.asset(index ==2 ? white_tick : black_tick,height: 20,width: 20,),
                      const SizedBox(width: 5),
                      Text('Advanced analytics',
                          style: TextStyle(
                              fontSize: 10.0.w,
                              color: index ==2 ? Colors.white : unSelectHeadingTextColor,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: height/45,),

                  Image.asset(divider_line,height:10,color: index ==2 ?  subHeadingColor : unSelectHeadingTextColor,),
                  SizedBox(height: height/15,),
                  RichText(
                    text: TextSpan(
                      text: '\$600',
                      style: TextStyle(
                          fontSize: 20.0.w,
                          color: index ==2 ? Colors.white : unSelectHeadingTextColor,
                          fontWeight: FontWeight.w700),
                      children:  <TextSpan>[
                        TextSpan(text: '/month ', style: TextStyle(
                            fontSize: 14.0.w,
                            color: index ==2 ? Colors.white : unSelectHeadingTextColor,
                            fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),

                  SizedBox(height: height/50,),
                  SizedBox(
                      width: double.infinity,
                      height: height/15,
                      child: Builder(builder: (BuildContext context1) {
                        return ElevatedButton(
                            child: Text("Choose",
                                style: TextStyle(
                                    fontFamily: 'Metropolis', fontSize: 16.sp,fontWeight: FontWeight.w600)),
                            style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(btnTextColor),
                                backgroundColor:
                                MaterialStateProperty.all<Color>(unSelectBtnTextColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                        side: BorderSide(color: Colors.transparent)))),
                            onPressed: () {

                            });
                      })),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ],
        )
    ),
  );
}




