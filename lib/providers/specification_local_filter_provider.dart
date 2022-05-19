import 'package:flutter/material.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';

class SpecificationLocalFilterProvider extends ChangeNotifier{

  List<Specification>? fiberSpecification;
  List<Specification>? fiberSpecificationFiltered;

  fiberFilterListSearch(value) {
    fiberSpecificationFiltered = fiberSpecification!
        .where((element) =>
    (element.formation!.isNotEmpty? element.formation!.first.blendName.toString().toLowerCase().contains(value) : false ||
        element.origin
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase()) ||
        element.grade.toString().contains(value)))
        .toList();
    notifyUI();

  }


  notifyUI() {
    notifyListeners();
  }
}