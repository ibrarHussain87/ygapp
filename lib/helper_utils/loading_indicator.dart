import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  final String? text;
  LoadingIndicator({this.text});


  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context,text),
              // _getText(displayedText!)
            ]
        )
    );
  }
}

Padding _getLoadingIndicator() {
  return const Padding(
      child: SizedBox(
          child: SpinKitWave(
            color: Colors.green,
            size: 24.0,
          ),
      ),
      padding: EdgeInsets.only(bottom: 16)
  );
}
//
Widget _getHeading(context,String? text) {
  return
     Padding(
        child: Text(
          text??"",
          style: TextStyle(
              color: btnColorLogin,
              fontSize: 12
          ),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4)
    );
}

// Text _getText(String displayedText) {
//   return Text(
//     displayedText,
//     style: const TextStyle(
//         color: Colors.white,
//         fontSize: 14
//     ),
//     textAlign: TextAlign.center,
//   );
// }