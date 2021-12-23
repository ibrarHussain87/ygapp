import 'dart:ui';

class AppColors{
  static var textColorBlue = HexColor.fromHex('#3BC458');
  static var textColorGrey = HexColor.fromHex('#5C5C7B');
  static var tileGreyClr = HexColor.fromHex('#DDF1FA');
  static var textColorGreyLight = HexColor.fromHex('#A1A8B3');
  static var strokeGrey = HexColor.fromHex('#E0E0E0');
  static var btnGreen = HexColor.fromHex('#2AC54D');
  static var textFieldLabel = const Color(0xFF3BC458);
  static var btnColorLogin = const Color(0xFF3BC458);
  static var lightBlueTabs = const Color(0xFF3BC458);
  static var pintFeatureClr = const Color(0xFFFC6A6D);
  static var tileSeaGreen = const Color(0xFFE6F2FE);
  static var appBarTextColor = const Color(0xFF3BC458);
  static var searchBarGreyStroke = const Color(0xFF939598);
  static var searchBarGreyText = const Color(0xFFE0E0E0);
  static var searchBarWhiteBg = const Color(0xFFF7F7F7);
  static var homePremiumGradientLight = HexColor.fromHex('#7CD78F');
  static var homePremiumGradientDark = HexColor.fromHex('#3BC458');
  static var bgWhiteMarketTrend = HexColor.fromHex('#F3F3F5');
  static var greenClr = HexColor.fromHex('#42CE81');
  static var redClr = HexColor.fromHex('#E45561');
  static var updatedDateColor = HexColor.fromHex('#4781FB');
}

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