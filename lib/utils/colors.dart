import 'dart:ui';

class AppColors{
  static var textColorBlue = HexColor.fromHex('#251685');
  static var textColorGrey = HexColor.fromHex('#5C5C7B');
  static var tileGreyClr = HexColor.fromHex('#F0F2F5');
  static var textColorGreyLight = HexColor.fromHex('#A1A8B3');
  static var textColorFBlue = HexColor.fromHex('#4B34DF');
  static var strokeGrey = HexColor.fromHex('#E0E0E0');
  static var btnGreen = HexColor.fromHex('#2AC54D');
  static var textFieldLabel = Color(0xFF251685);
  static var btnColorLogin = Color(0xFF4B34DF);
  static var lightBlueTabs = Color(0xFF1672EB);
  static var pintFeatureClr = Color(0xFFFC6A6D);
  static var tileSeaGreen = Color(0xFFE6F2FE);
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