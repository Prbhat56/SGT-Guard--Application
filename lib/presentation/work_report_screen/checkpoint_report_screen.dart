import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/helper/navigator_function.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/widgets/custom_bottom_model_sheet.dart';
import 'package:sgt/presentation/widgets/custom_button_widget.dart';
import 'package:sgt/presentation/widgets/custom_textfield_widget.dart';
import 'package:sgt/presentation/widgets/media_uploading_widget.dart';
import 'package:sgt/presentation/work_report_screen/cubit/report_type/report_type_cubit.dart';
import 'package:sgt/presentation/work_report_screen/widget/check_point_success.dart';
import 'package:sgt/presentation/work_report_screen/widget/property_image_preview_widget.dart';
import 'package:sgt/presentation/work_report_screen/widget/report_submit_success.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../widgets/dotted_choose_file_widget.dart';
import 'package:path/path.dart' as path;
import 'model/checkPoint_model.dart';
import 'widget/tasks_list_widget.dart';
import 'package:http/http.dart' as http;

class CheckpointReportScreen extends StatefulWidget {
  String? checkPointqrData;
  String? propId;
  String? shiftId;
  CheckpointReportScreen(
      {super.key, this.checkPointqrData, this.propId, this.shiftId});

  static _CheckpointReportScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CheckpointReportScreenState>();

  @override
  State<CheckpointReportScreen> createState() => _CheckpointReportScreenState();
}

class _CheckpointReportScreenState extends State<CheckpointReportScreen> {
  List<CheckPointTask> checkpointTask = [];
  TextEditingController additionalCommentsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List imageNames = [];
  // List<int> checkpointIds = [];

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

  Future<void> uploadImage(checkpointId,checkpointTask) async {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(child: CircularProgressIndicator());
        }));
    // List<int> ids = checkpointTask.map<int>((json) => json['id']).toList();
    // var checkpointsIds = ids.toString();
    print("%^%^%^% ====> ${checkpointTask.toString().replaceAll("(", "").replaceAll(")","")}");
    List<String> checkpointsIds = [];
    String ids = '';
    checkpointsIds.add(checkpointTask.toString().replaceAll("(", "").replaceAll(")",""));
    ids = checkpointsIds.join(',');
    String apiUrl = baseUrl + apiRoutes['checkpointTaskUpdate']!;
    print("apiUrl ==================> ${apiUrl.toString()}");
    var request = new http.MultipartRequest('POST', Uri.parse(apiUrl));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.fields['remarks'] = additionalCommentsController.text.toString();
    request.fields['task_id'] = ids.toString();
    request.fields['shift_id'] = widget.shiftId.toString();

    request.fields['checkpoint_id'] = checkpointId.toString();
    if (imageFileList!.length > 0) {
      for (var i = 0; i < imageFileList!.length; i++) {
        var stream = new http.ByteStream(imageFileList![i].openRead());
        stream.cast();

        var length = await imageFileList![i].length();

        request.files.add(http.MultipartFile('media_files[]', stream, length,
            filename: imageFileList![i].path.split("/").last));
      }
    }
    // final CheckPointDetailsModal responseModal = checkPointDetailsModalFromJson();
    // print("request fields ===============> ${request.fields}");
    // print("request files ===============> ${request.files}");
    var response = await request.send();
    // print("response.stream =========> ${response.stream.bytesToString()}");
    // print("response ===========> ${response.statusCode}");
    //final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      // print('=============================================> Request Submitted');
      // setState(() {
      screenNavigator(
      context, CheckPointCompleteSuccess());
      // });
      // screenNavigator(context, ReportSubmitSuccess());
    } else {
      setState(() {
        Navigator.of(context).pop();
      });
      print('Failed');
    }
  }

  Future<CheckPointDetailsModal> getCheckpointsTaskList(checkpoint_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? shift_id = prefs.getString('shiftId');
    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    Map<String, dynamic> myJsonBody = {
      'checkpoint_id': checkpoint_id.toString(),
      'shift_id': shift_id.toString(),
      'property_id': widget.propId
    };
    print("===========??????????? ${myJsonBody}");
    String apiUrl = baseUrl + apiRoutes['checkpointTaskList']!;
    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
    print(response.body.toString());
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 201) {
      final CheckPointDetailsModal responseModel =
          checkPointDetailsModalFromJson(response.body);
      checkpointTask = responseModel.data!.checkPointTask!;
      // checkpointIds = checkpointTask.map((e) => e.id);
      print("ffffffffffff =========>  ${checkpointTask.map((e) => e.id)}");
      // var checkpointsIds = ids.toString();
      // print("%^%^%^% ====> ${checkpointsIds}");
      return responseModel;
    } else {
      return CheckPointDetailsModal(
        status: response.statusCode,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    additionalCommentsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("widget.checkPointqrData =====> ${widget.checkPointqrData}");
    String? jsonString = widget.checkPointqrData;
    Map<String, dynamic> jsonData = jsonDecode(jsonString!);
    int checkpointId = jsonData['checkpoint_details']['checkpoint_id'];
    String checkPointName = jsonData['checkpoint_details']['checkpoint_name'];
    print('CheckPoint ID: $checkpointId');
    var cubit = context.watch<ReportTypeCubit>().state;
    print(cubit.isparkingReport);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          appbarTitle: checkPointName,
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
            child: FutureBuilder(
                future: getCheckpointsTaskList(checkpointId),
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
                              avatars: snapshot
                                  .data!.data!.property!.propertyAvatars,
                              propertyImageBaseUrl:
                                  snapshot.data!.propertyImageBaseUrl,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tasks',
                                style: TextStyle(
                                    fontSize: 17, color: primaryColor),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              checkpointTask.length != 0
                                  ? Container(
                                      child: TasksListWidget(
                                          checkPointTask: checkpointTask),
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
                              CustomTextField(
                                controller: additionalCommentsController,
                                textfieldTitle: '',
                                hintText: 'Something here',
                                isFilled: false,
                                maxLines: 5,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              imageFileList!.isNotEmpty
                                  ? Text(
                                      'Media',
                                      style: TextStyle(
                                          fontSize: 17, color: primaryColor),
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
                                                imageFileList: imageFileList!,
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
                                  title: 'Choose a file',
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
                            buttonTitle: 'Send',
                            onBtnPress: () {
                              uploadImage(checkpointId,checkpointTask.map((e) => e.id));
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
