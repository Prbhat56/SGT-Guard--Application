import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sgt/presentation/authentication_screen/firebase_auth.dart';
import 'package:sgt/presentation/connect_screen/model/chat_users_model.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickGalleryImagesAndUpload(
      BuildContext context, ChatUsers user) async {
    final List<XFile>? pickedImages =
        await _picker.pickMultiImage(imageQuality: 80);
    if (pickedImages != null) {
      showDialog(
          context: context,
          builder: ((context) {
            return Center(child: CircularProgressIndicator());
          }));
      emit(ImagePickerState(
          pickedImages: pickedImages.map((e) => File(e.path)).toList(),
          isUploading: true));
      await uploadGalleryImages(user);
      emit(state.copyWith(isUploading: false));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      EasyLoading.showError('Something went wrong');
    }
  }

  Future<void> uploadGalleryImages(ChatUsers user) async {
    // Here you can upload the picked images to a server or a storage provider
    for (final imageFile in state.pickedImages) {
      await Future.delayed(Duration(seconds: 1));
      FirebaseHelper.sendChatImage(user, File(imageFile.path)).then((value) {
        FirebaseHelper.updateRecentMessageTime(user);
      });
      print('Uploading...${imageFile.path}');
    }
    // After uploading, clear the picked images
    emit(ImagePickerState());
  }

////********** Camera */
  Future<void> pickCameraImagesAndUpload(
      BuildContext context, ChatUsers user) async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedImage != null) {
      showDialog(
          context: context,
          builder: ((context) {
            return Center(child: CircularProgressIndicator());
          }));
      emit(ImagePickerState(
          pickedImages: [File(pickedImage.path)], isUploading: true));
      await uploadCameraImages(user);
      emit(state.copyWith(isUploading: false));
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      EasyLoading.showError('Something went wrong');
    }
  }

  Future<void> uploadCameraImages(ChatUsers user) async {
    final imageFile = state.pickedImages.first;
    await Future.delayed(Duration(seconds: 1));
    FirebaseHelper.sendChatImage(user, File(imageFile.path)).then((value) {
      FirebaseHelper.updateRecentMessageTime(user);
    });
    print('Uploading...${imageFile.path}');

    // After uploading, clear the picked images
    emit(ImagePickerState());
  }
}
