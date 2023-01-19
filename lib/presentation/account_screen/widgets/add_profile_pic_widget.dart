import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../theme/custom_theme.dart';
import '../../widgets/custom_bottom_model_sheet.dart';
import 'add_profilepic_icon.dart';

class AddProfilePicWidget extends StatefulWidget {
  const AddProfilePicWidget({super.key});

  @override
  State<AddProfilePicWidget> createState() => _AddProfilePicWidgetState();
}

class _AddProfilePicWidgetState extends State<AddProfilePicWidget> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  void pickGprofilePic() async {
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  void pickCprofilePic() async {
    // Capture a photo
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
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
                backgroundImage: const NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
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
