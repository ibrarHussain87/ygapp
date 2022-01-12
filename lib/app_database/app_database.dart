import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:yg_app/app_database/dao/brands_dao.dart';
import 'package:yg_app/app_database/dao/certifications_dao.dart';
import 'package:yg_app/app_database/dao/city_state_dao.dart';
import 'package:yg_app/app_database/dao/companies_dao.dart';
import 'package:yg_app/app_database/dao/countries_dao.dart';
import 'package:yg_app/app_database/dao/deliver_period_dao.dart';
import 'package:yg_app/app_database/dao/fiber_dao/fiber_material_dao.dart';
import 'package:yg_app/app_database/dao/fiber_dao/fiber_nature_dao.dart';
import 'package:yg_app/app_database/dao/lc_types_dao.dart';
import 'package:yg_app/app_database/dao/packing_dao.dart';
import 'package:yg_app/app_database/dao/payment_type_dao.dart';
import 'package:yg_app/app_database/dao/port_dao.dart';
import 'package:yg_app/app_database/dao/price_terms_dao.dart';
import 'package:yg_app/app_database/dao/unit_dao.dart';
import 'package:yg_app/app_database/dao/user_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_blend_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_family_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_settings_dao.dart';
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
  Certification,DeliveryPeriod,Units,Companies,CityState,Grades,FPriceTerms,LcType,Packing,PaymentType,Ports,FiberSettings,YarnSetting,Family,Blends])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;

  FiberSettingDao get fiberSettingDao;
  FiberNatureDao get fiberNatureDao;
  FiberMaterialDao get fiberMaterialDao;

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
}