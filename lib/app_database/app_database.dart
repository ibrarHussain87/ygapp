import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:yg_app/app_database/dao/fiber_dao/fiber_material_dao.dart';
import 'package:yg_app/app_database/dao/fiber_dao/fiber_nature_dao.dart';
import 'package:yg_app/app_database/dao/user_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_blend_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_family_dao.dart';
import 'package:yg_app/app_database/dao/yarn_dao/yarn_settings_dao.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/common_response_models/fiber_delievery_period.dart';
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
  Certification,DeliveryPeriod,Units,Grades,FPriceTerms,LcType,Packing,PaymentType,Ports,FiberSettings,YarnSetting,Family,Blends])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  FiberSettingDao get fiberSettingDao;
  GradesDao get gradesDao;
  FiberNatureDao get fiberNatureDao;
  FiberMaterialDao get fiberMaterialDao;
  YarnSettingDao get yarnSettingsDao;
  YarnFamilyDao get yarnFamilyDao;
  YarnBlendDao get yarnBlendDao;
}