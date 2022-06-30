import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/matched_response.dart';
import 'package:yg_app/model/request/filter_request/filter_request.dart';
import 'package:yg_app/model/request/login_request/login_request.dart';
import 'package:yg_app/model/request/post_ad_request/create_request_model.dart';
import 'package:yg_app/model/request/post_fabric_request/create_fabric_request_model.dart';
import 'package:yg_app/model/request/signup_request/signup_request.dart';
import 'package:yg_app/model/request/specification_user/spec_user_request.dart';
import 'package:yg_app/model/request/stocklot_request/get_stock_lot_spec_request.dart';
import 'package:yg_app/model/request/sync_request/sync_request.dart';
import 'package:yg_app/model/request/update_fabric_request/update_fabric_request.dart';
import 'package:yg_app/model/request/update_profile/update_membership_plan_request.dart';
import 'package:yg_app/model/request/update_profile/update_profile_request.dart';
import 'package:yg_app/model/response/change_bid_response.dart';
import 'package:yg_app/model/response/create_bid_response.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/fiber_response/create_fiber_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/get_banner_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/model/response/my_products_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/model/response/yg_services/my_yg_services_response.dart';

import '../model/pre_login_response.dart';
import '../model/request/filter_request/fabric_filter_request.dart';
import '../model/request/stocklot_request/stocklot_request.dart';
import '../model/request/update_profile/brands_request_model.dart';
import '../model/request/update_profile/customer_support_request.dart';
import '../model/request/update_profile/update_business_request.dart';
import '../model/request/yg_service/yg_service_request_model.dart';
import '../model/response/common_response_models/companies_reponse.dart';
import '../model/response/common_response_models/countries_response.dart';
import '../model/response/common_response_models/pre_config_model.dart';
import '../model/response/create_stocklot_response.dart';
import '../model/response/fabric_response/fabric_update_response.dart';
import '../model/response/fabric_response/sync/fabric_sync_response.dart';
import '../model/response/list_bid_response.dart';
import '../model/response/mark_yg_response.dart';
import '../model/response/spec_user_response.dart';
import '../model/response/yg_service_response.dart';

class ApiService {
  var logger = Logger();
  Map<String, String> headerMap = {"Accept": "application/json"};
  String baseUrlApi = "http://stagingv2.yarnguru.net/api";
  String loginEndPoint = "/login";
  String signUpEndPoint = "/register";
  String uploadProfilePicEndPoint = "/upload-user-profile-pic";
  String profileUpdateEndPoint = "/update-personal-info";
  String businessUpdateEndPoint = "/update-business-info";
  String brandsUpdateEndPoint = "/update-brands";
  String brandsDeleteEndPoint = "/delete-brands";
  String specUserEndPoint = "/spec_user";
  String syncEndPoint = "/sync";
  String getSpecEndPoint = "/getSpecifications";
  String createSpecEndPoint = "/createSpecification";
  String updateSpecEndPint = "/update-specification";
  String listBiddersEndPoint = "/listBidders";
  String getMatchedEndPoint = "/getMatched";
  String createBidEndPoint = "/createBid";
  String changeBidStatusEndPoint = "/bidChangeStatus";
  String getBannersEndPoint = "/getBanners";
  String updateSpec = "/update-specification";
  String companiesEndPoint = "/company";
  String preLoginSync = "/get-pre-login-sync";
  String preConfigSync = "/get-pre-login-config";

  String createYgService = "/create-yg-service";
  String myYgServicesEndPoint = "/my-yg-service";
  String createCustomerServicePoint = "/create-customer-support";
  String subscribeToPlanEndPoint = "/subscribe-to-plan";
  String uploadUserProfilePic = "/upload-user-profile-pic";

