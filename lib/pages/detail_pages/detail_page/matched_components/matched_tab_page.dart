import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/list_items/stocklot_list_items.dart';
import 'package:yg_app/elements/no_data_found_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/model/matched_response.dart';
import 'package:yg_app/pages/market_pages/fiber_page/fiber_listing_body.dart';
import 'package:yg_app/pages/market_pages/yarn_page/yarn_components/yarn_list_body.dart';

import '../../../../helper_utils/navigation_utils.dart';
import '../../../market_pages/fabric_page/fabric_components/fabric_list_body.dart';

class MatchedPage extends StatefulWidget {
  final String catId;
  final int specId;

  const MatchedPage(
      {Key? key, required this.catId, required this.specId})
      : super(key: key);

  @override
  _MatchedPageState createState() => _MatchedPageState();
}

class _MatchedPageState extends State<MatchedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<MatchedResponse>(
        future: ApiService().getMatched(
            widget.catId, widget.specId.toString()),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data!=null) {
            if(widget.catId == "1" && snapshot.data!.data!= null && snapshot.data!.data!.fiber!= null){
              return Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                child: FiberListingBody(specification: snapshot.data!.data!.fiber!),
              );
            }else if(widget.catId == "2" && snapshot.data!.data!=null && snapshot.data!.data!.yarnSpecification!=null){
              return Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                child: YarnListBody(specification: snapshot.data!.data!.yarnSpecification!),
              );
            }else if(widget.catId == "5" && snapshot.data!.data!=null && snapshot.data!.data!.stockLotSpecification!=null){
              return snapshot.data!.data!.stockLotSpecification!.isNotEmpty ? Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                child: ListView.separated(
                  itemCount: snapshot.data!.data!.stockLotSpecification!.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      openDetailsScreen(context,
                          specObj:snapshot.data!.data!.stockLotSpecification![index]);
                    },
                    child: StockLotListItem(
                      specification:snapshot.data!.data!.stockLotSpecification![index],
                    ),
                  ),
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 1,
                      color: Colors.grey.shade400,
                    );
                  },
                ),
              ) :const Center(child: NoDataFoundWidget(),);
            }else if(widget.catId == "3" && snapshot.data!.data!=null && snapshot.data!.data!.fabricSpecification!=null){
              return Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                child: FabricListBody(specification: snapshot.data!.data!.fabricSpecification!),
              );
            }else{
              return const Center(
                  child: NoDataFoundWidget());
            }
          } else if (snapshot.hasError) {
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
    );
  }


}
