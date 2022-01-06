import 'package:flutter/cupertino.dart';

class YGServices extends StatefulWidget {
  const YGServices({Key? key}) : super(key: key);

  @override
  _YGServicesState createState() => _YGServicesState();
}

class _YGServicesState extends State<YGServices> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Text("YG Service"),
      ),
    );
  }
}
