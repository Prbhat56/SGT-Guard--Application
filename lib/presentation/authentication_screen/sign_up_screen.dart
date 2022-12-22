import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/presentation/authentication_screen/verification_screen.dart';
import 'package:sgt/utils/const.dart';

import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Welcome\nuser',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50)),
                            child: imageFileList!.isEmpty
                                ? Icon(
                                    Icons.camera_alt_outlined,
                                    color: white,
                                    size: 70,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      File(imageFileList![0].path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Positioned(
                            top: 70,
                            left: 60,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
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
                                                color: Color.fromARGB(
                                                    255, 109, 109, 109),
                                              ),
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
                                                    final XFile? photo =
                                                        await _picker.pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                    imageFileList!.clear();
                                                    imageFileList!.add(photo!);
                                                    setState(() {});
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: grey,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                    // Pick an image
                                                    final XFile? image =
                                                        await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                    );
                                                    imageFileList!.clear();
                                                    imageFileList!.add(image!);
                                                    setState(() {});
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 5,
                                                              blurRadius: 7,
                                                              offset: const Offset(
                                                                  0,
                                                                  3), // changes position of shadow
                                                            ),
                                                          ],
                                                        ),
                                                        child: const Icon(
                                                          Icons.photo_outlined,
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
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Sign up to join',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Jenny Doe', focusColor: primaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Email',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'johndoe@mail.com', focusColor: primaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Phone',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: '(808)628 8343', focusColor: primaryColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(hintText: '****'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Re-Enter Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(hintText: '****'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: greenColor,
                      ),
                      const Center(
                        child: Text(
                          "I agree to the",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "Terms of Service",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CupertinoButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 120.w, vertical: 15),
                      color: seconderyColor,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const VerificationScreen();
                        }));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignInScreen();
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: const [
                          Center(
                            child: Text(
                              "Have an account?",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Sign In",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        )),
      ),
    );
  }
}
