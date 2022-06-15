import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class CircleImageIconWidget extends StatefulWidget {

  final String? imageUrl;

  const CircleImageIconWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _CircleImageIconWidgetState createState() => _CircleImageIconWidgetState();
}

class _CircleImageIconWidgetState extends State<CircleImageIconWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl!,
        fit: BoxFit.scaleDown,
      placeholder: (context, url) =>  CircularProgressIndicator(strokeWidth: 1.0,color: lightBlueTabs,),
      errorWidget: (context, url, error) =>  const Icon(Icons.error),
    imageBuilder: (context, imageProvider) => Container(
    width: 24.0,
    height: 24.0,
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
    ),
    )
    );
  }
}
