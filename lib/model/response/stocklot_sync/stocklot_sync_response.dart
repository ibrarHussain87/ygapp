import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/lc_type_response.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';

import '../common_response_models/city_state_response.dart';
import '../common_response_models/countries_response.dart';
import '../common_response_models/delievery_period.dart';
import '../common_response_models/unit_of_count.dart';

class StockLotSyncResponse {
  bool? status;
  int? responseCode;
  Data? data;
  String? message;

  StockLotSyncResponse(
      {this.status, this.responseCode, this.data, this.message});

  StockLotSyncResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['response_code'] = this.responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  Stocklot? stocklot;

  Data({this.stocklot});

  Data.fromJson(Map<String, dynamic> json) {
    stocklot =
        json['stocklot'] != null ? Stocklot.fromJson(json['stocklot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.stocklot != null) {
      data['stocklot'] = this.stocklot!.toJson();
    }
    return data;
  }
}

class Stocklot {
  List<StocklotCategories>? stocklotCategories;
  List<Stocklots>? stocklots;
  List<Countries>? countries;
  List<CityState>? cityState;
  List<FPriceTerms>? priceTerms;
  List<LcType>? lcTypes;
  List<AvailabilityModel>? availabilityList;
  List<PaymentType>? paymentTypes;
  List<Units>? units;
  List<DeliveryPeriod>? deliveryPeriod;

  Stocklot(
      {this.stocklotCategories,
      this.stocklots,
      this.countries,
      this.cityState,
      this.priceTerms,
      this.lcTypes,
      this.availabilityList,
      this.paymentTypes,
      this.units,
      this.deliveryPeriod});

