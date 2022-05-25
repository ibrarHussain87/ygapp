import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/model/request/sync_request/sync_request.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_sync/stocklot_sync_response.dart';

import '../../api_services/api_service_class.dart';
import '../../app_database/app_database_instance.dart';
import '../../helper_utils/app_constants.dart';
import '../../helper_utils/shared_pref_util.dart';
import '../../model/response/fabric_response/sync/fabric_sync_response.dart';

class SyncProvider extends ChangeNotifier {

  bool isDataSynced = false;
  bool loading = false;

  syncAppData(context) async {
    if(!isDataSynced){
      DialogBuilder(context).showSyncDialog();
      loading = true;
      isDataSynced = await _synData();
      loading = false;
      DialogBuilder(context).hideDialog();

      notifyListeners();
    }
  }

  Future<bool> _synData() async {
    bool dataSynced = await SharedPreferenceUtil.getBoolValuesSF(SYNCED_KEY);
    Logger().e(dataSynced.toString());
    if (!dataSynced) {
      await Future.wait([
        ApiService.syncFiber(SyncRequestModel(categoryId: '1')).then((
            syncFiberResponse) {
          if (syncFiberResponse.status) {
            AppDbInstance().getDbInstance().then((value) async {
              await Future.wait([
              value.fiberBlendsDao.insertAllFiberBlends(syncFiberResponse.data.fiber.fiberBlends),

              value.fiberSettingDao.insertAllFiberSettings(
              syncFiberResponse.data.fiber.settings),
              value.gradesDao
                  .insertAllGrades(syncFiberResponse.data.fiber.grades),
              value.fiberFamilyDao.insertAllFiberNatures(
              syncFiberResponse.data.fiber.fiberFamily),

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
//              value.countriesDao
//                  .insertAllCountry(syncFiberResponse.data.fiber.countries),
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
              // value.packingDao.insertAllPacking(syncFiberResponse.data.fiber.packing
              // )
              ]
              );
            });
          }
        }),
        ApiService.syncYarn(SyncRequestModel(categoryId: '2')).then((
            syncYarnResponse) {
          if (syncYarnResponse.status!) {
            AppDbInstance().getDbInstance().then((value) async {
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
//                value.countriesDao
//                    .insertAllCountry(syncYarnResponse.data.yarn.countries!),
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
                value.dyingMethodDao.insertAllDyingMethod(
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
                // value.packingDao
                //     .insertAllPacking(syncYarnResponse.data.yarn.packing!)
              ]);
            });
          }
        }),
        ApiService.syncCall(SyncRequestModel(categoryId: '5')).then((
            StockLotSyncResponse response) {
          if (response.status!) {
            Logger().e(
                "Sync got successfully : " + response.toJson().toString());
            AppDbInstance().getDbInstance().then((value) async {
              await Future.wait([
                value.stocklotCategoriesDao.insertAllStocklotCategories(
                    response.data!.stocklot!.stocklots!),
                // if(response.data!.stocklot!.stocklots != null) value.stocklotDao
                //     .insertAllStocklots(response.data!.stocklot!.stocklots!),
                value.availabilityDao.insertAllAvailability(
                    response.data!.stocklot!.availabilityList!),
                value.priceTermsDao.insertAllFPriceTerms(
                    response.data!.stocklot!.priceTerms!),
                value.lcTypeDao.insertAllLcType(
                    response.data!.stocklot!.lcTypes!),
                value.paymentTypeDao.insertAllPaymentType(
                    response.data!.stocklot!.paymentTypes!)
              ]);
            });
          }
        }),
        ApiService.syncFabricCall(SyncRequestModel(categoryId: '3')).then((
            FabricSyncResponse response) {
          if (response.status!) {
            Logger().e("Fabric Sync got successfully : " +
                response.toJson().toString());
            AppDbInstance().getDbInstance().then((value) async {
              await Future.wait([
                value.fabricSettingDao.insertAllFabricSettings(
                    response.data!.fabric!.setting!),
                value.fabricFamilyDao.insertAllFabricFamily(
                    response.data!.fabric!.family!),
                value.fabricBlendsDao.insertAllFabricBlends(
                    response.data!.fabric!.blends!),
                value.fabricAppearanceDao.insertAllFabricAppearance(
                    response.data!.fabric!.appearance!),
                value.knittingTypesDao.insertAllKnittingTypes(
                    response.data!.fabric!.knittingTypes!),
                value.fabricPlyDao.insertAllFabricPly(
                    response.data!.fabric!.ply!),
                value.fabricColorTreatmentMethodDao
                    .insertAllFabricFiberColorTreatmentMethod(
                    response.data!.fabric!.colorTreatmentMethod!),
                value.fabricDyingTechniqueDao.insertAllFabricDyingTechnique(
                    response.data!.fabric!.dyingTechniques!),
                value.fabricQualityDao.insertAllFabricQuality(
                    response.data!.fabric!.quality!),
                value.fabricGradesDao.insertAllFabricGrade(
                    response.data!.fabric!.grades!),
                value.fabricLoomDao.insertAllFabricLoom(
                    response.data!.fabric!.loom!),
                value.fabricSalvedgeDao.insertAllFabricSalvedge(
                    response.data!.fabric!.salvedge!),
                value.fabricWeaveDao.insertAllFabricWeave(
                    response.data!.fabric!.weave!),
                value.fabricLayyerDao.insertAllFabricLayyer(
                    response.data!.fabric!.layyer!),
                value.fabricDenimTypesDao.insertAllFabricDenimTypes(
                    response.data!.fabric!.denimTypes!),
                value.deliveryPeriodDao.insertAllDeliveryPeriods(
                    response.data!.fabric!.deliveryPeriod!)
              ]);
            });
          }
        }),

        // For getting countries
//        ApiService.syncCountriesCall().then((
//            CountriesSyncResponse response) {
//          if (response.status!) {
//            Logger().e("Countries Sync got successfully : " +
//                response.toString());
//            AppDbInstance().getDbInstance().then((value) async {
//              await Future.wait([
//                value.countriesDao
//                    .insertAllCountry(response.data!.countries),
//              ]);
//            });
//          }
//        })


      ]);
      SharedPreferenceUtil.addBoolToSF(SYNCED_KEY, true);
    }

    /*  AppDbInstance().getDbInstance().then((value) async {

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