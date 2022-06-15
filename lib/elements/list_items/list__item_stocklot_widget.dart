
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yg_app/model/stocklot_waste_model.dart';

import '../../helper_utils/app_colors.dart';

class ListItemStockLot extends StatefulWidget {
  final StocklotWasteModel stocklotWaste;
  final bool addMore;
  final Function callback;
  final int i;

  const ListItemStockLot(
      {Key? key,
      required this.stocklotWaste,
      required this.addMore,
      required this.callback,
      required this.i})
      : super(key: key);

  @override
  State<ListItemStockLot> createState() => _ListItemStockLotState();
}

class _ListItemStockLotState extends State<ListItemStockLot> {
  var _tapPosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      // decoration: BoxDecoration(
      //     border: Border.all(color: Colors.black12),
      //     borderRadius: BorderRadius.all(const Radius.circular(6))),
      child: Stack(
        children: [
          Positioned(
            child: GestureDetector(
              onTapDown: (details) {
                _tapPosition = details.globalPosition;
              },
              onTap: () {
                _showPopupMenu();
              },
              child: Icon(
                Icons.more_horiz,
                color: darkBlueChip,
                size: 16,
              ),
            ),
            top: 0,
            right: 0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Text(
                  widget.stocklotWaste.name!,
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Price",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.stocklotWaste.price!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Quantity",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.stocklotWaste.quantity!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Unit of Count",
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.stocklotWaste.unitOfCount??'',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  /*Container(
                width: MediaQuery.of(context).size.width*0.05,
                child: Visibility(
                  visible: */ /*addMore*/ /*true,
                  child: GestureDetector(
                    onTap: () => callback(stocklotWaste),
                    child: const Icon(
                      Icons.clear,
                      size: 12,
                    ),
                  ),
                ),
              ),*/
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPopupMenu() async {
    final RenderObject? overlay =
        Overlay.of(context)!.context.findRenderObject();
    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
          _tapPosition & const Size(40, 40), // smaller rect, the touch area
          Offset.zero &
              overlay!.semanticBounds.size // Bigger rect, the entire screen
          ),
      items: [
        const PopupMenuItem(
          value: 1,
          child: Text("Edit"),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text("Delete"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null
      if (value != null) {
        if (value == 2) {
          widget.callback(widget.stocklotWaste,value);
        }else if (value == 1) {
          widget.callback(widget.stocklotWaste,value);
        }
      }
    });
  }
}
