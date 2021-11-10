import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_dialog/stylish_dialog.dart';

class ProgressDialogUtil {
  static StylishDialog? _stylishDialog;

  static showDialog(BuildContext context, String value) {

    _stylishDialog = StylishDialog(
      context: context,
      alertType: StylishDialogType.PROGRESS,
      contentText: value,
    );

    _stylishDialog!.show();
  }

  static hideDialog() {
    if(_stylishDialog!=null){
      _stylishDialog!.dismiss();
    }
  }
}
