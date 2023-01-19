import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import '../../utils/const.dart';
import '../widgets/custom_bottom_model_sheet.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_textfield_widget.dart';
import '../widgets/dotted_choose_file_widget.dart';
import '../widgets/media_uploading_widget.dart';

class MaintenanceReportScreen extends StatefulWidget {
  const MaintenanceReportScreen({super.key});

  @override
  State<MaintenanceReportScreen> createState() =>
      _MaintenanceReportScreenState();
}

class _MaintenanceReportScreenState extends State<MaintenanceReportScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List imageNames = [];

  //pick image from camera
  void pickCameraImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      imageFileList?.add(photo);
      imageNames.add(path.dirname(photo.path));
      setState(() {});
    }
  }

//pick image from gallery
  void pickGalleryImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        imageFileList?.add(images[i]);
      }
      imageNames.add(images[0].name);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Maintenance Report'),
        backgroundColor: white,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                textfieldTitle: 'Property Name',
                hintText: 'Empire Polo Fields',
                isFilled: true,
              ),
              CustomTextField(
                textfieldTitle: 'Title',
                hintText: 'Something here',
                isFilled: false,
              ),
              CustomTextField(
                textfieldTitle: 'Notes',
                hintText: 'Something here',
                isFilled: false,
                maxLines: 5,
              ),
              imageFileList!.isNotEmpty
                  ? Text(
                      'Media',
                      style: TextStyle(fontSize: 17, color: primaryColor),
                    )
                  : Container(),
              imageFileList!.isNotEmpty
                  ? SizedBox(
                      height: 110 * imageFileList!.length.toDouble(),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: imageFileList!.length,
                          itemBuilder: (context, index) {
                            return MediaUploadingWidget(
                                imageFileList: imageFileList!,
                                imageNames: imageNames,
                                clickClose: () {
                                  setState(() {
                                    imageFileList!.removeAt(index);
                                  });
                                },
                                index: index);
                          }),
                    )
                  : Container(),
              Text(
                'Upload Record Sample',
                style: TextStyle(
                    fontSize: 17,
                    color: primaryColor,
                    fontWeight: FontWeight.w500),
                textScaleFactor: 1.0,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
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
                  child: DottedChooseFileWidget()),
              imageFileList!.isNotEmpty
                  ? Container()
                  : SizedBox(
                      height: 117.h,
                    ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: CustomButtonWidget(
                      buttonTitle: 'Send', onBtnPress: () {}))
            ],
          ),
        )),
      ),
    );
  }
}
