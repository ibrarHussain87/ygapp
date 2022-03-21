

import 'package:floor/floor.dart';

import '../common_response_models/city_state_response.dart';
import '../common_response_models/countries_response.dart';
import '../common_response_models/delievery_period.dart';
import '../common_response_models/unit_of_count.dart';

class SyncResponse {
  bool? status;
  int? responseCode;
  Data? data;
  String? message;

  SyncResponse({this.status, this.responseCode, this.data, this.message});

  SyncResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    stocklot = json['stocklot'] != null
        ? new Stocklot.fromJson(json['stocklot'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
  List<PriceTerms>? priceTerms;
  List<LcTypes>? lcTypes;
  List<PaymentTypes>? paymentTypes;
  List<Units>? units;
  List<DeliveryPeriod>? deliveryPeriod;

  Stocklot(
      {this.stocklotCategories,
        this.stocklots,
        this.countries,
        this.cityState,
        this.priceTerms,
        this.lcTypes,
        this.paymentTypes,
        this.units,
        this.deliveryPeriod});

  Stocklot.fromJson(Map<String, dynamic> json) {
    if (json['Stocklot_categories'] != null) {
      stocklotCategories = <StocklotCategories>[];
      json['Stocklot_categories'].forEach((v) {
        stocklotCategories!.add(new StocklotCategories.fromJson(v));
      });
    }
    if (json['stocklots'] != null) {
      stocklots = <Stocklots>[];
      json['stocklots'].forEach((v) {
        stocklots!.add(new Stocklots.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    if (json['city_state'] != null) {
      cityState = <CityState>[];
      json['city_state'].forEach((v) {
        cityState!.add(new CityState.fromJson(v));
      });
    }
    if (json['price_terms'] != null) {
      priceTerms = <PriceTerms>[];
      json['price_terms'].forEach((v) {
        priceTerms!.add(new PriceTerms.fromJson(v));
      });
    }
    if (json['lc_types'] != null) {
      lcTypes = <LcTypes>[];
      json['lc_types'].forEach((v) {
        lcTypes!.add(new LcTypes.fromJson(v));
      });
    }
    if (json['payment_types'] != null) {
      paymentTypes = <PaymentTypes>[];
      json['payment_types'].forEach((v) {
        paymentTypes!.add(new PaymentTypes.fromJson(v));
      });
    }
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
    if (json['delivery_period'] != null) {
      deliveryPeriod = <DeliveryPeriod>[];
      json['delivery_period'].forEach((v) {
        deliveryPeriod!.add(new DeliveryPeriod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['category'] = this.category;
    data['is_active'] = this.isActive;
    data['sortid'] = this.sortid;
    return data;
  }

  @override
  String toString() {
    return category??"";
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return name??"";
  }
}

/*class Countries {
  int? conId;
  String? conName;
  String? conIsoCode2;
  String? conIsoCode3;
  String? conCurrency;
  String? conAddressFormat;
  String? conPostcodeRequired;
  String? conIsActive;

  Countries(
      {this.conId,
        this.conName,
        this.conIsoCode2,
        this.conIsoCode3,
        this.conCurrency,
        this.conAddressFormat,
        this.conPostcodeRequired,
        this.conIsActive});

  Countries.fromJson(Map<String, dynamic> json) {
    conId = json['con_id'];
    conName = json['con_name'];
    conIsoCode2 = json['con_iso_code_2'];
    conIsoCode3 = json['con_iso_code_3'];
    conCurrency = json['con_currency'];
    conAddressFormat = json['con_address_format'];
    conPostcodeRequired = json['con_postcode_required'];
    conIsActive = json['con_is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['con_id'] = this.conId;
    data['con_name'] = this.conName;
    data['con_iso_code_2'] = this.conIsoCode2;
    data['con_iso_code_3'] = this.conIsoCode3;
    data['con_currency'] = this.conCurrency;
    data['con_address_format'] = this.conAddressFormat;
    data['con_postcode_required'] = this.conPostcodeRequired;
    data['con_is_active'] = this.conIsActive;
    return data;
  }
}*/

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

class PriceTerms {
  int? ptrId;
  String? ptrCategoryIdfk;
  Null? ptrCountryIdfk;
  String? ptrLocality;
  Null? parentId;
  String? ptrName;
  String? ptrIsActive;
  Null? ptrSortid;
  Null? createdAt;
  Null? updatedAt;
  Null? deletedAt;

  PriceTerms(
      {this.ptrId,
        this.ptrCategoryIdfk,
        this.ptrCountryIdfk,
        this.ptrLocality,
        this.parentId,
        this.ptrName,
        this.ptrIsActive,
        this.ptrSortid,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  PriceTerms.fromJson(Map<String, dynamic> json) {
    ptrId = json['ptr_id'];
    ptrCategoryIdfk = json['ptr_category_idfk'];
    ptrCountryIdfk = json['ptr_country_idfk'];
    ptrLocality = json['ptr_locality'];
    parentId = json['parent_id'];
    ptrName = json['ptr_name'];
    ptrIsActive = json['ptr_is_active'];
    ptrSortid = json['ptr_sortid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ptr_id'] = this.ptrId;
    data['ptr_category_idfk'] = this.ptrCategoryIdfk;
    data['ptr_country_idfk'] = this.ptrCountryIdfk;
    data['ptr_locality'] = this.ptrLocality;
    data['parent_id'] = this.parentId;
    data['ptr_name'] = this.ptrName;
    data['ptr_is_active'] = this.ptrIsActive;
    data['ptr_sortid'] = this.ptrSortid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class LcTypes {
  int? lcId;
  String? lcName;
  String? lcIsActive;
  Null? lcSortid;
  Null? createdAt;
  Null? updatedAt;
  Null? deletedAt;

  LcTypes(
      {this.lcId,
        this.lcName,
        this.lcIsActive,
        this.lcSortid,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  LcTypes.fromJson(Map<String, dynamic> json) {
    lcId = json['lc_id'];
    lcName = json['lc_name'];
    lcIsActive = json['lc_is_active'];
    lcSortid = json['lc_sortid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lc_id'] = this.lcId;
    data['lc_name'] = this.lcName;
    data['lc_is_active'] = this.lcIsActive;
    data['lc_sortid'] = this.lcSortid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class PaymentTypes {
  String? payId;
  String? payPriceTerrmIdfk;
  String? parentId;
  String? payName;
  String? payIsActive;
  Null? paySortid;
  Null? createdAt;
  Null? updatedAt;
  Null? deletedAt;

  PaymentTypes(
      {this.payId,
        this.payPriceTerrmIdfk,
        this.parentId,
        this.payName,
        this.payIsActive,
        this.paySortid,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  PaymentTypes.fromJson(Map<String, dynamic> json) {
    payId = json['pay_id'];
    payPriceTerrmIdfk = json['pay_price_terrm_idfk'];
    parentId = json['parent_id'];
    payName = json['pay_name'];
    payIsActive = json['pay_is_active'];
    paySortid = json['pay_sortid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pay_id'] = this.payId;
    data['pay_price_terrm_idfk'] = this.payPriceTerrmIdfk;
    data['parent_id'] = this.parentId;
    data['pay_name'] = this.payName;
    data['pay_is_active'] = this.payIsActive;
    data['pay_sortid'] = this.paySortid;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

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
