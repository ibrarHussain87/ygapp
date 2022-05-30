import 'package:country_list_pick/country_list_pick.dart';
import 'package:country_list_pick/country_selection_theme.dart';

import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/connection_status_singleton.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/model/request/update_profile/update_profile_request.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/login/login_response.dart';
import 'package:yg_app/pages/profile/profile_segment_component.dart';
import 'package:yg_app/pages/profile/update_profile/user_notifier.dart';

import '../../../elements/title_text_widget.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../../model/request/update_profile/update_business_request.dart';
import '../../../model/response/common_response_models/countries_response.dart';
import '../../auth_pages/signup/country_search_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
   GlobalKey<FormState> brandsKey = GlobalKey<FormState>();
   GlobalKey<FormState> bussinessFormKey = GlobalKey<FormState>();

  late UpdateProfileRequestModel _updateProfileRequestModel;
  late UpdateBusinessRequestModel _updateBusinessRequestModel;
  String userName = "";
  String? countryName;
  String companyCountryName = "";
  String stateName = "";
  String companyStateName = "";
  int stateId = 0;
  int companyStateId = 0;
  int selectedValue = 1;
  List<String> roleList = ["Developer","Engineer","Manager","Director","CEO"];
  List<String> citiesList = ["Lahore","Islamabad","Peshawar","Quetta","Karachi"];
  List<TagModel> _tags=[];
  List<Countries> countriesList = [];
  List<CityState> cityStateList = [];
  var brandController=TextEditingController();

  @override
  void initState() {
    _tags.addAll(
        [
          TagModel(id: "1", title: 'Khadi'),
          TagModel(id: "2", title: 'Bonanza'),
          TagModel(id: "3", title: 'Maria B'),
          TagModel(id: "4", title: 'Gul Ahmed'),
        ]);
    _updateProfileRequestModel = UpdateProfileRequestModel();
    _updateBusinessRequestModel = UpdateBusinessRequestModel();
    AppDbInstance().getDbInstance().then((value) => {
      value.countriesDao.findAllCountries().then((value) {
        setState(() {
          countriesList = value;
        });
      }),
    value.cityStateDao.findAllCityState().then((value) {
        setState(() {
          cityStateList = value;
        });
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: FutureBuilder<User?>(
        future: AppDbInstance().getDbInstance()
            .then((value) => value.userDao.getUser()),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            countryName=countriesList.where((element) => element.conId.toString()==snapshot.data?.countryId).first.conName;
            _updateProfileRequestModel.countryId=snapshot.data?.countryId;
            _updateBusinessRequestModel.countryId=snapshot.data?.countryId;

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
                           selectedValue=value;
                        });
                      },
                     tab1: personal,
                     tab2: business,
                     tab3: brands,
                    ),),

                    if(selectedValue==1)
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
            )
                    else if(selectedValue==2)
                      Form(
                        key: bussinessFormKey,
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              child: Center(
                                child: Builder(builder: (BuildContext context2) {
                                  return buildBusinessDataColumn(snapshot, context2);
                                }),
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w),
                              child: Center(
                                child: Builder(builder: (BuildContext context2) {
                                  return buildBrands(snapshot, context2);
                                }),
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


  buildBrands( AsyncSnapshot<User?> snapshot, BuildContext context2)
  {
    var userNotifier = context2.watch<UserNotifier>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: brandsKey,
          child: Padding(
            padding:
            EdgeInsets.only(top: 30.w, bottom: 15.w, left: 8.w, right: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  flex:3,
                  child: TextFormField(
                    // For changing initial value
//                  key: Key(userNotifier.getUser().ntn_number.toString()),
                  controller: brandController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      onSaved: (input) =>
                      _updateProfileRequestModel.company = input! /*'44'*/,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "Please enter brand name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          contentPadding:const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          label:Text("Add Brand",style: TextStyle(color: brandFieldLabel,fontSize: 16.sp,fontWeight: FontWeight.w500),),
                          floatingLabelBehavior:FloatingLabelBehavior.always ,
                          hintText: "Enter your brand name",
                          hintStyle: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w500,color:hintColorGrey),

                          border: OutlineInputBorder(
                              borderRadius:const BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: BorderSide(color: newColorGrey,width: 0.1))
                      )
                  ),
                ),

//              const Expanded(flex:1,child: Text("Button")),
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: ()=>{
                      if (validateBrandInput()) {
                        _addTags(TagModel(id:"",title:brandController.text))
                  }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 14.0,
                        ),
                        decoration: BoxDecoration(
                          color: addBtnColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child:Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Add',
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),

                          ],
                        ),


                      ),
                    ),
                  ),
                )
              ],
            ),


          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Your Brands",textAlign: TextAlign.left,style: TextStyle(
              fontSize: 22.0.w,
              color: headingColor,
              fontWeight: FontWeight.w700)),
        ),

        _tagIcon(),

      ],
    );
  }

  Widget _tagIcon() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _tagsWidget(),
      ],
    );
  }


  Widget _tagsWidget() {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _tags.isNotEmpty
              ? Column(children: [
            Wrap(
              alignment: WrapAlignment.start,
              children: _tags
                  .map((tagModel) => tagChip(
                tagModel: tagModel,
                onTap: () => _removeTag(tagModel),
                action: 'Remove',
              ))
                  .toSet()
                  .toList(),
            ),
          ])
              : Container(),

        ],
      ),
    );
  }

  _addTags(tagModel) async {
    if (!_tags.contains(tagModel)) {
      setState(() {
        if(brandController.text!=null){
        brandController.clear();}
        _tags.add(tagModel);
      });
    }
  }


  _removeTag(tagModel) async {
    if (_tags.contains(tagModel)) {
      setState(() {
        _tags.remove(tagModel);
      });
    }
  }

  Widget tagChip({
    tagModel,
    onTap,
    action,
  }) {
    return InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 5.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                decoration: BoxDecoration(
                  color: tagsBackground,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${tagModel.title}',
                      style:  TextStyle(
                        color: tagsTextColor,
                        fontSize: 13.sp,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    Icon(
                      Icons.clear,
                      size: 16.0,
                      color: tagsIconColor,
                    ),
                  ],
                ),


              ),
            ),

          ],
        ));
  }



 Column buildBusinessDataColumn(AsyncSnapshot<User?> snapshot, BuildContext context2)
  {
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
                  _updateBusinessRequestModel.ntn_number = input! /*'44'*/,
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
                  initialValue: snapshot.data!.company ?? '',
                  onSaved: (input) =>
                  _updateBusinessRequestModel.name = input!,
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return "Please enter company name";
                    }
                    return null;
                  },
                  decoration: textFieldProfile(
                      'Enter Company Name', "Company Name")),
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
                      'Enter Business Area', "Business Area")),
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
                  onSaved: (input) =>
                                          _updateBusinessRequestModel.trade_mark = input!,
                  validator: (input) {
                if (input == null ||
                                                input.isEmpty) {
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
                  initialValue: '',
                  onSaved: (input) =>
                                          _updateBusinessRequestModel.employment_role = input!,
                  validator: (input) {
                  if (input == null ||
                                                input.isEmpty) {
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
                _updateBusinessRequestModel.designation_idfk=newValue;
                },


                validator: (value) => value == null ? '*' : null,

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
                 onSaved: (input) =>
                                          _updateBusinessRequestModel.address = input!,
                  initialValue: '',
                  validator: (input) {
                    if (input == null ||
                                                input.isEmpty) {
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
//              CountryListPick(
//                  appBar: AppBar(
//                    leading: BackButton(
//                        color: Colors.black
//                    ),
//                    titleSpacing: 0,
//                    backgroundColor: Colors.white,
//                    title: const Text('Choose a Country',style:TextStyle(color: Colors.black),),
//                  ),
//
//                  // if you need custome picker use this
////                   pickerBuilder: (context, CountryCode? countryCode){
////                     return Row(
////                       children: [
////                         Image.asset(
////                           countryCode?.flagUri ?? "",
////                           package: 'country_list_pick',
////                         ),
////                         Text(countryCode?.code ?? ""),
////                         Text(countryCode?.dialCode ?? ""),
////                       ],
////                     );
////                   },
//
//                  // To disable option set to false
//                  theme: CountryTheme(
//                    isShowFlag: true,
//                    isShowTitle: true,
//                    isShowCode: true,
//                    isDownIcon: true,
//                    showEnglishName: true,
//                  ),
//                  // Set default value
//                  initialSelection: '+92',
//                  // or
//                  // initialSelection: 'US'
//                  onChanged: (CountryCode? code) {
//                    print(code?.name);
//                    print(code?.code);
//                    print(code?.dialCode);
//                    print(code?.flagUri);
//                  },
//                  // Whether to allow the widget to set a custom UI overlay
//                  useUiOverlay: true,
//                  // Whether the country list should be wrapped in a SafeArea
//                  useSafeArea: false
//              ),


              FutureBuilder<List<Countries>?>(
                  future: AppDbInstance().getDbInstance()
                      .then((value) => value.countriesDao.findAllCountries()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return
//          DropdownButtonFormField<String>(
//
//          decoration: dropDownProfile(
//              'Select', "Country") ,
//          isDense: true,
//          hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
//          isExpanded: true,
//          iconSize: 20,
//          items:snapshot.data?.map((location) {
//            return DropdownMenuItem<String>(
//              child: Text(location.conName ?? "Empty"),
//              value: location.conName ?? "Empty",
//
//            );
//          }).toList(),
//
//          onChanged: (newValue) {
//            setState(() {
//              countryName = newValue!;
//            });
//          },
//
//
//          validator: (value) => value == null ? '*' : null,
//
//        );
                        SearchChoices.single(
                          displayClearIcon: false,
                          hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
                          isExpanded: true,
                          fieldPresentationFn: (Widget fieldWidget, {bool? selectionIsValid}) {
                            return Container(
                              child: InputDecorator(
                                decoration:dropDownProfile(
                                    'Select', "Company Country") ,
                                child: fieldWidget,
                              ),
                            );
                          },
                          iconSize: 20,
                          items:  snapshot.data?.map((value) =>
                              DropdownMenuItem(
                                child: Text(
                                  value.conName ??
                                      Utils.checkNullString(false),
                                  textAlign: TextAlign
                                      .center,style: TextStyle(fontSize: 10.sp,   overflow: TextOverflow.ellipsis,),),
                                value: value,
                              ))
                              .toList(),
                          isCaseSensitiveSearch: false,
                          onChanged: (value) {
                            setState(() {
                              companyCountryName = value;
                            });  },
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: textColorGrey,),
                        );
                    }
                    else {
                      return DropdownButtonFormField<String>(

                        decoration: dropDownProfile(
                            'Select', "Company Country") ,
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
                  future: AppDbInstance().getDbInstance()
                      .then((value) => value.cityStateDao.findAllCityState()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return DropdownButtonFormField<String>(

                        decoration: dropDownProfile(
                            'Select', "Company State/District") ,
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

                decoration: dropDownProfile('Select', "Company City") ,
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
                                          _updateBusinessRequestModel.postalCode = input!,
                  initialValue: snapshot.data!.postalCode ?? '',
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter zip code";
                                            }*/
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
                  initialValue: '',
                  onSaved: (input) =>
                                          _updateBusinessRequestModel.website = input!,
                  validator: (input) {
                  if (input == null ||
                                                input.isEmpty) {
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
                        _UpdateBusinessCall(snapshot.data, context1);
                      }
                    });
              })),
        ),
      ],
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
                  onSaved: (input) =>
               _updateProfileRequestModel.address = input!,
                  initialValue:'',
                  validator: (input) {
                    if (input == null ||
                                                input.isEmpty) {
                                              return "Please enter address";
                                            }
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
                                      Text("Country"),
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
                              countryName ?? "Select Country",textAlign: TextAlign.start,)),

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
                    .countryId ==
                    _updateProfileRequestModel.countryId
                        .toString())
                    .toList()
                    .map((value) =>
                    DropdownMenuItem(
                      child: Text(
                          value.name ??
                              Utils.checkNullString(
                                  false),
                          textAlign:
                          TextAlign
                              .center),
                      value: value,
                    ))
                    .toList(),
                isExpanded: true,
                onChanged: (CityState? value) {
                  FocusScope.of(context)
                      .requestFocus(
                      FocusNode());
                  _updateProfileRequestModel!
                      .cityStateId =
                      value!.id.toString();
                },

                decoration: dropDownProfile(
                    'Select', "State/District"),
                validator: (value) => value == null ? 'Please select sate/district' : null,
              ),
