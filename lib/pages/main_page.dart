import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/utils/colors.dart';

import 'main_pages/home_page.dart';
import 'main_pages/international_page.dart';
import 'main_pages/market_page.dart';
import 'main_pages/post_ad.dart';
import 'main_pages/yg_services.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> _screens = [
    HomePage(),
    MarketPage(),
    InternationalPage(),
    YGServices(),
    PastAdPage()
  ];
  int _selectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
        controller: pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: _screens,
        physics: NeverScrollableScrollPhysics());
  }

  void _onItemTapped(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
      pageController.animateToPage(selectedIndex,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: buildPageView(), bottomNavigationBar: _generateBottomBar()),
    );
  }

  BottomNavigationBar _generateBottomBar() {
    return BottomNavigationBar(
      selectedItemColor: AppColors.textColorBlue,
      unselectedItemColor: AppColors.textColorGrey,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      elevation: 8,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.all(8),
                child: Image.asset(
                  'images/ic_home_grey.png',
                  width: 20,
                  height: 20,
                )),
            activeIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/ic_home_blue.png',
                width: 20,
                height: 20,
              ),
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/ic_market_grey.png',
                width: 20,
                height: 20,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/ic_market_blue.png',
                width: 20,
                height: 20,
              ),
            ),
            label: 'Local Market'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/ic_market_grey.png',
                width: 20,
                height: 20,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/ic_market_blue.png',
                width: 20,
                height: 20,
              ),
            ),
            label: 'International'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/yg_service_grey.png',
                width: 20,
                height: 20,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/yg_service_blue.png',
                width: 20,
                height: 20,
              ),
            ),
            label: 'YG Service'),
        BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/post_ad_grey.png',
                width: 20,
                height: 20,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'images/post_ad_blue.png',
                width: 20,
                height: 20,
              ),
            ),
            label: 'Post AD'),
      ],
    );
  }
}
