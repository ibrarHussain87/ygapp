import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/home_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class HomeCardWidget extends StatefulWidget {
  final Function? callback;
  final List<HomeModel> listOfItems;
  final int? spanCount;

  const HomeCardWidget(
      {Key? key,
        required this.spanCount,
        required this.listOfItems,
        required this.callback
      })
      : super(key: key);

  @override
  HomeCardWidgetState createState() => HomeCardWidgetState();
}

class HomeCardWidgetState extends State<HomeCardWidget> {
  late double aspectRatio;
  @override
  void initState() {
    if (widget.spanCount == 2) {
      aspectRatio = 1.5;
    } else if (widget.spanCount == 3) {
      aspectRatio = 2.9;
    } else {
      aspectRatio = 2.2;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 10,

      children: List.generate(widget.listOfItems.length, (index){
      return StaggeredGridTile.count(
        crossAxisCellCount: (index+1)%5 == 0 ? 4 : 2,
        mainAxisCellCount: 1.6,
        child: buildGrid(index),
      );
  })

    );

    // return GridView.builder(
    //   physics: const NeverScrollableScrollPhysics(),
    //   shrinkWrap: true,
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisSpacing: widget.spanCount! == 2 ? 10 : 6,
    //       mainAxisSpacing: 4,
    //     childAspectRatio: 1.2,
    //       crossAxisCount: widget.listOfItems.length % 2 != 0 && widget.listOfItems.length - 1 == index ? 1 : widget.spanCount!,
    //       // childAspectRatio: aspectRatio
    //   ),
    //   itemCount: widget.listOfItems.length,
    //   itemBuilder: (context, index) {
    //     return  buildGrid(index);
    //   },
    //
    // );
  }



  Widget buildGrid(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.callback!(widget.listOfItems[index]);
      },
      child: buildCardContainer(index),
    );
  }



  Container buildCardContainer( int index) {
    return Container(
      // padding:const EdgeInsets.only(left:5.0,right: 5,,
      width: double.maxFinite,
      // decoration: BoxDecoration(
      //     border: Border.all(
      //       color: Colors.grey,
      //     ),
      //     borderRadius: BorderRadius.all(Radius.circular(15.w))),
      child: Card(
        elevation: 2,
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)

        ),

        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // FlutterLogo(),
              Image.asset(
                widget.listOfItems[index].image.toString(),
            scale: 2,
              ),
              const SizedBox(height: 18,),
              Text(
                widget.listOfItems[index].title.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12.sp,
                    // fontFamily: 'Metropolis',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }


}