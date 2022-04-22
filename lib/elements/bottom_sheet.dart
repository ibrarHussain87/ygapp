import 'package:flutter/material.dart';

class CustomSheet extends StatefulWidget {
  const CustomSheet({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _CustomSheetState createState() => _CustomSheetState();


}


class _CustomSheetState extends State<CustomSheet> {


//  final Widget child=widget.child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.only(topLeft:Radius.circular(16.0),topRight: Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.child != null)
            widget.child
        ],
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    final theme = Theme.of(context);

    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        child: Container(
          height: 5.0,
          decoration: BoxDecoration(
            color: theme.dividerColor,
            borderRadius: const BorderRadius.all(Radius.circular(2.5)),
          ),
        ),
      ),
    );
  }
}