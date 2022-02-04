
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_widgets/list_detail_item_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/spec_user_response.dart';

import '../detail_tab.dart';

class SpecUserView extends StatefulWidget {

  final SpecificationUser specificationUser;


  const SpecUserView({Key? key,required this.specificationUser}) : super(key: key);

  @override
  _SpecUserViewState createState() => _SpecUserViewState();
}

class _SpecUserViewState extends State<SpecUserView> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.w,
                ),
                TitleTextWidget(
                  title: "User details".toUpperCase(),
                  color: titleColor,
                ),
                SizedBox(
                  height: 12.w,
                ),
                ListView.separated(
                  itemCount: generateUserList(widget.specificationUser).length,
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        if(index==1){
                          _launchCaller(generateUserList(widget.specificationUser)[index].detail);
                        }else if(index==2){
                          launchEmailSubmission(generateUserList(widget.specificationUser)[index].detail);
                        }
                      },
                      child: listDetailItemWidget(
                          context, generateUserList(widget.specificationUser)[index]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButtonWithoutIcon(
                    callback: () {

                    },
                    color: btnColorLogin,
                    btnText: 'Service through YG'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: ElevatedButtonWithoutIcon(
                    callback: () {

                    },
                    color: btnColorLogin,
                    btnText: 'Post as requirement'),
              ),
            ],
          ),
        )
      ],
    );
  }

  _launchCaller(String phone) async {
    String url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchEmailSubmission(String email) async {
    final Uri params = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          'subject': '',
          'body': ''
        }
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  List<GridTileModel> generateUserList(SpecificationUser specificationUser) {
    List<GridTileModel> tempList = [];
    tempList.add(GridTileModel('Name', specificationUser.name??Utils.checkNullString(false)));
    /*Index 1 must contain phone for launchCaller to work*/
    tempList.add(GridTileModel('Phone', specificationUser.phone??Utils.checkNullString(false)));
    /*Index 2 must contain email for launchEmailSubmission to work*/
    tempList.add(GridTileModel('Email', specificationUser.email??Utils.checkNullString(false)));
    tempList.add(GridTileModel('Country', specificationUser.country??Utils.checkNullString(false)));
    tempList.add(GridTileModel('City', specificationUser.cityState??Utils.checkNullString(false)));
    tempList.add(GridTileModel('Company', specificationUser.company??Utils.checkNullString(false)));
    tempList.add(GridTileModel('NTN Number', specificationUser.ntnNumber??Utils.checkNullString(false)));
    return tempList;
  }
}

