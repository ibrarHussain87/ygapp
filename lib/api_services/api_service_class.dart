import 'dart:convert';
import 'package:yg_app/model/request/fiber_request.dart';
import 'package:yg_app/model/request/login_request/login_request.dart';
import 'package:yg_app/model/response/CreateResponse.dart';
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

  static Future<CreateResponse> multipartProdecudre(FiberRequestModel fiberRequestModel, String imagePath) async {

    //for multipartrequest
    var request = http.MultipartRequest('POST', Uri.parse(BASE_API_URL+_CREATE_FIBER_END_POINT));

    var userToken = SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);

    //for token
    request.headers.addAll({"Authorization": "Bearer $userToken","Accept": "application/json"});

    //for image and videos and files

    request.files.add(await http.MultipartFile.fromPath("fpc_picture[]", imagePath));
    request.fields.addAll(fiberRequestModel.toJson());

    //for completeing the request
    var response =await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    // final responseData = json.decode(responsed.body);

    return CreateResponse.fromJson(json.decode(responsed.body));

    // if (response.statusCode==200) {
    //   print("SUCCESS");
    //   print(responseData);
    // }
    // else {
    //   print("ERROR");
    // }
  }
}