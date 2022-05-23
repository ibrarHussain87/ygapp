import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:yg_app/app_database/dao/brands_dao.dart';
import 'package:yg_app/app_database/dao/category_dao.dart';
import 'package:yg_app/app_database/dao/certifications_dao.dart';
import 'package:yg_app/app_database/dao/city_state_dao.dart';
import 'package:yg_app/app_database/dao/companies_dao.dart';
import 'package:yg_app/app_database/dao/countries_dao.dart';
import 'package:yg_app/app_database/dao/deliver_period_dao.dart';
import 'package:yg_app/app_database/dao/fabric_dao/fabric_family_dao.dart';
import 'package:yg_app/app_database/dao/fiber_dao/fiber_appearance_dao.dart';
import 'package:yg_app/app_database/dao/fiber_dao/fiber_material_dao.dart';
import 'package:yg_app/app_database/dao/fiber_dao/fiber_nature_dao.dart';
import 'package:yg_app/app_database/dao/lc_types_dao.dart';
import 'package:yg_app/app_database/dao/packing_dao.dart';
import 'package:yg_app/app_database/dao/payment_type_dao.dart';
import 'package:yg_app/app_database/dao/port_dao.dart';
import 'package:yg_app/app_database/dao/price_terms_dao.dart';
import 'package:yg_app/app_database/dao/stocklot_dao/availability_dao.dart';
import 'package:yg_app/app_database/dao/stocklot_dao/stocklot_categories_dao.dart';
import 'package:yg_app/app_database/dao/unit_dao.dart';
import 'package:yg_app/app_database/dao/user_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/color_treatment_method_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/cone_types_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/doubling_method_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/dying_method_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/orientation_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/pattern_characteristics_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/pattern_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/ply_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/quality_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/spun_technequie_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/twist_direction_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/usage_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_appearance_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_blend_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_family_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_settings_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_types_dao.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/companies_reponse.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/common_response_models/delievery_period.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/common_response_models/lc_type_response.dart';
import 'package:yg_app/model/response/common_response_models/packing_response.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

import '../model/response/common_response_models/category_response.dart';
import '../model/response/fabric_response/sync/fabric_sync_response.dart';
import '../model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';
import 'dao/fabric_dao/fabric_appearance_dao.dart';
import 'dao/fabric_dao/fabric_blends_dao.dart';
import 'dao/fabric_dao/fabric_color_treatment_dao.dart';
import 'dao/fabric_dao/fabric_denim_types_dao.dart';
import 'dao/fabric_dao/fabric_dying_techniques_dao.dart';
import 'dao/fabric_dao/fabric_grades_dao.dart';
import 'dao/fabric_dao/fabric_layyer_dao.dart';
import 'dao/fabric_dao/fabric_loom_dao.dart';
import 'dao/fabric_dao/fabric_ply_dao.dart';
import 'dao/fabric_dao/fabric_quality_dao.dart';
import 'dao/fabric_dao/fabric_salvedge_dao.dart';
import 'dao/fabric_dao/fabric_settings_dao.dart';
import 'dao/fabric_dao/fabric_weave_dao.dart';
import 'dao/fabric_dao/knitting_types_dao.dart';
import 'dao/grades_dao.dart';
import 'dao/fiber_dao/fiber_settings_dao.dart';

import 'dao/yarn_grades_dao.dart';

part 'app_database.g.dart'; // the generated code will be there


/// Run the generator with flutter packages pub run build_runner build.
///To automatically run it, whenever a file changes, use flutter packages pub run build_runner watch.
///flutter clean
///flutter pub get
///flutter packages pub run build_runner build --delete-conflicting-outputs


@Database(version: APP_DATABASE_VERSION,entities: [User,FiberFamily,FiberAppearance,FiberAvailbleForMarket,FiberCategories,FiberBlends,Brands,Countries,Categories,
  Certification,DeliveryPeriod,Units,Companies,CityState,Grades,FPriceTerms,LcType,Packing,PaymentType,Ports,FiberSettings,YarnSetting,Family,Blends,FabricSetting,FabricFamily,FabricBlends,DenimTypes,FabricAppearance,KnittingTypes,FabricPly,
  FabricColorTreatmentMethod,FabricDyingTechniques,FabricQuality,FabricGrades,FabricLoom,FabricSalvedge,FabricWeave,FabricLayyer,AvailabilityModel,
ColorTreatmentMethod,ConeType,DoublingMethod,DyingMethod,YarnGrades,FiberAppearance,YarnAppearance,OrientationTable,PatternCharectristic,PatternModel,Ply,Quality,SpunTechnique,TwistDirection,Usage,YarnTypes,StockLotFamily])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;

  FiberSettingDao get fiberSettingDao;

  FiberFamilyDao get fiberFamilyDao;

  FiberBlendsDao get fiberBlendsDao;

  FiberAppearanceDao get fiberAppearanceDoa;

  GradesDao get gradesDao;

  BrandsDao get brandsDao;

  CertificationsDao get certificationDao;

  CityStateDao get cityStateDao;

  CompaniesDao get companiesDao;

  CountryDao get countriesDao;

  CategoryDao get categoriesDao;
  DeliveryPeriodDao get deliveryPeriodDao;

  LcTypesDao get lcTypeDao;

  PackingDao get packingDao;

  PaymentTypeDao get paymentTypeDao;

  PortsDao get portsDao;

  PriceTermsDao get priceTermsDao;

  UnitDao get unitDao;

  StocklotFamilyDao get stocklotCategoriesDao;

  AvailabilityDao get availabilityDao;

  FabricSettingDao get fabricSettingDao;

  FabricFamilyDao get fabricFamilyDao;

  FabricBlendsDao get fabricBlendsDao;

  FabricDenimTypesDao get fabricDenimTypesDao;

  FabricAppearanceDao get fabricAppearanceDao;

  KnittingTypesDao get knittingTypesDao;

  FabricPlyDao get fabricPlyDao;

  FabricColorTreatmentMethodDao get fabricColorTreatmentMethodDao;

  FabricDyingTechniqueDao get fabricDyingTechniqueDao;

  FabricQualityDao get fabricQualityDao;

  FabricGradesDao get fabricGradesDao;

  FabricLoomDao get fabricLoomDao;

  FabricSalvedgeDao get fabricSalvedgeDao;

  FabricWeaveDao get fabricWeaveDao;

  FabricLayyerDao get fabricLayyerDao;

  YarnSettingDao get yarnSettingsDao;

  YarnFamilyDao get yarnFamilyDao;

  YarnBlendDao get yarnBlendDao;

  YarnGradesDao get yarnGradesDao;

  DoublingMethodDao get doublingMethodDao;

  ColorTreatmentMethodDao get colorTreatmentMethodDao;

  ConeTypeDao get coneTypeDao;

  DyingMethodDao get colorMethodDao;

  OrientationDao get orientationDao;

  PatternCharacteristicsDao get patternCharDao;

  PatternDao get patternDao;

  PlyDao get plyDao;

  QualityDao get qualityDao;

  SpunTechniqueDao get spunTechDao;

  TwistDirectionDao get twistDirectionDao;

  UsageDao get usageDao;

  YarnTypesDao get yarnTypesDao;

  YarnAppearanceDao get yarnAppearanceDao;
}
