import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/request/filter_request/fiber_filter_request.dart';
import 'package:yg_app/model/request/login_request/login_request.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/response/change_bid_response.dart';
import 'package:yg_app/model/response/create_specification_response.dart';
import 'package:yg_app/model/response/fiber_response/create_fiber_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/get_banner_response.dart';
import 'package:yg_app/model/response/list_bidder_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/model/response/my_products_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

class ApiService {

  static var logger = Logger();
  static Map<String, String> headerMap = {"Accept": "application/json"};
  static String BASE_URL = "http://yarnonline.net/dev/public/";
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
    try {
      String url = BASE_API_URL + LOGIN_END_POINT;
      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: requestModel.toJson());
      return LoginResponse.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<SyncFiberResponse> syncFiber() async {
    try {
      var userToken = SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';

      String url = BASE_API_URL + SYNC_FIBER_END_POINT;

      final response = await http.post(Uri.parse(url), headers: headerMap);

      return SyncFiberResponse.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<FiberSpecificationResponse> getFiberSpecifications(
      GetSpecificationRequestModel getRequestModel, String? locality) async {
    try {
      String url = BASE_API_URL + GET_SPEC_END_POINT;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      getRequestModel.userId = userID;
      getRequestModel.locality = locality;
      final response = await Dio().post(url,
          options: Options(headers: headerMap),
          data: json.encode(getRequestModel.toJson()));
      logger.e(response.data);
      return FiberSpecificationResponse.fromJson(response.data);
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<YarnSyncResponse> syncYarn() async {
    try {
      var userToken = SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';

      String url = BASE_API_URL + SYNC_YARN_END_POINT;

      final response = await http.post(Uri.parse(url), headers: headerMap);

      return YarnSyncResponse.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<GetYarnSpecificationResponse> getYarnSpecifications(
      GetSpecificationRequestModel getRequestModel, String? locality) async {
    try {
      String url = BASE_API_URL + GET_SPEC_END_POINT;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      getRequestModel.userId = userID;
      getRequestModel.locality = locality;

      logger.e(getRequestModel.toJson());

      final response = await Dio().post(url,
          options: Options(headers: headerMap),
          data: json.encode(getRequestModel.toJson()));


      return GetYarnSpecificationResponse.fromJson(response.data);

    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<CreateFiberResponse> createSpecification(
      CreateRequestModel createRequestModel, String imagePath) async {
    //for multipart Request
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(BASE_API_URL + CREATE_FIBER_END_POINT));
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userId =
      await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      request.headers.addAll(
          {"Accept": "application/json", "Authorization": "Bearer $userToken"});
      if (imagePath.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath("fpc_picture[]", imagePath));
      }
      createRequestModel.spc_user_idfk = userId.toString();
      request.fields.addAll(createRequestModel.toJson());
      logger.e(createRequestModel.toJson());
      var response = await request.send();
      var responsed = await http.Response.fromStream(response);
      logger.e(json.decode(responsed.body));

      return CreateFiberResponse.fromJson(json.decode(responsed.body));
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<ListBiddersResponse> getListBidders(
      String catId, String specId) async {
    try {
      String url = BASE_API_URL + LIST_BIDDERS_END_POINT;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
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
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<CreateBidResponse> createBid(String catId, String specId,
      String price, String quantity, String remarks) async {
    try {
      String url = BASE_API_URL + CREATE_BID_END_POINT;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
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
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<ChangeBidResponse> bidChangeStatus(
      int bidId, int status) async {
    try {
      String url = BASE_API_URL + CHANGE_BID_STATUS_END_POINT;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);

      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);

      headerMap['device_token'] = '$userDeviceToken';

      Map<String, dynamic> data = {
        "bid_id": bidId.toString(),
        "bid_status": status.toString(),
      };
      headerMap['Authorization'] = 'Bearer $userToken';
      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return ChangeBidResponse.fromJson(json.decode(response.body));
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<ChangeBidResponse> bidChangeStatusBids(
      int bidId, int status, String specId) async {
    String url = BASE_API_URL + CHANGE_BID_STATUS_END_POINT;

    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);

      var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);

      Map<String, dynamic> data = {
        "bid_id": bidId.toString(),
        "bid_specification_idfk": specId.toString(),
        "bid_status": status.toString(),
      };
      headerMap['Authorization'] = 'Bearer $userToken';

      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);

      headerMap['device_token'] = '$userDeviceToken';
      headerMap['user_id'] = userId.toString();

      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return ChangeBidResponse.fromJson(json.decode(response.body));
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<GetBannersResponse> getBanners() async {
    try {
      String url = BASE_API_URL + GET_BANNERS_END_POINT;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      final response = await http.post(Uri.parse(url), headers: headerMap);

      return GetBannersResponse.fromJson(json.decode(response.body));
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<MyProductsResponse> myProducts() async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);

      headerMap['Authorization'] = 'Bearer $userToken';

      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      Map<String, dynamic> data = {"user_id": userID.toString()};
      String url = BASE_API_URL + "/myAds";

      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return MyProductsResponse.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }

  static Future<ListBiddersResponse> getListBids() async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      Map<String, dynamic> data = {"user_id": userID.toString()};
      String url = BASE_API_URL + "/listBids";

      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return ListBiddersResponse.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      if (e is SocketException) {
        throw (no_internet_available_msg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong");
      }
    }
  }
}



