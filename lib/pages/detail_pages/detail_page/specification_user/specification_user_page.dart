
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/elements/no_data_found_widget.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/detail_tile_model.dart';
import 'package:yg_app/model/request/specification_user/spec_user_request.dart';
import 'package:yg_app/model/response/spec_user_response.dart';
import 'package:yg_app/pages/detail_pages/detail_page/specification_user/spec_user_view.dart';

class SpecificationUserPage extends StatefulWidget {
  final String specId;
  final String categoryId;

  const SpecificationUserPage(
      {Key? key, required this.specId, required this.categoryId})
      : super(key: key);

  @override
  _SpecificationUserPageState createState() => _SpecificationUserPageState();
}

class _SpecificationUserPageState extends State<SpecificationUserPage> {
  late SpecificationRequestModel _specificationRequestModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DetailTileModel> _userDetails = [];
  String companyName = 'Contact Card';

  @override
  void initState() {
    _specificationRequestModel = SpecificationRequestModel(
        spc_id: widget.specId, category_id: widget.categoryId);
    Logger().e(_specificationRequestModel.toJson());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SpecificationUserResponse?>(
      future: ApiService().getSpecificationUser(_specificationRequestModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
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
                title: Text(snapshot.data!.data!= null ? snapshot.data!.data!.company ?? companyName : "Contact Details",
                    style: TextStyle(
                        fontSize: 16.0.w,
                        color: appBarTextColor,
                        fontWeight: FontWeight.w400)),
              ),
              body: snapshot.data!.data != null? SpecUserView(
                  specificationUser: snapshot.data!.data!,
                  specId: widget.specId,
                  categoryId: widget.categoryId) : const Center(
                  child: NoDataFoundWidget()),
            ),
          );
        } else if (snapshot.hasError) {
          return Material(
            child: Container(
              color: Colors.white,
              child: Center(
                  child: TitleSmallTextWidget(title: snapshot.error.toString())),
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: const Center(
              child: SpinKitWave(
                color: Colors.green,
                size: 24.0,
              ),
            ),
          );
        }
      },
    );
  }
}
