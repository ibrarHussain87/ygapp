import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/decimal_text_input_formatter.dart';
import 'package:yg_app/helper_utils/string_util.dart';

import 'decoration_widgets.dart';

class YgTextFormFieldWithRange extends StatelessWidget {
  final String errorText;
  final String minMax;
  final Function onSaved;
  // final Function onChanged;
  final bool? validation;

  const YgTextFormFieldWithRange(
      {Key? key,
      required this.errorText,
      required this.minMax,
      required this.onSaved,
      // required this.onChanged,
      this.validation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        cursorColor: lightBlueTabs,
        style: TextStyle(fontSize: 11.sp),
        textAlign: TextAlign.center,
        cursorHeight: 16.w,
        onSaved: (input) => onSaved(input),
        // onChanged: (input) => onChanged(input),
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 2),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        validator: MultiValidator([
          RangeValidator(
              min: StringUtils.splitMin(minMax),
              max: StringUtils.splitMax(minMax),
              errorText: "Range $minMax"),
          RequiredValidator(errorText: errorText),
        ]),
        decoration: roundedTextFieldDecoration(minMax));
  }
}

class YgTextFormFieldWithRangeNonDecimal extends StatelessWidget {
  final String errorText;
  final String minMax;
  final Function onSaved;
  // final Function onChanged;
  final bool? validation;

  const YgTextFormFieldWithRangeNonDecimal(
      {Key? key,
        required this.errorText,
        required this.minMax,
        required this.onSaved,
        // required this.onChanged,
        this.validation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        cursorColor: lightBlueTabs,
        style: TextStyle(fontSize: 11.sp),
        textAlign: TextAlign.center,
        cursorHeight: 16.w,
        onSaved: (input) => onSaved(input),
        // onChanged: (input) => onChanged(input),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
          // DecimalTextInputFormatter(decimalRange: 2),
          // FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        validator: MultiValidator([
          RangeValidator(
              min: StringUtils.splitMin(minMax),
              max: StringUtils.splitMax(minMax),
              errorText: "Range $minMax"),
          RequiredValidator(errorText: errorText),
        ]),
        decoration: roundedTextFieldDecoration(minMax));
  }
}

class YgTextFormFieldWithoutRange extends StatelessWidget {
  final String errorText;
  final Function onSaved;

  const YgTextFormFieldWithoutRange(
      {Key? key, required this.errorText, required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        cursorColor: lightBlueTabs,
        style: TextStyle(fontSize: 11.sp),
        textAlign: TextAlign.center,
        cursorHeight: 16.w,
        onSaved: (input) => onSaved(input),
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 2),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),

        ],
        validator: MultiValidator([
          RequiredValidator(errorText: errorText),
        ]),
        decoration: roundedTextFieldDecoration(errorText));
  }
}

class YgTextFormFieldWithRangeNoValidation extends StatelessWidget {
  final String errorText;
  final String minMax;
  final Function onSaved;

  const YgTextFormFieldWithRangeNoValidation(
      {Key? key,
      required this.errorText,
      required this.minMax,
      required this.onSaved,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        cursorColor: lightBlueTabs,
        style: TextStyle(fontSize: 11.sp),
        textAlign: TextAlign.center,
        cursorHeight: 16.w,
        onSaved: (input) => onSaved(input),
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 2),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        validator: RangeValidator(
            min: StringUtils.splitMin(minMax),
            max: StringUtils.splitMax(minMax),
            errorText: "Range $minMax"),
        decoration: roundedTextFieldDecoration(minMax));
  }
}
