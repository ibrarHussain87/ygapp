import 'package:flutter/material.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';

import '../../../elements/offering_requirment_bottom_sheet.dart';

class FabricPage extends StatefulWidget {

  final String? locality;

  const FabricPage({Key? key,required this.locality}) : super(key: key);

  @override
  FabricPageState createState() => FabricPageState();
}

class FabricPageState extends State<FabricPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheetOR(context, (value) {
              openFabricPostPage(context, widget.locality, "Fabric", value);
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
          heroTag: null,
        ),
        body: const Center(
          child: TitleTextWidget(
            title: "Fabric Page",
          ),
        ),
      ),
    );
  }
}
