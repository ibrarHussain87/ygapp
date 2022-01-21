import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
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
  List<GridTileModel> detailSpecification = [];
  List<GridTileModel> labParameters = [];
  List<GridTileModel> detailPackaging = [];
  int? bidPrice;
  int? bidQuantity = 1;
  String bidRemarks = "";
  bool showBidContainer = false;
  String? userId;

  @override
  void initState() {
    setState(() {
      if (widget.specification != null) {
        bidPrice = int.parse(widget.specification!.priceUnit!.split(" ").last);
      } else {
        bidPrice = int.parse(widget.yarnSpecification!.priceUnit!
            .replaceAll(RegExp(r'[^0-9]'), ''));
      }
      bidQuantity = 1;
    });

    widget.specification != null ? _fiberDetails() : _yarnDetails();

    _getUserId().then((value) => userId == value);

    if (widget.specification != null) {
      if (userId == widget.specification!.spc_user_id) {
        showBidContainer = true;
      }
    } else {
      if (userId == widget.yarnSpecification!.ys_user_id) {
        showBidContainer = true;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16.w,
                    ),
                    TitleTextWidget(title: specifications),
                    SizedBox(
                      height: 8.w,
                    ),
                    GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 2.77,
                      mainAxisSpacing: 3.w,
                      crossAxisSpacing: 6.w,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children:
                          List.generate(detailSpecification.length, (index) {
                        return TextDetailWidget(
                            title: detailSpecification[index]._title,
                            detail: detailSpecification[index]._detail);
                      }),
                    ),
                    const Divider(),
                    widget.yarnSpecification != null
                        ? Column(
                            children: [
                              SizedBox(
                                height: 4.w,
                              ),
                              const TitleTextWidget(title: 'Lab Parameters'),
                              SizedBox(
                                height: 8.w,
                              ),
                            ],
                          )
                        : SizedBox(
                            height: 4.w,
                          ),
                    GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 2.77,
                      mainAxisSpacing: 3.w,
                      crossAxisSpacing: 6.w,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(labParameters.length, (index) {
                        return TextDetailWidget(
                            title: labParameters[index]._title,
                            detail: labParameters[index]._detail);
                      }),
                    ),
                    const Divider(),
                    SizedBox(
                      height: 4.w,
                    ),
                    const TitleTextWidget(title: 'Packing Details'),
                    SizedBox(
                      height: 8.w,
                    ),
                    GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 2.77,
                      mainAxisSpacing: 3.w,
                      crossAxisSpacing: 6.w,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(detailPackaging.length, (index) {
                        return TextDetailWidget(
                            title: detailPackaging[index]._title,
                            detail: detailPackaging[index]._detail);
                      }),
                    ),
                    Divider(),
                    SizedBox(
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
                          /*decoration: roundedDescriptionDecoration(
                                "Description")*/
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    Visibility(
                      visible: showBidContainer,
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
                                    Container(
                                      width: 200.w,
                                      child: Padding(
                                        padding: EdgeInsets.all(1.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
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
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (bidPrice! >=
                                                                1) {
                                                              bidPrice =
                                                                  bidPrice! - 1;
                                                            }
                                                          });
                                                        },
                                                        child: Center(
                                                          child:
                                                              TitleTextWidget(
                                                            title: '-1',
                                                            color:
                                                                lightBlueTabs,
                                                          ),
                                                        ),
                                                      ),
                                                    ))),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.w),
                                                    child: Center(
                                                      child:
                                                          LargeTitleTextWidget(
                                                              title:
                                                                  '$bidPrice'),
                                                    ))),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
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
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            bidPrice =
                                                                bidPrice! + 1;
                                                          });
                                                        },
                                                        child: Center(
                                                          child:
                                                              TitleTextWidget(
                                                            title: '+1',
                                                            color:
                                                                lightBlueTabs,
                                                          ),
                                                        ),
                                                      ),
                                                    )))
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
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (bidQuantity! >= 1) {
                                                          bidQuantity =
                                                              bidQuantity! - 1;
                                                        }
                                                      });
                                                    },
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
                                              padding: EdgeInsets.all(8.w),
                                              child: Center(
                                                child: LargeTitleTextWidget(
                                                    title: '$bidQuantity'),
                                              ),
                                            )),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
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
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            bidQuantity =
                                                                bidQuantity! +
                                                                    1;
                                                          });
                                                        },
                                                        child: Center(
                                                          child:
                                                              TitleTextWidget(
                                                            title: '+1',
                                                            color:
                                                                lightBlueTabs,
                                                          ),
                                                        ),
                                                      ),
                                                    )))
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
                            height: 16.w,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: const TitleSmallTextWidget(title: 'Remarks')),
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
                                  bidRemarks = value;
                                },
                                decoration: roundedDescriptionDecoration("Remarks")),
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
              visible: showBidContainer,
              child: ElevatedButtonWithoutIcon(
                  callback: () {
                    ProgressDialogUtil.showDialog(context, "Please wait....");
                    ApiService.createBid(
                            widget.specification!.categoryId.toString(),
                            widget.specification!.spcId.toString(),
                            bidPrice.toString(),
                            bidQuantity.toString(),
                            bidRemarks)
                        .then((value) {
                      ProgressDialogUtil.hideDialog();
                      Ui.showSnackBar(context, value.message);
                    }, onError: (stacktrace, error) {
                      Ui.showSnackBar(context, error.message.toString());
                    });
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
    detailSpecification = [
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
              ? '${widget.specification!.moisture!} %'
              : "N/A"),
      GridTileModel(
          'Trash',
          widget.specification!.trash != null
              ? widget.specification!.trash! + " %"
              : "N/A"),
      GridTileModel(
          'RD',
          widget.specification!.rd != null
              ? widget.specification!.rd! + " %"
              : 'N/A'),
      GridTileModel(
          'GPT',
          widget.specification!.gpt != null
              ? widget.specification!.gpt! + " %"
              : 'N/A'),
      GridTileModel(
          'Apperrence',
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

    labParameters = [
      GridTileModel(
          'Unit Of Count',
          widget.specification!.unitCount == null
              ? "N/A"
              : widget.specification!.unitCount!),
      GridTileModel(
          'Price',
          widget.specification!.priceUnit == null
              ? "N/A"
              : widget.specification!.priceUnit!),
      GridTileModel(
          'Packing',
          widget.specification!.priceTerms == null
              ? "N/A"
              : widget.specification!.priceTerms!)
    ];

    detailPackaging = [
      GridTileModel(
          'Unit Of Count',
          widget.specification!.unitCount == null
              ? "N/A"
              : widget.specification!.unitCount!),
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
    detailSpecification = [
      GridTileModel(
          'Yarn Family', widget.yarnSpecification!.yarnFamily ?? "N/A"),
      GridTileModel('Yarn Usage', widget.yarnSpecification!.yarnUsage ?? "N/A"),
      GridTileModel(
          'Yarn Appearance', widget.yarnSpecification!.yarnApperance ?? "N/A"),
      GridTileModel(
          'Count',
          widget.yarnSpecification!.count != null
              ? '${widget.yarnSpecification!.count}'
              : "N/A"),
      GridTileModel(
          'Ratio',
          widget.yarnSpecification!.yarnRtio != null
              ? widget.yarnSpecification!.yarnRtio! + " %"
              : "N/A"),
      GridTileModel(
          'Filament',
          widget.yarnSpecification!.fdyFilament != null
              ? widget.yarnSpecification!.fdyFilament! + " %"
              : 'N/A'),
      GridTileModel(
          'Dianner',
          widget.yarnSpecification!.dtyFilament != null
              ? widget.yarnSpecification!.dtyFilament! + " %"
              : 'N/A'),
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
      GridTileModel(
          'Certification',
          (widget.yarnSpecification!.yarnCertificationStr == null || widget.yarnSpecification!.yarnCertificationStr!.isEmpty)
              ? "N/A"
              : widget.yarnSpecification!.yarnCertificationStr!.replaceAll(",", "")),
    ];

    labParameters = [
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

    detailPackaging = [
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
