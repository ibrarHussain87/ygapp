
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_cupertino.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/elevated_button_widget.dart';
import 'package:yg_app/elements/list_widgets/single_select_tile_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/elements/yg_text_form_field.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/blended_single_tile.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/common_response_models/brands_response.dart';
import 'package:yg_app/model/response/common_response_models/certification_response.dart';
import 'package:yg_app/model/response/common_response_models/city_state_response.dart';
import 'package:yg_app/model/response/common_response_models/countries_response.dart';

import '../../../../Providers/post_fabric_provider.dart';
import '../../../../helper_utils/fabric_bottom_sheet.dart';
import '../../../../helper_utils/pure_single_tile.dart';
import '../../../../model/blend_model.dart';
import '../../../../model/request/post_fabric_request/create_fabric_request_model.dart';
import '../../../../model/response/fabric_response/sync/fabric_sync_response.dart';
import '../../../elements/decoration_widgets.dart';
import '../../../model/request/signup_request/signup_request.dart';

class CountryComponent extends StatefulWidget {
  final Function? callback;

  final String? selectedTab;

  const CountryComponent(
      {Key? key,
        // required this.syncFiberResponse,
        required this.callback,
        required this.selectedTab})
      : super(key: key);

  @override
  CountryComponentState createState() => CountryComponentState();
}

class CountryComponentState
    extends State<CountryComponent>
    with AutomaticKeepAliveClientMixin {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  SignUpRequestModel? _signupRequestModel;

  String countryString="";

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _resetData();
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
//    _signupRequestModel?.countryId="AF";
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
//      key: scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding:
              EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Form(
                      key: globalFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.w,
                          ),
                          Center(
                            child: Column(
                              children: [
                                CountryPickerDropdown(

                                  underline: InputDecorator(
                                    decoration: dropDownProfile("Select Country", "Country"),
                                  ),
                                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                                  onValuePicked: (Country country) {
                                    print("${country.isoCode}");

                                    print("${_signupRequestModel?.countryId}");


                                    _signupRequestModel?.countryId=country.isoCode;
                                    print("${_signupRequestModel?.countryId}");
                                  },
                                  itemBuilder: (Country country) {
                                    return Row(
                                      children: <Widget>[
                                        const SizedBox(width: 8.0),
                                        CountryPickerUtils.getDefaultFlagImage(country),
                                        const SizedBox(width: 8.0),
                                        Expanded(child: Text(country.name)),
                                      ],
                                    );
                                  },
                                  itemHeight: null,
                                  isExpanded: true,
                                  //initialValue: 'TR',
                                  icon: const Icon(Icons.arrow_drop_down_outlined),
                                ),

                              ],

                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButtonWithIcon(
                callback: () async {
                  handleNextClick();
                },
                color: btnColorLogin,
                btnText: "Next",
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openCupertinoCountryPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CountryPickerCupertino(
          pickerSheetHeight: 300.0,
          onValuePicked: (Country country) =>
              setState(() => _signupRequestModel?.countryId = country.isoCode),
          itemFilter: (c) => ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('TR'),
            CountryPickerUtils.getCountryByIsoCode('US'),
          ],
        );
      });

  void handleNextClick() {
if (validationAllPage()) {

      widget.callback!(1);
    }
  }

  _resetData() {
    _signupRequestModel?.countryId=null;

  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }



  bool validationAllPage() {
    _signupRequestModel?.countryId ??= "AF";
    if (validateAndSave()) {
      if (_signupRequestModel?.countryId == null &&
          Ui.showHide("1")) {
        Ui.showSnackBar(context, 'Please select country');
        return false;
      }
      else {
        return true;
      }
    }
    return false;
    //  return true;
  }



}


