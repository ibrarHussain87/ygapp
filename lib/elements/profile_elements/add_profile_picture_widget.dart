import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yg_app/locators.dart';
import 'package:yg_app/providers/profile_providers/profile_info_provider.dart';

class AddProfilePictureWidget extends StatefulWidget {
  final int? imageCount;
  final Function? callbackImages;

  const AddProfilePictureWidget(
      {Key? key, required this.imageCount, required this.callbackImages})
      : super(key: key);

  @override
  _AddProfilePictureWidgetState createState() =>
      _AddProfilePictureWidgetState();
}

class _AddProfilePictureWidgetState extends State<AddProfilePictureWidget> {
  PickedFile? imageFile;
  List<PickedFile>? imageFiles = [];
  bool setButtonVisibility = true;
  bool listViewVisibility = false;
  final _profileInfoProvider = locator<ProfileInfoProvider>();

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _profileInfoProvider.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _profileInfoProvider.getSyncedData();
  }

  @override
  Widget build(BuildContext context) {
    return _profileInfoProvider.user != null
        ? Row(
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: imageFile?.path == null
                            ? Padding(
                                padding: EdgeInsets.all(2.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18.0),
                                  child: _profileInfoProvider
                                              .user!.profilePicture !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl: _profileInfoProvider
                                              .user!.profilePicture!,
                                          placeholder: (context, url) => SizedBox(
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                              ),
                                            ),
                                              height: 55.w,
                                              width: 55.w
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.wifi_tethering_error_outlined),
                                          height: 55.w,
                                          width: 55.w,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset(
                                          'images/image_not_available.png',
                                          height: 55.w,
                                          width: 55.w,
                                          fit: BoxFit.fill),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(2.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18.0),
                                  child: Image.file(
                                    File(imageFile!.path),
                                    width: 55.w,
                                    height: 55.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        : Container();
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
    Navigator.pop(context);
    widget.callbackImages!(imageFile);
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
    Navigator.pop(context);
    widget.callbackImages!(imageFile);
  }
}
