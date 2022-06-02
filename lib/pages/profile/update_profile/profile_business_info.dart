

import 'package:flutter/foundation.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/model/pre_login_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/pages/profile/update_profile/user_notifier.dart';

import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/request/update_profile/update_business_request.dart';
import '../../../model/response/common_response_models/companies_reponse.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../../auth_pages/signup/country_search_page.dart';

class ProfileBusinessInfoPage extends StatefulWidget {
  final Function? callback;
  final String? selectedTab;
  const ProfileBusinessInfoPage({Key? key,
    required this.callback,
    required this.selectedTab}) : super(key: key);

  @override
  ProfileBusinessInfoPageState createState() => ProfileBusinessInfoPageState();
}

class ProfileBusinessInfoPageState extends State<ProfileBusinessInfoPage> with AutomaticKeepAliveClientMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> bussinessFormKey = GlobalKey<FormState>();

  late UpdateBusinessRequestModel _updateBusinessRequestModel;
  String? companyCountryName ;
  String? countryId ;
  Designations? designations;
  String companyStateName = "";
  int companyStateId = 0;
  int selectedValue = 1;
  States? state;
  Cities? city;
 List<Designations> designationsList = [];
  List<Countries> countriesList = [];
  List<States> cityStateList = [];
  List<Cities> citiesList = [];
  List<Companies> companiesList = [];
  List<GenericCategories> categoriesList = [];
  final _companyTypeAheadController=TextEditingController();
  @override
  void initState() {

    _updateBusinessRequestModel = UpdateBusinessRequestModel();
//    courts = BrandsRequestModel.fromJson(json.decode(source)).map<BrandsRequestModel>((json) {return BrandsRequestModel.fromJson(json);}).toList();
    AppDbInstance().getDbInstance().then((value) => {
      value.countriesDao.findAllCountries().then((value) {
        setState(() {
          countriesList = value;
        });
      }),
      value.statesDao.findAllStates().then((value) {
        setState(() {
          cityStateList = value;
        });
      }),

      value.citiesDao.findAllCities().then((value) {
        setState(() {
          citiesList = value;
        });
      }),

      value.designationsDao.findAllDesignations().then((value) {
        setState(() {
          designationsList = value;
        });
      }),

      value.companiesDao.findAllCompanies().then((value) {
        setState(() {
          companiesList=value;
        });
      }),
      value.genericCategoriesDao.findAllGenericCategories().then((value) {
        setState(() {
          categoriesList=value;
        });
      }),

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print("business");
    return SafeArea(
      child: FutureBuilder<BusinessInfo?>(
        future: AppDbInstance().getDbInstance()
            .then((value) => value.businessInfoDao.getBusinessInfo()),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
             designations=designationsList.where((element) => element.designationId.toString()==snapshot.data?.designation_idfk).single;
             _updateBusinessRequestModel.designation_idfk=snapshot.data?.designation_idfk;
             _updateBusinessRequestModel.city=snapshot.data?.city;
             companyCountryName=countriesList.where((element) => element.conId.toString()==snapshot.data?.countryId).first.conName;
             _updateBusinessRequestModel.countryId=snapshot.data?.countryId;
             city?.cityName=snapshot.data!.city;
             state=cityStateList.where((element) => element.stateId.toString()==snapshot.data?.cityStateId).single;
             city=citiesList.where((element) => element.cityId.toString()==snapshot.data?.city).single;
             _companyTypeAheadController.text=snapshot.data!.name!;
             return Scaffold(
//              key: scaffoldKey,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
//              appBar: AppBar(
//                backgroundColor: Colors.white,
//                centerTitle: true,
//                leading: GestureDetector(
//                  behavior: HitTestBehavior.opaque,
//                  onTap: () {
//                    Navigator.pop(context);
//                  },
//                  child: Padding(
//                      padding: EdgeInsets.all(12.w),
//                      child: Card(
//                        child: Padding(
//                            padding: EdgeInsets.only(left: 4.w),
//                            child: Icon(
//                              Icons.arrow_back_ios,
//                              color: Colors.black,
//                              size: 12.w,
//                            )),
//                      )),
//                ),
//                title: Text('Update Profile',
//                    style: TextStyle(
//                        fontSize: 16.0.w,
//                        color: appBarTextColor,
//                        fontWeight: FontWeight.w400)),
//              ),
              body: Column(
                children: [
                  Form(
                    key: bussinessFormKey,
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Builder(builder: (BuildContext context2) {
                            return buildBusinessDataColumn(snapshot, context2);
                          }),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;

  Column buildBusinessDataColumn(AsyncSnapshot<BusinessInfo?> snapshot, BuildContext context2)
  {

//    var userNotifier = context2.watch<UserNotifier>();
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.only(top: 30.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                // For changing initial value
//                  key: Key(userNotifier.getUser().businessInfo.ntn_number.toString()),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,

                  initialValue:  snapshot.data?.ntn_number ?? '',
                  onSaved: (input) =>
                  _updateBusinessRequestModel.ntn_number = input! /*'44'*/,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter ntn number";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter NTN No.', "GST (NTN Number)")),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

//              TextFormField(
//                  keyboardType: TextInputType.text,
//                  cursorColor: Colors.black,
////                  initialValue: snapshot.data!.businessInfo?.name ?? '',
//                  initialValue: BusinessInfo.fromJson(jsonDecode(snapshot.data!.businessInfo!)).name ?? '',
//                  onSaved: (input) =>
//                  _updateBusinessRequestModel.name = input!,
//                  validator: (input) {
//                    if (input == null || input.isEmpty) {
//                      return "Please enter company name";
//                    }
//                    return null;
//                  },
//                  decoration: textFieldProfile(
//                      'Enter Company Name', "Company Name")
//              ),

              TypeAheadFormField(
//                  initialValue: snapshot.data?.name ?? '',
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _companyTypeAheadController,
                    decoration: textFieldProfile(
                        'Enter Company Name', "Company Name"),
                  ),
                  suggestionsCallback: (pattern) {
                    return companiesList.where(
                            (Companies x) => x.name.toString().toLowerCase().contains(pattern)
                    ).toList();
                  },
                  itemBuilder: (context,suggestion) {
                    return ListTile(
                      title: Text(suggestion.toString()),
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  hideSuggestionsOnKeyboardHide: true,
                  onSuggestionSelected: (Companies suggestion) {
                    _companyTypeAheadController.text = suggestion.name.toString();
//                    _signupRequestModel?.comapnyId=suggestion.id.toString();
                    _updateBusinessRequestModel.company=suggestion.name.toString();
                    _updateBusinessRequestModel.name=suggestion.name.toString();
//                    _signupRequestModel!.otherCompany = "0";
                  },
                  errorBuilder:(BuildContext context, Object? error) =>
                      Text(
                          '$error',
                          style: TextStyle(
                              color: Theme.of(context).errorColor
                          )
                      ),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter company name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (kDebugMode) {
                      print("Value"+value.toString());
                    }
                    _updateBusinessRequestModel.company = value;
                    _updateBusinessRequestModel.name = value;
//                  if(companiesList.where((element) => element.name == value).toList().isEmpty){
//                    _signupRequestModel!.otherCompany = "1";
//                  }
                  }

              ),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

//              TextFormField(
//                  keyboardType: TextInputType.text,
//                  cursorColor: Colors.black,
//                  initialValue: '',
//                  /*onSaved: (input) =>
//                                          _signupRequestModel.name = input!,*/
//                  validator: (input) {
//                    /*if (input == null ||
//                                                input.isEmpty) {
//                                              return "Please enter trade mark";
//                                            }*/
//                    return null;
//                  },
//                  decoration: textFieldProfile(
//                      'Enter Business Area', "Business Area")),

              DropdownButtonFormField<GenericCategories>(

                decoration:dropDownProfile(
                    'Select', "Business Area"),
                isDense: true,
                isExpanded: true,
                iconSize: 21,
                items:categoriesList.map((location) {
                  return DropdownMenuItem<GenericCategories>(
                    child: Text(location.catName.toString()),
                    value: location,

                  );
                }).toList(),

                onChanged: (newValue) {
//                  _signupRequestModel?.cityStateId=newValue?.catId.toString();
                },
                validator: (input) {
                  if (input == null) {
                    return "Please select business area";
                  }
                  return null;
                },

              ),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
//                  initialValue:snapshot.data?.businessInfo?.trade_mark,
                  initialValue:snapshot.data?.trade_mark ?? '',
                  onSaved: (input) => _updateBusinessRequestModel.trade_mark = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter trade mark";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Trade Mark', "Trade Mark")),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
//                  initialValue:snapshot.data?.businessInfo?.employmentRole,
                  initialValue:snapshot.data?.employmentRole ?? '',
                  onSaved: (input) => _updateBusinessRequestModel.employment_role = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter employment role";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Role', "Employment Role")),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              DropdownButtonFormField<Designations?>(

                decoration: dropDownProfile(
                    'Select', "Designation") ,
                isDense: true,
                hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                isExpanded: true,
                iconSize: 21,
                items:designationsList.map((location) {
                  return DropdownMenuItem<Designations?>(
                    child: Text(location.designationTitle ?? Utils.checkNullString(false)),
                    value: location,

                  );
                }).toList(),
                value: designations,
                onChanged: (Designations? value) {
                  designations=value;
                  _updateBusinessRequestModel.designation_idfk=value?.designationId.toString();
                },


                validator: (value) => value == null ? 'PLease select designation' : null,

              ),

            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  onSaved: (input) => _updateBusinessRequestModel.address = input!,
//                  initialValue:snapshot.data?.businessInfo?.address,
                  initialValue:snapshot.data?.address ?? '',
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter address";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Company Address")),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectCountryPage(title:"Country",isCodeVisible: false, callback:(Countries value)=>{
                        setState(() {

                          FocusScope.of(context)
                              .requestFocus(
                              FocusNode());
                          _updateBusinessRequestModel.countryId = value.conId.toString();
                          countryId = value.conId.toString();
                          companyCountryName = value.conName.toString();
                        }
                        )
                      },
                      ),
                    ),
                  );
                },
                child: InputDecorator(
                  decoration:InputDecoration(
                      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text("Company Country"),
                          Text("*", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      suffixIcon:const Icon(Icons.arrow_drop_down,color: Colors.black54,),
                      floatingLabelBehavior:FloatingLabelBehavior.always ,
                      hintText: "Select",
                      hintStyle:  TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
                      border: OutlineInputBorder(
                          borderRadius:const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(color: newColorGrey)
                      )
                  ),

                  child: Row(
                    children: [

                      Expanded(
                          flex:8,
                          child: Text(
                            companyCountryName ?? "Select Country",textAlign: TextAlign.start,)),

                    ],
                  ),
                ),
              ),


            ],
          ),
        ),




        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                hint: const Text('Select State'),
                items: cityStateList
                    .where((element) =>
                element
                    .countryIdfk ==
                    _updateBusinessRequestModel.countryId
                        .toString())
                    .toList()
                    .map((value) =>
                    DropdownMenuItem(
                      child: Text(
                          value.stateName ??
                              Utils.checkNullString(
                                  false),
                          textAlign:
                          TextAlign
                              .center),
                      value: value,
                    ))
                    .toList(),
                isExpanded: true,
                value: state,
                onChanged: (States? value) {
                  setState(() {
                    FocusScope.of(context)
                        .requestFocus(
                        FocusNode());
                    state=value;
                    _updateBusinessRequestModel.cityStateId =
                        value!.stateId.toString();
                  });
                },

                decoration: dropDownProfile(
                    'Select', "Company State/District"),
                validator: (value) => value == null ? 'Please select sate/district' : null,
              ),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                hint: const Text('Select City'),
                items: citiesList
                    .where((element) =>
                element.stateIdfk ==
                    state?.stateId
                        .toString())
                    .toList()
                    .map((value) =>
                    DropdownMenuItem(
                      child: Text(
                          value.cityName.toString(),
                          textAlign:
                          TextAlign
                              .center),
                      value: value,
                    ))
                    .toList(),
                isExpanded: true,
                value: city,
                onChanged: (Cities? value) {
                  FocusScope.of(context)
                      .requestFocus(
                      FocusNode());
                  _updateBusinessRequestModel.city =
                      value?.cityId.toString();
                },

                decoration: dropDownProfile(
                    'Select', "City"),
                validator: (value) => value == null ? 'Please select city' : null,
              ),

            ],
          ),
        ),



        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  onSaved: (input) => _updateBusinessRequestModel.postalCode = input!,
