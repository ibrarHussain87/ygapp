import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/providers/home_providers/banners_provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/model/response/get_banner_response.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerBody extends StatefulWidget {
  const BannerBody({Key? key}) : super(key: key);

  @override
  _BannerBodyState createState() => _BannerBodyState();
}

class _BannerBodyState extends State<BannerBody> {

  int currentImageBanner = 0;

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  void initState() {
    super.initState();
    final bannerProvider = Provider.of<BannersProvider>(context,listen: false);
    bannerProvider.getBannerData();
  }

  @override
  Widget build(BuildContext context) {
    final bannerProvider = Provider.of<BannersProvider>(context);
    return bannerProvider.bannerData.banners != null
        ? Column(
            children: [
              GFCarousel(
                height: MediaQuery.of(context).size.height / 5.5,
                pagination: false,
                viewportFraction: 1.0,
                autoPlay: true,
                enlargeMainPage: false,
                enableInfiniteScroll: true,
                activeIndicator: lightBlueTabs,
                passiveIndicator: textColorGreyLight,
                items: bannerProvider.bannerData.banners!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0.w),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              _launchURL(i.url);
                            },
                            child: CachedNetworkImage(
                              imageUrl: i.banner??"",
                              fit: BoxFit.fill,
                              placeholder: (context,
                                      url) => /*Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              color: lightBlueTabs,
                            ))*/
                                  Image.asset(
                                loading,
                                fit: BoxFit.fill,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
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
              // Container(
              //   padding: EdgeInsets.only(top: 2.w),
              //   child: DotsIndicator(
              //     dotsCount: bannerProvider.bannerData.banners!.length,
              //     position: double.tryParse(currentImageBanner.toString())!,
              //     decorator: DotsDecorator(
              //       shape: const _DiamondBorder(),
              //       activeShape: const _DiamondBorder(),
              //       size: Size.square(4.w),
              //       activeSize: Size.square(8.w),
              //       spacing: const EdgeInsets.all(2.0),
              //     ),
              //   ),
              // )
            ],
          )
        : Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0.w),
                child: Image.asset(
                  loading,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height / 6,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
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
      ..lineTo(rect.left + rect.width / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }
}
