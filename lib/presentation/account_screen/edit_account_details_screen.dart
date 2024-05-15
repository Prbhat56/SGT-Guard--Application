import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:intl/intl.dart';
import 'package:sgt/presentation/account_screen/widgets/add_card_back_images.dart';
import 'package:sgt/presentation/account_screen/widgets/add_card_front_images.dart';
import 'package:sgt/presentation/account_screen/widgets/dropdown_Country.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/custom_theme.dart';
import '../../utils/const.dart';
import '../widgets/custom_underline_textfield_widget.dart';
import 'model/guard_details_model.dart';
import 'widgets/add_profile_pic_widget.dart';
import 'package:http/http.dart' as http;

GuardDetails _guardDetails = GuardDetails();

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  static _EditAccountScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_EditAccountScreenState>();

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  http.MultipartFile? multipart;

  TextEditingController first_name_controller = TextEditingController();
  FocusNode first_name_FocusNode = FocusNode();
  TextEditingController last_name_controller = TextEditingController();
  FocusNode last_name_FocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController phone_code_Controller = TextEditingController();
  FocusNode phone_code_FocusNode = FocusNode();
  TextEditingController contact_number_Controller = TextEditingController();
  FocusNode contact_number_FocusNode = FocusNode();
  TextEditingController dob_Controller = TextEditingController();
  FocusNode dob_FocusNode = FocusNode();
  TextEditingController guard_position_controller = TextEditingController();
  TextEditingController street_Controller = TextEditingController();
  FocusNode street_FocusNode = FocusNode();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zip_code_Controller = TextEditingController();
  FocusNode zip_code_FocusNode = FocusNode();

  late String _selectedGender;
  List<String> _dropdownItems = <String>['Male', 'Female', 'Other'];

  Future getGuardDetailsAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };

    String apiUrl = baseUrl + apiRoutes['userDetails']!;
    final response = await http.get(Uri.parse(apiUrl), headers: myHeader);
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      _guardDetails = GuardDetails.fromJson(data);

      first_name_controller = TextEditingController(
          text: (_guardDetails.userDetails?.firstName != null
              ? _guardDetails.userDetails?.firstName.toString()
              : ''));
      last_name_controller = TextEditingController(
          text: (_guardDetails.userDetails?.lastName != null
              ? _guardDetails.userDetails?.lastName.toString()
              : ''));

      emailController = TextEditingController(
          text: (_guardDetails.userDetails?.emailAddress.toString()));

      phone_code_Controller = TextEditingController(
          text: (_guardDetails.userDetails?.contactCode != null
              ? "${_guardDetails.userDetails?.contactCode.toString()}"
              : ''));

      contact_number_Controller = TextEditingController(
          text: (_guardDetails.userDetails?.contactNumber != null
              ? _guardDetails.userDetails?.contactNumber.toString()
              : ''));

      _selectedGender = (_guardDetails.userDetails?.gender != null
          ? _guardDetails.userDetails?.gender.toString() ?? ""
          : 'Select a Gender');

      dob_Controller = TextEditingController(
          text: (_guardDetails.userDetails?.dateOfBirth != null
              ? _guardDetails.userDetails?.dateOfBirth
                  .toString()
                  .substring(0, 10)
              : ''));
      guard_position_controller = TextEditingController(
          text: (_guardDetails.userDetails?.guardPosition != null
              ? _guardDetails.userDetails?.guardPosition
                  .toString()
                  .capitalized()
              : ''));

      street_Controller = TextEditingController(
          text: (_guardDetails.userDetails?.street != null
              ? _guardDetails.userDetails?.street.toString()
              : ''));

      countryController = TextEditingController(
          text: (_guardDetails.userDetails?.countryText != null
              ? _guardDetails.userDetails?.countryText.toString()
              : ''));

      stateController = TextEditingController(
          text: (_guardDetails.userDetails?.stateText != null
              ? _guardDetails.userDetails?.stateText.toString()
              : ''));

      cityController = TextEditingController(
          text: (_guardDetails.userDetails?.cityText != null
              ? _guardDetails.userDetails?.cityText.toString()
              : ''));

      zip_code_Controller = TextEditingController(
          text: (_guardDetails.userDetails?.zipCode != null
              ? _guardDetails.userDetails?.zipCode.toString()
              : ''));

      countryId = _guardDetails.userDetails?.country;
      stateId = _guardDetails.userDetails?.state;
      cityId = _guardDetails.userDetails?.city;
      return GuardDetails.fromJson(data);
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
        throw Exception('Failed to load guard');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    first_name_FocusNode.dispose();
    last_name_FocusNode.dispose();
    phone_code_FocusNode.dispose();
    contact_number_FocusNode.dispose();
    dob_FocusNode.dispose();
    street_FocusNode.dispose();
    zip_code_FocusNode.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  int? countryId;
  int? stateId;
  int? cityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // centerTitle: true,
        title: Align(
          alignment: Alignment(-1.1.w, 0.w),
          child: Text(
            "Edit Account Details",
            textScaleFactor: 1.0,
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp),
          ),
        ),
      ),

      // CustomAppBarWidget(appbarTitle: 'Edit Account Details'),
      backgroundColor: white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: FutureBuilder(
                future: getGuardDetailsAPI(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                            child: AddProfilePicWidget(
                          baseUrl: snapshot.data?.imageBaseUrl ?? "",
                          imgUrl: snapshot.data?.userDetails?.avatar ?? "",
                          onProfilePicChange: (changePic) {
                            multipart = changePic;
                          },
                        )),
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
                            CommonService.fieldFocusChnage(context,
                                first_name_FocusNode, last_name_FocusNode);
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
                            CommonService.fieldFocusChnage(context,
                                last_name_FocusNode, phone_code_FocusNode);
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
                                  CommonService.fieldFocusChnage(
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
                                      borderSide:
                                          BorderSide(color: primaryColor)),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
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
                                  CommonService.fieldFocusChnage(context,
                                      contact_number_FocusNode, dob_FocusNode);
                                },
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: seconderyColor)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: primaryColor)),
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
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
                          value: _selectedGender,
                          hint: Text(
                            'Choose Gender',
                          ),
                          isExpanded: true,
                          onChanged: (newValue) {
                            // setState(() {
                            //   print(newValue);
                            //   _selectedGender = newValue!;
                            // });
                            _selectedGender = newValue!;
                          },
                          items: _dropdownItems.map((String value) {
                            return DropdownMenuItem(
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

                        TextFormField(
                          controller: dob_Controller,
                          focusNode: dob_FocusNode,
                          onFieldSubmitted: (value) {
                            CommonService.fieldFocusChnage(
                                context, dob_FocusNode, street_FocusNode);
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Date Of Birth',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: primaryColor,
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: seconderyColor)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor)),
                            hintStyle: const TextStyle(color: Colors.grey),
                            focusColor: primaryColor,
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.parse(_guardDetails
                                  .userDetails!.dateOfBirth
                                  .toString()), //DateTime.now(),
                              firstDate: DateTime(1970),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              dob_Controller.text = formattedDate;
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
                          controller: street_Controller,
                          focusNode: street_FocusNode,
                          onEditCompleted: () {
                            CommonService.fieldFocusChnage(
                                context, street_FocusNode, zip_code_FocusNode);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        DropdownCountry(
                          cName: snapshot.data?.userDetails?.countryText ?? "",
                          cId: snapshot.data?.userDetails?.country ?? 0,
                          sName: snapshot.data?.userDetails?.stateText ?? "",
                          sId: snapshot.data?.userDetails?.state ?? 0,
                          cityName: snapshot.data?.userDetails?.cityText ?? "",
                          citId: snapshot.data?.userDetails?.city ?? 0,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // dropdownState(),
                        // dropDownCity(),

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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Guard ID card',
                              style: CustomTheme.textField_Headertext_Style,
                              textScaleFactor: 1.0,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            AddFrontCardImage(
                                baseUrl: snapshot.data?.imageBaseUrl ?? "",
                                imgUrl: snapshot
                                        .data?.userDetails?.frontSideIdCard ??
                                    ""),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              'Weapon Permit',
                              style: CustomTheme.textField_Headertext_Style,
                              textScaleFactor: 1.0,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            AddBackCardImage(
                                baseUrl: snapshot.data?.imageBaseUrl ?? "",
                                imgUrl: snapshot
                                        .data?.userDetails?.backSideIdCard ??
                                    ""),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        SizedBox(
                          height: 40.h,
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
        child: CustomButtonWidget(
            buttonTitle: 'Update',
            onBtnPress: () {
              UpdateProfileDetails();
            }),
      ),
    );
  }

  void UpdateProfileDetails() async {
    // verifyProfileDetail();
    // if (_formKey.currentState!.validate()) {
    //   // verifyDetails();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Processing Data')),
    //   );
    // }
    print(" country----------------> ${countryId}");
    print(" state----------------> ${stateId}");
    print(" city----------------> ${cityId}");

    var map = new Map<String, dynamic>();
    map['first_name'] = first_name_controller.text.toString();
    map['last_name'] = last_name_controller.text.toString();
    map['email_address'] = emailController.text.toString();
    map['contact_code'] = phone_code_Controller.text.toString();
    map['contact_number'] = contact_number_Controller.text.toString();
    map['gender'] = _selectedGender.toString();
    map['date_of_birth'] = dob_Controller.text.toString();
    map['street'] = street_Controller.text.toString();
    map['city'] = cityId == 0 ? '' : cityId.toString();
    map['state'] = stateId == 0 ? '' : stateId.toString();
    map['country'] = countryId.toString();
    map['zip_code'] = zip_code_Controller.text.toString();
    var apiService = ApiCallMethodsService();
    apiService.post(apiRoutes['profileUpdate']!, map).then((value) {
      apiService.updateUserDetails(value);
      Map<String, dynamic> jsonMap = json.decode(value);
      var commonService = CommonService();
      commonService.openSnackBar(jsonMap['message'], context);
      if (multipart != null) {
        UpdateDetails();
      }
      // screenNavigator(context, SettingsScreen());
      Navigator.of(context).pop();
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      print(error);
      Navigator.of(context).pop();
      Navigator.pop(context);
      var commonService = CommonService();
      commonService.openSnackBar(error.toString(), context);
    });
  }

  void UpdateDetails() async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: CircularProgressIndicator());
        }));

    String apiUrl = baseUrl + apiRoutes['updateProfilePic']!;
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.files.add(multipart!);
    var response = await request.send();
    if (response.statusCode == 201) {
      setState(() {
        Navigator.of(context).pop();
        Navigator.pop(context);
      });
      print('Image Uploaded');
    } else {
      setState(() {
        Navigator.of(context).pop();
        Navigator.pop(context);
      });
      print('Failed');
    }
  }
}

// class Utils {
//   static fieldFocusChnage(
//       BuildContext context, FocusNode current, FocusNode nextFocus) {
//     current.unfocus();
//     FocusScope.of(context).requestFocus(nextFocus);
//   }
// }
