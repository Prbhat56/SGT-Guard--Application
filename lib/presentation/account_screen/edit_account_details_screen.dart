import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/account_screen/model/country_model.dart';
import 'package:sgt/presentation/account_screen/widgets/add_card_back_images.dart';
import 'package:sgt/presentation/account_screen/widgets/add_card_front_images.dart';
import 'package:sgt/presentation/account_screen/widgets/dropdown_Country.dart';
import 'package:sgt/presentation/account_screen/widgets/dropdown_State.dart';
import 'package:sgt/presentation/account_screen/widgets/dropdown_city.dart';
import 'package:sgt/presentation/settings_screen/settings_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/service/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import 'widgets/add_profile_pic_widget.dart';
import 'package:http/http.dart' as http;

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class Utils {
  static fieldFocusChnage(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

class _EditAccountScreenState extends State<EditAccountScreen> {

 @override
  void initState() {
    super.initState();
    getPropertyGuardListAPI();
 }

 Future<dynamic> getPropertyGuardListAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    // print(myHeader);

    String apiUrl = baseUrl + apiRoutes['userDetails']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print("userDetails ====>  $data");
      return data;
    } else {
      setState(() {
        print("userDetails setState====>  $data");
        return data;
      });
    }
  }

  List imageNames = [];
  List<XFile>? imageFileList = [];
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // final ImagePicker _picker = ImagePicker();
  final selectedValue = [];

  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  List countries = [];
  var buttonDisabled = false;

  var userD = jsonDecode(userDetail);
  TextEditingController first_name_controller = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['first_name'] != null
          ? jsonDecode(userDetail)['user_details']['first_name'].toString()
          : ''));
  FocusNode first_name_FocusNode = FocusNode();
  TextEditingController last_name_controller = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['last_name'] != null
          ? jsonDecode(userDetail)['user_details']['last_name'].toString()
          : ''));
  FocusNode last_name_FocusNode = FocusNode();
  TextEditingController emailController = TextEditingController(
      text:
          (jsonDecode(userDetail)['user_details']['email_address'].toString()));

  TextEditingController phone_code_Controller = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['contact_code'] != null
          ? jsonDecode(userDetail)['user_details']['contact_code'].toString()
          : ''));
  FocusNode phone_code_FocusNode = FocusNode();
  TextEditingController contact_number_Controller = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['contact_number'] != null
          ? jsonDecode(userDetail)['user_details']['contact_number'].toString()
          : ''));
  FocusNode contact_number_FocusNode = FocusNode();
  TextEditingController streetController = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['street'] != null
          ? jsonDecode(userDetail)['user_details']['street'].toString()
          : ''));
  FocusNode street_FocusNode = FocusNode();
  TextEditingController guard_position_controller = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['guard_position'] != null
          ? jsonDecode(userDetail)['user_details']['guard_position'].toString()
          : ''));
  FocusNode guard_position_FocusNode = FocusNode();
  TextEditingController cityController = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['city'] != null
          ? jsonDecode(userDetail)['user_details']['city'].toString()
          : ''));
  FocusNode city_FocusNode = FocusNode();
  TextEditingController stateController = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['state'] != null
          ? jsonDecode(userDetail)['user_details']['state'].toString()
          : ''));
  FocusNode state_FocusNode = FocusNode();
  TextEditingController countryController = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['country'] != null
          ? jsonDecode(userDetail)['user_details']['country'].toString()
          : ''));
  FocusNode country_FocusNode = FocusNode();
  TextEditingController zip_code_Controller = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['zip_code'] != null
          ? jsonDecode(userDetail)['user_details']['zip_code'].toString()
          : ''));
  FocusNode zip_code_FocusNode = FocusNode();
  TextEditingController dob_Controller = TextEditingController(
      text: (jsonDecode(userDetail)['user_details']['date_of_birth'] != null
          ? jsonDecode(userDetail)['user_details']['date_of_birth'].toString()
          : ''));
  FocusNode dob_FocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    first_name_FocusNode.dispose();
    last_name_FocusNode.dispose();
    phone_code_FocusNode.dispose();
    contact_number_FocusNode.dispose();
    street_FocusNode.dispose();
    city_FocusNode.dispose();
    state_FocusNode.dispose();
    country_FocusNode.dispose();
    zip_code_FocusNode.dispose();
    dob_FocusNode.dispose();
    guard_position_FocusNode.dispose();
  }

//pick image from camera
  void pickCameraImage(cardSide) async {
    // final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    // if (photo != null) {
    //   imageFileList?.add(photo);
    //   imageNames.add(path.dirname(photo.path));
    //   setState(() {});
    // }

    final photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (photo != null) {
      image = File(photo.path);
      print(image);
      setState(() {
        uploadImage(cardSide);
      });
    } else {
      print('Something went wrong');
    }
  }

