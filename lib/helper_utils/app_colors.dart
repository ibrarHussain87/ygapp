import 'dart:ui';

var textColorBlue = HexColor.fromHex('#3BC458');
var textColorGrey = HexColor.fromHex('#5C5C7B');
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
var homePremiumGradientLight = HexColor.fromHex('#7CD78F');
var homePremiumGradientDark = HexColor.fromHex('#3BC458');
var bgWhiteMarketTrend = HexColor.fromHex('#F3F3F5');
var greenClr = HexColor.fromHex('#42CE81');
var redClr = HexColor.fromHex('#E45561');
var updatedDateColor = HexColor.fromHex('#4781FB');

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
