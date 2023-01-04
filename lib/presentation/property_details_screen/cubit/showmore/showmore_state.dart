// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'showmore_cubit.dart';

class ShowmoreState extends Equatable {
  final bool showmore;
  ShowmoreState({
    required this.showmore,
  });

  factory ShowmoreState.initial() {
    return ShowmoreState(showmore: false);
  }
  @override
  List<Object> get props => [showmore];

  ShowmoreState copyWith({
    bool? showmore,
  }) {
    return ShowmoreState(
      showmore: showmore ?? this.showmore,
    );
  }
}
