import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/model/response/family_data.dart';

class SpecificationComponent extends StatefulWidget {

  List<FamilyData>? listdata;

  SpecificationComponent({Key? key,required this.listdata}) : super(key: key);

  @override
  _SpecificationComponentState createState() => _SpecificationComponentState();
}

class _SpecificationComponentState extends State<SpecificationComponent> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
