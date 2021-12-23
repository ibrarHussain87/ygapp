import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/decimal_text_input_formatter.dart';
import 'package:yg_app/utils/numeriacal_range_text_field.dart';

import '../decoration_widgets.dart';
import '../title_text_widget.dart';

class FilterRangeSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final String? hintTxt;
  final Function minCallback;
  final Function maxCallback;

  const FilterRangeSlider(
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
  late double low;
  late double high;

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    // minValue = StringUtils.splitMin(widget.minMaxRange!);
    // maxValue = StringUtils.splitMax(widget.minMaxRange!);
    low = widget.minValue;
    high = widget.maxValue;

    _values = RangeValues(widget.minValue, widget.maxValue);
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
                      padding:
                          EdgeInsets.only(top: 4.w, left: 8.w, bottom: 8.w),
                      child: TitleSmallTextWidget(
                          title: widget.hintTxt! + ' min')),
                  TextFormField(
                      controller: minController,
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2,maxValue: widget.maxValue),
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      cursorColor: Colors.black,
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
                      // inputFormatters: [
                      //   NumericalRangeFormatter(
                      //     min: 0,
                      //     max: widget.maxValue!,
                      //   )
                      // ],
                      onChanged: (String value) {
                        double numValue = double.parse(value);
                        if (numValue >= low && numValue < high) {
                          setState(() {
                            low = double.tryParse(value)!;
                            // minValue = double.tryParse(value);
                            _values = RangeValues(low, high);
                            widget.minCallback(low);
                          });
                        }
                      },
                      decoration: roundedTFDGrey('${widget.minValue} %')),
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
                      padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                      child: TitleSmallTextWidget(
                          title: widget.hintTxt! + " max")),
                  TextFormField(
                      controller: maxController,
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2,maxValue: widget.maxValue),
                      ],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      cursorColor: Colors.black,
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
                      onChanged: (String value) {
                        double numValue = double.parse(value);
                        if (numValue >= low && numValue < high) {
                          setState(() {
                            high = double.tryParse(value)!;
                            // maxValue = double.tryParse(value);
                            _values = RangeValues(low, high);
                            widget.maxCallback(high);
                          });
                        }
                      },
                      // inputFormatters: [
                      //   NumericalRangeFormatter(
                      //     min: 0,
                      //     max: widget.maxValue!,
                      //   )
                      // ],
                      decoration:
                          roundedTFDGrey(widget.maxValue.toString() + ' %')),
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
                trackHeight: 0.1,
                minThumbSeparation: 1,
                showValueIndicator: ShowValueIndicator.always,
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 3),
                inactiveTrackColor: Colors.grey,
              ),
              child: RangeSlider(
                  min: widget.minValue,
                  max: widget.maxValue,
                  values: _values!,
                  labels: RangeLabels(_values!.start.toStringAsFixed(2),
                      _values!.end.toStringAsFixed(2)),
                  onChanged: (value) {
                    setState(() {
                      minController.text = value.start.toStringAsFixed(2);
                      maxController.text = value.end.toStringAsFixed(2);
                      widget.minCallback(
                          double.parse(value.start.toStringAsFixed(2)));
                      widget.maxCallback(
                          double.parse(value.end.toStringAsFixed(2)));
                      _values = value;
                    });
                  })),
        )
      ],
    );
  }
}
