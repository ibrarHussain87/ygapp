import 'package:flutter/material.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
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

  getPersonalInfoData() {
    if (user != null) {
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
  {
    if(user?.businessInfo!=null)
    {
      if (user?.businessInfo!.countryId != null && countriesList.isNotEmpty &&
          countriesList != null) {
        updateBusinessRequestModel.countryId=
            user?.businessInfo!.countryId.toString();
        selectedCompanyCountry =
            countriesList.firstWhere((element) =>
            element.conId.toString() ==
                user?.businessInfo!.countryId.toString());
      }

      if (user?.businessInfo!.cityStateId != null && statesList.isNotEmpty &&
          statesList != null) {
        updateBusinessRequestModel.cityStateId=
            user?.businessInfo!.cityStateId.toString();
        selectedCompanyState =
            statesList.firstWhere((element) =>
            element.stateId.toString() ==
                user?.businessInfo!.cityStateId.toString());
      }

      if (user?.businessInfo!.city != null && citiesList.isNotEmpty &&
          citiesList != null) {
        updateBusinessRequestModel.city=
            user?.businessInfo!.city.toString();
        selectedCompanyCity =
            citiesList.firstWhere((element) =>
            element.cityId.toString() ==
                user?.businessInfo!.city.toString());
      }

      if (user?.businessInfo!.designation_idfk != null && designationsList.isNotEmpty &&
          designationsList != null) {
        updateBusinessRequestModel.designation_idfk=
            user?.businessInfo!.designation_idfk.toString();
        selectedDesignation =
            designationsList.firstWhere((element) =>
            element.designationId.toString() ==
                user?.businessInfo!.designation_idfk.toString());
      }

      if (user?.businessInfo!.name != null && companiesList.isNotEmpty &&
          companiesList != null) {
        updateBusinessRequestModel.name=
            user?.businessInfo!.name.toString();
        updateBusinessRequestModel.company=
            user?.businessInfo!.name.toString();
        selectedCompany =
            companiesList.firstWhere((element) =>
            element.name.toString() ==
                user?.businessInfo!.name.toString());
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
}
