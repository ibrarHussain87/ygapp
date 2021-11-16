import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/request/login_request/fiber_request.dart';
import 'package:yg_app/model/response/sync/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/sync/common_response_models/ports_response.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class PackingDetails extends StatefulWidget {
  FiberRequestModel? requestModel;
  SyncFiberResponse? syncFiberResponse;

  PackingDetails(
      {Key? key, required this.requestModel, required this.syncFiberResponse})
      : super(key: key);

  @override
  _PackingDetailsState createState() => _PackingDetailsState();
}

class _PackingDetailsState extends State<PackingDetails> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> sellingRegion = ['Local', 'International'];

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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const TitleTextWidget(
                        title: 'Packing Details',
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 8.w),
                                child: TitleSmallTextWidget(
                                    title: 'Selling Region')),
                            GridTileWidget(
                              spanCount: 2,
                              listOfItems: sellingRegion,
                              callback: (value) {},
                              selectedIndex: 0,
                            ),
                            Visibility(
                              visible: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(
                                                title: 'Country')),
                                        SizedBox(
                                          height: 36.w,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      AppColors.lightBlueTabs,
                                                  width:
                                                      1, //                   <--- border width here
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24.w))),
                                            child: DropdownButtonFormField(
                                              hint: Text('Select Country'),
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
                                                  (CountriesModel? value) {
                                                widget.requestModel!
                                                        .spc_origin_idfk =
                                                    value!.conId.toString();
                                              },

                                              // value: widget.syncFiberResponse.data.fiber.brands.first,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 16.w,
                                                    right: 6.w,
                                                    top: 0,
                                                    bottom: 0),
                                                border:
                                                    const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                              ),
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color:
                                                      AppColors.textColorGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.w),
                                            child: TitleSmallTextWidget(
                                                title: 'Port')),
                                        SizedBox(
                                          height: 36.w,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      AppColors.lightBlueTabs,
                                                  width:
                                                      1, //                   <--- border width here
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(24.w))),
                                            child: DropdownButtonFormField(
                                              hint: Text('Select Port'),
                                              items: widget.syncFiberResponse!
                                                  .data.fiber.ports
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        child: Text(
                                                            value.prtName,
                                                            textAlign: TextAlign
                                                                .center),
                                                        value: value,
                                                      ))
                                                  .toList(),
                                              onChanged: (PortsModel? value) {
                                                widget.requestModel!
                                                        .spc_origin_idfk =
                                                    value!.prtId.toString();
                                              },

                                              // value: widget.syncFiberResponse.data.fiber.brands.first,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 16.w,
                                                    right: 6.w,
                                                    top: 0,
                                                    bottom: 0),
                                                border:
                                                    const OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none),
                                              ),
                                              style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color:
                                                      AppColors.textColorGrey),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child:
                                    TitleSmallTextWidget(title: 'Price Terms')),
                            GridTileWidget(
                                spanCount: 3,
                                listOfItems: widget
                                    .syncFiberResponse!.data.fiber.priceTerms,
                                callback: (value) {}),
                            Visibility(
                              visible:false,
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.w, left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Payment Type')),
                                GridTileWidget(
                                    spanCount: 3,
                                    listOfItems: widget.syncFiberResponse!.data
                                        .fiber.paymentType,
                                    callback: (value) {}),
                              ],
                            )),
                            Visibility(
                              visible: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.w, left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: 'LC Type')),
                                  GridTileWidget(
                                      spanCount: 4,
                                      listOfItems: widget
                                          .syncFiberResponse!.data.fiber.lcType,
                                      callback: (value) {}),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 8.w, left: 8.w),
                                      child: TitleSmallTextWidget(
                                          title: 'Unit Of Count')),
                                  GridTileWidget(
                                      spanCount: 4,
                                      listOfItems: widget
                                          .syncFiberResponse!.data.fiber.units,
                                      callback: (value) {}),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.w, left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Price/Unit')),
                                    TextFormField(
                                        keyboardType: TextInputType.number,
                                        cursorColor: AppColors.lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        onSaved: (input) => widget
                                            .requestModel!.fbp_price = input,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Price/Unit";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            "Price/Unit")),
                                  ],
                                )),
                                SizedBox(width: 16.w),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.w, left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Minimum Qty')),
                                    TextFormField(
                                        keyboardType: TextInputType.number,
                                        cursorColor: AppColors.lightBlueTabs,
                                        style: TextStyle(fontSize: 11.sp),
                                        textAlign: TextAlign.center,
                                        cursorHeight: 16.w,
                                        onSaved: (input) => widget.requestModel!
                                            .fbp_min_quantity = input,
                                        validator: (input) {
                                          if (input == null || input.isEmpty) {
                                            return "Minimum Qty";
                                          }
                                          return null;
                                        },
                                        decoration: roundedTextFieldDecoration(
                                            "Minimum Qty")),
                                  ],
                                )),
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child: TitleSmallTextWidget(title: 'Packing')),
                            GridTileWidget(
                                spanCount: 3,
                                listOfItems: widget
                                    .syncFiberResponse!.data.fiber.packing,
                                callback: (value) {}),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child: TitleSmallTextWidget(
                                    title: 'Deilevery Period')),
                            GridTileWidget(
                                spanCount: 3,
                                listOfItems: widget.syncFiberResponse!.data
                                    .fiber.deliveryPeriod,
                                callback: (value) {}),
                            Padding(
                                padding: EdgeInsets.only(top: 8.w, left: 8.w),
                                child:
                                    TitleSmallTextWidget(title: 'Description')),
                            SizedBox(
                              height: 5 * 24.w,
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  maxLines: 5,
                                  cursorColor: AppColors.lightBlueTabs,
                                  style: TextStyle(fontSize: 11.sp),
                                  textAlign: TextAlign.start,
                                  cursorHeight: 16.w,
                                  onSaved: (input) => widget
                                      .requestModel!.fbp_min_quantity = input,
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return "Description";
                                    }
                                    return null;
                                  },
                                  decoration: roundedDescriptionDecoration(
                                      "Description")),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            flex: 9,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButtonWithIcon(
                  callback: () {},
                  color: AppColors.btnColorLogin,
                  btnText: 'Submit',
                ),
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
