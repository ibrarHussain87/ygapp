import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/fiber_countries.dart';
import 'package:yg_app/model/response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberSpecificationComponent extends StatefulWidget {
  Function? callback;
  SyncFiberResponse syncFiberResponse;

  FiberSpecificationComponent(
      {Key? key, required this.syncFiberResponse, required this.callback})
      : super(key: key);

  @override
  _FiberSpecificationComponentState createState() =>
      _FiberSpecificationComponentState();
}

class _FiberSpecificationComponentState
    extends State<FiberSpecificationComponent> {

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 9,
            child: Padding(
              padding: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTextWidget(
                      title: AppStrings.specifications,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.w),
                      child: Text(
                        AppStrings.selectSpecifications,
                        style:
                            TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
                      ),
                    ),
                    Form(
                      key: globalFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.w),
                            child: GridTileWidget(
                              spanCount: 3,
                              listOfItems:
                                  widget.syncFiberResponse.data.fiber.grades,
                              callback: (value) {},
                            ),
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Fiber Length')),
                                    SizedBox(
                                      height: 36.w,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          // onSaved: (input) =>
                                          // userName = input!,
                                          validator: (input) {
                                            if (input == null || input.isEmpty) {
                                              return "Please enter fiber length";
                                            }
                                            return null;
                                          },
                                          decoration: roundedTextFieldDecoration(
                                              'Fiber Length')),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Micronaire (Mic)')),
                                    SizedBox(
                                      height: 36.w,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          // onSaved: (input) =>
                                          // userName = input!,
                                          validator: (input) {
                                            if (input == null || input.isEmpty) {
                                              return "Please enter Micronaire (Mic)";
                                            }
                                            return null;
                                          },
                                          decoration: roundedTextFieldDecoration(
                                              'Micronaire (Mic)')),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Moisture')),
                                    SizedBox(
                                      height: 36.w,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          // onSaved: (input) =>
                                          // userName = input!,
                                          validator: (input) {
                                            if (input == null || input.isEmpty) {
                                              return "Please enter Moisture";
                                            }
                                            return null;
                                          },
                                          decoration: roundedTextFieldDecoration(
                                              'Moisture')),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Trash')),
                                    SizedBox(
                                      height: 36.w,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          // onSaved: (input) =>
                                          // userName = input!,
                                          validator: (input) {
                                            if (input == null || input.isEmpty) {
                                              return "Please enter Trash";
                                            }
                                            return null;
                                          },
                                          decoration: roundedTextFieldDecoration(
                                              'Trash')),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'RD')),
                                    SizedBox(
                                      height: 36.w,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          // onSaved: (input) =>
                                          // userName = input!,
                                          validator: (input) {
                                            if (input == null || input.isEmpty) {
                                              return "Please enter RD";
                                            }
                                            return null;
                                          },
                                          decoration: roundedTextFieldDecoration(
                                              'RD')),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'GPT')),
                                    SizedBox(
                                      height: 36.w,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          // onSaved: (input) =>
                                          // userName = input!,
                                          validator: (input) {
                                            if (input == null || input.isEmpty) {
                                              return "Please enter GPT";
                                            }
                                            return null;
                                          },
                                          decoration: roundedTextFieldDecoration(
                                              'GPT')),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: TitleSmallTextWidget(
                                      title: 'Apperance')),
                              GridTileWidget(
                                spanCount: 2,
                                listOfItems:
                                    widget.syncFiberResponse.data.fiber.apperance,
                                callback: (value) {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Brand')),
                                    SizedBox(
                                      height: 36.w,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          // onSaved: (input) =>
                                          // userName = input!,
                                          validator: (input) {
                                            if (input == null || input.isEmpty) {
                                              return "Please enter Brand";
                                            }
                                            return null;
                                          },
                                          decoration: roundedTextFieldDecoration(
                                              'Brand')),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 8.w),
                                        child: TitleSmallTextWidget(
                                            title: 'Production Year')),
                                    SizedBox(
                                      height: 36.w,
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          cursorColor: Colors.black,
                                          // onSaved: (input) =>
                                          // userName = input!,
                                          validator: (input) {
                                            if (input == null || input.isEmpty) {
                                              return "Please enter production year";
                                            }
                                            return null;
                                          },
                                          decoration: roundedTextFieldDecoration(
                                              'Production year')),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: TitleSmallTextWidget(
                                  title: 'Country')),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.lightBlueTabs,
                                width: 1, //                   <--- border width here
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(24.w))
                            ),
                            child: SizedBox(
                              height: 36.w,
                              child: DropdownButtonFormField(
                                items: widget.syncFiberResponse.data.fiber.countries
                                    .map((value) => DropdownMenuItem(
                                  child: Text(value.conName),
                                  value: value,
                                ))
                                    .toList(),
                                onChanged: (FiberCountries? value) {},
                                value: widget.syncFiberResponse.data.fiber.countries.first,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 16.w,
                                      right: 6.w,
                                      top: 0,
                                      bottom: 0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                  )/*OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.lightBlueTabs),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24.w),
                                      ))*/,
                                ),
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: AppColors.textColorGrey),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: TitleSmallTextWidget(
                                      title: 'Certification')),
                              GridTileWidget(
                                spanCount: widget.syncFiberResponse.data.fiber.certification.length,
                                listOfItems:
                                widget.syncFiberResponse.data.fiber.certification,
                                callback: (value) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButtonWithIcon(
                  callback: () {},
                  color: AppColors.btnColorLogin,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
