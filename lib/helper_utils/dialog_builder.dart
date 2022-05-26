import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/loading_indicator.dart';

class DialogBuilder {

  final BuildContext context;
  final String? title;
   DialogBuilder(this.context, {this.title});

  showLoadingDialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              backgroundColor: Colors.white,
              content:LoadingIndicator(text: title??"",),
            )
        );
      },
    );
  }

  hideDialog(){
    Navigator.of(context).pop();
  }

}

void showGenericDialog(
    String title,
    String content,
    BuildContext context,
    StylishDialogType dialogType,
    String positiveButtonText,
    Function callback) {
  StylishDialog(
    context: context,
    alertType: dialogType,
    /*titleText: title,*/
    contentText: content,
    dismissOnTouchOutside: false,
    confirmButton: Visibility(
      /*Show action button only when warning type*/
      visible: dialogType == StylishDialogType.WARNING,
      child: ElevatedButtonWithoutIcon(
        btnText: positiveButtonText,
        color: Colors.green,
        callback: () {
          Navigator.pop(context);
          callback();
        },
      ),
    ),
    cancelButton: GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const TitleTextWidget(
        title: "Close",
        color: Colors.green,
      ),
    ),
  ).show();
}

void showGenericDialogCancel(
    String title,
    String content,
    BuildContext context,
    StylishDialogType dialogType,
    String positiveButtonText,
    Function callback,
    Function cancelCallback) {
  StylishDialog(
    context: context,
    alertType: dialogType,
    /*titleText: title,*/
    contentText: content,
    dismissOnTouchOutside: false,
    confirmButton: Visibility(
      /*Show action button only when warning type*/
      visible: dialogType == StylishDialogType.WARNING,
      child: ElevatedButtonWithoutIcon(
        btnText: positiveButtonText,
        color: Colors.green,
        callback: () {
          Navigator.pop(context);
          callback();
        },
      ),
    ),
    cancelButton: GestureDetector(
      onTap: () {
        Navigator.pop(context);
        cancelCallback();
      },
      child: const TitleTextWidget(
        title: "Close",
        color: Colors.green,
      ),
    ),
  ).show();
}

void showPostRequirementDialog(String title, String content,
    BuildContext context, String positiveButtonText, Function callback) {
  StylishDialog(
    context: context,
    alertType: StylishDialogType.SUCCESS,
    /*titleText: title,*/
    contentText: content,
    dismissOnTouchOutside: false,
    cancelButton: GestureDetector(
      onTap: () {
        callback();
      },
      child: const TitleTextWidget(
        title: "Close",
        color: Colors.green,
      ),
    ),
  ).show();
}
