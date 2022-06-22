import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/model/pre_login_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';

import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../locators.dart';
import '../../../model/request/update_profile/update_business_request.dart';
import '../../../model/response/common_response_models/companies_reponse.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../../../providers/profile_providers/profile_info_provider.dart';
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
  final GlobalKey<FormFieldState> _provinceKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cityKey = GlobalKey<FormFieldState>();
  final _profileInfoProvider = locator<ProfileInfoProvider>();
  late UpdateBusinessRequestModel _updateBusinessRequestModel;
  int selectedValue = 1;
  final _companyTypeAheadController=TextEditingController();
  @override
  void initState() {
    super.initState();

    _profileInfoProvider.addListener(() {
      updateUI();
    });

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // _profileInfoProvider.getSyncedData();
      _updateBusinessRequestModel = _profileInfoProvider.updateBusinessRequestModel;
      _companyTypeAheadController.text=_profileInfoProvider.businessInfo?.name!=null ? _profileInfoProvider.businessInfo!.name.toString() : '';

    });
  }

  updateUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return SafeArea(
      child:Scaffold(
//              key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Form(
              key: bussinessFormKey,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Builder(builder: (BuildContext context2) {
                      return (!_profileInfoProvider.isLoading) ? buildBusinessDataColumn(_profileInfoProvider.businessInfo, context2) : Container();
                    }),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;

  Column buildBusinessDataColumn(BusinessInfo? snapshot, BuildContext context2)
  {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.only(top: 30.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                // For changing initial value
//                  key: Key(userNotifier.getUser().businessInfo.ntn_number.toString()),
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
//                  controller: ntnController,
                  initialValue:  snapshot?.ntn_number ?? '',
                  onSaved: (input) =>
                  _updateBusinessRequestModel.ntn_number = input! /*'44'*/,
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter ntn number";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldDecoration(
                      '', "GST (NTN Number)",false)),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              TypeAheadFormField(
//                  initialValue: snapshot.data?.name ?? '',
                  textFieldConfiguration: TextFieldConfiguration(
                    style: TextStyle(fontSize: 13.sp),
                    controller: _companyTypeAheadController,
                    decoration: textFieldDecoration(
                        '', "Company Name",true),
                  ),
                  noItemsFoundBuilder: (BuildContext context) {
                    return const Text('');
                  },
                  suggestionsCallback: (pattern) {
                    return _profileInfoProvider.companiesList.where(
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
                    _updateBusinessRequestModel.company=suggestion.name.toString();
                    _updateBusinessRequestModel.companyName=suggestion.name.toString();
                    _updateBusinessRequestModel.name=suggestion.name.toString();
                    _updateBusinessRequestModel.companyId=suggestion.id.toString();

                  },
                  errorBuilder:(BuildContext context, Object? error) =>
                      Text(
                          '$error',
                          style: TextStyle(fontSize: 13.sp,
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
                    _updateBusinessRequestModel.company = value;
                    _updateBusinessRequestModel.companyName = value;
                    // _updateBusinessRequestModel.companyId = _profileInfoProvider.selectedCompany!.id.toString();
                    _updateBusinessRequestModel.name = value;
                    // _updateBusinessRequestModel.otherCompany = "1";
                  }

              ),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              DropdownButtonFormField<GenericCategories>(
                decoration:textFieldDecoration(
                    'Select Business Area', "Business Area",false),
                isDense: true,
                isExpanded: true,
                iconSize: 21,
                items:_profileInfoProvider.categoriesList.map((location) {
                  return DropdownMenuItem<GenericCategories>(
                    child: Text(location.catName.toString(),style: TextStyle(fontSize: 13.sp)),
                    value: location,

                  );
                }).toList(),

                onChanged: (newValue) {
                  _updateBusinessRequestModel.ubi_business_area_idfk = newValue!.catId!.toString();
                },
                // validator: (input) {
                //   if (input == null) {
                //     return "Please select business area";
                //   }
                //   return null;
                // },

              ),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
//                  initialValue:snapshot.data?.businessInfo?.trade_mark,
                  initialValue:snapshot?.trade_mark ?? '',
//              controller: tradeController,
                  onSaved: (input) => _updateBusinessRequestModel.trade_mark = input!,
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter trade mark";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldDecoration(
                      '', "Trade Mark",false)),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
//                  initialValue:snapshot.data?.businessInfo?.employmentRole,
                  initialValue:snapshot?.employmentRole ?? '',
//                  controller: roleController,
                  onSaved: (input) => _updateBusinessRequestModel.employment_role = input!,
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter employment role";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldDecoration(
                      '', "Employment Role",false)),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              DropdownButtonFormField<Designations?>(
                decoration: textFieldDecoration(
                    'Select', "Designation",false) ,
                isDense: true,
                hint:Text("Select Designation",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500,color:hintColorGrey),),
                isExpanded: true,
                iconSize: 21,
                items:_profileInfoProvider.designationsList.map((location) {
                  return DropdownMenuItem<Designations?>(
                    child: Text(location.designationTitle ?? Utils.checkNullString(false),style: TextStyle(fontSize: 13.sp)),
                    value: location,

                  );
                }).toList(),
                value: _profileInfoProvider.selectedDesignation,
                onChanged: (Designations? value) {
                  _profileInfoProvider.selectedDesignation=value;
                  _updateBusinessRequestModel.designation_idfk=value?.designationId.toString();
                },


                // validator: (value) => value == null ? 'Please select designation' : null,

              ),

            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  onSaved: (input) => _updateBusinessRequestModel.address = input!,
