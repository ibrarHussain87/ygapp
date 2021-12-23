import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
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
    return Column(
      children: [
        GFCarousel(
          height: MediaQuery.of(context).size.height / 7,
          pagination: false,
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
        ),
        DotsIndicator(
          dotsCount: widget.banners.banners.length,
          position: double.tryParse(currentImageBanner.toString())!,

          decorator: DotsDecorator(
            shape: _DiamondBorder(),
            activeShape: _DiamondBorder(),
            size: Size.square(4.w),
            activeSize: Size.square(4.w),
            spacing: const EdgeInsets.all(2.0),
          ),
        )
      ],
    );
  }
}

class _DiamondBorder extends ShapeBorder {
  const _DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getOuterPath
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width  / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {

  }

  // This border doesn't support scaling.
 @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }
}
