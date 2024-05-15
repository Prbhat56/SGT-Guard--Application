import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_bottom_model_sheet.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_textfield_report_widget.dart';
import 'package:sgt/presentation/widgets/custom_textfield_widget.dart';
import 'package:sgt/presentation/widgets/custom_underline_textfield_widget.dart';
import 'package:sgt/presentation/widgets/dotted_choose_file_widget.dart';
import 'package:sgt/presentation/widgets/media_uploading_widget.dart';
import 'package:sgt/presentation/work_report_screen/cubit/addImage/add_image_cubit.dart';
import 'package:sgt/presentation/work_report_screen/cubit/addpeople/addpeople_cubit.dart';
import 'package:sgt/presentation/work_report_screen/cubit/addwitness/addwitness_cubit.dart';
import 'package:sgt/presentation/work_report_screen/emergency_report_screen/widget/add_people_widget.dart';
import 'package:sgt/presentation/work_report_screen/emergency_report_screen/widget/emergency_date_time_widget.dart';
import 'package:sgt/presentation/work_report_screen/emergency_report_screen/widget/emergency_location_widget.dart';
import 'package:sgt/presentation/work_report_screen/widget/report_submit_success.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/utils/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class StaticEmergencyReportScreen extends StatefulWidget {
  String? propId;
  String? propName;
  StaticEmergencyReportScreen(
      {super.key, required this.propId, required this.propName});

  static _StaticEmergencyReportScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_StaticEmergencyReportScreenState>();

  @override
  State<StaticEmergencyReportScreen> createState() =>
      _StaticEmergencyReportScreenState();
}