  Future<PreConfigResponse> preConfig(String countryID) async {
    try {
      var params = {
        'country_id': countryID,
      };
      String url = baseUrlApi + preConfigSync;
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: params);
      return PreConfigResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<AuthResponse> login(LoginRequestModel requestModel) async {
    try {
      String url = baseUrlApi + loginEndPoint;
      // final response = await http.post(Uri.parse(url),
      //     headers: headerMap, body: requestModel.toJson());
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      final response = await Dio().post(url,
          options: Options(headers: headerMap),
          data: json.encode(requestModel.toJson()));

      return AuthResponse.fromJson(
        response.data,
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<AuthResponse> signup(SignUpRequestModel requestModel) async {
    try {
      String url = baseUrlApi + signUpEndPoint;
      // final response = await http.post(Uri.parse(url),
      //     headers: headerMap, body: requestModel.toJson());
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      final response = await Dio().post(url,
          options: Options(headers: headerMap),
          data: json.encode(requestModel.toJson()));

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else if (e is dio.DioError) {
        throw (e.message.toString());
      } else {
        throw Exception(e.toString());
      }
    }
  }

  Future<UpdateProfileResponse> subscribeToPlan(
      MembershipRequestModel requestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      String url = baseUrlApi + subscribeToPlanEndPoint;

      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: requestModel.toJson());
      return UpdateProfileResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<YGServiceResponse> createCustomerService(
      CustomerSupportRequestModel requestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      String url = baseUrlApi + createCustomerServicePoint;
      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: requestModel.toJson());
      return YGServiceResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<YGServiceResponse> createYGService(
      YGServiceRequestModel requestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      String url = baseUrlApi + createYgService;
      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: requestModel.toJson());
      return YGServiceResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<MyYgServicesResponse> myYgServices() async {
    try {
      String url = baseUrlApi + myYgServicesEndPoint;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      // var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      // logger.e(getRequestModel.toJson());
      final response = await Dio().post(
        url,
        options: Options(headers: headerMap),
        // data: json.encode(getRequestModel.toJson())
      );
      logger.e(response.data);
      return MyYgServicesResponse.fromJson(response.data);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else if (e is dio.DioError) {
        throw (e.message.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  // Future<UpdateProfileResponse?> uploadProfilePicture(String imagePath) async {
  //   // //for multipart Request
  //   try {
  //     var userToken =
  //     await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
  //     var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
  //     try {
  //       ///[1] CREATING INSTANCE
  //       var dioRequest = dio.Dio();
  //       dioRequest.options.baseUrl = baseUrlApi;
  //       var userDeviceToken =
  //       await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
  //       //[2] ADDING TOKEN
  //       dioRequest.options.headers = {
  //         "Accept": "application/json",
  //         "Authorization": "Bearer $userToken",
  //         'device_token': '$userDeviceToken'
  //       };
  //       // Logger().e(stocklotRequestModel.toJson().toString());
  //       //[3] ADDING EXTRA INFO
  //       // var formData = dio.FormData.fromMap(stocklotRequestModel.toJson());
  //
  //
  //       //[4] ADD IMAGE TO UPLOAD
  //       if (imagePath != "") {
  //         //[4] ADD IMAGE TO UPLOAD
  //         var file = await dio.MultipartFile.fromFile(
  //           imagePath,
  //           filename: imagePath.split("/").last,
  //         );
  //         // formData.files.add(MapEntry('profile_pic', file));
  //         // formData.files.add(MapEntry('profile_pic[]', file));
  //       }
  //
  //       //[5] SEND TO SERVER
  //       var response = await dioRequest.post(
  //         uploadProfilePicEndPoint,
  //         data: formData,
  //       );
  //       final result = json.decode(response.toString());
  //       return UpdateProfileResponse.fromJson(result);
  //     } catch (err) {
  //       throw (err.toString());
  //     }
  //   } on Exception catch (e) {
  //     if (e is SocketException) {
  //       throw (noInternetAvailableMsg);
  //     } else if (e is TimeoutException) {
  //       throw (e.toString());
  //     } else if (e is dio.DioError) {
  //       throw (e.message.toString());
  //     } else {
  //       throw (e.toString());
  //     }
  //   } catch (err) {
  //     throw (err.toString());
  //   }
  // }

  Future<UpdateProfileResponse> updateProfile(
      UpdateProfileRequestModel requestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      String url = baseUrlApi + profileUpdateEndPoint;
      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: requestModel.toJson());
      return UpdateProfileResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<UpdateProfileResponse> updateBusinessInfo(
      UpdateBusinessRequestModel requestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      String url = baseUrlApi + businessUpdateEndPoint;

      final response = await Dio().post(url,
          options: Options(headers: headerMap),
          data: json.encode(requestModel.toJson()));

      // final response = await http.post(Uri.parse(url),
      //     headers: headerMap, body: requestModel.toJson());
      return UpdateProfileResponse.fromJson(response.data);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else if (e is dio.DioError) {
        throw (e.message.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<UpdateProfileResponse> updateBrands(
      BrandsRequestModel requestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      String url = baseUrlApi + brandsUpdateEndPoint;
      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: requestModel.toJson());
      return UpdateProfileResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<UpdateProfileResponse> deleteBrands(int brdID) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      Map<String, dynamic> data = {
        "user_id": userID.toString(),
        "brand_id": brdID.toString(),
      };
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      String url = baseUrlApi + brandsDeleteEndPoint;
      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);
      return UpdateProfileResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<SpecificationUserResponse> getSpecificationUser(
      SpecificationRequestModel requestModel) async {
    try {
      String url = baseUrlApi + specUserEndPoint;
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: requestModel.toJson());
      return SpecificationUserResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<SyncFiberResponse> syncFiber(SyncRequestModel syncRequestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);

      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      String url = baseUrlApi + syncEndPoint;

      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: syncRequestModel.toJson());

      return SyncFiberResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<FiberSpecificationResponse> getFiberSpecifications(
      GetSpecificationRequestModel getRequestModel, String? locality) async {
    try {
      String url = baseUrlApi + getSpecEndPoint;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      // var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      // getRequestModel.userId = userID;
      getRequestModel.locality = locality;
      logger.e(getRequestModel.toJson());
      final response = await Dio().post(url,
          options: Options(headers: headerMap),
          data: json.encode(getRequestModel.toJson()));
      logger.e(response.data);
      return FiberSpecificationResponse.fromJson(response.data);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else if (e is dio.DioError) {
        throw (e.message.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<YarnSyncResponse> syncYarn(SyncRequestModel syncRequestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      String url = baseUrlApi + syncEndPoint;

      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: syncRequestModel.toJson());

      return YarnSyncResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<StockLotSyncResponse> syncCall(SyncRequestModel requestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      String url = baseUrlApi + syncEndPoint;

      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: requestModel.toJson());

      return StockLotSyncResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<FabricSyncResponse> syncFabricCall(
      SyncRequestModel requestModel) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      String url = baseUrlApi + syncEndPoint;

      final response = await http.post(Uri.parse(url),
          headers: headerMap, body: requestModel.toJson());

      return FabricSyncResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<GetYarnSpecificationResponse> getYarnSpecifications(
      GetSpecificationRequestModel getRequestModel, String? locality) async {
    try {
      String url = baseUrlApi + getSpecEndPoint;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      // var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['Authorization'] = 'Bearer $userToken';
      // getRequestModel.userId = userID;
      getRequestModel.locality = locality;

      logger.e(json.encode(getRequestModel.toJson()));

      final response = await Dio().post(url,
          options: Options(headers: headerMap),
          data: json.encode(getRequestModel.toJson()));

      return GetYarnSpecificationResponse.fromJson(response.data);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<FabricSpecificationResponse> getFabricSpecifications(
      FabricSpecificationRequestModel getRequestModel, String? locality) async {
    try {
      String url = baseUrlApi + getSpecEndPoint;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      // var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      // getRequestModel.user_id = userID;
      getRequestModel.locality = locality;

      logger.e(getRequestModel.toJson().toString());

      final response = await Dio().post(url,
          options: Options(headers: headerMap),
          data: json.encode(getRequestModel.toJson()));
      logger.e(response.data.toString());
      return FabricSpecificationResponse.fromJson(response.data);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else if (e is dio.DioError) {
        throw (e.message.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<CreateFiberResponse> createSpecification(
      CreateRequestModel createRequestModel, String imagePath) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);

      if (createRequestModel.spc_category_idfk == "1") {
        createRequestModel.spc_user_idfk = userId.toString();
      } else {
        createRequestModel.ys_user_idfk = userId.toString();
        var dbInstance = await AppDbInstance().getDbInstance();
        var userDetail = await dbInstance.userDao.getUser();
        createRequestModel.ys_origin_idfk = userDetail!.countryId.toString();
      }
      try {
        ///[1] CREATING INSTANCE
        var dioRequest = dio.Dio();
        dioRequest.options.baseUrl = baseUrlApi;
        var userDeviceToken =
            await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
        //[2] ADDING TOKEN
        dioRequest.options.headers = {
          "Accept": "application/json",
          "Authorization": "Bearer $userToken",
          "device_token": "$userDeviceToken"
        };

        //[3] ADDING EXTRA INFO
        var formData = dio.FormData.fromMap(createRequestModel.toJson());

        if (imagePath != "") {
          //[4] ADD IMAGE TO UPLOAD
          var file = await dio.MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split("/").last,
          );
          formData.files.add(MapEntry('fpc_picture[]', file));
        }

        logger.e(createRequestModel.toJson());

        //[5] SEND TO SERVER
        var response = await dioRequest.post(
          createSpecEndPoint,
          data: formData,
        );
        final result = json.decode(response.toString());
        return CreateFiberResponse.fromJson(result);
      } on Exception catch (e) {
        if (e is SocketException) {
          throw (noInternetAvailableMsg);
        } else if (e is TimeoutException) {
          throw (e.toString());
        } else if (e is dio.DioError) {
          throw (e.message.toString());
        } else {
          throw (e.toString());
        }
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<CreateFiberResponse> createFabricSpecification(
      FabricCreateRequestModel createRequestModel, String imagePath) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      createRequestModel.fs_user_idfk = userId.toString();
      var dbInstance = await AppDbInstance().getDbInstance();
      var userDetail = await dbInstance.userDao.getUser();
      createRequestModel.fs_origin_idfk = userDetail!.countryId.toString();

      try {
        ///[1] CREATING INSTANCE
        var dioRequest = dio.Dio();
        dioRequest.options.baseUrl = baseUrlApi;
        var userDeviceToken =
            await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
        //[2] ADDING TOKEN
        dioRequest.options.headers = {
          "Accept": "application/json",
          "Authorization": "Bearer $userToken",
          'device_token': '$userDeviceToken'
        };

        //[3] ADDING EXTRA INFO
        var formData = dio.FormData.fromMap(createRequestModel.toJson());

        if (imagePath != "") {
          //[4] ADD IMAGE TO UPLOAD
          var file = await dio.MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split("/").last,
          );
          formData.files.add(MapEntry('fpc_picture[]', file));
        }

        logger.e(createRequestModel.toJson());

        //[5] SEND TO SERVER
        var response = await dioRequest.post(
          createSpecEndPoint,
          data: formData,
        );
        final result = json.decode(response.toString());
        return CreateFiberResponse.fromJson(result);
      } catch (err) {
        throw (err.toString());
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else if (e is dio.DioError) {
        throw (e.message.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }

    //for multipart Request
    // try {
    //   var request = http.MultipartRequest(
    //       'POST', Uri.parse(BASE_API_URL + CREATE_END_POINT));
    //   var userToken =
    //       await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
    //   var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
    //   request.headers.addAll(
    //       {"Accept": "application/json", "Authorization": "Bearer $userToken"});
    //   if (imagePath.isNotEmpty) {
    //     request.files
    //         .add(await http.MultipartFile.fromPath("fpc_picture[]", imagePath));
    //   }
    //   createRequestModel.fs_user_idfk = userId.toString();
    //   request.fields.addAll(createRequestModel.toJson());
    //   logger.e(createRequestModel.toJson());
    //   var response = await request.send();
    //   var responsed = await http.Response.fromStream(response);
    //   logger.e(json.decode(responsed.body));
    //
    //   return CreateFiberResponse.fromJson(json.decode(responsed.body));
    // } catch (e) {
    //   if (e is SocketException) {
    //     throw (no_internet_available_msg);
    //   } else if (e is TimeoutException) {
    //     throw (e.toString());
    //   } else {
    //     throw ("Something went wrong");
    //   }
    // }
  }

  Future<SpecificationUpdateResponse> updateSpecification(
      UpdateRequestModel updateFabricRequestModel, String imagePath) async {
    //for multipart Request
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse(baseUrlApi + updateSpecEndPint));
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      // var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      request.headers.addAll({
        "Accept": "application/json",
        "Authorization": "Bearer $userToken",
        'device_token': '$userDeviceToken'
      });
      if (imagePath.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath("fpc_picture[]", imagePath));
      }
      //createRequestModel.fs_user_idfk = userId.toString();
      request.fields.addAll(updateFabricRequestModel.toJson());
      logger.e(updateFabricRequestModel.toJson());
      var response = await request.send();
      var responsed = await http.Response.fromStream(response);
      logger.e(json.decode(responsed.body));

      return SpecificationUpdateResponse.fromJson(json.decode(responsed.body));
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<CreateStockLotResponse?> createStockLot(
      StocklotRequestModel stocklotRequestModel, String imagePath) async {
    // //for multipart Request
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userId = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      stocklotRequestModel.user_id = userId.toString();
      try {
        ///[1] CREATING INSTANCE
        var dioRequest = dio.Dio();
        dioRequest.options.baseUrl = baseUrlApi;
        var userDeviceToken =
            await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
        //[2] ADDING TOKEN
        dioRequest.options.headers = {
          "Accept": "application/json",
          "Authorization": "Bearer $userToken",
          'device_token': '$userDeviceToken'
        };
        Logger().e(stocklotRequestModel.toJson().toString());
        //[3] ADDING EXTRA INFO
        var formData = dio.FormData.fromMap(stocklotRequestModel.toJson());

        //[4] ADD IMAGE TO UPLOAD
        if (imagePath != "") {
          //[4] ADD IMAGE TO UPLOAD
          var file = await dio.MultipartFile.fromFile(
            imagePath,
            filename: imagePath.split("/").last,
          );
          formData.files.add(MapEntry('fpc_picture[]', file));
        }

        //[5] SEND TO SERVER
        var response = await dioRequest.post(
          createSpecEndPoint,
          data: formData,
        );
        final result = json.decode(response.toString());
        return CreateStockLotResponse.fromJson(result);
      } catch (err) {
        throw (err.toString());
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else if (e is dio.DioError) {
        throw (e.message.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<StockLotSpecificationResponse> getStockLotSpecifications(
      GetStockLotSpecRequestModel getRequestModel) async {
    try {
      String url = baseUrlApi + getSpecEndPoint;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      // var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      // getRequestModel.spcUserIdfk = userID;
      logger.e(getRequestModel.toJson());
      final response = await Dio().post(url,
          options: Options(headers: headerMap),
          data: json.encode(getRequestModel.toJson()));
      logger.e(response.data);
      return StockLotSpecificationResponse.fromJson(response.data);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else if (e is dio.DioError) {
        throw (e.message.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<ListBidResponse> getListBidders(String catId, String specId) async {
    try {
      String url = baseUrlApi + listBiddersEndPoint;
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
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
      logger.e(data.toString());
      return ListBidResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<MatchedResponse> getMatched(String catId, String specId) async {
    try {
      String url = baseUrlApi + getMatchedEndPoint;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      // var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      Map<String, dynamic> data = {
        "category_id": catId,
        // "user_id": userID.toString(),
        "spec_id": specId
      };
      headerMap['Authorization'] = 'Bearer $userToken';
      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return MatchedResponse.fromJson(json.decode(response.body));
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<CreateBidResponse> createBid(String catId, String specId, String price,
      String quantity, String remarks) async {
    try {
      String url = baseUrlApi + createBidEndPoint;

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
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      headerMap['user_id'] = '$userID';

      Logger().e(data.toString());
      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return CreateBidResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<ChangeBidResponse> bidChangeStatus(int bidId, int status) async {
    try {
      String url = baseUrlApi + changeBidStatusEndPoint;

      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      headerMap['user_id'] = '$userID';
      headerMap['device_token'] = '$userDeviceToken';

      Map<String, dynamic> data = {
        "bid_id": bidId.toString(),
        "bid_status": status.toString(),
      };
      headerMap['Authorization'] = 'Bearer $userToken';
      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return ChangeBidResponse.fromJson(json.decode(response.body));
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<ChangeBidResponse> bidChangeStatusBids(
      int bidId, int status, String specId) async {
    String url = baseUrlApi + changeBidStatusEndPoint;

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
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<GetBannersResponse> getBanners() async {
    try {
      String url = baseUrlApi + getBannersEndPoint;
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      final response = await http.post(Uri.parse(url), headers: headerMap);

      return GetBannersResponse.fromJson(json.decode(response.body));
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<MyProductsResponse> myProducts() async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);

      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      Map<String, dynamic> data = {"user_id": userID.toString()};
      String url = baseUrlApi + "/myAds";

      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return MyProductsResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<ListBidResponse> getListBids() async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      Map<String, dynamic> data = {"user_id": userID.toString()};
      String url = baseUrlApi + "/listBids";

      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return ListBidResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<ListBidResponse> getBidsHistory(String specId, String catId) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      Map<String, dynamic> data = {
        "user_id": userID.toString(),
        "specification_id": specId,
        "category_id": catId
      };
      String url = baseUrlApi + "/listBids";

      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return ListBidResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  Future<MarkYgResponse> markYg(String specId, String catId) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      Map<String, dynamic> data = {
        "user_id": userID.toString(),
        "specification_id": specId,
        "category_id": catId
      };
      String url = baseUrlApi + "/mark_yg";

      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      return MarkYgResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  //Post as requirement
  Future<dynamic> copySpecification(String specId, String catId) async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
      Map<String, dynamic> data = {
        "user_id": userID.toString(),
        "specification_id": specId,
        "category_id": catId
      };
      String url = baseUrlApi + "/copy_spec";

      final response =
          await http.post(Uri.parse(url), headers: headerMap, body: data);

      if (catId == "1") {
        return FiberSpecificationResponse.fromJson(
          json.decode(response.body),
        );
      } else if (catId == '2') {
        return GetYarnSpecificationResponse.fromJson(
          json.decode(response.body),
        );
      }else if(catId == '3'){
        return FabricSpecificationResponse.fromJson(
          json.decode(response.body),
        );
      } else {
        return StockLotSpecificationResponse.fromJson(
          json.decode(response.body),
        );
      }
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

// Countries Api
  Future<CountriesSyncResponse> syncCountriesCall() async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      String url = baseUrlApi + preLoginSync;

//      final response = await http.post(Uri.parse(url),
//          headers: headerMap, body: requestModel.toJson());

      final response = await http.post(Uri.parse(url), headers: headerMap);
      Logger()
          .e("Countries Sync got successfully : " + response.body.toString());
      return CountriesSyncResponse.fromJson(
        json.decode(response.body),
      );
    } catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw ("Something went wrong" + e.toString());
      }
    }
  }

// Coompanies Api
  Future<CompaniesSyncResponse> syncCompaniesCall() async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      String url = baseUrlApi + companiesEndPoint;

//      final response = await http.post(Uri.parse(url),
//          headers: headerMap, body: requestModel.toJson());

      final response = await http.get(Uri.parse(url), headers: headerMap);

      return CompaniesSyncResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  // Pre login sync call
  Future<PreLoginResponse> preLoginSyncCall() async {
    try {
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      headerMap['Authorization'] = 'Bearer $userToken';
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      headerMap['device_token'] = '$userDeviceToken';
      String url = baseUrlApi + preLoginSync;

      final response = await http.post(Uri.parse(url), headers: headerMap);

      return PreLoginResponse.fromJson(
        json.decode(response.body),
      );
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

  //UPLOAD USER PROFILE PIC

  Future<AuthResponse> uploadProfilePic(String imagePath) async {
    try {
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = baseUrlApi;
      var userDeviceToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_DEVICE_TOKEN_KEY);
      var userToken =
          await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $userToken",
        "device_token": "$userDeviceToken"
      };
      //[4] ADD IMAGE TO UPLOAD
      var file = await dio.MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split("/").last,
      );
      FormData formData = FormData.fromMap({
        "profile_pic": file,
      });
      var response = await dioRequest.post(
        uploadProfilePicEndPoint,
        data: formData,
      );

      //[5] SEND TO SERVER

      final result = json.decode(response.toString());
      return AuthResponse.fromJson(result);
    } on Exception catch (e) {
      if (e is SocketException) {
        throw (noInternetAvailableMsg);
      }else if (e is dio.DioError) {
        throw (e.message.toString());
      } else if (e is TimeoutException) {
        throw (e.toString());
      } else {
        throw (e.toString());
      }
    } catch (err) {
      throw (err.toString());
    }
  }

//  Future<dynamic> specificationRequest(
//     String specId, String catId) async {
//   try {
//     var userToken =
//     await SharedPreferenceUtil.getStringValuesSF(USER_TOKEN_KEY);
//     headerMap['Authorization'] = 'Bearer $userToken';
//     var userID = await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
//     Map<String, dynamic> data = {
//       "user_id": userID.toString(),
//       "specification_id": specId,
//       "category_id": catId
//     };
//     String url = BASE_API_URL + "/copy_spec";
//
//     final response =
//     await http.post(Uri.parse(url), headers: headerMap, body: data);
//
//     if(catId == "1"){
//       return FiberSpecificationResponse.fromJson(
//         json.decode(response.body),
//       );
//     }else{
//       return GetYarnSpecificationResponse.fromJson(
//         json.decode(response.body),
//       );
//     }
//
//
//   } catch (e) {
//     if (e is SocketException) {
//       throw (no_internet_available_msg);
//     } else if (e is TimeoutException) {
//       throw (e.toString());
//     } else {
//       throw ("Something went wrong");
//     }
//   }
// }
}
