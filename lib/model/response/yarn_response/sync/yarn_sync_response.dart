import 'package:floor/floor.dart';
import 'package:yg_app/helper_utils/util.dart';
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
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';

class YarnSyncResponse {
  YarnSyncResponse({
    required this.status,
    required this.responseCode,
    required this.data,
    required this.message,
  });

  bool? status;
  int? responseCode;
  late final YarnData data;
  String? message;

  YarnSyncResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['response_code'];
    data = YarnData.fromJson(json['data']);
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

class YarnData {
  YarnData({
    required this.yarn,
  });

  late final Yarn yarn;

  YarnData.fromJson(Map<String, dynamic> json) {
    yarn = Yarn.fromJson(json['yarn']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yarn'] = yarn.toJson();
    return _data;
  }
}

class Yarn {
  Yarn({
    required this.colorTreatmentMethod,
    required this.dyingMethod,
    required this.family,
    required this.orientation,
    required this.pattern,
    required this.patternCharectristic,
    required this.ply,
    required this.quality,
    required this.countries,
    required this.cityState,
    required this.ports,
    required this.lcTypes,
    required this.paymentTypes,
    required this.packing,
    required this.yarnTypes,
    required this.setting,
    required this.spunTechnique,
    required this.twistDirection,
    required this.usage,
    required this.blends,
    required this.grades,
    required this.coneType,
    required this.certification,
    required this.apperance,
    required this.doublingMethod,
    required this.priceTerms,
    required this.deliveryPeriod,
    required this.units,
    required this.companies,
    required this.brands,
  });

  List<ColorTreatmentMethod>? colorTreatmentMethod;
  List<DyingMethod>? dyingMethod;
  List<Family>? family;
  List<OrientationTable>? orientation;
  List<PatternModel>? pattern;
  List<PatternCharectristic>? patternCharectristic;
  List<Ply>? ply;
  List<Quality>? quality;
  List<Countries>? countries;
  List<CityState>? cityState;
  List<Ports>? ports;
  List<LcType>? lcTypes;
  List<PaymentType>? paymentTypes;
  List<Packing>? packing;
  List<YarnTypes>? yarnTypes;
  List<YarnSetting>? setting;
  List<SpunTechnique>? spunTechnique;
  List<TwistDirection>? twistDirection;
  List<Usage>? usage;
  List<Blends>? blends;
  List<YarnGrades>? grades;
  List<ConeType>? coneType;
  List<Certification>? certification;
  List<YarnAppearance>? apperance;
  List<DoublingMethod>? doublingMethod;
  List<FPriceTerms>? priceTerms;
  List<DeliveryPeriod>? deliveryPeriod;
  List<Units>? units;
  List<Companies>? companies;
  List<Brands>? brands;

