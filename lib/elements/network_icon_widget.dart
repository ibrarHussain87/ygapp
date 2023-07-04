import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/helper_utils/app_colors.dart';

class NetworkImageIconWidget extends StatefulWidget {

  final String? imageUrl;

  const NetworkImageIconWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _NetworkImageIconWidgetState createState() => _NetworkImageIconWidgetState();
}

class _NetworkImageIconWidgetState extends State<NetworkImageIconWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl!,
      placeholder: (context, url) =>  CircularProgressIndicator(strokeWidth: 1.0,color: lightBlueTabs,),
      errorWidget: (context, url, error) =>  const Icon(Icons.error),
      height: 24.h,
      width: 24.w,
    );
  }
}
