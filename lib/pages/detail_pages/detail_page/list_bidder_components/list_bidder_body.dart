import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/list_bidder_response.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';

import 'package:yg_app/elements/list_widgets/brand_text.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

import '../../../../helper_utils/navigation_utils.dart';


class ListBidderBody extends StatefulWidget {
  final BidData listBiddersData;

  const ListBidderBody({Key? key, required this.listBiddersData})
      : super(key: key);

  @override
  _ListBidderBodyState createState() => _ListBidderBodyState();
}

class _ListBidderBodyState extends State<ListBidderBody> {
  String? _changeColor;
  String? _bidStatus;

  @override
  void initState() {
    setState(() {
      Logger().e(widget.listBiddersData.bidId);
      _changeColor = widget.listBiddersData.status;
      _bidStatus = widget.listBiddersData.status;
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
        child: Container(
          decoration: BoxDecoration(
              color: Utils.getBackgroundColor(_bidStatus!),
              borderRadius: const BorderRadius.all(Radius.circular(6))
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(
                //   postAdGreyIcon,
                //   width: 24.w,
                //   height: 24.w,
                // ),
                // SizedBox(
                //   width: 8.w,
                // ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleTextWidget(
                          title: widget.listBiddersData.userName ?? ""),
                      SizedBox(
                        height: 4.w,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BrandWidget(title: "Quantity:"),
                          SizedBox(width: 2.w,),
                          CustomBrandWidget(title: widget.listBiddersData.quantity,),
                          SizedBox(width: 4.w,),
                        ],
                      ),
                      SizedBox(height: 4.h,),
                      BrandWidget(title: DateFormat("MMM dd, yyyy HH:mm:s").format(DateTime.parse(widget.listBiddersData.date??"")))
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
                      height: 8.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: _bidStatus != '2',
                          child: GestureDetector(
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
                                    top: 5.w, bottom: 5.w, left: 16.w, right: 16.w),
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
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Visibility(
                          visible: _bidStatus != '1',
                          child: GestureDetector(
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
                                    top: 5.w, bottom: 5.w, left: 16.w, right: 16.w),
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
                        ),
                        Visibility(
                          visible: _bidStatus == '1',
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if(widget.listBiddersData.specification is Specification){
                                var specification = widget.listBiddersData.specification as Specification;
                                openSpecificationUserScreen(
                                    context,
                                    specification.spcId.toString(),
                                    specification.categoryId.toString());
                              }else if(widget.listBiddersData.specification is YarnSpecification){
                                var yarnSpecification = widget.listBiddersData.specification as YarnSpecification;
                                openSpecificationUserScreen(
                                    context,
                                    yarnSpecification.ysId.toString(),
                                    /*yarnSpecification.category_id.toString()*/
                                    '2');
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: darkBlueBidderColor,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.w))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 5.w, bottom: 5.w, left: 16.w, right: 16.w),
                                child: Center(
                                  child: Text(
                                    'Contact',
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
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
          _bidStatus = value.data.status;
        });
      }

      Ui.showSnackBar(context, value.message);
    }, onError: (error, stackTrac) {
      ProgressDialogUtil.hideDialog();
      Ui.showSnackBar(context, error.toString());
    });
  }


}
