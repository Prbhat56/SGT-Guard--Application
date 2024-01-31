import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_bottom_model_sheet.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_textfield_widget.dart';
import 'package:sgt/presentation/widgets/dotted_choose_file_widget.dart';
import 'package:sgt/presentation/widgets/media_uploading_widget.dart';
import 'package:sgt/presentation/work_report_screen/widget/report_submit_success.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class StaticMaintenanceReportScreen extends StatefulWidget {
  String? propId;
  String? propName;
  StaticMaintenanceReportScreen(
      {super.key, required this.propId, required this.propName});

  static _StaticMaintenanceReportScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_StaticMaintenanceReportScreenState>();

  @override
  State<StaticMaintenanceReportScreen> createState() =>
      _StaticMaintenanceReportScreenState();
}

class _StaticMaintenanceReportScreenState
    extends State<StaticMaintenanceReportScreen> {
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _notesController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List imageNames = [];

  //pick image from gallery
  void pickGalleryImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      for (var i = 0; i < images.length; i++) {
        imageFileList?.add(images[i]);
        imageNames.add(images[i].name);
      }
      setState(() {
        Navigator.of(context).pop();
      });
    } else {
      var snackBar = SnackBar(content: Text('Something went wrong'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  //pick image from camera
  Future pickCameraImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      imageFileList?.add(photo);
      imageNames.add(path.dirname(photo.path));
      setState(() {
        Navigator.of(context).pop();
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

    String apiUrl = baseUrl + apiRoutes['maintenanceReport']!;
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.fields['property_id'] = widget.propId.toString();
    request.fields['title'] = _titleController.text.toString();
    request.fields['notes'] = _notesController.text.toString();

    if (imageFileList!.length > 0) {
      for (var i = 0; i < imageFileList!.length; i++) {
        var stream = new http.ByteStream(imageFileList![i].openRead());
        stream.cast();

        var length = await imageFileList![i].length();

        request.files.add(http.MultipartFile('media_files[]', stream, length,
            filename: imageFileList![i].path.split("/").last));
      }
    }

    var response = await request.send();
    print(response.stream.toString());

    if (response.statusCode == 201) {
      setState(() {
        Navigator.of(context).pop();
      });
      print('Image Uploaded');
      screenNavigator(context, ReportSubmitSuccess());
    } else {
      setState(() {
        Navigator.of(context).pop();
      });
      print('Failed');
    }
  }

  @override
  void initState() {
    super.initState();
    _propertyNameController.text = widget.propName.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _propertyNameController.dispose();
    _titleController.dispose();
    _notesController.dispose();
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Property Name \*',
                    style: CustomTheme.textField_Headertext_Style,
                    textScaleFactor: 1.0,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: seconderyMediumColor),
                    child: TextFormField(
                      controller: _propertyNameController,
                      readOnly: true,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(top: 10, bottom: 0, left: 10),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: primaryColor)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: seconderyMediumColor)),
                          fillColor: seconderyMediumColor,
                          hintText: 'Enter Property Name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          focusColor: primaryColor,
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: primaryColor,
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                controller: _titleController,
                textfieldTitle: 'Title \*',
                hintText: 'Enter Title',
                isFilled: false,
              ),
              CustomTextField(
                controller: _notesController,
                textfieldTitle: 'Notes \*',
                hintText: 'Enter Note Here',
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
                      height: 130 * imageFileList!.length.toDouble(),
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
                  child: DottedChooseFileWidget(
                    title: 'Choose a file',
                    height: 50,
                  )),
              imageFileList!.isNotEmpty
                  ? Container()
                  : SizedBox(
                      height: 117.h,
                    ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: CustomButtonWidget(
                      buttonTitle: 'Send',
                      onBtnPress: () {
                        if (_propertyNameController.text.isEmpty) {
                          CommonService().openSnackBar(
                              'Please enter Property name', context);
                        } else if (_titleController.text.isEmpty) {
                          CommonService()
                              .openSnackBar('Please enter title', context);
                        } else if (_notesController.text.isEmpty) {
                          CommonService()
                              .openSnackBar('Please enter notes', context);
                        } else {
                          uploadImage();
                        }
                      }))
            ],
          ),
        )),
      ),
    );
  }
}
