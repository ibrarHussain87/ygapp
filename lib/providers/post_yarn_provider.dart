import 'package:flutter/material.dart';

import '../model/response/yarn_response/sync/yarn_sync_response.dart';

class PostYarnProvider extends ChangeNotifier{

  List<dynamic> selectedBlends = [];
  List<TextEditingController> textFieldControllers = [];


  late bool _isBlendSelected;
  bool get isBlendSelected => _isBlendSelected;
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
}