import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/time_sheet_screen/model/today_active_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/work_report_screen/cubit/addImage/add_image_cubit.dart';
import 'package:sgt/presentation/work_report_screen/widget/report_submit_success.dart';
import 'package:sgt/presentation/work_report_screen/your_report_screen/widget/task_picker.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/const.dart';
import '../../widgets/custom_bottom_model_sheet.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/custom_underline_textfield_widget.dart';
import '../../widgets/dotted_choose_file_widget.dart';
import '../../widgets/media_uploading_widget.dart';
import 'widget/emergency_date_time_widget.dart';
import 'widget/emergency_location_widget.dart';
import 'package:http/http.dart' as http;

class EmergencyReportScreen extends StatefulWidget {
  const EmergencyReportScreen({super.key});

  static _EmergencyReportScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_EmergencyReportScreenState>();

  @override
  State<EmergencyReportScreen> createState() => _EmergencyReportScreenState();
}

class _EmergencyReportScreenState extends State<EmergencyReportScreen> {
  bool propertyClicked = false;
  TextEditingController _propertyNameController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  String? dateValue = '';
  String? timeValue = '';
  String? latValue = '';
  String? longValue = '';
  TextEditingController _detailsController = TextEditingController();
  TextEditingController _actionController = TextEditingController();
  TextEditingController _officerController = TextEditingController();
  TextEditingController _officeController = TextEditingController();
  String? propertyName;
  String? propertyId;

  List<String> _dropdownItems = <String>['Yes', 'No'];
  String? towedValue = 'Yes';

  // List<TextEditingController> _peopleNameController = [TextEditingController()];
  // List<TextEditingController> _peoplePhoneController = [
  //   TextEditingController()
  // ];

  // List<TextEditingController> _witnessNameController = [
  //   TextEditingController()
  // ];
  // List<TextEditingController> _witnessPhoneController = [
  //   TextEditingController()
  // ];

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
            CustomUnderlineTextFieldWidget(
              textfieldTitle: 'Name',
              hintText: 'Name',
              controller: nameController,
            ),
            CustomUnderlineTextFieldWidget(
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
            CustomUnderlineTextFieldWidget(
              textfieldTitle: 'Name',
              hintText: 'Name',
              controller: nameController,
            ),
            CustomUnderlineTextFieldWidget(
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
    request.fields['property_id'] = propertyId.toString();
    request.fields['title'] = _titleController.text.toString();

    dateValue != ''
        ? request.fields['emergency_date'] = dateValue.toString()
        : request.fields['emergency_date'] =
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

    timeValue != ''
        ? request.fields['emergency_time'] = timeValue.toString()
        : request.fields['emergency_time'] =
            DateFormat('HH:mm:ss').format(DateTime.now()).toString();

    request.fields['latitude'] = latValue.toString();
    request.fields['longitude'] = longValue.toString();
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
      setState(() {
        Navigator.of(context).pop();
      });
      print('Failed');
    }
  }

  List<TodaysDatum> reportDatum = [];
  String? imageBaseUrl;

  @override
  void initState() {
    super.initState();
    getTasks();
    item1.addAll({0: newMethod(context, 0)});
    item2.addAll({0: newWitnessMethod(context, 0)});
  }

  Future<TodayActiveModel> getTasks() async {
    try {
      EasyLoading.show();
      String apiUrl = baseUrl + apiRoutes['todaysActivePropertyList']!;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, String> myHeader = <String, String>{
        "Authorization": "Bearer ${prefs.getString('token')}",
      };
      var response = await http.get(Uri.parse(apiUrl), headers: myHeader);
      if (response.statusCode == 201) {
        final TodayActiveModel responseModel =
            todayModelFromJson(response.body);
        reportDatum = responseModel.data ?? [];
        print('Reports: $reportDatum');
        imageBaseUrl = responseModel.imageBaseUrl;
        EasyLoading.dismiss();
        return responseModel;
      } else {
        EasyLoading.dismiss();
        return TodayActiveModel(
            data: [], imageBaseUrl: '', status: response.statusCode);
      }
    } catch (e) {
      EasyLoading.dismiss();
      throw Exception(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _propertyNameController.dispose();
    _titleController.dispose();
    _detailsController.dispose();
    _actionController.dispose();
    _officerController.dispose();
    _officeController.dispose();

    propertyName = "";
    propertyId = "";
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
                    ? CustomListPicker(
                        onCallback: (() {
                          setState(() {
                            propertyClicked = !propertyClicked;
                            _propertyNameController.text = propertyName ?? "";
                          });
                        }),
                        reportDatum: reportDatum,
                        imageBaseUrl: imageBaseUrl,
                      )
                    : Container(),
                SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: _titleController,
                  textfieldTitle: 'Title \*',
                  hintText: 'Enter Title',
                  isFilled: false,
                ),

                EmergencyDateTimeWidget(), //taking date and time using this widget

                EmergencyLocationWidget(), //taking location widget

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
                  textfieldTitle: 'Action Taker',
                  hintText: 'Enter details',
                  isFilled: false,
                  maxLines: 5,
                ),
                CustomUnderlineTextFieldWidget(
                  controller: _officerController,
                  textfieldTitle: 'Officer Name#',
                  hintText: 'Officer Name',
                ),

                CustomUnderlineTextFieldWidget(
                  controller: _officeController,
                  textfieldTitle: 'Office#',
                  hintText: 'Officer Designation',
                ),

                Text(
                  'Towed',
                  style: CustomTheme.textField_Headertext_Style,
                  textScaleFactor: 1.0,
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
                Text(
                  'Upload Record Sample',
                  style: CustomTheme.blueTextStyle(17, FontWeight.w500),
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
                Center(
                  child: Container(
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
                            } else {
                              uploadImage();
                            }
                          })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
