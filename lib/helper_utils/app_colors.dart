import 'dart:ui';

var textColorBlue = HexColor.fromHex('#3BC458');
var textColorGrey = HexColor.fromHex('#5C5C7B');

////
var newColorGrey = HexColor.fromHex('#C3CCD3');
var hintColorGrey = HexColor.fromHex('#ced3d7');
var headingColor = HexColor.fromHex('#2E2F32');
var subHeadingColor = HexColor.fromHex('#C6C6D0');
var cardColor = HexColor.fromHex('#2267db');
var btnTextColor = HexColor.fromHex('#2267DB');
var unSelectHeadingTextColor = HexColor.fromHex('#0B0914');
var unSelectBtnTextColor = HexColor.fromHex('#ECF6FF');
var tabColors = HexColor.fromHex('#25398B');
var tabBackground = HexColor.fromHex('#f3f8fc');
var indicatorColor = HexColor.fromHex('#A7B5C2');
var formFieldLabel = HexColor.fromHex('#728498');
var brandFieldLabel = HexColor.fromHex('#5E7389');
var tagsBackground = HexColor.fromHex('#E3ECFF');
var tagsTextColor = HexColor.fromHex('#2E59B1');
var tagsIconColor = HexColor.fromHex('#BAC5DC');
var addBtnColor = HexColor.fromHex('#1AC646');
var redColorLight = HexColor.fromHex('#EC4F4F');
var text_color_customer = HexColor.fromHex('#2E59B1');
var border_color_customer = HexColor.fromHex('#4977D6');
var border_color = HexColor.fromHex('#e3e3e3');
var whatsapp_color_customer = HexColor.fromHex('#1bbd66');
var whatsapp_color = HexColor.fromHex('#33cd49');
var messanger_color_customer = HexColor.fromHex('#0077ff'); //0b86ee
var message_color_customer = HexColor.fromHex('#1871e4');
var telegram_color_customer = HexColor.fromHex('#32a8e5');
var contact_color_customer = HexColor.fromHex('#7c6ce8');
var sub_head_color_share = HexColor.fromHex('#6b7479');
var icon_color_share = HexColor.fromHex('#56656c');
var divider_color_share = HexColor.fromHex('#eeeeee');
var font_light_grey = HexColor.fromHex('#80838b');
var font_dark_grey = HexColor.fromHex('#414246');


//


var tileGreyClr = HexColor.fromHex('#DDF1FA');
var textColorGreyLight = HexColor.fromHex('#A1A8B3');
var strokeGrey = HexColor.fromHex('#E0E0E0');
var btnGreen = HexColor.fromHex('#2AC54D');
var textFieldLabel = const Color(0xFF3BC458);
var btnColorLogin = const Color(0xFF3BC458);
var lightBlueTabs = const Color(0xFF3BC458);
var pintFeatureClr = const Color(0xFFFC6A6D);
var titleColor = const Color(0xFFA0463E);
var tileSeaGreen = const Color(0xFFE6F2FE);
var appBarTextColor = const Color(0xFF3BC458);
var searchBarGreyStroke = const Color(0xFF939598);
var searchBarGreyText = const Color(0xFFE0E0E0);
var searchBarWhiteBg = const Color(0xFFF7F7F7);
var blueBackgroundColor = const Color(0xFF142650);
var lightBlueContainer = const Color(0xFFE4F1F2);
var lightBlueLabel = const Color(0xFF4292B3);
var lightGreenContainer = const Color(0xFFE2F7E9);
var lightGreenLabel = const Color(0xFF75C387);
var lightYellowContainer = const Color(0xFFF4F4DC);
var lightYellowLabel = const Color(0xFFAF9D43);
var greenButton = const Color(0xFF58C971);
var redColor = const Color(0xFFDD2B22);
var lightGreyColor = const Color(0xFF9A9A9A);
var skyBlueColor = const Color(0xFF29C1D0);
var iconColor = const Color(0xFF396073);
var lightBlueBidderColor = const Color(0xFFF0FEFE);
var lightOrangeBidderColor = const Color(0xFFFFF1F1);
var lightRedColor = const Color(0xFFF9C7C6);
var buttonRedColor = const Color(0xFFC03830);
var geryTextColor = const Color(0xFF8B878A);
var darkBlueBidderColor = const Color(0xFF2447AF);
var blueContainerLight = const Color(0xFF3a6073);
var greenButtonColor = const Color(0xFF2AC54D);
var homePremiumGradientLight = HexColor.fromHex('#7CD78F');
var homePremiumGradientDark = HexColor.fromHex('#3BC458');
var bgWhiteMarketTrend = HexColor.fromHex('#F3F3F5');
var greenClr = HexColor.fromHex('#42CE81');
var redClr = HexColor.fromHex('#E45561');
var updatedDateColor = HexColor.fromHex('#4781FB');
var signInColor = HexColor.fromHex('#266BDC');
var forgotPasswordColor = HexColor.fromHex('#1C3957');
var signInBorderColor = HexColor.fromHex('#C3CCD3');
var appBarColor1 = HexColor.fromHex('#25398B');
var appBarColor2 = HexColor.fromHex('#2675EC');
var searchBarColor = HexColor.fromHex('#dee3eb');
var bgColor = HexColor.fromHex('#eceff4');
var appbarIconColor = HexColor.fromHex('#d8d8d8');
var appBarIconColor = HexColor.fromHex('#72818F');
var appBarTitleColor = HexColor.fromHex('#363839');
var homeBgColor = HexColor.fromHex('#F4F4F4');
var trendsBgColor = HexColor.fromHex('#EDF1F6');
var cardTitleColor = HexColor.fromHex('#72818F');
var redDownColor = HexColor.fromHex('#E70808');
var greenUpColor = HexColor.fromHex('#20DA5F');

var lightBlueChip = const Color(0xFFE3ECFF);
var darkBlueChip = const Color(0xFF2E59B1);

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
