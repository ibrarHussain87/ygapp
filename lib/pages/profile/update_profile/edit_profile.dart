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
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/request/update_profile/update_profile_request.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/pages/profile/profile_segment_component.dart';
import 'package:yg_app/pages/profile/update_profile/user_notifier.dart';

import '../../main_page.dart';
import '../../market_pages/common_components/offering_requirment__segment_component.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  late UpdateProfileRequestModel _updateProfileRequestModel;
  String userName = "";
  String countryName = "";
  String stateName = "";
  int stateId = 0;
  List<String> roleList = ["Developer","Engineer","Manager","Director","CEO"];

  @override
  void initState() {
    _updateProfileRequestModel = UpdateProfileRequestModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: FutureBuilder<User?>(
        future: AppDbInstance.getDbInstance()
            .then((value) => value.userDao.getUser()),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ChangeNotifierProvider(
              create: (context) => UserNotifier(snapshot.data!),
              lazy: false,
              child: Scaffold(
                key: scaffoldKey,
                resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  leading: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Card(
                          child: Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                                size: 12.w,
                              )),
                        )),
                  ),
                  title: Text('Update Profile',
                      style: TextStyle(
                          fontSize: 16.0.w,
                          color: appBarTextColor,
                          fontWeight: FontWeight.w400)),
                ),
                body: Column(
                  children: [
                    const SizedBox(height: 14.0,),
                Padding(
                  padding: EdgeInsets.only(left: 18.w, right: 18.w),
                   child: ProfileSegmentComponent(
                      callback: (value) {
                        setState(() {

                        });
                      },
                    ),),
                    Form(
                      key: globalFormKey,
                      child: Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Center(
                              child: Builder(builder: (BuildContext context2) {
                                return buildUserDataColumn(snapshot, context2);
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
    var userNotifier = context2.watch<UserNotifier>();
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
                  key: Key(userNotifier.getUser().ntn_number.toString()),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,

                  initialValue: userNotifier.getUser().ntn_number ?? '',
                  onSaved: (input) =>
                  _updateProfileRequestModel.ntn_number = input! /*'44'*/,
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter";
                                            }*/
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

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  initialValue: snapshot.data!.name ?? '',
                  onSaved: (input) =>
                  _updateProfileRequestModel.name = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter name";
                    }
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
                  initialValue: '',
                  /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter trade mark";
                                            }*/
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
                  initialValue: '',
                  /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter employment role";
                                            }*/
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


              DropdownButtonFormField<String>(

                decoration: dropDownProfile(
                    'Select', "Designation") ,
                isDense: true,
                hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                isExpanded: true,
                iconSize: 21,
                items:roleList.map((location) {
                  return DropdownMenuItem<String>(
                    child: Text(location),
                    value: location,

                  );
                }).toList(),

                onChanged: (newValue) {

                },


                validator: (value) => value == null ? '*' : null,

              ),
//              TextFormField(
//                  keyboardType: TextInputType.text,
//                  cursorColor: Colors.black,
//                  initialValue: '',
//                  /*onSaved: (input) =>
//                                          _signupRequestModel.name = input!,*/
//                  validator: (input) {
//                    /*if (input == null ||
//                                                input.isEmpty) {
//                                              return "Please enter designation";
//                                            }*/
//                    return null;
//                  },
//                  decoration: textFormFieldDecProfile(
//                      'Enter Here', "Designation")),
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
                  /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                  initialValue: '',
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
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

    FutureBuilder<List<Countries>?>(
    future: AppDbInstance.getDbInstance()
        .then((value) => value.countriesDao.findAllCountries()),
    builder: (context, snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
        return DropdownButtonFormField<String>(

          decoration: dropDownProfile(
              'Select', "Country") ,
          isDense: true,
          hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
          isExpanded: true,
          iconSize: 20,
          items:snapshot.data?.map((location) {
            return DropdownMenuItem<String>(
              child: Text(location.conName ?? "Empty"),
              value: location.conName ?? "Empty",

            );
          }).toList(),

          onChanged: (newValue) {
            setState(() {
              countryName = newValue!;
            });
          },


          validator: (value) => value == null ? '*' : null,

        );
    }
    else {
      return DropdownButtonFormField<String>(

        decoration: dropDownProfile(
            'Select', "Country") ,
        isDense: true,
        hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
        isExpanded: true,
        iconSize: 20,
        items: const [

        ],

        onChanged: (newValue) {

        },


        validator: (value) => value == null ? 'Please select country name' : null,

      );
    }
    }),


//              TextFormField(
//                  keyboardType: TextInputType.text,
//                  cursorColor: Colors.black,
//                  initialValue: snapshot.data!.user_country ?? '',
//                  /*onSaved: (input) =>
//                                          _signupRequestModel.name = input!,*/
//                  validator: (input) {
//                    /*if (input == null ||
//                                                input.isEmpty) {
//                                              return "Please enter country";
//                                            }*/
//                    return null;
//                  },
//                  decoration: textFormFieldDecProfile(
//                      'Enter Here', "Country")),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              FutureBuilder<List<CityState>?>(
                  future: AppDbInstance.getDbInstance()
                      .then((value) => value.cityStateDao.findAllCityState()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return DropdownButtonFormField<String>(

                        decoration: dropDownProfile(
                            'Select', "State/District") ,
                        isDense: true,
                        hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                        isExpanded: true,
                        iconSize: 20,
                        items:snapshot.data?.map((location) {
                          return DropdownMenuItem<String>(
                            child: Text(location.name ?? "Empty"),
                            value: location.countryId ?? "Empty",

                          );
                        }).toList(),

                        onChanged: (newValue) {
                          setState(() {
                            countryName = newValue!;
                          });
                        },


                        validator: (value) => value == null ? '*' : null,

                      );
                    }
                    else {
                      return DropdownButtonFormField<String>(

                        decoration: dropDownProfile(
                            'Select', "State/District") ,
                        isDense: true,
                        hint:Text("Select",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                        isExpanded: true,
                        iconSize: 20,
                        items: const [

                        ],

                        onChanged: (newValue) {

                        },


                        validator: (value) => value == null ? 'Please select country name' : null,

                      );
                    }
                  }),



