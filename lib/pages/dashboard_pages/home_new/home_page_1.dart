import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/text_widgets.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/navigation_utils.dart';
import 'package:yg_app/pages/dashboard_pages/market_page.dart';

import '../../../model/home_model.dart';

class DashboardPage extends StatefulWidget {
  final Function callback;
   const DashboardPage({Key? key,required this.callback}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<HomeModel> homeList=
  [
    HomeModel(id: "1", title: 'Fiber',subTitle: 'over 255 ads',image:fiberImage,isDisable: false),
    HomeModel(id: "2", title: 'Yarn',subTitle: 'over 410 ads',image:yarnImage,isDisable: false),
    HomeModel(id: "3", title: 'Fabrics',subTitle: 'over 115 ads',image: fabricsImage,isDisable: false),
    HomeModel(id: "4", title: 'StockLots',subTitle: 'over 40 ads',image: stockLotsImage,isDisable: false),
    HomeModel(id: "5", title: 'YG Services',subTitle: 'over 5 services',image: servicesImage,isDisable: false),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height:AppBar().preferredSize.height*0.9,
            padding: const EdgeInsets.all(7),
            decoration:BoxDecoration(
                gradient:LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[appBarColor2,appBarColor1]) ,
                borderRadius:const BorderRadius.only(
                    bottomRight:  Radius.circular(/*20.0*/0),
                    bottomLeft: Radius.circular(/*20.0*/0))

            ),
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    widget.callback(4);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(left: 4.w,top: 8.w),
                      child: Icon(
                        Icons.segment,
                        color: Colors.white,
                        size: 22.w,
                      )),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Yarn Guru",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0.w,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {

                    },
                    child: Padding(
                        padding: EdgeInsets.only(left: 10.w,top: 6.w),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 22.w,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left:16.w,right: 16.w,bottom: 8.w,top: 8.w),
        margin: EdgeInsets.only(bottom: 4.w),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Visibility(
               visible: false,
               child: Padding(
                padding:  const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
                child:
                Text("Welcome, Zohaib Rao", style: TextStyle(fontSize: 18.sp, color:Colors.black,fontWeight: FontWeight.bold)),
            ),
             ),
             Visibility(
               visible: false,
               child: Padding(
                padding:  const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 8.0),
                child: TitleExtraSmallTextWidget(title: "Choose your required product to start",color: font_light_grey,),
            ),
             ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    )),
                child:  ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: homeList.length,
                  shrinkWrap: true,
                  primary: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        switch(index){
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  const MarketPage(locality: 'LOCAL'),
                              ),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  const MarketPage(locality: 'LOCAL'),
                              ),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  const MarketPage(locality: 'LOCAL'),
                              ),
                            );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  const MarketPage(locality: 'LOCAL'),
                              ),
                            );
                            break;
                          case 4:
                            openYGServiceScreen(context);
                            break;
                        }
                        // if (index==4) {
                        // }
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.all(5),
                              child: Image.asset(
                                  homeList[index].image.toString(),
                                  fit: BoxFit.cover
                              )
                          ),
                          Positioned(
                              left: 25,
                              bottom: 25,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 0.1)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                         Text(homeList[index].title.toString(), style: TextStyle(fontSize: 18.sp, color: Colors.white,fontWeight: FontWeight.bold)),
                                         Text(homeList[index].subTitle.toString() , style: TextStyle(fontSize: 10.sp, color: Colors.white))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )

      ),
    );
  }
}


