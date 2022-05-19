import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/decimal_text_input_formatter.dart';
import 'package:yg_app/helper_utils/util.dart';

import 'decoration_widgets.dart';

class YgTextFormFieldWithRange extends StatelessWidget {
  final String errorText;
  final String minMax;
  final String label;
  final int? maxLength;
  final Function onSaved;
  // final Function onChanged;
  final bool? validation;
  final bool? mandatoryField;

  const YgTextFormFieldWithRange(
      {Key? key,
      required this.errorText,
      required this.minMax,
      required this.label,
      required this.onSaved,
      // required this.onChanged,
      this.validation,
      this.maxLength,
      this.mandatoryField,
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
        maxLength: maxLength,
        onSaved: (input) => onSaved(input),
        // onChanged: (input) => onChanged(input),
        inputFormatters: [
          DecimalTextInputFormatter(decimalRange: 2),
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        validator: MultiValidator([
          RangeValidator(
              min: Utils.splitMin(minMax),
              max: Utils.splitMax(minMax),
              errorText: "Range $minMax"),
          RequiredValidator(errorText: errorText),
        ]),
        decoration: ygTextFieldDecoration(minMax,label,mandatoryField??true));
//        decoration: roundedTextFieldDecoration(minMax));
  }
}

class YgTextFormFieldWithRangeNonDecimal extends StatelessWidget {

  final String errorText;
  final String minMax;
  final String label;
  final int? maxLength;
  final bool? autoFocus;
  final Function onSaved;
  // final Function onChanged;
  final bool? validation;
  final String? value;
  final bool? mandatoryField;


  const YgTextFormFieldWithRangeNonDecimal(
      {Key? key,
        required this.errorText,
        required this.minMax,
        required this.label,
        required this.onSaved,
        // required this.onChanged,
        this.validation,
        this.value,
        this.mandatoryField,
        this.maxLength,
        this.autoFocus,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: value ?? '',
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        cursorColor: lightBlueTabs,
        style: TextStyle(fontSize: 11.sp),
        textAlign: TextAlign.center,
        cursorHeight: 16.w,
        maxLength: maxLength,
        autofocus: autoFocus??false,
        onSaved: (input) => onSaved(input),
        // onChanged: (input) => onChanged(input),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
          // DecimalTextInputFormatter(decimalRange: 2),
          // FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        validator: MultiValidator([
          RangeValidator(
              min: Utils.splitMin(minMax),
              max: Utils.splitMax(minMax),
              errorText: "Range $minMax"),
          RequiredValidator(errorText: errorText),
        ]),
        decoration: ygTextFieldDecoration(minMax,label,mandatoryField??true));
  }
}

class YgTextFormFieldWithoutRange extends StatelessWidget {
  final String errorText;
  final Function onSaved;
  final String label;
  final bool? mandatoryField;
  final String? value;

  const YgTextFormFieldWithoutRange(
      {Key? key, required this.errorText, required this.onSaved,
        required this.label,this.value,this.mandatoryField
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: value ?? '',
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
        decoration: ygTextFieldDecoration(errorText,label,mandatoryField??true));
  }
}

class YgTextFormFieldWithRangeNoValidation extends StatelessWidget {
  final String errorText;
  final String minMax;
  final String label;
  final bool? mandatoryField;
  final Function onSaved;

  const YgTextFormFieldWithRangeNoValidation(
      {Key? key,
      required this.errorText,
      required this.minMax,
      required this.label,
      required this.onSaved,
        this.mandatoryField,
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
            min: Utils.splitMin(minMax),
            max: Utils.splitMax(minMax),
            errorText: "Range $minMax"),
        decoration: ygTextFieldDecoration(minMax,label,mandatoryField??true));
  }
}
