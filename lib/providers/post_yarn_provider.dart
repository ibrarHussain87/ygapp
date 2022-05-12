import 'package:flutter/material.dart';

class PostYarnProvider extends ChangeNotifier{

  List<dynamic> selectedBlends = [];
  List<TextEditingController> textFieldControllers = [];


  bool? _isBlendSelected;
  bool get isBlendSelected => _isBlendSelected??false;
  set isBlendSelected(value){
    _isBlendSelected = value;
    notifyListeners();
  }

  List<Blends> _blendsList = [];
  List<Blends> get blendList => _blendsList;
  set setBlendList(value){
    _blendsList.clear();
    _blendsList = value;
    notifyListeners();
  }
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

  void setBlendRatio(index,ratio){
    _blendsList[index].blendRatio = ratio;
    notifyListeners();
  }

  void resetData(){
    for (var element in _blendsList) {
      element.blendRatio = "";
      element.isSelected = false;
    }
    textFieldControllers.clear();
    selectedBlends.clear();
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