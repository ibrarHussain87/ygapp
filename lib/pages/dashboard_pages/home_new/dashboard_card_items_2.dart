import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yg_app/helper_utils/app_colors.dart';
import 'package:yg_app/model/home_model.dart';

class HomeCardWidget2 extends StatefulWidget {
  final Function? callback;
  final List<HomeModel> listOfItems;
  final int? spanCount;

  const HomeCardWidget2(
      {Key? key,
        required this.spanCount,
        required this.listOfItems,
        required this.callback})
      : super(key: key);

  @override
  HomeCardWidgetState createState() => HomeCardWidgetState();
}

class HomeCardWidgetState extends State<HomeCardWidget2> {
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
    return StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 6,
        children: List.generate(widget.listOfItems.length, (index) {
          return StaggeredGridTile.count(
            crossAxisCellCount: (index + 1) % 5 == 0 ? 4 : 2,
            mainAxisCellCount: 1.6,
            child: buildGrid(index),
          );
        }));

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
        if (!widget.listOfItems[index].isDisable!) {
          widget.callback!(widget.listOfItems[index]);
        }
      },
      child: buildCardContainer(index),
    );
  }

  Container buildCardContainer(int index) {
    return Container(
      // padding:const EdgeInsets.only(left:5.0,right: 5,,
      width: double.maxFinite,
      // decoration: BoxDecoration(
      //     border: Border.all(
      //       color: Colors.grey,
      //     ),
      //     borderRadius: BorderRadius.all(Radius.circular(15.w))),

      child: Card(
        color: widget.listOfItems[index].cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
            // side: BorderSide(
            //     color: Colors.grey.shade300,
            //     width: 0.5,
            //     style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // FlutterLogo(),
              Image.asset(
                widget.listOfItems[index].image.toString(),
                scale: 2,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.listOfItems[index].title.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.merge(TextStyle(fontSize: 13.0, color: greyBlack)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
