import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/account_screen/widgets/add_card_back_images.dart';
import 'package:sgt/presentation/account_screen/widgets/add_card_front_images.dart';
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

// Future<CountryModel> countryList() async{
  // try {
  //   var url = Uri.parse(apiRoutes['countryList']!);
  //   var response = await http.get(url);
  //   if(response.statusCode==200){
  //         final CountryModel responseModel = countryStateModelFromJson(response.body);
  //         return responseModel;
  //       }
  //       else{
  //         return CountryModel(error:true,msg:'Something went wrong ${response.statusCode}',data:[]);
  //       }
  // }
  // catch (e){
  //     log('Exception: ${e.toString()}');
  //     throw Exception(e.toString());
  // }
  // var apiCallService=ApiCallMethodsService();
  //  apiCallService.get(apiRoutes['countryList']!).then((value) async{
  //   print(value);
  //    Map<String, dynamic> countrylist = jsonDecode(value);
  //    setState(() {
  //       countries = countrylist as List;
  //    });
  //    print(countrylist['countries']);
// }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      keyboardType: TextInputType.streetAddress,
                      textfieldTitle: 'City',
                      hintText: 'City',
                      controller: cityController,
                      focusNode: city_FocusNode,
                      onEditCompleted: () {
                        Utils.fieldFocusChnage(
                            context, city_FocusNode, state_FocusNode);
                      },
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      keyboardType: TextInputType.streetAddress,
                      textfieldTitle: 'State',
                      hintText: 'State',
                      controller: stateController,
                      focusNode: state_FocusNode,
                      onEditCompleted: () {
                        Utils.fieldFocusChnage(
                            context, state_FocusNode, country_FocusNode);
                      },
                    ),
                    CustomUnderlineTextFieldWidget(
                      bottomPadding: 7,
                      keyboardType: TextInputType.streetAddress,
                      textfieldTitle: 'Country',
                      hintText: 'Country',
                      controller: countryController,
                      focusNode: country_FocusNode,
                      onEditCompleted: () {
                        Utils.fieldFocusChnage(
                            context, country_FocusNode, zip_code_FocusNode);
                      },
                    ),
                   
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AddFrontCardImage(),
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
                          map['street'] = streetController.text.toString();
                          map['city'] = cityController.text.toString();
                          map['state'] = stateController.text.toString();
                          map['country'] = countryController.text.toString();
                          map['zip_code'] = zip_code_Controller.text.toString();
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
}
