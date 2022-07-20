import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';
class CustomShowcaseWidget extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? description;
  final GlobalKey? globalKey;

   const CustomShowcaseWidget({Key? key,
    @required this.title,
    @required this.description,
    @required this.child,
    @required this.globalKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Showcase(
    key: globalKey!,
    showcaseBackgroundColor:Colors.black45,
    contentPadding: const EdgeInsets.all(8),
    showArrow: true,
    disableAnimation: false,
    // shapeBorder: const CircleBorder(),
    // radius: const BorderRadius.all(Radius.circular(40)),
    overlayPadding: const EdgeInsets.all(5),
    blurValue: 3,
    title: title,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 16.sp,
    ),
    description: description,
    descTextStyle:  TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 11.sp,
    ),
    overlayColor: Colors.black,
    overlayOpacity: 0.7,
    child: child!,
  );
}