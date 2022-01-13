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
      dismissOnTouchOutside: false
    );

    _stylishDialog!.show();
  }

  static hideDialog() {
    if(_stylishDialog!=null){
      _stylishDialog!.dismiss();
    }
  }

  static showDialogAsync(BuildContext context, String value) async{

    _stylishDialog = StylishDialog(
        context: context,
        alertType: StylishDialogType.PROGRESS,
        contentText: value,
        dismissOnTouchOutside: false
    );

    _stylishDialog!.show();
  }

  static hideDialogAsync() async{
    if(_stylishDialog!=null){
      _stylishDialog!.dismiss();
    }
  }
}
