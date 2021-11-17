import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';

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
      width: 64.w,
      height: 16.w,
    );
  }
}
