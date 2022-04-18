import 'package:floor/floor.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';

import '../../common_response_models/brands_response.dart';
import '../../common_response_models/city_state_response.dart';
import '../../common_response_models/companies_reponse.dart';
import '../../common_response_models/countries_response.dart';
import '../../common_response_models/delievery_period.dart';
import '../../common_response_models/ports_response.dart';
import '../../common_response_models/unit_of_count.dart';

class FabricSyncResponse {
  bool? status;
  String? message;
  Data? data;
  int? responseCode;
  int? code;

  FabricSyncResponse(
      {this.status, this.message, this.data, this.responseCode, this.code});

  FabricSyncResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    responseCode = json['response_code'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['response_code'] = responseCode;
    data['code'] = code;
    return data;
  }
}

class Data {
  Fabric? fabric;

  Data({this.fabric});

  Data.fromJson(Map<String, dynamic> json) {
    fabric =
    json['fabric'] != null ? Fabric.fromJson(json['fabric']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (fabric != null) {
      data['fabric'] = fabric!.toJson();
    }
    return data;
  }
}

class Fabric {
  List<FabricSetting>? setting;
  List<FabricFamily>? family;
  List<FabricBlends>? blends;
  List<Countries>? countries;
  List<CityState>? cityState;
  List<Ports>? ports;
  List<PaymentType>? paymentTypes;
  List<FabricAppearance>? appearance;
  List<KnittingTypes>? knittingTypes;
  List<FabricPly>? ply;
  List<FabricColorTreatmentMethod>? colorTreatmentMethod;
  List<FabricDyingTechniques>? dyingTechniques;
  List<FabricQuality>? quality;
  List<FabricGrades>? grades;
  List<FabricLoom>? loom;
  List<FabricSalvedge>? salvedge;
  List<FabricWeave>? weave;
  List<FabricLayyer>? layyer;
  List<FPriceTerms>? priceTerms;
  List<DeliveryPeriod>? deliveryPeriod;
  List<Units>? units;
  List<Companies>? companies;
  List<Brands>? brands;
  List<Certification>? certification;

  Fabric(
      {this.setting,
        this.family,
        this.blends,
        this.countries,
        this.cityState,
        this.ports,
        this.paymentTypes,
        this.appearance,
        this.knittingTypes,
        this.ply,
        this.colorTreatmentMethod,
        this.dyingTechniques,
        this.quality,
        this.grades,
        this.loom,
        this.salvedge,
        this.weave,
        this.layyer,
        this.priceTerms,
        this.deliveryPeriod,
        this.units,
        this.companies,
        this.brands,
        this.certification});

