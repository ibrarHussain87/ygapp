import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/numeriacal_range_text_field.dart';

import '../decoration_widgets.dart';
import '../title_text_widget.dart';

class FilterRangeSlider extends StatefulWidget {
  double? minValue = 0.0;
  double? maxValue = 100.0;
  final String? hintTxt;
  final Function minCallback;
  final Function maxCallback;

  FilterRangeSlider(
      {Key? key,
      required this.minValue,
      required this.maxValue,
      required this.hintTxt,
      required this.minCallback,
        required this.maxCallback})
      : super(key: key);

  @override
  _FilterRangeSliderState createState() => _FilterRangeSliderState();
}

class _FilterRangeSliderState extends State<FilterRangeSlider> {
  RangeValues? _values;
  double? low;
  double? high;

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    // minValue = StringUtils.splitMin(widget.minMaxRange!);
    // maxValue = StringUtils.splitMax(widget.minMaxRange!);
    low = widget.minValue;
    high = widget.maxValue;

    _values = RangeValues(widget.minValue!, widget.maxValue!);
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
                      controller: minController,
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
                      inputFormatters: [
                        NumericalRangeFormatterMin(
                          min: widget.minValue!,
                        )
                      ],
                      onChanged: (String value) {
                        setState(() {
                          low = double.tryParse(value);
                          // minValue = double.tryParse(value);
                          _values = RangeValues(low!, high!);
                          widget.minCallback(low);
                        });
                      },
                      decoration:
                          roundedTextFieldDecoration('${widget.minValue} %')),
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
                      controller: maxController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.lightBlueTabs,
                      style: TextStyle(fontSize: 11.sp),
                      textAlign: TextAlign.center,
                      cursorHeight: 16.w,
                      onSaved: (input) => {

                      },
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return widget.hintTxt! + "max";
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        setState(() {
                          high = double.tryParse(value);
                          // maxValue = double.tryParse(value);
                          _values = RangeValues(low!, high!);
                          widget.maxCallback(high);
                        });
                      },
                      inputFormatters: [
                        NumericalRangeFormatterMax(
                          max: widget.maxValue!,
                        )
                      ],
                      decoration: roundedTextFieldDecoration(
                          widget.maxValue!.toString() + ' %')),
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
                  min: widget.minValue!,
                  max: widget.maxValue!,
                  values: _values!,
                  labels: RangeLabels(_values!.start.toStringAsFixed(0),
                      _values!.end.toStringAsFixed(0)),
                  onChanged: (value) {
                    setState(() {
                      minController.text = value.start.toStringAsFixed(0);
                      maxController.text = value.end.toStringAsFixed(0);
                      widget.minCallback(double.parse(value.start.toStringAsFixed(0)));
                      widget.maxCallback(double.parse(value.end.toStringAsFixed(0)));
                      _values = value;
                    });
                  })),
        )
      ],
    );
  }
}
