import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yg_app/elements/list_widgets/bid_now_widget.dart';
import 'package:yg_app/elements/list_widgets/short_detail_renewed_widget.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:intl/intl.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';

class StockLotListItem extends StatefulWidget {
  final StockLotSpecification specification;
  final bool? showCount;

  const StockLotListItem({Key? key, required this.specification, this.showCount})
      : super(key: key);

  @override
  State<StockLotListItem> createState() => _StockLotListItemState();
}

class _StockLotListItemState extends State<StockLotListItem> {

  priceStockLot(){
    return widget.specification.specDetails!.isNotEmpty ?widget.specification.specDetails!
        .length >
        1
        ? Utils.stockLotPriceRange(
        widget.specification)
        :  [
      // TextSpan(
      //   text:
      //   '${specification.priceUnit.toString().replaceAll(RegExp(r'[^a-zA-Z$]'), '')}.',
      //   style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 12.sp,
      //       // /*fontFamily: 'Metropolis',*/,
      //       fontWeight: FontWeight.w500),
      // ),
      TextSpan(
        text: widget.specification.specDetails!.first.price/*'1000'*/,
        style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            // /*fontFamily: 'Metropolis',*/,
            fontWeight: FontWeight.w600),
      ),
      TextSpan(
        text:
        "/${widget.specification.specDetails!.first.priceUnit!= null?widget.specification.specDetails!.first.priceUnit!.split(" ").first : ""}",
        style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            // /*fontFamily: 'Metropolis',*/,
            fontWeight: FontWeight.w500),
      ),
    ] : [
      TextSpan(
        text: "",
        style: TextStyle(
            color: Colors.black,
            fontSize: 17.sp,
            // /*fontFamily: 'Metropolis',*/,
            fontWeight: FontWeight.w600),
      ),
      TextSpan(
        text:
        "",
        style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
            // /*fontFamily: 'Metropolis',*/,
            fontWeight: FontWeight.w500),
      ),
    ];


  }

  late List<TextSpan> priceStockLotSpec;

  @override
  void initState() {
    super.initState();
    priceStockLotSpec = priceStockLot();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double paddingStart = 10;
    double paddingStartFeatured = 20;
    double paddingTop = 15;
    double paddingBottom = 10;
    double paddingEnd = 10;
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
      child: Material(
          color: Colors.white,
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: border_color,
                width: 1,
                style: BorderStyle.solid
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: widget.specification.isFeatured == '0'
                          ? paddingStart
                          : paddingStartFeatured,
                      right: paddingEnd,
                      // top: paddingTop,
                      bottom: paddingBottom),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.65,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  child: Text(
                                    widget.specification.company ??
                                        Utils.checkNullString(false),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      /*fontFamily: 'Metropolis',*/
                                    ),
                                  ),
                                  width: size.width * 0.40,
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Visibility(
                                  visible: false,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "4.5",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600
                                          /*fontFamily: 'Metropolis',*/,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Image.asset(
                                        ratingIcon,
                                        width: 8.w,
                                        height: 8.w,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2.w),
                                  child: Visibility(
                                      visible: Ui.showHide(widget
                                          .specification.isVerified) /*true*/,
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
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    color: blueContainerLight,
                                    // constraints:
                                    //     const BoxConstraints(maxHeight: 14),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 1),
                                      child: Center(
                                        child: TitleMediumBoldSmallTextWidget(
                                          title: widget.specification.stocklotParentFamilyName,
                                          color: Colors.white,
                                          textSize: 12,
                                        ),
                                      ),
                                    )),
                                // const SizedBox(
                                //   width: 2,
                                // ),
                                // Expanded(
                                //   child: TitleMediumTextWidget(
                                //     title: "Dummy",
                                //     color: Colors.black87,
                                //     weight: FontWeight.w600,
                                //     size: 13,
                                //   ),
                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TitleSmallBoldTextWidget(
                              title: Utils.stockLotSubCategoryTitle(
                                  widget.specification),
                              color: Colors.black87,
                              size: 11,
                              weight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            widget.specification.specDetails!.isNotEmpty ?Row(
                              children: [
                                Expanded(
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 3.0,
                                    children: [
                                      ShortDetailRenewedWidget(
                                        title: widget.specification.priceTerm ??
                                            Utils.checkNullString(false),
                                        imageIcon: IC_BAG_RENEWED,
                                        size: 10.sp,
                                        iconSize: 12,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title:
                                            widget.specification.availablity ??
                                                Utils.checkNullString(false),
                                        imageIcon: IC_CONE_RENEWED,
                                        size: 10.sp,
                                        iconSize: 12,
                                      ),
                                      ShortDetailRenewedWidget(
                                        title: widget.specification.locality,
                                        imageIcon: IC_VAN_RENEWED,
                                        size: 10.sp,
                                        iconSize: 12,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ):Container(),
                            Visibility(
                              visible: widget.showCount ?? false,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 0.w,
                                    right: 18.w,
                                    top: 0.w,
                                    bottom: 10.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: greenButton,
                                                  width:
                                                  1, //                   <--- border width here
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.w))),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 6.w),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Proposals',
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                        ),
                                                        Text(
                                                          widget.specification
                                                              .proposalCount
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              color:
                                                              greenButton,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700),
                                                        ),
                                                        // SizedBox(
                                                        //   width: 3.w,
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Align(
                                                //     alignment: AlignmentDirectional.topEnd,
                                                //     child: Padding(
                                                //       padding: const EdgeInsets.all(2),
                                                //       child: Container(
                                                //         width: 10,
                                                //         height: 10,
                                                //         decoration: BoxDecoration(
                                                //             color: redColor,
                                                //             borderRadius: BorderRadius.all(
                                                //                 Radius.circular(10.w))),
                                                //         child: Center(
                                                //           child: Text(
                                                //             specification.proposalCount.toString(),
                                                //             textAlign: TextAlign.center,
                                                //             style: TextStyle(
                                                //                 fontSize: 8.sp,
                                                //                 color: Colors.white,
                                                //                 fontWeight: FontWeight.w400),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ))
                                              ],
                                            ))),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                              /*color: lightYellowContainer,*/
                                                border: Border.all(
                                                  color: greenButton,
                                                  width:
                                                  1, //                   <--- border width here
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4.w))),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 6.w),
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Matches',
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                        ),
                                                        Text(
                                                          widget.specification
                                                              .matchedCount
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
                                                              color:
                                                              greenButton,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700),
                                                        ),
                                                        // SizedBox(
                                                        //   width: 3.w,
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Align(
                                                //     alignment: AlignmentDirectional.topEnd,
                                                //     child: Padding(
                                                //       padding: const EdgeInsets.all(2),
                                                //       child: Container(
                                                //         width: 10,
                                                //         height: 10,
                                                //         decoration: BoxDecoration(
                                                //             color: redColor,
                                                //             borderRadius: BorderRadius.all(
                                                //                 Radius.circular(10.w))),
                                                //         child: Center(
                                                //           child: Text(
                                                //             '3',
                                                //             textAlign: TextAlign.center,
                                                //             style: TextStyle(
                                                //                 fontSize: 8.sp,
                                                //                 color: Colors.white,
                                                //                 fontWeight: FontWeight.w400),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ))
                                              ],
                                            ))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: paddingTop),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(TextSpan(children: priceStockLotSpec,)),
                              SizedBox(
                                height: 1.h,
                              ),
                              const Center(
                                child: TitleSmallNormalTextWidget(
                                  title: "Ex- Factory",
                                  size: 8,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: "Last Updated",
                                      style: TextStyle(
                                          fontSize: 8.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ])),
                                  SizedBox(
                                    height: 2.w,
                                  ),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: DateFormat("MMM dd, yyyy").format(
                                          DateTime.parse(
                                              widget.specification.date ?? "")),
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: lightBlueLabel),
                                    )
                                  ])),
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              SizedBox(
                                height: 20.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: 0,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            border: Border.all(
                                                color: Colors.grey.shade500)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.network(
                                            /*specification
                                                    .certifications![index]
                                                    .certification!
                                                    .icon ??*/
                                            'images/ic_list.png',
                                            height: 20.w,
                                            width: 20.h,
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              FutureBuilder<String>(
                                future: Utils.getUserId(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                        padding: EdgeInsets.only(
                                          left: 4.w,
                                          right: 4.w,
                                        ),
                                        child: GestureDetector(
                                            onTap: () {
                                              if (widget.specification.userId == snapshot.data) {
                                                Fluttertoast.showToast(msg: "Delete coming soon...");
                                              } else {
                                                openDetailsScreen(context,
                                                    specObj:
                                                        widget.specification,
                                                    sendProposal: true);
                                              }
                                            },
                                            child: SizedBox(
                                              width: 80,
                                              height: 22,
                                              child: Center(
                                                child: BidNowWidget(
                                                  color: snapshot.data !=
                                                      widget.specification.userId ?greenButtonColor : Colors.red.shade400 ,
                                                  title: snapshot.data !=
                                                          widget.specification.userId
                                                      ? 'Send Proposal':
                                                      "Delete",
                                                  size: 10.sp,
                                                  padding: 5,
                                                ),
                                              ),
                                            )));
                                  } else {
                                    return Text(
                                      'Error: ${snapshot.error}',
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: Ui.showHide(widget.specification.isFeatured),
                child: Positioned.fill(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      FEATURED_VERTICAL,
                      width: 13.w,
                      fit: BoxFit.fill,
                      height: double.maxFinite,
                    ),
                  )
                  /*Container(
                  width: 13.w,
                  */ /*height: 80.h,*/ /*
                  color: Colors.red,
                )*/
                  ,
                ),
              ),
            ],
          )),
    );
  }
}
