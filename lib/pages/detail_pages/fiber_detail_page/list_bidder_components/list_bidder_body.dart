import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/list_bidder_response.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/progress_dialog_util.dart';
import 'package:yg_app/utils/show_messgae_util.dart';
import 'package:yg_app/widgets/list_widgets/brand_text.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class ListBidderBody extends StatefulWidget {
  final ListBiddersData listBiddersData;

  const ListBidderBody({Key? key, required this.listBiddersData})
      : super(key: key);

  @override
  _ListBidderBodyState createState() => _ListBidderBodyState();
}

class _ListBidderBodyState extends State<ListBidderBody> {
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
                AppImages.postAdGreyIcon,
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
                    BrandWidget(title: widget.listBiddersData.date ?? "N/A")
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
                        onTap: () {
                          if (_changeColor == "0") {
                            _changeBidApi(widget.listBiddersData.bidId, 2);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: _changeColor == "0"
                                  ? AppColors.redClr
                                  : AppColors.redClr.withOpacity(0.3),
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
                        onTap: () {
                          if (_changeColor == '0') {
                            _changeBidApi(widget.listBiddersData.bidId, 1);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: _changeColor == "0"
                                  ? AppColors.btnGreen
                                  : AppColors.greenClr.withOpacity(0.3),
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

      ShowMessageUtils.showSnackBar(context, value.message);
    }, onError: (error, stackTrac) {
      ProgressDialogUtil.hideDialog();
      ShowMessageUtils.showSnackBar(context, error.toString());
    });
  }
}
