import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/list_bidder_response.dart';
import 'package:yg_app/pages/detail_pages/fiber_detail_page/list_bidder_components/list_bidder_body.dart';
import 'package:yg_app/pages/profile/my_ads/list_bids_page/list_bids_body.dart';

class BidsListPage extends StatefulWidget {
  const BidsListPage({Key? key}) : super(key: key);
  @override
  _BidsListPageState createState() => _BidsListPageState();
}

class _BidsListPageState extends State<BidsListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Card(
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 12.w,
                      )),
                )),
          ),
          title: Text('My Bids',
              style: TextStyle(
                  fontSize: 16.0.w,
                  color: appBarTextColor,
                  fontWeight: FontWeight.w400)),
        ),
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.w),
          child: FutureBuilder<ListBiddersResponse>(
            future: ApiService.getListBids(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      return ListBidsBody(
                          listBiddersData: snapshot.data!.data[index]);
                    });
              } else if (snapshot.hasError) {
                return Center(
                    child: TitleSmallTextWidget(title: snapshot.error.toString()));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
