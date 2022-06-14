import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/loading_widgets/loading_image_widget.dart';

class LoadingListing extends StatelessWidget {
  const LoadingListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(4.w),
            child: const ImageLoadingWidget());
      },
      itemCount: 10,
      scrollDirection: Axis.horizontal,
    );
  }
}
