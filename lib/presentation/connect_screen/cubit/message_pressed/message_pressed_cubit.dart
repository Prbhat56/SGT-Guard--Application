import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'message_pressed_state.dart';

class MessagePressedCubit extends Cubit<MessagePressedState> {
  MessagePressedCubit() : super(MessagePressedState.initial());
  void messagedPressed() {
    emit(state.copyWith(messagelongpressed: !state.messagelongpressed));
  }
}
