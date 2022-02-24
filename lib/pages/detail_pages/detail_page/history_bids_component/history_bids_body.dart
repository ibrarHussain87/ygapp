import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/list_bid_response.dart';

import '../../../../elements/title_text_widget.dart';
import 'package:intl/intl.dart';


class HistoryOfBidsBody extends StatefulWidget {

  final BidData bidData;

  const HistoryOfBidsBody({Key? key,required this.bidData}) : super(key: key);

  @override
  _HistoryOfBidsBodyState createState() => _HistoryOfBidsBodyState();
}

class _HistoryOfBidsBodyState extends State<HistoryOfBidsBody> {
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleMediumBoldSmallTextWidget(title: "Quantity"),
                        SizedBox(height: 2.h,),
                        TitleExtraSmallTextWidget(title: widget.bidData.quantity,),
                        SizedBox(height: 4.h,)
                      ],
                    ),
                    TitleMediumBoldSmallTextWidget(title: DateFormat("MMM dd, yyyy HH:mm:s").format(DateTime.parse(widget.bidData.date??"")))
                  ],
                ),
                flex: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TitleTextWidget(title: widget.bidData.price ?? ""),
                  SizedBox(
                    height: 4.w,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Visibility(
                      visible: true,
                      maintainSize: true,
                      maintainState: true,
                      maintainAnimation: true,
                      child: Container(
                          width: 34.w,
                          padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.w),
                          decoration: BoxDecoration(
                              color: widget.bidData.status == "0" ? Colors.brown
                                  .shade100.withOpacity(0.4) : widget.bidData.status == "1" ? Colors.green
                                  .shade100 : Colors.red.shade100,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(0.w),
                              )),
                          child: Text(
                            _showStatus(int.parse(widget.bidData.status!)),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: widget.bidData.status == "0" ? Colors.
                              brown : widget.bidData.status == "1" ? Colors.green : Colors.red,
                              fontSize: 6.sp,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

String _showStatus(int bidStatus) {
  if (bidStatus == 0) {
    return "Pending";
  } else if (bidStatus == 1) {
    return "Accepted";
  } else {
    return "Rejected";
  }
}
