import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';

class PreLoginResponse {

  int? code;
  bool? success;
  String? message;
  int? statusCode;
  Data? data;

  PreLoginResponse(
      {this.code, this.success, this.message, this.statusCode, this.data});

  PreLoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<GenericCategories>? categories;
  List<Brands>? brands;
  List<Countries>? countries;
  List<States>? states;
  List<Cities>? cities;
  List<Designations>? designations;
  List<Ports>? ports;
  List<PaymentType>? paymentTypes;
  List<SubscriptionPlans>? subscriptionPlans;
  List<ServiceTypes>? serviceTypes;

  Data(
      {this.categories,
        this.brands,
        this.countries,
        this.states,
        this.cities,
        this.designations,
        this.ports,
        this.paymentTypes,
        this.subscriptionPlans,
        this.serviceTypes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <GenericCategories>[];
      json['categories'].forEach((v) {
        categories!.add(GenericCategories.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states!.add(States.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
    if (json['designations'] != null) {
      designations = <Designations>[];
      json['designations'].forEach((v) {
        designations!.add(Designations.fromJson(v));
      });
    }
    if (json['ports'] != null) {
      ports = <Ports>[];
      json['ports'].forEach((v) {
        ports!.add(Ports.fromJson(v));
      });
    }
    if (json['payment_types'] != null) {
      paymentTypes = <PaymentType>[];
      json['payment_types'].forEach((v) {
        paymentTypes!.add(PaymentType.fromJson(v));
      });
    }
    if (json['subscription_plans'] != null) {
      subscriptionPlans = <SubscriptionPlans>[];
      json['subscription_plans'].forEach((v) {
        subscriptionPlans!.add(SubscriptionPlans.fromJson(v));
      });
    }
    if (json['service_types'] != null) {
      serviceTypes = <ServiceTypes>[];
      json['service_types'].forEach((v) {
        serviceTypes!.add(ServiceTypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.states != null) {
      data['states'] = this.states!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    if (this.designations != null) {
      data['designations'] = this.designations!.map((v) => v.toJson()).toList();
    }
    if (this.ports != null) {
      data['ports'] = this.ports!.map((v) => v.toJson()).toList();
    }
    if (this.paymentTypes != null) {
      data['payment_types'] =
          this.paymentTypes!.map((v) => v.toJson()).toList();
    }
    if (this.subscriptionPlans != null) {
      data['subscription_plans'] =
          this.subscriptionPlans!.map((v) => v.toJson()).toList();
    }
    if (this.serviceTypes != null) {
      data['service_types'] =
          this.serviceTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@Entity(tableName: 'generic_categories')
class GenericCategories {
  @PrimaryKey(autoGenerate: false)
  int? catId;
  String? catName;

  GenericCategories({this.catId, this.catName});

  GenericCategories.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    catName = json['cat_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cat_id'] = this.catId;
    data['cat_name'] = this.catName;
    return data;
  }
}


@Entity(tableName: 'states')
class States {
  @PrimaryKey(autoGenerate: false)
  int? stateId;
  String? stateName;
  String? countryIdfk;
  String? stateIsActive;
  String? stateSortid;

  States(
      {this.stateId,
        this.stateName,
        this.countryIdfk,
        this.stateIsActive,
        this.stateSortid});

  States.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
    countryIdfk = json['country_idfk'];
    stateIsActive = json['state_is_active'];
    stateSortid = json['state_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['country_idfk'] = this.countryIdfk;
    data['state_is_active'] = this.stateIsActive;
    data['state_sortid'] = this.stateSortid;
    return data;
  }
}

@Entity(tableName: 'cities')
class Cities {
  @PrimaryKey(autoGenerate: false)
  int? cityId;
  String? countryIdfk;
  String? stateIdfk;
  String? cityName;
  String? citySortid;
  String? cityIsActive;

  Cities(
      {this.cityId,
        this.countryIdfk,
        this.stateIdfk,
        this.cityName,
        this.citySortid,
        this.cityIsActive});

  Cities.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    countryIdfk = json['country_idfk'];
    stateIdfk = json['state_idfk'];
    cityName = json['city_name'];
    citySortid = json['city_sortid'];
    cityIsActive = json['city_is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['country_idfk'] = this.countryIdfk;
    data['state_idfk'] = this.stateIdfk;
    data['city_name'] = this.cityName;
    data['city_sortid'] = this.citySortid;
    data['city_is_active'] = this.cityIsActive;
    return data;
  }
}

@Entity(tableName: 'designations')
class Designations {
  @PrimaryKey(autoGenerate: false)
  int? designationId;
  String? designationTitle;
  String? designationStatus;

  Designations(
      {this.designationId, this.designationTitle, this.designationStatus});

  Designations.fromJson(Map<String, dynamic> json) {
    designationId = json['designation_id'];
    designationTitle = json['designation_title'];
    designationStatus = json['designation_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['designation_id'] = this.designationId;
    data['designation_title'] = this.designationTitle;
    data['designation_status'] = this.designationStatus;
    return data;
  }
}


@Entity(tableName: 'subscription_plans')
class SubscriptionPlans {
  @PrimaryKey(autoGenerate: false)
  int? spId;
  String? spName;
  String? spDisplayTitle;
  String? spStatus;
  String? spLongDescription;
  String? spShortDescription;
  String? spPrice;
  String? spDurationType;
  String? spDurationCount;

  SubscriptionPlans(
      {this.spId,
        this.spName,
        this.spDisplayTitle,
        this.spStatus,
        this.spLongDescription,
        this.spShortDescription,
        this.spPrice,
        this.spDurationType,
        this.spDurationCount});

  SubscriptionPlans.fromJson(Map<String, dynamic> json) {
    spId = json['sp_id'];
    spName = json['sp_name'];
    spDisplayTitle = json['sp_display_title'];
    spStatus = json['sp_status'];
    spLongDescription = json['sp_long_description'];
    spShortDescription = json['sp_short_description'];
    spPrice = json['sp_price'];
    spDurationType = json['sp_duration_type'];
    spDurationCount = json['sp_duration_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sp_id'] = this.spId;
    data['sp_name'] = this.spName;
    data['sp_display_title'] = this.spDisplayTitle;
    data['sp_status'] = this.spStatus;
    data['sp_long_description'] = this.spLongDescription;
    data['sp_short_description'] = this.spShortDescription;
    data['sp_price'] = this.spPrice;
    data['sp_duration_type'] = this.spDurationType;
    data['sp_duration_count'] = this.spDurationCount;
    return data;
  }
}

@Entity(tableName: 'service_types')
class ServiceTypes {
  @PrimaryKey(autoGenerate: false)
  int? serviceTypeId;
  String? serviceTypeName;
  String? serviceTypeStatus;

  ServiceTypes(
      {this.serviceTypeId, this.serviceTypeName, this.serviceTypeStatus});

  ServiceTypes.fromJson(Map<String, dynamic> json) {
    serviceTypeId = json['service_type_id'];
    serviceTypeName = json['service_type_name'];
    serviceTypeStatus = json['service_type_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['service_type_id'] = this.serviceTypeId;
    data['service_type_name'] = this.serviceTypeName;
    data['service_type_status'] = this.serviceTypeStatus;
    return data;
  }
}
