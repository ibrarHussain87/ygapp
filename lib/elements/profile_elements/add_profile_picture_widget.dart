import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddProfilePictureWidget extends StatefulWidget {

  final int? imageCount;
  final Function? callbackImages;

  const AddProfilePictureWidget({Key? key, required this.imageCount,required this.callbackImages}) : super(key: key);

  @override
  _AddProfilePictureWidgetState createState() => _AddProfilePictureWidgetState();
}

class _AddProfilePictureWidgetState extends State<AddProfilePictureWidget> {

  PickedFile? imageFile;
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
                    title: const Text("Camera"),
                    leading: const Icon(
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
        // Visibility(
        //   visible: listViewVisibility,
        //   child: SizedBox(
        //     height: 55.w,
        //     child: ListView.builder(
        //         itemCount: imageFiles!.length,
        //         scrollDirection: Axis.horizontal,
        //         shrinkWrap: true,
        //         itemBuilder: (context, position) {
        //           return Padding(
        //             padding: EdgeInsets.all(2.w),
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(18.0),
        //               child: Image.file(
        //                 File(imageFiles![position].path),
        //                 width: 55.w,
        //                 height: 55.w,
        //                 fit: BoxFit.fill,
        //               ),
        //             ),
        //           );
        //         }),
        //   ),
        // ),
        Visibility(
          // visible: setButtonVisibility,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _showChoiceDialog(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child:      ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: imageFile?.path==null ? Padding(
                    padding: EdgeInsets.all(2.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child: Image.asset('images/img_dummy_profile.png',
                          height: 55.w,
                          width: 55.w,
                          fit: BoxFit.fill,
                      ),
                    ),
                  ) : Padding(
                    padding: EdgeInsets.all(2.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child: Image.file(
                        File(imageFile!.path),
                        width: 55.w,
                        height: 55.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
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
      // imageFiles!.add(pickedFile);
      // imageFiles!.length == widget.imageCount
      //     ? setButtonVisibility = false
      //     : setButtonVisibility = true;
      // listViewVisibility = true;
    });
    widget.callbackImages!(imageFile);
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

