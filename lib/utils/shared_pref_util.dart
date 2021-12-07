import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static addStringToSF(String key, String value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  static addIntToSF(String key, int value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  static addDoubleToSF(String key, double value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setDouble(key, value);
  }

  static addBoolToSF(String key, bool value) async {
    SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }


  static getStringValuesSF(String key) async {
    SharedPreferences prefs = await _prefs;
    //Return String
    String? stringValue = prefs.getString(key);
    return stringValue;
  }

  static getIntValuesSF(String key) async {
    SharedPreferences prefs = await _prefs;
    //Return int
    int? intValue = prefs.getInt(key);
    return intValue;
  }

  static getDoubleValuesSF(String key) async {
    SharedPreferences prefs = await _prefs;
    //Return double
    double? doubleValue = prefs.getDouble(key);
    return doubleValue;
  }

  static getBoolValuesSF(String key) async {
    SharedPreferences prefs = await _prefs;
    //Return bool
    bool? boolValue = prefs.getBool(key);
    return boolValue??false;
  }
}