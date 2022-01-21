class StringUtils{

  static bool disableClick = false;

  static double splitMin(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[0]);
  }

  static double splitMax(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[1]);
  }
}