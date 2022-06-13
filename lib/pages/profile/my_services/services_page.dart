import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/custom_header.dart';

import '../../../elements/custom_header.dart';

import '../../../helper_utils/app_colors.dart';
import '../../../helper_utils/navigation_utils.dart';
import '../../../model/services_model.dart';
class MyServicesPage extends StatefulWidget {
  const MyServicesPage({Key? key}) : super(key: key);

  @override
  _MyServicesPageState createState() => _MyServicesPageState();
}

class _MyServicesPageState extends State<MyServicesPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> types=["Total","Resolved","InProgress","Re-Opened","Others"];
  List<ServicesModel> serviceList=
  [
    ServicesModel(id: "1",complaintNo: "38445-15591", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Regretted",date: "12-2-2022",time: "12:33 PM"),
    ServicesModel(id: "2",complaintNo: "82452-77592", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Resolved",date: "14-2-2022",time: "10:21 AM"),
    ServicesModel(id: "3",complaintNo: "58516-35521", type: 'Cleanliness and Beatifications',subType:"Cleanliness and Beatifications of parks, roads and chowks",status:"Resolved",date: "21-3-2022",time: "3:30 PM"),

  ];
  @override
  void initState() {
    super.initState();


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
            Row(
              children:[
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:  [
                              Text(types[0].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(
                                  color:Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),
                              ),
                              Text("3",
                                style:TextStyle(
                                  color:Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:  [
                              Text(types[1].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(
                                  color:lightBlueTabs,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),
                              ),
                              Text("2",
                                style:TextStyle(
                                  color:lightBlueTabs,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:  [
                              Text(types[2].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(
                                  color:Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),
                              ),
                              Text("0",
                                style:TextStyle(
                                  color:Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:  [
                              Text(types[3].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(
                                  color:Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),
                              ),
                              Text("0",
                                style:TextStyle(
                                  color:Colors.orange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)

                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:  [
                              Text(types[4].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:TextStyle(
                                  color:Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),
                              ),
                              Text("1",
                                style:TextStyle(
                                  color:Colors.lightBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 9.sp,

                                ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]
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

                  physics: const BouncingScrollPhysics(),
                  itemCount: serviceList.length,
                  shrinkWrap: true,
                  primary: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){

                      },
                      child: Card(
                      shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                        elevation: 3,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
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
                                        const SizedBox(width: 3,),
                                        Expanded(child: Text(serviceList[index].complaintNo.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87))),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Text("Type:",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.black87)),
                                        const SizedBox(width: 3,),
                                        Expanded(child: Text(serviceList[index].type.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.grey.shade500))),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text("Sub Category :",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.black87)),
                                        const SizedBox(width: 3,),
                                        Expanded(child: Text(serviceList[index].subType.toString(),textAlign: TextAlign.start ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.grey.shade500))),
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
                                              Text(serviceList[index].date.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.grey.shade500)),
                                            ],
                                          ),
                                        ),

                                        Row(

                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.timer_outlined,color: lightBlueTabs,size: 20,),
                                            const SizedBox(width: 3,),
                                            Text(serviceList[index].time.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.grey.shade500)),
                                          ],
                                        ),
                                     ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Align(alignment:Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: (){
                                            openServiceDetailScreen(context,serviceList[index]);
                                          },
                                        child: Text("View Details",style: TextStyle(fontSize: 10.sp,fontWeight:FontWeight.w500,color: lightBlueTabs),)))

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }





//   void _createCustomerSupportCall(BuildContext context) {
//
//     check().then((value) {
//       if (value) {
//         ProgressDialogUtil.showDialog(context, 'Please wait...');
//
//         Logger().e(_csRequestModel?.toJson());
//         ApiService.createCustomerService(_csRequestModel!).then((value) {
//
//           ProgressDialogUtil.hideDialog();
// //            if (value.errors != null) {
// //              value.errors!.forEach((key, error) {
// //                ScaffoldMessenger.of(context)
// //                    .showSnackBar(SnackBar(content: Text(error.toString())));
// //              });
// //            } else
//           if (value.status!) {
// //              AppDbInstance().getDbInstance().then((db) async {
// ////                await db.userDao.insertUser(value.data!.user!);
// //                await db.userDao.insertUser(value.data!);
// //              });
//
//
//             Fluttertoast.showToast(
//                 msg: value.message ?? "",
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.BOTTOM,
//                 timeInSecForIosWeb: 1);
//             Navigator.of(context).pop();
// //            Navigator.of(context).pushAndRemoveUntil(
// //                MaterialPageRoute(builder: (context) => const MainPage()),
// //                    (Route<dynamic> route) => false);
//           } else {
//
//             ProgressDialogUtil.hideDialog();
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(value.message ?? "")));
//           }
//         }).onError((error, stackTrace) {
//           ProgressDialogUtil.hideDialog();
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(error.toString())));
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("No internet available.".toString())));
//       }
//     });
//
//   }

}


