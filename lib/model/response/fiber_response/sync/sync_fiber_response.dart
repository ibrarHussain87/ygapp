import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/companies_reponse.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/delievery_period.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/common_response_models/lc_type_response.dart';
import 'package:yg_app/model/response/common_response_models/packing_response.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';

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

  SyncFiberResponse.fromJson(Map<String, dynamic> json) {
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

  FiberSyncData.fromJson(Map<String, dynamic> json) {
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
    required this.fiberFamily,
    required this.fiberBlends,
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
  late final List<FiberFamily> fiberFamily;
  late final List<FiberBlends> fiberBlends;
  late final List<FiberAppearance> apperance;
  late final List<Countries> countries;
  late final List<Certification> certification;
  late final List<DeliveryPeriod> deliveryPeriod;
  late final List<Units> units;
  late final List<Brands> brands;
  late final List<Grades> grades;
  late final List<FPriceTerms> priceTerms;
  late final List<FiberAvailbleForMarket> availbleForMarket;
  late final List<Companies> companies;
  late final List<PaymentType> paymentType;
  late final List<CityState> cityState;
  late final List<Ports> ports;
  late final List<LcType> lcType;
  late final List<Packing> packing;
  late final List<FiberSettings> settings;

  FiberModel.fromJson(Map<String, dynamic> json) {
    categories = List.from(json['categories'])
        .map((e) => FiberCategories.fromJson(e))
        .toList();
    fiberFamily =
        List.from(json['family']).map((e) => FiberFamily.fromJson(e)).toList();
    fiberBlends =
        List.from(json['blends']).map((e) => FiberBlends.fromJson(e)).toList();
    apperance = List.from(json['apperance'])
        .map((e) => FiberAppearance.fromJson(e))
        .toList();
    brands = List.from(json['brands']).map((e) => Brands.fromJson(e)).toList();
    countries =
        List.from(json['countries']).map((e) => Countries.fromJson(e)).toList();
    certification = List.from(json['certification'])
        .map((e) => Certification.fromJson(e))
        .toList();
    deliveryPeriod = List.from(json['deliveryPeriod'])
        .map((e) => DeliveryPeriod.fromJson(e))
        .toList();
    units = List.from(json['units']).map((e) => Units.fromJson(e)).toList();
    grades = List.from(json['grades']).map((e) => Grades.fromJson(e)).toList();
    priceTerms = List.from(json['priceTerms'])
        .map((e) => FPriceTerms.fromJson(e))
        .toList();
    availbleForMarket = List.from(json['availbleForMarket'])
        .map((e) => FiberAvailbleForMarket.fromJson(e))
        .toList();
    companies =
        List.from(json['companies']).map((e) => Companies.fromJson(e)).toList();
    paymentType = List.from(json['payment_types'])
        .map((e) => PaymentType.fromJson(e))
        .toList();
    cityState = List.from(json['city_state'])
        .map((e) => CityState.fromJson(e))
        .toList();
    ports = List.from(json['ports']).map((e) => Ports.fromJson(e)).toList();
    lcType =
        List.from(json['lc_types']).map((e) => LcType.fromJson(e)).toList();
    packing =
        List.from(json['packing']).map((e) => Packing.fromJson(e)).toList();
    settings = List.from(json['setting'])
        .map((e) => FiberSettings.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categories'] = categories.map((e) => e.toJson()).toList();
    _data['material'] = fiberBlends.map((e) => e.toJson()).toList();
    _data['apperance'] = apperance.map((e) => e.toJson()).toList();
    _data['brands'] = brands.map((e) => e.toJson()).toList();
    _data['countries'] = countries.map((e) => e.toJson()).toList();
    _data['certification'] = certification.map((e) => e.toJson()).toList();
    _data['deliveryPeriod'] = deliveryPeriod.map((e) => e.toJson()).toList();
    _data['units'] = units.map((e) => e.toJson()).toList();
    _data['brands'] = units.map((e) => e.toJson()).toList();
    _data['grades'] = grades.map((e) => e.toJson()).toList();
    _data['priceTerms'] = priceTerms.map((e) => e.toJson()).toList();
    _data['availbleForMarket'] =
        availbleForMarket.map((e) => e.toJson()).toList();
    _data['companies'] = companies.map((e) => e.toJson()).toList();
    _data['payment_types'] = paymentType.map((e) => e.toJson()).toList();
    _data['city_state'] = cityState.map((e) => e.toJson()).toList();
    _data['ports'] = ports.map((e) => e.toJson()).toList();
    _data['lc_types'] = lcType.map((e) => e.toJson()).toList();
    _data['packing'] = packing.map((e) => e.toJson()).toList();
    _data['settings'] = settings.map((e) => e.toJson()).toList();
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

  FiberCategories.fromJson(Map<String, dynamic> json) {
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

@Entity(tableName: 'fiber_family')
class FiberFamily {
  FiberFamily({
    required this.fiberFamilyId,
    required this.fiberFamilyCategoryIdFk,
    required this.fiberFamilyParentId,
    required this.fiberFamilyName,
    required this.iconSelected,
    required this.iconUnselected,
    required this.fiberFamilyIsActive,
    required this.fiberFamilySortId,
  });

  @PrimaryKey(autoGenerate: false)
  late final int fiberFamilyId;
  String? fiberFamilyCategoryIdFk;
  String? fiberFamilyParentId;
  String? fiberFamilyName;
  String? iconSelected;
  String? iconUnselected;
  String? fiberFamilyIsActive;
  String? fiberFamilySortId;

  FiberFamily.fromJson(Map<String, dynamic> json) {
    fiberFamilyId = json['fiber_family_id'];
    fiberFamilyCategoryIdFk = json['fiber_family_category_idfk'];
    fiberFamilyParentId = json['fiber_family_parent_id'];
    fiberFamilyName = json['fiber_family_name'];
    iconSelected = json['icon_selected'];
    iconUnselected = json['icon_unselected'];
    fiberFamilyIsActive = json['fiber_family_is_active'];
    fiberFamilySortId = json['fiber_family_sortid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fiber_family_id'] = fiberFamilyId;
    _data['fiber_family_category_idfk'] = fiberFamilyCategoryIdFk;
    _data['fiber_family_parent_id'] = fiberFamilyParentId;
    _data['fiber_family_name'] = fiberFamilyName;
    _data['icon_selected'] = iconSelected;
    _data['icon_unselected'] = iconUnselected;
    _data['fiber_family_is_active'] = fiberFamilyIsActive;
    _data['fiber_family_sortid'] = fiberFamilySortId;

    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return fiberFamilyName ?? "";
  }
}

@Entity(tableName: 'fiber_blends')
class FiberBlends {
  @PrimaryKey(autoGenerate: false)
  int? blnId;
  String? blnCategoryIdfk;
  String? familyIdfk;
  String? blnNature;
  String? blnName;
  String? blnAbrv;
  String? minMax;
  String? blnRatioJson;
  String? iconSelected;
  String? iconUnselected;
  String? blnIsActive;
  String? blnSortid;

  FiberBlends(
      {this.blnId,
      this.blnCategoryIdfk,
      this.familyIdfk,
      this.blnNature,
      this.blnName,
      this.blnAbrv,
      this.minMax,
      this.blnRatioJson,
      this.iconSelected,
      this.iconUnselected,
      this.blnIsActive,
      this.blnSortid});

  FiberBlends.fromJson(Map<String, dynamic> json) {
    blnId = json['bln_id'];
    blnCategoryIdfk = json['bln_category_idfk'];
    familyIdfk = json['family_idfk'];
    blnNature = json['bln_nature'];
    blnName = json['bln_name'];
    blnAbrv = json['bln_abrv'];
    minMax = json['min_max'];
    blnRatioJson = json['bln_ratio_json'];
    iconSelected = json['icon_selected'];
    iconUnselected = json['icon_unselected'];
    blnIsActive = json['bln_is_active'];
    blnSortid = json['bln_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bln_id'] = this.blnId;
    data['bln_category_idfk'] = this.blnCategoryIdfk;
    data['family_idfk'] = this.familyIdfk;
    data['bln_nature'] = this.blnNature;
    data['bln_name'] = this.blnName;
    data['bln_abrv'] = this.blnAbrv;
    data['min_max'] = this.minMax;
    data['bln_ratio_json'] = this.blnRatioJson;
    data['icon_selected'] = this.iconSelected;
    data['icon_unselected'] = this.iconUnselected;
    data['bln_is_active'] = this.blnIsActive;
    data['bln_sortid'] = this.blnSortid;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return blnAbrv ?? blnName ?? "";
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

  FiberAvailbleForMarket.fromJson(Map<String, dynamic> json) {
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
    this.fbsId,
    this.fbsCategoryIdfk,
    this.fbsFiberFamilyIdfk,
    this.fbsBlendIdfk,
    this.showLength,
    this.lengthMinMax,
    this.showGrade,
    this.showMicronaire,
    this.micMinMax,
    this.showMoisture,
    this.moiMinMax,
    this.showTrash,
    this.trashMinMax,
    this.showRd,
    this.rdMinMax,
    this.showGpt,
    this.gptMinMax,
    this.showAppearance,
    this.showColorTreatmentMethod,
    this.showBrand,
    this.showProductionYear,
    this.showOrigin,
    this.showCertification,
    this.showCountUnit,
    this.showDeliveryPeriod,
    this.showAvailableForMarket,
    this.showPriceTerms,
    this.showLotNumber,
    this.showRatio,
    this.fbsIsActive,
    this.fbsSortid,
    // required this.catName,
    // required this.matName,
  });

  @PrimaryKey(autoGenerate: false)
  int? fbsId;
  String? fbsCategoryIdfk;
  String? fbsFiberFamilyIdfk;
  String? fbsBlendIdfk;
  String? showLength;
  String? lengthMinMax;
  String? showGrade;
  String? showMicronaire;
  String? micMinMax;
  String? showMoisture;
  String? moiMinMax;
  String? showTrash;
  String? trashMinMax;
  String? showRd;
  String? rdMinMax;
  String? showGpt;
  String? gptMinMax;
  String? showAppearance;
  String? showColorTreatmentMethod;
  String? showBrand;
  String? showProductionYear;
  String? showOrigin;
  String? showCertification;
  String? showCountUnit;
  String? showDeliveryPeriod;
  String? showAvailableForMarket;
  String? showPriceTerms;
  String? showLotNumber;
  String? showRatio;
  String? fbsIsActive;
  @ignore
  String? fbsSortid;

  // late final String catName;
  // late final String matName;

  FiberSettings.fromJson(Map<String, dynamic> json) {
    fbsId = json['fbs_id'];
    fbsCategoryIdfk = json['fbs_category_idfk'];
    fbsFiberFamilyIdfk = json['fbs_fiber_family_idfk'];
    fbsBlendIdfk = json['fbs_blend_idfk'];
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
    showColorTreatmentMethod = json['show_color_treatment_method'];
    showBrand = json['show_brand'];
    showProductionYear = json['show_production_year'];
    showOrigin = json['show_origin'];
    showCertification = json['show_certification'];
    showCountUnit = json['show_count_unit'];
    showDeliveryPeriod = json['show_delivery_period'];
    showAvailableForMarket = json['show_available_for_market'];
    showPriceTerms = json['show_price_terms'];
    showLotNumber = json['show_lot_number'];
    showRatio = json['show_ratio'];
    fbsIsActive = json['fbs_is_active'];
    fbsSortid = null;
    // catName = json['cat_name'];
    // matName = json['mat_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fbs_id'] = fbsId;
    _data['fbs_category_idfk'] = fbsCategoryIdfk;
    _data['fbs_fiber_family_idfk'] = fbsFiberFamilyIdfk;
    _data['fbs_blend_idfk'] = fbsBlendIdfk;
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
    _data['show_color_treatment_method'] = showColorTreatmentMethod;
    _data['show_brand'] = showBrand;
    _data['show_production_year'] = showProductionYear;
    _data['show_origin'] = showOrigin;
    _data['show_certification'] = showCertification;
    _data['show_count_unit'] = showCountUnit;
    _data['show_delivery_period'] = showDeliveryPeriod;
    _data['show_available_for_market'] = showAvailableForMarket;
    _data['show_price_terms'] = showPriceTerms;
    _data['show_lot_number'] = showLotNumber;
    _data['show_ratio'] = showRatio;
    _data['fbs_is_active'] = fbsIsActive;
    _data['fbs_sortid'] = fbsSortid;
    // _data['cat_name'] = catName;
    // _data['mat_name'] = matName;
    return _data;
  }
}
