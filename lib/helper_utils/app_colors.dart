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
var tileSeaGreen = const Color(0xFFE6F2FE);
var appBarTextColor = const Color(0xFF3BC458);
var searchBarGreyStroke = const Color(0xFF939598);
var searchBarGreyText = const Color(0xFFE0E0E0);
var searchBarWhiteBg = const Color(0xFFF7F7F7);
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
