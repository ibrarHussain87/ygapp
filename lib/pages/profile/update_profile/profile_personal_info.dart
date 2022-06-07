

import 'package:flutter/foundation.dart';
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
import 'package:yg_app/model/request/update_profile/update_profile_request.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/pages/profile/update_profile/user_notifier.dart';

import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../../auth_pages/signup/country_search_page.dart';

class ProfilePersonalInfoPage extends StatefulWidget {

  final Function? callback;
  final String? selectedTab;

  const ProfilePersonalInfoPage({Key? key,
    required this.callback,
    required this.selectedTab}) : super(key: key);

  @override
  ProfilePersonalInfoPageState createState() => ProfilePersonalInfoPageState();
}

class ProfilePersonalInfoPageState extends State<ProfilePersonalInfoPage>
    with AutomaticKeepAliveClientMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late UpdateProfileRequestModel _updateProfileRequestModel;
  String userName = "";
  String? countryName;
  String? countryId ;
  States? state;
  String? city;
  int stateId = 0;
  List<Countries> countriesList = [];
  List<States> cityStateList = [];
  List<Cities> citiesList = [];
  @override
  void initState() {
    _updateProfileRequestModel = UpdateProfileRequestModel();
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
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: FutureBuilder<User?>(
        future: AppDbInstance().getDbInstance()
            .then((value) => value.userDao.getUser()),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if(countriesList.isNotEmpty) {
              countryName = countryName = countriesList
                  .where((element) =>
              element.conId.toString() == snapshot.data?.countryId)
                  .first
                  .conName;
            }
        _updateProfileRequestModel.countryId=snapshot.data?.countryId;
        _updateProfileRequestModel.cityStateId=snapshot.data?.cityStateId;
        if(cityStateList.isNotEmpty) {
          state = cityStateList
              .where((element) =>
          element.stateId.toString() == snapshot.data?.cityStateId)
              .single;
        }
//         if(citiesList.isNotEmpty) {
//           city = citiesList
//               .where((element) =>
//           element.cityName.toString() == snapshot.data?.city)
//               .single;
//         }
        _updateProfileRequestModel.city=snapshot.data?.city;
        city=snapshot.data?.city;
            return Scaffold(
//                key: scaffoldKey,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Form(
                    key: globalFormKey,
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Builder(builder: (BuildContext context2) {
                            return buildUserDataColumn(snapshot, context2);
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


  Column buildUserDataColumn(
      AsyncSnapshot<User?> snapshot, BuildContext context2) {

    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.only(top: 30.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  initialValue: snapshot.data!.name ?? '',
                  onSaved: (input) =>
                  _updateProfileRequestModel.name = input!,
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter name";
                    }*/
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Name', "Name")),
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
                  onSaved: (input) =>
                  _updateProfileRequestModel.address = input!,
                  initialValue:snapshot.data?.address ?? '',
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter address";
                    }*/
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Address")),
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
                          _updateProfileRequestModel.countryId =
                              value.conId.toString();
                          countryName =
                              value.conName.toString();
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
                          Text("Country",style: TextStyle(fontSize: 13)),
                          /*Text("*", style: TextStyle(color: Colors.red)),*/
                        ],
                      ),
                      suffixIcon:const Icon(Icons.arrow_drop_down,color: Colors.black54,),
                      floatingLabelBehavior:FloatingLabelBehavior.always ,
                      hintText: "Select",
                      hintStyle:  TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500,color:Colors.black),
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
                            countryName ?? "Select Country",textAlign: TextAlign.start,style: const TextStyle(fontSize: 13),)),
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
                hint: const Text('Select State',style: TextStyle(fontSize: 13,color: Colors.black)),
                items: cityStateList
                    .where((element) =>
                element
                    .countryIdfk ==
                    _updateProfileRequestModel.countryId
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
                              .center,style: const TextStyle(fontSize: 13)),
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

