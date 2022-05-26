import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/category_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/companies_reponse.dart';
import 'package:yg_app/model/response/common_response_models/cone_type_reponse.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/common_response_models/delievery_period.dart';
import 'package:yg_app/model/response/common_response_models/grade.dart';
import 'package:yg_app/model/response/common_response_models/payment_type_response.dart';
import 'package:yg_app/model/response/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/common_response_models/price_term.dart';
import 'package:yg_app/model/response/common_response_models/unit_of_count.dart';
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

import 'app_database.dart';

class AppDbInstance {
  Future<AppDatabase> getDbInstance() async {
    AppDatabase? databaseInstance;
    final database =
        $FloorAppDatabase.databaseBuilder(APP_DATABASE_NAME).build();
    await database.then((value) => {databaseInstance = value});
    return databaseInstance!;
  }

  Future<List<FiberBlends>> getFiberMaterialData() {
    return getDbInstance()
        .then((value) => value.fiberBlendsDao.findAllFiberBlends());
  }

  Future<List<FabricBlends>> getFabricBlendsData() {
    return getDbInstance()
        .then((value) => value.fabricBlendsDao.findAllFabricBlends());
  }

  Future<List<FiberFamily>> getFiberNatureData() {
    return getDbInstance()
        .then((value) => value.fiberFamilyDao.findAllFiberNatures());
  }

  Future<List<Grades>> getFiberGradesData() {
    return getDbInstance().then((value) => value.gradesDao.findAllGrades());
  }

  Future<List<FiberAppearance>> getFiberAppearanceData() {
    return getDbInstance()
        .then((value) => value.fiberAppearanceDoa.findAllFiberAppearance());
  }

  Future<List<Brands>> getFiberBrandsData() {
    return getDbInstance().then((value) => value.brandsDao.findAllBrands());
  }

  Future<List<Countries>> getOriginsData() {
    return getDbInstance()
        .then((value) => value.countriesDao.findAllCountries());
  }

  Future<List<Certification>> getCertificationsData() {
    return getDbInstance()
        .then((value) => value.certificationDao.findAllCertifications());
  }

  Future<List<Family>> getYarnFamilyData() {
    return getDbInstance()
        .then((value) => value.yarnFamilyDao.findAllYarnFamily());
  }

  Future<List<Blends>> getYarnBlendData() {
    return getDbInstance()
        .then((value) => value.yarnBlendDao.allYarnBlends());
  }

  Future<List<Usage>> getYarnUsage() {
    return getDbInstance().then((value) => value.usageDao.findAllUsage());
  }

  Future<List<YarnTypes>> getYarnTypeData() {
    return getDbInstance()
        .then((value) => value.yarnTypesDao.findAllYarnTypes());
  }

  Future<List<ColorTreatmentMethod>> getColorTreatmentMethodData() {
    return getDbInstance().then(
        (value) => value.colorTreatmentMethodDao.findAllColorTreatmentMethod());
  }

  Future<List<DyingMethod>> getYarnDyingMethod() {
    return getDbInstance()
        .then((value) => value.dyingMethodDao.findAllDyingMethod());
  }

  Future<List<Ply>> getYarnPly() {
    return getDbInstance().then((value) => value.plyDao.findAllPly());
  }

  Future<List<DoublingMethod>> getDoublingMethod() {
    return getDbInstance()
        .then((value) => value.doublingMethodDao.findAllDoublingMethod());
  }

  Future<List<OrientationTable>> getOrientationData() {
    return getDbInstance()
        .then((value) => value.orientationDao.findAllOrientation());
  }

  Future<List<SpunTechnique>> getSpunTech() {
    return getDbInstance()
        .then((value) => value.spunTechDao.findAllSpunTechnique());
  }

  Future<List<Quality>> getYarnQuality() {
    return getDbInstance().then((value) => value.qualityDao.findAllQuality());
  }

  Future<List<PatternModel>> getPattern() {
    return getDbInstance().then((value) => value.patternDao.findAllPattern());
  }

  Future<List<PatternCharectristic>> getPatternCharacteristics() {
    return getDbInstance()
        .then((value) => value.patternCharDao.findAllPatternCharacteristics());
  }

  Future<List<YarnAppearance>> getYarnAppearance() {
    return getDbInstance()
        .then((value) => value.yarnAppearanceDao.findAllYarnAppearance());
  }

  Future<List<YarnGrades>> getYarnGradesDao() {
    return getDbInstance().then((value) => value.yarnGradesDao.findAllGrades());
  }

  // Future<List<TwistDirection>> getTwistDirections() {
  //   return getDbInstance()
  //       .then((value) => value.twistDirectionDao.findAllTwistDirection());
  // }

  Future<List<CityState>> getCityState() {
    return getDbInstance()
        .then((value) => value.cityStateDao.findAllCityState());
  }

  Future<List<Companies>> getCompaniesDao() {
    return getDbInstance()
        .then((value) => value.companiesDao.findAllCompanies());
  }

  Future<List<Categories>> getCategoriesDao() {
    return getDbInstance()
        .then((value) => value.categoriesDao.findAllCategories());
  }

  Future<List<DeliveryPeriod>> getDeliveryPeriod() {
    return getDbInstance()
        .then((value) => value.deliveryPeriodDao.findAllDeliveryPeriod());
  }

  // Future<List<LcType>> getLcType() {
  //   return getDbInstance().then((value) => value.lcTypeDao.findAllLcType());
  // }
  //
  // Future<List<Packing>> getPacking() {
  //   return getDbInstance().then((value) => value.packingDao.findAllPacking());
  // }

  Future<List<PaymentType>> getPaymentType() {
    return getDbInstance()
        .then((value) => value.paymentTypeDao.findAllPaymentTypes());
  }




  Future<List<YarnSetting>> getYarnSettings() {
    return getDbInstance()
        .then((value) => value.yarnSettingsDao.findAllYarnSettings());
  }

}
