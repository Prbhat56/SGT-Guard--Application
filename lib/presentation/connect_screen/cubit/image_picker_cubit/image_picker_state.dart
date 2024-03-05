part of 'image_picker_cubit.dart';

class ImagePickerState {
  final List<File> pickedImages;
  final bool isUploading;

  ImagePickerState({this.pickedImages = const [], this.isUploading = false});

  ImagePickerState copyWith({List<File>? pickedImages, bool? isUploading}) {
    return ImagePickerState(
        pickedImages: pickedImages ?? this.pickedImages,
        isUploading: isUploading ?? this.isUploading);
  }
}
