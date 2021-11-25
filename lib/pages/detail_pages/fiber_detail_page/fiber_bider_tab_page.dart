import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/model/response/list_bidder_response.dart';
import 'package:yg_app/utils/app_images.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/list_widgets/brand_text.dart';
import 'package:yg_app/widgets/title_text_widget.dart';

class BidderListPage extends StatefulWidget {

  final String materialId;
  final int specId;

  const BidderListPage(
      {Key? key, required this.materialId, required this.specId})
      : super(key: key);

  @override
  _BidderListPageState createState() => _BidderListPageState();
}

class _BidderListPageState extends State<BidderListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<ListBiddersResponse>(
        future: ApiService.getListBidders(
            widget.materialId, widget.specId.toString()),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.data.isNotEmpty) {
            return ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (context, index) {
                  return getItem(snapshot.data!.data[index]);
                });
          } else if (snapshot.hasError) {
            return Center(
                child: TitleTextWidget(title: snapshot.error.toString()));
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.data.isEmpty) {
            return const Center(
                child: TitleTextWidget(title: 'No data found!!'));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget getItem(ListBiddersData listBiddersData) {
    return Padding(
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
              Image.asset(
                AppImages.postAdGreyIcon,
                width: 24.w,
                height: 24.w,
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTextWidget(title: listBiddersData.userName ?? ""),
                    BrandWidget(title: listBiddersData.date?? "N/A")
                  ],
                ),
                flex: 8,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleTextWidget(title: listBiddersData.price ?? ""),
                  SizedBox(
                    height: 4.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.btnGreen,
                        borderRadius: BorderRadius.all(Radius.circular(2.w))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 3.w, bottom: 3.w, left: 12.w, right: 12.w),
                      child: Center(
                        child: Text(
                          'Accept',
                          style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
