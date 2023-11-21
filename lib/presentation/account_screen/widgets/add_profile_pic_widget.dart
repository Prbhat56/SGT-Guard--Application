import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
import '../../../theme/custom_theme.dart';
import '../../widgets/custom_bottom_model_sheet.dart';
import 'add_profilepic_icon.dart';
import 'package:http/http.dart' as http;


var userD = jsonDecode(userDetail);
class AddProfilePicWidget extends StatefulWidget {
  const AddProfilePicWidget({super.key});

  @override
  State<AddProfilePicWidget> createState() => _AddProfilePicWidgetState();
}

class _AddProfilePicWidgetState extends State<AddProfilePicWidget> {
  // final ImagePicker _picker = ImagePicker();
  // File? imageFile ;

   File? imageFile;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future pickGprofilePic() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      setState(() {
        uploadImage();
      });
    } else {
      print('Something went wrong');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(imageFile!.openRead());
    stream.cast();

    var length = await imageFile!.length();

    var request = new http.MultipartRequest(
        'POST', Uri.parse('https://sgt-inhouse.myclientdemo.us/api/guard/update-profile-pic'));
    request.fields['avatar'] = 'avatar';

    var multipart = new http.MultipartFile('image', stream, length);
    request.files.add(multipart);

    var response = await request.send();

    print(response.stream.toString());

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print('Image Uploaded');
    } else {
      setState(() {
        showSpinner = false;
      });
      print('Failed');
    }
  }








  // void pickGprofilePic() async {
  //   // Pick an image
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       imageFile = File(image.path);
  //       print("gallery image file ==> $imageFile");
  //       print(image.path);
  //       var map = new Map<String, dynamic>();
  //       map['avatar'] = imageFile;
  //        var apiService = ApiCallMethodsService();
  //             apiService.post(apiRoutes['profileUpdate']!, map).then((value) {
  //             print("api response ==> $value");
  //             // apiService.updateUserDetails(value);
  //             Map<String, dynamic> jsonMap = json.decode(value);
  //             var commonService = CommonService();
  //               commonService.openSnackBar(jsonMap['message'], context);
  //               Navigator.pop(context);
  //         }).onError((error, stackTrace) {
  //               print(error);
  //           });
  //     });
  //   }
  // }

  void pickCprofilePic() async {
    // Capture a photo
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
         var map = new Map<String, dynamic>();
        map['avatar'] = photo.path;
         var apiService = ApiCallMethodsService();
              apiService.post(apiRoutes['profileUpdate']!, map).then((value) {
              print("api response ==> $value");
              // apiService.updateUserDetails(value);
              Map<String, dynamic> jsonMap = json.decode(value);
              var commonService = CommonService();
                commonService.openSnackBar(jsonMap['message'], context);
                Navigator.pop(context);
          }).onError((error, stackTrace) {
                print(error);
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageFile != null
            ? CircleAvatar(
                radius: 70,
                backgroundColor: CustomTheme.grey,
                backgroundImage: FileImage(File(imageFile!.path)),
              )
            : CircleAvatar(
                radius: 70,
                backgroundColor: CustomTheme.grey,
                backgroundImage:  AssetImage(
                  'assets/profile.svg'
                  // userD['image_base_url']+'/'+userD['user_details']['avatar'],  
                ),
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
                        pickCprofilePic();
                      },
                      galleryClick: () {
                        pickGprofilePic();
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
