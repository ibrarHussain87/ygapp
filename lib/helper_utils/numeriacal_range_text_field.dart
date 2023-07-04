import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue(
              selection: TextSelection.collapsed(
                  offset: min.toStringAsFixed(2).length))
          .copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max
          ? TextEditingValue(
                  selection: TextSelection.collapsed(
                      offset: max.toStringAsFixed(2).length))
              .copyWith(text: max.toStringAsFixed(2))
          : newValue;
    }
  }
}

class NumericalRangeFormatterMin extends TextInputFormatter {

  final double min;

  NumericalRangeFormatterMin({required this.min});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    if (newValue.text == '') {
      return const TextEditingValue();
    } else if (int.parse(newValue.text) < min) {
      return TextEditingValue(
          selection: TextSelection.collapsed(
              offset: min.toStringAsFixed(2).length))
          .copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > min
          ? TextEditingValue(
          selection: TextSelection.collapsed(
              offset: min.toStringAsFixed(2).length))
          .copyWith(text: min.toStringAsFixed(2))
          : newValue;
    }
  }
}


class NumericalRangeFormatterMax extends TextInputFormatter {
  final double max;

  NumericalRangeFormatterMax({required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return const TextEditingValue();
    } else {
      return int.parse(newValue.text) > max
          ? TextEditingValue(
          selection: TextSelection.collapsed(
              offset: max.toStringAsFixed(2).length))
          .copyWith(text: max.toStringAsFixed(2))
          : newValue;
    }
  }
}
