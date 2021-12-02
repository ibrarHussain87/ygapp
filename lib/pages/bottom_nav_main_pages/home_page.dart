import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/home_filter_widget.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/home_premium_widget.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/market_stock_widget.dart';
import 'package:yg_app/pages/bottom_nav_main_pages/home_widgets/market_trend_widget.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  int currentImageBanner = 0;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.w),
                    child: GFCarousel(
                      height: MediaQuery.of(context).size.height/5,
                      pagination: false,
                      autoPlay: true,
                      enableInfiniteScroll: true,
                      activeIndicator: AppColors.lightBlueTabs,
                      passiveIndicator: AppColors.textColorGreyLight,
                      items: imgList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0.w),
                                child: Image.network(
                                  i,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                      onPageChanged: (index){
                        setState(() {
                          currentImageBanner = index;
                        });
                      },
                    ),
                  ),
                  DotsIndicator(
                    dotsCount: imgList.length,
                    position: double.tryParse(currentImageBanner.toString())!,
                    decorator: DotsDecorator(
                      size: Size.square(6.w),
                      spacing: const EdgeInsets.all(4.0),
                    ),
                  )
                ],
              ),
              HomeFilterWidget(),
              HomePremiumWidget(),
              MarketStockWidget(),
              Expanded(child: MarketTrendWidget())
            ],
          ),

        ],
      ),
    ));
  }
}
