// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final int selectedIndex;

  NavigationState({required this.selectedIndex});

  factory NavigationState.initial() {
    return NavigationState(selectedIndex: 0);
  }

  @override
  List<Object?> get props => [selectedIndex];



  @override
  bool get stringify => true;

  NavigationState copyWith({
    int? selectedIndex,
  }) {
    return NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
