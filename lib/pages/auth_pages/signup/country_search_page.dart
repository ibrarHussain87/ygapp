
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';

import '../../../elements/circle_icon_widget.dart';
import '../../../elements/custom_header.dart';
import '../../../model/request/signup_request/signup_request.dart';

class SelectCountryPage extends StatefulWidget {
  final Function? callback;
  final bool isCodeVisible;
  final String? title;

  const SelectCountryPage(
      {Key? key,
        required this.callback,
        required this.isCodeVisible,
        required this.title})
      : super(key: key);

  @override
  SelectCountryPageState createState() => SelectCountryPageState();
}

class SelectCountryPageState extends State<SelectCountryPage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  SignUpRequestModel? _signupRequestModel;

  String countryString = "";

  List<Countries> countriesList = [];

  List<Countries>? _countriesFilterList;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    AppDbInstance().getDbInstance().then((value) =>
    {
      value.countriesDao.findAllCountries().then((value) {
        setState(() {
          countriesList = value;
          _countriesFilterList=countriesList;
        });
      })
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
    _signupRequestModel = Provider.of<SignUpRequestModel?>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: appBar(context, widget.title.toString()),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 8, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: searchBarColor,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(24.w)),
                          color: Colors.grey.shade100
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 10.w, bottom: 10.w),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8.w,
                            ),
                            Icon(
                              Icons.search_rounded,
                              size: 20.w,
                              color: searchBarGreyStroke,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (value) {
                                  filterListSearch(value);
                                },
                                cursorColor: Colors.black,
                                keyboardType: TextInputType
                                    .text,
                                style: TextStyle(
                                    fontSize: 11.sp),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder
                                      .none,
                                  enabledBorder: InputBorder
                                      .none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder:
                                  InputBorder.none,
                                  isDense: true,
                                  // this will remove the default content padding
                                  // now you can customize it here or add padding widget
                                  contentPadding:
                                  EdgeInsets.symmetric(
                                      horizontal: 0,
                                      vertical: 0),
                                  // contentPadding:
                                  // EdgeInsets.only(left: 4, bottom: 4, top: 4, right: 4),
                                  hintText:
                                  "Search",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Expanded(

              child
                  : countriesList.isNotEmpty
                  ? ListView.builder(

                shrinkWrap: true,
                itemCount: _countriesFilterList?.length,
                itemBuilder: (context, index) =>
                    Padding(
                      padding: const EdgeInsets.only(top:18.0,bottom: 18.0,left: 12.0,right: 12.0),
                      child: InkWell(
                        onTap: ()=>{
                          widget.callback!(_countriesFilterList![index]),
                          Navigator.of(context).pop()
                        },
                        child: Row(
                          key: ValueKey(_countriesFilterList![index].conId),
                          children: <Widget>[
                            Expanded(
                              child: CircleImageIconWidget(
                                  imageUrl:
                                  _countriesFilterList![index].medium.toString()),
                            ),
                            SizedBox(width: 6.w,),
                            Expanded(
                                flex:8,
                                child: Text(
                                  _countriesFilterList![index].conName.toString(),textAlign: TextAlign.start,style: TextStyle(color: font_dark_grey,fontSize: 15.sp),)),
                            Visibility(
                              visible: widget.isCodeVisible,
                              child: Expanded(
                                flex:2,
                                child: Text(
                                  _countriesFilterList![index].countryPhoneCode.toString(),textAlign: TextAlign.end,style: TextStyle(color: font_light_grey,fontSize: 15.sp),),
                              ),
                            )
                          ],
                        ),
                      ),
                    )

              )
                  :  Center(
                    child: Text(
                'No Country found',
                style: TextStyle(fontSize: 10.sp),
              ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  filterListSearch(value) {
    setState(() {
      _countriesFilterList = countriesList
          .where((element) =>
      (element.conName.toString().toLowerCase().contains(value)))
          .toList();
    });
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Countries> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      setState(() {
        results = countriesList;
      });
    } else {
      setState(() {
        results = countriesList
            .where((country) =>
            country.conName.toString().toLowerCase().contains(enteredKeyword.toLowerCase()))
            .toList();
      });
      // we use the toLowerCase() method to make it case-insensitive
    }

  }

}