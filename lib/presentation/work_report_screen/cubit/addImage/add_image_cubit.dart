import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
part 'add_image_state.dart';

class AddImageCubit extends Cubit<AddImageState> {
  AddImageCubit() : super(AddImageState.initial());

  void addImagetoList(index) {
    var list = state.imageList;
    list!.add(index);
    emit(state.copyWith(imageList: list));
  }

  void removeImagefromList(index) {
    var removedlist = state.imageList;
    removedlist!.remove(index);
    emit(state.copyWith(imageList: removedlist));
  }
}