//                        citiesList=citiesList
//                            .where((element) =>
//                        element.stateIdfk ==
//                            value?.stateId
//                                .toString())
//                            .toList();
                        print("cities"+citiesList.toString());
                        _updateProfileRequestModel.city=null;
                    _updateProfileRequestModel.cityStateId =
                        value?.stateId.toString();
                  });
                },
                decoration: dropDownProfile(
                    'Select', "State/District"),
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
                hint: const Text('Select City',style: TextStyle(fontSize: 13,color: Colors.black)),
                items: citiesList
                    .where((element) =>
                element.stateIdfk ==
                    state?.stateId
                        .toString())
                    .toList()
                    .map((value) =>
                    DropdownMenuItem(
                      child: Text(
                          value.cityName ??  Utils.checkNullString(
                              false),
                          textAlign: TextAlign.center,style: const TextStyle(fontSize: 13)),
                      value: value.cityName,
                    ))
                    .toList(),
                isExpanded: true,
                value:city,
                onChanged: (String? value) {
                  setState(() {
                    FocusScope.of(context)
                        .requestFocus(
                        FocusNode());
                    city=value;
                    _updateProfileRequestModel.city =
                        value?.toString();
                  });
                },
                decoration: dropDownProfile(
                    'Select', "City"),
                validator: (value) => value == null || _updateProfileRequestModel.city==null ? 'Please select city' : null,
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
                  onSaved: (input) => _updateProfileRequestModel.postalCode = input!,
                  initialValue: snapshot.data!.postalCode ?? '',
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter zip code";
                    }*/
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Postal Code")),
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
                  initialValue:snapshot.data?.whatsApp ?? '',
                  onSaved: (input) => _updateProfileRequestModel.whatsapp = input!,
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter whatsapp number";
                    }*/
                    return null;
                  },
                  decoration: textFormWhatsAppProfile(
                      '+92 |', "WhatsApp")),
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
                  initialValue: snapshot.data!.telephoneNumber ?? '',
                  onSaved: (input) =>
                  _updateProfileRequestModel.telephoneNumber = input!,
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter number";
                    }*/
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Telephone")),
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
//                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  initialValue: snapshot.data!.email ?? '',
                  onSaved: (input) => _updateProfileRequestModel.email = input!,
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    /*if (input == null ||
                        input.isEmpty ||
                        !input.isValidEmail()) {
                      return "Please check your email";
                    }*/
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Email")),
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
                            fontFamily: 'Metropolis', fontSize: 14.sp)),
                    style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(btnColorLogin),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(6)),
                                side: BorderSide(color: Colors.transparent)))),
                    onPressed: () {
                      if (validateAndSave()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _updateProfileCall(snapshot.data, context1);
                      }
                    });
              })),
        ),
      ],
    );
  }


  void handleNextClick() {
      widget.callback!(1);

  }


  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (_updateProfileRequestModel.countryId == null || _updateProfileRequestModel.countryId=="") {
      Ui.showSnackBar(context, "Please select country");
      return false;
    }
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }


  void _updateProfileCall(User? user, BuildContext context1) {
    if (user != null) {
      check().then((value) {
        if (value) {
          ProgressDialogUtil.showDialog(context, 'Please wait...');

          Logger().e(_updateProfileRequestModel.toJson());
          ApiService.updateProfile(_updateProfileRequestModel).then((value) {

            ProgressDialogUtil.hideDialog();
//            if (value.errors != null) {
//              value.errors!.forEach((key, error) {
//                ScaffoldMessenger.of(context)
//                    .showSnackBar(SnackBar(content: Text(error.toString())));
//              });
//            } else
            if (value.status!) {
              AppDbInstance().getDbInstance().then((db) async {
//                await db.userDao.insertUser(value.data!.user!);
                await db.userDao.insertUser(value.data!);
              });


              Fluttertoast.showToast(
                  msg: value.message ?? "",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1);
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

  @override
  bool get wantKeepAlive => true;


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
