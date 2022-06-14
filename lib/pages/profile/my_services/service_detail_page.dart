
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/helper_utils/app_images.dart';

import '../../../elements/custom_header.dart';
import '../../../helper_utils/app_colors.dart';
import '../../../model/response/yg_services/my_yg_services_response.dart';
class ServiceDetailPage extends StatefulWidget {
  final MyYgServices servicesDetails;
  const ServiceDetailPage({Key? key,required this.servicesDetails}) : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> types=["Total","Resolved","InProgress","Re-Opened","Others"];
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
        appBar: appBar(context,"Details"),
        body:SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Complaint #:",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                        const SizedBox(width: 3,),
                        Text(widget.servicesDetails.ygserviceId.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500)),
                      ],
                    ),

                    Row(
                      children: [
                        Text("Status:",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                        const SizedBox(width: 3,),
                        // Text(widget.servicesDetails.status.toString().toUpperCase(),textAlign: TextAlign.center,overflow: TextOverflow.fade,style:TextStyle(
                        //     color:widget.servicesDetails.status.toString()==types[1] ? lightBlueTabs :
                        //     widget.servicesDetails.status.toString()==types[2] ? Colors.blue :
                        //     widget.servicesDetails.status.toString()==types[3] ? Colors.orange :
                        //     widget.servicesDetails.status.toString()==types[4] ? Colors.lightBlue : Colors.red,
                        //     fontWeight: FontWeight.w600,fontSize: 12.sp
                        // ),
                        // ),
                        Text("Resolved".toUpperCase(),textAlign: TextAlign.center,overflow: TextOverflow.fade,style:TextStyle(
                            color:  lightBlueTabs ,
                            fontWeight: FontWeight.w600,fontSize: 12.sp
                        ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Address:",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                        const SizedBox(width: 3,),
                        Text(widget.servicesDetails.ygserviceAddress.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500)),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Landmark:",textAlign:TextAlign.start,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                        const SizedBox(width: 3,),
                        Text(widget.servicesDetails.ygserviceNearestLandmark.toString(),textAlign: TextAlign.center,overflow: TextOverflow.fade,style:TextStyle(
                            color:Colors.grey.shade500,
                            fontWeight: FontWeight.w500,fontSize: 12.sp
                        ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 5,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Text("Complaint Type:",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                    const SizedBox(width: 3,),
                    Expanded(child: Text(widget.servicesDetails.ygserviceDetails.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500))),
                  ],
                ),

                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Complaint Sub Type :",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                    const SizedBox(width: 3,),
                    Expanded(child: Text(widget.servicesDetails.ygserviceSpecialInstruction.toString(),textAlign: TextAlign.start ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500))),
                  ],
                ),

                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Contact Name :",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                    const SizedBox(width: 3,),
                    Expanded(child: Text(widget.servicesDetails.ygserviceCompanyName.toString(),textAlign: TextAlign.start ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500))),
                  ],
                ),
                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Contact Number :",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                    const SizedBox(width: 3,),
                    Expanded(child: Text(widget.servicesDetails.ygserviceContactNumber.toString(),textAlign: TextAlign.start ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500))),
                  ],
                ),

                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Contact Email :",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                    const SizedBox(width: 3,),
                    Expanded(child: Text(widget.servicesDetails.ygserviceEmail.toString(),textAlign: TextAlign.start ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500))),
                  ],
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //
                //     Text("Comments :",style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w600,color: Colors.black87)),
                //     const SizedBox(width: 3,),
                //     Expanded(child: Text("Wires around the pole are not arranged properly and some of the wires are too loose that they can touch "
                //         "any vehicle or any passing object",textAlign: TextAlign.start ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500))),
                //   ],
                // ),

                const SizedBox(height: 5,),
                Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(

                      flex: 1,
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today_rounded,color: lightBlueTabs,size: 20,),
                          const SizedBox(width: 3,),
                          Text(widget.servicesDetails.ygserviceSuitableDatetime.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500)),
                        ],
                      ),
                    ),

                    // Row(
                    //
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Icon(Icons.timer_outlined,color: lightBlueTabs,size: 20,),
                    //     const SizedBox(width: 3,),
                    //     Text(widget.servicesDetails.time.toString() ,style:TextStyle(fontSize:12.sp,fontWeight: FontWeight.w500,color: Colors.grey.shade500)),
                    //   ],
                    // ),

                  ],
                ),
                // const SizedBox(height: 10,),
                // Text("Complaint Pictures\t:",style:TextStyle(fontSize:14.sp,fontWeight: FontWeight.w600,color: lightBlueTabs)),
                // const SizedBox(width: 10,),
                // GridView.builder(
                //   shrinkWrap: true,
                //   itemCount: 3,
                //   itemBuilder: (context, index) => buildImageCard(index),
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 3,
                //     mainAxisSpacing: 14,
                //     childAspectRatio: 1.5,
                //     crossAxisSpacing: 6,
                //   ),
                // ),
                // const SizedBox(width: 10,),
                // Card(
                //   color: Colors.grey.shade200,
                //   shape:RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10)),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         GridView.builder(
                //           shrinkWrap: true,
                //           itemCount: 3,
                //           itemBuilder: (context, index) => buildImageCard(index),
                //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 3,
                //             mainAxisSpacing: 14,
                //             childAspectRatio: 1.5,
                //             crossAxisSpacing: 6,
                //           ),
                //         ),
                //         const SizedBox(height: 10,),
                //         Text(widget.servicesDetails.status.toString().toUpperCase(),textAlign: TextAlign.center,overflow: TextOverflow.fade,style:TextStyle(
                //             color: Colors.black,
                //             fontWeight: FontWeight.w500,fontSize: 14.sp
                //         ),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.center
                //           ,
                //           children: [
                //             Expanded(
                //               child: Text("These complaint are not related to Municipal Authority.Please register your complaint with "
                //                   "Wapda office. ",textAlign: TextAlign.start,overflow: TextOverflow.fade,style:TextStyle(
                //                   color: Colors.grey.shade500,
                //                   fontWeight: FontWeight.w500,fontSize: 12.sp
                //               ),
                //               ),
                //             ),
                //             Icon(Icons.thumb_down,size: 25,color: lightBlueTabs,),
                //             Container(
                //               height: 20.0,
                //               width: 2.0,
                //               color: lightBlueTabs,
                //               margin: const EdgeInsets.only(left: 3.0, right: 3.0),
                //             ),
                //             Icon(Icons.thumb_up,size: 25,color: lightBlueTabs,)
                //           ],
                //         ),
                //         const SizedBox(height: 10,),
                //         Text(widget.servicesDetails.date.toString()+"\t"+widget.servicesDetails.time.toString(),textAlign: TextAlign.start,overflow: TextOverflow.fade,style:TextStyle(
                //             color: Colors.grey.shade500,
                //             fontWeight: FontWeight.w500,fontSize: 12.sp
                //         ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImageCard(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage(placeHolder),
            fit: BoxFit.cover,
          ),
        ),

      ),
    );
  }

}