//          FutureBuilder<List<CityState>?>(
//                  future: AppDbInstance().getDbInstance()
//                      .then((value) => value.cityStateDao.findAllCityState()),
//                  builder: (context, snapshot) {
//                    if (snapshot.hasData && snapshot.data != null) {
//                      return DropdownButtonFormField<String>(
//
//                        decoration: dropDownProfile(
//                            'Select', "State/District") ,
//                        isDense: true,
//                        hint:Text("Select",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
//                        isExpanded: true,
//                        iconSize: 20,
//                        items:snapshot.data?.map((location) {
//                          return DropdownMenuItem<String>(
//                            child: Text(location.name ?? "Empty"),
//                            value: location.countryId.toString(),
//
//                          );
//                        }).toList(),
//
//                        onChanged: (newValue) {
//                          setState(() {
//                            _updateProfileRequestModel.cityStateId = newValue!;
//                          });
//                        },
//
//
//                        validator: (value) => value == null ? '*' : null,
//
//                      );
//                    }
//                    else {
//                      return DropdownButtonFormField<String>(
//
//                        decoration: dropDownProfile(
//                            'Select', "State/District") ,
//                        isDense: true,
//                        hint:Text("Select",style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
//                        isExpanded: true,
//                        iconSize: 20,
//                        items: const [
//
//                        ],
//
//                        onChanged: (newValue) {
//
//                        },
//
//
//                        validator: (value) => value == null ? 'Please select country name' : null,
//
//                      );
//                    }
//                  }),


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
                    .toList()
                    .map((value) =>
                    DropdownMenuItem(
                      child: Text(
                          value,
                          textAlign:
                          TextAlign
                              .center),
                      value: value,
                    ))
                    .toList(),
                isExpanded: true,
                onChanged: (value) {
                  FocusScope.of(context)
                      .requestFocus(
                      FocusNode());
                  _updateProfileRequestModel.city =
                      value.toString();
                },

                decoration: dropDownProfile(
                    'Select', "City"),
                validator: (value) => value == null ? 'Please select city' : null,
              ),

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
//              SizedBox(
//                height: 40.w,
//                child: DropdownButtonFormField<String>(
//
//                  decoration: dropDownProfile(
//                      'Select', "City") ,
////                    value: priceTerm,
//                  isDense: true,
//                  hint:Text("Select Cty",style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400,color: Colors.black87),),
//                  isExpanded: true,
//                  iconSize: 21,
//                  items:citiesList
//                      .toList()
//                      .map((value) =>
//                      DropdownMenuItem(
//                        child: Text(
//                            value ,
//                            textAlign:
//                            TextAlign
//                                .center),
//                        value: value,
//                      ))
//                      .toList(),
//                  onChanged: (newValue) {
//                   _updateProfileRequestModel.city=newValue;
//                  },
//
//
//                  validator: (value) => value == null ? '*' : null,
//
//                ),
//              ),
//
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
                 onSaved: (input) => _updateProfileRequestModel.postalCode = input!,
                  initialValue: snapshot.data!.postalCode ?? '',
                  validator: (input) {
                    /*if (input == null ||
                                                input.isEmpty) {
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
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  initialValue: '',
                  onSaved: (input) => _updateProfileRequestModel.whatsapp = input!,
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
//                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  initialValue: snapshot.data!.email ?? '',
                 onSaved: (input) => _updateProfileRequestModel.email = input!,
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

  bool validateBrandInput() {
    final form = brandsKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (_updateProfileRequestModel!.countryId == null || _updateProfileRequestModel!.countryId=="") {
      Ui.showSnackBar(context, "Please select country");
      return false;
    }
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool validateAndSaveBusinessInfo() {
    final form = bussinessFormKey.currentState;
    if (_updateBusinessRequestModel!.countryId == null || _updateBusinessRequestModel!.countryId=="") {
      Ui.showSnackBar(context, "Please select country");
      return false;
    }
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
//          _updateProfileRequestModel.postalCode = '1';
//          _updateProfileRequestModel.countryId = '1';
//          _updateProfileRequestModel.cityStateId = '1';
//          _updateProfileRequestModel.id = user.id.toString();
//          _updateProfileRequestModel.name = user.name.toString();
          Logger().e(_updateProfileRequestModel.toJson());
          ApiService.updateProfile(_updateProfileRequestModel).then((value) {
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
                await db.userDao.insertUser(value.data!.user!);
              });
//              SharedPreferenceUtil.addStringToSF(
//                  USER_ID_KEY, value.data!.user!.id.toString());
//              SharedPreferenceUtil.addStringToSF(
//                  USER_TOKEN_KEY, value.data!.token!);
//              SharedPreferenceUtil.addBoolToSF(IS_LOGIN, true);

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


  void _UpdateBusinessCall(User? user, BuildContext context1) {
    if (user != null) {
      check().then((value) {
        if (value) {
          ProgressDialogUtil.showDialog(context, 'Please wait...');
          /*remove operator and added static data for parameter*/
//          _updateProfileRequestModel.postalCode = '1';
//          _updateProfileRequestModel.countryId = '1';
//          _updateProfileRequestModel.cityStateId = '1';
//          _updateProfileRequestModel.id = user.id.toString();
//          _updateProfileRequestModel.name = user.name.toString();
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
                await db.userDao.insertUser(value.data!.user!);
              });

//              SharedPreferenceUtil.addStringToSF(
//                  USER_ID_KEY, value.data!.user!.id.toString());
//              SharedPreferenceUtil.addStringToSF(
//                  USER_TOKEN_KEY, value.data!.token!);
//              SharedPreferenceUtil.addBoolToSF(IS_LOGIN, true);

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

class TagModel {
  String? id;
  String? title;

  TagModel({
    @required this.id,
    @required this.title,
  });
}
