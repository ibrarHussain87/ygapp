import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/helper_utils/ui_utils.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/progress_dialog_util.dart';

import 'package:yg_app/helper_utils/app_constants.dart';
import 'package:yg_app/elements/decoration_widgets.dart';
import 'package:yg_app/elements/elevated_button_widget_2.dart';
import 'package:yg_app/elements/grey_text_detail_widget_.dart';
import 'package:yg_app/elements/title_text_widget.dart';

class DetailTabPage extends StatefulWidget {
  final Specification? specification;

  const DetailTabPage({Key? key, required this.specification})
      : super(key: key);

  @override
  _DetailTabPageState createState() => _DetailTabPageState();
}

class _DetailTabPageState extends State<DetailTabPage> {
  List<GridTileModel> detailSpecification = [];
  List<GridTileModel> detailPackaging = [];
  int? bidPrice;
  int? bidQuantity = 1;
  String bidRemarks = "";

  @override
  void initState() {
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
          widget.specification!.trash!=null
              ? widget.specification!.trash! + " %"
              : "N/A"),
      GridTileModel(
          'RD',
          widget.specification!.rd!=null
              ? widget.specification!.rd! + " %"
              : 'N/A'),
      GridTileModel(
          'GPT',
          widget.specification!.gpt!= null
              ? widget.specification!.gpt! + " %"
              : 'N/A'),
      GridTileModel(
          'Apperrence',
          widget.specification!.apperance == null
              ? "N/A"
              : widget.specification!.apperance!),
      GridTileModel(
          'Brand',
          widget.specification!.brand==null
              ? "N/A"
              : widget.specification!.brand!),
      GridTileModel(
          'Production year',
          widget.specification!.productYear ==null
              ? "N/A"
              : widget.specification!.productYear!),
      GridTileModel(
          'Origin',
          widget.specification!.origin == null
              ? "N/A"
              : widget.specification!.origin!),
      GridTileModel(
          'Certification',
          widget.specification!.certification==null
              ? "N/A"
              : widget.specification!.certification!),
    ];

    detailPackaging = [
      GridTileModel(
          'Unit Of Count',
          widget.specification!.unitCount==null
              ? "N/A"
              : widget.specification!.unitCount!),
      GridTileModel(
          'Price',
          widget.specification!.priceUnit == null
              ? "N/A"
              : widget.specification!.priceUnit!),
      GridTileModel(
          'Packing',
          widget.specification!.priceTerms==null
              ? "N/A"
              : widget.specification!.priceTerms!),
      GridTileModel(
          'Minimum Quantity',
          widget.specification!.minQuantity==null
              ? "N/A"
              : widget.specification!.minQuantity!),
      GridTileModel('Seller Location', widget.specification!.unitCount ?? "N/A")
    ];

    setState(() {
      bidPrice = int.parse(widget.specification!.priceUnit!.split(" ").last);
      bidQuantity = 1;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                      return GreyTextDetailWidget(
                          title: detailSpecification[index]._title,
                          detail: detailSpecification[index]._detail);
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
                      return GreyTextDetailWidget(
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
                        initialValue: widget.specification!.description==null
                            ? "N/A"
                            : widget.specification!.description!,
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
                                child:
                                    const TitleSmallTextWidget(title: 'Price')),
                            Container(
                              width: 200.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: lightBlueTabs,
                                    width:
                                        1, //                   <--- border width here
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.w))),
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (bidPrice! >= 1) {
                                              bidPrice = bidPrice! - 1;
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          size: 16.w,
                                          color: Colors.grey,
                                        )),
                                    TitleTextWidget(title: '$bidPrice'),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            bidPrice = bidPrice! + 1;
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 16.w,
                                          color: Colors.grey,
                                        )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.all(4.w),
                                child: const TitleSmallTextWidget(
                                    title: 'Quantity (Kg)')),
                            Container(
                              width: 200.w,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: lightBlueTabs,
                                    width:
                                        1, //                   <--- border width here
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.w))),
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (bidQuantity! >= 1) {
                                              bidQuantity = bidQuantity! - 1;
                                            }
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          size: 16.w,
                                          color: Colors.grey,
                                        )),
                                    TitleTextWidget(title: '$bidQuantity'),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            bidQuantity = bidQuantity! + 1;
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 16.w,
                                          color: Colors.grey,
                                        )),
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
            flex: 9,
          ),
          ElevatedButtonWithoutIcon(
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
                  Ui.showSnackBar(
                      context, error.message.toString());
                });
              },
              color: btnColorLogin,
              btnText: 'Place Bid'),
        ],
      ),
    );
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
