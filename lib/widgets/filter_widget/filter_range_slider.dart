import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/string_util.dart';

import '../decoration_widgets.dart';
import '../title_text_widget.dart';

class FilterRangeSlider extends StatefulWidget {
  final String? minMaxRange;
  final String? hintTxt;

  const FilterRangeSlider(
      {Key? key, required this.minMaxRange, required this.hintTxt})
      : super(key: key);

  @override
  _FilterRangeSliderState createState() => _FilterRangeSliderState();
}

class _FilterRangeSliderState extends State<FilterRangeSlider> {
  RangeValues? _values;

  @override
  void initState() {
    _values = RangeValues(StringUtils.splitMin(widget.minMaxRange!), StringUtils.splitMax(widget.minMaxRange!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: TitleSmallTextWidget(
                          title: widget.hintTxt! + ' min')),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.lightBlueTabs,
                      style: TextStyle(fontSize: 11.sp),
                      textAlign: TextAlign.center,
                      cursorHeight: 16.w,
                      onSaved: (input) => {},
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return widget.hintTxt! + " min";
                        }
                        return null;
                      },
                      decoration: roundedTextFieldDecoration(
                          StringUtils.splitMin(widget.minMaxRange!).toString() +
                              ' %')),
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
                          title: widget.hintTxt! + " max")),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.lightBlueTabs,
                      style: TextStyle(fontSize: 11.sp),
                      textAlign: TextAlign.center,
                      cursorHeight: 16.w,
                      onSaved: (input) => {},
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return widget.hintTxt! + "max";
                        }
                        return null;
                      },
                      decoration: roundedTextFieldDecoration(
                          StringUtils.splitMax(widget.minMaxRange!).toString() +
                              ' %')),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.w,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.lightBlueTabs,
                inactiveTrackColor: Colors.grey,
                trackShape: const RectangularSliderTrackShape(),
                trackHeight: 1.0,
                thumbColor: AppColors.lightBlueTabs,
                showValueIndicator: ShowValueIndicator.always,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 4.0),
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: RangeSlider(
                  min: 1.0,
                  max: 10.0,
                  values: _values!,
                  labels: RangeLabels(_values!.start.toStringAsFixed(1),
                      _values!.end.toStringAsFixed(1)),
                  onChanged: (value) {
                    setState(() {
                      _values = value;
                    });
                  })),
        )
      ],
    );
  }
}