class _StaticEmergencyReportScreenState
    extends State<StaticEmergencyReportScreen> {
  LatLng? currentLatLng;
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  String? dateValue = '';
  String? timeValue = '';
  String? latValue = '';
  String? longValue = '';
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _actionController = TextEditingController();
  TextEditingController _policeReportController = TextEditingController();
  TextEditingController _officerController = TextEditingController();
  TextEditingController _officeController = TextEditingController();

  List<String> _dropdownItems = <String>['Yes', 'No'];
  String? towedValue = 'Yes';

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

  var nameTEC1 = <int, TextEditingController>{};
  var mobileTEC1 = <int, TextEditingController>{};
  var item1 = <int, Widget>{};

  var nameTEC2 = <int, TextEditingController>{};
  var mobileTEC2 = <int, TextEditingController>{};
  var item2 = <int, Widget>{};

  newMethod(
    BuildContext context,
    int index,
  ) {
    var nameController = TextEditingController();
    var mobileController = TextEditingController();
    nameTEC1.addAll({index: nameController});
    mobileTEC1.addAll({index: mobileController});
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CustomReportTextField(
              textfieldTitle: 'Name',
              hintText: 'Name',
              controller: nameController,
            ),
            CustomReportTextField(
              textfieldTitle: 'Phone Number',
              hintText: 'Phone Number',
              keyboardType: TextInputType.number,
              controller: mobileController,
            ),
          ],
        ),
      ],
    );
  }

  newWitnessMethod(
    BuildContext context,
    int index,
  ) {
    var nameController = TextEditingController();
    var mobileController = TextEditingController();
    nameTEC2.addAll({index: nameController});
    mobileTEC2.addAll({index: mobileController});
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CustomReportTextField(
              textfieldTitle: 'Name',
              hintText: 'Name',
              controller: nameController,
            ),
            CustomReportTextField(
              textfieldTitle: 'Phone Number',
              hintText: 'Phone Number',
              keyboardType: TextInputType.number,
              controller: mobileController,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> uploadImage() async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: CircularProgressIndicator());
        }));

    String apiUrl = baseUrl + apiRoutes['emergencyReport']!;
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.fields['property_id'] = widget.propId.toString();
    request.fields['title'] = _titleController.text.toString();

    dateValue != ''
        ? request.fields['emergency_date'] = dateValue.toString()
        : request.fields['emergency_date'] =
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

    timeValue != ''
        ? request.fields['emergency_time'] = timeValue.toString()
        : request.fields['emergency_time'] =
            DateFormat('HH:mm:ss').format(DateTime.now()).toString();

    // request.fields['latitude'] = latValue.toString();
    request.fields['latitude'] = currentLatLng!.latitude.toString();
    // request.fields['longitude'] = longValue.toString();
    request.fields['longitude'] = currentLatLng!.longitude.toString();
    request.fields['emergency_details'] = _detailsController.text.toString();

    List<String> peopleNameList = [];
    List<String> peoplePhoneList = [];
    String peoplesNames = '';
    String peoplesPhone = '';

    for (int a = 0; a < item1.length; a++) {
      var name = nameTEC1[a]?.value.text;
      var mobile = mobileTEC1[a]?.value.text;
      peopleNameList.add(name.toString());
      peoplePhoneList.add(mobile.toString());
    }

    peoplesNames = peopleNameList.join(', ');
    peoplesPhone = peoplePhoneList.join(', ');

    request.fields['people_involved_name[]'] = peoplesNames;
    request.fields['people_involved_phone[]'] = peoplesPhone;

    List<String> witnessNameList = [];
    List<String> witnessPhoneList = [];
    String witnessNames = '';
    String witnessPhone = '';

    for (int a = 0; a < item2.length; a++) {
      var name = nameTEC2[a]?.value.text;
      var mobile = mobileTEC2[a]?.value.text;
      witnessNameList.add(name.toString());
      witnessPhoneList.add(mobile.toString());
    }

    witnessNames = witnessNameList.join(', ');
    witnessPhone = witnessPhoneList.join(', ');

    request.fields['witnesses_name[]'] = witnessNames;
    request.fields['witnesses_phone[]'] = witnessPhone;
    request.fields['action_taken'] = _actionController.text.toString();
    request.fields['police_report'] = _policeReportController.text.toString();
    request.fields['officer_name'] = _officerController.text.toString();
    request.fields['officer_designation'] = _officeController.text.toString();

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

    if (response.statusCode == 201) {
      setState(() {
        Navigator.of(context).pop();
      });
      print('Image Uploaded');
      screenNavigator(context, ReportSubmitSuccess());
    } else {
      if (response.statusCode == 401) {
        print("--------------------------------Unauthorized");
        var apiService = ApiCallMethodsService();
        apiService.updateUserDetails('');
        var commonService = CommonService();
        FirebaseHelper.signOut();
        FirebaseHelper.auth = FirebaseAuth.instance;
        commonService.logDataClear();
        commonService.clearLocalStorage();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('welcome', '1');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (route) => false,
        );
      } else {
        setState(() {
        Navigator.of(context).pop();
      });
      print('Failed');
      }
      
    }
  }

  @override
  void initState() {
    super.initState();
    _propertyNameController.text = widget.propName.toString();
    item1.addAll({0: newMethod(context, 0)});
    item2.addAll({0: newWitnessMethod(context, 0)});
  }

  @override
  void dispose() {
    super.dispose();
    _propertyNameController.dispose();
    _titleController.dispose();
    _detailsController.dispose();
    _actionController.dispose();
    _policeReportController.dispose();
    _officerController.dispose();
    _officeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<AddImageCubit>().state.imageList);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(appbarTitle: 'Emergency Report'),
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
                    RichText(
                        text: TextSpan(
                            text: 'Property Name',
                            style: CustomTheme.textField_Headertext_Style,
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
                  textfieldTitle: 'Title',
                  hintText: 'Enter Title',
                  isFilled: false,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Emergency Date & Time',
                        style: CustomTheme.textField_Headertext_Style,
                        children: [
                      TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ))
                    ])),
                SizedBox(
                  height: 10,
                ),
                EmergencyDateTimeWidget(), //taking date and time using this widget

                EmergencyLocationWidget(
                  onStatusChanged: (currentPosition) {
                    // print("----------static_emergency_report =======>${currentPosition}");
                    currentLatLng = currentPosition;
                  },
                ), //taking location widget

                CustomTextField(
                  controller: _detailsController,
                  textfieldTitle: 'Emergency Details',
                  hintText: 'Enter details',
                  isFilled: false,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'People Involved',
                  style: CustomTheme.textField_Headertext_Style,
                  textScaleFactor: 1.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: item1.length,
                        itemBuilder: (context, index) {
                          return item1.values.elementAt(index);
                        }),
                    GestureDetector(
                      onTap: () {
                        item1.addAll({
                          item1.keys.last + 1:
                              newMethod(context, item1.keys.last + 1)
                        });
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: CustomTheme.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'Add peoples +',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Witnesss',
                  style: CustomTheme.textField_Headertext_Style,
                  textScaleFactor: 1.0,
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: item2.length,
                        itemBuilder: (context, index) {
                          return item2.values.elementAt(index);
                        }),
                    GestureDetector(
                      onTap: () {
                        item2.addAll({
                          item2.keys.last + 1:
                              newWitnessMethod(context, item2.keys.last + 1)
                        });
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: CustomTheme.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          'Add peoples +',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: _actionController,
                  textfieldTitle: 'Action Taken',
                  hintText: 'Something here',
                  isFilled: false,
                  maxLines: 5,
                ),
                CustomReportTextField(
                  controller: _policeReportController,
                  textfieldTitle: 'Police Report#',
                  hintText: 'Police report number',
                ),
                CustomReportTextField(
                  controller: _officerController,
                  textfieldTitle: 'Officer Name#',
                  hintText: 'Officer Name',
                ),

                CustomReportTextField(
                  controller: _officeController,
                  textfieldTitle: 'Officer#',
                  hintText: 'Officer Designation',
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
                        style: CustomTheme.blueTextStyle(17, FontWeight.w400),
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
                const SizedBox(
                  height: 18,
                ),
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
                // Text(
                //   'Upload Record Sample',
                //   style: CustomTheme.blueTextStyle(17, FontWeight.w500),
                //   textScaleFactor: 1.0,
                // ),
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
                    )),
                // Center(
                //   child: Container(
                //       margin: EdgeInsets.symmetric(vertical: 30),
                //       child: CustomButtonWidget(
                //           buttonTitle: 'Send',
                //           onBtnPress: () {
                //            if (_propertyNameController.text.isEmpty) {
                //               CommonService().openSnackBar(
                //                   'Please Select Property', context);
                //             } else if (_titleController.text.isEmpty) {
                //               CommonService()
                //                   .openSnackBar('Please enter title', context);
                //             } else if (_detailsController.text.isEmpty) {
                //               CommonService().openSnackBar(
                //                   'Please enter emergency details', context);
                //             } else if (_actionController.text.isEmpty) {
                //               CommonService().openSnackBar(
                //                   'Please enter action taken', context);
                //             } else if (_policeReportController.text.isEmpty) {
                //               CommonService().openSnackBar(
                //                   'Please enter Police report number', context);
                //             } else if (_officerController.text.isEmpty) {
                //               CommonService().openSnackBar(
                //                   'Please enter Officer name', context);
                //             } else if (_officeController.text.isEmpty) {
                //               CommonService().openSnackBar(
                //                   'Please enter officer designation', context);
                //             } else if (imageFileList!.isEmpty) {
                //               CommonService().openSnackBar(
                //                   'Please upload Record Sample', context);
                //             } else {
                //               uploadImage();
                //             }
                //           })),
                // )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            margin: EdgeInsets.symmetric(vertical: 20.h),
            child: CustomButtonWidget(
                buttonTitle: 'Send',
                onBtnPress: () {
                  if (_propertyNameController.text.isEmpty) {
                    CommonService()
                        .openSnackBar('Please Select Property', context);
                  } else if (_titleController.text.isEmpty) {
                    CommonService()
                        .openSnackBar('Please enter title', context);
                  } else if (_detailsController.text.isEmpty) {
                    CommonService().openSnackBar(
                        'Please enter emergency details', context);
                  } else if (_actionController.text.isEmpty) {
                    CommonService()
                        .openSnackBar('Please enter action taken', context);
                  } else if (_policeReportController.text.isEmpty) {
                    CommonService().openSnackBar(
                        'Please enter Police report number', context);
                  } else if (_officerController.text.isEmpty) {
                    CommonService()
                        .openSnackBar('Please enter Officer name', context);
                  } else if (_officeController.text.isEmpty) {
                    CommonService().openSnackBar(
                        'Please enter officer designation', context);
                  } else if (imageFileList!.isEmpty) {
                    CommonService()
                        .openSnackBar('Please upload Record Sample', context);
                  } else {
                    uploadImage();
                  }
                })),
      ),
    );
  }
}
