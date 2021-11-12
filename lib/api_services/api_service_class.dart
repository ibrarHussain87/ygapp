import 'dart:convert';
import 'package:yg_app/model/request/login_request/login_request.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/utils/shared_pref_util.dart';
import 'package:yg_app/utils/strings.dart';
class ApiService {

  static Map<String, String> headerMap = {"Accept": "application/json"};
  static String BASE_API_URL = "http://yarnonline.net/dev/public/api";
  static const String _LOGIN_END_POINT = "/login";
  static const String _SYNC_FIBER_END_POINT = "/syncFiber";

  static Future<LoginResponse> login(
      LoginRequestModel requestModel) async {
    String url = BASE_API_URL + _LOGIN_END_POINT;
    final response = await http.post(
        Uri.parse(url),
        headers: headerMap, body: requestModel.toJson());
    return LoginResponse.fromJson(
      json.decode(response.body),
    );
  }

  static Future<SyncFiberResponse> SyncFiber() async{

    var userToken = SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    headerMap['Authorization'] = 'Bearer $userToken';

    String url = BASE_API_URL + _SYNC_FIBER_END_POINT;
    
    final response = await http.post(
      Uri.parse(url),
      headers:headerMap
    );
    
    return SyncFiberResponse.fromJson(
      json.decode(response.body),
    );
  }
}