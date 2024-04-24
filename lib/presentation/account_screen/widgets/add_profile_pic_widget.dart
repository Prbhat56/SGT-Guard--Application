import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/custom_theme.dart';
import '../../widgets/custom_bottom_model_sheet.dart';
import 'add_profilepic_icon.dart';
import 'package:http/http.dart' as http;
import 'package:http/src/multipart_file.dart';

class AddProfilePicWidget extends StatefulWidget {
  final ValueChanged<http.MultipartFile> onProfilePicChange;
  String baseUrl;
  String imgUrl;
  AddProfilePicWidget({super.key, required this.baseUrl, required this.imgUrl, required this.onProfilePicChange,});

  @override
  State<AddProfilePicWidget> createState() => _AddProfilePicWidgetState();
}

class _AddProfilePicWidgetState extends State<AddProfilePicWidget> {
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
    // String apiUrl = baseUrl + apiRoutes['updateProfilePic']!;
    // var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));

    var multipart = new http.MultipartFile('avatar', stream, length,
        filename: image!.path.split('/').last);
    widget.onProfilePicChange(multipart);
      Navigator.of(context).pop();
        Navigator.pop(context);

    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    // request.files.add(multipart);

    // var response = await request.send();
    // print(response.stream.toString());

    // //final respStr = await response.stream.bytesToString();
    // if (response.statusCode == 201) {
    //   setState(() {
    //     Navigator.of(context).pop();
    //     Navigator.pop(context);
    //   });
    //   print('Image Uploaded');
    // } else {
    //   setState(() {
    //     Navigator.of(context).pop();
    //     Navigator.pop(context);
    //   });
    //   print('Failed');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image != null
            ? CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.file(
                    File(image!.path).absolute,
                    fit: BoxFit.fill,
                    width: 140,
                    height: 140,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/sgt_logo.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                radius: 70,
                backgroundColor: CustomTheme.grey,
              )
            : CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: CachedNetworkImage(
                      imageUrl: widget.baseUrl +
                              '/' +
                              widget.imgUrl,
                      fit: BoxFit.fill,
                      width: 140,
                      height: 140,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                            strokeCap: StrokeCap.round,
                          ),
                      errorWidget: (context, url, error) => Image.asset(
                            'assets/sgt_logo.jpg',
                            fit: BoxFit.fill,
                          )),
                ),
                radius: 70,
                backgroundColor: Colors.transparent,
              ),
        Positioned(
          top: 100,
          left: 100,
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
            child: AddProfilePicIcon(),
          ),
        ),
      ],
    );
  }
}
