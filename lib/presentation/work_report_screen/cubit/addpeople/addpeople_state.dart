// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'addpeople_cubit.dart';

class AddpeopleState extends Equatable {
  final int peopleNo;

  AddpeopleState({required this.peopleNo});

  factory AddpeopleState.initial() {
    return AddpeopleState(peopleNo: 1);
  }

  @override
  List<Object?> get props => [peopleNo];

  AddpeopleState copyWith({
    int? peopleNo,
  }) {
    return AddpeopleState(
      peopleNo: peopleNo ?? this.peopleNo,
    );
  }

  @override
  bool get stringify => true;
}