//              TextFormField(
//                  keyboardType: TextInputType.text,
//                  cursorColor: Colors.black,
//                  initialValue: snapshot.data!.city_state_name ?? '',
//                  /*onSaved: (input) =>
//                                          _signupRequestModel.name = input!,*/
//                  validator: (input) {
//                    /*if (input == null ||
//                                                input.isEmpty) {
//                                              return "Please enter state/district";
//                                            }*/
//                    return null;
//                  },
//                  decoration: textFormFieldDecProfile(
//                      'Enter Here', "State/District")),
            ],
          ),
        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              DropdownButtonFormField<String>(

                decoration: dropDownProfile(
                    'Select', "City") ,
//                    value: priceTerm,
                isDense: true,
                hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                isExpanded: true,
                iconSize: 21,
                items: const [
                  DropdownMenuItem(child: Text("Islamabad",style: TextStyle(fontSize: 12),), value: "A"),
                  DropdownMenuItem(child: Text("Lahore",style: TextStyle(fontSize: 12),), value: "B"),
                  DropdownMenuItem(child: Text("Karachi",style: TextStyle(fontSize: 12),), value: "C"),
                  DropdownMenuItem(child: Text("Peshawar",style: TextStyle(fontSize: 12),), value: "C"),
                  DropdownMenuItem(child: Text("Quetta",style: TextStyle(fontSize: 12),), value: "C"),
                  DropdownMenuItem(child: Text("Rawalpindi",style: TextStyle(fontSize: 12),), value: "C"),
                  DropdownMenuItem(child: Text("Gilgit",style: TextStyle(fontSize: 12),), value: "C"),
                ],

                onChanged: (newValue) {

                },


                validator: (value) => value == null ? '*' : null,

              ),
