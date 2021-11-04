import 'package:flutter/cupertino.dart';

class InternationalPage extends StatefulWidget {
  const InternationalPage({Key? key}) : super(key: key);

  @override
  _InternationalPageState createState() => _InternationalPageState();
}

class _InternationalPageState extends State<InternationalPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Text("International Page"),
      ),
    );
  }
}
