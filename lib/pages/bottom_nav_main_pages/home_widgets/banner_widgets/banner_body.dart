import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:yg_app/model/response/get_banner_response.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/utils/colors.dart';

class BannerBody extends StatefulWidget {
  final BannerData banners;

  const BannerBody({Key? key, required this.banners}) : super(key: key);

  @override
  _BannerBodyState createState() => _BannerBodyState();
}

class _BannerBodyState extends State<BannerBody> {
  int currentImageBanner = 0;

  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      height: MediaQuery.of(context).size.height / 7,
      pagination: true,
      pagerSize: 2.0,
      autoPlay: true,
      enableInfiniteScroll: true,
      activeIndicator: AppColors.lightBlueTabs,
      passiveIndicator: AppColors.textColorGreyLight,
      items: widget.banners.banners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0.w),
                child: CachedNetworkImage(
                  imageUrl: i.banner,
                  placeholder: (context,
                          url) => /*Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        color: AppColors.lightBlueTabs,
                      ))*/
                      Image.asset(
                    AppImages.loading,
                    fit: BoxFit.fill,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        );
      }).toList(),
      onPageChanged: (index) {
        setState(() {
          currentImageBanner = index;
        });
      },
    );
  }
}
