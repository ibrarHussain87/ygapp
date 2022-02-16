import 'package:fitted_text_field_container/fitted_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/alert_dialog.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

import 'decoration_widgets.dart';
import 'elevated_button_widget_2.dart';

class SendProposalBottomSheet extends StatefulWidget {

  final Specification? specification;
  final YarnSpecification? yarnSpecification;

  const SendProposalBottomSheet({Key? key,this.specification, this.yarnSpecification}) : super(key: key);

  @override
  _SendProposalBottomSheetState createState() => _SendProposalBottomSheetState();
}

class _SendProposalBottomSheetState extends State<SendProposalBottomSheet> {

  int? _bidPrice;
  int? _bidQuantity;
  int? _minBidQuantity;
  int? _tempBidQuantity;
  bool _isChanged = false;
  String _bidRemarks = "";
  final priceController = TextEditingController();
  final quantityController = TextEditingController();

  bool _isYarn() {
    if (widget.specification == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    setState(() {
      if (widget.specification != null) {
        _bidPrice = int.parse(widget.specification!.priceUnit!.split(" ").last);
      } else {
        Logger().e(widget.yarnSpecification!.priceUnit!);
        _bidPrice = int.parse(widget.yarnSpecification!.priceUnit!
            .replaceAll(RegExp(r'[^0-9]'), ''));
      }
      _bidQuantity = _isYarn()
          ? int.parse(widget.yarnSpecification!.minQuantity!)
          : int.parse(widget.specification!.minQuantity!);

      _minBidQuantity = _isYarn()
          ? int.parse(widget.yarnSpecification!.minQuantity!)
          : int.parse(widget.specification!.minQuantity!);

      if (!_isChanged) {
        _tempBidQuantity = _isYarn()
            ? int.parse(widget.yarnSpecification!.minQuantity!)
            : int.parse(widget.specification!.minQuantity!);
        _isChanged = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
          height: 0.26 * MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Center(
                          /*child: TitleSmallTextWidget(
                                              title: 'Price'),
                                        )*/
                          child: Text(
                            'Price',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        )),
                    SizedBox(
                      width: 200.w,
                      child: Padding(
                        padding: EdgeInsets.all(1.w),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      if (_bidPrice! >= 1) {
                                        _bidPrice = _bidPrice! - 1;
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: lightBlueTabs,
                                          width:
                                          1, //                   <--- border width here
                                        ),
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(
                                                12.w))),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.w),
                                      child: Center(
                                        child: TitleTextWidget(
                                          title: '-1',
                                          color: lightBlueTabs,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            /*fixed price 3 4 digit issue*/
                            const SizedBox(
                              width: 2,
                            ),
                            Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.w,
                                      horizontal: 3.w),
                                  child: Center(
                                      child: SizedBox(
                                        width: 50.w,
                                        child: FittedTextFieldContainer(
                                          child: TextField(
                                            showCursor: false,
                                            keyboardType:
                                            TextInputType.number,
                                            textInputAction:
                                            TextInputAction.done,
                                            textAlign: TextAlign.center,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            controller: priceController
                                              ..text = _bidPrice
                                                  .toString()
                                                  .trim()
                                                  .isNotEmpty
                                                  ? _bidPrice.toString()
                                                  : '0',
                                            onChanged: (value) {
                                              if (value != '') {
                                                _bidPrice = int.parse(
                                                    value.replaceAll(
                                                        RegExp(
                                                            r'^0+(?=.)'),
                                                        ''));
                                                priceController.text =
                                                    _bidPrice
                                                        .toString()
                                                        .trim();
                                                priceController
                                                    .selection =
                                                    TextSelection.fromPosition(
                                                        TextPosition(
                                                            offset: priceController
                                                                .text
                                                                .length));
                                              } else {
                                                priceController.text =
                                                '0';
                                                priceController
                                                    .selection =
                                                    TextSelection.fromPosition(
                                                        TextPosition(
                                                            offset: priceController
                                                                .text
                                                                .length));
                                                _bidPrice = 0;
                                              }
                                            },
                                            decoration:
                                            const InputDecoration(
                                                border: InputBorder
                                                    .none),
                                          ),
                                        ),
                                      )),
                                )),
                            const SizedBox(
                              width: 2,
                            ),
                            Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      _bidPrice = _bidPrice! + 1;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: lightBlueTabs,
                                          width:
                                          1, //                   <--- border width here
                                        ),
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(
                                                12.w))),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.w),
                                      child: Center(
                                        child: TitleTextWidget(
                                          title: '+1',
                                          color: lightBlueTabs,
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Center(
                        /*child: TitleSmallTextWidget(
                                              title: 'Quantity (Kg)')*/
                          child: Text(
                            'Quantity (Kg)',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                    Container(
                      width: 200.w,
                      child: Padding(
                        padding: EdgeInsets.all(1.w),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                behavior:
                                HitTestBehavior.opaque,
                                onTap: () {
                                  setState(() {
                                    if (_bidQuantity! >
                                        _tempBidQuantity!) {
                                      _bidQuantity =
                                          _bidQuantity! - 1;
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: lightBlueTabs,
                                        width:
                                        1, //                   <--- border width here
                                      ),
                                      borderRadius:
                                      BorderRadius.all(
                                          Radius.circular(
                                              12.w))),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.all(8.w),
                                    child: Center(
                                      child: TitleTextWidget(
                                        title: '-1',
                                        color: lightBlueTabs,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.w,
                                      horizontal: 3.w),
                                  child: Center(
                                    child: SizedBox(
                                      width: 50.w,
                                      child:
                                      FittedTextFieldContainer(
                                        child: TextField(
                                          showCursor: false,
                                          keyboardType:
                                          TextInputType.number,
                                          textInputAction:
                                          TextInputAction.done,
                                          textAlign:
                                          TextAlign.center,
                                          inputFormatters: <
                                              TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .allow(RegExp(
                                                r'[0-9]')),
                                          ],
                                          controller:
                                          quantityController
                                            ..text =
                                            _bidQuantity
                                                .toString(),
                                          onChanged: (value) {
                                            if (value != '') {
                                              _bidQuantity = int.parse(
                                                  value.replaceAll(
                                                      RegExp(
                                                          r'^0+(?=.)'),
                                                      ''));
                                              quantityController
                                                  .text =
                                                  _bidQuantity
                                                      .toString()
                                                      .trim();
                                              quantityController
                                                  .selection =
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset: quantityController
                                                              .text
                                                              .length));
                                            } else {
                                              quantityController
                                                  .text =
                                                  _minBidQuantity
                                                      .toString()
                                                      .trim();
                                              quantityController
                                                  .selection =
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset: quantityController
                                                              .text
                                                              .length));
                                              _bidQuantity =
                                                  _minBidQuantity;
                                            }
                                          },
                                          decoration:
                                          const InputDecoration(
                                              border:
                                              InputBorder
                                                  .none),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    setState(() {
                                      _bidQuantity =
                                          _bidQuantity! + 1;
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: lightBlueTabs,
                                            width:
                                            1, //                   <--- border width here
                                          ),
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  12.w))),
                                      child: Padding(
                                        padding:
                                        EdgeInsets.all(8.w),
                                        child: Center(
                                          child: TitleTextWidget(
                                            title: '+1',
                                            color: lightBlueTabs,
                                          ),
                                        ),
                                      )),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12.w,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 0.w),
                  child: Text(
                    'Remarks',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: 4.w,
              ),
              SizedBox(
                height: 5 * 22.w,
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    cursorColor: lightBlueTabs,
                    style: TextStyle(fontSize: 11.sp),
                    textAlign: TextAlign.start,
                    cursorHeight: 16.w,
                    showCursor: false,
                    readOnly: false,
                    onSaved: (value) {},
                    onChanged: (value) {
                      _bidRemarks = value;
                    },
                    decoration: roundedDescriptionDecorationUpdated(
                        "Remarks")),
              ),
              Visibility(
                visible: true,
                child: ElevatedButtonWithoutIcon(
                    callback: () {
                      FocusScope.of(context).unfocus();
                      /*var logger = Logger();
                      logger.e(_bidPrice);
                      logger.e(_bidQuantity);*/
                      if (_bidPrice!.toInt() <= 0) {
                        Ui.showSnackBar(context, "Please enter price");
                      } else if (_bidQuantity!.toInt() <= 0) {
                        Ui.showSnackBar(context, "Please enter quantity");
                      } else if (_bidQuantity!.toInt() < _minBidQuantity!) {
                        Ui.showSnackBar(context,
                            "Please enter minimum quantity ${_minBidQuantity}");
                      } else {
                        showGenericDialog(
                          'Send Proposal',
                          "Are you sure, you want to send Proposal?",
                          context,
                          StylishDialogType.WARNING,
                          'Yes',
                              () {
                            placeBid(context);
                          },
                        );
                      }
                    },
                    color: btnColorLogin,
                    btnText: 'Send Proposal'),
              ),
            ],
          )),
    );
  }

  void placeBid(BuildContext context) {
    ProgressDialogUtil.showDialog(context, "Please wait....");
    ApiService.createBid(
        widget.specification == null
            ? 2.toString()
            : widget.specification!.categoryId.toString(),
        widget.specification == null
            ? widget.yarnSpecification!.ysId.toString()
            : widget.specification!.spcId.toString(),
        _bidPrice.toString(),
        _bidQuantity.toString(),
        _bidRemarks)
        .then((value) {
      ProgressDialogUtil.hideDialog();
      // Ui.showSnackBar(context, value.message);
      showGenericDialog(
        'Send Proposal',
        value.message,
        context,
        StylishDialogType.SUCCESS,
        'Yes',
            () {},
      );
    }, onError: (stacktrace, error) {
      ProgressDialogUtil.hideDialog();
      // Ui.showSnackBar(context, error.message.toString());
      showGenericDialog(
        'Send Proposal',
        error.message.toString(),
        context,
        StylishDialogType.ERROR,
        'Yes',
            () {},
      );
    });
  }

}




