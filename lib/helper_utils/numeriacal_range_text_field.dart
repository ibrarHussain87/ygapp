import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < min) {
      return TextEditingValue(text: min.toString());
    } else if (value > max) {
      return TextEditingValue(text: max.toString());
    }
    return newValue;
  }
}


// class NumericalRangeFormatterMin extends TextInputFormatter {
//   final double min;
//
//   NumericalRangeFormatterMin({required this.min});
//
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue,
//       ) {
//
//     if (newValue.text == '') {
//       return newValue;
//     } else if (int.parse(newValue.text) < min) {
//       return const TextEditingValue().copyWith(text: min.toStringAsFixed(2));
//     } else {
//       return int.parse(newValue.text) > min ? oldValue : newValue;
//     }
//   }
// }
//
class NumericalRangeFormatterMax extends TextInputFormatter {
  final double max;

  NumericalRangeFormatterMax({required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    if (newValue.text == '') {
      return newValue;
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}