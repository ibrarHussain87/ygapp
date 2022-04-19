import 'package:yg_app/helper_utils/app_constants.dart';
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
import 'package:yg_app/model/response/fabric_response/sync/fabric_sync_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_apperance.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_grades.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

import 'app_database.dart';

class AppDbInstance {
  static Future<AppDatabase> getDbInstance() async {
    AppDatabase? databaseInstance;
    final database =
        $FloorAppDatabase.databaseBuilder(APP_DATABASE_NAME).build();
    await database.then((value) => {databaseInstance = value});
    return databaseInstance!;
  }

  static Future<List<FiberMaterial>> getFiberMaterialData() {
    return getDbInstance()
        .then((value) => value.fiberMaterialDao.findAllFiberMaterials());
  }

  static Future<List<FabricBlends>> getFabricBlendsData() {
    return getDbInstance()
        .then((value) => value.fabricBlendsDao.findAllFabricBlends());
  }

  static Future<List<FiberNature>> getFiberNatureData() {
    return getDbInstance()
        .then((value) => value.fiberNatureDao.findAllFiberNatures());
  }

  static Future<List<Grades>> getFiberGradesData() {
    return getDbInstance().then((value) => value.gradesDao.findAllGrades());
  }

  static Future<List<FiberAppearance>> getFiberAppearanceData() {
    return getDbInstance()
        .then((value) => value.fiberAppearanceDoa.findAllFiberAppearance());
  }

  static Future<List<Brands>> getFiberBrandsData() {
    return getDbInstance().then((value) => value.brandsDao.findAllBrands());
  }

  static Future<List<Countries>> getOriginsData() {
    return getDbInstance()
        .then((value) => value.countriesDao.findAllCountries());
  }

  static Future<List<Certification>> getCertificationsData() {
    return getDbInstance()
        .then((value) => value.certificationDao.findAllCertifications());
  }

  static Future<List<Family>> getYarnFamilyData() {
    return getDbInstance()
        .then((value) => value.yarnFamilyDao.findAllYarnFamily());
  }

  static Future<List<Blends>> getYarnBlendData() {
    return getDbInstance()
        .then((value) => value.yarnBlendDao.findAllYarnBlends());
  }

  static Future<List<Usage>> getYarnUsage() {
    return getDbInstance().then((value) => value.usageDao.findAllUsage());
  }

  static Future<List<YarnTypes>> getYarnTypeData() {
    return getDbInstance()
        .then((value) => value.yarnTypesDao.findAllYarnTypes());
  }

  static Future<List<ColorTreatmentMethod>> getColorTreatmentMethodData() {
    return getDbInstance().then(
        (value) => value.colorTreatmentMethodDao.findAllColorTreatmentMethod());
  }

  static Future<List<DyingMethod>> getYarnDyingMethod() {
    return getDbInstance()
        .then((value) => value.colorMethodDao.findAllDyingMethod());
  }

  static Future<List<Ply>> getYarnPly() {
    return getDbInstance().then((value) => value.plyDao.findAllPly());
  }

  static Future<List<DoublingMethod>> getDoublingMethod() {
    return getDbInstance()
        .then((value) => value.doublingMethodDao.findAllDoublingMethod());
  }

  static Future<List<OrientationTable>> getOrientationData() {
    return getDbInstance()
        .then((value) => value.orientationDao.findAllOrientation());
  }

  static Future<List<SpunTechnique>> getSpunTech() {
    return getDbInstance()
        .then((value) => value.spunTechDao.findAllSpunTechnique());
  }

  static Future<List<Quality>> getYarnQuality() {
    return getDbInstance().then((value) => value.qualityDao.findAllQuality());
  }

  static Future<List<PatternModel>> getPattern() {
    return getDbInstance().then((value) => value.patternDao.findAllPattern());
  }

  static Future<List<PatternCharectristic>> getPatternCharacteristics() {
    return getDbInstance()
        .then((value) => value.patternCharDao.findAllPatternCharacteristics());
  }

  static Future<List<YarnAppearance>> getYarnAppearance() {
    return getDbInstance()
        .then((value) => value.yarnAppearanceDao.findAllYarnAppearance());
  }

  static Future<List<YarnGrades>> getYarnGradesDao() {
    return getDbInstance().then((value) => value.yarnGradesDao.findAllGrades());
  }

  static Future<List<TwistDirection>> getTwistDirections() {
    return getDbInstance()
        .then((value) => value.twistDirectionDao.findAllTwistDirection());
  }

  static Future<List<CityState>> getCityState() {
    return getDbInstance()
        .then((value) => value.cityStateDao.findAllCityState());
  }

  static Future<List<Companies>> getCompaniesDao() {
    return getDbInstance()
        .then((value) => value.companiesDao.findAllCompanies());
  }

  static Future<List<DeliveryPeriod>> getDeliveryPeriod() {
    return getDbInstance()
        .then((value) => value.deliveryPeriodDao.findAllDeliveryPeriod());
  }

  static Future<List<LcType>> getLcType() {
    return getDbInstance().then((value) => value.lcTypeDao.findAllLcType());
  }

  static Future<List<Packing>> getPacking() {
    return getDbInstance().then((value) => value.packingDao.findAllPacking());
  }

  static Future<List<PaymentType>> getPaymentType() {
    return getDbInstance()
        .then((value) => value.paymentTypeDao.findAllPaymentTypes());
  }

  static Future<List<Ports>> getPorts() {
    return getDbInstance().then((value) => value.portsDao.findAllPorts());
  }

  static Future<List<FPriceTerms>> getPriceTerms() {
    return getDbInstance()
        .then((value) => value.priceTermsDao.findAllFPriceTerms());
  }

  static Future<List<Units>> getUnits() {
    return getDbInstance().then((value) => value.unitDao.findAllUnit());
  }

  static Future<List<YarnSetting>> getYarnSettings() {
    return getDbInstance()
        .then((value) => value.yarnSettingsDao.findAllYarnSettings());
  }

  static Future<List<ConeType>> getConeTypes() {
    return getDbInstance().then((value) => value.coneTypeDao.findAllConeType());
  }
}