  Fabric.fromJson(Map<String, dynamic> json) {
    if (json['setting'] != null) {
      setting = <FabricSetting>[];
      json['setting'].forEach((v) {
        setting!.add(FabricSetting.fromJson(v));
      });
    }
    if (json['family'] != null) {
      family = <FabricFamily>[];
      json['family'].forEach((v) {
        family!.add(FabricFamily.fromJson(v));
      });
    }
    if (json['blends'] != null) {
      blends = <FabricBlends>[];
      json['blends'].forEach((v) {
        blends!.add(FabricBlends.fromJson(v));
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
    if (json['appearance'] != null) {
      appearance = <FabricAppearance>[];
      json['appearance'].forEach((v) {
        appearance!.add(FabricAppearance.fromJson(v));
      });
    }
    if (json['knitting_types'] != null) {
      knittingTypes = <KnittingTypes>[];
      json['knitting_types'].forEach((v) {
        knittingTypes!.add(KnittingTypes.fromJson(v));
      });
    }
    if (json['ply'] != null) {
      ply = <FabricPly>[];
      json['ply'].forEach((v) {
        ply!.add(FabricPly.fromJson(v));
      });
    }
    if (json['color_treatment_method'] != null) {
      colorTreatmentMethod = <FabricColorTreatmentMethod>[];
      json['color_treatment_method'].forEach((v) {
        colorTreatmentMethod!.add(FabricColorTreatmentMethod.fromJson(v));
      });
    }
    if (json['dying_techniques'] != null) {
      dyingTechniques = <FabricDyingTechniques>[];
      json['dying_techniques'].forEach((v) {
        dyingTechniques!.add(FabricDyingTechniques.fromJson(v));
      });
    }
    if (json['quality'] != null) {
      quality = <FabricQuality>[];
      json['quality'].forEach((v) {
        quality!.add(FabricQuality.fromJson(v));
      });
    }
    if (json['grades'] != null) {
      grades = <FabricGrades>[];
      json['grades'].forEach((v) {
        grades!.add(FabricGrades.fromJson(v));
      });
    }
    if (json['loom'] != null) {
      loom = <FabricLoom>[];
      json['loom'].forEach((v) {
        loom!.add(FabricLoom.fromJson(v));
      });
    }
    if (json['salvedge'] != null) {
      salvedge = <FabricSalvedge>[];
      json['salvedge'].forEach((v) {
        salvedge!.add(FabricSalvedge.fromJson(v));
      });
    }
    if (json['weave'] != null) {
      weave = <FabricWeave>[];
      json['weave'].forEach((v) {
        weave!.add(FabricWeave.fromJson(v));
      });
    }
    if (json['layyer'] != null) {
      layyer = <FabricLayyer>[];
      json['layyer'].forEach((v) {
        layyer!.add(FabricLayyer.fromJson(v));
      });
    }
    if (json['price_terms'] != null) {
      priceTerms = <FPriceTerms>[];
      json['price_terms'].forEach((v) {
        priceTerms!.add(FPriceTerms.fromJson(v));
      });
    }
    if (json['delivery_period'] != null) {
      deliveryPeriod = <DeliveryPeriod>[];
      if(json['delivery_period'] is List) {
        json['delivery_period'].forEach((v) {
          deliveryPeriod!.add(DeliveryPeriod.fromJson(v));
        });
      }
    }
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(Units.fromJson(v));
      });
    }
    if (json['companies'] != null) {
      companies = <Companies>[];
      json['companies'].forEach((v) {
        companies!.add(Companies.fromJson(v));
      });
    }
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
    if (json['certification'] != null) {
      certification = <Certification>[];
      json['certification'].forEach((v) {
        certification!.add(Certification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (setting != null) {
      data['setting'] = setting!.map((v) => v.toJson()).toList();
    }
    if (family != null) {
      data['family'] = family!.map((v) => v.toJson()).toList();
    }
    if (blends != null) {
      data['blends'] = blends!.map((v) => v.toJson()).toList();
    }
    if (countries != null) {
      data['countries'] = countries!.map((v) => v.toJson()).toList();
    }
    if (cityState != null) {
      data['city_state'] = cityState!.map((v) => v.toJson()).toList();
    }
    if (ports != null) {
      data['ports'] = ports!.map((v) => v.toJson()).toList();
    }
    if (paymentTypes != null) {
      data['payment_types'] =
          paymentTypes!.map((v) => v.toJson()).toList();
    }
    if (appearance != null) {
      data['appearance'] = appearance!.map((v) => v.toJson()).toList();
    }
    if (knittingTypes != null) {
      data['knitting_types'] =
          knittingTypes!.map((v) => v.toJson()).toList();
    }
    if (ply != null) {
      data['ply'] = ply!.map((v) => v.toJson()).toList();
    }
    if (colorTreatmentMethod != null) {
      data['color_treatment_method'] =
          colorTreatmentMethod!.map((v) => v.toJson()).toList();
    }
    if (dyingTechniques != null) {
      data['dying_techniques'] =
          dyingTechniques!.map((v) => v.toJson()).toList();
    }
    if (quality != null) {
      data['quality'] = quality!.map((v) => v.toJson()).toList();
    }
    if (grades != null) {
      data['grades'] = grades!.map((v) => v.toJson()).toList();
    }
    if (loom != null) {
      data['loom'] = loom!.map((v) => v.toJson()).toList();
    }
    if (salvedge != null) {
      data['salvedge'] = salvedge!.map((v) => v.toJson()).toList();
    }
    if (weave != null) {
      data['weave'] = weave!.map((v) => v.toJson()).toList();
    }
    if (layyer != null) {
      data['layyer'] = layyer!.map((v) => v.toJson()).toList();
    }
    if (priceTerms != null) {
      data['price_terms'] = priceTerms!.map((v) => v.toJson()).toList();
    }
    if (deliveryPeriod != null) {
      data['delivery_period'] =
          deliveryPeriod!.map((v) => v.toJson()).toList();
    }
    if (units != null) {
      data['units'] = units!.map((v) => v.toJson()).toList();
    }
    if (companies != null) {
      data['companies'] = companies!.map((v) => v.toJson()).toList();
    }
    if (brands != null) {
      data['brands'] = brands!.map((v) => v.toJson()).toList();
    }
    if (certification != null) {
      data['certification'] =
          certification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@Entity(tableName: 'fabric_settings')
class FabricSetting {
  @PrimaryKey(autoGenerate: false)
  int? fabricSettingId;
  String? fabricFamilyIdfk;
  String? showCount;
  String? countMinMax;
  String? showPly;
  String? showBlend;
  String? showGsm;
  String? gsmCountMinMax;
  String? showRatio;
  String? showKnittingType;
  String? showAppearance;
  String? showColorTreatmentMethod;
  String? showDyingMethod;
  String? showColor;
  String? showQuality;
  String? showGrade;
  String? showCertification;
  String? showWarpCount;
  String? warpCountMinMax;
  String? showWarpPly;
  String? showNoOfEndsWarp;
  String? noOfEndsWarpMinMax;
  String? showWeftCount;
  String? weftCountMinMax;
  String? showWeftPly;
  String? showNoOfPickWeft;
  String? noOfPickWeftMinMax;
  String? showWidth;
  String? widthMinMax;
  String? showWeave;
  String? showLoom;
  String? showSalvedge;
  String? showTuckinWidth;
  String? showTuckinWidthMinMax;
  String? showOnce;
  String? onceMinMax;
  String? showLayyer;
  String? fabricSettingIsActive;
  String? fabricSettingSortid;

  FabricSetting(
      {this.fabricSettingId,
        this.fabricFamilyIdfk,
        this.showCount,
        this.countMinMax,
        this.showPly,
        this.showBlend,
        this.showGsm,
        this.gsmCountMinMax,
        this.showRatio,
        this.showKnittingType,
        this.showAppearance,
        this.showColorTreatmentMethod,
        this.showDyingMethod,
        this.showColor,
        this.showQuality,
        this.showGrade,
        this.showCertification,
        this.showWarpCount,
        this.warpCountMinMax,
        this.showWarpPly,
        this.showNoOfEndsWarp,
        this.noOfEndsWarpMinMax,
        this.showWeftCount,
        this.weftCountMinMax,
        this.showWeftPly,
        this.showNoOfPickWeft,
        this.noOfPickWeftMinMax,
        this.showWidth,
        this.widthMinMax,
        this.showWeave,
        this.showLoom,
        this.showSalvedge,
        this.showTuckinWidth,
        this.showTuckinWidthMinMax,
        this.showOnce,
        this.onceMinMax,
        this.showLayyer,
        this.fabricSettingIsActive,
        this.fabricSettingSortid});

  FabricSetting.fromJson(Map<String, dynamic> json) {
    fabricSettingId = json['fabric_setting_id'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
    showCount = json['show_count'];
    countMinMax = json['count_min_max'];
    showPly = json['show_ply'];
    showBlend = json['show_blend'];
    showGsm = json['show_gsm'];
    gsmCountMinMax = json['gsm_count_min_max'];
    showRatio = json['show_ratio'];
    showKnittingType = json['show_knitting_type'];
    showAppearance = json['show_appearance'];
    showColorTreatmentMethod = json['show_color_treatment_method'];
    showDyingMethod = json['show_dying_method'];
    showColor = json['show_color'];
    showQuality = json['show_quality'];
    showGrade = json['show_grade'];
    showCertification = json['show_certification'];
    showWarpCount = json['show_warp_count'];
    warpCountMinMax = json['warp_count_min_max'];
    showWarpPly = json['show_warp_ply'];
    showNoOfEndsWarp = json['show_no_of_ends_warp'];
    noOfEndsWarpMinMax = json['no_of_ends_warp_min_max'];
    showWeftCount = json['show_weft_count'];
    weftCountMinMax = json['weft_count_min_max'];
    showWeftPly = json['show_weft_ply'];
    showNoOfPickWeft = json['show_no_of_pick_weft'];
    noOfPickWeftMinMax = json['no_of_pick_weft_min_max'];
    showWidth = json['show_width'];
    widthMinMax = json['width_min_max'];
    showWeave = json['show_weave'];
    showLoom = json['show_loom'];
    showSalvedge = json['show_salvedge'];
    showTuckinWidth = json['show_tuckin_width'];
    showTuckinWidthMinMax = json['show_tuckin_width_min_max'];
    showOnce = json['show_once'];
    onceMinMax = json['once_min_max'];
    showLayyer = json['show_layyer'];
    fabricSettingIsActive = json['fabric_setting_is_active'];
    fabricSettingSortid = json['fabric_setting_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_setting_id'] = fabricSettingId;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    data['show_count'] = showCount;
    data['count_min_max'] = countMinMax;
    data['show_ply'] = showPly;
    data['show_blend'] = showBlend;
    data['show_gsm'] = showGsm;
    data['gsm_count_min_max'] = gsmCountMinMax;
    data['show_ratio'] = showRatio;
    data['show_knitting_type'] = showKnittingType;
    data['show_appearance'] = showAppearance;
    data['show_color_treatment_method'] = showColorTreatmentMethod;
    data['show_dying_method'] = showDyingMethod;
    data['show_color'] = showColor;
    data['show_quality'] = showQuality;
    data['show_grade'] = showGrade;
    data['show_certification'] = showCertification;
    data['show_warp_count'] = showWarpCount;
    data['warp_count_min_max'] = warpCountMinMax;
    data['show_warp_ply'] = showWarpPly;
    data['show_no_of_ends_warp'] = showNoOfEndsWarp;
    data['no_of_ends_warp_min_max'] = noOfEndsWarpMinMax;
    data['show_weft_count'] = showWeftCount;
    data['weft_count_min_max'] = weftCountMinMax;
    data['show_weft_ply'] = showWeftPly;
    data['show_no_of_pick_weft'] = showNoOfPickWeft;
    data['no_of_pick_weft_min_max'] = noOfPickWeftMinMax;
    data['show_width'] = showWidth;
    data['width_min_max'] = widthMinMax;
    data['show_weave'] = showWeave;
    data['show_loom'] = showLoom;
    data['show_salvedge'] = showSalvedge;
    data['show_tuckin_width'] = showTuckinWidth;
    data['show_tuckin_width_min_max'] = showTuckinWidthMinMax;
    data['show_once'] = showOnce;
    data['once_min_max'] = onceMinMax;
    data['show_layyer'] = showLayyer;
    data['fabric_setting_is_active'] = fabricSettingIsActive;
    data['fabric_setting_sortid'] = fabricSettingSortid;
    return data;
  }
}

@Entity(tableName: 'fabric_family')
class FabricFamily {
  @PrimaryKey(autoGenerate: false)
  int? fabricFamilyId;
  String? fabricFamilyName;
  String? iconSelected;
  String? iconUnselected;
  String? fabricFamilyType;
  String? fabricFamilyDescription;
  String? fabricFamilyActive;
  String? fabricFamilySortid;

  FabricFamily(
      {this.fabricFamilyId,
        this.fabricFamilyName,
        this.iconSelected,
        this.iconUnselected,
        this.fabricFamilyType,
        this.fabricFamilyDescription,
        this.fabricFamilyActive,
        this.fabricFamilySortid});

  FabricFamily.fromJson(Map<String, dynamic> json) {
    fabricFamilyId = json['fabric_family_id'];
    fabricFamilyName = json['fabric_family_name'];
    iconSelected = json['icon_selected'];
    iconUnselected = json['icon_unselected'];
    fabricFamilyType = json['fabric_family_type'];
    fabricFamilyDescription = json['fabric_family_description'];
    fabricFamilyActive = json['fabric_family_active'];
    fabricFamilySortid = json['fabric_family_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_family_id'] = fabricFamilyId;
    data['fabric_family_name'] = fabricFamilyName;
    data['icon_selected'] = iconSelected;
    data['icon_unselected'] = iconUnselected;
    data['fabric_family_type'] = fabricFamilyType;
    data['fabric_family_description'] = fabricFamilyDescription;
    data['fabric_family_active'] = fabricFamilyActive;
    data['fabric_family_sortid'] = fabricFamilySortid;
    return data;
  }
}

@Entity(tableName: 'fabric_blends')
class FabricBlends {
  @PrimaryKey(autoGenerate: false)
  int? blnId;
  String? blnCategoryIdfk;
  String? familyIdfk;
  String? blnName;
  String? blnAbrv;
  String? minMax;
  String? iconSelected;
  String? iconUnselected;
  String? blnIsActive;
  String? blnSortid;

  FabricBlends(
      {this.blnId,
        this.blnCategoryIdfk,
        this.familyIdfk,
        this.blnName,
        this.blnAbrv,
        this.minMax,
        this.iconSelected,
        this.iconUnselected,
        this.blnIsActive,
        this.blnSortid});

  FabricBlends.fromJson(Map<String, dynamic> json) {
    blnId = json['bln_id'];
    blnCategoryIdfk = json['bln_category_idfk'];
    familyIdfk = json['family_idfk'];
    blnName = json['bln_name'];
    blnAbrv = json['bln_abrv'];
    minMax = json['min_max'];
    iconSelected = json['icon_selected'];
    iconUnselected = json['icon_unselected'];
    blnIsActive = json['bln_is_active'];
    blnSortid = json['bln_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bln_id'] = blnId;
    data['bln_category_idfk'] = blnCategoryIdfk;
    data['family_idfk'] = familyIdfk;
    data['bln_name'] = blnName;
    data['bln_abrv'] = blnAbrv;
    data['min_max'] = minMax;
    data['icon_selected'] = iconSelected;
    data['icon_unselected'] = iconUnselected;
    data['bln_is_active'] = blnIsActive;
    data['bln_sortid'] = blnSortid;
    return data;
  }
}

@Entity(tableName: 'fabric_appearance')
class FabricAppearance {
  @PrimaryKey(autoGenerate: false)
  int? fabricAppearanceId;
  String? fabricAppearanceName;
  String? fabricAppearanceSortid;
  String? fabricAppearanceIsActive;
  String? fabricFamilyIdfk;

  FabricAppearance(
      {this.fabricAppearanceId,
        this.fabricAppearanceName,
        this.fabricAppearanceSortid,
        this.fabricAppearanceIsActive,
        this.fabricFamilyIdfk});

  FabricAppearance.fromJson(Map<String, dynamic> json) {
    fabricAppearanceId = json['fabric_appearance_id'];
    fabricAppearanceName = json['fabric_appearance_name'];
    fabricAppearanceSortid = json['fabric_appearance_sortid'];
    fabricAppearanceIsActive = json['fabric_appearance_is_active'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_appearance_id'] = fabricAppearanceId;
    data['fabric_appearance_name'] = fabricAppearanceName;
    data['fabric_appearance_sortid'] = fabricAppearanceSortid;
    data['fabric_appearance_is_active'] = fabricAppearanceIsActive;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    return data;
  }
}

@Entity(tableName: 'knitting_types')
class KnittingTypes {
  @PrimaryKey(autoGenerate: false)
  int? fabricKnittingTypeId;
  String? fabricKnittingTypeName;
  String? fabricFamilyIdfk;

  KnittingTypes(
      {this.fabricKnittingTypeId,
        this.fabricKnittingTypeName,
        this.fabricFamilyIdfk});

  KnittingTypes.fromJson(Map<String, dynamic> json) {
    fabricKnittingTypeId = json['fabric_knitting_type_id'];
    fabricKnittingTypeName = json['fabric_knitting_type_name'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_knitting_type_id'] = fabricKnittingTypeId;
    data['fabric_knitting_type_name'] = fabricKnittingTypeName;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    return data;
  }
}

@Entity(tableName: 'fabric_ply')
class FabricPly {
  @PrimaryKey(autoGenerate: false)
  int? fabricPlyId;
  String? fabricFamilyIdfk;
  String? fabricPlyType;
  String? fabricPlyName;
  String? fabricPlyDescription;
  String? fabricPlyIsActive;
  String? fabricPlySortid;

  FabricPly(
      {this.fabricPlyId,
        this.fabricFamilyIdfk,
        this.fabricPlyType,
        this.fabricPlyName,
        this.fabricPlyDescription,
        this.fabricPlyIsActive,
        this.fabricPlySortid});

  FabricPly.fromJson(Map<String, dynamic> json) {
    fabricPlyId = json['fabric_ply_id'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
    fabricPlyType = json['fabric_ply_type'];
    fabricPlyName = json['fabric_ply_name'];
    fabricPlyDescription = json['fabric_ply_description'];
    fabricPlyIsActive = json['fabric_ply_is_active'];
    fabricPlySortid = json['fabric_ply_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_ply_id'] = fabricPlyId;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    data['fabric_ply_type'] = fabricPlyType;
    data['fabric_ply_name'] = fabricPlyName;
    data['fabric_ply_description'] = fabricPlyDescription;
    data['fabric_ply_is_active'] = fabricPlyIsActive;
    data['fabric_ply_sortid'] = fabricPlySortid;
    return data;
  }
}

@Entity(tableName: 'fiber_color_treatment_method')
class FabricColorTreatmentMethod {
  @PrimaryKey(autoGenerate: false)
  int? fctmId;
  String? fabricFamilyIdfk;
  String? fctmName;
  String? fctmDescription;
  String? fctmIsActive;
  String? fctmSortid;

  FabricColorTreatmentMethod(
      {this.fctmId,
        this.fabricFamilyIdfk,
        this.fctmName,
        this.fctmDescription,
        this.fctmIsActive,
        this.fctmSortid});

  FabricColorTreatmentMethod.fromJson(Map<String, dynamic> json) {
    fctmId = json['fctm_id'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
    fctmName = json['fctm_name'];
    fctmDescription = json['fctm_description'];
    fctmIsActive = json['fctm_is_active'];
    fctmSortid = json['fctm_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fctm_id'] = fctmId;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    data['fctm_name'] = fctmName;
    data['fctm_description'] = fctmDescription;
    data['fctm_is_active'] = fctmIsActive;
    data['fctm_sortid'] = fctmSortid;
    return data;
  }
}

@Entity(tableName: 'fabric_dying_techniques')
class FabricDyingTechniques {
  @PrimaryKey(autoGenerate: false)
  int? fdtId;
  String? fctmIdfk;
  String? fabricFamilyIdfk;
  String? fdtName;
  String? fdtIsActive;
  String? fdtSortid;

  FabricDyingTechniques(
      {this.fdtId,
        this.fctmIdfk,
        this.fabricFamilyIdfk,
        this.fdtName,
        this.fdtIsActive,
        this.fdtSortid});

  FabricDyingTechniques.fromJson(Map<String, dynamic> json) {
    fdtId = json['fdt_id'];
    fctmIdfk = json['fctm_idfk'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
    fdtName = json['fdt_name'];
    fdtIsActive = json['fdt_is_active'];
    fdtSortid = json['fdt_sortid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fdt_id'] = fdtId;
    data['fctm_idfk'] = fctmIdfk;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    data['fdt_name'] = fdtName;
    data['fdt_is_active'] = fdtIsActive;
    data['fdt_sortid'] = fdtSortid;
    return data;
  }
}

@Entity(tableName: 'fabric_quality')
class FabricQuality {
  @PrimaryKey(autoGenerate: false)
  int? fabricQualityId;
  String? fabricQualityName;
  String? fabricFamilyIdfk;

  FabricQuality(
      {this.fabricQualityId, this.fabricQualityName, this.fabricFamilyIdfk});

  FabricQuality.fromJson(Map<String, dynamic> json) {
    fabricQualityId = json['fabric_quality_id'];
    fabricQualityName = json['fabric_quality_name'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_quality_id'] = fabricQualityId;
    data['fabric_quality_name'] = fabricQualityName;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    return data;
  }
}

@Entity(tableName: 'fabric_grades')
class FabricGrades {
  @PrimaryKey(autoGenerate: false)
  int? fabricGradeId;
  String? fabricGradeName;
  String? fabricFamilyIdfk;

  FabricGrades({this.fabricGradeId, this.fabricGradeName, this.fabricFamilyIdfk});

  FabricGrades.fromJson(Map<String, dynamic> json) {
    fabricGradeId = json['fabric_grade_id'];
    fabricGradeName = json['fabric_grade_name'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_grade_id'] = fabricGradeId;
    data['fabric_grade_name'] = fabricGradeName;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    return data;
  }
}

@Entity(tableName: 'fabric_loom')
class FabricLoom {
  @PrimaryKey(autoGenerate: false)
  int? fabricLoomId;
  String? fabricLoomName;
  String? fabricFamilyIdfk;

  FabricLoom({this.fabricLoomId, this.fabricLoomName, this.fabricFamilyIdfk});

  FabricLoom.fromJson(Map<String, dynamic> json) {
    fabricLoomId = json['fabric_loom_id'];
    fabricLoomName = json['fabric_loom_name'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_loom_id'] = fabricLoomId;
    data['fabric_loom_name'] = fabricLoomName;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    return data;
  }
}

@Entity(tableName: 'fabric_salvedge')
class FabricSalvedge {
  @PrimaryKey(autoGenerate: false)
  int? fabricSalvedgeId;
  String? fabricSalvedgeName;
  String? fabricFamilyIdfk;

  FabricSalvedge(
      {this.fabricSalvedgeId, this.fabricSalvedgeName, this.fabricFamilyIdfk});

  FabricSalvedge.fromJson(Map<String, dynamic> json) {
    fabricSalvedgeId = json['fabric_salvedge_id'];
    fabricSalvedgeName = json['fabric_salvedge_name'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_salvedge_id'] = fabricSalvedgeId;
    data['fabric_salvedge_name'] = fabricSalvedgeName;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    return data;
  }
}

@Entity(tableName: 'fabric_weave')
class FabricWeave {
  @PrimaryKey(autoGenerate: false)
  int? fabricWeaveId;
  String? fabricWeaveName;
  String? fabricFamilyIdfk;

  FabricWeave({this.fabricWeaveId, this.fabricWeaveName, this.fabricFamilyIdfk});

  FabricWeave.fromJson(Map<String, dynamic> json) {
    fabricWeaveId = json['fabric_weave_id'];
    fabricWeaveName = json['fabric_weave_name'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_weave_id'] = fabricWeaveId;
    data['fabric_weave_name'] = fabricWeaveName;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    return data;
  }
}

@Entity(tableName: 'fabric_layyer')
class FabricLayyer {
  @PrimaryKey(autoGenerate: false)
  int? fabricLayyerId;
  String? fabricLayyerName;
  String? fabricFamilyIdfk;

  FabricLayyer({this.fabricLayyerId, this.fabricLayyerName, this.fabricFamilyIdfk});

  FabricLayyer.fromJson(Map<String, dynamic> json) {
    fabricLayyerId = json['fabric_layyer_id'];
    fabricLayyerName = json['fabric_layyer_name'];
    fabricFamilyIdfk = json['fabric_family_idfk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fabric_layyer_id'] = fabricLayyerId;
    data['fabric_layyer_name'] = fabricLayyerName;
    data['fabric_family_idfk'] = fabricFamilyIdfk;
    return data;
  }
}


