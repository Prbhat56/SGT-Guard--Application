import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'addpeople_state.dart';

class AddpeopleCubit extends Cubit<AddpeopleState> {
  AddpeopleCubit() : super(AddpeopleState.initial());

  void addPeople() {
    emit(state.copyWith(peopleNo: state.peopleNo + 1));
  }
}
