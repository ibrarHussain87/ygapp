import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/detail_page.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/detail_page_renewed.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/yarn_post_ad.dart';
import 'package:yg_app/pages/profile/my_products/list_bids_page/bids_page.dart';
import 'package:yg_app/pages/profile/my_products/my_product_page.dart';
import 'package:yg_app/pages/profile/profile_page.dart';

void openDetailsScreen(BuildContext context, {Specification? specification,YarnSpecification? yarnSpecification}) {
  if(specification!= null){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FiberDetailRenewedPage(
            specification: specification),
      ),
    );
  }else{
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FiberDetailRenewedPage(
            yarnSpecification: yarnSpecification),
      ),
    );
  }

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
void openMyBidsScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BidsListPage(),
    ),
  );
}
