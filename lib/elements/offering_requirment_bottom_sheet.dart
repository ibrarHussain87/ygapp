import 'package:flutter/material.dart';

final List<MyActions> actionsList = [
  MyActions('Offering', Icons.local_offer,'1'),
  MyActions('Requirement', Icons.local_offer_outlined,"0"),
];

showBottomSheetOR(BuildContext context,Function callback) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: Container(
              height: 0.26 * MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5, top: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close),
                        ),
                      )),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'What do you want to sell?',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: Align(
                    alignment: Alignment.center,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: actionsList.length,
                        itemBuilder: (context, index) {
                          return ItemBottomSheet(
                              myActions: actionsList[index],
                              myClickCallback: (value) {
                                Navigator.pop(context);
                                callback(actionsList[index].value);
                              });
                        }),
                  )),
                  const SizedBox(height: 20),
                ],
              )),
        );
      });
}

class MyActions {
  String title;
  IconData icon;
  String value;

  MyActions(this.title, this.icon,this.value);
}

class ItemBottomSheet extends StatelessWidget {
  final MyActions myActions;
  final Function(String) myClickCallback;

  const ItemBottomSheet(
      {Key? key, required this.myActions, required this.myClickCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: GestureDetector(
          onTap: () {
            myClickCallback('You clicked ${myActions.title}');
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
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
                height: 10,
              ),
              Text(
                myActions.title,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
