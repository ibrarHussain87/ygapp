import 'package:fitted_text_field_container/fitted_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_widgets/list_detail_item_widget.dart';
import 'package:yg_app/elements/send_proposal_bottom_sheet.dart';
import 'package:yg_app/elements/text_detail_widget_.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/dialog_builder.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/helper_utils/util.dart';
import 'package:yg_app/model/response/fabric_response/fabric_specification_response.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/stocklot_repose/stocklot_specification_response.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';
import 'package:group_list_view/group_list_view.dart';

class DetailTabPage extends StatefulWidget {
  final Specification? specification;
  final YarnSpecification? yarnSpecification;
  final dynamic specObject;
  final bool? sendProposal;

  const DetailTabPage(
      {Key? key,
      this.specification,
      this.yarnSpecification,
      this.specObject,
      this.sendProposal})
      : super(key: key);

  @override
  _DetailTabPageState createState() => _DetailTabPageState();
}

class _DetailTabPageState extends State<DetailTabPage> {
  List<GridTileModel> _detailSpecification = [];
  List<GridTileModel> _labParameters = [];
  List<GridTileModel> _detailPackaging = [];
  int? _bidPrice = 0;
  int? _bidPriceFixed;
  int? _bidQuantity;
  int? _bidQuantityFixed;
  int? _minBidQuantity;
  int? _tempBidQuantity;
  String _bidRemarks = "";
  bool _showBidContainer = false;
  bool _isChanged = false;
  String? _userId;
  int? stockLotMin;
  int? stockLotMax;
  Map<String, List<GridTileModel>> _stockLotItems = {};
  late BuildContext _context1;
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
        _bidPrice =
            int.tryParse(widget.specification!.priceUnit!.split(" ").last);
        _bidPriceFixed = _bidPrice ?? 0;
      } else if (widget.yarnSpecification != null) {
        _bidPrice = int.tryParse(widget.yarnSpecification!.priceUnit!
            .replaceAll(RegExp(r'[^0-9]'), ''));
        _bidPriceFixed = _bidPrice ?? 0;
      } else if (widget.specObject is FabricSpecification) {
        _bidPrice = int.tryParse((widget.specObject as FabricSpecification)
            .priceUnit!
            .replaceAll(RegExp(r'[^0-9]'), ''));
        _bidPriceFixed = _bidPrice ?? 0;
      } else {
        stockLotMin =
            Utils.stockLotPriceMin(widget.specObject as StockLotSpecification);

        _bidPrice = stockLotMin;
        _bidPriceFixed = _bidPrice ?? 0;
        stockLotMax =
            Utils.stockLotPriceMax(widget.specObject as StockLotSpecification);
      }

      if (widget.specObject == null) {
        _bidQuantity = _isYarn()
            ? int.tryParse(widget.yarnSpecification!.minQuantity ?? "0")
            : int.tryParse(widget.specification!.minQuantity ?? "0");

        _bidQuantityFixed = _isYarn()
            ? int.tryParse(widget.yarnSpecification!.minQuantity ?? "0")
            : int.tryParse(widget.specification!.minQuantity ?? "0");

        _minBidQuantity = _isYarn()
            ? int.tryParse(widget.yarnSpecification!.minQuantity ?? "0")
            : int.tryParse(widget.specification!.minQuantity ?? "0");

        if (!_isChanged) {
          _tempBidQuantity = _isYarn()
              ? int.tryParse(widget.yarnSpecification!.minQuantity ?? "0")
              : int.tryParse(widget.specification!.minQuantity ?? "0");
          _isChanged = true;
        }
      } else if (widget.specObject is FabricSpecification) {
        var fabricSpec = (widget.specObject as FabricSpecification);
        _bidQuantity = int.tryParse(fabricSpec.minQuantity ?? "0");

        _bidQuantityFixed = int.tryParse(fabricSpec.minQuantity ?? "0");

        _minBidQuantity = int.tryParse(fabricSpec.minQuantity ?? "0");

        if (!_isChanged) {
          _tempBidQuantity = int.tryParse(fabricSpec.minQuantity ?? "0");
          _isChanged = true;
        }
      }
    });

    widget.specification != null
        ? _fiberDetails()
        : widget.yarnSpecification != null
            ? _yarnDetails()
            : widget.specObject is StockLotSpecification
                ? _stockLotDetails()
                : _fabricDetails();

    _getUserId().then((value) {
      _userId = value;
      if (widget.specification != null) {
        if (value != widget.specification!.spc_user_id) {
          setState(() {
            _showBidContainer = true;
          });
          if (widget.sendProposal ?? false) {
            showProposalBottomSheet(context);
          }
        }
      } else if (widget.yarnSpecification != null) {
        if (value != widget.yarnSpecification!.ys_user_id) {
          setState(() {
            _showBidContainer = true;
          });
          if (widget.sendProposal ?? false) {
            showProposalBottomSheet(context);
          }
        }
      } else if (widget.specObject is FabricSpecification) {
        if (value != (widget.specObject as FabricSpecification).fsUserId) {
          setState(() {
            _showBidContainer = true;
          });
          if (widget.sendProposal ?? false) {
            showProposalBottomSheet(context);
          }
        }
      } else {
        if (value != (widget.specObject as StockLotSpecification).userId) {
          setState(() {
            _showBidContainer = true;
          });
          if (widget.sendProposal ?? false) {
            showProposalBottomSheet(context);
          }
        }
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
                      itemCount: _detailSpecification.length,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => listDetailItemWidget(
                          context, _detailSpecification[index]),
                    ),
                    /*GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 2.77,
                      mainAxisSpacing: 3.w,
                      crossAxisSpacing: 6.w,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children:
                          List.generate(_detailSpecification.length, (index) {
                        return TextDetailWidget(
                            title: _detailSpecification[index]._title,
                            detail: _detailSpecification[index]._detail);
                      }),
                    ),*/
                    const Divider(),
                    SizedBox(
                      height: 8.w,
                    ),
                    /*fixed lab parameters issue in fiber*/
                    Visibility(
                      visible: _getOfferingVisibility() ?? true,
                      child: Container(
                        child: widget.yarnSpecification != null
                            ? widget.yarnSpecification!.yarnFamilyId != '4'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      widget.yarnSpecification != null
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
                                        itemCount: _labParameters.length,
                                        shrinkWrap: true,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            listDetailItemWidget(
                                                context, _labParameters[index]),
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
                      visible: widget.specObject is! StockLotSpecification,
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
                      visible: widget.specObject is! StockLotSpecification,
                      child: ListView.separated(
                        itemCount: _detailPackaging.length,
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => listDetailItemWidget(
                            context, _detailPackaging[index]),
                      ),
                    ),
                    Visibility(
                      visible: widget.specObject is StockLotSpecification,
                      child: GroupListView(
                        shrinkWrap: true,
                        sectionsCount: _stockLotItems.keys.toList().length,
                        countOfItemInSection: (int section) {
                          return _stockLotItems.values.toList()[section].length;
                        },
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: _itemBuilder,
                        groupHeaderBuilder:
                            (BuildContext context, int section) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TitleTextWidget(
                              title: _stockLotItems.keys
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

                    /*GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 2.77,
                      mainAxisSpacing: 3.w,
                      crossAxisSpacing: 6.w,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(_detailPackaging.length, (index) {
                        return TextDetailWidget(
                            title: _detailPackaging[index]._title,
                            detail: _detailPackaging[index]._detail);
                      }),
                    ),*/
                    Visibility(
                        visible: widget.specObject is! StockLotSpecification,
                        child: Divider()),
                    /* SizedBox(
                      height: 8.w,
                    ),*/
                    /* Visibility(
                      visible: getDescriptionVisibility(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 6.w,
                          ),
                          Text(
                            widget.yarnSpecification != null
                                ? widget.yarnSpecification!.description ??
                                    Utils.checkNullString(false)
                                : widget.specification != null
                                    ? widget.specification!.description ??
                                        Utils.checkNullString(false)
                                    : widget.specObject is FabricSpecification
                                        ? (widget.specObject
                                                    as FabricSpecification)
                                                .description ??
                                            Utils.checkNullString(false)
                                        : "",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),*/
                    /*SizedBox(
                      height: 8.w,
                    ),
                    const TitleSmallTextWidget(title: 'Description'),
                    Container(
                      height: 5 * 22.w,
                      decoration: BoxDecoration(
                          color: tileGreyClr,
                          borderRadius: BorderRadius.all(Radius.circular(4.w))),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w, right: 8.w),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          maxLines: 5,
                          initialValue: widget.specification == null
                              ? widget.yarnSpecification!.description ?? Utils.checkNullString(false)
                              : widget.specification!.description ?? Utils.checkNullString(false),
                          cursorColor: lightBlueTabs,
                          style: TextStyle(fontSize: 11.sp),
                          textAlign: TextAlign.start,
                          cursorHeight: 16.w,
                          showCursor: false,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          */ /*decoration: roundedDescriptionDecoration(
                                "Description")*/ /*
                        ),
                      ),
                    ),*/
                    SizedBox(
                      height: 16.w,
                    ),
                    /*Visibility(
                      visible: _showBidContainer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.all(4.w),
                                        child: Center(
                                          */ /*child: TitleSmallTextWidget(
                                              title: 'Price'),
                                        )*/ /*
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
                                            */ /*fixed price 3 4 digit issue*/ /*
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
                                                      */ /*setState(() {
                                                                value != '' ? bidPrice = int.parse(value) : 0 ;
                                                              });*/ /*
                                                      */ /*if (value == '') {
                                                        priceController.text =
                                                            '0';
                                                        priceController.selection = TextSelection.fromPosition(TextPosition(offset: priceController.text.length));
                                                      }
                                                      //value == '' ? priceController.text = '0' : priceController.text = priceController.text;
                                                      value != ''
                                                          ? _bidPrice =
                                                              int.parse(value.replaceAll(RegExp(r'^0+(?=.)'), ''))
                                                          : _bidPrice = 0;*/ /*
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
                                                    */ /*onSubmitted: (value) {
                                                      setState(() {
                                                        value != ''
                                                            ? _bidPrice =
                                                                int.parse(value)
                                                            : _bidPrice = 0;
                                                      });
                                                    },*/ /*
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
                                          */ /*child: TitleSmallTextWidget(
                                              title: 'Quantity (Kg)')*/ /*
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
                                                */ /*child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: LargeTitleTextWidget(
                                                      title: '$bidQuantity'),
                                                )*/ /*
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
                                                        */ /*setState(() {
                                                          value.isNotEmpty
                                                              ? _bidQuantity =
                                                                  int.parse(
                                                                      value)
                                                              :_bidQuantity = 0;
                                                        });*/ /*

                                                        */ /* if (value == '') {
                                                          quantityController.text =
                                                          '0';
                                                        }
                                                        //value == '' ? priceController.text = '0' : priceController.text = priceController.text;
                                                        value != ''
                                                            ? _bidQuantity =
                                                            int.parse(value)
                                                            : _bidQuantity = 0;*/ /*

                                                        */ /*if(value != ''){
                                                          if(int.parse(value.replaceAll(RegExp(r'^0+(?=.)'), '')) < _minBidQuantity!){
                                                            _bidQuantity = _minBidQuantity;
                                                            quantityController.text = _minBidQuantity.toString().trim();
                                                            quantityController.selection = TextSelection.fromPosition(TextPosition(offset: quantityController.text.length));
                                                          }else{
                                                            _bidQuantity =
                                                                int.parse(value.replaceAll(RegExp(r'^0+(?=.)'), ''));
                                                            quantityController.text = _bidQuantity.toString().trim();
                                                            quantityController.selection = TextSelection.fromPosition(TextPosition(offset: quantityController.text.length));
                                                          }
                                                        }else{
                                                          quantityController.text = _minBidQuantity.toString().trim();
                                                          quantityController.selection = TextSelection.fromPosition(TextPosition(offset: quantityController.text.length));
                                                          _bidQuantity = _minBidQuantity;
                                                        }*/ /*
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
                                                      */ /*onSubmitted: (value) {
                                                        setState(() {
                                                          value != ''
                                                              ? _bidQuantity =
                                                                  int.parse(
                                                                      value)
                                                              : _bidQuantity =
                                                                  0;
                                                        });
                                                        },*/ /*

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
                            ],
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
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),
              flex: 9,
            ),
            /*Visibility(
              visible: _showBidContainer,
              child: ElevatedButtonWithoutIcon(
                  callback: () {
                    FocusScope.of(context).unfocus();
                    */ /*var logger = Logger();
                      logger.e(_bidPrice);
                      logger.e(_bidQuantity);*/ /*
                    if (_bidPrice!.toInt() <= 0) {
                      Ui.showSnackBar(context, "Please enter price");
                    } else if (_bidQuantity!.toInt() <= 0) {
                      Ui.showSnackBar(context, "Please enter quantity");
                    } else if (_bidQuantity!.toInt() < _minBidQuantity!) {
                      Ui.showSnackBar(context,
                          "Please enter minimum quantity ${_minBidQuantity}");
                    } else {
                      showGenericDialog(
                        'Place Bid',
                        "Are you sure, you want to place bid?",
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
                  btnText: 'Place Bid'),
            ),*/
            !_showBidContainer
                ? Visibility(
                    visible: _getOfferingVisibility()?? true,
                    child: ElevatedButtonWithoutIcon(
                        callback: () {
                          widget.yarnSpecification != null
                              ? Utils.updateDialog(
                                  context, widget.yarnSpecification, null, null)
                              : widget.specification != null
                                  ? Utils.updateDialog(
                                      context, null, widget.specification, null)
                                  : (widget.specObject is StockLotSpecification)
                                      ? Fluttertoast.showToast(
                                          msg: 'Delete coming soon')
                                      : Utils.updateDialog(
                                          context,
                                          null,
                                          null,
                                          widget.specObject
                                              as FabricSpecification);
                        },
                        color: (widget.specObject is StockLotSpecification)
                            ? Colors.red.shade400
                            : btnColorLogin,
                        btnText: (widget.specObject is StockLotSpecification)
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
                              widget.specification != null
                                  ? openSpecificationUserScreen(
                                      context,
                                      widget.specification!.spcId.toString(),
                                      widget.specification!.categoryId
                                          .toString())
                                  : widget.yarnSpecification != null
                                      ? openSpecificationUserScreen(
                                          context,
                                          widget.yarnSpecification!.ysId
                                              .toString(),
                                          /*widget.yarnSpecification!.category_id.toString()*/
                                          '2')
                                      : widget.specObject
                                              is StockLotSpecification
                                          ? openSpecificationUserScreen(
                                              context,
                                              (widget.specObject
                                                      as StockLotSpecification)
                                                  .id
                                                  .toString(),
                                              (widget.specObject
                                                      as StockLotSpecification)
                                                  .stocklotCategoryId
                                                  .toString())
                                          : openSpecificationUserScreen(
                                              context,
                                              (widget.specObject
                                                      as FabricSpecification)
                                                  .fsId
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

  bool getDescriptionVisibility() {
    bool visible = true;
    if (widget.yarnSpecification != null) {
      var specification = widget.yarnSpecification as YarnSpecification;
      if (specification.description == null) {
        visible = false;
      } else if (specification.description!.isEmpty) {
        visible = false;
      }
    } else if (widget.specification != null) {
      var specification = widget.specification as Specification;
      if (specification.description == null) {
        visible = false;
      } else if (specification.description!.isEmpty) {
        visible = false;
      }
    } else if (widget.specObject is FabricSpecification) {
      var specification = widget.specObject as FabricSpecification;
      if (specification.description == null) {
        visible = false;
      } else if (specification.description!.isEmpty) {
        visible = false;
      }
    }else if (widget.specObject is StockLotSpecification) {
      var specification = widget.specObject as StockLotSpecification;
      if (specification.description == null) {
        visible = false;
      } else if (specification.description!.isEmpty) {
        visible = false;
      }
    } else {
      visible = false;
    }
    return visible;
  }

  void showProposalBottomSheet(BuildContext context) {
    _bidPrice = _bidPriceFixed;
    _bidQuantity = _bidQuantityFixed;
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
                                              /*child: TitleSmallTextWidget(
                                      title: 'Price'),
                        )*/
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
                                                      if (_bidPrice! >= 1) {
                                                        _bidPrice =
                                                            _bidPrice! - 1;
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
                                                        showCursor: false,
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
                                                          ..text = _bidPrice
                                                                  .toString()
                                                                  .trim()
                                                                  .isNotEmpty
                                                              ? _bidPrice
                                                                  .toString()
                                                              : '0',
                                                        onChanged: (value) {
                                                          if (value != '') {
                                                            _bidPrice = int.parse(
                                                                value.replaceAll(
                                                                    RegExp(
                                                                        r'^0+(?=.)'),
                                                                    ''));
                                                            priceController
                                                                    .text =
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
                                                            priceController
                                                                .text = '0';
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
                                                      _bidPrice =
                                                          _bidPrice! + 1;
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
                                      visible: widget.specObject
                                          is! StockLotSpecification,
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
                                                              if (_bidQuantity! >
                                                                  _tempBidQuantity!) {
                                                                _bidQuantity =
                                                                    _bidQuantity! -
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
                                                                    false,
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
                                                                controller: quantityController
                                                                  ..text =
                                                                      _bidQuantity
                                                                          .toString(),
                                                                onChanged:
                                                                    (value) {
                                                                  if (value !=
                                                                      '') {
                                                                    _bidQuantity =
                                                                        int.parse(value.replaceAll(
                                                                            RegExp(r'^0+(?=.)'),
                                                                            ''));
                                                                    quantityController
                                                                            .text =
                                                                        _bidQuantity
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
                                                                        _minBidQuantity
                                                                            .toString()
                                                                            .trim();
                                                                    quantityController
                                                                            .selection =
                                                                        TextSelection.fromPosition(TextPosition(
                                                                            offset:
                                                                                quantityController.text.length));
                                                                    _bidQuantity =
                                                                        _minBidQuantity;
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
                                                            _bidQuantity =
                                                                _bidQuantity! +
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
                                            _bidRemarks = value;
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
                                    logger.e(_bidPrice);
                                    logger.e(_bidQuantity);
                                    if (_bidPrice!.toInt() <= 0) {
                                      //Ui.showSnackBar(context, "Please enter price");
                                      Fluttertoast.showToast(
                                          msg: "Please enter price");
                                    } else if (widget.specObject == null &&
                                        _bidQuantity == null) {
                                      //Ui.showSnackBar(context, "Please enter quantity");
                                      Fluttertoast.showToast(
                                          msg: "Please enter quantity");
                                    } else if ((widget.specObject
                                            is! StockLotSpecification) &&
                                        _bidQuantity != null &&
                                        _bidQuantity!.toInt() <
                                            _minBidQuantity!) {
                                      /*Ui.showSnackBar(context,
                                            "Please enter minimum quantity ${_minBidQuantity}");*/
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please enter minimum quantity $_minBidQuantity");
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

  bool? _getOfferingVisibility() {
    if (widget.specification != null) {
      return widget.specification!.is_offering == offering_type;
    } else if (widget.yarnSpecification != null) {
      return widget.yarnSpecification!.is_offering == offering_type;
    } else if (widget.specObject is FabricSpecification) {
      return (widget.specObject as FabricSpecification).isOffering ==
          offering_type;
    } else {
      return true;
    }
  }

  void placeBid(BuildContext context) {
    ProgressDialogUtil.showDialog(context, "Please wait....");
    ApiService.createBid(
            widget.yarnSpecification != null
                ? 2.toString()
                : widget.specification != null
                    ? widget.specification!.categoryId.toString()
                    : widget.specObject is StockLotSpecification
                        ? (widget.specObject as StockLotSpecification)
                            .stocklotCategoryId
                            .toString()
                        : 3.toString(),
            widget.yarnSpecification != null
                ? widget.yarnSpecification!.ysId.toString()
                : widget.specification != null
                    ? widget.specification!.spcId.toString()
                    : widget.specObject is StockLotSpecification
                        ? (widget.specObject as StockLotSpecification)
                            .id
                            .toString()
                        : (widget.specObject as FabricSpecification)
                            .fsId
                            .toString(),
            _bidPrice.toString(),
            _bidQuantity.toString(),
            _bidRemarks)
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

  _fiberDetails() {
    _detailSpecification = [
      GridTileModel('Fiber Material',
          widget.specification!.material ?? Utils.checkNullString(false)),
      GridTileModel(
          'Fiber Length',
          widget.specification!.length != null
              ? '${widget.specification!.length} mm'
              : Utils.checkNullString(false)),
      GridTileModel(
          'Micronaire',
          widget.specification!.micronaire != null
              ? '${widget.specification!.micronaire!} mic'
              : Utils.checkNullString(false)),
      GridTileModel(
          'Moisture',
          widget.specification!.moisture != null
              ? '${widget.specification!.moisture!} '
              : Utils.checkNullString(false)),
      GridTileModel(
          'Trash',
          widget.specification!.trash != null
              ? widget.specification!.trash!
              : Utils.checkNullString(false)),
      GridTileModel(
          'RD',
          widget.specification!.rd != null
              ? widget.specification!.rd!
              : Utils.checkNullString(false)),
      GridTileModel(
          'GPT',
          widget.specification!.gpt != null
              ? widget.specification!.gpt!
              : Utils.checkNullString(false)),
      GridTileModel(
          'Appearance',
          widget.specification!.apperance == null
              ? Utils.checkNullString(false)
              : widget.specification!.apperance!),
      GridTileModel(
          'Brand',
          widget.specification!.brand == null
              ? Utils.checkNullString(false)
              : widget.specification!.brand!),
      GridTileModel(
          'Production year',
          widget.specification!.productYear == null
              ? Utils.checkNullString(false)
              : widget.specification!.productYear!),
      GridTileModel(
          'Origin',
          widget.specification!.origin == null
              ? Utils.checkNullString(false)
              : widget.specification!.origin!),
      GridTileModel(
          'Certification',
          widget.specification!.certification == null
              ? Utils.checkNullString(false)
              : widget.specification!.certification!),
    ];
    var newSpecifications = _detailSpecification.toList();
    _detailSpecification = newSpecifications
        .where((element) =>
            element._detail.isNotEmpty &&
            element._detail.toUpperCase() != "N/A")
        .toList();
    // labParameters = [
    //   GridTileModel(
    //       'Unit Of Count',
    //       widget.specification!.unitCount == null
    //           ? Utils.checkNullString(false)
    //           : widget.specification!.unitCount!),
    //   GridTileModel(
    //       'Price',
    //       widget.specification!.priceUnit == null
    //           ? Utils.checkNullString(false)
    //           : widget.specification!.priceUnit!),
    //   GridTileModel(
    //       'Packing',
    //       widget.specification!.priceTerms == null
    //           ? Utils.checkNullString(false)
    //           : widget.specification!.priceTerms!)
    // ];

    _detailPackaging = [
      GridTileModel(
          'Unit of Counting',
          widget.specification!.unitCount == null
              ? Utils.checkNullString(false)
              : widget.specification!.unitCount!),
      // GridTileModel('Seller Location',
      //     widget.specification!.locality ?? Utils.checkNullString(false)),
      /*GridTileModel(
          'Country',
          widget.specification!.country == null
              ? Utils.checkNullString(false)
              : widget.specification!.country!),*/
      GridTileModel(
          'Price Terms',
          widget.specification!.priceTerms == null
              ? Utils.checkNullString(false)
              : widget.specification!.priceTerms!),
      /*GridTileModel(
          'Payment Type',
          widget.specification!.paymentType == null
              ? Utils.checkNullString(false)
              : widget.specification!.paymentType!),*/
      /* GridTileModel(
          'LC Type',
          widget.specification!.lcType == null
              ? Utils.checkNullString(false)
              : widget.specification!.lcType!),*/
      GridTileModel(
          'Price',
          widget.specification!.priceUnit == null
              ? Utils.checkNullString(false)
              : widget.specification!.priceUnit!),
      GridTileModel(
          'Available Quantity',
          widget.specification!.available == null
              ? Utils.checkNullString(false)
              : widget.specification!.available!),
      GridTileModel(
          'Delivery Period',
          widget.specification!.deliveryPeriod == null
              ? Utils.checkNullString(false)
              : widget.specification!.deliveryPeriod!),
      GridTileModel(
          'Minimum Quantity',
          widget.specification!.minQuantity == null
              ? Utils.checkNullString(false)
              : widget.specification!.minQuantity!),
    ];
    if (widget.specification!.locality!.toUpperCase() == international) {
      _detailPackaging.add(GridTileModel(
          'Port',
          widget.specification!.port == null
              ? Utils.checkNullString(false)
              : widget.specification!.port!));
    }
    var newPackingDetails = _detailPackaging.toList();
    _detailPackaging = newPackingDetails
        .where((element) =>
            element._detail.isNotEmpty &&
            element._detail.toUpperCase() != "N/A")
        .toList();
  }

  _fabricDetails() {
    var fabricSpec = (widget.specObject as FabricSpecification);
    _detailSpecification = [
      GridTileModel('Fabric Family',
          fabricSpec.fabricFamily ?? Utils.checkNullString(false)),
      GridTileModel('Blends Formation',
          fabricSpec.formationDisplayText ?? Utils.checkNullString(false)),
      GridTileModel('Count', fabricSpec.count ?? Utils.checkNullString(false)),
      GridTileModel(
          'Ply', fabricSpec.fabricPly ?? Utils.checkNullString(false)),
      GridTileModel('GSM', fabricSpec.gsmCount ?? Utils.checkNullString(false)),
      GridTileModel('Once', fabricSpec.once ?? Utils.checkNullString(false)),
      GridTileModel(
          'Wrap Count', fabricSpec.warpCount ?? Utils.checkNullString(false)),
      GridTileModel('Wrap Ply',
          fabricSpec.fabricWarpPlyName ?? Utils.checkNullString(false)),
      GridTileModel('No of Ends(Warp)',
          fabricSpec.noOfEndsWarp ?? Utils.checkNullString(false)),
      GridTileModel(
          'Weft Count', fabricSpec.weftCount ?? Utils.checkNullString(false)),
      GridTileModel('Weft Ply',
          fabricSpec.fabricWeftPlyName ?? Utils.checkNullString(false)),
      GridTileModel('No of Picks(Weft)',
          fabricSpec.noOfPickWeft ?? Utils.checkNullString(false)),
      GridTileModel('Type of Denim',
          fabricSpec.fabricDenimTypeName ?? Utils.checkNullString(false)),
      GridTileModel('Knitting Type',
          fabricSpec.fabricKnittingTypeName ?? Utils.checkNullString(false)),
      GridTileModel('Layyer',
          fabricSpec.fabricLayyerName ?? Utils.checkNullString(false)),
      GridTileModel(
          'Loom', fabricSpec.fabricLoomName ?? Utils.checkNullString(false)),
      GridTileModel('Width', fabricSpec.width == null ? Utils.checkNullString(false):'${fabricSpec.width} inch'),
      GridTileModel('Salvedge',
          fabricSpec.fabricSalvedgeName ?? Utils.checkNullString(false)),
      GridTileModel('Tucking Width',
          fabricSpec.tuckinWidth == null ? Utils.checkNullString(false):'${fabricSpec.tuckinWidth} mm'),
      GridTileModel(
          'Weave', fabricSpec.fabricWeaveName ?? Utils.checkNullString(false)),
      GridTileModel('Weave Pattern',
          fabricSpec.fabricWeavePatternName ?? Utils.checkNullString(false)),
      GridTileModel(
          'Color Treatment Method',
          fabricSpec.fabricColorTreatmentMethod ??
              Utils.checkNullString(false)),
      GridTileModel('Dying Technique',
          fabricSpec.fabricDyingTechnique ?? Utils.checkNullString(false)),
      GridTileModel('Color', fabricSpec.color ?? Utils.checkNullString(false)),
      GridTileModel('Appearance',
          fabricSpec.fabricApperance ?? Utils.checkNullString(false)),
      GridTileModel(
          'Quality', fabricSpec.fabricQuality ?? Utils.checkNullString(false)),
      GridTileModel(
          'Grade', fabricSpec.fabricGrade ?? Utils.checkNullString(false)),
      GridTileModel('Certification',
          fabricSpec.certificationStr ?? Utils.checkNullString(false)),
    ];
    /*_detailSpecification.add(formatFormations(fabricSpec.formation!));*/
    var newSpecifications = _detailSpecification.toList();
    _detailSpecification = newSpecifications
        .where((element) =>
            element._detail.isNotEmpty &&
            element._detail.toUpperCase() != "N/A")
        .toList();

    /* _detailPackaging = [
      GridTileModel('Unit of Counting',
          fabricSpec.unitCount ?? Utils.checkNullString(false)),
      // GridTileModel('Seller Location', fabricSpec.locality ?? Utils.checkNullString(false)),
      GridTileModel(
          'Price Terms', fabricSpec.priceTerms ?? Utils.checkNullString(false)),
      GridTileModel(
          'Price', fabricSpec.priceUnit ?? Utils.checkNullString(false)),
      GridTileModel('Available Quantity',
          fabricSpec.available ?? Utils.checkNullString(false)),
      GridTileModel('Delivery Period',
          fabricSpec.deliveryPeriod ?? Utils.checkNullString(false)),
      GridTileModel('Minimum Quantity',
          fabricSpec.minQuantity ?? Utils.checkNullString(false)),
    ];*/
    _detailPackaging = [
      GridTileModel(
          'Unit of Counting',
          fabricSpec.unitCount == null
              ? Utils.checkNullString(false)
              : fabricSpec.unitCount ?? ""),
      GridTileModel('Packing',
          fabricSpec.fpb_cone_type_name ?? Utils.checkNullString(false)),
      GridTileModel(
          'Cones/Bags',
          fabricSpec.conesBag == null
              ? Utils.checkNullString(false)
              : fabricSpec.conesBag!),
      GridTileModel(
          'Weight/Bags',
          fabricSpec.weightBag == null
              ? Utils.checkNullString(false)
              : fabricSpec.weightBag!),
      GridTileModel(
          'Price Terms',
          fabricSpec.priceTerms == null
              ? Utils.checkNullString(false)
              : fabricSpec.priceTerms!),
      GridTileModel(
          'Price',
          fabricSpec.priceUnit == null
              ? Utils.checkNullString(false)
              : fabricSpec.priceUnit!),
      GridTileModel(
          'Delivery Period',
          fabricSpec.deliveryPeriod == null
              ? Utils.checkNullString(false)
              : fabricSpec.deliveryPeriod!),
      GridTileModel(
          'Available Quantity',
          fabricSpec.available == null
              ? Utils.checkNullString(false)
              : fabricSpec.available!),
      GridTileModel(
          'Minimum Quantity',
          fabricSpec.minQuantity == null
              ? Utils.checkNullString(false)
              : fabricSpec.minQuantity!),
      GridTileModel(
          'Country',
          fabricSpec.fabricCountry == null
              ? Utils.checkNullString(false)
              : fabricSpec.fabricCountry!),
      GridTileModel(
          'Port', fabricSpec.portName ?? Utils.checkNullString(false)),
      GridTileModel(
          'Payment Type',
          fabricSpec.paymentType == null
              ? Utils.checkNullString(false)
              : fabricSpec.paymentType!),
      GridTileModel('Description',
          fabricSpec.description ?? Utils.checkNullString(false)),
    ];
    if (fabricSpec.locality!.toUpperCase() == international) {
      _detailPackaging.add(GridTileModel('Port', 'fabricSpec.port'));
    }
    var newPackingDetails = _detailPackaging.toList();
    _detailPackaging = newPackingDetails
        .where((element) =>
            element._detail.isNotEmpty &&
            element._detail.toUpperCase() != "N/A")
        .toList();
  }

  _yarnDetails() {
    _detailSpecification = [
      GridTileModel('Yarn Family',
          widget.yarnSpecification!.yarnFamily ?? Utils.checkNullString(false)),
      GridTileModel('Blends Formation',
          widget.yarnSpecification!.formationDisplayText ?? Utils.checkNullString(false)),
      GridTileModel('Yarn Usage',
          widget.yarnSpecification!.yarnUsage ?? Utils.checkNullString(false)),
      GridTileModel(
          'Count',
          widget.yarnSpecification!.count != null
              ? '${widget.yarnSpecification!.count}'
              : Utils.checkNullString(false)),
      GridTileModel(
          'Ply',
          widget.yarnSpecification!.yarnPly == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.yarnPly!),
      GridTileModel(
          'Doubling Method',
          widget.yarnSpecification!.doublingMethod == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.doublingMethod!),
      GridTileModel(
          'Orientation',
          widget.yarnSpecification!.yarnOrientation == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.yarnOrientation!),
      GridTileModel(
          'Color Treatment Method',
          widget.yarnSpecification!.yarnColorTreatmentMethod == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.yarnColorTreatmentMethod!),
      GridTileModel(
          'Dying Method',
          widget.yarnSpecification!.yarnDyingMethod == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.yarnDyingMethod!),
      GridTileModel(
          'Color',
          widget.yarnSpecification!.color == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.color!),
      GridTileModel(
          'Spun Technique',
          widget.yarnSpecification!.yarnSpunTechnique == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.yarnSpunTechnique!),
      GridTileModel(
          'Quality',
          widget.yarnSpecification!.yarnQuality == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.yarnQuality!),
      GridTileModel(
          'Yarn Appearance',
          widget.yarnSpecification!.yarnApperance ??
              Utils.checkNullString(false)),
      GridTileModel('Yarn Grade',
          widget.yarnSpecification!.yarnGrade ?? Utils.checkNullString(false)),
      GridTileModel(
          'Pattern',
          widget.yarnSpecification!.yarnPattern == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.yarnPattern!),
      GridTileModel(
          'Pattern Characteristics',
          widget.yarnSpecification!.yarnPatternCharectristic == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.yarnPatternCharectristic!),
      GridTileModel(
          'Yarn Certification',
          widget.yarnSpecification!.yarnCertificationStr ??
              Utils.checkNullString(false)),
    ];
    /*_detailSpecification
        .add(formatFormations(widget.yarnSpecification!.yarnFormation!));*/
    var newSpecifications = _detailSpecification.toList();
    _detailSpecification = newSpecifications
        .where((element) =>
            element._detail.isNotEmpty &&
            element._detail.toUpperCase() != "N/A")
        .toList();

    _labParameters = [
      GridTileModel(
          'Actual Yarn Count',
          widget.yarnSpecification!.actualYarnCount == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.actualYarnCount!),
      GridTileModel(
          'CLSP',
          widget.yarnSpecification!.clsp == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.clsp!),
      GridTileModel(
          'IPM/KM',
          widget.yarnSpecification!.ys_ipm_km == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.ys_ipm_km!),
      GridTileModel(
          'Thin Places',
          widget.yarnSpecification!.thinPlaces == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.thinPlaces!),
      GridTileModel(
          'Thick Places',
          widget.yarnSpecification!.thickPlaces == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.thickPlaces!),
      GridTileModel(
          'Naps',
          widget.yarnSpecification!.naps == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.naps!),
      GridTileModel(
          'Uniformity',
          widget.yarnSpecification!.uniformity == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.uniformity!),
      GridTileModel(
          'CV',
          widget.yarnSpecification!.cv == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.cv!),
      GridTileModel(
          'Hairness',
          widget.yarnSpecification!.ys_hairness == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.ys_hairness!),
      GridTileModel(
          'RKM',
          widget.yarnSpecification!.ys_rkm == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.ys_rkm!),
      GridTileModel(
          'Elongation',
          widget.yarnSpecification!.ys_elongation == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.ys_elongation!),
      GridTileModel(
          'TPI',
          widget.yarnSpecification!.ys_tpi == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.ys_tpi!),
      GridTileModel(
          'TM',
          widget.yarnSpecification!.ys_tm == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.ys_tm!),
    ];
    var newLabParams = _labParameters.toList();
    _labParameters = newLabParams
        .where((element) =>
            element._detail.isNotEmpty &&
            element._detail.toUpperCase() != "N/A")
        .toList();

    _detailPackaging = [
      GridTileModel(
          'Unit of Counting',
          widget.yarnSpecification!.unitCount == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.unitCount!),
      GridTileModel(
          'Packing',
          widget.yarnSpecification!.fpb_cone_type_name ??
              Utils.checkNullString(false)),
      GridTileModel(
          'Cones/Bags',
          widget.yarnSpecification!.conesBag == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.conesBag!),
      GridTileModel(
          'Weight/Bags',
          widget.yarnSpecification!.weightBag == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.weightBag!),
      GridTileModel(
          'Price Terms',
          widget.yarnSpecification!.priceTerms == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.priceTerms!),
      GridTileModel(
          'Price',
          widget.yarnSpecification!.priceUnit == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.priceUnit!),
      GridTileModel(
          'Delivery Period',
          widget.yarnSpecification!.deliveryPeriod == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.deliveryPeriod!),
      GridTileModel(
          'Available Quantity',
          widget.yarnSpecification!.available == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.available!),
      GridTileModel(
          'Minimum Quantity',
          widget.yarnSpecification!.minQuantity == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.minQuantity!),
      GridTileModel(
          'Country',
          widget.yarnSpecification!.yarn_country == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.yarn_country!),
      GridTileModel('Port',
          widget.yarnSpecification!.port ?? Utils.checkNullString(false)),
      GridTileModel(
          'Payment Type',
          widget.yarnSpecification!.paymentType == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.paymentType!),
      GridTileModel(
          'Description',
          widget.yarnSpecification!.description ??
              Utils.checkNullString(false)),
    ];
    if (widget.yarnSpecification!.locality!.toUpperCase() == international) {
      _detailPackaging.add(GridTileModel(
          'Port',
          widget.yarnSpecification!.port == null
              ? Utils.checkNullString(false)
              : widget.yarnSpecification!.port!));
    }
    var newPackingDetails = _detailPackaging.toList();
    _detailPackaging = newPackingDetails
        .where((element) =>
            element._detail.isNotEmpty &&
            element._detail.toUpperCase() != "N/A")
        .toList();
  }

  _stockLotDetails() {
    _detailSpecification = [
      GridTileModel(
          'Waste',
          (widget.specObject as StockLotSpecification).stocklotParentFamilyName ??
              Utils.checkNullString(false)),
      GridTileModel(
          'Category',
          (widget.specObject as StockLotSpecification).spc_category_name ??
              Utils.checkNullString(false)),
      GridTileModel(
          'Price Terms',
          (widget.specObject as StockLotSpecification).priceTerm != null
              ? '${(widget.specObject as StockLotSpecification).priceTerm} '
              : Utils.checkNullString(false)),
      GridTileModel(
          'Availability',
          (widget.specObject as StockLotSpecification).availablity != null
              ? '${(widget.specObject as StockLotSpecification).availablity}'
              : Utils.checkNullString(false)),
      GridTileModel(
          'Country',
          (widget.specObject as StockLotSpecification).country_name ??
              Utils.checkNullString(false)),
      GridTileModel(
          'Port',
          (widget.specObject as StockLotSpecification).port_name ??
              Utils.checkNullString(false)),
      GridTileModel(
          'Description',
          (widget.specObject as StockLotSpecification).description ??
              Utils.checkNullString(false)),
    ];
    var newSpecifications = _detailSpecification.toList();
    _detailSpecification = newSpecifications
        .where((element) =>
            element._detail.isNotEmpty &&
            element._detail.toUpperCase() != "N/A")
        .toList();

    for (var element
        in (widget.specObject as StockLotSpecification).specDetails!) {
      _detailPackaging = [];
      _detailPackaging.add(GridTileModel(
          'Quantity',
          element.quantity != null
              ? '${element.quantity} '
              : Utils.checkNullString(false)));

      _detailPackaging.add(GridTileModel(
          'Price',
          element.price != null
              ? '${element.price} '
              : Utils.checkNullString(false)));

      _detailPackaging.add(GridTileModel(
          'Price Unit',
          element.priceUnit != null
              ? '${element.priceUnit!.split(" ").first} '
              : Utils.checkNullString(false)));

      _stockLotItems[element.subCategory.toString()] = _detailPackaging;
    }

    var newPackingDetails = _detailPackaging.toList();
    _detailPackaging = newPackingDetails
        .where((element) =>
            element._detail.isNotEmpty &&
            element._detail.toUpperCase() != "N/A")
        .toList();
  }

  Future<String?> _getUserId() async {
    return await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
  }

  Widget _itemBuilder(BuildContext context, IndexPath index) {
    GridTileModel details =
        _stockLotItems.values.toList()[index.section][index.index];
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

  GridTileModel formatFormations(List<GenericFormation> yarnFormation) {
    GridTileModel formationTileModel;
    switch (yarnFormation.length) {
      case 1:
        if (yarnFormation.first.formationRatio == "100") {
          formationTileModel = GridTileModel('Blends Formation', '');
        } else {
          formationTileModel = GridTileModel('Blends Formation',
              "${yarnFormation.first.blendName} :${yarnFormation.first.formationRatio}");
        }
        break;
      case 2:
        formationTileModel = GridTileModel(
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
        formationTileModel = GridTileModel(
            'Blends Formation', blendString ?? Utils.checkNullString(false));
        break;
    }
    return formationTileModel;
  }
}

class GridTileModel {
  String _title;
  String _detail;

  GridTileModel(this._title, this._detail);

  String get detail => _detail;

  set detail(String value) {
    _detail = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}
