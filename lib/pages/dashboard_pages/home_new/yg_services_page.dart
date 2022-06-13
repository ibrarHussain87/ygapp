

import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/model/pre_login_response.dart';
import 'package:yg_app/model/request/update_profile/update_profile_request.dart';
import 'package:yg_app/model/request/yg_service/yg_service_request_model.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/pages/profile/update_profile/user_notifier.dart';

import '../../../elements/list_widgets/single_select_tile_widget.dart';
import '../../../elements/title_text_widget.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/response/common_response_models/companies_reponse.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../../auth_pages/signup/country_search_page.dart';
import '../../main_page.dart';

class YgServicePage extends StatefulWidget {


  const YgServicePage({Key? key,}) : super(key: key);

  @override
  YgServicePageState createState() => YgServicePageState();
}

class YgServicePageState extends State<YgServicePage>
    with AutomaticKeepAliveClientMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late YGServiceRequestModel _ygServiceRequestModel;
  List<Companies> companiesList = [];
  List<ServiceTypes> serviceList = [];
  User? user;

  static const String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
  String? dateTime;
  List<String> contactList = ["Same as Profile","Different"];
  final _companyTypeAheadController=TextEditingController();
  final _nameController=TextEditingController();
  final _addressController=TextEditingController();
  final _numberController=TextEditingController();
  final _emailController=TextEditingController();
  bool _termsChecked = false;
  final GlobalKey<SingleSelectTileWidgetState> _contactKey =
  GlobalKey<SingleSelectTileWidgetState>();
  @override
  void initState() {
    _ygServiceRequestModel = YGServiceRequestModel();
    AppDbInstance().getDbInstance().then((value) => {
      value.serviceTypesDao.findAllServiceTypes().then((value) {
        setState(() {
          serviceList = value;
        });
      }),
      value.companiesDao.findAllCompanies().then((value) {
        setState(() {
          companiesList=value;
        });
      }),

      value.userDao.getUser().then((value) {
        setState(() {
          user=value;
          _setData();
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
      child:Scaffold(
//                key: scaffoldKey,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar:appBar(context, "YG Services"),
        body: Column(
          children: [
            Form(
              key: globalFormKey,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Builder(builder: (BuildContext context2) {
                      return Padding(
                        padding:EdgeInsets.only(top: 30.w, bottom: 8.w, left: 18.w, right: 18.w),
                        child: buildUserDataColumn(context2),
                      );
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


  Column buildUserDataColumn(BuildContext context2) {
//    _companyTypeAheadController.text=snapshot.data!.name!;
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                hint:  Text('Select Service Type',style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.w500,color:hintColorGrey),),

                items: serviceList
                    .map((value) =>
                    DropdownMenuItem(
                      child: Text(
                          value.serviceTypeName ??
                              Utils.checkNullString(
                                  false),
                          textAlign:
                          TextAlign
                              .center,style:TextStyle(fontSize: 13.sp),),
                      value: value,
                    ))
                    .toList(),
                isExpanded: true,
//                value: state,
                onChanged: (ServiceTypes? value) {
                  FocusScope.of(context)
                      .requestFocus(
                      FocusNode());
//                  state=value;
                  _ygServiceRequestModel.serviceTypeId =
                      value?.serviceTypeId.toString();
                },

                decoration: textFieldProfile(
                    'Select', "Service Type",true),
                validator: (value) => value == null ? 'Please select service type' : null,
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
              Padding(
                  padding: EdgeInsets.only(left: 0.w, top: 4, bottom: 4),
                  child: const TitleSmallBoldTextWidget(
                      title: "Contact Details*")),
              SingleSelectTileWidget(
                selectedIndex: 0,
                key: _contactKey,
                spanCount: 2,
                listOfItems: contactList,
                callback: (String value) {
              if(value=="Different")
                {
                  setState(() {
                   _resetData();
                  });
                }
              else
                {
                  setState(() {

                    _setData();

                  });
                }

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


              TypeAheadFormField(
                  textFieldConfiguration: TextFieldConfiguration(
                    style: TextStyle(fontSize: 13.sp),
                    controller: _companyTypeAheadController,
                    decoration: textFieldProfile(
                        'Enter Company Name', "Company Name",true),
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
                    _ygServiceRequestModel.companyName=suggestion.name.toString();
                  },
                  errorBuilder:(BuildContext context, Object? error) =>
                      Text(
                          '$error',
                          style: TextStyle(
                            fontSize: 13.sp,
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

                    _ygServiceRequestModel.companyName = value;

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


              TextFormField(
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.text,
                  controller: _nameController,
                  cursorColor: Colors.black,
//                  initialValue: _ygServiceRequestModel.name ?? "",
                  onSaved: (input) =>
                  _ygServiceRequestModel.name = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Name', "Name",true)),
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
                  style: TextStyle(fontSize: 13.sp),
                controller: _numberController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
//                  initialValue: _ygServiceRequestModel.telephoneNumber ?? '',
                  onSaved: (input) =>
                  _ygServiceRequestModel.telephoneNumber = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter contact number";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Contact Number', "Contact Number",true)),
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
                  style: TextStyle(fontSize: 13.sp),
                controller: _addressController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  onSaved: (input) =>
                  _ygServiceRequestModel.address = input!,
//                  initialValue:_ygServiceRequestModel.address ?? '',
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter address";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Address', "Address",true)),
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
                  style: TextStyle(fontSize: 13.sp),
              controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
//                  initialValue: _ygServiceRequestModel.email ?? '',
                  onSaved: (input) => _ygServiceRequestModel.email = input!,
                  validator: (input) {
                    if (input == null ||
                        input.isEmpty ||
                        !input.isValidEmail()) {
                      return "Please check your email";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Email', "Email",true)),
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
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  onSaved: (input) => _ygServiceRequestModel.landMark = input!,
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter nearest landmark";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldProfile(
                      'Enter Landmark', "Landmark",false)),
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
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  onSaved: (input) => _ygServiceRequestModel.secName = input!,
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter secondary contact name";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldProfile(
                      'Enter Secondary Contact Name', "Secondary Contact Name",false)),
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
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  onSaved: (input) => _ygServiceRequestModel.secNumber = input!,
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter secondary number";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldProfile(
                      'Enter Secondary Contact Number', "Secondary Contact Number",false)),
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
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  maxLines: 5,
                  onSaved: (input) => _ygServiceRequestModel.details = input!,
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter details";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldProfile(
                      '', "Details",false)),
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
                  style: TextStyle(fontSize: 13.sp),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  maxLines: 5,
                  onSaved: (input) => _ygServiceRequestModel.specialInstructions = input!,
                  // validator: (input) {
                  //   if (input == null || input.isEmpty) {
                  //     return "Please enter special instructions";
                  //   }
                  //   return null;
                  // },
                  decoration: textFieldProfile(
                      '', "Special Instructions",false)),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 8.w, bottom: 8.w, left: 8.w, right: 8.w),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.w,
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
//                    FocusScope.of(context)
//                        .requestFocus(
//                        FocusNode());
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,

                        minTime: DateTime(2022, 1, 1),
                        maxTime: DateTime(2030, 6, 7),
                        onChanged: (date) {
                          setState(() {
                            dateTime=date.toString();
                            _ygServiceRequestModel.dateTime=date.toString();
                          });
                        },
                        onConfirm: (date) {

                          FocusScope.of(context).requestFocus(FocusNode());
                          dateTime= formatDate(date);
                          _ygServiceRequestModel.dateTime=dateTime.toString();
//                          dateTime=date.toString();

                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  }
                  );
                },
                child: SizedBox(
                  height: 50.w,
                  child:InputDecorator(
                    decoration: InputDecoration(
                      label: Row(
                        mainAxisSize:
                        MainAxisSize.min,
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Date/Time',
                            style: TextStyle(color: Colors.black,fontSize: 13),
                          ),
                          Text("*", style: TextStyle(color: Colors.red, fontSize: 16.sp,
                                  /*fontFamily: 'Metropolis',*/
                                  backgroundColor:
                                  Colors.white,
                                  fontWeight:
                                  FontWeight
                                      .w500)),
                        ],
                      ),

                      contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      suffixIcon:const Icon(Icons.arrow_drop_down,color: Colors.black54,),
                      floatingLabelBehavior:FloatingLabelBehavior.always ,
                      hintText:'Select Date/Time',
                      border: OutlineInputBorder(
                          borderRadius:const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(color: newColorGrey)
                      ),
                      hintStyle: TextStyle(
                          fontSize: 13.sp,
                          color: textColorGrey),
                    ),

                    child: Row(
                      children: [

                        Expanded(
                            flex:8,
                            child: Text(
                                dateTime ?? "Select Date/Time",textAlign: TextAlign.start,style:TextStyle(
                                fontSize: 13.sp,
                                color:dateTime!=null ? Colors.black : newColorGrey))),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 5.w, bottom: 6.w),
          child: Row(
            children: [
              Checkbox(
                  activeColor: signInColor,
                  value: _termsChecked,
                  onChanged: (val) {
                    setState(() {
                      _termsChecked = val!;
                    });
                  }),
              RichText(
                text: TextSpan(
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
                  style: TextStyle(
                    fontFamily: 'Metropolis',
                    fontSize: 14.0.sp,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'I agree to ',
                        style: TextStyle(
                            fontFamily:
                            'Metropolis',
                            fontSize: 13.sp,
                            color:
                            textColorGrey)),
                    TextSpan(
                        text:
                        'terms & conditions',
                        style: TextStyle(
                            fontFamily:
                            'Metropolis',
                            fontSize: 13.sp,
                            color:
                            textColorGrey)),
                  ],
                ),
              )
            ],
          ),
        ),


        Padding(
          padding: EdgeInsets.all(14.w),
          child: SizedBox(
              width: double.infinity,
              child: Builder(builder: (BuildContext context1) {
                return TextButton(
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
                        FocusScope.of(context1).requestFocus(FocusNode());
                        _createYGServicesCall(context1);
                      }
                    });
              })),
        ),
      ],
    );
  }




  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate() && _termsChecked) {
      if(_ygServiceRequestModel.dateTime!=null) {
        form.save();
        return true;
      }
      else
        {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please select date and time')));
        }
    } else if (!_termsChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please accept Terms & Conditions')));
    }
    return false;
  }


  void _createYGServicesCall(BuildContext context1) {

      check().then((value) {
        if (value) {
          ProgressDialogUtil.showDialog(context, 'Please wait...');

          Logger().e(_ygServiceRequestModel.toJson());
          ApiService.createYGService(_ygServiceRequestModel).then((value) {

            ProgressDialogUtil.hideDialog();
//            if (value.errors != null) {
//              value.errors!.forEach((key, error) {
//                ScaffoldMessenger.of(context)
//                    .showSnackBar(SnackBar(content: Text(error.toString())));
//              });
//            } else
            if (value.status!) {
//              AppDbInstance().getDbInstance().then((db) async {
////                await db.userDao.insertUser(value.data!.user!);
//                await db.userDao.insertUser(value.data!);
//              });


              Fluttertoast.showToast(
                  msg: value.message ?? "",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const MainPage()),
                      (Route<dynamic> route) => false);
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

  _resetData() {
    _ygServiceRequestModel.contactDetails="Different";
    _ygServiceRequestModel.companyName = null ;
    _companyTypeAheadController.clear();
    _nameController.clear();
    _numberController.clear();
    _addressController.clear();
    _emailController.clear();

    _ygServiceRequestModel.name = null ;
    _ygServiceRequestModel.address = null ;
    _ygServiceRequestModel.telephoneNumber = null ;
    _ygServiceRequestModel.email = null ;
  }

  _setData() {

    _ygServiceRequestModel.contactDetails="Same as Profile";
    _companyTypeAheadController.text=user?.company?? "";
    _ygServiceRequestModel.companyName=user?.name;
    _nameController.text=user?.name.toString() ?? "";
    _ygServiceRequestModel.name=user?.name;
    _emailController.text=user?.email.toString() ?? "";
    _ygServiceRequestModel.email=user?.email;
    _numberController.text=user?.telephoneNumber.toString() ?? "";
    _ygServiceRequestModel.telephoneNumber=user?.telephoneNumber;
    _addressController.text=user?.address.toString() ?? "";
    _ygServiceRequestModel.address=user?.address;
  }

  @override
  bool get wantKeepAlive => true;

   String formatDate(DateTime dateTime)

  {
    return DateFormat(DATE_TIME_FORMAT ).format(dateTime);
  }

}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

