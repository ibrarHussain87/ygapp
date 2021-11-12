import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

class NetworkImageIconWidget extends StatefulWidget {

  String? imageUrl;

  NetworkImageIconWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _NetworkImageIconWidgetState createState() => _NetworkImageIconWidgetState();
}

class _NetworkImageIconWidgetState extends State<NetworkImageIconWidget> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl!,
      placeholder: (context, url) =>  CircularProgressIndicator(strokeWidth: 1.0,color: AppColors.lightBlueTabs,),
      errorWidget: (context, url, error) =>  Icon(Icons.error),
      height: 24.h,
      width: 24.w,
    );
  }
}
