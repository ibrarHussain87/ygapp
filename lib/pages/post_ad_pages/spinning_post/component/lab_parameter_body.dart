import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';

class LabParameterPage extends StatefulWidget {
  const LabParameterPage({Key? key}) : super(key: key);

  @override
  _LabParameterPageState createState() => _LabParameterPageState();
}

class _LabParameterPageState extends State<LabParameterPage> {

  List<String> listItems = ['Open End','Ring Spun','Vortex','Autocoro'];
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.w,left: 16.w,right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter actual yarn count";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('Actual yarn count')),
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter CLSP*";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('CLSP*')),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.w,left: 16.w,right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter U%";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('U% (Uniformity)')),
                    ),
                  ),
                  SizedBox(width: 16.w,),

                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter CV%";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('CV%')),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 8.w,left: 16.w,right: 16.w),
                child: GridTileWidget(spanCount: 2, callback: (value){}, listOfItems: listItems)),
            Padding(
              padding: EdgeInsets.only(top: 8.w,left: 16.w,right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter actual thin places";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('Thin Places')),
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please thick places";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('Thick Places')),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.w,left: 16.w,right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter Naps";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('Naps')),
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter IPM/KM*";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('IPM/KM*')),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.w,left: 16.w,right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter H% (Hairness)";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('H% (Hairness)')),
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter RKM";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('RKM')),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.w,left: 16.w,right: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter Elongation %";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('Elongation %')),
                    ),
                  ),
                  SizedBox(width: 16.w,),
                  Expanded(
                    child: SizedBox(
                      height: 36.w,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          // onSaved: (input) =>
                          // userName = input!,
                          validator: (input) {
                            if (input == null || input.isEmpty) {
                              return "Please enter TPI";
                            }
                            return null;
                          },
                          decoration: roundedTextFieldDecoration('TPI')),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.w,left: 16.w,right: 16.w),
              child: SizedBox(
                height: 36.w,
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    // onSaved: (input) =>
                    // userName = input!,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return "Please enter TPI";
                      }
                      return null;
                    },
                    decoration: roundedTextFieldDecoration('TPI')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
