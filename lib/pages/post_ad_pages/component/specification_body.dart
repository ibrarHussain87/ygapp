import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';

class SpecificationComponent extends StatefulWidget {
  SpecificationComponent({Key? key}) : super(key: key);

  @override
  _SpecificationComponentState createState() => _SpecificationComponentState();
}

class _SpecificationComponentState extends State<SpecificationComponent> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> items = [
    {
      'value': 'boxValue',
      'label': 'Box Label',
      'icon': Icon(Icons.stop),
    },
    {
      'value': 'circleValue',
      'label': 'Circle Label',
      'icon': Icon(Icons.fiber_manual_record),
      'textStyle': TextStyle(color: Colors.red),
    },
    {
      'value': 'starValue',
      'label': 'Star Label',
      'enable': false,
      'icon': Icon(Icons.grade),
    },
  ];
  String? _selectedItem = AppStrings.plyStringList[0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Specifications',
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              'Select your acurate specifications',
              style: TextStyle(
                  fontSize: 11.sp, color: AppColors.textColorGreyLight),
            ),
            Form(
                key: globalFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.w),
                              child: SizedBox(
                                height: 32.w,
                                child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.black,
                                    // onSaved: (input) =>
                                    // userName = input!,
                                    validator: (input) {
                                      if (input == null || input.isEmpty) {
                                        return "Please enter count";
                                      }
                                      return null;
                                    },
                                    decoration:
                                        roundedTextFieldDecoration('Count')),
                              ),
                            ),
                          ),
                          Expanded(
                            child: PreferredSize(
                              preferredSize:Size(double.maxFinite,32.w),
                              child: DropdownButtonFormField(
                                items: AppStrings.plyStringList
                                    .map((value) => DropdownMenuItem(
                                          child: Text(value),
                                          value: value,
                                        ))
                                    .toList(),
                                onChanged: (String? value) {},
                                value: AppStrings.plyStringList.first,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left:16.w,right:5.w,top: 0,bottom: 0),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(24.w))),
                                ),
                                style: TextStyle(fontSize: 11.sp,color: AppColors.textColorGrey),

                              ),
                            )
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
