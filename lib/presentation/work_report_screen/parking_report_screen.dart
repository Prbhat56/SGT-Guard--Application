import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/presentation/time_sheet_screen/model/assigned_propertieslist_modal.dart';
import 'package:sgt/presentation/time_sheet_screen/model/today_active_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_textfield_parking_report.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/widget/propertieslist_picker.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/widget/task_picker.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/navigator_function.dart';
import '../../utils/const.dart';
import '../widgets/custom_bottom_model_sheet.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/custom_textfield_widget.dart';
import '../widgets/dotted_choose_file_widget.dart';
import '../widgets/media_uploading_widget.dart';
import 'widget/report_submit_success.dart';
import 'package:http/http.dart' as http;

class ParkingReportScreen extends StatefulWidget {
  const ParkingReportScreen({super.key});

  static _ParkingReportScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ParkingReportScreenState>();

  @override
  State<ParkingReportScreen> createState() => _ParkingReportScreenState();
}

class _ParkingReportScreenState extends State<ParkingReportScreen> {
  bool propertyClicked = false;
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _vehicleTypeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _lincenseController = TextEditingController();
  TextEditingController _stateMyController = TextEditingController();
  List<String> _dropdownItems = <String>['Yes', 'No'];
  String? towedValue = 'Yes';
  String? propertyName;
  String? propertyId;

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

    String apiUrl = baseUrl + apiRoutes['parkingReport']!;
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.fields['property_id'] = propertyId.toString();
    request.fields['title'] = _titleController.text.toString();
    request.fields['vehicle_make'] = _vehicleTypeController.text.toString();
    request.fields['vehicle_model'] = _modelController.text.toString();
    request.fields['vehicle_color'] = _colorController.text.toString();
    request.fields['license_number'] = _lincenseController.text.toString();
    request.fields['state'] = _stateMyController.text.toString();

    towedValue == 'Yes'
        ? request.fields['towed_status'] = '1'.toString()
        : request.fields['towed_status'] = '0'.toString();

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

    //final respStr = await response.stream.bytesToString();
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

