import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/presentation/work_report_screen/widget/success_popup.dart';
import '../../utils/const.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class GeneralReportScreen extends StatefulWidget {
  const GeneralReportScreen({super.key});

  @override
  State<GeneralReportScreen> createState() => _GeneralReportScreenState();
}

class _GeneralReportScreenState extends State<GeneralReportScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];

  List imageNames = [];
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: primaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            'General Report',
            textScaleFactor: 1.0,
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
          ),
        ),
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
              Text(
                'Title',
                style: TextStyle(
                  fontSize: 17,
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                textScaleFactor: 1.0,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 0, bottom: 0, left: 10),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: seconderyMediumColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: seconderyMediumColor)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: seconderyMediumColor)),
                  filled: true,
                  fillColor: seconderyMediumColor,
                  hintText: 'Something here',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusColor: primaryColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Notes',
                style: TextStyle(
                    fontSize: 17,
                    color: primaryColor,
                    fontWeight: FontWeight.w500),
                textScaleFactor: 1.0,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: seconderyColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryColor)),
                  hintText: 'Something here',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusColor: primaryColor,
                ),
              ),
              const SizedBox(
                height: 30,
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
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        height: 60,
                                        width: 60,
                                        alignment: Alignment.center,
                                        child: Image.file(
                                            File(imageFileList![index].path))),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            width: 190,
                                            child: Text(imageNames[index],
                                                style: TextStyle())),
                                        Row(
                                          children: [
                                            Container(
                                              height: 4,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  color: primaryColor),
                                            ),
                                            SizedBox(width: 5),
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: greenColor,
                                              size: 20,
                                            ),
                                            // Text('100 %',
                                            //     style: TextStyle(fontSize: 12)),
                                            SizedBox(width: 5),
                                          ],
                                        )
                                      ],
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        print('remove');

                                        setState(() {
                                          imageFileList!.removeAt(index);
                                          // imageNames.removeAt(index);
                                        });
                                        print(index);
                                        print(imageFileList);
                                        // imageNames
                                        //     .add(path.dirname(photo.path));
                                      },
                                      child: Container(
                                          height: 15,
                                          width: 15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  color: primaryColor)),
                                          child: Icon(Icons.close, size: 12)),
                                    )
                                  ]),
                            );
                          }),
                    )
                  : Container(),
              Text(
                'Upload Record Sample',
                style: TextStyle(
                    fontSize: 17,
                    color: primaryColor,
                    fontWeight: FontWeight.w500),
                textScaleFactor: 1.0,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Select Media From?',
                                textScaleFactor: 1.0,
                                style: TextStyle(fontSize: 16),
                              ),
                              const Text(
                                'Use camera or select file from device gallery',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 109, 109, 109)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      // Capture a photo
                                      final XFile? photo =
                                          await _picker.pickImage(
                                              source: ImageSource.camera);
                                      if (photo != null) {
                                        imageFileList?.add(photo);

                                        imageNames
                                            .add(path.dirname(photo.path));
                                        setState(() {});
                                      }
                                      print('$imageFileList   $imageNames');
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt,
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          'Camera',
                                          textScaleFactor: 1.0,
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // Pick multiple images
                                      final List<XFile>? images =
                                          await _picker.pickMultiImage();
                                      if (images != null) {
                                        for (var i = 0;
                                            i < images.length;
                                            i++) {
                                          imageFileList?.add(images[i]);
                                        }
                                        imageNames.add(images[0].name);
                                        setState(() {});
                                      }
                                      print('$imageFileList   $imageNames');
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.folder_open_outlined,
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          'Gallery',
                                          textScaleFactor: 1.0,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: Colors.blue,
                  strokeWidth: 2,
                  dashPattern: [10, 3],
                  radius: Radius.circular(10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                        child: Text(
                      'Choose a File',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        )),
        bottomNavigationBar: SizedBox(
          height: 100.h,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Center(
              child: CupertinoButton(
                  disabledColor: seconderyColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                  color: primaryColor,
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 20),
                    textScaleFactor: 1.0,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context, builder: (context) => SuccessPopup());
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return const ReportSuccessScreen(
                    //     isSubmitReportScreen: false,
                    //   );
                    // }));
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
