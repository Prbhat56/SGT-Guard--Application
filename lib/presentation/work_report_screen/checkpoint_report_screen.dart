import 'dart:convert';
import 'dart:math';

import 'package:carp_background_location/carp_background_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/authentication_screen/sign_in_screen.dart';
import 'package:sgt/presentation/check_point_screen/check_point_screen.dart';
import 'package:sgt/presentation/qr_screen/checkpoints_in_scanning_screen.dart';
import 'package:sgt/presentation/qr_screen/model/checkpoint_qr_details_model.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_bottom_model_sheet.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_textfield_widget.dart';
import 'package:sgt/presentation/widgets/media_uploading_widget.dart';
import 'package:sgt/presentation/work_report_screen/cubit/report_type/report_type_cubit.dart';
import 'package:sgt/presentation/work_report_screen/widget/check_point_success.dart';
import 'package:sgt/presentation/work_report_screen/widget/property_image_preview_widget.dart';
import 'package:sgt/service/api_call_service.dart';
import 'package:sgt/service/common_service.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:sgt/theme/colors.dart';
import 'package:sgt/theme/custom_theme.dart';
import 'package:sgt/theme/font_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../widgets/dotted_choose_file_widget.dart';
import 'package:path/path.dart' as path;
import 'model/checkPoint_model.dart';
import 'widget/tasks_list_widget.dart';
import 'package:http/http.dart' as http;

class CheckpointReportScreen extends StatefulWidget {
  String? checkPointName;
  String? propId;
  String? shiftId;
  String? checkPointId;
  String? checkpointHistoryId;
  int? checkpointListIndex;

  CheckpointReportScreen({
    super.key,
    this.checkPointName,
    this.propId,
    this.shiftId,
    this.checkPointId,
    this.checkpointHistoryId,
    this.checkpointListIndex,
  });

  static _CheckpointReportScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CheckpointReportScreenState>();

  @override
  State<CheckpointReportScreen> createState() => _CheckpointReportScreenState();
}

var checkpointDetailsDataFetched;
String? propertyImageBaseUrlData;
Property? property = Property();

class _CheckpointReportScreenState extends State<CheckpointReportScreen> {
  bool? checkIdList;
  String? latestCheckpointId;

  List<CheckPointTask> checkpointTask = [];
  // CheckPointData? checkpointData;
  TextEditingController additionalCommentsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List imageNames = [];
  // List<int> checkpointIds = [];

//pick image from gallery

  @override
  void initState() {
    getCheckpointsTaskList(widget.checkPointId);
    // checkpointDetailsDataFetched = getCheckpointsTaskList(widget.checkPointId);
    super.initState();
  }

