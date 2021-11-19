import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/grid_tile_widget.dart';

class SpecificationComponent extends StatefulWidget {

  Function? callback;
  SpecificationComponent({Key? key, this.callback}) : super(key: key);

  @override
  _SpecificationComponentState createState() => _SpecificationComponentState();
}

class _SpecificationComponentState extends State<SpecificationComponent> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  List<String> listItems = ['Woven', 'Knitted'];
  List<String> listItems3 = ['Woven', 'Knitted', 'Woven', 'Ibrar', 'Ibrar'];
  List<String> listItems4 = [
    'Woven',
    'Knitted',
    'Woven',
    'Knitted',
    'Woven',
    'Knitted',
    'Woven',
    'Knitted'
  ];

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
              'Select your accurate specifications',
              style: TextStyle(
                  fontSize: 11.sp, color: AppColors.textColorGreyLight),
            ),
            Form(
                key: widget.key,
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
                                height: 36.w,
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
                              preferredSize: Size(double.maxFinite, 36.w),
                              child: SizedBox(
                                height: 36.w,
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
                                    contentPadding: EdgeInsets.only(
                                        left: 16.w,
                                        right: 5.w,
                                        top: 0,
                                        bottom: 0),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.lightBlueTabs),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24.w),
                                        )),
                                  ),
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      color: AppColors.textColorGrey),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: GridTileWidget(
                        spanCount: 2,
                        listOfItems: listItems,
                        callback: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: GridTileWidget(
                        spanCount: 2,
                        listOfItems: listItems,
                        callback: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: GridTileWidget(
                        spanCount: 2,
                        listOfItems: listItems,
                        callback: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: GridTileWidget(
                        spanCount: 4,
                        listOfItems: listItems4,
                        callback: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: GridTileWidget(
                        spanCount: 2,
                        listOfItems: listItems,
                        callback: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: GridTileWidget(
                        spanCount: 2,
                        listOfItems: listItems,
                        callback: (value) {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: GridTileWidget(
                        spanCount: 4,
                        listOfItems: listItems3,
                        callback: (value) {},
                      ),
                    ),
                  ],
                )),

            ElevatedButton(
                child: Text(
                    "Next".toUpperCase(),
                    style: TextStyle(fontSize: 14.sp)
                ),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(AppColors.btnColorLogin),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(color: Colors.transparent)
                        )
                    )
                ),
                onPressed: (){
                  // if(validateAndSave()){
                    widget.callback!(true);
                  // }else{
                  //   widget.callback!(false);
                  // }
                }
            ),
          ],
        ),
      ),
    );
  }

  // bool validateAndSave() {
  //   final form = globalFormKey.currentState;
  //   if (form!.validate()) {
  //     form.save();
  //     return true;
  //   }
  //   return false;
  // }

}