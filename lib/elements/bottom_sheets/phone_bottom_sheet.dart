import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/helper_utils/top_round_corners.dart';
import 'package:yg_app/model/enum_phone.dart';

import 'offering_requirment_bottom_sheet.dart';

final List<MyActions> actionsList = [
  MyActions('Phone', Icons.phone,'1'),
  MyActions('Whatsapp', Icons.whatsapp,"0"),
];

showBottomSheetPhone(BuildContext context,Function callback) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: false,
      builder: (context) {
        return Container(
            decoration: getRoundedTopCorners(),
            height: 0.26 * MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, top: 8),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close),
                      ),
                    )),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'What do you want to open?',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Align(
                        alignment: Alignment.center,
                        child: ListView.separated(
                            separatorBuilder: (BuildContext context, int index) => const VerticalDivider(width: 1,indent: 15,
                              endIndent: 8,),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: actionsList.length,
                            itemBuilder: (context, index) {
                              return ItemBottomSheet(
                                  myActions: actionsList[index],
                                  myClickCallback: (value) {
                                    Navigator.pop(context);
                                    Logger().e(index == 0);
                                    if(index == 0){
                                      callback(CallEnum.Phone);
                                    }else{
                                      callback(CallEnum.Whatsapp);
                                    }
                                  });
                            }),
                      ),
                    )
                ),
                const SizedBox(height: 20),
              ],
            ));
      });
}

class ItemBottomSheet extends StatelessWidget {
  final MyActions myActions;
  final Function(String) myClickCallback;

  const ItemBottomSheet(
      {Key? key, required this.myActions, required this.myClickCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width/2,
      child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              myClickCallback('You clicked ${myActions.title}');
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                    color: Colors.white,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(7),
                        child: Icon(
                          myActions.icon,
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 0,
                ),
                Text(
                  myActions.title,
                  style:
                      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }
}
