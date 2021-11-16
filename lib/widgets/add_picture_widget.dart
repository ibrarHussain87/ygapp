import 'package:flutter/material.dart';

class AddPictureWidget extends StatefulWidget {

  int? pictureCount;
  Function? callbackImageResult;

  AddPictureWidget({Key? key,required this.pictureCount,this.callbackImageResult}) : super(key: key);

  @override
  _AddPictureWidgetState createState() => _AddPictureWidgetState();
}

class _AddPictureWidgetState extends State<AddPictureWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [

        ],
      ),
    );
  }
}
