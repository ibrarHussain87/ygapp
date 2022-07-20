import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../helper_utils/app_colors.dart';

class SecondIntro extends StatelessWidget {

  final String title;
  final String message;
  final String bg;
  final String circle;
  final String image;

   const SecondIntro(this.title,this.message, this.bg,this.circle,this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildImage(context, bg, circle, image),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 20.w,horizontal: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold,color: HexColor.fromHex("#33363A")),),
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: 8.h),
                  child: Text(message,style: TextStyle(fontSize:12.sp,fontWeight: FontWeight.normal,color: HexColor.fromHex("#33363A")),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context,String bg,String circle,String image) {
    return Stack(
      children: [
        Image.asset(bg, width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),

         Center(child: Image.asset(circle)),
        Positioned.fill(child: Center(child: Image.asset(image,scale: 1.5,))),
      ],
    );
  }
}