  void sendCurrentCheckPointStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? latitude = prefs.getString('latitude');
    String? longitude = prefs.getString('propertyId');
    String? latestCheckpointId = prefs.getString('Cp');
    String? routeId = prefs.getString('routeId');
    String? shift_id = prefs.getString('shiftId');
    String? property_id = prefs.getString('propertyId');
    await FirebaseHelper.createGuardLocation(
        latitude.toString(),
        longitude.toString(),
        shift_id.toString(),
        latestCheckpointId.toString(),
        routeId.toString(),
        property_id.toString());
    screenReplaceNavigator(context, CheckPointCompleteSuccess());
  }

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

  Future<void> uploadImage(checkpointId, checkpointTask) async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: CircularProgressIndicator());
        }));
    // print("%^%^%^% ====> ${checkpointTask.toString().replaceAll("(", "").replaceAll(")", "")}");
    List<String> checkpointsIds = [];
    String ids = '';
    checkpointsIds
        .add(checkpointTask.toString().replaceAll("(", "").replaceAll(")", ""));
    ids = checkpointsIds.join(',');
    String apiUrl = baseUrl + apiRoutes['checkpointTaskUpdate']!;
    // print("apiUrl ==================> ${apiUrl.toString()}");
    // print(
    // "--------------------------------${additionalCommentsController.text.toString()}");
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.fields['remarks'] = additionalCommentsController.text.toString();
    request.fields['task_id'] = ids.toString();
    request.fields['checkpoint_history_id'] =
        widget.checkpointHistoryId.toString();
    request.fields['shift_id'] = widget.shiftId.toString();
    request.fields['checkpoint_id'] = checkpointId.toString();
    if (imageFileList!.length > 0) {
      for (var i = 0; i < imageFileList!.length; i++) {
        var stream = new http.ByteStream(imageFileList![i].openRead());
        stream.cast();
        var length = await imageFileList![i].length();
        request.files.add(http.MultipartFile('media_files[]', stream, length,
            // filename: imageFileList![i].path.split("/").last
            filename: imageFileList![i].path.split("/").last
            ));
      }
    }
    print("==================================== ${request.files.map((e) => e.filename)}");
    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((value) {    // to print response
          debugPrint(value);
       });
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print('=============================================> Request Submitted');
      // setState(() {
      sendCurrentCheckPointStatus();
      // });
      // screenNavigator(context, ReportSubmitSuccess());
    } else {
      setState(() {
        Navigator.of(context).pop();
      });
      print('falied');
    }
  }

  Future getCheckpointsTaskList(checkpoint_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? shift_id = prefs.getString('shiftId');
    prefs.setString('Cp', checkpoint_id.toString());
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    Map<String, dynamic> myJsonBody = {
      'checkpoint_id': checkpoint_id.toString(),
      'shift_id': shift_id.toString(),
      'property_id': widget.propId,
      'checkpoint_history_id': widget.checkpointHistoryId,
    };
    String apiUrl = baseUrl + apiRoutes['checkpointTaskList']!;
    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
    // var data = jsonDecode(response.body.toString());
    // print("data-------> ${data}");
    if (response.statusCode == 201) {
      final CheckPointDetailsModal responseModel =
          checkPointDetailsModalFromJson(response.body);
      checkpointTask = responseModel.data!.checkPointTask ?? [];
      propertyImageBaseUrlData = responseModel.propertyImageBaseUrl ?? '';
      property = responseModel.data!.property ?? Property();
      // checkpointData = responseModel.data!;
      return responseModel;
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
        return CheckPointDetailsModal(
        status: response.statusCode,
      );
      }
      
    }
  }

  @override
  void dispose() {
    super.dispose();
    additionalCommentsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<ReportTypeCubit>().state;
    print(cubit.isparkingReport);
    return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: Scaffold(
              appBar: CustomAppBarWidget(
                appbarTitle:
                    "CP-${widget.checkpointListIndex! + 1} ${'' + widget.checkPointName.toString()}",
              ),
              backgroundColor: white,
              body: SingleChildScrollView(
                  child: FutureBuilder(
                      future: getCheckpointsTaskList(widget.checkPointId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  child: CircularProgressIndicator()));
                        } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: PropertyImagesPreviewWidget(
                                  avatars: property!.propertyAvatars,
                                  propertyImageBaseUrl:
                                      propertyImageBaseUrlData,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'tasks'.tr,
                                    style: TextStyle(
                                        fontSize: 17, color: primaryColor),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  checkpointTask.length != 0
                                      ? Container(
                                          child: TasksListWidget(
                                            checkPointTask: checkpointTask,
                                            // checkPointIdList:(checkPointStatus) {
                                            //   checkIdList = checkPointStatus;
                                            // },
                                          ),
                                        )
                                      : Container(
                                          child: Text(
                                            'No Tasks Assigned',
                                            style: TextStyle(
                                                fontSize: 10, color: black),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Additional comments',
                                        style: TextStyle(
                                            fontSize: 17, color: primaryColor),
                                      ),
                                      Text(
                                        '(Optional)',
                                        style: TextStyle(
                                            fontSize: 10, color: primaryColor),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '',
                                          style: CustomTheme
                                              .textField_Headertext_Style,
                                          textScaleFactor: 1.0,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          // initialValue: snapshot
                                          //     .data!.data!.taskRemarks
                                          //     .toString(),
                                          controller:
                                              additionalCommentsController,
                                          maxLines: 5,
                                          decoration:
                                              CustomTheme.textfieldDecoration(
                                                  'Something here',
                                                  false,
                                                  false),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // CustomTextField(
                                  //   controller: additionalCommentsController,
                                  //   textfieldTitle: '',
                                  //   hintText: 'Something here',
                                  //   isFilled: false,
                                  //   maxLines: 5,
                                  // ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  imageFileList!.isNotEmpty
                                      ? Text(
                                          'Media',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: primaryColor),
                                        )
                                      : Container(),
                                  imageFileList!.isNotEmpty
                                      ? SizedBox(
                                          height: 110 *
                                              imageFileList!.length.toDouble(),
                                          child: ListView.builder(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: imageFileList!.length,
                                              itemBuilder: (context, index) {
                                                return MediaUploadingWidget(
                                                    imageFileList:
                                                        imageFileList!,
                                                    imageNames: imageNames,
                                                    clickClose: () {
                                                      setState(() {
                                                        imageFileList!
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    index: index);
                                              }),
                                        )
                                      : Container(),
                                  Text(
                                    'Add Media',
                                    style: TextStyle(
                                        fontSize: 17, color: primaryColor),
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
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
                                      title: 'choose_file_text'.tr,
                                      height: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                            CustomButtonWidget(
                                buttonTitle: 'send'.tr,
                                onBtnPress: () {
                                  uploadImage(widget.checkPointId,
                                      checkpointTask.map((e) => e.id));
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                        }
                      })),
            ),
          );
  }
}
