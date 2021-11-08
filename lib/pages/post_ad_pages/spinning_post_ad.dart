import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:yg_app/model/response/family_data.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/images.dart';
import 'package:yg_app/utils/strings.dart';

class SpinningPostAdPage extends StatefulWidget {
  const SpinningPostAdPage(
      {Key? key, required this.businessArea, required this.selectedTab})
      : super(key: key);
  final String businessArea;
  final String selectedTab;

  @override
  _SpinningPostAdPageState createState() => _SpinningPostAdPageState();
}

class _SpinningPostAdPageState extends State<SpinningPostAdPage> {
  List<dynamic> familyList = <dynamic>[
    FamilyData(AppImages.cottonImage, AppImages.cottonGreyImage, 'Cotton'),
    FamilyData(
        AppImages.syentheticIcon, AppImages.syentheticGreyIcon, 'Syenthatic'),
    FamilyData(AppImages.homeIcon, AppImages.homeGreyIcon, 'Syenthatic'),
    FamilyData(AppImages.postAdIcon, AppImages.postAdGreyIcon, 'Syenthatic'),
    FamilyData(
        AppImages.ygServicesIcon, AppImages.ygServicesGreyIcon, 'Syenthatic')
  ];
  int checkedIndex = 0;
  int checkCardIndex = 0;

  Map<int, Widget> _children = {
    0: Text('Hummingbird'),
    1: Text('Kiwi'),
    2: Text('Rio'),
    3: Text('Telluraves')
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 8.w,
                  left: 24.w,
                  right: 24.w,
                ),
                child: Text(
                  AppStrings.family,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, childAspectRatio: 3 / 2),
                  itemCount: familyList.length,
                  itemBuilder: (context, index) {
                    return buildGrid(index);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w),
                child: Text(
                  AppStrings.blend,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(  left: 8.w, right: 8.w),
                child: SizedBox(
                  height: 32.h,
                  child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return buildCardTile(index);
                    },
                  ),
                ),
              ),
              MaterialSegmentedControl(children: _children)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGrid(int index) {
    bool checked = index == checkedIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          checkedIndex = index;
        });
      },
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Image.asset(
                  checked
                      ? familyList[index].imageUrl
                      : familyList[index].unselectedImage,
                  height: 24.h,
                  width: 24.w,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  familyList[index].familyName,
                  style: TextStyle(
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget buildCardTile(int index) {
    bool checkedCard = index == checkCardIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          checkCardIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(1.0, 1.0), // shadow direction: bottom right
              )
            ],
            gradient: LinearGradient(
                colors: [
                  checkedCard ? const Color(0xFF00CCFF) : Colors.white,
                  checkedCard ? const Color(0xFF3366FF) : Colors.white,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "20/1\nCotton",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 9.sp,
                      color: checkedCard ? Colors.white : AppColors.textColorGrey,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