//                  initialValue: snapshot.data!.businessInfo?.postalCode ?? '',
                  initialValue: snapshot.data?.postalCode ?? '',
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter zip code";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Company Zip Code")),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
//                  initialValue:snapshot.data?.businessInfo?.website ?? '',
                  initialValue:snapshot.data?.website ?? '',
                  onSaved: (input) =>
                  _updateBusinessRequestModel.website = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter web url";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Website")),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.w),
          child: SizedBox(
              width: double.infinity,
              child: Builder(builder: (BuildContext context1) {
                return ElevatedButton(
                    child: Text("Submit",
                        style: TextStyle(
                          /*fontFamily: 'Metropolis',*/ fontSize: 14.sp)),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(btnColorLogin),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                                side: BorderSide(color: Colors.transparent)))),
                    onPressed: () {
                      if (validateAndSaveBusinessInfo()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _updateBusinessCall(snapshot.data, context1);
                      }
                    });
              })),
        ),
      ],
    );
  }





  bool validateAndSaveBusinessInfo() {
    final form = bussinessFormKey.currentState;
    if (_updateBusinessRequestModel.countryId == null || _updateBusinessRequestModel.countryId=="") {
      Ui.showSnackBar(context, "Please select country");
      return false;
    }
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _updateBusinessCall(BusinessInfo? businessInfo, BuildContext context1) {
    if (businessInfo != null) {
      check().then((value) {
        if (value) {
          ProgressDialogUtil.showDialog(context, 'Please wait...');

          Logger().e(_updateBusinessRequestModel.toJson());
          ApiService.updateBusinessInfo(_updateBusinessRequestModel).then((value) {
            Logger().e(value.toJson());
            ProgressDialogUtil.hideDialog();
//            if (value.errors != null) {
//              value.errors!.forEach((key, error) {
//                ScaffoldMessenger.of(context)
//                    .showSnackBar(SnackBar(content: Text(error.toString())));
//              });
//            } else
            if (value.status!) {
              AppDbInstance().getDbInstance().then((db) async {
                await db.businessInfoDao.insertBusinessInfo(value.data!.businessInfo!);
              });


              Fluttertoast.showToast(
                  msg: value.message ?? "",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1);
              /*Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainPage()),
                      (Route<dynamic> route) => false);*/
//              var userNotifier = context1.read<UserNotifier>();
//              userNotifier.updateUser(value.data!);
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value.message ?? "")));
            }
          }).onError((error, stackTrace) {
            ProgressDialogUtil.hideDialog();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error.toString())));
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("No internet available.".toString())));
        }
      });
    }
  }

  void handleNextClick() {
    widget.callback!(2);

  }

  _resetData() {

  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class TagModel {
  String? id;
  String? title;

  TagModel({
    @required this.id,
    @required this.title,
  });
}
