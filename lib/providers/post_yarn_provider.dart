import 'package:flutter/material.dart';

class PostYarnProvider extends ChangeNotifier{

  List<dynamic> selectedBlends = [];
  List<dynamic> yarnFamilyList= [];
  List<dynamic> yarnBlendsList= [];

  set addSelectedBlend(value){
    selectedBlends.add(value);
    notifyListeners();
  }

  set removeSelectedBlend(value){
    selectedBlends.remove(value);
    notifyListeners();
  }

  set addYarnFamily(value)
  {
    yarnFamilyList.add(value);
    notifyListeners();
  }

  set addYarnBlends(value)
  {
    yarnBlendsList.add(value);
    notifyListeners();
  }


}