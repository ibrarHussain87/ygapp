import 'dart:convert';
import 'package:yg_app/model/request/fiber_request.dart';
import 'package:yg_app/model/request/login_request/login_request.dart';
import 'package:yg_app/model/response/fiber_response/create_fiber_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:yg_app/utils/shared_pref_util.dart';
import 'package:yg_app/utils/strings.dart';
class ApiService {

  static Map<String, String> headerMap = {"Accept": "application/json"};
  static String BASE_API_URL = "http://yarnonline.net/dev/public/api";
  static const String _LOGIN_END_POINT = "/login";
  static const String _SYNC_FIBER_END_POINT = "/syncFiber";
  static const String _GET_FIBER_SPEC_END_POINT = "/getFiberSpecifications";
  static const String _CREATE_FIBER_END_POINT = "/createFiberSpecification";

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
  static Future<FiberSpecificationResponse> getFiberSpecifications() async{

    var userToken = await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    var userID = await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_ID_KEY);
    headerMap['Authorization'] = 'Bearer $userToken';

    String url = BASE_API_URL + _GET_FIBER_SPEC_END_POINT;

    Map<String, dynamic> data = {"user_id": userID.toString()};

    final response = await http.post(
      Uri.parse(url),
      headers:headerMap,
      body: data
    );

    return FiberSpecificationResponse.fromJson(
      json.decode(response.body),
    );
  }

  static Future<CreateFiberResponse> multipartProdecudre(FiberRequestModel fiberRequestModel, String imagePath) async {
    //for multipartrequest
    var request = http.MultipartRequest('POST', Uri.parse(BASE_API_URL+_CREATE_FIBER_END_POINT));
    var userToken = await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    request.headers.addAll({"Accept": "application/json","Authorization": "Bearer $userToken"});
    request.files.add(await http.MultipartFile.fromPath("fpc_picture[]", imagePath));
    var userID = await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_ID_KEY);
    fiberRequestModel.spc_user_idfk = userID.toString();
    fiberRequestModel.spc_production_year = "${fiberRequestModel.spc_production_year}-1-1";
    request.fields.addAll(fiberRequestModel.toJson());
    var response =await request.send();
    var responsed = await http.Response.fromStream(response);
    return CreateFiberResponse.fromJson(json.decode(responsed.body));

  }
}