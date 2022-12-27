// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'add_image_cubit.dart';

class AddImageState extends Equatable {
  List<XFile>? imageList;
  List imageName;
  AddImageState({
    required this.imageList,
    required this.imageName,
  });

  factory AddImageState.initial() {
    return AddImageState(imageList: [], imageName: []);
  }
  @override
  List<Object?> get props => [imageList];

  @override
  bool get stringify => true;

  AddImageState copyWith({
    List<XFile>? imageList,
    List? imageName,
  }) {
    return AddImageState(
      imageList: imageList ?? this.imageList,
      imageName: imageName ?? this.imageName,
    );
  }
}
