import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  const TitleTextWidget({Key? key, required this.title,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title??"N/A",
      style: TextStyle(
          color: color??Colors.black,
          fontSize: 14.sp,
          fontFamily: 'Metropolis',
          fontWeight: FontWeight.bold),
    );
  }
}

class LargeTitleTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  const LargeTitleTextWidget({Key? key, required this.title,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title??"N/A",
      style: TextStyle(
          color: color??Colors.black,
          fontSize: 16.sp,
          fontFamily: 'Metropolis',
          fontWeight: FontWeight.w400),
    );
  }
}

class NormalTitleTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  const NormalTitleTextWidget({Key? key, required this.title,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title??"N/A",
      style: TextStyle(
          color: color??Colors.black,
          fontSize: 13.sp,
          fontFamily: 'Metropolis',
          fontWeight: FontWeight.w500),
    );
  }
}

class TitleSmallTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  final double? padding;

  const TitleSmallTextWidget({Key? key, required this.title,this.color,this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding??2.w),
      child: Text(
        title??"N/A",
        style: TextStyle(
            color: color?? Colors.black87,
            fontSize: 11.sp,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w500),
      ),
    );
  }

}

class TitleSmallBoldTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  final double? padding;
  final double? size;
  final FontWeight? weight;

  const TitleSmallBoldTextWidget({Key? key, required this.title,
    this.color,this.padding,this.weight,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding??2.w),
      child: Text(
        title??"N/A",
        style: TextStyle(
            color: color?? Colors.black87,
            fontSize: size??11.sp,
            fontFamily: 'Metropolis',
            fontWeight: weight??FontWeight.w600),
      ),
    );
  }

}

class TitleSmallNormalTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  final double? padding;
  final double? size;
  final FontWeight? weight;

  const TitleSmallNormalTextWidget({Key? key, required this.title,this.color,
    this.padding,this.size,this.weight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding??2.w),
      child: Text(
        title??"N/A",
        style: TextStyle(
            color: color?? Colors.black87,
            fontSize: size??10.sp,
            fontFamily: 'Metropolis',
            fontWeight: weight??FontWeight.w500),
      ),
    );
  }

}

class TitleMediumTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  final double? padding;
  final double? size;
  final FontWeight? weight;

  const TitleMediumTextWidget({Key? key, required this.title,this.color,this.padding,this.weight,this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding??0.w,),
      child: Text(
        title??"N/A",
        overflow: TextOverflow.fade,
        maxLines: 1,
        softWrap: false,
        style: TextStyle(
            color: color??Colors.black,
            fontSize: size??12.sp,
            fontFamily: 'Metropolis',
            fontWeight: weight??FontWeight.bold),
      ),
    );
  }

}

class TitleBoldSmallTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  final double? textSize;

  const TitleBoldSmallTextWidget({Key? key, required this.title,this.color,this.textSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.w),
      child: Text(
        title!,
        style: TextStyle(
            color: color ?? Colors.black87,
            fontSize: textSize?? 10.sp,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.bold),
      ),
    );
  }

}

class TitleMediumBoldSmallTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  final double? textSize;

  const TitleMediumBoldSmallTextWidget({Key? key, required this.title,this.color,this.textSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.w),
      child: Text(
        title!,
        style: TextStyle(
            color: color ?? Colors.black87,
            fontSize: textSize?? 10.sp,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w600),
      ),
    );
  }

}

class TitleExtraSmallTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  final double? textSize;

  const TitleExtraSmallTextWidget({Key? key, required this.title,this.color,this.textSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Text(
        title!,
        style: TextStyle(
            color: color ?? Colors.black87,
            fontSize: textSize?? 9.sp,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w500),
      ),
    );
  }

}

class TitleExtraSmallBoldTextWidget extends StatelessWidget {

  final String? title;
  final Color? color;
  final double? textSize;

  const TitleExtraSmallBoldTextWidget({Key? key, required this.title,this.color,this.textSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Text(
        title!,
        style: TextStyle(
            color: color ?? Colors.black87,
            fontSize: textSize?? 9.sp,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w600),
      ),
    );
  }

}

class TitleCustomSizeTextWidget extends StatelessWidget {

  final String? title;
  final double? sizeText;

  const TitleCustomSizeTextWidget({Key? key, required this.title,required this.sizeText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.w),
      child: Text(
        title!,
        style: TextStyle(
            color: Colors.black87,
            fontSize: sizeText!.sp,
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w500),
      ),
    );
  }

}