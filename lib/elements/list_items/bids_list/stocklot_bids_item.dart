import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/model/response/list_bid_response.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';

import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/app_images.dart';
import '../../../helper_utils/ui_utils.dart';
import '../../../helper_utils/util.dart';
import '../../elevated_button_without_icon_widget.dart';
import '../../list_widgets/short_detail_renewed_widget.dart';
import '../../text_widgets.dart';

class StockLotBidsItem extends StatelessWidget {
  final BidData bidData;

  const StockLotBidsItem({Key? key, required this.bidData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StockLotSpecification stockLotSpecification =
        bidData.specification as StockLotSpecification;

    return Card(
        color: Colors.white,
        elevation: 18.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.w),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Text(
                            stockLotSpecification.company ??
                                Utils.checkNullString(false),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              
                            ),
                          ),
                          width: MediaQuery.of(context).size.width * 0.30,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.w),
                          child: Visibility(
                              visible:
                                  Ui.showHide(stockLotSpecification.isVerified),
                              maintainSize: true,
                              maintainState: true,
                              maintainAnimation: true,
                              child: Image.asset(
                                'images/ic_verified_supplier.png',
                                width: 8.w,
                                height: 8.w,
                                fit: BoxFit.fill,
                              )),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 3.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.w,
                              ),
                              Row(
                                children: [
                                  Container(
                                      color: blueBackgroundColor,
                                      /*constraints:
                                          const BoxConstraints(maxHeight: 14),*/
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        child: Center(
                                          child: TitleMediumBoldSmallTextWidget(
                                            title: stockLotSpecification
                                                .stocklotParentFamilyName,
                                            color: Colors.white,
                                            textSize: 12,
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  /*Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 1),
                                      child: TitleMediumTextWidget(
                                        title: Utils.setStocklotTitle(StocklotSpecification),
                                        color: Colors.black87,
                                        weight: FontWeight.w600,
                                        size: 13,
                                      ),
                                    ),
                                    flex: 1,
                                  ),*/
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: 6.0.w, top: 8.w),
                                child: TitleSmallBoldTextWidget(
                                  title: Utils.stockLotSubCategoryTitle(
                                      stockLotSpecification),
                                  /*title:'Weaving,Ring Frame,Carded,Regular',*/
                                  color: Colors.black87,
                                  size: 10,
                                  weight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 5.w,
                              ),
                              stockLotSpecification.specDetails!.isNotEmpty
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: Wrap(
                                            spacing: 4.0,
                                            runSpacing: 3.0,
                                            children: [
                                              ShortDetailRenewedWidget(
                                                title: stockLotSpecification
                                                        .priceTerm ??
                                                    Utils.checkNullString(
                                                        false),
                                                imageIcon: IC_BAG_RENEWED,
                                                size: 10.sp,
                                                iconSize: 12,
                                              ),
                                              Visibility(
                                                visible: stockLotSpecification
                                                            .currency_name !=
                                                        null
                                                    ? stockLotSpecification
                                                            .currency_name!
                                                            .isNotEmpty
                                                        ? true
                                                        : false
                                                    : false,
                                                child: ShortDetailRenewedWidget(
                                                  title: stockLotSpecification
                                                          .currency_name ??
                                                      Utils.checkNullString(
                                                          false),
                                                  imageIcon: IC_CONE_RENEWED,
                                                  size: 10.sp,
                                                  iconSize: 12,
                                                ),
                                              ),
                                              ShortDetailRenewedWidget(
                                                title: stockLotSpecification
                                                    .locality,
                                                imageIcon: IC_VAN_RENEWED,
                                                size: 10.sp,
                                                iconSize: 12,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 6.w, right: 6.w, top: 5.h),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      children: priceStockLot(stockLotSpecification),
                                    )),
                                SizedBox(
                                  height: 1.h,
                                ),
                                const Center(
                                  child: TitleSmallNormalTextWidget(
                                    title: "Ex- Factory",
                                    size: 7,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2.w,
                            ),
                            SizedBox(
                              height: 4.w,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'images/ic_list.png',
                                  height: 24.w,
                                  width: 24.h,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Image.asset(
                                  'images/ic_list.png',
                                  height: 24.h,
                                  width: 24.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Image.asset(
                                  'images/ic_list.png',
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.w,
                            ),
                            SizedBox(
                              width: 64.w,
                              height: 24.w,
                              child: ElevatedButtonWithoutIcon(
                                btnText: "Details",
                                textSize: 8.sp,
                                callback: () {
                                  openDetailsScreen(context,
                                      specObj: bidData.specification,
                                      isFromBid: true);
                                },
                                color: Colors.green,
                              ),
                            ),
                            /*SizedBox(
                              height: 8.w,
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 0.w, right: 0.w, top: 0.w, bottom: 0.w),
                  child: Utils.buildContainer(bidData),
                )
              ],
            ),
            Positioned(
              top: 0,
              right: 18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: Ui.showHide(stockLotSpecification.isFeatured),
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: Container(
                        width: 58.w,
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                            color: pintFeatureClr,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(0.w),
                              bottomLeft: Radius.circular(3.w),
                              bottomRight: Radius.circular(3.w),
                            )),
                        child: Text(
                          'Featured'.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 6.sp,
                            
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 0.w, bottom: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                            text: "Updated ",
                            style: TextStyle(
                                fontSize: 5.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: DateFormat("MMM dd, yyyy").format(
                                DateTime.parse(
                                    stockLotSpecification.date ?? "")),
                            style: TextStyle(
                                fontSize: 5.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          )
                        ])),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  priceStockLot(StockLotSpecification stockLotSpecification){
    return stockLotSpecification.specDetails!.isNotEmpty ? stockLotSpecification.specDetails!
        .length >
        1
        ? Utils.stockLotPriceRange(
        stockLotSpecification)
        :  [
      TextSpan(
        text: stockLotSpecification.specDetails!.first.price/*'1000'*/,
        style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            // /**/,
            fontWeight: FontWeight.w600),
      ),
      TextSpan(
        text:
        "/${stockLotSpecification.specDetails!.first.priceUnit!= null?stockLotSpecification.specDetails!.first.priceUnit!.split(" ").first : ""}",
        style: TextStyle(
            color: Colors.black,
            fontSize: 11.sp,
            // /**/,
            fontWeight: FontWeight.w600),
      ),
    ] : [
      TextSpan(
        text: "",
        style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            // /**/,
            fontWeight: FontWeight.w600),
      ),
      TextSpan(
        text:
        "",
        style: TextStyle(
            color: Colors.black,
            fontSize: 11.sp,
            // /**/,
            fontWeight: FontWeight.w600),
      ),
    ];


  }

}
