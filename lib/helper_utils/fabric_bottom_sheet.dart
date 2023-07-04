
import 'package:flutter/material.dart';

class NatureFabricSheet extends StatefulWidget {
  const NatureFabricSheet({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _NatureFabricSheetState createState() => _NatureFabricSheetState();


}

// Nature Fabric Bottom Sheet (asad_m)
class _NatureFabricSheetState extends State<NatureFabricSheet> {


//  final Widget child=widget.child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRect(
      child: Container(
        height: MediaQuery.of(context).size.height*0.8,
        padding: const EdgeInsets.only(left: 12,right: 12,top: 4),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: const BorderRadius.only(topLeft:Radius.circular(16.0),topRight: Radius.circular(16.0)),
        ),
        child:widget.child,
//      Column(
//        mainAxisSize: MainAxisSize.min,
//        children: [
//          if (widget.child != null)
//            widget.child
//        ],
//      ),
      ),
    );
  }

}