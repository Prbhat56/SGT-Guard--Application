import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/const.dart';
import 'report_success_screen.dart';

class ParkingReportScreen extends StatefulWidget {
  const ParkingReportScreen({super.key});

  @override
  State<ParkingReportScreen> createState() => _ParkingReportScreenState();
}

class _ParkingReportScreenState extends State<ParkingReportScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];
  List imageNames = [];
  var value;
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Parking Report',
            style: TextStyle(color: black),
            textScaleFactor: 1.0,
          ),
          elevation: 0,
          backgroundColor: white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Vechicle Type',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.grey)),
                    textScaleFactor: 1.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Something here',
                        hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: Colors.grey),
                        ),
                        focusColor: primaryColor),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Model',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.grey)),
                    textScaleFactor: 1.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Something here',
                        hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: Colors.grey),
                        ),
                        focusColor: primaryColor),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Color',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.grey)),
                    textScaleFactor: 1.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Something here',
                        hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: Colors.grey),
                        ),
                        focusColor: primaryColor),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'License Number',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.grey)),
                    textScaleFactor: 1.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Something here',
                        hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: Colors.grey),
                        ),
                        focusColor: primaryColor),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Title',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.grey)),
                    textScaleFactor: 1.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Something here',
                        hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: Colors.grey),
                        ),
                        focusColor: primaryColor),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: [
                          'Andhra Pradesh',
                          'Arunachal Pradesh',
                          'Assam',
                          'Bihar'
                        ].map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Row(
                              children: <Widget>[
                                Text(val),
                              ],
                            ),
                          );
                        }).toList(),
                        hint: Text(
                          'Select State',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        onChanged: (v) {
                          setState(() {
                            value = v;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Towed',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.grey)),
                    textScaleFactor: 1.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: ['Yes', 'No'].map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        hint: Text(
                          'Select Yes or No',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        onChanged: (v) {},
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    'Notes',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.grey)),
                    textScaleFactor: 1.0,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    maxLines: 8,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: 'Something here',
                      hintStyle: GoogleFonts.montserrat(
                        textStyle: const TextStyle(color: Colors.grey),
                      ),
                      focusColor: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Upload Record Sample',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(fontSize: 17.sp, color: Colors.grey)),
                    textScaleFactor: 1.0,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
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
                                            child: Image.file(File(
                                                imageFileList![index].path))),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                Text('100 %',
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                SizedBox(width: 5),
                                                InkWell(
                                                  onTap: () {
                                                    print('remove');

                                                    setState(() {
                                                      imageFileList!
                                                          .removeAt(index);
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
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          border: Border.all(
                                                              color:
                                                                  primaryColor)),
                                                      child: Icon(Icons.close,
                                                          size: 12)),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ]),
                                );
                              }),
                        )
                      : Container(),
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
                                        color:
                                            Color.fromARGB(255, 109, 109, 109)),
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
                                            imageFileList?.addAll(images);
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
                      color: Colors.grey,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Center(
                            child: Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 50,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            const Divider(
              color: Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: Center(
                child: CupertinoButton(
                    disabledColor: seconderyColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 150, vertical: 15),
                    color: primaryColor,
                    child: const Text(
                      'Done',
                      style: TextStyle(fontSize: 20),
                      textScaleFactor: 1.0,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ReportSuccessScreen(
                          isSubmitReportScreen: false,
                        );
                      }));
                    }),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
