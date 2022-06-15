import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../decoration_widgets.dart';
import '../text_widgets.dart';

class FilterRangeSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final String? hintTxt;

  // final Function minCallback;
  // final Function maxCallback;
  final Function valueCallback;

  const FilterRangeSlider(
      {Key? key,
      required this.minValue,
      required this.maxValue,
      required this.hintTxt,
      // required this.minCallback,
      // required this.maxCallback
      required this.valueCallback})
      : super(key: key);

  @override
  _FilterRangeSliderState createState() => _FilterRangeSliderState();
}

class _FilterRangeSliderState extends State<FilterRangeSlider> {
  // String _valueToString(double value) {
  //   return value.toStringAsFixed(2);
  // }

  // RangeValues? _values;
  // late double minSpinValue;
  // late double maxSpinValue;

  // TextEditingController minController = TextEditingController();
  // TextEditingController maxController = TextEditingController();

  @override
  void initState() {
    // minSpinValue = widget.minValue;
    // maxSpinValue = widget.maxValue;
    // _values = RangeValues(widget.minValue, widget.maxValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSmallTextWidget(title: widget.hintTxt),
        SizedBox(
          height: 4.w,
        ),
        SpinBox(
          max: widget.maxValue,
          min: widget.minValue,
          showButtons: false,
          keyboardType: TextInputType.number,
          decimals: 2,
          step: 0.2,
          enableInteractiveSelection: false,
          readOnly: false,
          textStyle: TextStyle(fontSize: 9.sp, color: Colors.grey.shade600),
          decoration: roundedTFDGrey('${widget.minValue} %'),
          onChanged: (value) {
            widget.valueCallback(value);
            // setState(() {
            // if (value != 0.0 && value <= widget.maxValue && value > minSpinValue) {
            //   maxSpinValue = value;
            //   widget.maxCallback(value);
            //   _values = RangeValues(minSpinValue, value);
            // }
            // });
          },
        ),
      ],
    ) /*Column(
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
                  // TextFormField(
                  //     controller: minController,
                  //     inputFormatters: [
                  //       DecimalTextInputFormatter(decimalRange: 2),
                  //       FilteringTextInputFormatter.allow(
                  //           RegExp(r'^\d*\.?\d{0,2}')),
                  //     ],
                  //     keyboardType: TextInputType.number,
                  //     cursorColor: Colors.black,
                  //     style: TextStyle(fontSize: 11.sp),
                  //     textAlign: TextAlign.center,
                  //     cursorHeight: 16.w,
                  //     onSaved: (input) => {},
                  //     validator: (input) {
                  //       if (input == null || input.isEmpty) {
                  //         return widget.hintTxt! + " min";
                  //       }
                  //       return null;
                  //     },
                  //     onChanged: (String value) {
                  //       double numValue = double.parse(value);
                  //       if (numValue >= low && numValue < high) {
                  //         setState(() {
                  //           low = double.tryParse(value)!;
                  //           // minValue = double.tryParse(value);
                  //           _values = RangeValues(low, high);
                  //           widget.minCallback(low);
                  //         });
                  //       }
                  //     },
                  //     decoration: roundedTFDGrey('${widget.minValue} %')),
                  SpinBox(
                    max: maxSpinValue,
                    min: widget.minValue,
                    showButtons: false,
                    keyboardType: TextInputType.number,
                    decimals: 2,
                    value: minSpinValue,
                    enableInteractiveSelection: false,
                    step: 0.2,
                    readOnly: false,
                    textStyle:
                        TextStyle(fontSize: 9.sp, color: Colors.grey.shade600),
                    decoration: roundedTFDGrey('${widget.minValue} %'),
                    onChanged: (value) {
                      setState(() {
                        if (value != 0.0 && value <= widget.maxValue) {
                          minSpinValue = value;
                          widget.minCallback(value);
                          _values = RangeValues(value, maxSpinValue);
                        }
                      });
                      // }
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
                      padding: EdgeInsets.only(left: 8.w, bottom: 8.w),
                      child: TitleSmallTextWidget(
                          title: widget.hintTxt! + " max")),
                  // TextFormField(
                  //     controller: maxController,
                  //     inputFormatters: [
                  //       DecimalTextInputFormatter(decimalRange: 2),
                  //       FilteringTextInputFormatter.allow(
                  //           RegExp(r'^\d*\.?\d{0,2}')),
                  //     ],
                  //     keyboardType: TextInputType.number,
                  //     cursorColor: Colors.black,
                  //     style: TextStyle(fontSize: 11.sp),
                  //     textAlign: TextAlign.center,
                  //     cursorHeight: 16.w,
                  //     onSaved: (input) => {},
                  //     validator: (input) {
                  //       if (input == null || input.isEmpty) {
                  //         return widget.hintTxt! + "max";
                  //       }
                  //       return null;
                  //     },
                  //     onChanged: (value) {
                  //       double numValue = double.parse(value);
                  //       if (numValue >= low && numValue < high) {
                  //         setState(() {
                  //           high = double.tryParse(value)!;
                  //           _values = RangeValues(low, high);
                  //           widget.maxCallback(high);
                  //         });
                  //       }
                  //     },
                  //     decoration:
                  //         roundedTFDGrey(widget.maxValue.toString() + ' %')),

                  SpinBox(
                    max: widget.maxValue,
                    min: minSpinValue,
                    showButtons: false,
                    keyboardType: TextInputType.number,
                    decimals: 2,
                    step: 0.2,
                    value: maxSpinValue,
                    enableInteractiveSelection: false,
                    readOnly: false,
                    textStyle:
                        TextStyle(fontSize: 9.sp, color: Colors.grey.shade600),
                    decoration: roundedTFDGrey('${widget.minValue} %'),
                    onChanged: (value) {
                      setState(() {
                        if (value != 0.0 && value <= widget.maxValue && value > minSpinValue) {
                          maxSpinValue = value;
                          widget.maxCallback(value);
                          _values = RangeValues(minSpinValue, value);
                        }
                      });
                    },
                  )
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
                activeTrackColor: lightBlueTabs,
                trackHeight: 0.1,
                minThumbSeparation: 1,
                showValueIndicator: ShowValueIndicator.always,
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 3),
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
                      minSpinValue = double.parse(_valueToString(value.start));
                      maxSpinValue = double.parse(_valueToString(value.end));
                      widget.minCallback(
                          double.parse(_valueToString(value.start)));
                      widget
                          .maxCallback(double.parse(_valueToString(value.end)));
                      _values = value;
                    });
                  })),
        )
      ],
    )*/
        ;
  }
}
