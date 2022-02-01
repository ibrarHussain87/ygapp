class Utils{

  static double splitMin(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[0]);
  }

  static double splitMax(String? minMax) {
    var splitValue = minMax!.split('-');
    return double.parse(splitValue[1]);
  }

  static String checkNullString(bool prefix) {
    var debug = true;
    var value = '';
    if(debug){
      if(prefix){
        value = ',N/A';
      }else{
        value = 'N/A';
      }
    }
    return value;
  }


}