// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'is_valid_password_cubit.dart';

class IsValidPasswordState extends Equatable {
  final bool ispasswordvalid;
  IsValidPasswordState({
    required this.ispasswordvalid,
  });

  factory IsValidPasswordState.initial() {
    return IsValidPasswordState(ispasswordvalid: true);
  }
  @override
  List<Object> get props => [ispasswordvalid];

  IsValidPasswordState copyWith({
    bool? ispasswordvalid,
  }) {
    return IsValidPasswordState(
      ispasswordvalid: ispasswordvalid ?? this.ispasswordvalid,
    );
  }

  @override
  bool get stringify => true;
}