  // List<TodaysDatum> reportDatum = [];
  List<AssignedDatum> reportDatum = [];
  String? imageBaseUrl;

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  // Future<TodayActiveModel> getTasks() async {
  //   try {
  //     EasyLoading.show();
  //     String apiUrl = baseUrl + apiRoutes['todaysActivePropertyList']!;
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     Map<String, String> myHeader = <String, String>{
  //       "Authorization": "Bearer ${prefs.getString('token')}",
  //     };
  //     var response = await http.get(Uri.parse(apiUrl), headers: myHeader);
  //     if (response.statusCode == 201) {
  //       final TodayActiveModel responseModel =
  //           todayModelFromJson(response.body);
  //       reportDatum = responseModel.data ?? [];
  //       print('Reports: $reportDatum');
  //       imageBaseUrl = responseModel.imageBaseUrl;
  //       EasyLoading.dismiss();
  //       return responseModel;
  //     } else {
  //       EasyLoading.dismiss();
  //       return TodayActiveModel(
  //           data: [], imageBaseUrl: '', status: response.statusCode);
  //     }
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     throw Exception(e.toString());
  //   }
  // }

  Future<AssignedPropertiesListModal> getTasks() async {
    try {
      EasyLoading.show();
      String apiUrl = baseUrl + apiRoutes['assignedPropertiesList']!;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, String> myHeader = <String, String>{
        "Authorization": "Bearer ${prefs.getString('token')}",
      };
      var response = await http.get(Uri.parse(apiUrl), headers: myHeader);
      if (response.statusCode == 201) {
        final AssignedPropertiesListModal responseModel =
            assignedPropertiesListModalFromJson(response.body);
        reportDatum = responseModel.data ?? [];
        print('Reports: $reportDatum');
        imageBaseUrl = responseModel.propertyImageBaseUrl;
        EasyLoading.dismiss();
        return responseModel;
      } else {
        EasyLoading.dismiss();
        return AssignedPropertiesListModal(
            data: [], propertyImageBaseUrl: '', status: response.statusCode);
      }
    } catch (e) {
      EasyLoading.dismiss();
      log('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _propertyNameController.dispose();
    _titleController.dispose();
    _vehicleTypeController.dispose();
    _modelController.dispose();
    _colorController.dispose();
    _lincenseController.dispose();
    _stateMyController.dispose();

    propertyName = "";
    propertyId = "";
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Parking Report'),
        backgroundColor: white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: 'Property Name',
                              style: TextStyle(
                                fontSize: 17,
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                            TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  color: Colors.red,
                                ))
                          ])),
                      // Text(
                      //   'Property Name \*',
                      //   style: CustomTheme.textField_Headertext_Style,
                      //   textScaleFactor: 1.0,
                      // ),
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
                              hintText: 'Select Assigned Property',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              focusColor: primaryColor,
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: primaryColor,
                              )),
                          onTap: () {
                            setState(() {
                              reportDatum.length > 0
                                  ? propertyClicked = !propertyClicked
                                  : CommonService().openSnackBar(
                                      'No Active Property Found', context);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  propertyClicked
                      ? PropertiesListPicker(
                          onCallback: (() {
                            setState(() {
                              propertyClicked = !propertyClicked;
                              _propertyNameController.text = propertyName ?? "";
                            });
                          }),
                          reportDatum: reportDatum,
                          imageBaseUrl: imageBaseUrl,
                        )
                      // CustomListPicker(
                      //     onCallback: (() {
                      //       setState(() {
                      //         propertyClicked = !propertyClicked;
                      //         _propertyNameController.text = propertyName ?? "";
                      //       });
                      //     }),
                      //     reportDatum: reportDatum,
                      //     imageBaseUrl: imageBaseUrl,
                      //   )
                      : Container(),
                  SizedBox(
                    height: 30,
                  ),
                  CustomParkingTextField(
                    controller: _titleController,
                    textfieldTitle: 'Title',
                    hintText: 'Enter Title',
                    isFilled: false,
                  ),
                  CustomParkingTextField(
                    controller: _vehicleTypeController,
                    textfieldTitle: 'Manufacturer',
                    hintText: 'Type here manufacturer',
                    isFilled: false,
                  ),
                  CustomParkingTextField(
                    controller: _modelController,
                    textfieldTitle: 'Model',
                    hintText: 'Enter Model',
                    isFilled: false,
                  ),
                  CustomParkingTextField(
                    controller: _colorController,
                    textfieldTitle: 'Color',
                    hintText: 'Enter Color',
                    isFilled: false,
                  ),
                  CustomParkingTextField(
                    controller: _lincenseController,
                    textfieldTitle: 'License Number',
                    hintText: 'Enter License Number',
                    isFilled: false,
                  ),
                  CustomParkingTextField(
                    controller: _stateMyController,
                    textfieldTitle: 'State',
                    hintText: 'Enter State',
                    isFilled: false,
                  ),
                  Text(
                    'Towed',
                    style: CustomTheme.textField_Headertext_Style,
                    textScaleFactor: 1.0,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  DropdownButtonFormField<String>(
                    value: towedValue,
                    isExpanded: true,
                    onChanged: (newValue) {
                      towedValue = newValue!;
                    },
                    items: _dropdownItems.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 30,
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
                  RichText(
                      text: TextSpan(
                          text: 'Upload Record Sample',
                          style: CustomTheme.blueTextStyle(17, FontWeight.w500),
                          children: [
                        TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: Colors.red,
                            ))
                      ])),
                  // Text('Upload Record Sample',
                  //     style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
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
                      height: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                child: CustomButtonWidget(
                    buttonTitle: 'Send',
                    onBtnPress: () {
                      if (_propertyNameController.text.isEmpty) {
                        CommonService()
                            .openSnackBar('Please Select Property', context);
                      } else if (_titleController.text.isEmpty) {
                        CommonService()
                            .openSnackBar('Please enter title', context);
                      } else if (_vehicleTypeController.text.isEmpty) {
                        CommonService()
                            .openSnackBar('Please enter manufacturer', context);
                      } else if (_modelController.text.isEmpty) {
                        CommonService()
                            .openSnackBar('Please enter model', context);
                      } else if (_colorController.text.isEmpty) {
                        CommonService()
                            .openSnackBar('Please enter color', context);
                      } else if (_lincenseController.text.isEmpty) {
                        CommonService().openSnackBar(
                            'Please enter licence number', context);
                      } else if (_stateMyController.text.isEmpty) {
                        CommonService()
                            .openSnackBar('Please enter state', context);
                      } else if (imageFileList!.isEmpty) {
                        CommonService().openSnackBar(
                            'Please upload Record Sample', context);
                      } else {
                        uploadImage();
                      }
                    }))
          ],
        )),
      ),
    );
  }
}
