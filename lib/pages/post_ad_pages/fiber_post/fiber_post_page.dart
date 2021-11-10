import 'package:flutter/material.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class FiberPostPage extends StatefulWidget {

  final String? businessArea;
  final String? selectedTab;

  const FiberPostPage({Key? key,required this.businessArea,this.selectedTab}) : super(key: key);

  @override
  _FiberPostPageState createState() => _FiberPostPageState();
}

class _FiberPostPageState extends State<FiberPostPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TileTextWidget(title: 'Fiber Material',),
            ],
          ),
        ),
      ),
    );
  }
}
