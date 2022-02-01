import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/list_bidder_response.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';

import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/title_text_widget.dart';

class MatchedPageBody extends StatefulWidget {
  final ListBiddersData listBiddersData;

  const MatchedPageBody({Key? key, required this.listBiddersData})
      : super(key: key);

  @override
  _MatchedPageBodyState createState() => _MatchedPageBodyState();
}

class _MatchedPageBodyState extends State<MatchedPageBody> {
  String? _changeColor;

  @override
  void initState() {
    setState(() {
      _changeColor = widget.listBiddersData.isAccepted;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.w, top: 8.w),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(6.w),
        color: Colors.grey.shade200,
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                postAdGreyIcon,
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTextWidget(
                        title: widget.listBiddersData.userName ?? ""),
                    BrandWidget(title: widget.listBiddersData.date ?? Utils.checkNullString(false))
                  ],
                ),
                flex: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TitleTextWidget(title: widget.listBiddersData.price ?? ""),
                  SizedBox(
                    height: 4.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (_changeColor == "0") {
                            _changeBidApi(widget.listBiddersData.bidId, 2);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: _changeColor == "0"
                                  ? redClr
                                  : redClr.withOpacity(0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 3.w, bottom: 3.w, left: 12.w, right: 12.w),
                            child: Center(
                              child: Text(
                                'Reject',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (_changeColor == '0') {
                            _changeBidApi(widget.listBiddersData.bidId, 1);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: _changeColor == "0"
                                  ? btnGreen
                                  : greenClr.withOpacity(0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 3.w, bottom: 3.w, left: 12.w, right: 12.w),
                            child: Center(
                              child: Text(
                                'Accept',
                                style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _changeBidApi(bidId, status) {
    ProgressDialogUtil.showDialog(context, "Please wait...");
    ApiService.bidChangeStatus(bidId, status).then((value) {
      ProgressDialogUtil.hideDialog();
      if (value.status) {
        setState(() {
          _changeColor = "1";
        });
      }

      Ui.showSnackBar(context, value.message);
    }, onError: (error, stackTrac) {
      ProgressDialogUtil.hideDialog();
      Ui.showSnackBar(context, error.toString());
    });
  }
}
