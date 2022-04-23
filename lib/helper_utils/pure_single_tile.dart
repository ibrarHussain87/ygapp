import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';

import '../elements/yg_text_form_field.dart';
import '../model/response/fabric_response/sync/fabric_sync_response.dart';

class PureTileWidget extends StatefulWidget {
  final Function? callback;
  final List<dynamic> listOfItems;
  final FabricBlends? selectedIndex;


  const PureTileWidget(
      {Key? key,
        required this.callback,
        required this.listOfItems,
        this.selectedIndex,
      })
      : super(key: key);

  @override
  PureTileWidgetState createState() => PureTileWidgetState();
}

class PureTileWidgetState extends State<PureTileWidget> {

  var looger = Logger();
  var width;

  FabricBlends? title=FabricBlends();



  @override
  void initState() {
    title=widget.selectedIndex;


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    return SizedBox(
      width:width ,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return Container(height: 8,);
        },
        scrollDirection: Axis.vertical,
        itemCount: widget.listOfItems.length,
        itemBuilder: (context, index) {
          return buildGrid(index);
        },
      ),
    );
  }

  Widget buildGrid(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          if(title==widget.listOfItems[index])
          {
            title=null;

          }
          else
          {
            title=widget.listOfItems[index];


          }
        });
        widget.callback!(widget.listOfItems[index]);
        looger.e(widget.listOfItems[index].toString());
      },
      child: Container(
        width: width,
        height: 30,
        child: Row(
          children:[
            Container(
              height: 35,
              width: width*0.4,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  color: title==widget.listOfItems[index]
                      ? lightBlueTabs.withOpacity(0.1)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.all(Radius.circular(24.w))),
              child: Center(
                child: Text(
                  widget.listOfItems[index].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 11.sp,
                      color: title==widget.listOfItems[index] ? lightBlueTabs : Colors.black54),
                ),
              ),
            ),

          ]

        ),
      ),
    );
  }


}
