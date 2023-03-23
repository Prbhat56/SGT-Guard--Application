import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';
import '../widgets/custom_bottom_model_sheet.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import '../widgets/dotted_choose_file_widget.dart';
import '../widgets/media_uploading_widget.dart';
import 'package:path/path.dart' as path;
import 'widgets/add_profile_pic_widget.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  List imageNames = [];
  List<XFile>? imageFileList = [];
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Edit Account Details'),
        backgroundColor: white,
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Center(child: AddProfilePicWidget()),
                    Text(
                      'Personal',
                      style: CustomTheme.blackTextStyle(21),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'Name',
                      hintText: 'Jenny Doe',
                      readonly: true,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'Email',
                      hintText: 'johndoe@mail.com',
                      readonly: true,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'Phone',
                      hintText: '(808)628 8343',
                      readonly: true,
                    ),
                    Text(
                      'Address',
                      style: CustomTheme.blackTextStyle(21),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'Street',
                      hintText: 'Sample Street',
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'City',
                      hintText: 'Los Angeles',
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'State',
                      hintText: 'CA',
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'Zipcode',
                      hintText: '90045',
                    ),
                    Text(
                      'Upload Guard Card',
                      style: CustomTheme.blackTextStyle(21),
                    ),
                    SizedBox(
                      height: 20.h,
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
                    SizedBox(
                      height: 30,
                    ),
                    CustomButtonWidget(
                        buttonTitle: 'Verify',
                        onBtnPress: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        }),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
