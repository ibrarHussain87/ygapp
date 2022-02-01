import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/title_text_widget.dart';

void showGenericDialog(
    String title, String content, BuildContext context, StylishDialogType dialogType,String positiveButtonText, Function callback,) {
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
        callback: (){
          Navigator.pop(context);
          callback();
        },
      ),
    ),
    cancelButton: GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: const TitleMediumBoldSmallTextWidget(
        title: "Close",
        color: Colors.green,
      ),
    ),
  ).show();
}