  Stocklot.fromJson(Map<String, dynamic> json) {
    if (json['Stocklot_categories'] != null) {
      stocklotCategories = <StocklotCategories>[];
      json['Stocklot_categories'].forEach((v) {
        stocklotCategories!.add(StocklotCategories.fromJson(v));
      });
    }
    if (json['stocklots'] != null) {
      stocklots = <Stocklots>[];
      json['stocklots'].forEach((v) {
        stocklots!.add(Stocklots.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(Countries.fromJson(v));
      });
    }
    if (json['city_state'] != null) {
      cityState = <CityState>[];
      json['city_state'].forEach((v) {
        cityState!.add(CityState.fromJson(v));
      });
    }
    if (json['price_terms'] != null) {
      priceTerms = <FPriceTerms>[];
      json['price_terms'].forEach((v) {
        priceTerms!.add(FPriceTerms.fromJson(v));
      });
    }
    if (json['lc_types'] != null) {
      lcTypes = <LcType>[];
      json['lc_types'].forEach((v) {
        lcTypes!.add(LcType.fromJson(v));
      });
    }

    if (json['availablity'] != null) {
      availabilityList = <AvailabilityModel>[];
      json['availablity'].forEach((v) {
        availabilityList!.add(AvailabilityModel.fromJson(v));
      });
    }

    if (json['payment_types'] != null) {
      paymentTypes = <PaymentType>[];
      json['payment_types'].forEach((v) {
        paymentTypes!.add(PaymentType.fromJson(v));
      });
    }
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(Units.fromJson(v));
      });
    }
    if (json['delivery_period'] != null) {
      deliveryPeriod = <DeliveryPeriod>[];
      json['delivery_period'].forEach((v) {
        deliveryPeriod!.add(DeliveryPeriod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.stocklotCategories != null) {
      data['Stocklot_categories'] =
          this.stocklotCategories!.map((v) => v.toJson()).toList();
    }
    if (this.stocklots != null) {
      data['stocklots'] = this.stocklots!.map((v) => v.toJson()).toList();
    }
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.cityState != null) {
      data['city_state'] = this.cityState!.map((v) => v.toJson()).toList();
    }
    if (this.priceTerms != null) {
      data['price_terms'] = this.priceTerms!.map((v) => v.toJson()).toList();
    }
    if (this.lcTypes != null) {
      data['lc_types'] = this.lcTypes!.map((v) => v.toJson()).toList();
    }
    if (this.paymentTypes != null) {
      data['payment_types'] =
          this.paymentTypes!.map((v) => v.toJson()).toList();
    }
    if (this.units != null) {
      data['units'] = this.units!.map((v) => v.toJson()).toList();
    }
    if (this.deliveryPeriod != null) {
      data['delivery_period'] =
          this.deliveryPeriod!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@Entity(tableName: 'stocklot_categories_table')
class StocklotCategories {
  @PrimaryKey(autoGenerate: false)
  int? id;
  String? parentId;
  String? category;
  String? isActive;
  @ignore
  Null? sortid;

  StocklotCategories(
      {this.id, this.parentId, this.category, this.isActive, this.sortid});

  StocklotCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    category = json['category'];
    isActive = json['is_active'];
    sortid = json['sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['category'] = this.category;
    data['is_active'] = this.isActive;
    data['sortid'] = this.sortid;
    return data;
  }

  @override
  String toString() {
    return category ?? "";
  }
}

@Entity(tableName: 'stocklots_table')
class Stocklots {
  @PrimaryKey(autoGenerate: false)
  int? id;
  String? categoryId;
  String? parentId;
  String? name;
  String? isActive;
  @ignore
  Null? sortid;

  Stocklots(
      {this.id,
      this.categoryId,
      this.parentId,
      this.name,
      this.isActive,
      this.sortid});

  Stocklots.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    parentId = json['parent_id'];
    name = json['name'];
    isActive = json['is_active'];
    sortid = json['sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['sortid'] = this.sortid;
    return data;
  }

  @override
  String toString() {
    return name ?? "";
  }
}

@Entity(tableName: 'availability_table')
class AvailabilityModel {
  @PrimaryKey(autoGenerate: false)
  int? afm_id;
  String? afm_category_idfk;
  String? afm_port_idfk;
  String? afm_name;
  String? afm_is_active;
  String? afm_sortid;
  String? created_at;
  String? updated_at;
  String? deleted_at;

  AvailabilityModel(
      {this.afm_id,
        this.afm_category_idfk,
        this.afm_port_idfk,
        this.afm_name,
        this.afm_is_active,
        this.afm_sortid,
        this.created_at,
        this.updated_at,
        this.deleted_at});

  AvailabilityModel.fromJson(Map<String, dynamic> json) {
    afm_id = json['afm_id'];
    afm_category_idfk = json['afm_category_idfk'];
    afm_port_idfk = json['afm_port_idfk'];
    afm_name = json['afm_name'];
    afm_is_active = json['afm_is_active'];
    afm_sortid = json['afm_sortid'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    deleted_at = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['afm_id'] = this.afm_id;
    data['afm_category_idfk'] = this.afm_category_idfk;
    data['afm_port_idfk'] = this.afm_port_idfk;
    data['afm_name'] = this.afm_name;
    data['afm_is_active'] = this.afm_is_active;
    data['afm_sortid'] = this.afm_sortid;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['deleted_at'] = this.deleted_at;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return afm_name ?? "";
  }
}

/*class CityState {
  int? id;
  String? countryId;
  String? name;
  String? code;

  CityState({this.id, this.countryId, this.name, this.code});

  CityState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}*/

/*class Units {
  int? untId;
  String? untCategoryIdfk;
  String? untName;
  String? untIsActive;
  Null? untSortid;
  Null? createdAt;
  Null? updatedAt;
  Null? deletedAt;

  Units(
      {this.untId,
        this.untCategoryIdfk,
        this.untName,
        this.untIsActive,
        this.untSortid,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Units.fromJson(Map<String, dynamic> json) {
    untId = json['unt_id'];
    untCategoryIdfk = json['unt_category_idfk'];
    untName = json['unt_name'];
    untIsActive = json['unt_is_active'];
    untSortid = json['unt_sortid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unt_id'] = this.untId;
    data['unt_category_idfk'] = this.untCategoryIdfk;
    data['unt_name'] = this.untName;
    data['unt_is_active'] = this.untIsActive;
    data['unt_sortid'] = this.untSortid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}*/

/*
class DeliveryPeriod {
  int? dprId;
  String? dprCategoryIdfk;
  String? dprName;
  String? dprIsActive;
  Null? dprSortid;
  Null? createdAt;
  Null? updatedAt;
  Null? deletedAt;

  DeliveryPeriod(
      {this.dprId,
        this.dprCategoryIdfk,
        this.dprName,
        this.dprIsActive,
        this.dprSortid,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  DeliveryPeriod.fromJson(Map<String, dynamic> json) {
    dprId = json['dpr_id'];
    dprCategoryIdfk = json['dpr_category_idfk'];
    dprName = json['dpr_name'];
    dprIsActive = json['dpr_is_active'];
    dprSortid = json['dpr_sortid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dpr_id'] = this.dprId;
    data['dpr_category_idfk'] = this.dprCategoryIdfk;
    data['dpr_name'] = this.dprName;
    data['dpr_is_active'] = this.dprIsActive;
    data['dpr_sortid'] = this.dprSortid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}*/
