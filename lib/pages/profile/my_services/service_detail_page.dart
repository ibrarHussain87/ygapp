import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/app_database/app_database_instance.dart';
import 'package:yg_app/elements/custom_header.dart';
import 'package:yg_app/elements/title_text_widget.dart';
import 'package:yg_app/helper_utils/app_images.dart';
import 'package:yg_app/helper_utils/util.dart';

import '../../../elements/custom_header.dart';

import '../../../api_services/api_service_class.dart';
import '../../../helper_utils/app_colors.dart';
import '../../../model/response/yg_services/my_yg_services_response.dart';
import '../../../model/services_model.dart';
class ServiceDetailPage extends StatefulWidget {
  final MyYgServices servicesDetails;
  const ServiceDetailPage({Key? key,required this.servicesDetails}) : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<String>? dateTime=[];
  @override
  void initState() {
    super.initState();

   dateTime=widget.servicesDetails.ygserviceSuitableDatetime?.split(' ');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
  var definedSize=6.sp;
  var definedFontSize=14.sp;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset:false,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: appBar(context,"Details"),

        body:SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 5.0,top: 12.0),
                  child: Text("User Details",style:TextStyle(fontSize:15.sp,fontFamily: 'Metropolis',fontWeight: FontWeight.w600,color: Colors.black)),
                ),

                Card(
                    shape:RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey.shade200,
                            width: 1,
                            style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2,
                    child:Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Contact Name ",style:TextStyle(fontSize:definedFontSize,fontFamily: 'Metropolis',fontWeight: FontWeight.w600,color: Colors.black)),
                           SizedBox(height: definedSize,),
                          Text(widget.servicesDetails.ygserviceName ?? "N/A",textAlign: TextAlign.start ,style:TextStyle(
                              fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),

                           SizedBox(height: definedSize,),

                          Text("Contact Number ",style:TextStyle(fontSize:definedFontSize,fontFamily: 'Metropolis',fontWeight: FontWeight.w600,color: Colors.black)),
                           SizedBox(height: definedSize,),
                          Text(widget.servicesDetails.ygserviceContactNumber.toString(),textAlign: TextAlign.start ,
                              style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),

                          SizedBox(height: definedSize,),

                          Text("Contact Email ",style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w600,fontFamily: 'Metropolis',color: Colors.black)),
                           SizedBox(height: definedSize,),
                          Text(widget.servicesDetails.ygserviceEmail.toString(),textAlign: TextAlign.start ,
                              style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),

                          SizedBox(height: definedSize,),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Address",style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w600,fontFamily: 'Metropolis',color: Colors.black)),
                                    SizedBox(height:definedSize,),
                                    Text(widget.servicesDetails.ygserviceAddress.toString() ,
                                        style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),
                                  ],
                                ),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Landmark",textAlign:TextAlign.start,style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w600,fontFamily: 'Metropolis',color: Colors.black)),
                                  SizedBox(height:definedSize,),
                                  Text(widget.servicesDetails.ygserviceNearestLandmark ?? "N/A",textAlign: TextAlign.center,overflow: TextOverflow.fade,style:TextStyle(
                                      color:Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,fontFamily: 'Metropolis',fontSize: definedFontSize
                                  ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: definedSize,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.calendar_today_rounded,color: lightBlueTabs,size: 20,),
                                    const SizedBox(width: 3,),
                                    Text(dateTime?[0].toString() ?? '' ,style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),
                                  ],
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer_outlined,color: lightBlueTabs,size: 20,),
                                  const SizedBox(width: 1,),
                                  Text(dateTime?[1].toString() ?? '' ,style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),
                                ],
                              ),

                            ],
                          ),
                        ],
                      ),
                    )
                ),

                const SizedBox(height:10,),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 5.0,top: 8.0),
                  child: Text("Complaint Details",style:TextStyle(fontSize:15.sp,fontFamily: 'Metropolis',fontWeight: FontWeight.w600,color: Colors.black)),
                ),
                Card(
                  shape:RoundedRectangleBorder(
                      side: BorderSide(
                          color: Colors.grey.shade200,
                          width: 1,
                          style: BorderStyle.solid
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child:Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Complaint #",style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w600,fontFamily: 'Metropolis',color: Colors.black)),
                                  SizedBox(height: definedSize,),
                                  Text(widget.servicesDetails.ygserviceId.toString() ,
                                      style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),
                                ],
                              ),
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Status",style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w600,fontFamily: 'Metropolis',color: Colors.black)),
                                SizedBox(height: definedSize,),
                                Text("Resolved".toUpperCase(),textAlign: TextAlign.center,overflow: TextOverflow.fade,
                                  style:TextStyle(color:lightBlueTabs ,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',
                                      fontSize: 12.sp
                                ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: definedSize,),

                        Text("Complaint Type",style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w600,fontFamily: 'Metropolis',color: Colors.black)),
                        SizedBox(height: definedSize,),
                        Text(widget.servicesDetails.ygserviceDetails.toString() ,style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),

                        SizedBox(height: definedSize,),

                        Text("Details",style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w600,fontFamily: 'Metropolis',color: Colors.black)),
                        SizedBox(height: definedSize,),
                        Text(widget.servicesDetails.ygserviceDetails ?? "N/A",textAlign: TextAlign.start ,
                            style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),

                        SizedBox(height: definedSize,),

                        Text("Special Instructions",style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w600,fontFamily: 'Metropolis',color: Colors.black)),
                        SizedBox(height: definedSize,),
                        Text(widget.servicesDetails.ygserviceSpecialInstruction ?? "N/A",textAlign: TextAlign.start ,
                            style:TextStyle(fontSize:definedFontSize,fontWeight: FontWeight.w500,fontFamily: 'Metropolis',color: Colors.grey.shade600)),

                      ],
                    ),
                  )
                ),
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


