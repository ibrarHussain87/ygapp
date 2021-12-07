import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/get_banner_response.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/banner_widgets/banner_body.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class BannersWidget extends StatefulWidget {
  const BannersWidget({Key? key}) : super(key: key);

  @override
  _BannersWidgetState createState() => _BannersWidgetState();
}

class _BannersWidgetState extends State<BannersWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetBannersResponse>(
      future: ApiService.getBanners(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data!.data.banners.isNotEmpty) {
          return BannerBody(banners: snapshot.data!.data);
        } else if (snapshot.hasError) {
          return Center(
              child: TitleTextWidget(title: snapshot.error.toString()));
        } else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data!.data.banners.isEmpty) {
          return const Center(child: TitleTextWidget(title: 'No data found!!'));
        } else {
          return Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w,right: 16.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0.w),
                child: Image.asset(
                  AppImages.loading,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height / 7,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
