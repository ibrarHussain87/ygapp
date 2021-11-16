import 'package:floor/floor.dart';
import 'package:yg_app/model/response/sync/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/companies_reponse.dart';
import 'package:yg_app/model/response/sync/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/lc_type_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/packing_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/price_term.dart';

import 'fiber_apperance.dart';
import '../common_response_models/certification_response.dart';
import 'fiber_delievery_period.dart';
import 'fiber_grade.dart';
import 'fiber_unit_of_count.dart';

class SyncFiberResponse {
  SyncFiberResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });
  late final bool status;
  late final int responseCode;
  late final FiberSyncData data;
  late final String message;

  SyncFiberResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    responseCode = json['response_code'];
    data = FiberSyncData.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['response_code'] = responseCode;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class FiberSyncData {
  FiberSyncData({
    required this.fiber,
  });
  late final FiberModel fiber;

  FiberSyncData.fromJson(Map<String, dynamic> json){
    fiber = FiberModel.fromJson(json['fiber']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fiber'] = fiber.toJson();
    return _data;
  }
}
class FiberModel {
  FiberModel({
    required this.categories,
    required this.material,
    required this.apperance,
    required this.brands,
    required this.countries,
    required this.certification,
    required this.deliveryPeriod,
    required this.units,
    required this.grades,
    required this.priceTerms,
    required this.availbleForMarket,
    required this.settings,
  });
  late final List<FiberCategories> categories;
  late final List<FiberMaterial> material;
  late final List<FiberApperance> apperance;
  late final List<CountriesModel> countries;
  late final List<CertificationModel> certification;
  late final List<FiberDeliveryPeriod> deliveryPeriod;
  late final List<FiberUnits> units;
  late final List<BrandsModel> brands;
  late final List<FiberGrades> grades;
  late final List<FiberPriceTerms> priceTerms;
  late final List<FiberAvailbleForMarket> availbleForMarket;
  late final List<CompaniesModel> companies;
  late final List<PaymentTypeModel> paymentType;
  late final List<PortsModel> ports;
  late final List<LcTypeModel> lcType;
  late final List<PackingModel> packing;
  late final List<FiberSettings> settings;

  FiberModel.fromJson(Map<String, dynamic> json){
    categories = List.from(json['categories']).map((e)=>FiberCategories.fromJson(e)).toList();
    material = List.from(json['material']).map((e)=>FiberMaterial.fromJson(e)).toList();
    apperance = List.from(json['apperance']).map((e)=>FiberApperance.fromJson(e)).toList();
    brands = List.from(json['brands']).map((e)=>BrandsModel.fromJson(e)).toList();
    countries = List.from(json['countries']).map((e)=>CountriesModel.fromJson(e)).toList();
    certification = List.from(json['certification']).map((e)=>CertificationModel.fromJson(e)).toList();
    deliveryPeriod = List.from(json['deliveryPeriod']).map((e)=>FiberDeliveryPeriod.fromJson(e)).toList();
    units = List.from(json['units']).map((e)=>FiberUnits.fromJson(e)).toList();
    grades = List.from(json['grades']).map((e)=>FiberGrades.fromJson(e)).toList();
    priceTerms = List.from(json['priceTerms']).map((e)=>FiberPriceTerms.fromJson(e)).toList();
    availbleForMarket = List.from(json['availbleForMarket']).map((e)=>FiberAvailbleForMarket.fromJson(e)).toList();
    companies = List.from(json['companies']).map((e)=>CompaniesModel.fromJson(e)).toList();
    paymentType = List.from(json['payment_types']).map((e)=>PaymentTypeModel.fromJson(e)).toList();
    ports = List.from(json['ports']).map((e)=>PortsModel.fromJson(e)).toList();
    lcType = List.from(json['lc_types']).map((e)=>LcTypeModel.fromJson(e)).toList();
    packing = List.from(json['packing']).map((e)=>PackingModel.fromJson(e)).toList();
    settings = List.from(json['settings']).map((e)=>FiberSettings.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categories'] = categories.map((e)=>e.toJson()).toList();
    _data['material'] = material.map((e)=>e.toJson()).toList();
    _data['apperance'] = apperance.map((e)=>e.toJson()).toList();
    _data['brands'] = brands.map((e)=>e.toJson()).toList();
    _data['countries'] = countries.map((e)=>e.toJson()).toList();
    _data['certification'] = certification.map((e)=>e.toJson()).toList();
    _data['deliveryPeriod'] = deliveryPeriod.map((e)=>e.toJson()).toList();
    _data['units'] = units.map((e)=>e.toJson()).toList();
    _data['brands'] = units.map((e)=>e.toJson()).toList();
    _data['grades'] = grades.map((e)=>e.toJson()).toList();
    _data['priceTerms'] = priceTerms.map((e)=>e.toJson()).toList();
    _data['availbleForMarket'] = availbleForMarket.map((e)=>e.toJson()).toList();
    _data['companies'] = companies.map((e)=>e.toJson()).toList();
    _data['payment_types'] = paymentType.map((e)=>e.toJson()).toList();
    _data['ports'] = ports.map((e)=>e.toJson()).toList();
    _data['lc_types'] = lcType.map((e)=>e.toJson()).toList();
    _data['packing'] = packing.map((e)=>e.toJson()).toList();
    _data['settings'] = settings.map((e)=>e.toJson()).toList();
    return _data;
  }
}

@Entity(tableName: 'fiber_categories')
class FiberCategories {
  FiberCategories({
    required this.catId,
    required this.catName,
    required this.catIsActive,
    this.catSortid,
  });
  @PrimaryKey(autoGenerate: false)
  late final int catId;
  late final String catName;
  late final String catIsActive;
  @ignore
  late final Null catSortid;

  FiberCategories.fromJson(Map<String, dynamic> json){
    catId = json['cat_id'];
    catName = json['cat_name'];
    catIsActive = json['cat_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cat_id'] = catId;
    _data['cat_name'] = catName;
    _data['cat_is_active'] = catIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }
}

@Entity(tableName: 'fiber_entity')
class FiberMaterial {
  FiberMaterial({
    required this.fbmId,
    required this.fbmCategoryIdfk,
    required this.fbmName,
    required this.fbmIsActive,
    this.fbmSortid,
  });
  @PrimaryKey(autoGenerate: false)
  late final int fbmId;
  late final String fbmCategoryIdfk;
  late final String fbmName;
  late final String fbmIsActive;
  @ignore
  late final Null fbmSortid;

  FiberMaterial.fromJson(Map<String, dynamic> json){
    fbmId = json['fbm_id'];
    fbmCategoryIdfk = json['fbm_category_idfk'];
    fbmName = json['fbm_name'];
    fbmIsActive = json['fbm_is_active'];
    fbmSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fbm_id'] = fbmId;
    _data['fbm_category_idfk'] = fbmCategoryIdfk;
    _data['fbm_name'] = fbmName;
    _data['fbm_is_active'] = fbmIsActive;
    _data['fbm_sortid'] = fbmSortid;
    return _data;
  }
}

@Entity(tableName: 'fiber_available_market')
class FiberAvailbleForMarket {
  FiberAvailbleForMarket({
    required this.afmId,
    required this.afmCategoryIdfk,
    this.afmPortIdfk,
    required this.afmName,
    required this.afmIsActive,
    this.afmSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @PrimaryKey(autoGenerate: false)
  late final int afmId;
  late final String afmCategoryIdfk;
  @ignore
  late final Null afmPortIdfk;
  late final String afmName;
  late final String afmIsActive;
  @ignore
  late final Null afmSortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  FiberAvailbleForMarket.fromJson(Map<String, dynamic> json){
    afmId = json['afm_id'];
    afmCategoryIdfk = json['afm_category_idfk'];
    afmPortIdfk = null;
    afmName = json['afm_name'];
    afmIsActive = json['afm_is_active'];
    afmSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['afm_id'] = afmId;
    _data['afm_category_idfk'] = afmCategoryIdfk;
    _data['afm_port_idfk'] = afmPortIdfk;
    _data['afm_name'] = afmName;
    _data['afm_is_active'] = afmIsActive;
    _data['afm_sortid'] = afmSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }
}

@Entity(tableName: 'fiber_setting')
class FiberSettings {
  FiberSettings({
    required this.fbsId,
    required this.fbsCategoryIdfk,
    required this.fbsFiberMaterialIdfk,
    required this.showLength,
    required this.lengthMinMax,
    required this.showGrade,
    required this.showMicronaire,
    required this.micMinMax,
    required this.showMoisture,
    required this.moiMinMax,
    required this.showTrash,
    required this.trashMinMax,
    required this.showRd,
    required this.rdMinMax,
    required this.showGpt,
    required this.gptMinMax,
    required this.showAppearance,
    required this.showBrand,
    required this.showOrigin,
    required this.showCertification,
    required this.showCountUnit,
    required this.showDeliveryPeriod,
    required this.showAvailableForMarket,
    required this.showPriceTerms,
    required this.fbsIsActive,
    this.fbsSortid,
    required this.catName,
    required this.matName,
  });
  @PrimaryKey(autoGenerate: false)
  late final int fbsId;
  late final String fbsCategoryIdfk;
  late final String fbsFiberMaterialIdfk;
  late final String showLength;
  late final String lengthMinMax;
  late final String showGrade;
  late final String showMicronaire;
  late final String micMinMax;
  late final String showMoisture;
  late final String moiMinMax;
  late final String showTrash;
  late final String trashMinMax;
  late final String showRd;
  late final String rdMinMax;
  late final String showGpt;
  late final String gptMinMax;
  late final String showAppearance;
  late final String showBrand;
  late final String showOrigin;
  late final String showCertification;
  late final String showCountUnit;
  late final String showDeliveryPeriod;
  late final String showAvailableForMarket;
  late final String showPriceTerms;
  late final String fbsIsActive;
  @ignore
  late final Null fbsSortid;
  late final String catName;
  late final String matName;

  FiberSettings.fromJson(Map<String, dynamic> json){
    fbsId = json['fbs_id'];
    fbsCategoryIdfk = json['fbs_category_idfk'];
    fbsFiberMaterialIdfk = json['fbs_fiber_material_idfk'];
    showLength = json['show_length'];
    lengthMinMax = json['length_min_max'];
    showGrade = json['show_grade'];
    showMicronaire = json['show_micronaire'];
    micMinMax = json['mic_min_max'];
    showMoisture = json['show_moisture'];
    moiMinMax = json['moi_min_max'];
    showTrash = json['show_trash'];
    trashMinMax = json['trash_min_max'];
    showRd = json['show_rd'];
    rdMinMax = json['rd_min_max'];
    showGpt = json['show_gpt'];
    gptMinMax = json['gpt_min_max'];
    showAppearance = json['show_appearance'];
    showBrand = json['show_brand'];
    showOrigin = json['show_origin'];
    showCertification = json['show_certification'];
    showCountUnit = json['show_count_unit'];
    showDeliveryPeriod = json['show_delivery_period'];
    showAvailableForMarket = json['show_available_for_market'];
    showPriceTerms = json['show_price_terms'];
    fbsIsActive = json['fbs_is_active'];
    fbsSortid = null;
    catName = json['cat_name'];
    matName = json['mat_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fbs_id'] = fbsId;
    _data['fbs_category_idfk'] = fbsCategoryIdfk;
    _data['fbs_fiber_material_idfk'] = fbsFiberMaterialIdfk;
    _data['show_length'] = showLength;
    _data['length_min_max'] = lengthMinMax;
    _data['show_grade'] = showGrade;
    _data['show_micronaire'] = showMicronaire;
    _data['mic_min_max'] = micMinMax;
    _data['show_moisture'] = showMoisture;
    _data['moi_min_max'] = moiMinMax;
    _data['show_trash'] = showTrash;
    _data['trash_min_max'] = trashMinMax;
    _data['show_rd'] = showRd;
    _data['rd_min_max'] = rdMinMax;
    _data['show_gpt'] = showGpt;
    _data['gpt_min_max'] = gptMinMax;
    _data['show_appearance'] = showAppearance;
    _data['show_brand'] = showBrand;
    _data['show_origin'] = showOrigin;
    _data['show_certification'] = showCertification;
    _data['show_count_unit'] = showCountUnit;
    _data['show_delivery_period'] = showDeliveryPeriod;
    _data['show_available_for_market'] = showAvailableForMarket;
    _data['show_price_terms'] = showPriceTerms;
    _data['fbs_is_active'] = fbsIsActive;
    _data['fbs_sortid'] = fbsSortid;
    _data['cat_name'] = catName;
    _data['mat_name'] = matName;
    return _data;
  }

}