import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/request/login_request/fiber_request.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_countries.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/elevated_button_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class PackingDetails extends StatefulWidget {

  FiberRequestModel? requestModel;
  SyncFiberResponse? syncFiberResponse;

  PackingDetails({Key? key,required this.requestModel,required this.syncFiberResponse}) : super(key: key);

  @override
  _PackingDetailsState createState() => _PackingDetailsState();
}

class _PackingDetailsState extends State<PackingDetails> {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> sellingRegion = ['Local','International'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: SingleChildScrollView(
            child: Padding(
              padding:EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
              child: Form(
                key: globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding:
                              EdgeInsets.only(left: 8.w),
                              child: TitleSmallTextWidget(
                                  title: 'Selling Region')),
                          GridTileWidget(
                            spanCount: 2,
                            listOfItems: sellingRegion,
                            callback: (value) {
                            },
                            selectedIndex: 0,
                          ),
                          SizedBox(height: 8.w,),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: TitleSmallTextWidget(
                                      title: 'Country')),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.lightBlueTabs,
                                      width:
                                      1, //                   <--- border width here
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(24.w))),
                                child: SizedBox(
                                  height: 36.w,
                                  child: DropdownButtonFormField(
                                    hint: Text('Select country'),
                                    items: widget.syncFiberResponse!
                                        .data.fiber.countries
                                        .map((value) =>
                                        DropdownMenuItem(
                                          child: Text(
                                              value.conName,
                                              textAlign: TextAlign
                                                  .center),
                                          value: value,
                                        ))
                                        .toList(),
                                    onChanged:
                                        (FiberCountries? value) {
                                      widget.requestModel!
                                          .spc_origin_idfk =
                                          value!.conId.toString();
                                    },
                                    // value: widget.syncFiberResponse.data.fiber.countries.first,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 16.w,
                                          right: 6.w,
                                          top: 0,
                                          bottom: 0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide
                                              .none) /*OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.lightBlueTabs),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(24.w),
                                          ))*/
                                      ,
                                    ),
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color:
                                        AppColors.textColorGrey),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),flex: 9,),
          Expanded(child: Padding(
            padding: EdgeInsets.all(8.w),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButtonWithIcon(
                callback: (){

                },
                color: AppColors.btnColorLogin, btnText: 'Submit',
              ),
            ),
          ),flex: 1,),
        ],
      ),
    );
  }
}
