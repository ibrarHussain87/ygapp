
import 'package:flutter/cupertino.dart';

import '../api_services/api_service_class.dart';
import '../app_database/app_database_instance.dart';
import '../helper_utils/app_constants.dart';
import '../helper_utils/shared_pref_util.dart';

class SyncProvider extends ChangeNotifier{

  bool isDataSynced = false;
  bool loading = false;

  syncAppData() async{
    loading = true;
    isDataSynced = await _synData();
    loading = false;
    notifyListeners();
  }

  Future<bool> _synData() async {
    bool dataSynced = await SharedPreferenceUtil.getBoolValuesSF(SYNCED_KEY);

    if (!dataSynced) {
      await Future.wait([
        ApiService.syncFiber().then((syncFiberResponse) {
          if (syncFiberResponse.status) {
            AppDbInstance.getDbInstance().then((value) async {
              await Future.wait([
                value.fiberMaterialDao.insertAllFiberMaterials(
                    syncFiberResponse.data.fiber.material),

                value.fiberSettingDao.insertAllFiberSettings(
                    syncFiberResponse.data.fiber.settings),
                value.gradesDao
                    .insertAllGrades(syncFiberResponse.data.fiber.grades),
                value.fiberNatureDao.insertAllFiberNatures(
                    syncFiberResponse.data.fiber.natures),

                //insert Common objects for fiber
                value.gradesDao
                    .insertAllGrades(syncFiberResponse.data.fiber.grades),
                value.brandsDao
                    .insertAllBrands(syncFiberResponse.data.fiber.brands),
                value.certificationDao.insertAllCertification(
                    syncFiberResponse.data.fiber.certification),
                value.cityStateDao
                    .insertAllCityState(syncFiberResponse.data.fiber.cityState),
                value.companiesDao
                    .insertAllCompanies(syncFiberResponse.data.fiber.companies),
                value.countriesDao
                    .insertAllCountry(syncFiberResponse.data.fiber.countries),
                value.deliveryPeriodDao.insertAllDeliveryPeriods(
                    syncFiberResponse.data.fiber.deliveryPeriod),
                value.lcTypeDao
                    .insertAllLcType(syncFiberResponse.data.fiber.lcType),
                value.paymentTypeDao.insertAllPaymentType(
                    syncFiberResponse.data.fiber.paymentType),
                value.portsDao
                    .insertAllPorts(syncFiberResponse.data.fiber.ports),
                value.priceTermsDao.insertAllFPriceTerms(
                    syncFiberResponse.data.fiber.priceTerms),
                value.unitDao.insertAllUnit(syncFiberResponse.data.fiber.units),
                value.fiberAppearanceDoa.insertAllFiberAppearance(
                    syncFiberResponse.data.fiber.apperance),
                value.packingDao
                    .insertAllPacking(syncFiberResponse.data.fiber.packing)
              ]);
            });
          }
        }),
        ApiService.syncYarn().then((syncYarnResponse) {
          if (syncYarnResponse.status!) {
            AppDbInstance.getDbInstance().then((value) async {
              await Future.wait([
                //Yarn
                value.yarnSettingsDao
                    .insertAllYarnSettings(syncYarnResponse.data.yarn.setting!),
                value.yarnBlendDao
                    .insertAllYarnBlend(syncYarnResponse.data.yarn.blends!),

                value.spunTechDao.insertAllSpunTechnique(
                    syncYarnResponse.data.yarn.spunTechnique!),
                value.doublingMethodDao.insertAllDoublingMethod(
                    syncYarnResponse.data.yarn.doublingMethod!),
                value.yarnFamilyDao
                    .insertAllYarnFamily(syncYarnResponse.data.yarn.family!),
                //Insert All Common Objects for yarn
                value.yarnGradesDao
                    .insertAllGrades(syncYarnResponse.data.yarn.grades!),
                value.brandsDao
                    .insertAllBrands(syncYarnResponse.data.yarn.brands!),
                value.certificationDao.insertAllCertification(
                    syncYarnResponse.data.yarn.certification!),
                value.cityStateDao
                    .insertAllCityState(syncYarnResponse.data.yarn.cityState!),
                value.companiesDao
                    .insertAllCompanies(syncYarnResponse.data.yarn.companies!),
                value.countriesDao
                    .insertAllCountry(syncYarnResponse.data.yarn.countries!),
                value.deliveryPeriodDao.insertAllDeliveryPeriods(
                    syncYarnResponse.data.yarn.deliveryPeriod!),
                value.lcTypeDao
                    .insertAllLcType(syncYarnResponse.data.yarn.lcTypes!),
                value.paymentTypeDao.insertAllPaymentType(
                    syncYarnResponse.data.yarn.paymentTypes!),
                value.portsDao
                    .insertAllPorts(syncYarnResponse.data.yarn.ports!),
                value.priceTermsDao.insertAllFPriceTerms(
                    syncYarnResponse.data.yarn.priceTerms!),
                value.unitDao.insertAllUnit(syncYarnResponse.data.yarn.units!),
                value.colorTreatmentMethodDao.insertAllColorTreatmentMethod(
                    syncYarnResponse.data.yarn.colorTreatmentMethod!),
                value.coneTypeDao
                    .insertAllConeType(syncYarnResponse.data.yarn.coneType!),
                value.colorMethodDao.insertAllDyingMethod(
                    syncYarnResponse.data.yarn.dyingMethod!),
                value.orientationDao.insertAllOrientation(
                    syncYarnResponse.data.yarn.orientation!),
                value.patternCharDao.insertAllPatternCharacteristics(
                    syncYarnResponse.data.yarn.patternCharectristic!),
                value.patternDao
                    .insertAllPattern(syncYarnResponse.data.yarn.pattern!),
                value.plyDao.insertAllPly(syncYarnResponse.data.yarn.ply!),
                value.qualityDao
                    .insertAllQuality(syncYarnResponse.data.yarn.quality!),
                value.twistDirectionDao.insertAllTwistDirection(
                    syncYarnResponse.data.yarn.twistDirection!),
                value.usageDao
                    .insertAllUsage(syncYarnResponse.data.yarn.usage!),
                value.yarnTypesDao
                    .insertAllYarnTypes(syncYarnResponse.data.yarn.yarnTypes!),

                value.yarnAppearanceDao.insertAllYarnAppearance(
                    syncYarnResponse.data.yarn.apperance!),
                value.packingDao
                    .insertAllPacking(syncYarnResponse.data.yarn.packing!)
              ]);
            });
          }
        })
      ]);

      SharedPreferenceUtil.addBoolToSF(SYNCED_KEY, true);
    }

    /*  AppDbInstance.getDbInstance().then((value) async {

      await Future.wait([
        value.fiberMaterialDao
            .insertAllFiberMaterials(syncFiberResponse.data.fiber.material),

        value.yarnFamilyDao
            .insertAllYarnFamily(syncYarnResponse.data.yarn.family!),

        value.fiberSettingDao
            .insertAllFiberSettings(syncFiberResponse.data.fiber.settings),
        value.gradesDao.insertAllGrades(syncFiberResponse.data.fiber.grades),
        value.fiberNatureDao
            .insertAllFiberNatures(syncFiberResponse.data.fiber.natures),

        //insert Common objects for fiber
        value.brandsDao.insertAllBrands(syncFiberResponse.data.fiber.brands),
        value.certificationDao
            .insertAllCertification(syncFiberResponse.data.fiber.certification),
        value.cityStateDao
            .insertAllCityState(syncFiberResponse.data.fiber.cityState),
        value.companiesDao
            .insertAllCompanies(syncFiberResponse.data.fiber.companies),
        value.countriesDao
            .insertAllCountry(syncFiberResponse.data.fiber.countries),
        value.deliveryPeriodDao.insertAllDeliveryPeriods(
            syncFiberResponse.data.fiber.deliveryPeriod),
        value.lcTypeDao.insertAllLcType(syncFiberResponse.data.fiber.lcType),
        value.paymentTypeDao
            .insertAllPaymentType(syncFiberResponse.data.fiber.paymentType),
        value.portsDao.insertAllPorts(syncFiberResponse.data.fiber.ports),
        value.priceTermsDao
            .insertAllFPriceTerms(syncFiberResponse.data.fiber.priceTerms),
        value.unitDao.insertAllUnit(syncFiberResponse.data.fiber.units),
        value.fiberAppearanceDoa
            .insertAllFiberAppearance(syncFiberResponse.data.fiber.apperance),

        //Yarn
        value.yarnSettingsDao
            .insertAllYarnSettings(syncYarnResponse.data.yarn.setting!),
        value.yarnBlendDao
            .insertAllYarnBlend(syncYarnResponse.data.yarn.blends!),

        value.gradesDao.insertAllGrades(syncYarnResponse.data.yarn.grades!),

        //Insert All Common Objects for yarn
        value.brandsDao.insertAllBrands(syncYarnResponse.data.yarn.brands!),
        value.certificationDao
            .insertAllCertification(syncYarnResponse.data.yarn.certification!),
        value.cityStateDao
            .insertAllCityState(syncYarnResponse.data.yarn.cityState!),
        value.companiesDao
            .insertAllCompanies(syncYarnResponse.data.yarn.companies!),
        value.countriesDao
            .insertAllCountry(syncYarnResponse.data.yarn.countries!),
        value.deliveryPeriodDao.insertAllDeliveryPeriods(
            syncYarnResponse.data.yarn.deliveryPeriod!),
        value.lcTypeDao.insertAllLcType(syncYarnResponse.data.yarn.lcTypes!),
        value.paymentTypeDao
            .insertAllPaymentType(syncYarnResponse.data.yarn.paymentTypes!),
        value.portsDao.insertAllPorts(syncYarnResponse.data.yarn.ports!),
        value.priceTermsDao
            .insertAllFPriceTerms(syncYarnResponse.data.yarn.priceTerms!),
        value.unitDao.insertAllUnit(syncYarnResponse.data.yarn.units!),
        value.colorTreatmentMethodDao.insertAllColorTreatmentMethod(
            syncYarnResponse.data.yarn.colorTreatmentMethod!),
        value.coneTypeDao
            .insertAllConeType(syncYarnResponse.data.yarn.coneType!),
        value.colorMethodDao
            .insertAllDyingMethod(syncYarnResponse.data.yarn.dyingMethod!),
        value.orientationDao
            .insertAllOrientation(syncYarnResponse.data.yarn.orientation!),
        value.patternCharDao.insertAllPatternCharacteristics(
            syncYarnResponse.data.yarn.patternCharectristic!),
        value.patternDao.insertAllPattern(syncYarnResponse.data.yarn.pattern!),
        value.plyDao.insertAllPly(syncYarnResponse.data.yarn.ply!),
        value.qualityDao.insertAllQuality(syncYarnResponse.data.yarn.quality!),
        value.twistDirectionDao.insertAllTwistDirection(
            syncYarnResponse.data.yarn.twistDirection!),
        value.usageDao.insertAllUsage(syncYarnResponse.data.yarn.usage!),
        value.yarnTypesDao
            .insertAllYarnTypes(syncYarnResponse.data.yarn.yarnTypes!),

        value.yarnAppearanceDao
            .insertAllYarnAppearance(syncYarnResponse.data.yarn.apperance!),
      ]);
    });
*/
    return true;
  }

}