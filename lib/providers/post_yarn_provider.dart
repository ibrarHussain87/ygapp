import 'package:flutter/material.dart';

class PostYarnProvider extends ChangeNotifier{

  List<dynamic> selectedBlends = [];

  set addSelectedBlend(value){
    selectedBlends.add(value);
    notifyListeners();
  }

  set removeSelectedBlend(value){
    selectedBlends.remove(value);
    notifyListeners();
  }
}