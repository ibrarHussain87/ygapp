
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/pages/profile/update_profile/membership_card.dart';

import '../../../api_services/api_service_class.dart';
import '../../../elements/custom_header.dart';
import '../../../helper_utils/connection_status_singleton.dart';
import '../../../helper_utils/progress_dialog_util.dart';
import '../../../model/pre_login_response.dart';
import '../../../model/request/update_profile/update_membership_plan_request.dart';


class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  @override
  _MembershipPageState createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageValue = 0;
  int previousPageValue = 0;
  int currentImageBanner = 1;
  PageController? controller;
  MembershipRequestModel? _membershipRequestModel;
  List<SubscriptionPlans> subList=[];

  String? name;
  @override
  void initState() {
    super.initState();
    _membershipRequestModel=MembershipRequestModel();
    AppDbInstance().getDbInstance().then((value) => {
      value.subscriptionPlansDao.findAllSubscriptionPlans().then((value) {
        setState(() {
          subList = value;
          if(subList.isNotEmpty)
            {
              name=subList[currentImageBanner].spName;
        }
        });
        })



    });
    controller=PageController(initialPage: currentPageValue);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
//    final List<Widget> introWidgetsList = <Widget>[
//      buildFreeMembershipWidget(context,0),
//      buildSuperMembershipWidget(context,1),
//      buildPremiumMembershipWidget(context,2)
//      ];
    return SafeArea(
      child: Scaffold(
        appBar:appBar(context,"Membership"),

        key: scaffoldKey,
        backgroundColor: Colors.grey.shade200,
        body:SizedBox(
          width:width,
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height/15,),
              Text("Choose Your Plan",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 22.0.w,
                  color: headingColor,
                  fontWeight: FontWeight.w700)),
              SizedBox(height: height/25,),


              GFCarousel(
                height: height/1.55,
                reverse: false,
                hasPagination: false,
                initialPage: 1,
                enlargeMainPage: true,
                enableInfiniteScroll: true,
                activeIndicator: btnTextColor,
                passiveIndicator: textColorGreyLight,
                items:subList.map((i) {
                 return Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: buildFreeMembershipWidget(
                          context, currentImageBanner,i,name,(SubscriptionPlans value) {
                            _membershipRequestModel?.spId=value.spId.toString();
                      _subscribeToPlan(context);
                      }),
                    ),
                  );

//                  Container(
//                  width: MediaQuery.of(context).size.width,
//                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                  child: ClipRRect(
//                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                  child: buildSuperMembershipWidget(context,currentImageBanner),
//                  ),
//                  ),
//
//                  Container(
//                  width: MediaQuery.of(context).size.width,
//                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                  child: ClipRRect(
//                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                  child: buildPremiumMembershipWidget(context,currentImageBanner)
//                  ,
//                  )
//                  ,
//                  )

                }).toList(),
                onPageChanged: (index) {
                  setState(() {
                    currentImageBanner=index;
                    name=subList[currentImageBanner].spName;
                  });
                },
              ),
              Container(
                padding: EdgeInsets.only(top: 15.w),
                child: DotsIndicator(
                  dotsCount: subList.length,
                  position: double.tryParse(currentImageBanner.toString())!,
                  decorator: DotsDecorator(
                    activeColor: btnTextColor,
                    shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    size: Size.fromRadius(4.w),
                    spacing: const EdgeInsets.all(4.0),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }



  void _subscribeToPlan(BuildContext context) {

    check().then((value) {
      if (value) {
        ProgressDialogUtil.showDialog(context, 'Please wait...');

        Logger().e(_membershipRequestModel?.toJson());
        ApiService().subscribeToPlan(_membershipRequestModel!).then((value) {

          ProgressDialogUtil.hideDialog();
//            if (value.errors != null) {
//              value.errors!.forEach((key, error) {
//                ScaffoldMessenger.of(context)
//                    .showSnackBar(SnackBar(content: Text(error.toString())));
//              });
//            } else
          if (value.status!) {
//              AppDbInstance().getDbInstance().then((db) async {
////                await db.userDao.insertUser(value.data!.user!);
//                await db.userDao.insertUser(value.data!);
//              });


            Fluttertoast.showToast(
                msg: value.message ?? "",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
            Navigator.of(context).pop();
          } else {

            ProgressDialogUtil.hideDialog();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.message ?? "")));
          }
        }).onError((error, stackTrace) {
          ProgressDialogUtil.hideDialog();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        });
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No internet available.".toString())));
      }
    });

  }

}
