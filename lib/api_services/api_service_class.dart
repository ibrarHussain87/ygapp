import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/request/login_request/login_request.dart';
import 'package:yg_app/model/request/post_ad_request/fiber_request.dart';
import 'package:yg_app/model/response/change_bid_response.dart';
import 'package:yg_app/model/response/create_specification_response.dart';
import 'package:yg_app/model/response/fiber_response/create_fiber_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/get_banner_response.dart';
import 'package:yg_app/model/response/list_bidder_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/utils/shared_pref_util.dart';
import 'package:yg_app/utils/strings.dart';

class ApiService {
  static Map<String, String> headerMap = {"Accept": "application/json"};
  static String BASE_API_URL = "http://yarnonline.net/dev/public/api";
  static const String LOGIN_END_POINT = "/login";
  static const String SYNC_FIBER_END_POINT = "/syncFiber";
  static const String SYNC_YARN_END_POINT = "/syncYarn";
  static const String GET_SPEC_END_POINT = "/getSpecifications";
  static const String CREATE_FIBER_END_POINT = "/createSpecification";
  static const String LIST_BIDDERS_END_POINT = "/listBidders";
  static const String CREATE_BID_END_POINT = "/createBid";
  static const String CHANGE_BID_STATUS_END_POINT = "/bidChangeStatus";
  static const String GET_BANNERS_END_POINT = "/getBanners";

  static Future<LoginResponse> login(LoginRequestModel requestModel) async {
    String url = BASE_API_URL + LOGIN_END_POINT;
    final response = await http.post(Uri.parse(url),
        headers: headerMap, body: requestModel.toJson());
    return LoginResponse.fromJson(
      json.decode(response.body),
    );
  }

  static Future<SyncFiberResponse> syncFiber() async {
    var userToken =
        SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    headerMap['Authorization'] = 'Bearer $userToken';

    String url = BASE_API_URL + SYNC_FIBER_END_POINT;

    final response = await http.post(Uri.parse(url), headers: headerMap);

    return SyncFiberResponse.fromJson(
      json.decode(response.body),
    );
  }

  static Future<FiberSpecificationResponse> getFiberSpecifications(
      GetSpecificationRequestModel getRequestModel, String? locality) async {
    String url = BASE_API_URL + GET_SPEC_END_POINT;

    var userToken =
    await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    var userID =
    await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_ID_KEY);
    headerMap['Authorization'] = 'Bearer $userToken';
    getRequestModel.userId = userID;
    getRequestModel.locality = locality;
    final response = await Dio().post(url,
        options: Options(headers: headerMap),
        data: json.encode(getRequestModel.toJson()));
    return FiberSpecificationResponse.fromJson(response.data);
  }

  static Future<YarnSyncResponse> syncYarn() async {
    var userToken =
    SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    headerMap['Authorization'] = 'Bearer $userToken';

    String url = BASE_API_URL + SYNC_YARN_END_POINT;

    final response = await http.post(Uri.parse(url), headers: headerMap);

    return YarnSyncResponse.fromJson(
      json.decode(response.body),
    );
  }

  static Future<GetYarnSpecificationResponse> getYarnSpecifications(
      GetSpecificationRequestModel getRequestModel, String? locality) async {
    String url = BASE_API_URL + GET_SPEC_END_POINT;

    var userToken =
    await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    var userID =
    await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_ID_KEY);
    headerMap['Authorization'] = 'Bearer $userToken';
    getRequestModel.userId = userID;
    getRequestModel.locality = locality;
    final response = await Dio().post(url,
        options: Options(headers: headerMap),
        data: json.encode(getRequestModel.toJson()));
    return GetYarnSpecificationResponse.fromJson(response.data);
  }

  static Future<CreateFiberResponse> createSpecification(
      CreateRequestModel createRequestModel, String imagePath) async {
    //for multipartrequest
    var request = http.MultipartRequest(
        'POST', Uri.parse(BASE_API_URL + CREATE_FIBER_END_POINT));
    var userToken =
        await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    request.headers.addAll(
        {"Accept": "application/json", "Authorization": "Bearer $userToken"});

    if(imagePath.isNotEmpty) {
      request.files
          .add(await http.MultipartFile.fromPath("fpc_picture[]", imagePath));
    }
    request.fields.addAll(createRequestModel.toJson());
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    return CreateFiberResponse.fromJson(json.decode(responsed.body));
  }

  static Future<ListBiddersResponse> getListBidders(
      String catId, String specId) async {
    String url = BASE_API_URL + LIST_BIDDERS_END_POINT;

    var userToken =
        await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    var userID =
        await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_ID_KEY);
    Map<String, dynamic> data = {
      "category_id": catId,
      "user_id": userID.toString(),
      "specification_id": specId
    };
    headerMap['Authorization'] = 'Bearer $userToken';
    final response =
        await http.post(Uri.parse(url), headers: headerMap, body: data);

    return ListBiddersResponse.fromJson(
      json.decode(response.body),
    );
  }

  static Future<CreateBidResponse> createBid(String catId, String specId,
      String price, String quantity, String remarks) async {
    String url = BASE_API_URL + CREATE_BID_END_POINT;

    var userToken =
        await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    var userID =
        await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_ID_KEY);
    Map<String, dynamic> data = {
      "bid_category_idfk": catId,
      "bid_user_idfk": userID.toString(),
      "bid_specification_idfk": specId,
      "bid_price": price,
      "bid_quantity": quantity,
      "bid_remarks": remarks
    };
    headerMap['Authorization'] = 'Bearer $userToken';
    final response =
        await http.post(Uri.parse(url), headers: headerMap, body: data);

    return CreateBidResponse.fromJson(
      json.decode(response.body),
    );
  }

  static Future<ChangeBidResponse> bidChangeStatus(
      int bidId, int status) async {
    String url = BASE_API_URL + CHANGE_BID_STATUS_END_POINT;

    var userToken =
        await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    Map<String, dynamic> data = {
      "bid_id": bidId.toString(),
      "bid_status": status.toString(),
    };
    headerMap['Authorization'] = 'Bearer $userToken';
    final response =
        await http.post(Uri.parse(url), headers: headerMap, body: data);

    return ChangeBidResponse.fromJson(json.decode(response.body));
  }

  static Future<GetBannersResponse> getBanners() async {

    String url = BASE_API_URL + GET_BANNERS_END_POINT;

    var userToken =
    await SharedPreferenceUtil.getStringValuesSF(AppStrings.USER_TOKEN_KEY);
    headerMap['Authorization'] = 'Bearer $userToken';
    final response =
    await http.post(Uri.parse(url), headers: headerMap);

    return GetBannersResponse.fromJson(json.decode(response.body));
  }
}
