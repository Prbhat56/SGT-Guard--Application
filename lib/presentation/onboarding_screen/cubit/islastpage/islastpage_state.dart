// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'islastpage_cubit.dart';

class IslastpageState extends Equatable {
  final bool isLastpage;

  IslastpageState({required this.isLastpage});

  factory IslastpageState.initial() {
    return IslastpageState(isLastpage: false);
  }
  @override
  List<Object?> get props => [];

  IslastpageState copyWith({
    bool? isLastpage,
  }) {
    return IslastpageState(
      isLastpage: isLastpage ?? this.isLastpage,
    );
  }
}
