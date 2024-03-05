part of 'isMediaSelected_cubit.dart';

class IsMediaSelectedState extends Equatable {
  final bool isMedia;

  IsMediaSelectedState({required this.isMedia});

  factory IsMediaSelectedState.initial() {
    return IsMediaSelectedState(isMedia: true);
  }

  @override
  List<Object?> get props => [isMedia];

  IsMediaSelectedState copyWith({
    bool? isMedias,
  }) {
    return IsMediaSelectedState(
      isMedia: isMedias ?? this.isMedia,
    );
  }
}
