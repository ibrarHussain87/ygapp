import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/widgets/list_widgets/brand_text.dart';

class ListRatingWidget extends StatefulWidget {

  String rating;

  ListRatingWidget({Key? key,required this.rating}) : super(key: key);

  @override
  _ListRatingWidgetState createState() => _ListRatingWidgetState();
}

class _ListRatingWidgetState extends State<ListRatingWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BrandWidget(title: widget.rating),
        SizedBox(width: 2.w,),
        Image.asset(AppImages.ratingIcon,width: 9.w,height: 9.w,)
      ],
    );
  }
}
