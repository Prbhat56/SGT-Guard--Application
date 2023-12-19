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
import 'package:sgt/presentation/work_report_screen/model/checkPoint_model.dart';
import 'package:sgt/service/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/const.dart';
import '../property_details_screen/widgets/show_property_images_widget.dart';
import '../widgets/dotted_choose_file_widget.dart';
import 'package:path/path.dart' as path;
import 'widget/check_point_sccess.dart';
import 'widget/tasks_list_widget.dart';
import 'package:http/http.dart' as http;

class CheckpointReportScreen extends StatefulWidget {
  String? checkPointqrData;
  CheckpointReportScreen({super.key, this.checkPointqrData});

  @override
  State<CheckpointReportScreen> createState() => _CheckpointReportScreenState();
}

class _CheckpointReportScreenState extends State<CheckpointReportScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List imageNames = [];

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

  Future<CheckPointDetailsModal> getCheckpointsTaskList(checkpoint_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> myHeader = <String, String>{
      "Authorization": "Bearer ${prefs.getString('token')}",
    };
    Map<String, dynamic> myJsonBody = {'checkpoint_id': checkpoint_id.toString()};
    String apiUrl = baseUrl + apiRoutes['checkpointTaskList']!;
    final response =
        await http.post(Uri.parse(apiUrl), headers: myHeader, body: myJsonBody);
    print(response.body.toString());
    var data = jsonDecode(response.body.toString());
    print(data);
    if (response.statusCode == 201) {
      final CheckPointDetailsModal responseModel =
          checkPointDetailsModalFromJson(response.body);
      return responseModel;
    } else {
      return CheckPointDetailsModal(
        status: response.statusCode,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("widget.checkPointqrData =====> ${widget.checkPointqrData}");
    String? jsonString = widget.checkPointqrData;
    Map<String, dynamic> jsonData = jsonDecode(jsonString!);
    int checkpointId = jsonData['checkpoint_details']['checkpoint_id'];
    print('CheckPoint ID: $checkpointId');
    var cubit = context.watch<ReportTypeCubit>().state;
    print(cubit.isparkingReport);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: CustomAppBarWidget(
          appbarTitle: 'Building Hallway 1',
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
                            child: PropertyImagesWidget(
                              avatars: [],
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
                              //showing list of tasks
                              TasksListWidget(
                                checkPointTask:snapshot.data!.data!.checkPointTask
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
                              screenNavigator(
                                  context, CheckPointCompleteSuccess());
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
