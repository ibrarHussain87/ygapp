import 'package:flutter/material.dart';

class PostYarnProvider extends ChangeNotifier{

  List<dynamic> title = [];

  void setSelectedBlend(value){
    title.add(value);
    notifyListeners();
  }

  void removeSelectedBlend(value){
    title.remove(value);
    notifyListeners();
  }
}