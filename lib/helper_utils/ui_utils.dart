import 'package:flutter/material.dart';

class Ui {

  static bool showHide(String? value){
    if(value == '1'){
      return true;
    }else{
      return false;
    }
  }

  static showSnackBar(BuildContext context,String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

}
