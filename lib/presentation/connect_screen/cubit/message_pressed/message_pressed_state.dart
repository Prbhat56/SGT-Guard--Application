// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'message_pressed_cubit.dart';

class MessagePressedState extends Equatable {
  final bool messagelongpressed;

  MessagePressedState({required this.messagelongpressed});

  factory MessagePressedState.initial() {
    return MessagePressedState(messagelongpressed: false);
  }

  @override
  List<Object> get props => [messagelongpressed];

  MessagePressedState copyWith({
    bool? messagelongpressed,
  }) {
    return MessagePressedState(
      messagelongpressed: messagelongpressed ?? this.messagelongpressed,
    );
  }

  @override
  bool get stringify => true;
}