  Yarn.fromJson(Map<String, dynamic> json) {
    colorTreatmentMethod = List.from(json['color_treatment_method'])
        .map((e) => ColorTreatmentMethod.fromJson(e))
        .toList();
    dyingMethod = List.from(json['dying_method'])
        .map((e) => DyingMethod.fromJson(e))
        .toList();
    family = List.from(json['family']).map((e) => Family.fromJson(e)).toList();
    orientation = List.from(json['orientation'])
        .map((e) => OrientationTable.fromJson(e))
        .toList();
    pattern =
        List.from(json['pattern']).map((e) => PatternModel.fromJson(e)).toList();
    patternCharectristic = List.from(json['pattern_charectristic'])
        .map((e) => PatternCharectristic.fromJson(e))
        .toList();
    ply = List.from(json['ply']).map((e) => Ply.fromJson(e)).toList();
    quality =
        List.from(json['quality']).map((e) => Quality.fromJson(e)).toList();
    countries =
        List.from(json['countries']).map((e) => Countries.fromJson(e)).toList();
    cityState = List.from(json['city_state'])
        .map((e) => CityState.fromJson(e))
        .toList();
    ports = List.from(json['ports']).map((e) => Ports.fromJson(e)).toList();
    lcTypes =
        List.from(json['lc_types']).map((e) => LcType.fromJson(e)).toList();
    paymentTypes = List.from(json['payment_types'])
        .map((e) => PaymentType.fromJson(e))
        .toList();
    packing =
        List.from(json['packing']).map((e) => Packing.fromJson(e)).toList();
    yarnTypes = List.from(json['yarn_types'])
        .map((e) => YarnTypes.fromJson(e))
        .toList();
    setting =
        List.from(json['setting']).map((e) => YarnSetting.fromJson(e)).toList();
    spunTechnique = List.from(json['spun_technique'])
        .map((e) => SpunTechnique.fromJson(e))
        .toList();
    twistDirection = List.from(json['twist_direction'])
        .map((e) => TwistDirection.fromJson(e))
        .toList();
    usage = List.from(json['usage']).map((e) => Usage.fromJson(e)).toList();
    blends = List.from(json['blends']).map((e) => Blends.fromJson(e)).toList();
    grades = List.from(json['grades']).map((e) => YarnGrades.fromJson(e)).toList();
    coneType =
        List.from(json['cone_type']).map((e) => ConeType.fromJson(e)).toList();
    certification = List.from(json['certification'])
        .map((e) => Certification.fromJson(e))
        .toList();
    apperance =
        List.from(json['apperance']).map((e) => YarnAppearance.fromJson(e)).toList();
    doublingMethod = List.from(json['doubling_method'])
        .map((e) => DoublingMethod.fromJson(e))
        .toList();
    priceTerms = List.from(json['price_terms'])
        .map((e) => FPriceTerms.fromJson(e))
        .toList();
    deliveryPeriod = List.from(json['delivery_period'])
        .map((e) => DeliveryPeriod.fromJson(e))
        .toList();
    units = List.from(json['units']).map((e) => Units.fromJson(e)).toList();
    companies =
        List.from(json['companies']).map((e) => Companies.fromJson(e)).toList();
    brands = List.from(json['brands']).map((e) => Brands.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['color_treatment_method'] =
        colorTreatmentMethod!.map((e) => e.toJson()).toList();
    _data['dying_method'] = dyingMethod!.map((e) => e.toJson()).toList();
    _data['family'] = family!.map((e) => e.toJson()).toList();
    _data['orientation'] = orientation!.map((e) => e.toJson()).toList();
    _data['pattern'] = pattern!.map((e) => e.toJson()).toList();
    _data['pattern_charectristic'] =
        patternCharectristic!.map((e) => e.toJson()).toList();
    _data['ply'] = ply!.map((e) => e.toJson()).toList();
    _data['quality'] = quality!.map((e) => e.toJson()).toList();
    _data['countries'] = countries!.map((e) => e.toJson()).toList();
    _data['city_state'] = cityState!.map((e) => e.toJson()).toList();
    _data['ports'] = ports!.map((e) => e.toJson()).toList();
    _data['lc_types'] = lcTypes!.map((e) => e.toJson()).toList();
    _data['payment_types'] = paymentTypes!.map((e) => e.toJson()).toList();
    _data['packing'] = packing!.map((e) => e.toJson()).toList();
    _data['yarn_types'] = yarnTypes!.map((e) => e.toJson()).toList();
    _data['setting'] = setting!.map((e) => e.toJson()).toList();
    _data['spun_technique'] = spunTechnique!.map((e) => e.toJson()).toList();
    _data['twist_direction'] = twistDirection!.map((e) => e.toJson()).toList();
    _data['usage'] = usage!.map((e) => e.toJson()).toList();
    _data['blends'] = blends!.map((e) => e.toJson()).toList();
    _data['grades'] = grades!.map((e) => e.toJson()).toList();
    _data['cone_type'] = coneType!.map((e) => e.toJson()).toList();
    _data['certification'] = certification!.map((e) => e.toJson()).toList();
    _data['apperance'] = apperance!.map((e) => e.toJson()).toList();
    _data['doubling_method'] = doublingMethod!.map((e) => e.toJson()).toList();
    _data['price_terms'] = priceTerms!.map((e) => e.toJson()).toList();
    _data['delivery_period'] = deliveryPeriod!.map((e) => e.toJson()).toList();
    _data['units'] = units!.map((e) => e.toJson()).toList();
    _data['companies'] = companies!.map((e) => e.toJson()).toList();
    _data['brands'] = brands!.map((e) => e.toJson()).toList();
    return _data;
  }
}

@Entity(tableName: "color_treatment_method")
class ColorTreatmentMethod {
  ColorTreatmentMethod({
    required this.yctmId,
    required this.familyId,
    required this.yctmName,
    required this.yctmColorMethodIdfk,
    this.yctmDescription,
    required this.yctmIsActive,
    this.yctmSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? yctmId;
  String? familyId;
  String? yctmName;
  String? yctmColorMethodIdfk;
  String? yctmDescription;
  String? yctmIsActive;
  String? yctmSortid;

  ColorTreatmentMethod.fromJson(Map<String, dynamic> json) {
    yctmId = json['yctm_id'];
    familyId = json['family_id'];
    yctmName = json['yctm_name'];
    yctmColorMethodIdfk = json['yctm_color_method_idfk'];
    yctmDescription = null;
    yctmIsActive = json['yctm_is_active'];
    yctmSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yctm_id'] = yctmId;
    _data['family_id'] = familyId;
    _data['yctm_name'] = yctmName;
    _data['yctm_color_method_idfk'] = yctmColorMethodIdfk;
    _data['yctm_description'] = yctmDescription;
    _data['yctm_is_active'] = yctmIsActive;
    _data['yctm_sortid'] = yctmSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return yctmName ?? "";
  }
}

@Entity(tableName: "dying_method")
class DyingMethod {
  DyingMethod({
    required this.ydmId,
    required this.apperanceId,
    required this.ydmName,
    required this.ydmType,
    required this.ydmColorTreatmentMethodIdfk,
    this.ydmDescription,
    required this.ydmIsActive,
    this.ydmSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? ydmId;
  String? apperanceId;
  String? ydmName;
  String? ydmType;
  String? ydmColorTreatmentMethodIdfk;
  String? ydmDescription;
  String? ydmIsActive;
  String? ydmSortid;

  DyingMethod.fromJson(Map<String, dynamic> json) {
    ydmId = json['ydm_id'];
    apperanceId = json['apperance_id'];
    ydmName = json['ydm_name'];
    ydmType = json['ydm_type'];
    ydmColorTreatmentMethodIdfk = json['ydm_color_treatment_method_idfk'];
    ydmDescription = null;
    ydmIsActive = json['ydm_is_active'];
    ydmSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ydm_id'] = ydmId;
    _data['apperance_id'] = apperanceId;
    _data['ydm_name'] = ydmName;
    _data['ydm_type'] = ydmType;
    _data['ydm_color_treatment_method_idfk'] = ydmColorTreatmentMethodIdfk;
    _data['ydm_description'] = ydmDescription;
    _data['ydm_is_active'] = ydmIsActive;
    _data['ydm_sortid'] = ydmSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return ydmName ?? "";
  }
}

@Entity(tableName: "yarn_family")
class Family {
  Family({
    required this.famId,
    required this.famName,
    required this.iconSelected,
    required this.iconUnSelected,
    required this.famType,
    required this.famDescription,
    required this.catIsActive,
    this.catSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? famId;
  String? famName;
  String? iconSelected;
  String? iconUnSelected;
  String? famType;
  String? famDescription;
  String? catIsActive;
  @ignore
  Null catSortid;

  Family.fromJson(Map<String, dynamic> json) {
    famId = json['fam_id'];
    famName = json['fam_name'];
    famType = json['fam_type'];
    iconSelected = json['icon_selected'];
    iconUnSelected = json['icon_unselected'];
    famDescription = json['fam_description'];
    catIsActive = json['cat_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fam_id'] = famId;
    _data['fam_name'] = famName;
    _data['icon_selected'] = iconSelected;
    _data['icon_unselected'] = iconUnSelected;
    _data['fam_type'] = famType;
    _data['fam_description'] = famDescription;
    _data['cat_is_active'] = catIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return famName ?? "";
  }
}

@Entity(tableName: "orientation_table")
class OrientationTable {
  OrientationTable({
    required this.yoId,
    required this.familyId,
    required this.yoName,
    this.yoDescription,
    required this.yoIsActive,
    this.catSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? yoId;
  String? familyId;
  String? yoName;
  String? yoDescription;
  String? yoIsActive;
  String? catSortid;

  OrientationTable.fromJson(Map<String, dynamic> json) {
    yoId = json['yo_id'];
    familyId = json['family_id'];
    yoName = json['yo_name'];
    yoDescription = null;
    yoIsActive = json['yo_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yo_id'] = yoId;
    _data['family_id'] = familyId;
    _data['yo_name'] = yoName;
    _data['yo_description'] = yoDescription;
    _data['yo_is_active'] = yoIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }

  @override
  String toString() {
    return yoName ?? "";
  }
}

@Entity(tableName: "pattern_table")
class PatternModel {
  PatternModel({
    required this.ypId,
    required this.familyId,
    required this.spun_technique_id,
    required this.ypName,
    this.ypDescription,
    required this.ypIsActive,
    this.catSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? ypId;
  String? familyId;
  String? ypName;
  String? spun_technique_id;
  String? ypDescription;
  String? ypIsActive;
  String? catSortid;

  PatternModel.fromJson(Map<String, dynamic> json) {
    ypId = json['yp_id'];
    familyId = json['family_id'];
    spun_technique_id = json['spun_technique_id'];
    ypName = json['yp_name'];
    ypDescription = null;
    ypIsActive = json['yp_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yp_id'] = ypId;
    _data['family_id'] = familyId;
    _data['spun_technique_id'] = spun_technique_id;
    _data['yp_name'] = ypName;
    _data['yp_description'] = ypDescription;
    _data['yp_is_active'] = ypIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return ypName ?? "";
  }
}

@Entity(tableName: "pattern_characteristics_table")
class PatternCharectristic {
  PatternCharectristic({
    required this.ypcId,
    required this.ypcName,
    required this.ypcPatternIdfk,
    required this.ypcDescription,
    required this.ypcIsActive,
    this.ypcSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? ypcId;
  String? ypcName;
  String? ypcPatternIdfk;
  String? ypcDescription;
  String? ypcIsActive;
  String? ypcSortid;

  PatternCharectristic.fromJson(Map<String, dynamic> json) {
    ypcId = json['ypc_id'];
    ypcName = json['ypc_name'];
    ypcPatternIdfk = json['ypc_pattern_idfk'];
    ypcDescription = json['ypc_description'];
    ypcIsActive = json['ypc_is_active'];
    ypcSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ypc_id'] = ypcId;
    _data['ypc_name'] = ypcName;
    _data['ypc_pattern_idfk'] = ypcPatternIdfk;
    _data['ypc_description'] = ypcDescription;
    _data['ypc_is_active'] = ypcIsActive;
    _data['ypc_sortid'] = ypcSortid;
    return _data;
  }

  @override
  String toString() {
    return ypcName ?? "";
  }
}

@Entity(tableName: "ply_table")
class Ply {
  Ply({
    required this.plyId,
    required this.familyId,
    required this.plyName,
    this.plyDescription,
    required this.catIsActive,
    this.catSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? plyId;
  String? familyId;
  String? plyName;
  String? plyDescription;
  String? catIsActive;
  String? catSortid;

  Ply.fromJson(Map<String, dynamic> json) {
    plyId = json['ply_id'];
    familyId = json['family_id'];
    plyName = json['ply_name'];
    plyDescription = null;
    catIsActive = json['cat_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ply_id'] = plyId;
    _data['family_id'] = familyId;
    _data['ply_name'] = plyName;
    _data['ply_description'] = plyDescription;
    _data['cat_is_active'] = catIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return plyName ?? "";
  }
}

@Entity(tableName: "quality_table")
class Quality {
  Quality({
    required this.yqId,
    required this.familyId,
    required this.yqName,
    required this.yqAbrv,
    required this.spun_technique_id,
    required this.yqBlendIdfk,
    this.yqDescription,
    required this.yqIsActive,
    this.yqSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? yqId;
  String? familyId;
  String? yqName;
  String? yqAbrv;
  String? spun_technique_id;
  String? yqBlendIdfk;
  String? yqDescription;
  String? yqIsActive;
  String? yqSortid;

  Quality.fromJson(Map<String, dynamic> json) {
    yqId = json['yq_id'];
    familyId = json['family_id'];
    spun_technique_id = json['spun_technique_id'];
    yqName = json['yq_name'];
    yqAbrv = json['yq_abrv'];
    yqBlendIdfk = json['yq_blend_idfk'];
    yqDescription = null;
    yqIsActive = json['yq_is_active'];
    yqSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yq_id'] = yqId;
    _data['family_id'] = familyId;
    _data['yq_name'] = yqName;
    _data['yq_abrv'] = yqAbrv;
    _data['spun_technique_id'] = spun_technique_id;
    _data['yq_blend_idfk'] = yqBlendIdfk;
    _data['yq_description'] = yqDescription;
    _data['yq_is_active'] = yqIsActive;
    _data['yq_sortid'] = yqSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return yqAbrv ?? yqName ?? "";
  }
}

@Entity(tableName: "yarn_types_table")
class YarnTypes {
  @PrimaryKey(autoGenerate: false)
  int? ytId;
  String? ytBlendIdfk;
  String? ytName;
  String? dannierRange;
  String? filamentRange;
  String? ytIsActive;
  String? ytSortid;

  YarnTypes(
      {this.ytId,
      this.ytBlendIdfk,
      this.ytName,
      this.dannierRange,
      this.filamentRange,
      this.ytIsActive,
      this.ytSortid});

  YarnTypes.fromJson(Map<String, dynamic> json) {
    ytId = json['yt_id'];
    ytBlendIdfk = json['yt_blend_idfk'];
    ytName = json['yt_name'];
    dannierRange = json['dannier_range'];
    filamentRange = json['filament_range'];
    ytIsActive = json['yt_is_active'];
    ytSortid = json['yt_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yt_id'] = this.ytId;
    data['yt_blend_idfk'] = this.ytBlendIdfk;
    data['yt_name'] = this.ytName;
    data['dannier_range'] = this.dannierRange;
    data['filament_range'] = this.filamentRange;
    data['yt_is_active'] = this.ytIsActive;
    data['yt_sortid'] = this.ytSortid;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return ytName??Utils.checkNullString(false);
  }
}

@Entity(tableName: 'yarn_settings')
class YarnSetting {
  @PrimaryKey(autoGenerate: false)
  int? ysId;
  String? ysBlendIdfk;
  String? ysFiberMaterialIdfk;
  String? showCount;
  String? countMinMax;
  String? showOrigin;
  String? showDannier;
  String? dannierMinMax;
  String? showFilament;
  String? filamentMinMax;
  String? showBlend;
  String? showPly;
  String? showSpunTechnique;
  String? showQuality;
  String? showGrade;
  String? showDoublingMethod;
  String? showCertification;
  String? showColorTreatmentMethod;
  String? showDyingMethod;
  String? showColor;
  String? showAppearance;
  String? showQlt;
  String? qltMinMax;
  String? showClsp;
  String? clspMinMax;
  String? showUniformity;
  String? uniformityMinMax;
  String? showCv;
  String? cvMinMax;
  String? showThinPlaces;
  String? thinPlacesMinMax;
  String? showtThickPlaces;
  String? thickPlacesMinMax;
  String? showNaps;
  String? napsMinMax;
  String? showIpmKm;
  String? ipmKmMinMax;
  String? showHairness;
  String? hairnessMinMax;
  String? showRkm;
  String? rkmMinMax;
  String? showElongation;
  String? elongationMinMax;
  String? showTpi;
  String? tpiMinMax;
  String? showTm;
  String? tmMinMax;
  String? showDty;
  String? dtyMinMax;
  String? showFdy;
  String? fdyMinMax;
  String? showRatio;
  String? showTexturized;
  String? showUsage;
  String? showPattern;
  String? showPatternCharectristic;
  String? showOrientation;
  String? showTwistDirection;
  String? ysIsActive;
  String? ysSortid;
  String? show_actual_count;
  String? actual_count_min_max;

  YarnSetting(
      {this.ysId,
      this.ysBlendIdfk,
      this.ysFiberMaterialIdfk,
      this.showCount,
      this.countMinMax,
      this.showOrigin,
      this.showDannier,
      this.dannierMinMax,
      this.showFilament,
      this.filamentMinMax,
      this.showBlend,
      this.showPly,
      this.showSpunTechnique,
      this.showQuality,
      this.showGrade,
      this.showDoublingMethod,
      this.showCertification,
      this.showColorTreatmentMethod,
      this.showDyingMethod,
      this.showColor,
      this.showAppearance,
      this.showQlt,
      this.qltMinMax,
      this.showClsp,
      this.clspMinMax,
      this.showUniformity,
      this.uniformityMinMax,
      this.showCv,
      this.cvMinMax,
      this.showThinPlaces,
      this.thinPlacesMinMax,
      this.showtThickPlaces,
      this.thickPlacesMinMax,
      this.showNaps,
      this.napsMinMax,
      this.showIpmKm,
      this.ipmKmMinMax,
      this.showHairness,
      this.hairnessMinMax,
      this.showRkm,
      this.rkmMinMax,
      this.showElongation,
      this.elongationMinMax,
      this.showTpi,
      this.tpiMinMax,
      this.showTm,
      this.tmMinMax,
      this.showDty,
      this.dtyMinMax,
      this.showFdy,
      this.fdyMinMax,
      this.showRatio,
      this.showTexturized,
      this.showUsage,
      this.showPattern,
      this.showPatternCharectristic,
      this.showOrientation,
      this.showTwistDirection,
      this.ysIsActive,
      this.ysSortid,
      this.show_actual_count,
      this.actual_count_min_max});

  YarnSetting.fromJson(Map<String, dynamic> json) {
    ysId = json['ys_id'];
    ysBlendIdfk = json['ys_blend_idfk'];
    ysFiberMaterialIdfk = json['ys_fiber_material_idfk'];
    showCount = json['show_count'];
    countMinMax = json['count_min_max'];
    showOrigin = json['show_origin'];
    showDannier = json['show_dannier'];
    dannierMinMax = json['dannier_min_max'];
    showFilament = json['show_filament'];
    filamentMinMax = json['filament_min_max'];
    showBlend = json['show_blend'];
    showPly = json['show_ply'];
    showSpunTechnique = json['show_spun_technique'];
    showQuality = json['show_quality'];
    showGrade = json['show_grade'];
    showDoublingMethod = json['show_doubling_method'];
    showCertification = json['show_certification'];
    showColorTreatmentMethod = json['show_color_treatment_method'];
    showDyingMethod = json['show_dying_method'];
    showColor = json['show_color'];
    showAppearance = json['show_appearance'];
    showQlt = json['show_qlt'];
    qltMinMax = json['qlt_min_max'];
    showClsp = json['show_clsp'];
    clspMinMax = json['clsp_min_max'];
    showUniformity = json['show_uniformity'];
    uniformityMinMax = json['uniformity_min_max'];
    showCv = json['show_cv'];
    cvMinMax = json['cv_min_max'];
    showThinPlaces = json['show_thin_places'];
    thinPlacesMinMax = json['thin_places_min_max'];
    showtThickPlaces = json['showt_thick_places'];
    thickPlacesMinMax = json['thick_places_min_max'];
    showNaps = json['show_naps'];
    napsMinMax = json['naps_min_max'];
    showIpmKm = json['show_ipm_km'];
    ipmKmMinMax = json['ipm_km_min_max'];
    showHairness = json['show_hairness'];
    hairnessMinMax = json['hairness_min_max'];
    showRkm = json['show_rkm'];
    rkmMinMax = json['rkm_min_max'];
    showElongation = json['show_elongation'];
    elongationMinMax = json['elongation_min_max'];
    showTpi = json['show_tpi'];
    tpiMinMax = json['tpi_min_max'];
    showTm = json['show_tm'];
    tmMinMax = json['tm_min_max'];
    showDty = json['show_dty'];
    dtyMinMax = json['dty_min_max'];
    showFdy = json['show_fdy'];
    fdyMinMax = json['fdy_min_max'];
    showRatio = json['show_ratio'];
    showTexturized = json['show_texturized'];
    showUsage = json['show_usage'];
    showPattern = json['show_pattern'];
    showPatternCharectristic = json['show_pattern_charectristic'];
    showOrientation = json['show_orientation'];
    showTwistDirection = json['show_twist_direction'];
    ysIsActive = json['ys_is_active'];
    ysSortid = json['ys_sortid'];
    show_actual_count = json['show_actual_count'];
    actual_count_min_max = json['actual_count_min_max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ys_id'] = this.ysId;
    data['ys_blend_idfk'] = this.ysBlendIdfk;
    data['ys_fiber_material_idfk'] = this.ysFiberMaterialIdfk;
    data['show_count'] = this.showCount;
    data['count_min_max'] = this.countMinMax;
    data['show_origin'] = this.showOrigin;
    data['show_dannier'] = this.showDannier;
    data['dannier_min_max'] = this.dannierMinMax;
    data['show_filament'] = this.showFilament;
    data['filament_min_max'] = this.filamentMinMax;
    data['show_blend'] = this.showBlend;
    data['show_ply'] = this.showPly;
    data['show_spun_technique'] = this.showSpunTechnique;
    data['show_quality'] = this.showQuality;
    data['show_grade'] = this.showGrade;
    data['show_doubling_method'] = this.showDoublingMethod;
    data['show_certification'] = this.showCertification;
    data['show_color_treatment_method'] = this.showColorTreatmentMethod;
    data['show_dying_method'] = this.showDyingMethod;
    data['show_color'] = this.showColor;
    data['show_appearance'] = this.showAppearance;
    data['show_qlt'] = this.showQlt;
    data['qlt_min_max'] = this.qltMinMax;
    data['show_clsp'] = this.showClsp;
    data['clsp_min_max'] = this.clspMinMax;
    data['show_uniformity'] = this.showUniformity;
    data['uniformity_min_max'] = this.uniformityMinMax;
    data['show_cv'] = this.showCv;
    data['cv_min_max'] = this.cvMinMax;
    data['show_thin_places'] = this.showThinPlaces;
    data['thin_places_min_max'] = this.thinPlacesMinMax;
    data['showt_thick_places'] = this.showtThickPlaces;
    data['thick_places_min_max'] = this.thickPlacesMinMax;
    data['show_naps'] = this.showNaps;
    data['naps_min_max'] = this.napsMinMax;
    data['show_ipm_km'] = this.showIpmKm;
    data['ipm_km_min_max'] = this.ipmKmMinMax;
    data['show_hairness'] = this.showHairness;
    data['hairness_min_max'] = this.hairnessMinMax;
    data['show_rkm'] = this.showRkm;
    data['rkm_min_max'] = this.rkmMinMax;
    data['show_elongation'] = this.showElongation;
    data['elongation_min_max'] = this.elongationMinMax;
    data['show_tpi'] = this.showTpi;
    data['tpi_min_max'] = this.tpiMinMax;
    data['show_tm'] = this.showTm;
    data['tm_min_max'] = this.tmMinMax;
    data['show_dty'] = this.showDty;
    data['dty_min_max'] = this.dtyMinMax;
    data['show_fdy'] = this.showFdy;
    data['fdy_min_max'] = this.fdyMinMax;
    data['show_ratio'] = this.showRatio;
    data['show_texturized'] = this.showTexturized;
    data['show_usage'] = this.showUsage;
    data['show_pattern'] = this.showPattern;
    data['show_pattern_charectristic'] = this.showPatternCharectristic;
    data['show_orientation'] = this.showOrientation;
    data['show_twist_direction'] = this.showTwistDirection;
    data['ys_is_active'] = this.ysIsActive;
    data['ys_sortid'] = this.ysSortid;
    data['show_actual_count'] = this.show_actual_count;
    data['actual_count_min_max'] = this.actual_count_min_max;
    return data;
  }
}

@Entity(tableName: "spun_technique")
class SpunTechnique {
  SpunTechnique({
    required this.ystId,
    required this.familyId,
    required this.orientationId,
    required this.ystName,
    required this.ystBlendIdfd,
    this.ystDescription,
    required this.ystIsActive,
    this.ystSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? ystId;
  String? familyId;
  String? orientationId;
  String? ystName;
  String? ystBlendIdfd;
  String? ystDescription;
  String? ystIsActive;
  String? ystSortid;

  SpunTechnique.fromJson(Map<String, dynamic> json) {
    ystId = json['yst_id'];
    familyId = json['family_id'];
    orientationId = json['orientation_id'];
    ystName = json['yst_name'];
    ystBlendIdfd = json['yst_blend_idfd'];
    ystDescription = null;
    ystIsActive = json['yst_is_active'];
    ystSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yst_id'] = ystId;
    _data['family_id'] = familyId;
    _data['orientation_id'] = orientationId;
    _data['yst_name'] = ystName;
    _data['yst_blend_idfd'] = ystBlendIdfd;
    _data['yst_description'] = ystDescription;
    _data['yst_is_active'] = ystIsActive;
    _data['yst_sortid'] = ystSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return ystName ?? "";
  }
}

@Entity(tableName: "twist_direction")
class TwistDirection {
  TwistDirection({
    required this.ytdId,
    required this.familyId,
    required this.ytdName,
    this.ytdDescription,
    required this.ytdIsActive,
    this.catSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? ytdId;
  String? familyId;
  String? ytdName;
  String? ytdDescription;
  String? ytdIsActive;
  String? catSortid;

  TwistDirection.fromJson(Map<String, dynamic> json) {
    ytdId = json['ytd_id'];
    familyId = json['family_id'];
    ytdName = json['ytd_name'];
    ytdDescription = null;
    ytdIsActive = json['ytd_is_active'];
    catSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ytd_id'] = ytdId;
    _data['family_id'] = familyId;
    _data['ytd_name'] = ytdName;
    _data['ytd_description'] = ytdDescription;
    _data['ytd_is_active'] = ytdIsActive;
    _data['cat_sortid'] = catSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return ytdName ?? "";
  }
}
@Entity(tableName: "usage_table")
class Usage {
  Usage({
    required this.yuId,
    required this.ysFamilyId,
    required this.yuName,
    this.yuDescription,
    required this.yuIsActive,
    this.yuSortid,
  });

  @PrimaryKey(autoGenerate: false)
  int? yuId;
  String? ysFamilyId;
  String? yuName;
  String? yuDescription;
  String? yuIsActive;
  String? yuSortid;
  // bool _isSelected = false;
  // bool get isSelected => _isSelected;
  // set isSelected(bool value) {
  //   _isSelected = value;
  // }

  Usage.fromJson(Map<String, dynamic> json) {
    yuId = json['yu_id'];
    ysFamilyId = json['ys_family_idfk'];
    yuName = json['yu_name'];
    yuDescription = null;
    yuIsActive = json['yu_is_active'];
    yuSortid = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['yu_id'] = yuId;
    _data['ys_family_id'] = ysFamilyId;
    _data['yu_name'] = yuName;
    _data['yu_description'] = yuDescription;
    _data['yu_is_active'] = yuIsActive;
    _data['yu_sortid'] = yuSortid;
    return _data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return yuName ?? "";
  }
}

@Entity(tableName: "yarn_blend")
class Blends {
  @PrimaryKey(autoGenerate: false)
  int? blnId;
  String? familyIdfk;
  String? blnName;
  String? bln_abrv;
  String? minMax;
  String? iconSelected;
  String? iconUnselected;
  String? blnIsActive;
  String? blnSortid;
  bool? isSelected = false;
  String? blendRatio = '';

  Blends(
      {this.blnId,
        this.familyIdfk,
        this.blnName,
        this.bln_abrv,
        this.minMax,
        this.iconSelected,
        this.iconUnselected,
        this.blnIsActive,
        this.isSelected,
        this.blendRatio,
        this.blnSortid});

  Blends.fromJson(Map<String, dynamic> json) {
    blnId = json['bln_id'];
    familyIdfk = json['family_idfk'];
    blnName = json['bln_name'];
    bln_abrv = json['bln_abrv'];
    minMax = json['min_max'];
    iconSelected = json['icon_selected'];
    iconUnselected = json['icon_unselected'];
    blnIsActive = json['bln_is_active'];
    blnSortid = json['bln_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bln_id'] = blnId;
    data['family_idfk'] = familyIdfk;
    data['bln_name'] = blnName;
    data['bln_abrv'] = bln_abrv;
    data['min_max'] = minMax;
    data['icon_selected'] = this.iconSelected;
    data['icon_unselected'] = this.iconUnselected;
    data['bln_is_active'] = this.blnIsActive;
    data['bln_sortid'] = this.blnSortid;
    return data;
  }
  @override
  String toString() {
    return bln_abrv != null ? bln_abrv.toString():blnName.toString();
  }
}

@Entity(tableName: "corn_type")
class ConeType {
  @PrimaryKey(autoGenerate: false)
  int? yctId;
  String? familyId;
  String? yctName;
  String? yctDescription;
  String? yctIsActive;
  String? yctSortid;

  ConeType(
      {this.yctId,
      this.familyId,
      this.yctName,
      this.yctDescription,
      this.yctIsActive,
      this.yctSortid});

  ConeType.fromJson(Map<String, dynamic> json) {
    yctId = json['yct_id'];
    familyId = json['family_id'];
    yctName = json['yct_name'];
    yctDescription = json['yct_description'];
    yctIsActive = json['yct_is_active'];
    yctSortid = json['yct_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['yct_id'] = yctId;
    data['family_id'] = familyId;
    data['yct_name'] = yctName;
    data['yct_description'] = yctDescription;
    data['yct_is_active'] = yctIsActive;
    data['yct_sortid'] = yctSortid;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return yctName?? "";
  }
}

// class Grades {
//   Grades({
//     required this.grdId,
//     required this.grdCategoryIdfk,
//     required this.grdName,
//     required this.grdIsActive,
//     this.grdSortid,
//   });
//    int grdId;
//    String grdCategoryIdfk;
//    String grdName;
//    String grdIsActive;
//    Null grdSortid;
//
//   Grades.fromJson(Map<String, dynamic> json){
//     grdId = json['grd_id'];
//     grdCategoryIdfk = json['grd_category_idfk'];
//     grdName = json['grd_name'];
//     grdIsActive = json['grd_is_active'];
//     grdSortid = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['grd_id'] = grdId;
//     _data['grd_category_idfk'] = grdCategoryIdfk;
//     _data['grd_name'] = grdName;
//     _data['grd_is_active'] = grdIsActive;
//     _data['grd_sortid'] = grdSortid;
//     return _data;
//   }
// }
//
// class Certification {
//   Certification({
//     required this.cerId,
//     required this.cerCategoryIdfk,
//     required this.cerName,
//     this.icon,
//     required this.cerIsActive,
//     this.cerSortid,
//     required this.pictures,
//     required this.attachFiles,
//   });
//    int cerId;
//    String cerCategoryIdfk;
//    String cerName;
//    Null icon;
//    String cerIsActive;
//    Null cerSortid;
//    List<dynamic> pictures;
//    List<dynamic> attachFiles;
//
//   Certification.fromJson(Map<String, dynamic> json){
//     cerId = json['cer_id'];
//     cerCategoryIdfk = json['cer_category_idfk'];
//     cerName = json['cer_name'];
//     icon = null;
//     cerIsActive = json['cer_is_active'];
//     cerSortid = null;
//     pictures = List.castFrom<dynamic, dynamic>(json['pictures']);
//     attachFiles = List.castFrom<dynamic, dynamic>(json['attach_files']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['cer_id'] = cerId;
//     _data['cer_category_idfk'] = cerCategoryIdfk;
//     _data['cer_name'] = cerName;
//     _data['icon'] = icon;
//     _data['cer_is_active'] = cerIsActive;
//     _data['cer_sortid'] = cerSortid;
//     _data['pictures'] = pictures;
//     _data['attach_files'] = attachFiles;
//     return _data;
//   }
// }
//
// class Apperance {
//   Apperance({
//     required this.aprId,
//     required this.aprCategoryIdfk,
//     required this.aprName,
//     required this.aprIsActive,
//     this.aprSortid,
//   });
//    int aprId;
//    String aprCategoryIdfk;
//    String aprName;
//    String aprIsActive;
//    Null aprSortid;
//
//   Apperance.fromJson(Map<String, dynamic> json){
//     aprId = json['apr_id'];
//     aprCategoryIdfk = json['apr_category_idfk'];
//     aprName = json['apr_name'];
//     aprIsActive = json['apr_is_active'];
//     aprSortid = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['apr_id'] = aprId;
//     _data['apr_category_idfk'] = aprCategoryIdfk;
//     _data['apr_name'] = aprName;
//     _data['apr_is_active'] = aprIsActive;
//     _data['apr_sortid'] = aprSortid;
//     return _data;
//   }
// }

// class PriceTerms {
//   PriceTerms({
//     required this.ptrId,
//     required this.ptrCategoryIdfk,
//     this.ptrCountryIdfk,
//     required this.ptrLocality,
//     required this.ptrName,
//     required this.ptrIsActive,
//     this.ptrSortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//    int ptrId;
//    String ptrCategoryIdfk;
//    Null ptrCountryIdfk;
//    String ptrLocality;
//    String ptrName;
//    String ptrIsActive;
//    Null ptrSortid;
//    Null createdAt;
//    Null updatedAt;
//    Null deletedAt;
//
//   PriceTerms.fromJson(Map<String, dynamic> json){
//     ptrId = json['ptr_id'];
//     ptrCategoryIdfk = json['ptr_category_idfk'];
//     ptrCountryIdfk = null;
//     ptrLocality = json['ptr_locality'];
//     ptrName = json['ptr_name'];
//     ptrIsActive = json['ptr_is_active'];
//     ptrSortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['ptr_id'] = ptrId;
//     _data['ptr_category_idfk'] = ptrCategoryIdfk;
//     _data['ptr_country_idfk'] = ptrCountryIdfk;
//     _data['ptr_locality'] = ptrLocality;
//     _data['ptr_name'] = ptrName;
//     _data['ptr_is_active'] = ptrIsActive;
//     _data['ptr_sortid'] = ptrSortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }
//
// class DeliveryPeriod {
//   DeliveryPeriod({
//     required this.dprId,
//     required this.dprCategoryIdfk,
//     required this.dprName,
//     required this.dprIsActive,
//     this.dprSortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//    int dprId;
//    String dprCategoryIdfk;
//    String dprName;
//    String dprIsActive;
//    Null dprSortid;
//    Null createdAt;
//    Null updatedAt;
//    Null deletedAt;
//
//   DeliveryPeriod.fromJson(Map<String, dynamic> json){
//     dprId = json['dpr_id'];
//     dprCategoryIdfk = json['dpr_category_idfk'];
//     dprName = json['dpr_name'];
//     dprIsActive = json['dpr_is_active'];
//     dprSortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['dpr_id'] = dprId;
//     _data['dpr_category_idfk'] = dprCategoryIdfk;
//     _data['dpr_name'] = dprName;
//     _data['dpr_is_active'] = dprIsActive;
//     _data['dpr_sortid'] = dprSortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }
//
// class Units {
//   Units({
//     required this.untId,
//     required this.untCategoryIdfk,
//     required this.untName,
//     required this.untIsActive,
//     this.untSortid,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//   });
//    int untId;
//    String untCategoryIdfk;
//    String untName;
//    String untIsActive;
//    Null untSortid;
//    Null createdAt;
//    Null updatedAt;
//    Null deletedAt;
//
//   Units.fromJson(Map<String, dynamic> json){
//     untId = json['unt_id'];
//     untCategoryIdfk = json['unt_category_idfk'];
//     untName = json['unt_name'];
//     untIsActive = json['unt_is_active'];
//     untSortid = null;
//     createdAt = null;
//     updatedAt = null;
//     deletedAt = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['unt_id'] = untId;
//     _data['unt_category_idfk'] = untCategoryIdfk;
//     _data['unt_name'] = untName;
//     _data['unt_is_active'] = untIsActive;
//     _data['unt_sortid'] = untSortid;
//     _data['created_at'] = createdAt;
//     _data['updated_at'] = updatedAt;
//     _data['deleted_at'] = deletedAt;
//     return _data;
//   }
// }

// class Companies {
//   Companies({
//     required this.id,
//     required this.name,
//     required this.gst,
//     this.logo,
//     this.tradeMark,
//     required this.address,
//     required this.countryId,
//     required this.cityStateId,
//     required this.zipCode,
//     required this.websiteUrl,
//     required this.whatsappNumber,
//     required this.wechatNumber,
//     required this.telephoneNumber,
//     required this.emailId,
//     required this.maxProduction,
//     required this.noOfUnits,
//     required this.yearEstablished,
//     required this.tradeCategory,
//     required this.licenseHolder,
//     this.icon,
//     required this.isVerified,
//     required this.rating,
//     required this.featured,
//     required this.pictures,
//     required this.attachFiles,
//   });
//
//   int? id;
//   String? name;
//   String? gst;
//   String? logo;
//   String? tradeMark;
//   String? address;
//   String? countryId;
//   String? cityStateId;
//   String? zipCode;
//   String? websiteUrl;
//   String? wechatNumber;
//   String? telephoneNumber;
//   String? whatsappNumber;
//   String? emailId;
//   String? maxProduction;
//   String? noOfUnits;
//   String? yearEstablished;
//   String? tradeCategory;
//   String? licenseHolder;
//   String? icon;
//   String? isVerified;
//   String? rating;
//   String? featured;
//   List<dynamic>? pictures;
//   List<dynamic>? attachFiles;
//
//   Companies.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     gst = json['gst'];
//     logo = null;
//     tradeMark = null;
//     address = json['address'];
//     countryId = json['country_id'];
//     cityStateId = json['city_state_id'];
//     zipCode = json['zip_code'];
//     websiteUrl = json['website_url'];
//     whatsappNumber = json['whatsapp_number'];
//     wechatNumber = json['wechat_number'];
//     telephoneNumber = json['telephone_number'];
//     emailId = json['email_id'];
//     maxProduction = json['max_production'];
//     noOfUnits = json['no_of_units'];
//     yearEstablished = json['year_established'];
//     tradeCategory = json['trade_category'];
//     licenseHolder = json['license_holder'];
//     icon = null;
//     isVerified = json['is_verified'];
//     rating = json['rating'];
//     featured = json['featured'];
//     pictures = List.castFrom<dynamic, dynamic>(json['pictures']);
//     attachFiles = List.castFrom<dynamic, dynamic>(json['attach_files']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['name'] = name;
//     _data['gst'] = gst;
//     _data['logo'] = logo;
//     _data['trade_mark'] = tradeMark;
//     _data['address'] = address;
//     _data['country_id'] = countryId;
//     _data['city_state_id'] = cityStateId;
//     _data['zip_code'] = zipCode;
//     _data['website_url'] = websiteUrl;
//     _data['whatsapp_number'] = whatsappNumber;
//     _data['wechat_number'] = wechatNumber;
//     _data['telephone_number'] = telephoneNumber;
//     _data['email_id'] = emailId;
//     _data['max_production'] = maxProduction;
//     _data['no_of_units'] = noOfUnits;
//     _data['year_established'] = yearEstablished;
//     _data['trade_category'] = tradeCategory;
//     _data['license_holder'] = licenseHolder;
//     _data['icon'] = icon;
//     _data['is_verified'] = isVerified;
//     _data['rating'] = rating;
//     _data['featured'] = featured;
//     _data['pictures'] = pictures;
//     _data['attach_files'] = attachFiles;
//     return _data;
//   }
// }

// class Brands {
//   Brands({
//     required this.brdId,
//     this.brdCategoryIdfk,
//     required this.brdName,
//     required this.brdIsVerified,
//     required this.brdRating,
//     required this.brdFeatured,
//     this.icon,
//     required this.brdIsActive,
//     this.brdSortid,
//   });
//    int brdId;
//    Null brdCategoryIdfk;
//    String brdName;
//    String brdIsVerified;
//    String brdRating;
//    String brdFeatured;
//    Null icon;
//    String brdIsActive;
//    Null brdSortid;
//
//   Brands.fromJson(Map<String, dynamic> json){
//     brdId = json['brd_id'];
//     brdCategoryIdfk = null;
//     brdName = json['brd_name'];
//     brdIsVerified = json['brd_is_verified'];
//     brdRating = json['brd_rating'];
//     brdFeatured = json['brd_featured'];
//     icon = null;
//     brdIsActive = json['brd_is_active'];
//     brdSortid = null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['brd_id'] = brdId;
//     _data['brd_category_idfk'] = brdCategoryIdfk;
//     _data['brd_name'] = brdName;
//     _data['brd_is_verified'] = brdIsVerified;
//     _data['brd_rating'] = brdRating;
//     _data['brd_featured'] = brdFeatured;
//     _data['icon'] = icon;
//     _data['brd_is_active'] = brdIsActive;
//     _data['brd_sortid'] = brdSortid;
//     return _data;
//   }
// }

@Entity(tableName: "doubling_method")
class DoublingMethod {
  @PrimaryKey(autoGenerate: false)
  int? dmId;
  String? plyId;
  String? dmName;
  String? catIsActive;
  String? catSortid;

  DoublingMethod(
      {this.dmId, this.plyId, this.dmName, this.catIsActive, this.catSortid});

  DoublingMethod.fromJson(Map<String, dynamic> json) {
    dmId = json['dm_id'];
    plyId = json['ply_id'];
    dmName = json['dm_name'];
    catIsActive = json['cat_is_active'];
    catSortid = json['cat_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dm_id'] = this.dmId;
    data['ply_id'] = this.plyId;
    data['dm_name'] = this.dmName;
    data['cat_is_active'] = this.catIsActive;
    data['cat_sortid'] = this.catSortid;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return dmName??Utils.checkNullString(false);
  }
}

@Entity(tableName: "yarn_appearance")
class YarnAppearance {
  @PrimaryKey(autoGenerate: false)
  int? yaId;
  String? familyId;
  String? usageId;
  String? yaName;
  String? yaIsActive;
  String? catSortid;

  YarnAppearance(
      {this.yaId,
        this.familyId,
        this.usageId,
        this.yaName,
        this.yaIsActive,
        this.catSortid});

  YarnAppearance.fromJson(Map<String, dynamic> json) {
    yaId = json['ya_id'];
    familyId = json['family_id'];
    usageId = json['usage_id'];
    yaName = json['ya_name'];
    yaIsActive = json['ya_is_active'];
    catSortid = json['cat_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ya_id'] = this.yaId;
    data['family_id'] = this.familyId;
    data['usage_id'] = this.usageId;
    data['ya_name'] = this.yaName;
    data['ya_is_active'] = this.yaIsActive;
    data['cat_sortid'] = this.catSortid;
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return yaName??Utils.checkNullString(false);
  }
}