import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_apperance.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_certification.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_countries.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_grade.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';

import 'dao/fiber_dao/fiber_settings_dao.dart';
part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1,entities: [FiberApperance,FiberAvailbleForMarket,FiberCategories,FiberMaterial,FiberBrands,FiberCountries,FiberCertification,FiberDeliveryPeriod,FiberUnits,FiberGrades,FiberPriceTerms,FiberSettings])
abstract class AppDatabase extends FloorDatabase {
  FiberSettingDao get fiberSettingDao;
}