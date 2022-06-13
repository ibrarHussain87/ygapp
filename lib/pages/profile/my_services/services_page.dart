import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/custom_header.dart';

import '../../../elements/custom_header.dart';

import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/navigation_utils.dart';
import '../../../locators.dart';
import '../../../model/services_model.dart';
import '../../../providers/profile_providers/my_yg_services_provider.dart';
class MyServicesPage extends StatefulWidget {
  const MyServicesPage({Key? key}) : super(key: key);

  @override
  _MyServicesPageState createState() => _MyServicesPageState();
}

class _MyServicesPageState extends State<MyServicesPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> types=["Total","Resolved","InProgress","Re-Opened","Others"];

  final _ygServiceProvider = locator<YgServicesProvider>();
  List<ServicesModel> serviceList=
  [
    ServicesModel(id: "1",complaintNo: "38445-15591", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Regretted",date: "12-2-2022",time: "12:33 PM"),
    ServicesModel(id: "2",complaintNo: "82452-77592", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Resolved",date: "14-2-2022",time: "10:21 AM"),
    ServicesModel(id: "3",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Resolved",date: "21-3-2022",time: "3:30 PM"),

  ];
  @override
  void initState() {
    super.initState();

    _ygServiceProvider.addListener(() {
      updateUI();
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // _profileInfoProvider.resetData();
      _ygServiceProvider.getServicesData(context);
      if (kDebugMode) {
        print("Services List"+_ygServiceProvider.myServices.toString());
      }

    });
  }

  updateUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: appBar(context,"My Services"),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                // decoration: const BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(24.0),
                //       topRight: Radius.circular(24.0),
                //     )),
                child: (!_ygServiceProvider.loading) ? ListView.builder(

                  physics: const BouncingScrollPhysics(),
                  itemCount: _ygServiceProvider.myServices?.length,
                  shrinkWrap: true,
                  primary: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){

                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 5.0,bottom: 5.0),
                        child: Card(
                        shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                RotatedBox
                                  (
                                  quarterTurns: 1,
                                  child: Text(serviceList[index].status.toString().toUpperCase(),textAlign: TextAlign.center,overflow: TextOverflow.fade,style:TextStyle(
                                    color:serviceList[index].status.toString()==types[1] ? lightBlueTabs :
                                    serviceList[index].status.toString()==types[2] ? Colors.blue :
                                    serviceList[index].status.toString()==types[3] ? Colors.orange :
                                    serviceList[index].status.toString()==types[4] ? Colors.lightBlue : Colors.red,
                                      fontWeight: FontWeight.w600,fontSize: 13.sp,letterSpacing: 1
                                  ),),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Complaint #:",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.black87)),
                                          const SizedBox(width:3,),
                                          Expanded(child: Text(_ygServiceProvider.myServices![index].ygserviceId.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87))),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          Text("Type:",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.black87)),
                                          const SizedBox(width:3,),
                                          Expanded(child: Text(_ygServiceProvider.myServices![index].ygserviceDetails.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.grey.shade500))),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("Sub Category :",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.black87)),
                                          const SizedBox(width:3,),
                                          Expanded(child: Text(_ygServiceProvider.myServices![index].ygserviceSpecialInstruction.toString(),textAlign: TextAlign.start ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.grey.shade500))),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Expanded(

                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Icon(Icons.calendar_today_rounded,color: lightBlueTabs,size: 20,),
                                                const SizedBox(width: 3,),
                                                Text(_ygServiceProvider.myServices![index].ygserviceSuitableDatetime.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.grey.shade500)),
                                              ],
                                            ),
                                          ),

                                          // Row(
                                          //
                                          //   crossAxisAlignment: CrossAxisAlignment.start,
                                          //   children: [
                                          //     Icon(Icons.timer_outlined,color: lightBlueTabs,size: 20,),
                                          //     const SizedBox(width: 3,),
                                          //     Text(serviceList[index].time.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.grey.shade500)),
                                          //   ],
                                          // ),
                                       ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Align(alignment:Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: (){
                                              openServiceDetailScreen(context,_ygServiceProvider.myServices![index]);
                                            },
                                          child: Text("View Details",style: TextStyle(fontSize: 11.sp,fontWeight:FontWeight.w500,color: lightBlueTabs),)))

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ) :  Center(
                  child: CircularProgressIndicator(color: lightBlueTabs,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}


