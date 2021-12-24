import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/main_fiber_detail_page.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post/spinning_post_ad.dart';

void openFiberDetailsScreen(BuildContext context, Specification specification) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FiberDetailPage(
          specification: specification),
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
      builder: (context) => SpinningPostAdPage(
          locality: locality,
          businessArea: businessArea,
          selectedTab: selectedTab),
    ),
  );

}
