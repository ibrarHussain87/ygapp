import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/title_text_widget.dart';

class ProfileTileWidget extends StatelessWidget {

  final String image;
  final String title;

  const ProfileTileWidget({Key? key,required this.title,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0,left: 0.0,right: 8.0,bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex:2,child: Image.asset(image,width: 20,height: 20,)),
          SizedBox(width: 16.w,),
          Expanded(flex:8,child: NormalTitleTextWidget(title: title,fontSize: 14,)),
          SizedBox(width: 5.w,),
          const Expanded(flex:1,child: Icon(Icons.navigate_next,size: 24,color: Colors.black,)),
        ],
      ),
    );
  }
}
