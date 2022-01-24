import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddPictureWidget extends StatefulWidget {

  final int? imageCount;
  final Function? callbackImages;

  const AddPictureWidget({Key? key, required this.imageCount,required this.callbackImages}) : super(key: key);

  @override
  _AddPictureWidgetState createState() => _AddPictureWidgetState();
}

class _AddPictureWidgetState extends State<AddPictureWidget> {

  PickedFile? imageFile = null;
  List<PickedFile>? imageFiles = [];
  bool setButtonVisibility = true;
  bool listViewVisibility = false;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: listViewVisibility,
          child: SizedBox(
            height: 100.w,
            child: ListView.builder(
                itemCount: imageFiles!.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  return Padding(
                    padding: EdgeInsets.all(2.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        File(imageFiles![position].path),
                        width: 100.w,
                        height: 100.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          ),
        ),
        Visibility(
          visible: setButtonVisibility,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _showChoiceDialog(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  height: 100.w,
                  width: 100.w,
                  color: Colors.grey.shade200,
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Image.asset(
                  'images/take_image_place_holder.png',
                  width: 24.w,
                  height: 24.w,
                ),
                    )),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
      imageFiles!.add(pickedFile);
      imageFiles!.length == widget.imageCount
          ? setButtonVisibility = false
          : setButtonVisibility = true;
      listViewVisibility = true;
    });
    widget.callbackImages!(imageFiles);

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
      imageFiles!.add(pickedFile);
      imageFiles!.length == widget.imageCount
          ? setButtonVisibility = false
          : setButtonVisibility = true;
      listViewVisibility = true;
    });
    widget.callbackImages!(imageFiles);
    Navigator.pop(context);
  }
}

// class _AddPictureWidgetState extends State<AddPictureWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class AddPictureWidget extends StatefulWidget {
//
//   int? imageCount;
//
//   const AddPictureWidget({Key? key, required this.imageCount})
//       : super(key: key);
//
//   @override
//   _AddPictureWidgetState createState() =>
//       _FiberSpecificationComponentState();
//
//   @override
//   State createState() {
//     return AddPictureWidgetState();
//   }
// }
