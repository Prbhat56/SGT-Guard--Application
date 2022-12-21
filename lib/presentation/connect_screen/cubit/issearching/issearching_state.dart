// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'issearching_cubit.dart';

class IssearchingState extends Equatable {
  final bool isSearching;

  IssearchingState({
    required this.isSearching,
  });

  factory IssearchingState.initial() {
    return IssearchingState(isSearching: false);
  }

  @override
  List<Object?> get props => [isSearching];

  IssearchingState copyWith({
    bool? isSearching,
  }) {
    return IssearchingState(
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