//              TextFormField(
//                  keyboardType: TextInputType.text,
//                  cursorColor: Colors.black,
//                  initialValue: snapshot.data!.city_state_name ?? '',
//                  /*onSaved: (input) =>
//                                          _signupRequestModel.name = input!,*/
//                  validator: (input) {
//                    /*if (input == null ||
//                                                input.isEmpty) {
//                                              return "Please enter city";
//                                            }*/
//                    return null;
//                  },
//                  decoration: textFormFieldDecProfile(
//                      'Enter Here', "City")),
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
                  /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                  initialValue: snapshot.data!.postalCode ?? '',
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter zip code";
                                            }*/
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Zip Code")),
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
                  initialValue: '',
                  /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter whatsapp number";
                                            }*/
                    return null;
                  },
                  decoration: textFormWhatsAppProfile(
                      '+92 |', "WhatsApp")),
            ],
          ),
        ),
//        Padding(
//          padding:
//          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//
//              TextFormField(
//                  keyboardType: TextInputType.text,
//                  cursorColor: Colors.black,
//                  initialValue: '',
//                  /*onSaved: (input) =>
//                                          _signupRequestModel.name = input!,*/
//                  validator: (input) {
//                    /*if (input == null ||
//                                                input.isEmpty) {
//                                              return "Please enter wechat";
//                                            }*/
//                    return null;
//                  },
//                  decoration: textFormFieldDecProfile(
//                      'Enter Here', "Wechat")),
//            ],
//          ),
//        ),
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  initialValue: snapshot.data!.telephoneNumber ?? '',
                  onSaved: (input) =>
                  _updateProfileRequestModel.telephoneNumber = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter number";
                    }
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
                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  initialValue: snapshot.data!.email ?? '',
                  /*onSaved: (input) =>
                                          _signupRequestModel.email = input!,*/
                  validator: (input) {
                    if (input == null ||
                        input.isEmpty ||
                        !input.isValidEmail()) {
                      return "Please check your email";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      '', "Email")),
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
                  initialValue: '',
                  /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter web url";
                                            }*/
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
                                BorderRadius.all(Radius.circular(8)),
                                side: BorderSide(color: Colors.transparent)))),
                    onPressed: () {
                      if (validateAndSave()) {
                        _UpdateProfileCall(snapshot.data, context1);
                      }
                    });
              })),
        ),
      ],
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _UpdateProfileCall(User? user, BuildContext context1) {
    if (user != null) {
      check().then((value) {
        if (value) {
          ProgressDialogUtil.showDialog(context, 'Please wait...');
          /*remove operator and added static data for parameter*/
          _updateProfileRequestModel.operator = '1';
          _updateProfileRequestModel.countryId = '1';
          _updateProfileRequestModel.cityStateId = '1';
          _updateProfileRequestModel.id = user.id.toString();
          _updateProfileRequestModel.name = user.name.toString();
          Logger().e(_updateProfileRequestModel.toJson());
          ApiService.updateProfile(_updateProfileRequestModel).then((value) {
            Logger().e(value.toJson());
            ProgressDialogUtil.hideDialog();
            if (value.errors != null) {
              value.errors!.forEach((key, error) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error.toString())));
              });
            } else if (value.success!) {
              AppDbInstance.getDbInstance().then((db) async {
                await db.userDao.insertUser(value.data!.user!);
              });
              SharedPreferenceUtil.addStringToSF(
                  USER_ID_KEY, value.data!.user!.id.toString());
              SharedPreferenceUtil.addStringToSF(
                  USER_TOKEN_KEY, value.data!.token!);
              SharedPreferenceUtil.addBoolToSF(IS_LOGIN, true);

              Fluttertoast.showToast(
                  msg: value.message ?? "",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1);
              /*Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainPage()),
                      (Route<dynamic> route) => false);*/
              var userNotifier = context1.read<UserNotifier>();
              userNotifier.updateUser(value.data!.user!);
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
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
