import 'package:flutter/cupertino.dart';

class PastAdPage extends StatefulWidget {
  const PastAdPage({Key? key}) : super(key: key);

  @override
  _PastAdPageState createState() => _PastAdPageState();
}

class _PastAdPageState extends State<PastAdPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Text("Past Ad Page"),
      ),
    );
  }
}
