import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/detail_pages/detail_page/detail_page_renewed.dart';
import 'package:yg_app/pages/detail_pages/detail_page/specification_user/specification_user_page.dart';
import 'package:yg_app/pages/post_ad_pages/fiber_post/fiber_post_page.dart';
import 'package:yg_app/pages/post_ad_pages/stocklot_page/create_stocklot_page.dart';
import 'package:yg_app/pages/post_ad_pages/yarn_post/yarn_post_ad.dart';
import 'package:yg_app/pages/profile/my_products/list_bids_page/bids_page.dart';
import 'package:yg_app/pages/profile/my_products/my_product_page.dart';
import 'package:yg_app/pages/profile/profile_page.dart';
import 'package:yg_app/pages/profile/update_profile/customer_support.dart';
import 'package:yg_app/pages/profile/update_profile/customer_support_2.dart';
import 'package:yg_app/pages/profile/update_profile/edit_profile.dart';
import 'package:yg_app/pages/profile/update_profile/membership.dart';
import 'package:yg_app/pages/profile/update_profile/update_profile.dart';

import '../pages/post_ad_pages/fabric_post/fabric_post_page.dart';

void openDetailsScreen(BuildContext context,
    {Specification? specification,
    YarnSpecification? yarnSpecification,
    dynamic specObj,
    bool? isFromBid,
    bool? sendProposal}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailRenewedPage(
        specification: specification,
        yarnSpecification: yarnSpecification,
        specObj: specObj,
        isFromBid: isFromBid,
        sendProposal: sendProposal,
      ),
    ),
  );
}

void openProfileScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ProfilePage(),
    ),
  );
}

void openFiberPostPage(BuildContext context, String? locality,
    String? businessArea, String? selectedTab) {
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

void openYarnPostPage(BuildContext context, String? locality,
    String? businessArea, String? selectedTab) {
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

void openStockLotPostPage(BuildContext context, String? locality,
    String? businessArea, String? selectedTab) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CreateStockLotPage(
          locality: locality,
          businessArea: businessArea,
          selectedTab: selectedTab),
    ),
  );
}

void openFabricPostPage(BuildContext context, String? locality,
    String? businessArea, String? selectedTab) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FabricPostPage(
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

void openPersonalDetailsScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const EditProfilePage(),
//      builder: (context) => const UpdateProfilePage(),
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

void openSpecificationUserScreen(
  BuildContext context,
  String specId,
  String categoryId,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          SpecificationUserPage(specId: specId, categoryId: categoryId),
    ),
  );
}

///////////////
void openMembershipScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const MembershipPage(),
    ),
  );
}

void openCustomerSupportScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const CustomerSupportPage2(),
    ),
  );
}

//////////////////////
