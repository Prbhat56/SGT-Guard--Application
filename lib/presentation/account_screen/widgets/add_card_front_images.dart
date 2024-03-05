import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/presentation/widgets/custom_bottom_model_sheet.dart';
import 'package:sgt/presentation/widgets/dotted_choose_file_widget.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:http/http.dart' as http;
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFrontCardImage extends StatefulWidget {
  String baseUrl;
  String imgUrl;
  AddFrontCardImage({super.key, required this.baseUrl, required this.imgUrl});

  @override
  State<AddFrontCardImage> createState() => _AddFrontCardImageState();
}

class _AddFrontCardImageState extends State<AddFrontCardImage> {
  File? image;
  final _picker = ImagePicker();

  Future pickGalleryImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      print(image);
      setState(() {
        uploadImage();
      });
    } else {
      var snackBar = SnackBar(content: Text('Something went wrong'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future pickCameraImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      print(image);
      setState(() {
        uploadImage();
      });
    } else {
      var snackBar = SnackBar(content: Text('Something went wrong'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> uploadImage() async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: CircularProgressIndicator());
        }));

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    String apiUrl = baseUrl + apiRoutes['updateProfilePic']!;
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));

    var multipart = new http.MultipartFile('front_side_id_card', stream, length,
        filename: image!.path.split('/').last);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.files.add(multipart);

    var response = await request.send();
    print(response.stream.toString());

    //final respStr = await response.stream.bytesToString();
    if (response.statusCode == 201) {
      setState(() {
        Navigator.of(context).pop();
        Navigator.pop(context);
      });
      print('Image Uploaded');
    } else {
      setState(() {
        Navigator.of(context).pop();
        Navigator.pop(context);
      });
      print('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.imgUrl != ""
        ? Edit_Image(context)
        : image != null
            ? Pick_Image(context)
            : GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      builder: (context) {
                        return CustomBottomModelSheet(
                          cameraClick: () {
                            pickCameraImage();
                          },
                          galleryClick: () {
                            pickGalleryImage();
                          },
                        );
                      });
                },
                child: DottedChooseFileWidget(
                    title: 'Upload\n Guard ID card', height: 60),
              ));
  }

  Stack Edit_Image(BuildContext context) {
    return Stack(children: [
      Container(
          height: 180,
          width: MediaQuery.of(context).size.width * .9,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)),
          child: image != null
              ? Image.file(
                  File(image!.path).absolute,
                  fit: BoxFit.fill,
                  height: 180,
                  width: MediaQuery.of(context).size.width * .9,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/sgt_logo.jpg',
                      fit: BoxFit.cover,
                    );
                  },
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      imageUrl: widget.baseUrl + '/' + widget.imgUrl,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Center(
                            child: const CircularProgressIndicator(
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                      errorWidget: (context, url, error) => Image.asset(
                            'assets/sgt_logo.jpg',
                            fit: BoxFit.fill,
                          )),
                )),
      Positioned(
        bottom: 0,
        right: 0,
        child: InkWell(
          onTap: () {
            //showing bottom model sheet to upload image
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                builder: (context) {
                  return CustomBottomModelSheet(
                    cameraClick: () {
                      pickCameraImage();
                    },
                    galleryClick: () {
                      pickGalleryImage();
                    },
                  );
                });
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: CustomTheme.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white)),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    ]);
  }

  Stack Pick_Image(BuildContext context) {
    return Stack(children: [
      Container(
        height: 180,
        width: MediaQuery.of(context).size.width * .9,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        child: Image.file(
          File(image!.path).absolute,
          fit: BoxFit.fill,
          height: 180,
          width: MediaQuery.of(context).size.width * .9,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/sgt_logo.jpg',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: InkWell(
          onTap: () {
            //showing bottom model sheet to upload image
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                builder: (context) {
                  return CustomBottomModelSheet(
                    cameraClick: () {
                      pickCameraImage();
                    },
                    galleryClick: () {
                      pickGalleryImage();
                    },
                  );
                });
          },
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: CustomTheme.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.white)),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ),
    ]);
  }
}
