import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/response/fiber_response/sync/sync_fiber_response.dart';
import 'package:yg_app/model/response/yarn_response/sync/yarn_sync_response.dart';
import 'package:yg_app/utils/strings.dart';
import 'package:yg_app/widgets/network_icon_widget.dart';

class MaterialListviewWidget extends StatefulWidget {

  final Function? onClickCallback;
  final List<dynamic>? listItem;

  const MaterialListviewWidget(
      {Key? key, required this.listItem, required this.onClickCallback})
      : super(key: key);

  @override
  _MaterialListviewWidgetState createState() =>
      _MaterialListviewWidgetState();
}

class _MaterialListviewWidgetState extends State<MaterialListviewWidget> {

  int checkedIndex = 0;
  int _selectedSegmentIndex = 1;

  @override
  void initState() {
    BroadcastReceiver().subscribe<int> // Data Type returned from publisher
      (AppStrings.segmentIndexBroadcast, (index) {
      setState(() {
        _selectedSegmentIndex = index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.06*MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: widget.listItem!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return buildListBody(index);
        },
      ),
    );
  }

  Widget buildListBody(int index) {
    bool checked = index == checkedIndex;
    String? name;
    if (widget.listItem is List<FiberMaterial>) {
       name = widget.listItem!.cast<FiberMaterial>()[index].fbmName;
    }else if(widget.listItem is List<Blends>){
      name = widget.listItem!.cast<Blends>()[index].blnName;
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          if(_selectedSegmentIndex == 1) {
            checkedIndex = index;
          }
        });
        widget.onClickCallback!(index);
      },
      child: Center(
        child: SizedBox(
          width: 0.15*MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              NetworkImageIconWidget(
                imageUrl: checked
                    ? 'https://static.thenounproject.com/png/18663-200.png'
                    : 'https://static.thenounproject.com/png/223920-200.png',
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: Text(
                  name!,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
