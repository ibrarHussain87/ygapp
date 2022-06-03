import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_items/bids_list/bids_list_items.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import '../../../../model/response/list_bid_response.dart';

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
            behavior: HitTestBehavior.opaque,
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
        body: FutureBuilder<ListBidResponse>(
          future: ApiService.getListBids(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null && snapshot.data!.data!= null && snapshot.data!.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, index) {
                   var bidItem = snapshot.data!.data![index];
                    return bidItem.specification != null ? BidsListItem(bidData: bidItem) : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Bid Specification does not exist'),
                    );
                  });
            } else if(snapshot.data != null && snapshot.data!.data!.isEmpty){
              return const Center(
                  child: TitleSmallTextWidget(title: 'No data found!!'));
            }else if (snapshot.hasError) {
              return Center(
                  child: TitleSmallTextWidget(title: snapshot.error.toString()));
            } else {
              return const Center(
                child: SpinKitWave(
                  color: Colors.green,
                  size: 24.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
