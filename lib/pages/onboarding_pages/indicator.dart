import 'package:flutter/material.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class Indicator extends AnimatedWidget {

  final PageController? controller;
   Indicator({Key? key, this.controller}) : super(key: key, listenable: controller!);

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return _createIndicator(index);
              })],
        ),
      ),
    );
  }
  Widget _createIndicator(index) {
    double w=10;
    double h=10;
    Color color=Colors.grey;

    if(controller?.page==index)
    {
      color=appBarColor2;
      h=13;
      w=13;
    }

    return Container(
      height: 26,
      width: 26,
      child: Center(
        child: AnimatedContainer(
          margin: EdgeInsets.all(5),
          color: color,
          width: w,
          height: h,
          duration: Duration(milliseconds: 300),
        ),
      ),
    );
  }
}

