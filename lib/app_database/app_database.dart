import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:yg_app/model/response/sync/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/companies_reponse.dart';
import 'package:yg_app/model/response/sync/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/lc_type_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/packing_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_apperance.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_delievery_period.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_grade.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_unit_of_count.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/price_term.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';

import 'dao/fiber_dao/fiber_settings_dao.dart';

part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1,entities: [FiberApperance,FiberAvailbleForMarket,FiberCategories,FiberMaterial,BrandsModel,CountriesModel,
  CertificationModel,FiberDeliveryPeriod,FiberUnits,FiberGrades,FiberPriceTerms,CompaniesModel,LcTypeModel,PackingModel,PaymentTypeModel,PortsModel,FiberSettings])
abstract class AppDatabase extends FloorDatabase {
  FiberSettingDao get fiberSettingDao;
}