import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_widgets/list_detail_item_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/spec_user_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/pages/dashboard_pages/market_page.dart';

import '../../../../helper_utils/alert_dialog.dart';
import '../../../../helper_utils/ui_utils.dart';
import '../detail_tab.dart';

class SpecUserView extends StatefulWidget {
  final SpecificationUser specificationUser;
  final String specId;
  final String categoryId;

  const SpecUserView(
      {Key? key,
      required this.specificationUser,
      required this.specId,
      required this.categoryId})
      : super(key: key);

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
                        if(index==generateUserList(widget.specificationUser).length-2){
                          /*_launchCaller(generateUserList(widget.specificationUser)[index].detail);*/
                        }else if(index==generateUserList(widget.specificationUser).length-1){
                          launchEmailSubmission(generateUserList(widget.specificationUser)[index].detail);
                        }
                      },
                      child: listItemContactCard(
                          context, generateUserList(widget.specificationUser)[index],index==generateUserList(widget.specificationUser).length-2),
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
                      _markYgApi();
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
                      _postAsRequirement();
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

  /*_launchCaller(String phone) async {
    String url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/

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
    tempList.add(GridTileModel('Country', specificationUser.country??Utils.checkNullString(false)));
    tempList.add(GridTileModel('City', specificationUser.cityState??Utils.checkNullString(false)));
    tempList.add(GridTileModel('Company', specificationUser.company??Utils.checkNullString(false)));
    tempList.add(GridTileModel('NTN Number', specificationUser.ntnNumber??Utils.checkNullString(false)));
    /*Index Second Last must contain phone for launchCaller to work*/
    tempList.add(GridTileModel('Phone', specificationUser.phone??Utils.checkNullString(false)));
    /*Index Last must contain email for launchEmailSubmission to work*/
    tempList.add(GridTileModel('Email', specificationUser.email??Utils.checkNullString(false)));
    return tempList;
  }

  void _markYgApi() {
    showGenericDialog("Alert", "Are you sure for service through Yg", context,
        StylishDialogType.WARNING, "Confirm", () {
      ProgressDialogUtil.showDialog(context, "Please wait...");
      ApiService.markYg(widget.specId, widget.categoryId).then((value) {
        ProgressDialogUtil.hideDialog();
        // Ui.showSnackBar(context, value.message.toString());
        showGenericDialog("Success", value.message.toString(), context,
            StylishDialogType.SUCCESS, "Close", () {});
      }, onError: (error, stackTrac) {
        ProgressDialogUtil.hideDialog();
        Ui.showSnackBar(context, error.toString());
      });
    });
  }

  void _postAsRequirement() {
    showGenericDialog("Alert", "Are you sure post as requirement?", context,
        StylishDialogType.WARNING, "Confirm", () {
      ProgressDialogUtil.showDialog(context, "Please wait...");
      ApiService.copySpecification(widget.specId, widget.categoryId).then(
          (value) {
        ProgressDialogUtil.hideDialog();
        // Ui.showSnackBar(context, value.message.toString());

        showGenericDialog(
            "Success",
            widget.categoryId == "1"
                ? (value as FiberSpecificationResponse).message.toString()
                :widget.categoryId == "2"? (value as GetYarnSpecificationResponse).message.toString() :(value as StockLotSpecificationResponse).message.toString(),
            context,
            StylishDialogType.SUCCESS,
            "Close",
            () {});
      }, onError: (error, stackTrac) {
        ProgressDialogUtil.hideDialog();
        Ui.showSnackBar(context, error.toString());
      });
    });
  }
}
