import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/app_database/app_database.dart';
import 'package:yg_app/model/response/fiber_response/sync/common_response_models/countries_response.dart';
import 'package:yg_app/model/response/fiber_response/sync/fiber_sync_response/sync_fiber_response.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/constants.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget_2.dart';
import 'package:yg_app/widgets/filter_widget/filter_grid_tile_widget.dart';
import 'package:yg_app/widgets/filter_widget/filter_material_listview.dart';
import 'package:yg_app/widgets/filter_widget/filter_range_slider.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberFilterView extends StatefulWidget {

  final SyncFiberResponse syncFiberResponse;
  const FiberFilterView({Key? key,required this.syncFiberResponse}) : super(key: key);

  @override
  _FiberFilterViewState createState() => _FiberFilterViewState();
}

class _FiberFilterViewState extends State<FiberFilterView> {

  List<FiberSettings> listOfSettings = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              top: 16.w, left: 16.w, right: 16.w, bottom: 16.w),
                          child: const TitleTextWidget(
                            title: 'Fiber Material',
                          )),
                      SizedBox(
                        height: 58.w,
                        child: FilterMaterialWidget(
                          listItem: widget.syncFiberResponse.data.fiber.material,
                          onClickCallback: (index) {
                            _querySetting(widget.syncFiberResponse.data.fiber.material[index].fbmId);
                          },
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child:
                              const TitleSmallTextWidget(title: 'Grades')),
                          FilterGridTileWidget(
                            spanCount: 3,
                            listOfItems: widget.syncFiberResponse.data.fiber.grades,
                            callback: (value) {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      FilterRangeSlider(
                        minMaxRange:
                        widget.syncFiberResponse.data.fiber.settings[0].micMinMax,
                        hintTxt: "Micronaire (Mic)",
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      FilterRangeSlider(
                        minMaxRange:
                        widget.syncFiberResponse.data.fiber.settings[0].moiMinMax,
                        hintTxt: "Moisture",
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      FilterRangeSlider(
                        minMaxRange:
                        widget.syncFiberResponse.data.fiber.settings[0].rdMinMax,
                        hintTxt: "RD",
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: const TitleSmallTextWidget(
                                  title: 'Apperance')),
                          FilterGridTileWidget(
                            spanCount: 2,
                            listOfItems: widget.syncFiberResponse.data.fiber.apperance,
                            callback: (value) {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: TitleSmallTextWidget(
                                        title: 'Production Year')),
                                TextFormField(
                                  keyboardType: TextInputType.none,
                                  controller: _textEditingController,
                                  cursorColor: AppColors.lightBlueTabs,
                                  autofocus: false,
                                  style: TextStyle(fontSize: 11.sp),
                                  textAlign: TextAlign.center,
                                  showCursor: false,
                                  readOnly: true,
                                  onSaved: (input) => {},
                                  validator: (input) {
                                    if (input == null || input.isEmpty) {
                                      return "Please enter production year";
                                    }
                                    return null;
                                  },
                                  decoration: roundedTextFieldDecoration(
                                      'Production year'),
                                  onTap: () {
                                    handleReadOnlyInputClick(context);
                                  },
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
                                    child: const TitleSmallTextWidget(
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
                                    width: double.maxFinite,
                                    child: DropdownButtonFormField(
                                      isExpanded: true,
                                      hint: const Text('Select country'),
                                      items:
                                      widget.syncFiberResponse.data.fiber.countries
                                          .map((value) => DropdownMenuItem(
                                        child: Text(value.conName,
                                            textAlign:
                                            TextAlign.center),
                                        value: value,
                                      ))
                                          .toList(),
                                      onChanged: (CountriesModel? value) {

                                      },
                                      // value: widget.syncFiberResponse.data.fiber.countries.first,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 16.w,
                                            right: 6.w,
                                            top: 0,
                                            bottom: 0),
                                        border: const OutlineInputBorder(
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
                                          color: AppColors.textColorGrey),
                                    ),
                                  ),
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
                              child: const TitleSmallTextWidget(
                                  title: 'Certification')),
                          FilterGridTileWidget(
                            spanCount: 2,
                            listOfItems:
                            widget.syncFiberResponse.data.fiber.certification,
                            callback: (value) {},
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
                              child:
                              const TitleSmallTextWidget(title: 'Packing')),
                          FilterGridTileWidget(
                            spanCount: 3,
                            listOfItems: widget.syncFiberResponse.data.fiber.packing,
                            callback: (value) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButtonWithoutIcon(
                      callback: () {},
                      color: Colors.grey.shade300,
                      btnText: 'Reset',
                      textColor: 'black',
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: ElevatedButtonWithoutIcon(
                        callback: () {},
                        color: AppColors.textColorBlue,
                        btnText: 'Apply Filter'),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  _querySetting(int id) {
    getDbInstance().then(
            (value) => value.fiberSettingDao.findFiberSettings(id).then((value) {
          setState(() {
            listOfSettings = value;
          });
        }));
  }

  void handleReadOnlyInputClick(context) {
    showBottomSheet(
        context: context,
        builder: (BuildContext context) => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: YearPicker(
            selectedDate: DateTime(DateTime.now().year),
            firstDate: DateTime(DateTime.now().year - 100),
            lastDate: DateTime.now(),
            onChanged: (val) {
              _textEditingController.text = val.year.toString();
              Navigator.pop(context);
            },
          ),
        ));
  }


  Future<AppDatabase> getDbInstance() async {
    var databaseInstance;
    final database = $FloorAppDatabase
        .databaseBuilder(AppConstants.APP_DATABASE_NAME)
        .build();
    await database.then((value) => {databaseInstance = value});

    return databaseInstance;
  }
}
