import 'package:flutter/material.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/model/pre_login_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';

import 'package:yg_app/model/request/update_profile/update_profile_request.dart';
import '../../model/request/update_profile/update_business_request.dart';
import '../../model/response/common_response_models/companies_reponse.dart';
import '../../model/response/login/login_response.dart';

class ProfileInfoProvider extends ChangeNotifier {

  UpdateProfileRequestModel updateProfileRequestModel = UpdateProfileRequestModel();
  UpdateBusinessRequestModel updateBusinessRequestModel = UpdateBusinessRequestModel();
  bool isLoading = true;
  User? user;
  BusinessInfo? businessInfo;
  List<Countries> countriesList = [];
  List<States> statesList = [];
  List<Cities> citiesList = [];
  List<Designations> designationsList = [];
  List<GenericCategories> categoriesList = [];
  List<Companies> companiesList = [];


  Countries? selectedCountry;
  Cities? selectedCity;
  States? selectedState;
  Countries? selectedCompanyCountry;
  Cities? selectedCompanyCity;
  States? selectedCompanyState;
  Designations? selectedDesignation;
  Companies? selectedCompany;



  getSyncedData() async {
    isLoading=true;
    notifyUI();
    var dbInstance = await AppDbInstance().getDbInstance();
    user = await dbInstance.userDao
        .getUser();
    businessInfo = await dbInstance.businessInfoDao
        .getBusinessInfo();

    countriesList = await dbInstance.countriesDao
        .findAllCountries();
    statesList = await dbInstance.statesDao
        .findAllStates();
    citiesList = await dbInstance.citiesDao.findAllCities();
    designationsList = await dbInstance.designationsDao
        .findAllDesignations();
    categoriesList = await dbInstance.genericCategoriesDao.findAllGenericCategories();
    companiesList = await dbInstance.companiesDao
        .findAllCompanies();
    getPersonalInfoData();
    getBusinessInfoData();
    isLoading=false;
    notifyUI();
  }

  getPersonalInfoData() async {
    if (user != null) {

      var dbInstance = await AppDbInstance().getDbInstance();
      if (user!.countryId != null && countriesList.isNotEmpty &&
          countriesList != null) {
        updateProfileRequestModel.countryId=
            user!.countryId.toString();
        selectedCountry =
            countriesList.firstWhere((element) =>
            element.conId.toString() ==
                user!.countryId.toString());
      }

      if (user!.cityStateId != null && statesList.isNotEmpty &&
          statesList != null) {
        updateProfileRequestModel.cityStateId=
            user!.cityStateId.toString();
        selectedState =
            statesList.firstWhere((element) =>
            element.stateId.toString() ==
                user!.cityStateId.toString());
      }

      if (user!.city != null && citiesList.isNotEmpty &&
          citiesList != null) {
        updateProfileRequestModel.city=
            user!.city.toString();
        selectedCity =
            citiesList.firstWhere((element) =>
            element.cityName.toString() ==
                user!.city.toString());
      }
      notifyUI();
    }
  }
  getBusinessInfoData()
  async {

    if(businessInfo!=null)
    {

      var dbInstance = await AppDbInstance().getDbInstance();
      if (businessInfo!.countryId != null) {
        updateBusinessRequestModel.countryId=
            businessInfo!.countryId.toString();
        selectedCompanyCountry =await dbInstance.countriesDao
            .findYarnCountryWithId(int.parse(businessInfo!.countryId.toString()));


      }

      if (businessInfo!.cityStateId != null) {
        updateBusinessRequestModel.cityStateId=
          businessInfo!.cityStateId.toString();
        selectedCompanyState =await dbInstance.statesDao
            .findStatesWithId(int.parse(businessInfo!.cityStateId.toString()));
      }

      if (businessInfo!.city != null ) {
        updateBusinessRequestModel.city=
            businessInfo!.city.toString();
        selectedCompanyCity = await dbInstance.citiesDao
            .findCitiesWithId(int.parse(businessInfo!.city.toString()));
      }

      if (businessInfo!.designation_idfk != null ) {
        updateBusinessRequestModel.designation_idfk=
            businessInfo!.designation_idfk.toString();
        selectedDesignation =await dbInstance.designationsDao
            .findDesignationsWithId(int.parse(businessInfo!.designation_idfk.toString()));
      }

      if (businessInfo!.name != null) {
        updateBusinessRequestModel.name=
          businessInfo!.name.toString();
        updateBusinessRequestModel.company=
           businessInfo!.name.toString();
        var companies = await dbInstance.companiesDao.findAllCompanies();
        selectedCompany = companies.where((element) => element.name == businessInfo!.name).toList().first;
      }

      notifyUI();
    }
  }



  setSelectedState(States state) {
    selectedState = state;
    notifyUI();
  }


  setSelectedCountry(Countries country)  {
    selectedCountry=country;
    notifyUI();
  }

  setSelectedCompanyCountry(Countries country)  {
    selectedCompanyCountry=country;
    notifyUI();
  }



  notifyUI() {
    notifyListeners();
  }

  resetData() {
    companiesList = [];
    countriesList = [];
    citiesList = [];
    statesList = [];
    categoriesList = [];
    isLoading = false;
    user=null;
    selectedCountry=null;
    selectedCity=null;
    selectedState=null;
    selectedCompanyCountry=null;
    selectedCompanyCity=null;
    selectedCompanyState=null;
    selectedDesignation=null;
    selectedCompany=null;
    updateBusinessRequestModel = UpdateBusinessRequestModel();
    updateProfileRequestModel = UpdateProfileRequestModel();
    notifyUI();
  }

}
