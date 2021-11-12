import 'package:floor/floor.dart';

import 'fiber_apperance.dart';
import 'fiber_certification.dart';
import 'fiber_countries.dart';
import 'fiber_grade.dart';

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
  late final List<FiberBrands> brands;
  late final List<FiberCountries> countries;
  late final List<FiberCertification> certification;
  late final List<FiberDeliveryPeriod> deliveryPeriod;
  late final List<FiberUnits> units;
  late final List<FiberGrades> grades;
  late final List<FiberPriceTerms> priceTerms;
  late final List<FiberAvailbleForMarket> availbleForMarket;
  late final List<FiberSettings> settings;

  FiberModel.fromJson(Map<String, dynamic> json){
    categories = List.from(json['categories']).map((e)=>FiberCategories.fromJson(e)).toList();
    material = List.from(json['material']).map((e)=>FiberMaterial.fromJson(e)).toList();
    apperance = List.from(json['apperance']).map((e)=>FiberApperance.fromJson(e)).toList();
    brands = List.from(json['brands']).map((e)=>FiberBrands.fromJson(e)).toList();
    countries = List.from(json['countries']).map((e)=>FiberCountries.fromJson(e)).toList();
    certification = List.from(json['certification']).map((e)=>FiberCertification.fromJson(e)).toList();
    deliveryPeriod = List.from(json['deliveryPeriod']).map((e)=>FiberDeliveryPeriod.fromJson(e)).toList();
    units = List.from(json['units']).map((e)=>FiberUnits.fromJson(e)).toList();
    grades = List.from(json['grades']).map((e)=>FiberGrades.fromJson(e)).toList();
    priceTerms = List.from(json['priceTerms']).map((e)=>FiberPriceTerms.fromJson(e)).toList();
    availbleForMarket = List.from(json['availbleForMarket']).map((e)=>FiberAvailbleForMarket.fromJson(e)).toList();
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
    _data['grades'] = grades.map((e)=>e.toJson()).toList();
    _data['priceTerms'] = priceTerms.map((e)=>e.toJson()).toList();
    _data['availbleForMarket'] = availbleForMarket.map((e)=>e.toJson()).toList();
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

@Entity(tableName: 'fiber_brand')
class FiberBrands {
  FiberBrands({
    required this.brdId,
    this.brdCategoryIdfk,
    required this.brdName,
    required this.brdIsActive,
    this.brdSortid,
  });
  @PrimaryKey(autoGenerate: false)
  late final int brdId;
  @ignore
  late final Null brdCategoryIdfk;
  late final String brdName;
  late final String brdIsActive;
  @ignore
  late final Null brdSortid;

  FiberBrands.fromJson(Map<String, dynamic> json){
    brdId = json['brd_id'];
    brdCategoryIdfk = null;
    brdName = json['brd_name'];
    brdIsActive = json['brd_is_active'];
    brdSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['brd_id'] = brdId;
    _data['brd_category_idfk'] = brdCategoryIdfk;
    _data['brd_name'] = brdName;
    _data['brd_is_active'] = brdIsActive;
    _data['brd_sortid'] = brdSortid;
    return _data;
  }
}

@Entity(tableName: 'fiber_delivery_period')
class FiberDeliveryPeriod {
  FiberDeliveryPeriod({
    required this.dprId,
    required this.dprCategoryIdfk,
    required this.dprName,
    required this.dprIsActive,
    this.dprSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int dprId;
  late final String dprCategoryIdfk;
  late final String dprName;
  late final String dprIsActive;
  @ignore
  late final Null dprSortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  FiberDeliveryPeriod.fromJson(Map<String, dynamic> json){
    dprId = json['dpr_id'];
    dprCategoryIdfk = json['dpr_category_idfk'];
    dprName = json['dpr_name'];
    dprIsActive = json['dpr_is_active'];
    dprSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dpr_id'] = dprId;
    _data['dpr_category_idfk'] = dprCategoryIdfk;
    _data['dpr_name'] = dprName;
    _data['dpr_is_active'] = dprIsActive;
    _data['dpr_sortid'] = dprSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }
}

@Entity(tableName: 'fiber_units')
class FiberUnits {
  FiberUnits({
    required this.untId,
    required this.untCategoryIdfk,
    required this.untName,
    required this.untIsActive,
    this.untSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int untId;
  late final String untCategoryIdfk;
  late final String untName;
  late final String untIsActive;
  @ignore
  late final Null untSortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  FiberUnits.fromJson(Map<String, dynamic> json){
    untId = json['unt_id'];
    untCategoryIdfk = json['unt_category_idfk'];
    untName = json['unt_name'];
    untIsActive = json['unt_is_active'];
    untSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['unt_id'] = untId;
    _data['unt_category_idfk'] = untCategoryIdfk;
    _data['unt_name'] = untName;
    _data['unt_is_active'] = untIsActive;
    _data['unt_sortid'] = untSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
    return _data;
  }
}



@Entity(tableName: 'fiber_price_table')
class FiberPriceTerms {
  FiberPriceTerms({
    required this.ptrId,
    required this.ptrCategoryIdfk,
    this.ptrCountryIdfk,
    required this.ptrName,
    required this.ptrIsActive,
    this.ptrSortid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });
  @PrimaryKey(autoGenerate: false)
  late final int ptrId;
  late final String ptrCategoryIdfk;
  @ignore
  late final Null ptrCountryIdfk;
  late final String ptrName;
  late final String ptrIsActive;
  @ignore
  late final Null ptrSortid;
  @ignore
  late final Null createdAt;
  @ignore
  late final Null updatedAt;
  @ignore
  late final Null deletedAt;

  FiberPriceTerms.fromJson(Map<String, dynamic> json){
    ptrId = json['ptr_id'];
    ptrCategoryIdfk = json['ptr_category_idfk'];
    ptrCountryIdfk = null;
    ptrName = json['ptr_name'];
    ptrIsActive = json['ptr_is_active'];
    ptrSortid = null;
    createdAt = null;
    updatedAt = null;
    deletedAt = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ptr_id'] = ptrId;
    _data['ptr_category_idfk'] = ptrCategoryIdfk;
    _data['ptr_country_idfk'] = ptrCountryIdfk;
    _data['ptr_name'] = ptrName;
    _data['ptr_is_active'] = ptrIsActive;
    _data['ptr_sortid'] = ptrSortid;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['deleted_at'] = deletedAt;
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