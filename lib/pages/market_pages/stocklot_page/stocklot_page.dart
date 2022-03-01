import 'package:flutter/material.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';

import '../../../elements/offering_requirment_bottom_sheet.dart';

class StockLotPage extends StatefulWidget {

  final String? locality;

  const StockLotPage({Key? key,required this.locality}) : super(key: key);

  @override
  StockLotPageState createState() => StockLotPageState();
}

class StockLotPageState extends State<StockLotPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showBottomSheetOR(context, (value) {
              openStockLotPostPage(context, widget.locality, "StockLot", value);
            });
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
          heroTag: null,
        ),
        body: const Center(
          child: TitleTextWidget(
            title: "StockLotPage",
          ),
        ),
      ),
    );
  }
}
