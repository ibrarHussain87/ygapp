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
    ServicesModel(id: "3",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Re-Opened",date: "21-3-2022",time: "3:30 PM"),
    ServicesModel(id: "4",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"InProgress",date: "21-3-2022",time: "3:30 PM"),
    ServicesModel(id: "5",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Re-Opened",date: "21-3-2022",time: "3:30 PM"),
    ServicesModel(id: "6",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Resolved",date: "21-3-2022",time: "3:30 PM"),
    ServicesModel(id: "7",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Resolved",date: "21-3-2022",time: "3:30 PM"),
    ServicesModel(id: "8",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Resolved",date: "21-3-2022",time: "3:30 PM"),
    ServicesModel(id: "9",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Resolved",date: "21-3-2022",time: "3:30 PM"),
    ServicesModel(id: "10",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Resolved",date: "21-3-2022",time: "3:30 PM"),

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

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: appBar(context,"Services"),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          openYGServiceScreen(context);
          },
          backgroundColor: darkBlueChip,
          child: const Icon(Icons.add,color: Colors.white,),
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: (!_ygServiceProvider.loading) ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _ygServiceProvider.myServices?.length,
                  shrinkWrap: true,
                  primary: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    List<String>? dateTime=_ygServiceProvider.myServices![index].ygserviceSuitableDatetime?.split(' ');
                    return GestureDetector(
                      onTap: (){
                      openServiceDetailScreen(context,_ygServiceProvider.myServices![index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 4.0,bottom: 4.0),
                        child: Card(
                        shape:RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey.shade200,
                                width: 1,
                                style: BorderStyle.solid
                            ),
                        borderRadius: BorderRadius.circular(10)),
                          elevation: 2,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top:10.0,bottom: 10.0,right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:[
                                const SizedBox(width:15,),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: RotatedBox
                                    (
                                    quarterTurns: 1,
                                    child: Text(serviceList[index].status.toString().toUpperCase(),textAlign: TextAlign.center,overflow: TextOverflow.fade,
                                           style:TextStyle(color:serviceList[index].status.toString()==types[1] ?
                                           Colors.green : serviceList[index].status.toString()==types[2] ?
                                           Colors.blue :  serviceList[index].status.toString()==types[3] ?
                                           Colors.orange : serviceList[index].status.toString()==types[4] ?
                                           Colors.lightBlue : Colors.red,
                                           fontWeight: FontWeight.w500,
                                           // fontFamily:'Metropolis',
                                           fontSize: 12.sp),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15,),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Complaint #:",
                                          style:TextStyle(
                                              fontSize:14.sp,
                                              // fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)
                                          ),
                                          const SizedBox(width:3,),
                                          Expanded(child: Text(_ygServiceProvider.myServices![index].ygserviceId.toString() ,
                                                         style:TextStyle(
                                                             fontSize:12.sp,
                                                             // fontFamily: 'Metropolis',
                                                             fontWeight: FontWeight.w600,
                                                             color: Colors.black)
                                          ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text("Type:",
                                          style:TextStyle(
                                              fontSize:14.sp,
                                              // fontFamily: 'Metropolis',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black)
                                          ),
                                          const SizedBox(width:3,),
                                          Expanded(child: Text(_ygServiceProvider.myServices![index].ygserviceDetails.toString() ,
                                                          style:TextStyle(
                                                              fontSize:12.sp,
                                                              // fontFamily: 'Metropolis',
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.grey.shade600)
                                          )
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 5,),
                                      Row(

                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [

                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.calendar_today_rounded,color: Colors.green,size: 22,),
                                                const SizedBox(width: 3,),
                                                Text(dateTime?[0].toString() ?? "" ,
                                                style:TextStyle(
                                                    fontSize:12.sp,
                                                    // fontFamily: 'Metropolis',
                                                    fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade600)
                                                ),
                                              ],
                                            ),
                                          ),

                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.timer_outlined,color: Colors.green,size: 22,),
                                                const SizedBox(width: 3,),
                                                Text(dateTime?[1].toString() ?? ""  ,
                                                style:TextStyle(
                                                    fontSize:12.sp,
                                                    // fontFamily: 'Metropolis',
                                                    fontWeight: FontWeight.w500,
                                                color: Colors.grey.shade600)
                                                ),
                                              ],
                                            ),
                                          ),
                                       ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Align(alignment:Alignment.centerRight,
                                          child: GestureDetector(
                                            onTap: (){
                                              openServiceDetailScreen(context,_ygServiceProvider.myServices![index]);
                                            },
                                          child: Text("View Details",
                                                 style: TextStyle(
                                                     fontSize: 12.sp,
                                                     // fontFamily: 'Metropolis',
                                                     fontWeight:FontWeight.w500,
                                                 color: Colors.green),
                                          )
                                          )
                                      )

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


