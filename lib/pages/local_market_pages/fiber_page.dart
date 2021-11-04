import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yg_app/utils/colors.dart';
import 'package:yg_app/widgets/decoration_widgets.dart';

class FiberPage extends StatefulWidget {
  const FiberPage({Key? key}) : super(key: key);

  @override
  _FiberPageState createState() => _FiberPageState();
}

class _FiberPageState extends State<FiberPage> {

  Color offeringColor = AppColors.lightBlueTabs;
  Color requirementColor = Colors.white;
  Color textOfferClr = Colors.white;
  Color textReqClr = AppColors.textColorGreyLight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: bodyContent(),
      ),
    );
  }

  bodyContent() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Container(
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 90,
                    child: Column(
                      children: [
                        Image.asset(
                          'images/cotton.png',
                          height: 32,
                          width: 32,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Cotton",
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.strokeGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if(offeringColor == AppColors.lightBlueTabs){
                            changeTabColor(true);
                          }else{
                            changeTabColor(false);
                          }
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Offering',
                              style: TextStyle(color: textOfferClr),
                            ),
                          ),
                        ),
                        decoration: getOfferingDec(offeringColor),

                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          if(requirementColor == AppColors.lightBlueTabs){
                           changeTabColor(false);
                          }else{
                           changeTabColor(true);
                          }
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Requirements',
                              style: TextStyle(color: textReqClr),
                            ),
                          ),
                        ),
                        decoration: getRequirementDec(requirementColor)),

                    ),
                    flex: 1,
                  ),

                ],
              )),
        )
      ],
    );
  }

  void changeTabColor(bool value){
    if(value){
      offeringColor = Colors.white;
      requirementColor = AppColors.lightBlueTabs;

      textOfferClr = AppColors.textColorGreyLight;
      textReqClr = Colors.white;
    }else{
      offeringColor = AppColors.lightBlueTabs;
      requirementColor = Colors.white;

      textReqClr = AppColors.textColorGreyLight;
      textOfferClr = Colors.white;
    }
  }
}
