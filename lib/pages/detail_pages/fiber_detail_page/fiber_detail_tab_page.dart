import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/fiber_response/fiber_specification.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/utils/progress_dialog_util.dart';
import 'package:yg_app/utils/show_messgae_util.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';
import 'package:yg_app/widgets/elevated_button_widget_2.dart';
import 'package:yg_app/widgets/grey_text_detail_widget_.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class DetailTabPage extends StatefulWidget {
  Specification? specification;

  DetailTabPage({Key? key, required this.specification}) : super(key: key);

  @override
  _DetailTabPageState createState() => _DetailTabPageState();
}

class _DetailTabPageState extends State<DetailTabPage> {
  List<GridTileModel> detailSpecification = [];
  List<GridTileModel> detailPackaging = [];
  int? bidPrice;

  @override
  void initState() {
    detailSpecification = [
      GridTileModel('Fiber Material', widget.specification!.material ?? "N/A"),
      GridTileModel(
          'Fiber Length',
          widget.specification!.length!.isNotEmpty
              ? '${widget.specification!.length} mm'
              : 'N/A'),
      GridTileModel(
          'Micronaire',
          widget.specification!.micronaire!.isNotEmpty
              ? '${widget.specification!.micronaire!} mic'
              : "N/A"),
      GridTileModel(
          'Moisture',
          widget.specification!.moisture!.isNotEmpty
              ? '${widget.specification!.moisture!} %'
              : "N/A"),
      GridTileModel(
          'Trash',
          widget.specification!.trash!.isNotEmpty
              ? widget.specification!.trash! + " %"
              : "N/A"),
      GridTileModel(
          'RD',
          widget.specification!.rd!.isNotEmpty
              ? widget.specification!.rd! + " %"
              : 'N/A'),
      GridTileModel(
          'GPT',
          widget.specification!.gpt!.isNotEmpty
              ? widget.specification!.gpt! + " %"
              : 'N/A'),
      GridTileModel('Apperrence', widget.specification!.apperance!.isEmpty ? "N/A" : widget.specification!.apperance!),
      GridTileModel('Brand', widget.specification!.brand!.isEmpty ? "N/A" :widget.specification!.brand!),
      GridTileModel(
          'Production year', widget.specification!.productYear!.isEmpty ? "N/A" : widget.specification!.productYear!),
      GridTileModel('Origin', widget.specification!.origin!.isEmpty ? "N/A" :widget.specification!.origin!),
      GridTileModel(
          'Certification', widget.specification!.certification!.isEmpty ? "N/A" : widget.specification!.certification!),
    ];

    detailPackaging = [
      GridTileModel('Unit Of Count', widget.specification!.unitCount!.isEmpty ? "N/A" :widget.specification!.unitCount!),
      GridTileModel('Price', widget.specification!.priceUnit!.isEmpty ? "N/A" : widget.specification!.priceUnit!),
      GridTileModel('Packing', widget.specification!.priceTerms!.isEmpty ? "N/A" :widget.specification!.priceTerms!),
      GridTileModel(
          'Minimum Quantity', widget.specification!.minQuantity!.isEmpty ? "N/A" : widget.specification!.minQuantity!),
      GridTileModel('Seller Location', widget.specification!.unitCount ?? "N/A")
    ];

    setState(() {
      bidPrice = int.parse(widget.specification!.priceUnit!.split(" ").last);
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
                  TitleTextWidget(title: AppStrings.specifications),
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

                  Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child:
                      const TitleSmallTextWidget(title: 'Description')),
                  SizedBox(
                    height: 5 * 22.w,
                    child: TextFormField(
                        keyboardType: TextInputType.text,
                        maxLines: 5,
                        initialValue: widget.specification!.description!.isEmpty ? "N/A" :  widget.specification!.description!,
                        cursorColor: AppColors.lightBlueTabs,
                        style: TextStyle(fontSize: 11.sp),
                        textAlign: TextAlign.start,
                        cursorHeight: 16.w,
                        showCursor: false,
                        readOnly: true,
                        decoration: roundedDescriptionDecoration(
                            "Description")),
                  ),
                ],
              ),
            ),
            flex: 9,
          ),
          Column(
            children: [
              Container(
                width: 200.w,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.lightBlueTabs,
                      width: 1, //                   <--- border width here
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.w))),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              bidPrice = bidPrice! - 1;
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
              ),
              SizedBox(
                height: 8.w,
              ),
              ElevatedButtonWithoutIcon(
                  callback: () {
                    ProgressDialogUtil.showDialog(context, "Please wait....");
                    ApiService.createBid(
                            widget.specification!.categoryId.toString(),
                            widget.specification!.spcId.toString(),
                            bidPrice.toString())
                        .then((value) {
                      ProgressDialogUtil.hideDialog();
                      ShowMessageUtils.showSnackBar(context, value.message);
                    }, onError: (stacktrace, error) {
                      ShowMessageUtils.showSnackBar(
                          context, error.message.toString());
                    });
                  },
                  color: AppColors.btnColorLogin,
                  btnText: 'Place Bid')
            ],
          )
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
