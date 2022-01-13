import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:yg_app/app_database/dao/brands_dao.dart';
import 'package:yg_app/app_database/dao/certifications_dao.dart';
import 'package:yg_app/app_database/dao/city_state_dao.dart';
import 'package:yg_app/app_database/dao/companies_dao.dart';
import 'package:yg_app/app_database/dao/countries_dao.dart';
import 'package:yg_app/app_database/dao/deliver_period_dao.dart';
import 'package:yg_app/app_database/dao/fiber_dao/fiber_appearance_dao.dart';
import 'package:yg_app/app_database/dao/fiber_dao/fiber_material_dao.dart';
import 'package:yg_app/app_database/dao/fiber_dao/fiber_nature_dao.dart';
import 'package:yg_app/app_database/dao/lc_types_dao.dart';
import 'package:yg_app/app_database/dao/packing_dao.dart';
import 'package:yg_app/app_database/dao/payment_type_dao.dart';
import 'package:yg_app/app_database/dao/port_dao.dart';
import 'package:yg_app/app_database/dao/price_terms_dao.dart';
import 'package:yg_app/app_database/dao/unit_dao.dart';
import 'package:yg_app/app_database/dao/user_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/color_treatment_method_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/cone_types_dao.dart';
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
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

import 'dao/grades_dao.dart';
import 'dao/fiber_dao/fiber_settings_dao.dart';
import 'package:build_daemon/constants.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: APP_DATABASE_VERSION,entities: [User,FiberNature,FiberAppearance,FiberAvailbleForMarket,FiberCategories,FiberMaterial,Brands,Countries,
  Certification,DeliveryPeriod,Units,Companies,CityState,Grades,FPriceTerms,LcType,Packing,PaymentType,Ports,FiberSettings,YarnSetting,Family,Blends,
ColorTreatmentMethod,ConeType,DyingMethod,FiberAppearance,YarnAppearance,Orientation,PatternCharectristic,PatternModel,Ply,Quality,SpunTechnique,TwistDirection,Usage,YarnTypes])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;

  FiberSettingDao get fiberSettingDao;
  FiberNatureDao get fiberNatureDao;
  FiberMaterialDao get fiberMaterialDao;
  FiberAppearanceDao get fiberAppearanceDoa;

  GradesDao get gradesDao;
  BrandsDao get brandsDao;
  CertificationsDao get certificationDao;
  CityStateDao get cityStateDao;
  CompaniesDao get companiesDao;
  CountryDao get countriesDao;
  DeliveryPeriodDao get deliveryPeriodDao;
  LcTypesDao get lcTypeDao;
  PackingDao get packingDao;
  PaymentTypeDao get paymentTypeDao;
  PortsDao get portsDao;
  PriceTermsDao get priceTermsDao;
  UnitDao get unitDao;

  YarnSettingDao get yarnSettingsDao;
  YarnFamilyDao get yarnFamilyDao;
  YarnBlendDao get yarnBlendDao;

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