import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8.w),
          child: CarouselSlider(
            options: CarouselOptions(height: 140.0.w),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: Image.asset(
                      AppImages.placeHolder,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        )
      ],
    )));
  }
}
