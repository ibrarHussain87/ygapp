import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/list_widgets/brand_text.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class BidderListPage extends StatefulWidget {
  const BidderListPage({Key? key}) : super(key: key);

  @override
  _BidderListPageState createState() => _BidderListPageState();
}

class _BidderListPageState extends State<BidderListPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.w),
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return getItem(index);
          }),
    );
  }

  Widget getItem(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom:8.w,top: 8.w),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(6.w),
        color: Colors.grey.shade200,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.postAdGreyIcon,
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(width: 8.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleSmallTextWidget(title: 'Bidder Name'),
                    BrandWidget(title: '20-20-1998')
                  ],
                ),
                flex: 8,
              ),
              TitleTextWidget(title: 'PKR.22000')
            ],
          ),
        ),
      ),
    );
  }
}
