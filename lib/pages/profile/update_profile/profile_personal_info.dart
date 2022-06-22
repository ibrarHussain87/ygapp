import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/model/pre_login_response.dart';
import 'package:yg_app/model/request/update_profile/update_profile_request.dart';
import 'package:yg_app/model/response/login/login_response.dart';

import '../../../helper_utils/ui_utils.dart';
import '../../../locators.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../../../providers/profile_providers/profile_info_provider.dart';
import '../../auth_pages/signup/country_search_page.dart';

class ProfilePersonalInfoPage extends StatefulWidget {
  final Function? callback;
  final String? selectedTab;

  const ProfilePersonalInfoPage(
      {Key? key, required this.callback, required this.selectedTab})
      : super(key: key);

  @override
  ProfilePersonalInfoPageState createState() => ProfilePersonalInfoPageState();
}

class ProfilePersonalInfoPageState extends State<ProfilePersonalInfoPage>
    with AutomaticKeepAliveClientMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormFieldState> _provinceKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cityKey = GlobalKey<FormFieldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late UpdateProfileRequestModel _updateProfileRequestModel;
  final _profileInfoProvider = locator<ProfileInfoProvider>();

  @override
  void initState() {
    super.initState();

    _profileInfoProvider.addListener(() {
      updateUI();
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // _profileInfoProvider.resetData();
      // _profileInfoProvider.getSyncedData();
      _updateProfileRequestModel =
          _profileInfoProvider.updateProfileRequestModel;
    });
  }

  updateUI() {
    if (mounted) setState(() {});
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
      child: Scaffold(
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
                      return (!_profileInfoProvider.isLoading)
                          ? buildUserDataColumn(
                              _profileInfoProvider.user, context2)
                          : Container();
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

  Column buildUserDataColumn(User? user, BuildContext context2) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: 30.w, bottom: 8.w, left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  initialValue: user?.name ?? '',
                  onSaved: (input) => _updateProfileRequestModel.name = input!,
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter name";
                    }*/
                    return null;
                  },
                  decoration: textFieldDecoration('Enter Name', "Name", false)),
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
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  onSaved: (input) =>
                      _updateProfileRequestModel.address = input!,
                  initialValue: user?.address ?? '',
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter address";
                    }*/
                    return null;
                  },
                  decoration: textFieldDecoration('', "Address", false)),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectCountryPage(
                        title: "Country",
                        isCodeVisible: false,
                        callback: (Countries value) => {
                          FocusScope.of(context).requestFocus(FocusNode()),
                          _profileInfoProvider.selectedState = null,
                          _profileInfoProvider.selectedCity = null,
                          _profileInfoProvider.setSelectedCountry(value),
                          _updateProfileRequestModel.countryId =
                              value.conId.toString()
                        },
                      ),
                    ),
                  );
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text("Country",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black)),
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
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Select",
                      hintStyle: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(color: newColorGrey))),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 8,
                          child: Text(
                            _profileInfoProvider.selectedCountry?.conName ??
                                "Select Country",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: _profileInfoProvider
                                            .selectedCountry?.conName !=
                                        null
                                    ? Colors.black
                                    : newColorGrey,
                                fontSize: 13),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 8.w, bottom: 8.w,left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                key: _provinceKey,
                hint: Text(
                  'Select State',
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: hintColorGrey),
                ),
                items: _profileInfoProvider.statesList
                    .where((element) =>
                        element.countryIdfk ==
                        _profileInfoProvider.selectedCountry?.conId.toString())
                    .toList()
                    .map((value) => DropdownMenuItem(
                          child: Text(value.stateName ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13.sp)),
                          value: value,
                        ))
                    .toList(),
                isExpanded: true,
                value: _profileInfoProvider.selectedState,
                onChanged: (States? value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _profileInfoProvider.selectedCity = null;
                  _profileInfoProvider.selectedState = value;
                  _updateProfileRequestModel.cityStateId =
                      value?.stateId.toString();
                },
                decoration:
                    textFieldDecoration('Select', "State/District", true),
                validator: (value) =>
                    value == null ? 'Please select sate/district' : null,
              ),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 8.w, bottom: 8.w,left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                key: _cityKey,
                hint: Text('Select City',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: hintColorGrey)),
                items: _profileInfoProvider.citiesList
                    .where((element) =>
                        element.stateIdfk ==
                        _profileInfoProvider.selectedState?.stateId.toString())
                    .toList()
                    .map((value) => DropdownMenuItem(
                          child: Text(value.cityName ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 13.sp)),
                          value: value,
                        ))
                    .toList(),
                isExpanded: true,
                value: _profileInfoProvider.selectedCity,
                onChanged: (Cities? value) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _profileInfoProvider.selectedCity = value;
                  _updateProfileRequestModel.city = value?.cityName;
                },
                decoration: textFieldDecoration('Select', "City", true),
                validator: (value) =>
                    value == null ? 'Please select city' : null,
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
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  onSaved: (input) =>
                      _updateProfileRequestModel.postalCode = input!,
                  initialValue: user?.postalCode ?? '',
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter zip code";
                    }*/
                    return null;
                  },
                  decoration: textFieldDecoration('', "Postal Code", false)),
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
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  initialValue: user?.whatsApp ?? '',
                  onSaved: (input) =>
                      _updateProfileRequestModel.whatsapp = input!,
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'([+0-9])')),
                    LengthLimitingTextInputFormatter(13),
                  ],
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter whatsapp number";
                    }*/
                    return null;
                  },
                  decoration: textFormWhatsAppProfile('+92 | ', "WhatsApp")),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 8.w, bottom: 8.w,left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  initialValue: user?.telephoneNumber ?? '',
                  onSaved: (input) =>
                      _updateProfileRequestModel.telephoneNumber = input!,
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'([+0-9])')),
                    LengthLimitingTextInputFormatter(13),
                  ],
                  validator: (input) {
                    /*if (input == null || input.isEmpty) {
                      return "Please enter number";
                    }*/
                    return null;
                  },
                  decoration: textFieldDecoration('', "Telephone", false)),
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 8.w, bottom: 8.w,left: 0.w, right: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
//                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  initialValue: user?.email ?? '',
                  onSaved: (input) => _updateProfileRequestModel.email = input!,
                  style: TextStyle(fontSize: 13.sp),
                  textAlign: TextAlign.start,
                  cursorHeight: 16.w,
                  validator: (input) {
                    if (input == null ||
                        input.isEmpty ||
                        !input.isValidEmail()) {
                      return "Please check your email";
                    }
                    return null;
                  },
                  decoration: textFieldDecoration('', "Email", true)),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top:14.w,bottom: 14.w),
          child: SizedBox(
              width: double.infinity,
              child: Builder(builder: (BuildContext context1) {
                return TextButton(
                    child: Text("Submit", style: TextStyle(fontSize: 14.sp)),
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
                        FocusScope.of(context).requestFocus(FocusNode());
                        _updateProfileCall(context1);
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
    if (_updateProfileRequestModel.countryId == null ||
        _updateProfileRequestModel.countryId == "") {
      Ui.showSnackBar(context, "Please select country");
      return false;
    }
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _updateProfileCall(BuildContext context1) {
    check().then((value) {
      if (value) {
        ProgressDialogUtil.showDialog(context, 'Please wait...');

        Logger().e(_updateProfileRequestModel.toJson());
        ApiService().updateProfile(_updateProfileRequestModel).then((value) {
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
              await db.userDao.deleteUserData();
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
