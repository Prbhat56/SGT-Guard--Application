import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/presentation/widgets/custom_appbar_widget.dart';
import 'package:sgt/presentation/work_report_screen/cubit/addImage/add_image_cubit.dart';
import 'package:sgt/theme/custom_theme.dart';
import '../../../utils/const.dart';
import '../../widgets/custom_bottom_model_sheet.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_textfield_widget.dart';
import '../../widgets/custom_underline_textfield_widget.dart';
import '../../widgets/dotted_choose_file_widget.dart';
import '../../widgets/media_uploading_widget.dart';
import '../cubit/addpeople/addpeople_cubit.dart';
import '../cubit/addwitness/addwitness_cubit.dart';
import '../widget/drop_down_widget.dart';
import 'widget/add_people_widget.dart';
import 'widget/emergency_date_time_widget.dart';
import 'widget/emergency_location_widget.dart';

class EmergencyReportScreen extends StatefulWidget {
  const EmergencyReportScreen({super.key});

  @override
  State<EmergencyReportScreen> createState() => _EmergencyReportScreenState();
}

class _EmergencyReportScreenState extends State<EmergencyReportScreen> {
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
                  height: 25,
                ),
                CustomTextField(
                  textfieldTitle: 'Property Name',
                  hintText: 'Empire Polo Fields',
                  isFilled: true,
                ),

                CustomTextField(
                  textfieldTitle: 'Title',
                  hintText: 'Something here',
                  isFilled: false,
                ),

                Text('Emergency Date & Time',
                    style: CustomTheme.blueTextStyle(17, FontWeight.w500)),
                const SizedBox(
                  height: 10,
                ),
                EmergencyDateTimeWidget(), //taking date and time using this widget

                EmergencyLocationWidget(), //taking location widget

                CustomTextField(
                  textfieldTitle: 'Emergency Details',
                  hintText: 'Something here',
                  isFilled: false,
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                AddPeopleWidget(
                  title: 'People Involved',
                  number: context.watch<AddpeopleCubit>().state.peopleNo,
                  ontap: () {
                    context.read<AddpeopleCubit>().addPeople();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                AddPeopleWidget(
                  title: 'Witnesss',
                  number: context.watch<AddwitnessCubit>().state.witness,
                  ontap: () {
                    context.read<AddwitnessCubit>().addwitness();
                  },
                ),

                CustomTextField(
                  textfieldTitle: 'Action Taker',
                  hintText: 'Something here',
                  isFilled: false,
                  maxLines: 5,
                ),

                CustomUnderlineTextFieldWidget(
                  textfieldTitle: 'Police Report#',
                  hintText: 'Something here',
                ),

                CustomUnderlineTextFieldWidget(
                  textfieldTitle: 'Officer Name#',
                  hintText: 'Something here',
                ),

                CustomUnderlineTextFieldWidget(
                  textfieldTitle: 'Officer#',
                  hintText: 'Something here',
                ),

                DropDownWidget(), //towed dropdown widget

                imageFileList!.isNotEmpty
                    ? Text(
                        'Media',
                        style: CustomTheme.blueTextStyle(17, FontWeight.w400),
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
                const SizedBox(
                  height: 18,
                ),
                Text(
                  'Upload Record Sample',
                  style: CustomTheme.blueTextStyle(17, FontWeight.w500),
                  textScaleFactor: 1.0,
                ),
                const SizedBox(
                  height: 18,
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
                          buttonTitle: 'Send', onBtnPress: () {})),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
