import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifiedSupplier extends StatefulWidget {
  const VerifiedSupplier({Key? key}) : super(key: key);

  @override
  _VerifiedSupplierState createState() => _VerifiedSupplierState();
}

class _VerifiedSupplierState extends State<VerifiedSupplier> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/ic_verified_supplier.png',
      width: 12.w,
      height: 12.w,
      fit: BoxFit.fill,
    );
  }
}