//              controller: addressController,
                  initialValue:snapshot?.address ?? '',
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter address";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldDecoration(
                      '', "Company Address",false)),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectCountryPage(title:"Country",isCodeVisible: false, callback:(Countries value)=>{

                      FocusScope.of(context)
                          .requestFocus(
                      FocusNode()),
                          _profileInfoProvider.setSelectedCompanyCountry(value),
                          _updateBusinessRequestModel.countryId = value.conId.toString(),
                      _profileInfoProvider.selectedCompanyState=null,
                      _profileInfoProvider.selectedCompanyCity=null
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
                          Text("Company Country",style: TextStyle(color: Colors.black,fontSize: 13),),
                         Text("*", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black54,
                        ),
                      ),
                      floatingLabelBehavior:FloatingLabelBehavior.always ,
                      hintText: "Select",
                      hintStyle:  TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500,color:hintColorGrey),
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
                            _profileInfoProvider.selectedCompanyCountry?.conName  ?? "Select Country",textAlign: TextAlign.start,style: TextStyle(color:_profileInfoProvider.selectedCompanyCountry?.conName!=null ? Colors.black : newColorGrey,fontSize: 13.sp))),

                    ],
                  ),
                ),
              ),


            ],
          ),
        ),




        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                key:_provinceKey,
                hint:  Text('Select  State',style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500,color:hintColorGrey),),
                items:_profileInfoProvider.statesList
                    .where((element) =>
                     element
                    .countryIdfk ==
                    _profileInfoProvider.selectedCountry?.conId
                        .toString())
                    .toList()
                    .map((value) =>
                    DropdownMenuItem(
                      child: Text(
                          value.stateName ?? "",
                          textAlign:
                          TextAlign
                              .center,style: TextStyle(fontSize: 13.sp),),
                      value: value,
                    ))
                    .toList(),
                isExpanded: true,
                value: _profileInfoProvider.selectedCompanyState,
                onChanged: (States? value) {
                  FocusScope.of(context)
                      .requestFocus(
                      FocusNode());
                  _profileInfoProvider.selectedCompanyState=value;
                 _profileInfoProvider.selectedCompanyCity=null;
                  _updateBusinessRequestModel.cityStateId =
                      value!.stateId.toString();
                },

                decoration: textFieldDecoration(
                    'Select', "Company State/District",true),
                validator: (value) => value == null ? 'Please select sate/district' : null,
              ),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                key:_cityKey,
                hint: Text('Select City',style:TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500,color:hintColorGrey)),
                items: _profileInfoProvider.citiesList
                    .where((element) =>
                element.stateIdfk ==
                    _profileInfoProvider.selectedCompanyState?.stateId
                        .toString())
                    .toList()
                    .map((value) =>
                    DropdownMenuItem(
                      child: Text(
                          value.cityName.toString(),
                          textAlign:
                          TextAlign
                              .center,style: TextStyle(fontSize: 13.sp)),
                      value: value,
                    ))
                    .toList(),
                isExpanded: true,
                value: _profileInfoProvider.selectedCompanyCity,
                onChanged: (Cities? value) {
                  FocusScope.of(context)
                      .requestFocus(
                      FocusNode());
                  _profileInfoProvider.selectedCompanyCity=value;
                  _updateBusinessRequestModel.city =
                      value?.cityId.toString();
                },

                decoration: textFieldDecoration(
                    'Select', "City",true),
                validator: (value) => value == null ? 'Please select city' : null,
              ),

            ],
          ),
        ),



        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  onSaved: (input) => _updateBusinessRequestModel.postalCode = input!,
//                  initialValue: snapshot.data!.businessInfo?.postalCode ?? '',
                  initialValue: snapshot?.postalCode ?? '',
//                  controller: postalController,
//                   validator: (input) {
//                     if (input == null || input.isEmpty) {
//                       return "Please enter zip code";
//                     }
//                     return null;
//                   },
                  decoration: textFieldDecoration(
                      '', "Company Zip Code",false)),
            ],
          ),
        ),

        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
//                  initialValue:snapshot.data?.businessInfo?.website ?? '',
                  initialValue:snapshot?.website ?? '',
//                  controller: webController,
                  onSaved: (input) =>
                  _updateBusinessRequestModel.website = input!,
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter web url";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldDecoration(
                      '', "Website",false)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:14.w,bottom: 14.w),
          child: SizedBox(
              width: double.infinity,
              child: Builder(builder: (BuildContext context1) {
                return TextButton(
                    child: Text("Submit",
                        style: TextStyle(
                          /**/ fontSize: 14.sp)),
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
                        var contain = _profileInfoProvider.companiesList.where((element) => element.name == _updateBusinessRequestModel.company);
                        if(contain.isEmpty)
                          {
                            _updateBusinessRequestModel.companyId=null;
                          }
                        _updateBusinessCall(context1);
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

  void _updateBusinessCall(BuildContext context1) {
    check().then((value) {
      if (value) {
        ProgressDialogUtil.showDialog(context, 'Please wait...');

        Logger().e(_updateBusinessRequestModel.toJson());
        ApiService().updateBusinessInfo(_updateBusinessRequestModel).then((value) {
          Logger().e(value.toJson());
          ProgressDialogUtil.hideDialog();
          if (value.status!) {
            AppDbInstance().getDbInstance().then((db) async {
              await db.businessInfoDao.deleteBusinessInfoData();
              await db.businessInfoDao.insertBusinessInfo(value.data!.businessInfo!);
              Fluttertoast.showToast(
                  msg: value.message ?? "",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1);
            });
          } else {

            ProgressDialogUtil.hideDialog();
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

  void handleNextClick() {
    widget.callback!(2);

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
