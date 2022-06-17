import 'package:fitted_text_field_container/fitted_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:logger/logger.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_without_icon_widget.dart';
import 'package:yg_app/elements/list_widgets/list_detail_item_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/model/detail_tile_model.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:yg_app/providers/detail_provider/detail_page_provider.dart';

class DetailTabPage extends StatefulWidget {
  // final Specification? specification;
  // final YarnSpecification? yarnSpecification;
  // final dynamic specObject;
  final bool? sendProposal;

  const DetailTabPage(
      {Key? key,
      // this.specification,
      // this.yarnSpecification,
      // this.specObject,
      this.sendProposal})
      : super(key: key);

  @override
  _DetailTabPageState createState() => _DetailTabPageState();
}

class _DetailTabPageState extends State<DetailTabPage> {
  late BuildContext _context1;
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final _detailPageProvider = locator<DetailPageProvider>();

  @override
  void initState() {
    super.initState();
    setBidPrice();
    _detailPageProvider.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context1 = context;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.w,
                    ),
                    TitleTextWidget(
                      title: specifications.toUpperCase(),
                      color: titleColor,
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    ListView.separated(
                      itemCount: _detailPageProvider.detailSpecification.length,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => listDetailItemWidget(
                          context,
                          _detailPageProvider.detailSpecification[index]),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 8.w,
                    ),
                    /*fixed lab parameters issue in fiber*/
                    Visibility(
                      visible: _detailPageProvider.getOfferingVisibility(),
                      child: Container(
                        child: _detailPageProvider.isYarn
                            ? _detailPageProvider
                                        .yarnSpecification!.yarnFamilyId !=
                                    '4'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _detailPageProvider.isYarn
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 4.w,
                                                ),
                                                TitleTextWidget(
                                                  title: 'Lab Parameters'
                                                      .toUpperCase(),
                                                  color: titleColor,
                                                ),
                                                SizedBox(
                                                  height: 12.w,
                                                ),
                                              ],
                                            )
                                          : SizedBox(
                                              height: 4.w,
                                            ),
                                      ListView.separated(
                                        itemCount: _detailPageProvider
                                            .labParameters.length,
                                        shrinkWrap: true,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            listDetailItemWidget(
                                                context,
                                                _detailPageProvider
                                                    .labParameters[index]),
                                      ),
                                      /*GridView.count(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2.77,
                                  mainAxisSpacing: 3.w,
                                  crossAxisSpacing: 6.w,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(_labParameters.length,
                                      (index) {
                                    return TextDetailWidget(
                                        title: _labParameters[index]._title,
                                        detail: _labParameters[index]._detail);
                                  }),
                                ),*/
                                      const Divider(),
                                      SizedBox(
                                        height: 4.w,
                                      ),
                                    ],
                                  )
                                : Container()
                            : SizedBox(
                                height: 4.w,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 8.w,
                    ),
                    Visibility(
                      visible: !_detailPageProvider.isStockLot,
                      child: Column(
                        children: [
                          TitleTextWidget(
                            title: 'Packing Details'.toUpperCase(),
                            color: titleColor,
                          ),
                          SizedBox(
                            height: 12.w,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: !_detailPageProvider.isStockLot,
                      child: ListView.separated(
                        itemCount: _detailPageProvider.detailPackaging.length,
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => listDetailItemWidget(
                            context,
                            _detailPageProvider.detailPackaging[index]),
                      ),
                    ),
                    Visibility(
                      visible: _detailPageProvider.isStockLot,
                      child: GroupListView(
                        shrinkWrap: true,
                        sectionsCount: _detailPageProvider.stockLotItems.keys
                            .toList()
                            .length,
                        countOfItemInSection: (int section) {
                          return _detailPageProvider.stockLotItems.values
                              .toList()[section]
                              .length;
                        },
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: _itemBuilder,
                        groupHeaderBuilder:
                            (BuildContext context, int section) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TitleTextWidget(
                              title: _detailPageProvider.stockLotItems.keys
                                  .toList()[section]
                                  .toUpperCase(),
                              color: titleColor,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        sectionSeparatorBuilder: (context, section) =>
                            SizedBox(height: 10),
                      ),
                    ),
                    Visibility(
                        visible: !_detailPageProvider.isStockLot,
                        child: Divider()),
                    SizedBox(
                      height: 16.w,
                    ),
                  ],
                ),
              ),
              flex: 9,
            ),
            !_detailPageProvider.showBidContainer
                ? Visibility(
                    visible: _detailPageProvider.getOfferingVisibility(),
                    child: ElevatedButtonWithoutIcon(
                        callback: () {
                          _detailPageProvider.isYarn
                              ? Utils.updateDialog(
                                  context,
                                  _detailPageProvider.yarnSpecification,
                                  null,
                                  null, (updateSpecification) {
                                  _detailPageProvider.updateYarnSpecification(
                                      YarnSpecification.fromJson(
                                          updateSpecification));
                                })
                              : _detailPageProvider.isFiber
                                  ? Utils.updateDialog(
                                      context,
                                      null,
                                      _detailPageProvider.fiberSpecification,
                                      null, (updateSpecification) {
                                      _detailPageProvider
                                          .updateFiberSpecification(
                                              Specification.fromJson(
                                                  updateSpecification));
                                    })
                                  : _detailPageProvider.isStockLot
                                      ? Fluttertoast.showToast(
                                          msg: 'Delete coming soon')
                                      : Utils.updateDialog(
                                          context,
                                          null,
                                          null,
                                          _detailPageProvider
                                              .fabricSpecification,
                                          (updateSpecification) {
                                          _detailPageProvider
                                              .updateFabricSpecification(
                                                  FabricSpecification.fromJson(
                                                      updateSpecification));
                                        });
                        },
                        color: _detailPageProvider.isStockLot
                            ? Colors.red.shade400
                            : btnColorLogin,
                        btnText: _detailPageProvider.isStockLot
                            ? 'Delete'
                            : 'Update'),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButtonWithoutIcon(
                            callback: () {
                              showProposalBottomSheet(context);
                            },
                            color: btnColorLogin,
                            btnText: 'Send Proposal'),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: ElevatedButtonWithoutIcon(
                            callback: () {
                              FocusScope.of(context).unfocus();
                              _detailPageProvider.isFiber
                                  ? openSpecificationUserScreen(
                                      context,
                                      _detailPageProvider.fiberSpecification!.spcId
                                          .toString(),
                                      _detailPageProvider
                                          .fiberSpecification!.categoryId
                                          .toString())
                                  : _detailPageProvider.isYarn
                                      ? openSpecificationUserScreen(
                                          context,
                                          _detailPageProvider
                                              .yarnSpecification!.ysId
                                              .toString(),
                                          _detailPageProvider.yarnSpecification!
                                                      .category_id ==
                                                  null
                                              ? "2"
                                              : _detailPageProvider
                                                  .yarnSpecification!
                                                  .category_id
                                                  .toString())
                                      : _detailPageProvider.isStockLot
                                          ? openSpecificationUserScreen(
                                              context,
                                              _detailPageProvider
                                                  .stockLotSpecification!.id
                                                  .toString(),
                                              _detailPageProvider
                                                  .stockLotSpecification!
                                                  .stocklotCategoryId
                                                  .toString())
                                          : openSpecificationUserScreen(
                                              context,
                                              _detailPageProvider
                                                  .fabricSpecification!.fsId
                                                  .toString(),
                                              '3');
                            },
                            color: btnColorLogin,
                            btnText: 'Contact'),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

  void showProposalBottomSheet(BuildContext context) {
    _detailPageProvider.bidPrice = _detailPageProvider.bidPriceFixed;
    _detailPageProvider.bidQuantity = _detailPageProvider.bidQuantityFixed;
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Container(
                height: 0.5 * MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.w),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Send Proposal',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.all(4.w),
                                            child: Center(
                                              child: Text(
                                                'Price',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 250.w,
                                          child: Padding(
                                            padding: EdgeInsets.all(1.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    setState(() {
                                                      if (_detailPageProvider
                                                              .bidPrice! >=
                                                          1) {
                                                        _detailPageProvider
                                                                .bidPrice =
                                                            _detailPageProvider
                                                                    .bidPrice! -
                                                                1;
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
                                                                    8.w))),
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
                                                    child:
                                                        FittedTextFieldContainer(
                                                      child: TextField(
                                                        showCursor: true,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        textAlign:
                                                            TextAlign.center,
                                                        inputFormatters: <
                                                            TextInputFormatter>[
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'[0-9]')),
                                                        ],
                                                        controller: priceController
                                                          ..text = _detailPageProvider
                                                                  .bidPrice
                                                                  .toString()
                                                                  .trim()
                                                                  .isNotEmpty
                                                              ? _detailPageProvider
                                                                  .bidPrice
                                                                  .toString()
                                                              : '0'
                                                          ..selection = TextSelection.collapsed(
                                                              offset: _detailPageProvider
                                                                  .bidPrice
                                                                  .toString()
                                                                  .length),
                                                        onChanged: (value) {
                                                          if (value != '') {
                                                            _detailPageProvider
                                                                    .bidPrice =
                                                                int.parse(value
                                                                    .replaceAll(
                                                                        RegExp(
                                                                            r'^0+(?=.)'),
                                                                        ''));
                                                            priceController
                                                                    .text =
                                                                _detailPageProvider
                                                                    .bidPrice
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
                                                            priceController
                                                                .text = '0';
                                                            priceController
                                                                    .selection =
                                                                TextSelection.fromPosition(
                                                                    TextPosition(
                                                                        offset: priceController
                                                                            .text
                                                                            .length));
                                                            _detailPageProvider
                                                                .bidPrice = 0;
                                                          }
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    InputBorder
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
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    setState(() {
                                                      _detailPageProvider
                                                              .bidPrice =
                                                          _detailPageProvider
                                                                  .bidPrice! +
                                                              1;
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
                                                                    8.w))),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8.w),
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
                                    Visibility(
                                      visible: !_detailPageProvider.isStockLot,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )),
                                              ),
                                              Container(
                                                width: 250.w,
                                                child: Padding(
                                                  padding: EdgeInsets.all(1.w),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: GestureDetector(
                                                          behavior:
                                                              HitTestBehavior
                                                                  .opaque,
                                                          onTap: () {
                                                            setState(() {
                                                              if (_detailPageProvider
                                                                      .bidQuantity! >
                                                                  _detailPageProvider
                                                                      .tempBidQuantity!) {
                                                                _detailPageProvider
                                                                        .bidQuantity =
                                                                    _detailPageProvider
                                                                            .bidQuantity! -
                                                                        1;
                                                              }
                                                            });
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color:
                                                                          lightBlueTabs,
                                                                      width:
                                                                          1, //                   <--- border width here
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(8.w))),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.w),
                                                              child: Center(
                                                                child:
                                                                    TitleTextWidget(
                                                                  title: '-1',
                                                                  color:
                                                                      lightBlueTabs,
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 0.w,
                                                                horizontal:
                                                                    3.w),
                                                        child: Center(
                                                          child: SizedBox(
                                                            width: 50.w,
                                                            child:
                                                                FittedTextFieldContainer(
                                                              child: TextField(
                                                                showCursor:
                                                                    true,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .done,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                inputFormatters: <
                                                                    TextInputFormatter>[
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp(
                                                                          r'[0-9]')),
                                                                ],
                                                                controller:
                                                                    quantityController
                                                                      ..text = _detailPageProvider
                                                                          .bidQuantity
                                                                          .toString()
                                                                      ..selection = TextSelection.collapsed(
                                                                          offset: _detailPageProvider
                                                                              .bidQuantity
                                                                              .toString()
                                                                              .length),
                                                                onChanged:
                                                                    (value) {
                                                                  if (value !=
                                                                      '') {
                                                                    _detailPageProvider
                                                                            .bidQuantity =
                                                                        int.parse(value.replaceAll(
                                                                            RegExp(r'^0+(?=.)'),
                                                                            ''));
                                                                    quantityController
                                                                            .text =
                                                                        _detailPageProvider
                                                                            .bidQuantity
                                                                            .toString()
                                                                            .trim();
                                                                    quantityController
                                                                            .selection =
                                                                        TextSelection.fromPosition(TextPosition(
                                                                            offset:
                                                                                quantityController.text.length));
                                                                  } else {
                                                                    quantityController
                                                                            .text =
                                                                        _detailPageProvider
                                                                            .minBidQuantity
                                                                            .toString()
                                                                            .trim();
                                                                    quantityController
                                                                            .selection =
                                                                        TextSelection.fromPosition(TextPosition(
                                                                            offset:
                                                                                quantityController.text.length));
                                                                    _detailPageProvider
                                                                            .bidQuantity =
                                                                        _detailPageProvider
                                                                            .minBidQuantity;
                                                                  }
                                                                },
                                                                decoration:
                                                                    const InputDecoration(
                                                                        border:
                                                                            InputBorder.none),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                          child:
                                                              GestureDetector(
                                                        behavior:
                                                            HitTestBehavior
                                                                .opaque,
                                                        onTap: () {
                                                          setState(() {
                                                            _detailPageProvider
                                                                    .bidQuantity =
                                                                _detailPageProvider
                                                                        .bidQuantity! +
                                                                    1;
                                                          });
                                                        },
                                                        child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color:
                                                                          lightBlueTabs,
                                                                      width:
                                                                          1, //                   <--- border width here
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(8.w))),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.w),
                                                              child: Center(
                                                                child:
                                                                    TitleTextWidget(
                                                                  title: '+1',
                                                                  color:
                                                                      lightBlueTabs,
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
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.w,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(left: 0.w),
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional.topStart,
                                          child: Text(
                                            'Remarks',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w700),
                                          ),
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
                                            _detailPageProvider.bidRemarks =
                                                value;
                                          },
                                          decoration:
                                              roundedDescriptionDecorationUpdated(
                                                  "Enter your remarks")),
                                    ),
                                  ],
                                ),
                              ),
                              flex: 9,
                            ),
                            Expanded(
                              child: ElevatedButtonWithoutIcon(
                                  callback: () {
                                    FocusScope.of(context).unfocus();
                                    var logger = Logger();
                                    logger.e(_detailPageProvider.bidPrice);
                                    logger.e(_detailPageProvider.bidQuantity);
                                    if (_detailPageProvider.bidPrice!.toInt() <=
                                        0) {
                                      //Ui.showSnackBar(context, "Please enter price");
                                      Fluttertoast.showToast(
                                          msg: "Please enter price");
                                    } else if (_detailPageProvider
                                            .bidQuantity ==
                                        null) {
                                      //Ui.showSnackBar(context, "Please enter quantity");
                                      Fluttertoast.showToast(
                                          msg: "Please enter quantity");
                                    } else if (!_detailPageProvider
                                            .isStockLot &&
                                        _detailPageProvider.bidQuantity !=
                                            null &&
                                        _detailPageProvider.bidQuantity!
                                                .toInt() <
                                            _detailPageProvider
                                                .minBidQuantity!) {
                                      /*Ui.showSnackBar(context,
                                            "Please enter minimum quantity ${_minBidQuantity}");*/
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please enter minimum quantity ${_detailPageProvider.minBidQuantity}");
                                    } else {
                                      showGenericDialog(
                                        'Send Proposal',
                                        "Are you sure, you want to send proposal?",
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
                            SizedBox(
                              height: 4.h,
                            )
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.close),
                          )),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  void placeBid(BuildContext context) {
    ProgressDialogUtil.showDialog(context, "Please wait....");
    ApiService()
        .createBid(
            _detailPageProvider.isYarn
                ? 2.toString()
                : _detailPageProvider.isFiber
                    ? _detailPageProvider.fiberSpecification!.categoryId
                        .toString()
                    : _detailPageProvider.isStockLot
                        ? _detailPageProvider
                            .stockLotSpecification!.stocklotCategoryId
                            .toString()
                        : 3.toString(),
            _detailPageProvider.isYarn
                ? _detailPageProvider.yarnSpecification!.ysId.toString()
                : _detailPageProvider.isFiber
                    ? _detailPageProvider.fiberSpecification!.spcId.toString()
                    : _detailPageProvider.isStockLot
                        ? _detailPageProvider.stockLotSpecification!.id
                            .toString()
                        : _detailPageProvider.fabricSpecification!.fsId
                            .toString(),
            _detailPageProvider.bidPrice.toString(),
            _detailPageProvider.bidQuantity.toString(),
            _detailPageProvider.bidRemarks)
        .then((value) {
      ProgressDialogUtil.hideDialog();
      // Ui.showSnackBar(context, value.message);
      Navigator.pop(context);
      showGenericDialog(
        'Send Proposal',
        value.message,
        _context1,
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

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    DetailTileModel details = _detailPageProvider.stockLotItems.values
        .toList()[index.section][index.index];
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Text(
              details.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600),
            ),
            flex: 6,
          ),
          Expanded(
            child: Text(
              details.detail,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400),
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }

  DetailTileModel formatFormations(List<GenericFormation> yarnFormation) {
    DetailTileModel formationTileModel;
    switch (yarnFormation.length) {
      case 1:
        if (yarnFormation.first.formationRatio == "100") {
          formationTileModel = DetailTileModel('Blends Formation', '');
        } else {
          formationTileModel = DetailTileModel('Blends Formation',
              "${yarnFormation.first.blendName} :${yarnFormation.first.formationRatio}");
        }
        break;
      case 2:
        formationTileModel = DetailTileModel(
            'Blends Formation',
            '${yarnFormation.first.blendName ?? Utils.checkNullString(false)} : ${yarnFormation.first.formationRatio ?? Utils.checkNullString(false)} '
                '${yarnFormation[1].blendName ?? Utils.checkNullString(false)} : ${yarnFormation[1].formationRatio ?? Utils.checkNullString(false)}');
        break;
      default:
        String? blendString = '';
        for (var element in yarnFormation) {
          if (blendString!.isEmpty) {
            blendString =
                blendString + '${element.blendName}:${element.formationRatio} ';
          } else {
            blendString = blendString +
                ': ${element.blendName}:${element.formationRatio} ';
          }
        }
        formationTileModel = DetailTileModel(
            'Blends Formation', blendString ?? Utils.checkNullString(false));
        break;
    }
    return formationTileModel;
  }

  void openBottomSheet() async {
    var userId = await _detailPageProvider.getUserId();
    if (_detailPageProvider.isFiber) {
      userId != _detailPageProvider.fiberSpecification!.spc_user_id
          ? _detailPageProvider.showBidContainer = true
          : _detailPageProvider.showBidContainer = false;
    } else if (_detailPageProvider.isYarn) {
      userId != _detailPageProvider.yarnSpecification!.ys_user_id
          ? _detailPageProvider.showBidContainer = true
          : _detailPageProvider.showBidContainer = false;
    } else if (_detailPageProvider.isFabric) {
      userId != _detailPageProvider.fabricSpecification!.fsUserId
          ? _detailPageProvider.showBidContainer = true
          : _detailPageProvider.showBidContainer = false;
    } else {
      userId != _detailPageProvider.stockLotSpecification!.userId
          ? _detailPageProvider.showBidContainer = true
          : _detailPageProvider.showBidContainer = false;
    }
    _detailPageProvider.notifyUI();
    if (widget.sendProposal ?? false) {
      showProposalBottomSheet(context);
    }
  }

  void setBidPrice() {
    _detailPageProvider.setBidPriceQty();
    _detailPageProvider.setDetailData();
    openBottomSheet();
  }
}
