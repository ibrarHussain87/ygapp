import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/main_fiber_detail_page.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/yarn_post_ad.dart';
import 'package:yg_app/pages/profile/my_ads/my_product_page.dart';
import 'package:yg_app/pages/profile/profile_page.dart';

void openFiberDetailsScreen(BuildContext context, Specification specification) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FiberDetailPage(
          specification: specification),
    ),
  );
}

void openProfileScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfilePage(),
    ),
  );
}

void openFiberPostPage(BuildContext context,String? locality,String? businessArea,String? selectedTab){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FiberPostPage(
          locality: locality,
          businessArea: businessArea,
          selectedTab: selectedTab),
    ),
  );

}

void openYarnPostPage(BuildContext context,String? locality,String? businessArea,String? selectedTab){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => YarnPostAdPage(
          locality: locality,
          businessArea: businessArea,
          selectedTab: selectedTab),
    ),
  );

}


void openMyAdsScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MyProductPage(),
    ),
  );
}