//pick image from gallery
  void pickGalleryImage(cardSide) async {
    // final List<XFile>? images = await _picker.pickMultiImage();
    // if (images != null) {
    //   for (var i = 0; i < images.length; i++) {
    //     imageFileList?.add(images[i]);
    //   }
    //   imageNames.add(images[0].name);
    //   setState(() {});
    // }

    final photo =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (photo != null) {
      image = File(photo.path);
      print(image);
      setState(() {
        uploadImage(cardSide);
      });
    } else {
      print('Something went wrong');
    }
  }

  Future<void> uploadImage(cardSide) async {
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    String apiUrl = baseUrl + apiRoutes['updateProfilePic']!;
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));

    var multipart = new http.MultipartFile(cardSide, stream, length,
        filename: image!.path.split('/').last);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.files.add(multipart);

    var response = await request.send();
    print(response.stream.toString());

    //final respStr = await response.stream.bytesToString();
    if (response.statusCode == 201) {
      setState(() {
        Navigator.pop(context);
        showSpinner = false;
      });
      print('Image Uploaded');
    } else {
      setState(() {
        Navigator.pop(context);
        showSpinner = false;
      });
      print('Failed');
    }
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   myController.dispose();
  //   super.dispose();
  // }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String selectedGender = (userD['user_details']['gender'] != null
        ? userD['user_details']['gender']
        : 'Select a Gender');
    // countryList();
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
                      keyboardType: TextInputType.name,
                      textfieldTitle: 'First Name',
                      hintText: 'Enter First Name',
                      controller: first_name_controller,
                      focusNode: first_name_FocusNode,
                      onEditCompleted: () {
                        Utils.fieldFocusChnage(
                            context, first_name_FocusNode, last_name_FocusNode);
                      },
                      // readonly: true,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      keyboardType: TextInputType.name,
                      textfieldTitle: 'Last Name',
                      hintText: 'Enter Last Name',
                      controller: last_name_controller,
                      focusNode: last_name_FocusNode,
                      onEditCompleted: () {
                        Utils.fieldFocusChnage(
                            context, last_name_FocusNode, phone_code_FocusNode);
                      },
                      // readonly: true,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      keyboardType: TextInputType.emailAddress,
                      textfieldTitle: 'Email',
                      hintText: 'Enter Email',
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
                            keyboardType: TextInputType.phone,
                            controller: phone_code_Controller,
                            focusNode: phone_code_FocusNode,
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChnage(
                                  context,
                                  phone_code_FocusNode,
                                  contact_number_FocusNode);
                            },
                            decoration: InputDecoration(
                              hintText: '+1',
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
                            keyboardType: TextInputType.number,
                            controller: contact_number_Controller,
                            focusNode: contact_number_FocusNode,
                            onFieldSubmitted: (value) {
                              Utils.fieldFocusChnage(context,
                                  contact_number_FocusNode, street_FocusNode);
                            },
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
                      'Gender',
                      style: CustomTheme.textField_Headertext_Style,
                      textScaleFactor: 1.0,
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGender = newValue!;
                        });
                      },
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Date Of Birth',
                      style: CustomTheme.textField_Headertext_Style,
                      textScaleFactor: 1.0,
                    ),
                    TextField(
                      focusNode: dob_FocusNode,
                      controller:
                          dob_Controller, //editing controller of this TextField
                      decoration: InputDecoration(
                          // icon: Icon(Icons.calendar_today), //icon of text field
                          // labelText: "Date Of Birth" //label text of field
                          ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                1970), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dob_Controller.text = formattedDate;
                            // dateinput.text = formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      keyboardType: TextInputType.name,
                      textfieldTitle: 'Guard Position',
                      hintText: 'Guard position',
                      controller: guard_position_controller,
                      readonly: true,
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
                      keyboardType: TextInputType.streetAddress,
                      textfieldTitle: 'Street',
                      hintText: 'Street',
                      controller: streetController,
                      focusNode: street_FocusNode,
                      onEditCompleted: () {
                        Utils.fieldFocusChnage(
                            context, street_FocusNode, city_FocusNode);
                      },
                    ),

                    dropdownCountry(),
                    // dropdownState(),
                    // dropDownCity(),

                    // CustomUnderlineTextFieldWidget(
                    //   bottomPadding: 7,
                    //   keyboardType: TextInputType.streetAddress,
                    //   textfieldTitle: 'City',
                    //   hintText: 'City',
                    //   controller: cityController,
                    //   focusNode: city_FocusNode,
                    //   onEditCompleted: () {
                    //     Utils.fieldFocusChnage(
                    //         context, city_FocusNode, state_FocusNode);
                    //   },
                    // ),
                    // CustomUnderlineTextFieldWidget(
                    //   bottomPadding: 7,
                    //   keyboardType: TextInputType.streetAddress,
                    //   textfieldTitle: 'State',
                    //   hintText: 'State',
                    //   controller: stateController,
                    //   focusNode: state_FocusNode,
                    //   onEditCompleted: () {
                    //     Utils.fieldFocusChnage(
                    //         context, state_FocusNode, country_FocusNode);
                    //   },
                    // ),
                    // CustomUnderlineTextFieldWidget(
                    //   bottomPadding: 7,
                    //   keyboardType: TextInputType.streetAddress,
                    //   textfieldTitle: 'Country',
                    //   hintText: 'Country',
                    //   controller: countryController,
                    //   focusNode: country_FocusNode,
                    //   onEditCompleted: () {
                    //     Utils.fieldFocusChnage(
                    //         context, country_FocusNode, zip_code_FocusNode);
                    //   },
                    // ),

                    // DropdownField(
                    //   heading:'Choose Country'),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // DropdownField(
                    //   heading:'Choose State'),
                    // SizedBox(
                    //   height: 20.h,
                    // ),
                    // DropdownField(
                    //   heading:'Choose city'),
                    // SizedBox(
                    //   height: 20.h,
                    // ),

                    // dropdownState(),
                    // dropDownCity(),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      keyboardType: TextInputType.number,
                      textfieldTitle: 'Zipcode',
                      hintText: 'Zipcode',
                      controller: zip_code_Controller,
                      focusNode: zip_code_FocusNode,
                      onEditCompleted: () {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Upload Guard Card',
                      style: CustomTheme.blackTextStyle(21),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    /*
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
                        */

                    //     Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         height: 180,
                    //         width: MediaQuery.of(context).size.width * 1,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10),
                    //             border: Border.all(color: Colors.grey)),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(10),
                    //           child:
                    //           (userD['user_details']['front_side_id_card'] !=null ?
                    //           Image.network(
                    //             userD['image_base_url'] +
                    //                 '/' +
                    //                 userD['user_details']['front_side_id_card'],
                    //             fit: BoxFit.fill,
                    //             errorBuilder: (context, error, stackTrace) {
                    //               return Image.asset(
                    //                 'assets/sgt_logo.jpg',
                    //                 fit: BoxFit.cover,
                    //               );
                    //             },
                    //           ):Image.asset(
                    //                 'assets/sgt_logo.jpg',
                    //                 fit: BoxFit.cover,
                    //               )),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //       Container(
                    //         height: 180,
                    //         width: MediaQuery.of(context).size.width * .9,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10),
                    //             border: Border.all(color: Colors.grey)),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(10),
                    //           child:
                    //           (userD['user_details']['back_side_id_card'] !=null ? Image.network(
                    //             userD['image_base_url'] +
                    //                 '/' +
                    //                 userD['user_details']['back_side_id_card'],
                    //             fit: BoxFit.fill,
                    //             errorBuilder: (context, error, stackTrace) {
                    //               return Image.asset(
                    //                 'assets/sgt_logo.jpg',
                    //                 fit: BoxFit.cover,
                    //               );
                    //             },
                    //           ): Image.asset(
                    //                 'assets/sgt_logo.jpg',
                    //                 fit: BoxFit.cover,
                    //               )

                    //               ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Front Side Id Card',
                            style: CustomTheme.textField_Headertext_Style,
                            textScaleFactor: 1.0,
                          ),
                        ),
                        AddFrontCardImage(),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Back Side Id Card',
                            style: CustomTheme.textField_Headertext_Style,
                            textScaleFactor: 1.0,
                          ),
                        ),
                        AddBackCardImage(),
                      ],
                    ),
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
                          map['first_name'] =
                              first_name_controller.text.toString();
                          map['last_name'] =
                              last_name_controller.text.toString();
                          map['email_address'] =
                              emailController.text.toString();
                          map['contact_code'] =
                              phone_code_Controller.text.toString();
                          map['contact_number'] =
                              contact_number_Controller.text.toString();
                          map['gender'] = selectedGender.toString();
                          map['date_of_birth'] = dob_Controller.text.toString();
                          map['street'] = streetController.text.toString();
                          map['city'] = cityController.text.toString();
                          map['state'] = stateController.text.toString();
                          map['country'] = countryController.text.toString();
                          map['zip_code'] = zip_code_Controller.text.toString();
                          // map['guard_position'] = guard_position_controller.text.toString();
                          var apiService = ApiCallMethodsService();
                          apiService
                              .post(apiRoutes['profileUpdate']!, map)
                              .then((value) {
                            // print("api response ==> $value");
                            apiService.updateUserDetails(value);
                            Map<String, dynamic> jsonMap = json.decode(value);
                            var commonService = CommonService();
                            commonService.openSnackBar(
                                jsonMap['message'], context);
                            // screenNavigator(context, SettingsScreen());
                            Navigator.of(context).pop();
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
}
