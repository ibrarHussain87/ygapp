import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yg_app/pages/post_ad_pages/spinning_post_ad.dart';
import 'package:yg_app/utils/colors.dart';

class SpinningPage extends StatefulWidget {
  const SpinningPage({Key? key}) : super(key: key);

  @override
  _SpinningPageState createState() => _SpinningPageState();
}

class _SpinningPageState extends State<SpinningPage> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          if(isDialOpen.value){
            isDialOpen.value = false;
            return false;
          }else{
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            openCloseDial: isDialOpen,
            backgroundColor: AppColors.btnColorLogin,
            overlayColor: Colors.grey,
            overlayOpacity: 0.5,
            spacing: 3.w,
            spaceBetweenChildren: 3.w,
            closeManually: true,
            children: [
              SpeedDialChild(
                  label: 'Requirement',
                  backgroundColor: Colors.blue,
                  onTap: (){
                    setState(() {
                      isDialOpen.value = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpinningPostAdPage(businessArea:"Spinning",selectedTab:"requirement"),
                      ),
                    );
                  }
              ),
              SpeedDialChild(
                  label: 'Offering',
                  onTap: (){
                    setState(() {
                      isDialOpen.value = false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpinningPostAdPage(businessArea:"Spinning",selectedTab:"Offering"),
                      ),
                    );
                  }
              ),
            ],
          ),
          body: Container(
          ),
        ),
      ),
    );
  }

}
