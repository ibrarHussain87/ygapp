import 'package:fitted_text_field_container/fitted_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/list_widgets/list_detail_item_widget.dart';
import 'package:yg_app/elements/text_detail_widget_.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';
import 'package:yg_app/helper_utils/shared_pref_util.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/model/response/yarn_response/yarn_specification_response.dart';

class DetailTabPage extends StatefulWidget {
  final Specification? specification;
  final YarnSpecification? yarnSpecification;

  const DetailTabPage({Key? key, this.specification, this.yarnSpecification})
      : super(key: key);

  @override
  _DetailTabPageState createState() => _DetailTabPageState();
}

class _DetailTabPageState extends State<DetailTabPage> {
  List<GridTileModel> _detailSpecification = [];
  List<GridTileModel> _labParameters = [];
  List<GridTileModel> _detailPackaging = [];
  int? _bidPrice;
  int? _bidQuantity;
  int? _tempBidQuantity;
  String _bidRemarks = "";
  bool _showBidContainer = false;
  bool _isChanged = false;
  String? _userId;

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
        _bidPrice = int.parse(widget.yarnSpecification!.priceUnit!
            .replaceAll(RegExp(r'[^0-9]'), ''));
      }
      _bidQuantity = _isYarn()
          ? int.parse(widget.yarnSpecification!.minQuantity!)
          : int.parse(widget.specification!.minQuantity!);

      if (!_isChanged) {
        _tempBidQuantity = _isYarn()
            ? int.parse(widget.yarnSpecification!.minQuantity!)
            : int.parse(widget.specification!.minQuantity!);
        _isChanged = true;
      }
    });

    widget.specification != null ? _fiberDetails() : _yarnDetails();

    _getUserId().then((value) {
      _userId = value;
      if (widget.specification != null) {
        if (value != widget.specification!.spc_user_id) {
          setState(() {
            _showBidContainer = true;
          });
        }
      } else {
        if (value != widget.yarnSpecification!.ys_user_id) {
          setState(() {
            _showBidContainer = true;
          });
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.yarnSpecification != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.yarnSpecification != null
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 4.w,
                                        ),
                                        TitleTextWidget(
                                          title: 'Lab Parameters'.toUpperCase(),
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
                                separatorBuilder: (BuildContext context, int index) =>
                                const Divider(),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => listDetailItemWidget(
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
                        : SizedBox(
                            height: 4.w,
                          ),
                    SizedBox(
                      height: 8.w,
                    ),
                     TitleTextWidget(title: 'Packing Details'.toUpperCase(),
                      color: titleColor,),
                    SizedBox(
                      height: 12.w,
                    ),
                    ListView.separated(
                      itemCount: _detailPackaging.length,
                      shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => listDetailItemWidget(
                          context, _detailPackaging[index]),
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
                    Divider(),
                   /* SizedBox(
                      height: 8.w,
                    ),*/
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
                      widget.specification == null
                          ? widget.yarnSpecification!.description ?? "N/A"
                          : widget.specification!.description ?? "N/A",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
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
                              ? widget.yarnSpecification!.description ?? "N/A"
                              : widget.specification!.description ?? "N/A",
                          cursorColor: lightBlueTabs,
                          style: TextStyle(fontSize: 11.sp),
                          textAlign: TextAlign.start,
                          cursorHeight: 16.w,
                          showCursor: false,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          *//*decoration: roundedDescriptionDecoration(
                                "Description")*//*
                        ),
                      ),
                    ),*/
                    SizedBox(
                      height: 16.w,
                    ),
                    Visibility(
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
                                        child: const Center(
                                          child: TitleSmallTextWidget(
                                              title: 'Price'),
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
                                                  vertical: 8.w,
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
                                                    controller:
                                                        TextEditingController()
                                                          ..text = _bidPrice
                                                              .toString(),
                                                    /*onChanged: (value){
                                                              setState(() {
                                                                value != '' ? bidPrice = int.parse(value) : 0 ;
                                                              });
                                                            },*/
                                                    onSubmitted: (value) {
                                                      setState(() {
                                                        value != ''
                                                            ? _bidPrice =
                                                                int.parse(value)
                                                            : _bidPrice = 0;
                                                      });
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
                                      child: const Center(
                                          child: TitleSmallTextWidget(
                                              title: 'Quantity (Kg)')),
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
                                                  vertical: 8.w,
                                                  horizontal: 3.w),
                                              child: Center(
                                                /*child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: LargeTitleTextWidget(
                                                      title: '$bidQuantity'),
                                                )*/
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
                                                          TextEditingController()
                                                            ..text =
                                                                _bidQuantity
                                                                    .toString(),
                                                      // onChanged: (value) {
                                                      //   setState(() {
                                                      //     value.isNotEmpty
                                                      //         ? _bidQuantity =
                                                      //             int.parse(
                                                      //                 value)
                                                      //         :_bidQuantity = 0;
                                                      //   });
                                                      // },
                                                      onSubmitted: (value) {
                                                        setState(() {
                                                          value != ''
                                                              ? _bidQuantity =
                                                                  int.parse(
                                                                      value)
                                                              : _bidQuantity =
                                                                  0;
                                                        });
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
                            ],
                          ),
                          SizedBox(
                            height: 12.w,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child:
                                  const TitleSmallTextWidget(title: 'Remarks')),
                          SizedBox(
                            height: 2.w,
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
                                    roundedDescriptionDecoration("Remarks")),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              flex: 9,
            ),
            Visibility(
              visible: _showBidContainer,
              child: ElevatedButtonWithoutIcon(
                  callback: () {
                    if (_bidPrice!.toInt() <= 0) {
                      Ui.showSnackBar(context, "Please enter price");
                    } else if (_bidQuantity!.toInt() <= 0) {
                      Ui.showSnackBar(context, "Please enter quantity");
                    } else {
                      ProgressDialogUtil.showDialog(context, "Please wait....");
                      ApiService.createBid(
                              widget.specification == null
                                  ? 2.toString()
                                  : widget.specification!.categoryId.toString(),
                              widget.specification == null
                                  ? widget.yarnSpecification!.specId.toString()
                                  : widget.specification!.spcId.toString(),
                              _bidPrice.toString(),
                              _bidQuantity.toString(),
                              _bidRemarks)
                          .then((value) {
                        ProgressDialogUtil.hideDialog();
                        Ui.showSnackBar(context, value.message);
                      }, onError: (stacktrace, error) {
                        ProgressDialogUtil.hideDialog();
                        Ui.showSnackBar(context, error.message.toString());
                      });
                    }
                  },
                  color: btnColorLogin,
                  btnText: 'Place Bid'),
            ),
          ],
        ),
      ),
    );
  }

  _fiberDetails() {
    _detailSpecification = [
      GridTileModel('Fiber Material', widget.specification!.material ?? "N/A"),
      GridTileModel(
          'Fiber Length',
          widget.specification!.length != null
              ? '${widget.specification!.length} mm'
              : 'N/A'),
      GridTileModel(
          'Micronaire',
          widget.specification!.micronaire != null
              ? '${widget.specification!.micronaire!} mic'
              : "N/A"),
      GridTileModel(
          'Moisture',
          widget.specification!.moisture != null
              ? '${widget.specification!.moisture!} '
              : "N/A"),
      GridTileModel(
          'Trash',
          widget.specification!.trash != null
              ? widget.specification!.trash!
              : "N/A"),
      GridTileModel('RD',
          widget.specification!.rd != null ? widget.specification!.rd! : 'N/A'),
      GridTileModel(
          'GPT',
          widget.specification!.gpt != null
              ? widget.specification!.gpt!
              : 'N/A'),
      GridTileModel(
          'Appearance',
          widget.specification!.apperance == null
              ? "N/A"
              : widget.specification!.apperance!),
      GridTileModel(
          'Brand',
          widget.specification!.brand == null
              ? "N/A"
              : widget.specification!.brand!),
      GridTileModel(
          'Production year',
          widget.specification!.productYear == null
              ? "N/A"
              : widget.specification!.productYear!),
      GridTileModel(
          'Origin',
          widget.specification!.origin == null
              ? "N/A"
              : widget.specification!.origin!),
      GridTileModel(
          'Certification',
          widget.specification!.certification == null
              ? "N/A"
              : widget.specification!.certification!),
    ];

    // labParameters = [
    //   GridTileModel(
    //       'Unit Of Count',
    //       widget.specification!.unitCount == null
    //           ? "N/A"
    //           : widget.specification!.unitCount!),
    //   GridTileModel(
    //       'Price',
    //       widget.specification!.priceUnit == null
    //           ? "N/A"
    //           : widget.specification!.priceUnit!),
    //   GridTileModel(
    //       'Packing',
    //       widget.specification!.priceTerms == null
    //           ? "N/A"
    //           : widget.specification!.priceTerms!)
    // ];

    _detailPackaging = [
      // GridTileModel(
      //     'Unit Of Count',
      //     widget.specification!.unitCount == null
      //         ? "N/A"
      //         : widget.specification!.unitCount!),
      GridTileModel(
          'Price',
          widget.specification!.priceUnit == null
              ? "N/A"
              : widget.specification!.priceUnit!),
      GridTileModel(
          'Packing',
          widget.specification!.priceTerms == null
              ? "N/A"
              : widget.specification!.priceTerms!),
      GridTileModel(
          'Minimum Quantity',
          widget.specification!.minQuantity == null
              ? "N/A"
              : widget.specification!.minQuantity!),
      GridTileModel('Seller Location', widget.specification!.unitCount ?? "N/A")
    ];
  }

  _yarnDetails() {
    String? familyId = widget.yarnSpecification!.yarnFamilyId;
    switch (familyId) {
      case '1':
        _detailSpecification = [
          GridTileModel(
              'Yarn Family', widget.yarnSpecification!.yarnFamily ?? "N/A"),
          GridTileModel(
              'Yarn Usage', widget.yarnSpecification!.yarnUsage ?? "N/A"),
          /*GridTileModel('Yarn Appearance',
              widget.yarnSpecification!.yarnApperance ?? "N/A"),*/
          GridTileModel(
              'Count',
              widget.yarnSpecification!.count != null
                  ? '${widget.yarnSpecification!.count}'
                  : "N/A"),
          /*GridTileModel(
              'Ratio',
              widget.yarnSpecification!.yarnRtio != null
                  ? widget.yarnSpecification!.yarnRtio!
                  : "N/A"),*/
          /*GridTileModel(
              'Filament',
              widget.yarnSpecification!.fdyFilament != null
                  ? widget.yarnSpecification!.fdyFilament!
                  : 'N/A'),*/
          /*GridTileModel(
              'Dianner',
              widget.yarnSpecification!.dtyFilament != null
                  ? widget.yarnSpecification!.dtyFilament!
                  : 'N/A'),*/
          GridTileModel(
              'Quality',
              widget.yarnSpecification!.yarnQuality == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnQuality!),
          GridTileModel(
              'Ply',
              widget.yarnSpecification!.yarnPly == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPly!),
          GridTileModel(
              'Doubling Method',
              widget.yarnSpecification!.doublingMethod == null
                  ? "N/A"
                  : widget.yarnSpecification!.doublingMethod!),
          GridTileModel(
              'Orientation',
              widget.yarnSpecification!.yarnOrientation == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnOrientation!),
          GridTileModel(
              'Spun Technique',
              widget.yarnSpecification!.yarnSpunTechnique == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnSpunTechnique!),
          GridTileModel(
              'Pattern',
              widget.yarnSpecification!.yarnPattern == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPattern!),
          GridTileModel(
              'Pattern Characteristics',
              widget.yarnSpecification!.yarnPatternCharectristic == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPatternCharectristic!),
          GridTileModel(
              'Color Treatment Method',
              widget.yarnSpecification!.yarnColorTreatmentMethod == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnColorTreatmentMethod!),
          /*GridTileModel(
              'Certification',
              (widget.yarnSpecification!.yarnCertificationStr == null ||
                      widget.yarnSpecification!.yarnCertificationStr!.isEmpty)
                  ? "N/A"
                  : widget.yarnSpecification!.yarnCertificationStr!
                      .replaceAll(",", "")),*/
        ];
        break;
      case '2':
        _detailSpecification = [
          GridTileModel(
              'Yarn Family', widget.yarnSpecification!.yarnFamily ?? "N/A"),
          GridTileModel(
              'Yarn Usage', widget.yarnSpecification!.yarnUsage ?? "N/A"),
          GridTileModel('Blend', widget.yarnSpecification!.yarnBlend ?? "N/A"),
          GridTileModel(
              'Count',
              widget.yarnSpecification!.count != null
                  ? '${widget.yarnSpecification!.count}'
                  : "N/A"),
          GridTileModel(
              'Ratio',
              widget.yarnSpecification!.yarnRtio != null
                  ? widget.yarnSpecification!.yarnRtio!
                  : "N/A"),
          GridTileModel(
              'Ply',
              widget.yarnSpecification!.yarnPly == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPly!),
          GridTileModel(
              'Orientation',
              widget.yarnSpecification!.yarnOrientation == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnOrientation!),
          GridTileModel(
              'Pattern',
              widget.yarnSpecification!.yarnPattern == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPattern!),
          GridTileModel(
              'Pattern Characteristics',
              widget.yarnSpecification!.yarnPatternCharectristic == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPatternCharectristic!),
          GridTileModel(
              'Color Treatment Method',
              widget.yarnSpecification!.yarnColorTreatmentMethod == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnColorTreatmentMethod!),
        ];
        break;
      case '3':
        _detailSpecification = [
          GridTileModel(
              'Yarn Family', widget.yarnSpecification!.yarnFamily ?? "N/A"),
          GridTileModel(
              'Yarn Usage', widget.yarnSpecification!.yarnUsage ?? "N/A"),
          GridTileModel(
              'Count',
              widget.yarnSpecification!.count != null
                  ? '${widget.yarnSpecification!.count}'
                  : "N/A"),
          GridTileModel(
              'Ply',
              widget.yarnSpecification!.yarnPly == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPly!),
          GridTileModel(
              'Orientation',
              widget.yarnSpecification!.yarnOrientation == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnOrientation!),
          GridTileModel(
              'Doubling Method',
              widget.yarnSpecification!.doublingMethod == null
                  ? "N/A"
                  : widget.yarnSpecification!.doublingMethod!),
          GridTileModel(
              'Spun Technique',
              widget.yarnSpecification!.yarnSpunTechnique == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnSpunTechnique!),
          GridTileModel(
              'Pattern',
              widget.yarnSpecification!.yarnPattern == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPattern!),
          GridTileModel(
              'Pattern Characteristics',
              widget.yarnSpecification!.yarnPatternCharectristic == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPatternCharectristic!),
          GridTileModel(
              'Color Treatment Method',
              widget.yarnSpecification!.yarnColorTreatmentMethod == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnColorTreatmentMethod!),
        ];
        break;
      case '4':
        _detailSpecification = [
          GridTileModel(
              'Yarn Family', widget.yarnSpecification!.yarnFamily ?? "N/A"),
          GridTileModel(
              'Dianner',
              widget.yarnSpecification!.dtyFilament != null
                  ? widget.yarnSpecification!.dtyFilament!
                  : 'N/A'),
          GridTileModel(
              'Filament',
              widget.yarnSpecification!.fdyFilament != null
                  ? widget.yarnSpecification!.fdyFilament!
                  : 'N/A'),
          GridTileModel(
              'Ply',
              widget.yarnSpecification!.yarnPly == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPly!),
          GridTileModel(
              'Color Treatment Method',
              widget.yarnSpecification!.yarnColorTreatmentMethod == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnColorTreatmentMethod!),
          GridTileModel(
              'Dying Method',
              widget.yarnSpecification!.yarnDyingMethod == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnDyingMethod!),
          GridTileModel(
              'Color',
              widget.yarnSpecification!.color == null
                  ? "N/A"
                  : widget.yarnSpecification!.color!),
          GridTileModel('Yarn Appearance',
              widget.yarnSpecification!.yarnApperance ?? "N/A"),
        ];
        break;
      case '5':
        _detailSpecification = [
          GridTileModel(
              'Yarn Family', widget.yarnSpecification!.yarnFamily ?? "N/A"),
          GridTileModel(
              'Blend',
              widget.yarnSpecification!.yarnBlend != null
                  ? '${widget.yarnSpecification!.yarnBlend}'
                  : "N/A"),
          GridTileModel(
              'Color Treatment Method',
              widget.yarnSpecification!.yarnColorTreatmentMethod == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnColorTreatmentMethod!),
          GridTileModel(
              'Dying Method',
              widget.yarnSpecification!.yarnDyingMethod == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnDyingMethod!),
          GridTileModel(
              'Color',
              widget.yarnSpecification!.color == null
                  ? "N/A"
                  : widget.yarnSpecification!.color!),
          GridTileModel(
              'Count',
              widget.yarnSpecification!.count != null
                  ? '${widget.yarnSpecification!.count}'
                  : "N/A"),
          GridTileModel(
              'Ply',
              widget.yarnSpecification!.yarnPly == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPly!),
          GridTileModel(
              'Pattern',
              widget.yarnSpecification!.yarnPattern == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPattern!),
          GridTileModel(
              'Pattern Characteristics',
              widget.yarnSpecification!.yarnPatternCharectristic == null
                  ? "N/A"
                  : widget.yarnSpecification!.yarnPatternCharectristic!),
        ];
        break;
    }

    _labParameters = [
      GridTileModel(
          'Actual Yarn Count',
          widget.yarnSpecification!.actualYarnCount == null
              ? "N/A"
              : widget.yarnSpecification!.actualYarnCount!),
      GridTileModel(
          'CLSP',
          widget.yarnSpecification!.clsp == null
              ? "N/A"
              : widget.yarnSpecification!.clsp!),
      GridTileModel(
          'IPM/KM',
          widget.yarnSpecification!.ys_ipm_km == null
              ? "N/A"
              : widget.yarnSpecification!.ys_ipm_km!),
      GridTileModel(
          'Thin Places',
          widget.yarnSpecification!.thinPlaces == null
              ? "N/A"
              : widget.yarnSpecification!.thinPlaces!),
      GridTileModel(
          'Thick Places',
          widget.yarnSpecification!.thickPlaces == null
              ? "N/A"
              : widget.yarnSpecification!.thickPlaces!),
      GridTileModel(
          'Naps',
          widget.yarnSpecification!.naps == null
              ? "N/A"
              : widget.yarnSpecification!.naps!),
      GridTileModel(
          'Uniformity',
          widget.yarnSpecification!.uniformity == null
              ? "N/A"
              : widget.yarnSpecification!.uniformity!),
      GridTileModel(
          'CV',
          widget.yarnSpecification!.cv == null
              ? "N/A"
              : widget.yarnSpecification!.cv!),
      GridTileModel(
          'Hairness',
          widget.yarnSpecification!.ys_hairness == null
              ? "N/A"
              : widget.yarnSpecification!.ys_hairness!),
      GridTileModel(
          'RKM',
          widget.yarnSpecification!.ys_rkm == null
              ? "N/A"
              : widget.yarnSpecification!.ys_rkm!),
      GridTileModel(
          'Elongation',
          widget.yarnSpecification!.ys_elongation == null
              ? "N/A"
              : widget.yarnSpecification!.ys_elongation!),
      GridTileModel(
          'TPI',
          widget.yarnSpecification!.ys_tpi == null
              ? "N/A"
              : widget.yarnSpecification!.ys_tpi!),
      GridTileModel(
          'TM',
          widget.yarnSpecification!.ys_tm == null
              ? "N/A"
              : widget.yarnSpecification!.ys_tm!),
    ];

    _detailPackaging = [
      // GridTileModel(
      //     'Unit Of Counting',
      //       widget.yarnSpecification!.unitCount == null
      //         ? "N/A"
      //         : widget.yarnSpecification!.unitCount!),

      // GridTileModel(
      //     'Available Quantity',
      //     widget.yarnSpecification!.ava == null
      //         ? "N/A"
      //         : widget.yarnSpecification!.av!),

      GridTileModel(
          'Minimum Quantity',
          widget.yarnSpecification!.minQuantity == null
              ? "N/A"
              : widget.yarnSpecification!.minQuantity!),
      GridTileModel(
          'Delivery Period',
          widget.yarnSpecification!.deliveryPeriod == null
              ? "N/A"
              : widget.yarnSpecification!.deliveryPeriod!),

      GridTileModel(
          'Price',
          widget.yarnSpecification!.priceUnit == null
              ? "N/A"
              : widget.yarnSpecification!.priceUnit!),

      GridTileModel(
          'Price Terms',
          widget.yarnSpecification!.priceTerms == null
              ? "N/A"
              : widget.yarnSpecification!.priceTerms!),

      GridTileModel(
          'Seller Location', widget.yarnSpecification!.locality ?? "N/A")
    ];
  }

  Future<String?> _getUserId() async {
    return await SharedPreferenceUtil.getStringValuesSF(USER_ID_KEY);
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
