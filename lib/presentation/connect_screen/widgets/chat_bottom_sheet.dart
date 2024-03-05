// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sgt/presentation/connect_screen/cubit/image_picker_cubit/image_picker_cubit.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';
import 'package:sgt/utils/const.dart';

class ChatBottomSheetContent extends StatefulWidget {
  const ChatBottomSheetContent({super.key, required this.user});
  final ChatUsers user;

  @override
  State<ChatBottomSheetContent> createState() => _ChatBottomSheetContentState();
}

class _ChatBottomSheetContentState extends State<ChatBottomSheetContent> {
  // final VoidCallback cameraClick;
  @override
  Widget build(BuildContext context) {
    final imagePickerCubit = BlocProvider.of<ImagePickerCubit>(context);
    return BlocBuilder<ImagePickerCubit, ImagePickerState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
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
                    fontSize: 12, color: Color.fromARGB(255, 109, 109, 109)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      imagePickerCubit.pickCameraImagesAndUpload(
                          context, widget.user);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: grey,
                            borderRadius: BorderRadius.circular(10),
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
                    onTap: () {
                      imagePickerCubit.pickGalleryImagesAndUpload(
                          context, widget.user);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
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
      },
    );
  }
}
