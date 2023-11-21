import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/settings_screen/settings_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
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
  final selectedValue = [];

  var buttonDisabled = false;

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
    var userD = jsonDecode(userDetail);
    TextEditingController first_name_controller = TextEditingController(
        text: (userD['user_details']['first_name'] != null
                ? userD['user_details']['first_name'].toString()
                : ''));
    TextEditingController last_name_controller = TextEditingController(
        text: (userD['user_details']['last_name'] != null
                ? userD['user_details']['last_name'].toString()
                : ''));
    TextEditingController emailController = TextEditingController(
        text: (userD['user_details']['email_address'].toString()));
    TextEditingController phone_code_Controller = TextEditingController(
        text: (userD['user_details']['contact_code'] != null
            ? userD['user_details']['contact_code'].toString()
            : ''));
    TextEditingController contact_number_Controller = TextEditingController(
        text: (userD['user_details']['contact_number'] != null
            ? userD['user_details']['contact_number'].toString()
            : ''));
    TextEditingController streetController = TextEditingController(
        text: (userD['user_details']['street'] != null
            ? userD['user_details']['street'].toString()
            : ''));
    TextEditingController cityController = TextEditingController(
        text: (userD['user_details']['city'] != null
            ? userD['user_details']['city'].toString()
            : ''));
    TextEditingController stateController = TextEditingController(
        text: (userD['user_details']['state'] != null
            ? userD['user_details']['state'].toString()
            : ''));
    TextEditingController countryController = TextEditingController(
        text: (userD['user_details']['country'] != null
            ? userD['user_details']['country'].toString()
            : ''));
    TextEditingController zip_code_Controller = TextEditingController(
        text: (userD['user_details']['zip_code'] != null
            ? userD['user_details']['zip_code'].toString()
            : ''));

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
                      textfieldTitle: 'First Name',
                      hintText: 'Enter First Name',
                      controller: first_name_controller,
                      // readonly: true,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'Last Name',
                      hintText: 'Enter Last Name',
                      controller: last_name_controller,
                      // readonly: true,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'Email',
                      hintText:'Enter Email',
                      controller: emailController,
                      readonly: true,
                    ),
                    // CustomUnderlineTextFieldWidget(
                    //   bottomPadding: 7,
                    //   textfieldTitle: 'Countrycode',
                    //   hintText: (userD['user_details']['contact_code'] !=null ? userD['user_details']['contact_code'].toString():''),
                    //   controller: phone_code_Controller,
                    //   // readonly: true,
                    // ),
                    // CustomUnderlineTextFieldWidget(
                    //   bottomPadding: 7,
                    //   textfieldTitle: 'Phone',
                    //   hintText: (userD['user_details']['contact_number'] !=null ? userD['user_details']['contact_number'].toString():''),
                    //   // readonly: true,
                    //   controller: contact_number_Controller,
                    // ),
                    Text(
                      'Contact Number',
                      style: CustomTheme.textField_Headertext_Style,
                      textScaleFactor: 1.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: phone_code_Controller,
                            decoration: InputDecoration(
                              hintText:'phone Code',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: seconderyColor)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor)),
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusColor: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 9,
                          child: TextFormField(
                            controller: contact_number_Controller,
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: seconderyColor)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor)),
                              hintStyle: const TextStyle(color: Colors.grey),
                              focusColor: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                      hintText:'street',
                      controller: streetController,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'City',
                      hintText: 'city',
                      controller: cityController,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'State',
                      hintText: 'state',
                      controller: stateController,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'Country',
                      hintText: 'country',
                      controller: countryController,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      textfieldTitle: 'Zipcode',
                      hintText: 'zipcode',
                      controller: zip_code_Controller,
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
                        buttonTitle: 'Update',
                        onBtnPress: () {
                          // verifyProfileDetail();
                          // if (_formKey.currentState!.validate()) {
                          //   // verifyDetails();
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(content: Text('Processing Data')),
                          //   );
                          // }
                          var map = new Map<String, dynamic>();
                          map['first_name'] = first_name_controller.text.toString();
                          map['last_name'] = last_name_controller.text.toString();
                          map['email_address'] =emailController.text.toString();
                          map['contact_code'] =phone_code_Controller.text.toString();
                          map['contact_number'] =contact_number_Controller.text.toString();
                          map['street'] = streetController.text.toString();
                          map['city'] = cityController.text.toString();
                          map['state'] = stateController.text.toString();
                          map['country'] = countryController.text.toString();
                          map['zip_code'] = zip_code_Controller.text.toString();
                          var apiService = ApiCallMethodsService();
                          apiService.post(apiRoutes['profileUpdate']!, map).then((value) {
                            // print("api response ==> $value");
                            apiService.updateUserDetails(value);
                            Map<String, dynamic> jsonMap = json.decode(value);
                            var commonService = CommonService();
                            commonService.openSnackBar(
                                jsonMap['message'], context);
                            screenNavigator(context, SettingsScreen());
                          }).onError((error, stackTrace) {
                            print(error);
                          });
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

  // Future<void>  verifyDetails() async{
  //    var apiCallService=ApiCallMethodsService();
  //   apiCallService.get(apiRoutes['termsCondition']!).then((value) {
  //      Map<String, dynamic> jsonData = jsonDecode(value);
  //       print(jsonData);
  //     }).onError((error, stackTrace) {
  //       print(error);
  //     });
  // }
}
