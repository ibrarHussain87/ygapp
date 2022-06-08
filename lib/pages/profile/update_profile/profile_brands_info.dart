

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
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/request/update_profile/brands_request_model.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import '../../../providers/profile_providers/user_brands_provider.dart';


class ProfileBrandsInfoPage extends StatefulWidget {
  final Function? callback;

  final String? selectedTab;
   const ProfileBrandsInfoPage(
       {Key? key,
         required this.callback,
         required this.selectedTab}) : super(key: key);

  @override
  ProfileBrandsInfoPageState createState() => ProfileBrandsInfoPageState();
}

class ProfileBrandsInfoPageState extends State<ProfileBrandsInfoPage>
    with AutomaticKeepAliveClientMixin{
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> brandsKey = GlobalKey<FormState>();

  late BrandsRequestModel _updateBrandsRequestModel;
  List<UserBrands> _tags=[];
  List<Brands> brandsList = [];
   var brandController=TextEditingController();
  final _typeAheadController=TextEditingController();

  final _brandsProvider = locator<UserBrandsProvider>();
  @override
  void initState() {

    _updateBrandsRequestModel = BrandsRequestModel();
  AppDbInstance().getDbInstance().then((value) => {

      value.brandsDao.findAllBrands().then((value) {
        setState(() {
          brandsList = value;
        });
      }),
    value.userBrandsDao.findAllUserBrands().then((value) {
        setState(() {
          _tags = value;
        });
      }),

    });

    _brandsProvider.addListener(() {updateUI();});
    _brandsProvider.getUserBrandsData();
    super.initState();
  }




updateUI() {
  if (mounted) {
    setState(() {});
  }
}

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Builder(builder: (BuildContext context2) {
                    return buildBrands(context2);
                  }),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }


  buildBrands(BuildContext context2)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: brandsKey,
          child: Padding(
            padding:
            EdgeInsets.only(top: 30.w, bottom: 0.w, left: 8.w, right: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Expanded(
                  flex:3,
                  child:  TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _typeAheadController,

                        decoration: textFieldProfile(
                            'Enter Brand', "Brand"),
                      ),
                      suggestionsCallback: (pattern) {
                        return brandsList.where(
                                (Brands x) => x.brdName.toString().toLowerCase().contains(pattern)
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
                      onSuggestionSelected: (Brands suggestion) {
                        _typeAheadController.text = suggestion.brdName.toString();
                        _updateBrandsRequestModel.brdId=suggestion.brdId.toString();
                        _updateBrandsRequestModel.brdName=suggestion.brdName.toString();
                        _updateBrandsRequestModel.brdOther = "0";
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
                          return 'Please enter brand name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print("Value"+value.toString());
                        _updateBrandsRequestModel.brdName = value;

                      }

                  ),
                ),

                const SizedBox(width: 10,),
                InkWell(
                  onTap: ()=>{
                    if (validateBrandInput()) {
                      _addTags(_updateBrandsRequestModel)
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 13.0,
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
                )
              ],
            ),


          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Your Brands",textAlign: TextAlign.left,style: TextStyle(
              fontSize: 18.0.w,
              color: headingColor,
              fontWeight: FontWeight.w700)),
        ),
        _tagIcon(context2)


      ],
    );
  }

  Widget _tagIcon(BuildContext ctx) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _brandsProvider.brandsList!=null
                  ? Column(children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  children:   _brandsProvider.brandsList
                      !.map((UserBrands tagModel) => tagChip(
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
        )
      ],
    );
  }




//  _addTags(tagModel) async {
//    if (!_tags.contains(tagModel)) {
//      setState(() {
//        if(brandController.text!=null){
//        brandController.clear();}
//        _tags.add(tagModel);
//      });
//    }
//  }


  _addTags(BrandsRequestModel _brandsModel) async {
    _updateBrandsCall(context);

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
                      '${tagModel.brdName}',
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

  void handleNextClick() {
    widget.callback!(3);

  }


  bool validateBrandInput() {
    final form = brandsKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }




  void _updateBrandsCall(BuildContext context1) {
    check().then((value) {
      if (value) {
        ProgressDialogUtil.showDialog(context, 'Please wait...');
        Logger().e(_updateBrandsRequestModel.toJson());
        ApiService.updateBrands(_updateBrandsRequestModel).then((value) {

          ProgressDialogUtil.hideDialog();
//            if (value.errors != null) {
//              value.errors!.forEach((key, error) {
//                ScaffoldMessenger.of(context)
//                    .showSnackBar(SnackBar(content: Text(error.toString())));
//              });
//            } else
          if (value.status!) {
            Logger().e(value.data!.brands!);
            AppDbInstance().getDbInstance().then((db) async {
              await db.userDao.insertUser(value.data!);
              await db.userBrandsDao.insertAllUserBrands(value.data!.brands!);
              await db.businessInfoDao.insertBusinessInfo(value.data!.businessInfo!);

              _brandsProvider.getUserBrandsData();
            });

            setState(() {
              _typeAheadController.clear();
            });
            Fluttertoast.showToast(
                msg: value.message ?? "",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
//            var brandsNotifier = context1.read<UserBrandsNotifier>();
//            brandsNotifier.updateBrands(value.data!.brands!);
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


