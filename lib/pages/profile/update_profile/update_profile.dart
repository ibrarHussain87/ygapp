import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/login/login_response.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  /*late SignUpRequestModel _signupRequestModel;*/
  String userName = "";

  @override
  void initState() {
    /*_signupRequestModel = SignUpRequestModel();*/
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
            return Scaffold(
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
                  Form(
                    key: globalFormKey,
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.w, right: 16.w),
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 30.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('GST (NTN Number)',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: snapshot.data!.name??'N/A',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Enter Here";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Your Username',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Company Name',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: snapshot.data!.company??'',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter company name";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Trade Mark',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: '',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter trade mark";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Employment Role',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: '',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter employment role";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Designation',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: '',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter designation";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Address',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          initialValue: '',
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter address";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Country',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: '',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter country";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('State/District',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: '',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter state/district";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('City',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: '',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter city";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Zip Code',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          initialValue: '',
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter zip code";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Web Url',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: '',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter web url";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Whatsapp Number',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: '',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter whatsapp number";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Wechat',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: '',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter wechat";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Telephone Number(Optional)',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          initialValue: snapshot.data!.telephoneNumber??'',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.name = input!,*/
                                          /*validator: (input) {
                                            if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter web url";
                                            }
                                            return null;
                                          },*/
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_profile.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.w,
                                      bottom: 8.w, left: 8.w, right: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Email',
                                          style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.black)),
                                      TextFormField(
                                          keyboardType: TextInputType
                                              .emailAddress,
                                          cursorColor: Colors.black,
                                          initialValue: snapshot.data!.email??'',
                                          /*onSaved: (input) =>
                                          _signupRequestModel.email = input!,*/
                                          validator: (input) {
                                            if (input == null || input.isEmpty ||
                                                !input.isValidEmail()) {
                                              return "Please check your email";
                                            }
                                            return null;
                                          },
                                          decoration: textFormFieldDecProfile(
                                              'Enter Here',"assets/ic_email.svg")
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                          child: Text("Submit",
                                              style: TextStyle(fontFamily: 'Metropolis',
                                                  fontSize: 14.sp)),
                                          style: ButtonStyle(
                                              foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                              backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  btnColorLogin),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(8)),
                                                      side: BorderSide(
                                                          color: Colors.transparent)))),
                                          onPressed: () {
                                            if (validateAndSave()) {
                                              /*_UpdateProfileCall();*/
                                            }
                                          })),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

/*void _UpdateProfileCall() {
    check().then((value) {
      if (value) {
        ProgressDialogUtil.showDialog(context, 'Please wait...');
        */ /*remove operator and added static data for parameter*/ /*
        _signupRequestModel.operator = '1';
        _signupRequestModel.countryId = '1';
        Logger().e(_signupRequestModel.toJson());
        ApiService.signup(_signupRequestModel).then((value) {
          Logger().e(value.toJson());
          ProgressDialogUtil.hideDialog();
          if(value.errors != null){
            value.errors!.forEach((key, error) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.toString())));
            });
          }else if (value.success!) {
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
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainPage()),
                    (Route<dynamic> route) => false);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.message ??"")));
          }
        }).onError((error, stackTrace) {
          ProgressDialogUtil.hideDialog();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(
            SnackBar(content: Text("No internet available.".toString())));
      }
    });
  }*/
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
