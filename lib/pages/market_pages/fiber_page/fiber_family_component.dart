import 'package:flutter/material.dart';
import 'package:yg_app/api_services/api_service_class.dart';
import 'package:yg_app/app_database/app_database.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/loading_widgets/loading_listing.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/pages/market_pages/fiber_page/nature_family_body_component.dart';

class FiberFamilyComponent extends StatefulWidget {
  final Function callback;

  const FiberFamilyComponent({Key? key, required this.callback})
      : super(key: key);

  @override
  FiberFamilyComponentState createState() => FiberFamilyComponentState();
}

class FiberFamilyComponentState extends State<FiberFamilyComponent> {

  SyncFiberResponse? fiberSyncResponse;
  List<FiberMaterial>? materials;
  List<FiberNature>? fiberNature;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppDbInstance.getDbInstance().then((value) async{
      materials = await value.fiberMaterialDao.findAllFiberMaterials();
      fiberNature = await value.fiberNatureDao.findAllFiberNatures();
    });

  }

  @override
  Widget build(BuildContext context) {
    return /*fiberNature!.isNotEmpty && materials!.isNotEmpty ? NatureFamilyBodyComponent(
      natureId: fiberNature!.first.id.toString(),
      fiberMaterialList: materials??[],
      fiberNaturesList: fiberNature??[],
      callback: (value) {
        widget.callback(value);
      },
    ):SizedBox(
      child: const LoadingListing(),
      height: 0.065 * MediaQuery.of(context).size.height,
    );*/ FutureBuilder<SyncFiberResponse>(
        future: ApiService.syncFiber(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            fiberSyncResponse = snapshot.data!;
            AppDbInstance.getDbInstance().then((value) async{
              await value.fiberNatureDao.insertAllFiberNatures(snapshot.data!.data.fiber.natures);
              await value.fiberMaterialDao.insertAllFiberMaterials(snapshot.data!.data.fiber.material);
            });
            return NatureFamilyBodyComponent(
              natureId: fiberSyncResponse!.data.fiber.natures.first.id.toString(),
              fiberMaterialList: fiberSyncResponse!.data.fiber.material,
              fiberNaturesList: fiberSyncResponse!.data.fiber.natures,
              callback: (value) {
                widget.callback(value);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
                child: TitleSmallTextWidget(title: snapshot.error.toString()));
          } else {
            return SizedBox(
              child: const LoadingListing(),
              height: 0.065 * MediaQuery.of(context).size.height,
            );
          }
        });
  }


}
